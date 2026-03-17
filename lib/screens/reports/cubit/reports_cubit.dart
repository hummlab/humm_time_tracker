import 'package:flutter/services.dart' show Clipboard, ClipboardData, rootBundle;
import 'package:flutter/material.dart' show DateTimeRange;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/reports/cubit/reports_state.dart';
import 'package:time_tracker/utils/csv_download_helper.dart' as csv_download;
import 'package:time_tracker/widgets/app_toast.dart';

class ReportsCubit extends BaseCubit<ReportsState> {
  ReportsCubit(this._workspaceRepository, this._authDataProvider) : super(ReportsState.initial()) {
    _workspaceRepository.addListener(_syncFromSources);
    _authDataProvider.addListener(_syncFromSources);
    _syncFromSources();
  }

  final WorkspaceRepository _workspaceRepository;
  final AuthDataProvider _authDataProvider;
  bool _didInitializeMemberFilter = false;

  void _syncFromSources() {
    final isAdmin = _authDataProvider.isAdmin;
    final isManager = _authDataProvider.isManager;
    final hasManagerAccess = _authDataProvider.hasManagerAccess;
    final currentUserId = _authDataProvider.currentUserId;
    final currentMember = _workspaceRepository.getCurrentUserTeamMember(currentUserId);

    var selectedMemberIds = state.selectedMemberIds;
    if (!_didInitializeMemberFilter && !isAdmin && !isManager) {
      if (currentMember != null) {
        selectedMemberIds = [currentMember.id];
        _didInitializeMemberFilter = true;
      }
    }

    if (!isAdmin && !isManager && currentMember != null) {
      selectedMemberIds = [currentMember.id];
    }

    final filteredProjects = _workspaceRepository.getProjectsForUser(
      hasManagerAccess: hasManagerAccess,
      teamMemberId: currentMember?.id,
    );
    final filteredClients = _workspaceRepository.getClientsForUser(
      hasManagerAccess: hasManagerAccess,
      teamMemberId: currentMember?.id,
    );
    final filteredMembers = _workspaceRepository.getTeamMembersForUser(
      isAdmin: isAdmin,
      isManager: isManager,
      teamMemberId: currentMember?.id,
      currentUserId: currentUserId,
    );

    final canChangeMembers = isAdmin || isManager;

    var entries =
        _workspaceRepository.timeEntries.where((entry) {
          return entry.date.isAfter(state.selectedRange.start.subtract(const Duration(days: 1))) &&
              entry.date.isBefore(state.selectedRange.end.add(const Duration(days: 1)));
        }).toList();

    final visibleUserIds = _workspaceRepository.getVisibleUserIds(
      isAdmin: isAdmin,
      isManager: isManager,
      teamMemberId: currentMember?.id,
      currentUserId: currentUserId,
    );

    if (!isAdmin) {
      entries = entries.where((e) => visibleUserIds.contains(e.createdByUserId)).toList();
    }

    if (selectedMemberIds.isNotEmpty) {
      final selectedFirebaseUids =
          _workspaceRepository.teamMembers
              .where((m) => selectedMemberIds.contains(m.id))
              .map((m) => m.firebaseUid)
              .whereType<String>()
              .toSet();

      entries = entries.where((e) => selectedFirebaseUids.contains(e.createdByUserId)).toList();
    }

    if (state.selectedProjectIds.isNotEmpty) {
      entries = entries.where((e) => e.projectId != null && state.selectedProjectIds.contains(e.projectId)).toList();
    }

    if (state.selectedClientIds.isNotEmpty) {
      final projectsForClients =
          _workspaceRepository.projects
              .where((p) => p.clientId != null && state.selectedClientIds.contains(p.clientId))
              .map((p) => p.id)
              .toSet();

      entries = entries.where((e) => e.projectId != null && projectsForClients.contains(e.projectId)).toList();
    }

    if (state.selectedTagIds.isNotEmpty) {
      entries = entries.where((e) => e.tagIds.any((tagId) => state.selectedTagIds.contains(tagId))).toList();
    }

    entries.sort((a, b) {
      int result;
      switch (state.sortBy) {
        case SortBy.date:
          result = a.date.compareTo(b.date);
          break;
        case SortBy.duration:
          result = a.durationMinutes.compareTo(b.durationMinutes);
          break;
        case SortBy.project:
          result = (a.projectId ?? '').compareTo(b.projectId ?? '');
          break;
      }
      return state.sortDescending ? -result : result;
    });

    final minutesByProject = <String, int>{};
    for (final entry in entries) {
      final projectId = entry.projectId ?? 'unassigned';
      minutesByProject[projectId] = (minutesByProject[projectId] ?? 0) + entry.durationMinutes;
    }

    final uniqueDays = entries.map((e) => DateFormat('yyyy-MM-dd').format(e.date)).toSet().length;

    final totalMinutes = entries.fold(0, (sum, e) => sum + e.durationMinutes);

    final hasFilters =
        state.selectedProjectIds.isNotEmpty ||
        state.selectedClientIds.isNotEmpty ||
        state.selectedTagIds.isNotEmpty ||
        (canChangeMembers && selectedMemberIds.isNotEmpty);

    emit(
      state.copyWith(
        selectedMemberIds: selectedMemberIds,
        filteredEntries: entries,
        minutesByProject: minutesByProject,
        totalMinutes: totalMinutes,
        uniqueDays: uniqueDays,
        filteredProjects: filteredProjects,
        filteredClients: filteredClients,
        filteredMembers: filteredMembers,
        tags: _workspaceRepository.tags,
        canChangeMembers: canChangeMembers,
        hasFilters: hasFilters,
      ),
    );
  }

