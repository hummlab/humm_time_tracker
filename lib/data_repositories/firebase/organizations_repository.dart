import '../../data_providers/firebase/organization_data_provider.dart';
import '../../models/org/organization.dart';
import '../../models/org/organization_invite.dart';
import '../../models/org/organization_member.dart';
import '../../models/org/team_member.dart';
import '../data_repository.dart';

class OrganizationsRepository extends DataRepository<List<Organization>, List<String>> {
  OrganizationsRepository(this._dataProvider) : super(const []);

  final OrganizationDataProvider _dataProvider;

  @override
  Future<List<Organization>> fetch(List<String> organizationIds) async {
    try {
      final organizations = await _dataProvider.getOrganizationsByIds(organizationIds);
      emit(organizations);
      return organizations;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  Future<Organization> createOrganization({
    required String name,
    required String ownerUserId,
    required String ownerEmail,
  }) async {
    return _dataProvider.createOrganization(name: name, ownerUserId: ownerUserId, ownerEmail: ownerEmail);
  }

  Future<void> setActiveOrganizationForUser(String userId, String organizationId) async {
    await _dataProvider.setActiveOrganizationForUser(userId, organizationId);
  }

  Future<OrganizationMember?> getOrganizationMember(String organizationId, String userId) async {
    return _dataProvider.getOrganizationMember(organizationId, userId);
  }

  Future<void> inviteOrganizationMember({required String email, required TeamMemberRole role}) async {
    await _dataProvider.inviteOrganizationMember(email: email, role: role);
  }

  Future<List<OrganizationInvite>> getMyPendingOrganizationInvites() async {
    return _dataProvider.getMyPendingOrganizationInvites();
  }

  Future<void> acceptOrganizationInvite({required String organizationId, required String inviteId}) async {
    await _dataProvider.acceptOrganizationInvite(organizationId: organizationId, inviteId: inviteId);
  }

  Future<Map<String, dynamic>> resolveMyOrganizations({bool persistToUserDoc = true}) async {
    return _dataProvider.resolveMyOrganizations(persistToUserDoc: persistToUserDoc);
  }
}