  void setPeriod(ReportPeriod period) {
    if (period == ReportPeriod.custom) return;
    emit(state.copyWith(selectedPeriod: period, selectedRange: period.getDateRange()));
    _syncFromSources();
  }

  void setCustomRange(DateTimeRange range) {
    emit(state.copyWith(selectedPeriod: ReportPeriod.custom, selectedRange: range));
    _syncFromSources();
  }

  void setSelectedProjectIds(List<String> ids) {
    emit(state.copyWith(selectedProjectIds: ids));
    _syncFromSources();
  }

  void setSelectedClientIds(List<String> ids) {
    emit(state.copyWith(selectedClientIds: ids));
    _syncFromSources();
  }

  void setSelectedTagIds(List<String> ids) {
    emit(state.copyWith(selectedTagIds: ids));
    _syncFromSources();
  }

  void setSelectedMemberIds(List<String> ids) {
    if (!state.canChangeMembers) return;
    emit(state.copyWith(selectedMemberIds: ids));
    _syncFromSources();
  }

  void clearFilters() {
    final isAdmin = _authDataProvider.isAdmin;
    final isManager = _authDataProvider.isManager;
    final currentMember = _workspaceRepository.getCurrentUserTeamMember(_authDataProvider.currentUserId);

    final memberIds = (!isAdmin && !isManager && currentMember != null) ? [currentMember.id] : <String>[];

    emit(
      state.copyWith(selectedProjectIds: [], selectedClientIds: [], selectedTagIds: [], selectedMemberIds: memberIds),
    );
    _syncFromSources();
  }

  void setSortBy(SortBy sortBy) {
    emit(state.copyWith(sortBy: sortBy));
    _syncFromSources();
  }

  void toggleSortDirection() {
    emit(state.copyWith(sortDescending: !state.sortDescending));
    _syncFromSources();
  }

  void setGroupBy(GroupBy groupBy) {
    emit(state.copyWith(groupBy: groupBy));
    _syncFromSources();
  }

  Project? getProjectById(String? id) {
    if (id == null) return null;
    return _workspaceRepository.getProjectById(id);
  }

  Client? getClientById(String? id) {
    if (id == null) return null;
    return _workspaceRepository.getClientById(id);
  }

  Tag? getTagById(String id) {
    return _workspaceRepository.getTagById(id);
  }

  TeamMember? getTeamMemberById(String id) {
    return _workspaceRepository.getTeamMemberById(id);
  }

  Future<void> exportToCsv() async {
    if (state.filteredEntries.isEmpty) {
      emit(state.copyWith(toastMessage: 'No entries to export', toastType: AppToastType.info));
      return;
    }

    final csvContent = _buildDetailedCsv(state.filteredEntries);
    final fileName = 'time-report-detailed-${DateFormat('yyyyMMdd-HHmm').format(DateTime.now())}.csv';

    final downloaded = await csv_download.downloadCsv(fileName: fileName, csvContent: csvContent);

    if (downloaded) {
      emit(state.copyWith(toastMessage: 'CSV downloaded: $fileName', toastType: AppToastType.success));
      return;
    }

    await Clipboard.setData(ClipboardData(text: csvContent));
    emit(
      state.copyWith(
        toastMessage: 'CSV copied to clipboard (download unsupported on this platform).',
        toastType: AppToastType.info,
      ),
    );
  }

  Future<void> exportToPdf() async {
    final pdf = pw.Document();
    final entries = state.filteredEntries;
    final totalMinutes = entries.fold(0, (sum, e) => sum + e.durationMinutes);

    pw.Font? font;
    try {
      final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
      font = pw.Font.ttf(fontData);
    } catch (_) {}

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        header:
            (context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Time Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, font: font)),
                pw.SizedBox(height: 8),
                pw.Text(
                  '${DateFormat('MMM d, yyyy').format(state.selectedRange.start)} - ${DateFormat('MMM d, yyyy').format(state.selectedRange.end)}',
                  style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700, font: font),
                ),
                pw.SizedBox(height: 16),
                pw.Divider(),
                pw.SizedBox(height: 16),
              ],
            ),
        footer:
            (context) => pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Generated: ${DateFormat('MMM d, yyyy HH:mm').format(DateTime.now())}',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600, font: font),
                ),
                pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600, font: font),
                ),
              ],
            ),
        build:
            (context) => [
              ..._buildPdfFilters(font: font),
              pw.SizedBox(height: 24),
              pw.Text('Time Entries', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, font: font)),
              pw.SizedBox(height: 4),
              pw.Text(
                'Total: ${_formatMinutes(totalMinutes)}',
                style: pw.TextStyle(fontSize: 12, color: PdfColors.blue700, fontWeight: pw.FontWeight.bold, font: font),
              ),
              pw.SizedBox(height: 12),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1.5),
                  1: const pw.FlexColumnWidth(4),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildPdfTableHeader('Date', font: font),
                      _buildPdfTableHeader('Description', font: font),
                      _buildPdfTableHeader('Project', font: font),
                      _buildPdfTableHeader('Duration', font: font),
                    ],
                  ),
                  ...entries.map((entry) {
                    final project = getProjectById(entry.projectId);
                    return pw.TableRow(
                      children: [
                        _buildPdfTableCell(DateFormat('MMM d').format(entry.date), font: font),
                        _buildPdfTableCell(entry.description, font: font),
                        _buildPdfTableCell(project?.name ?? '-', font: font),
                        _buildPdfTableCell(entry.formattedDuration, font: font),
                      ],
                    );
                  }),
                ],
              ),
              if (entries.isNotEmpty) ...[
                pw.SizedBox(height: 24),
                pw.Text('By Project', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, font: font)),
                pw.SizedBox(height: 12),
                ..._buildPdfProjectBreakdown(entries, totalMinutes, font: font),
              ],
            ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  String _buildDetailedCsv(List<TimeEntry> entries) {
    final header = [
      'Description',
      'Duration',
      'Member',
      'Email',
      'Project',
      'Client',
      'Tags',
      'Status',
      'Start date',
      'Start time',
      'Stop date',
      'Stop time',
    ];

    final lines = <String>[header.map(_csvCell).join(',')];

    for (final entry in entries) {
      final member = _workspaceRepository.teamMembers.firstWhere(
        (m) => m.firebaseUid == entry.createdByUserId,
        orElse:
            () => TeamMember(
              id: '',
              name: entry.createdByUserId,
              email: '',
              role: TeamMemberRole.regular,
              userId: '',
              createdAt: DateTime.now(),
            ),
      );

      final project = getProjectById(entry.projectId);
      final client = project?.clientId != null ? getClientById(project!.clientId) : null;

      final tags = entry.tagIds.map((id) => getTagById(id)).whereType<Tag>().map((t) => t.name).toList();

      final start = entry.startTime ?? entry.date;
      final stop = start.add(Duration(minutes: entry.durationMinutes));
      final duration = _formatCsvDuration(entry.durationMinutes);

      final row = [
        entry.description,
        duration,
        member.name,
        member.email,
        project?.name ?? '-',
        client?.name ?? '-',
        tags.isEmpty ? '-' : tags.join('|'),
        entry.status.value,
        DateFormat('yyyy-MM-dd').format(start),
        DateFormat('HH:mm:ss').format(start),
        DateFormat('yyyy-MM-dd').format(stop),
        DateFormat('HH:mm:ss').format(stop),
      ];

      lines.add(row.map(_csvCell).join(','));
    }

    return lines.join('\n');
  }

  String _formatCsvDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours.toString().padLeft(1, '0')}:${mins.toString().padLeft(2, '0')}:00';
  }

  String _csvCell(String value) {
    final escaped = value.replaceAll('"', '""');
    return '"$escaped"';
  }

  pw.Widget _buildPdfTableHeader(String text, {pw.Font? font}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(text, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10, font: font)),
    );
  }

  pw.Widget _buildPdfTableCell(String text, {pw.Font? font}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(text, style: pw.TextStyle(fontSize: 9, font: font, fontFallback: [font!])),
    );
  }

  List<pw.Widget> _buildPdfFilters({pw.Font? font}) {
    final filters = <pw.Widget>[];

    if (state.selectedMemberIds.isNotEmpty) {
      final memberNames = state.selectedMemberIds.map((id) => getTeamMemberById(id)?.name).whereType<String>().toList();
      if (memberNames.isNotEmpty) {
        filters.add(
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Members: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: font)),
                pw.Expanded(child: pw.Text(memberNames.join(', '), style: pw.TextStyle(fontSize: 10, font: font))),
              ],
            ),
          ),
        );
      }
    }

    if (state.selectedProjectIds.isNotEmpty) {
      final projectNames = state.selectedProjectIds.map((id) => getProjectById(id)?.name).whereType<String>().toList();
      if (projectNames.isNotEmpty) {
        filters.add(
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Projects: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: font)),
                pw.Expanded(child: pw.Text(projectNames.join(', '), style: pw.TextStyle(fontSize: 10, font: font))),
              ],
            ),
          ),
        );
      }
    }

    if (state.selectedClientIds.isNotEmpty) {
      final clientNames = state.selectedClientIds.map((id) => getClientById(id)?.name).whereType<String>().toList();
      if (clientNames.isNotEmpty) {
        filters.add(
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Clients: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: font)),
                pw.Expanded(child: pw.Text(clientNames.join(', '), style: pw.TextStyle(fontSize: 10, font: font))),
              ],
            ),
          ),
        );
      }
    }

    if (state.selectedTagIds.isNotEmpty) {
      final tagNames = state.selectedTagIds.map((id) => getTagById(id)?.name).whereType<String>().toList();
      if (tagNames.isNotEmpty) {
        filters.add(
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Tags: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: font)),
                pw.Expanded(child: pw.Text(tagNames.join(', '), style: pw.TextStyle(fontSize: 10, font: font))),
              ],
            ),
          ),
        );
      }
    }

    if (filters.isEmpty) {
      return [];
    }

    return [
      pw.Container(
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(color: PdfColors.grey100, borderRadius: pw.BorderRadius.circular(8)),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Filters', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: font)),
            pw.SizedBox(height: 8),
            ...filters,
          ],
        ),
      ),
    ];
  }

  List<pw.Widget> _buildPdfProjectBreakdown(List<TimeEntry> entries, int totalMinutes, {pw.Font? font}) {
    final minutesByProject = <String, int>{};
    for (final entry in entries) {
      final projectId = entry.projectId ?? 'unassigned';
      minutesByProject[projectId] = (minutesByProject[projectId] ?? 0) + entry.durationMinutes;
    }

    final sorted = minutesByProject.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return sorted.map((e) {
      final project = e.key != 'unassigned' ? getProjectById(e.key) : null;
      final percentage = totalMinutes > 0 ? (e.value / totalMinutes * 100) : 0.0;

      return pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Row(
          children: [
            pw.Expanded(
              flex: 2,
              child: pw.Text(project?.name ?? 'Unassigned', style: pw.TextStyle(fontSize: 10, font: font)),
            ),
            pw.Expanded(
              flex: 4,
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: (percentage * 1000).round().clamp(0, 100000),
                    child: pw.Container(
                      height: 16,
                      decoration: pw.BoxDecoration(color: PdfColors.blue300, borderRadius: pw.BorderRadius.circular(4)),
                    ),
                  ),
                  pw.Expanded(
                    flex: ((100 - percentage) * 1000).round().clamp(0, 100000),
                    child: pw.Container(
                      height: 16,
                      decoration: pw.BoxDecoration(color: PdfColors.grey200, borderRadius: pw.BorderRadius.circular(4)),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 8),
            pw.SizedBox(
              width: 60,
              child: pw.Text(
                '${_formatMinutes(e.value)} (${percentage.toStringAsFixed(1)}%)',
                style: pw.TextStyle(fontSize: 9, font: font),
                textAlign: pw.TextAlign.right,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) return '${hours}h ${mins}m';
    if (hours > 0) return '${hours}h';
    return '${mins}m';
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  @override
  void dispose() {
    _workspaceRepository.removeListener(_syncFromSources);
    _authDataProvider.removeListener(_syncFromSources);
    super.dispose();
  }
}
