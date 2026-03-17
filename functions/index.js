/**
 * ClickUp Integration Cloud Functions
 * 
 * Functions for syncing ClickUp tasks to Firestore
 */

const { setGlobalOptions } = require("firebase-functions");
const { onRequest, onCall } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
const logger = require("firebase-functions/logger");

// Initialize Firebase Admin
admin.initializeApp();

const db = admin.firestore();

// Global settings
setGlobalOptions({ maxInstances: 10, region: "europe-west1" });

// ClickUp API base URL
const CLICKUP_API_BASE = "https://api.clickup.com/api/v2";

/**
 * Helper function to make ClickUp API requests
 * Uses native fetch (available in Node 18+)
 */
async function clickupRequest(endpoint, apiToken, method = "GET", body = null) {
  const options = {
    method,
    headers: {
      "Authorization": apiToken,
      "Content-Type": "application/json",
    },
  };
  
  if (body) {
    options.body = JSON.stringify(body);
  }
  
  const response = await fetch(`${CLICKUP_API_BASE}${endpoint}`, options);
  
  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`ClickUp API error: ${response.status} - ${errorText}`);
  }
  
  return response.json();
}

function getOrgSettingsDoc(organizationId) {
  return db
    .collection("organizations")
    .doc(organizationId)
    .collection("settings")
    .doc("clickup");
}

function getOrgTasksCollection(organizationId) {
  return db
    .collection("organizations")
    .doc(organizationId)
    .collection("clickup_tasks");
}

function requireOrganizationId(data) {
  const organizationId = data?.organizationId;
  if (!organizationId || typeof organizationId !== "string") {
    throw new Error("organizationId is required");
  }
  return organizationId;
}

function requireAuthUid(request) {
  const uid = request.auth?.uid;
  if (!uid) {
    throw new Error("Authentication is required");
  }
  return uid;
}

async function getMemberData(organizationId, uid, email = null) {
  const membersRef = db
    .collection("organizations")
    .doc(organizationId)
    .collection("members");

  const memberDoc = await membersRef.doc(uid).get();
  if (memberDoc.exists) {
    const data = memberDoc.data() || {};
    if (data.isActive === false) {
      throw new Error("Membership is inactive");
    }
    return data;
  }

  const byUserIdSnapshot = await membersRef.where("userId", "==", uid).limit(1).get();
  if (!byUserIdSnapshot.empty) {
    const data = byUserIdSnapshot.docs[0].data() || {};
    if (data.isActive === false) {
      throw new Error("Membership is inactive");
    }
    return data;
  }

  const normalizedEmail = (email || "").toString().trim().toLowerCase();
  if (normalizedEmail) {
    const byEmailLowerSnapshot = await membersRef
      .where("emailLower", "==", normalizedEmail)
      .limit(1)
      .get();
    if (!byEmailLowerSnapshot.empty) {
      const data = byEmailLowerSnapshot.docs[0].data() || {};
      if (data.isActive === false) {
        throw new Error("Membership is inactive");
      }
      return data;
    }

    const byEmailSnapshot = await membersRef.where("email", "==", normalizedEmail).limit(1).get();
    if (!byEmailSnapshot.empty) {
      const data = byEmailSnapshot.docs[0].data() || {};
      if (data.isActive === false) {
        throw new Error("Membership is inactive");
      }
      return data;
    }
  }

  throw new Error("User is not a member of this organization");
}

function hasManagerAccess(role) {
  return role === "owner" || role === "admin" || role === "manager";
}

function isAllowedInviteRole(role) {
  return role === "admin" || role === "manager" || role === "member" || role === "client";
}

function normalizeEmail(value) {
  return (value || "").toString().trim().toLowerCase();
}

/**
 * Get ClickUp API token from Firestore settings
 */
async function getClickUpToken(organizationId) {
  const settingsDoc = await getOrgSettingsDoc(organizationId).get();
  if (!settingsDoc.exists) {
    throw new Error("ClickUp settings not configured");
  }
  const settings = settingsDoc.data();
  if (!settings.apiToken) {
    throw new Error("ClickUp API token not configured");
  }
  return settings.apiToken;
}

/**
 * Get ClickUp workspaces (teams)
 */
exports.getClickUpWorkspaces = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    await getMemberData(organizationId, uid);
    const apiToken = await getClickUpToken(organizationId);
    const data = await clickupRequest("/team", apiToken);
    
    return {
      success: true,
      workspaces: data.teams.map((team) => ({
        id: team.id,
        name: team.name,
        color: team.color,
        avatar: team.avatar,
      })),
    };
  } catch (error) {
    logger.error("Error getting ClickUp workspaces:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Get ClickUp spaces for a workspace
 */
exports.getClickUpSpaces = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    await getMemberData(organizationId, uid);
    const { workspaceId } = request.data;
    if (!workspaceId) {
      throw new Error("workspaceId is required");
    }
    
    const apiToken = await getClickUpToken(organizationId);
    const data = await clickupRequest(`/team/${workspaceId}/space?archived=false`, apiToken);
    
    return {
      success: true,
      spaces: data.spaces.map((space) => ({
        id: space.id,
        name: space.name,
        color: space.color,
        private: space.private,
      })),
    };
  } catch (error) {
    logger.error("Error getting ClickUp spaces:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Get ClickUp folders for a space
 */
exports.getClickUpFolders = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    await getMemberData(organizationId, uid);
    const { spaceId } = request.data;
    if (!spaceId) {
      throw new Error("spaceId is required");
    }
    
    const apiToken = await getClickUpToken(organizationId);
    const data = await clickupRequest(`/space/${spaceId}/folder?archived=false`, apiToken);
    
    return {
      success: true,
      folders: data.folders.map((folder) => ({
        id: folder.id,
        name: folder.name,
        hidden: folder.hidden,
        lists: folder.lists.map((list) => ({
          id: list.id,
          name: list.name,
        })),
      })),
    };
  } catch (error) {
    logger.error("Error getting ClickUp folders:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Get ClickUp lists for a space (folderless lists)
 */
exports.getClickUpLists = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    await getMemberData(organizationId, uid);
    const { spaceId } = request.data;
    if (!spaceId) {
      throw new Error("spaceId is required");
    }
    
    const apiToken = await getClickUpToken(organizationId);
    const data = await clickupRequest(`/space/${spaceId}/list?archived=false`, apiToken);
    
    return {
      success: true,
      lists: data.lists.map((list) => ({
        id: list.id,
        name: list.name,
        content: list.content,
      })),
    };
  } catch (error) {
    logger.error("Error getting ClickUp lists:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Get ClickUp lists for a folder
 */
exports.getClickUpFolderLists = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    await getMemberData(organizationId, uid);
    const { folderId } = request.data;
    if (!folderId) {
      throw new Error("folderId is required");
    }
    
    const apiToken = await getClickUpToken(organizationId);
    const data = await clickupRequest(`/folder/${folderId}/list?archived=false`, apiToken);
    
    return {
      success: true,
      lists: data.lists.map((list) => ({
        id: list.id,
        name: list.name,
        content: list.content,
      })),
    };
  } catch (error) {
    logger.error("Error getting ClickUp folder lists:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Sync all tasks from selected ClickUp lists to Firestore
 */
exports.syncClickUpTasks = onCall({ timeoutSeconds: 540 }, async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    const memberData = await getMemberData(organizationId, uid);
    if (!hasManagerAccess(memberData.role)) {
      throw new Error("Manager access is required");
    }
    const apiToken = await getClickUpToken(organizationId);
    
    // Get sync settings
    const settingsDoc = await getOrgSettingsDoc(organizationId).get();
    const settings = settingsDoc.data() || {};
    const selectedListIds = settings.selectedListIds || [];
    
    if (selectedListIds.length === 0) {
      return { success: false, error: "No lists selected for sync" };
    }
    
    let totalTasks = 0;
    const batch = db.batch();
    const tasksCollection = getOrgTasksCollection(organizationId);
    
    for (const listId of selectedListIds) {
      let page = 0;
      let hasMore = true;
      
      while (hasMore) {
        try {
          const data = await clickupRequest(
            `/list/${listId}/task?page=${page}&subtasks=true&include_closed=true`,
            apiToken,
          );
          
          const tasks = data.tasks || [];
          
          for (const task of tasks) {
            const taskDoc = tasksCollection.doc(task.id);
            batch.set(taskDoc, {
              id: task.id,
              customId: task.custom_id || null,
              name: task.name,
              description: task.description || "",
              status: task.status?.status || "unknown",
              statusColor: task.status?.color || "#808080",
              priority: task.priority?.priority || null,
              priorityColor: task.priority?.color || null,
              listId: task.list?.id || listId,
              listName: task.list?.name || "",
              folderId: task.folder?.id || null,
              folderName: task.folder?.name || "",
              spaceId: task.space?.id || null,
              spaceName: task.space?.name || "",
              url: task.url,
              dateCreated: task.date_created ? parseInt(task.date_created) : null,
              dateUpdated: task.date_updated ? parseInt(task.date_updated) : null,
              dateClosed: task.date_closed ? parseInt(task.date_closed) : null,
              dueDate: task.due_date ? parseInt(task.due_date) : null,
              startDate: task.start_date ? parseInt(task.start_date) : null,
              timeEstimate: task.time_estimate || null,
              timeSpent: task.time_spent || null,
              assignees: (task.assignees || []).map((a) => ({
                id: a.id,
                username: a.username,
                email: a.email,
                profilePicture: a.profilePicture,
              })),
              tags: (task.tags || []).map((t) => ({
                name: t.name,
                tagFg: t.tag_fg,
                tagBg: t.tag_bg,
              })),
              parent: task.parent || null,
              syncedAt: admin.firestore.FieldValue.serverTimestamp(),
            }, { merge: true });
            
            totalTasks++;
          }
          
          // ClickUp returns max 100 tasks per page
          if (tasks.length < 100) {
            hasMore = false;
          } else {
            page++;
          }
          
          // Commit batch every 400 operations to avoid limits
          if (totalTasks % 400 === 0) {
            await batch.commit();
          }
        } catch (listError) {
          logger.error(`Error syncing list ${listId}:`, listError);
          // Continue with next list
          hasMore = false;
        }
      }
    }
    
    // Commit remaining operations
    await batch.commit();
    
    // Update last sync timestamp
    await getOrgSettingsDoc(organizationId).update({
      lastSyncAt: admin.firestore.FieldValue.serverTimestamp(),
      lastSyncTaskCount: totalTasks,
    });
    
    logger.info(`Synced ${totalTasks} tasks from ClickUp`);
    
    return {
      success: true,
      taskCount: totalTasks,
    };
  } catch (error) {
    logger.error("Error syncing ClickUp tasks:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Sync tasks updated since last sync (incremental sync)
 */
exports.syncClickUpTasksIncremental = onCall({ timeoutSeconds: 300 }, async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    const memberData = await getMemberData(organizationId, uid);
    if (!hasManagerAccess(memberData.role)) {
      throw new Error("Manager access is required");
    }
    const apiToken = await getClickUpToken(organizationId);
    
    // Get sync settings
    const settingsDoc = await getOrgSettingsDoc(organizationId).get();
    const settings = settingsDoc.data() || {};
    const selectedListIds = settings.selectedListIds || [];
    const lastSyncAt = settings.lastSyncAt?.toMillis() || 0;
    
    if (selectedListIds.length === 0) {
      return { success: false, error: "No lists selected for sync" };
    }
    
    let totalTasks = 0;
    const batch = db.batch();
    const tasksCollection = getOrgTasksCollection(organizationId);
    
    for (const listId of selectedListIds) {
      try {
        const data = await clickupRequest(
          `/list/${listId}/task?subtasks=true&include_closed=true&date_updated_gt=${lastSyncAt}`,
          apiToken,
        );
        
        const tasks = data.tasks || [];
        
        for (const task of tasks) {
          const taskDoc = tasksCollection.doc(task.id);
          batch.set(taskDoc, {
            id: task.id,
            customId: task.custom_id || null,
            name: task.name,
            description: task.description || "",
            status: task.status?.status || "unknown",
            statusColor: task.status?.color || "#808080",
            priority: task.priority?.priority || null,
            priorityColor: task.priority?.color || null,
            listId: task.list?.id || listId,
            listName: task.list?.name || "",
            folderId: task.folder?.id || null,
            folderName: task.folder?.name || "",
            spaceId: task.space?.id || null,
            spaceName: task.space?.name || "",
            url: task.url,
            dateCreated: task.date_created ? parseInt(task.date_created) : null,
            dateUpdated: task.date_updated ? parseInt(task.date_updated) : null,
            dateClosed: task.date_closed ? parseInt(task.date_closed) : null,
            dueDate: task.due_date ? parseInt(task.due_date) : null,
            startDate: task.start_date ? parseInt(task.start_date) : null,
            timeEstimate: task.time_estimate || null,
            timeSpent: task.time_spent || null,
            assignees: (task.assignees || []).map((a) => ({
              id: a.id,
              username: a.username,
              email: a.email,
              profilePicture: a.profilePicture,
            })),
            tags: (task.tags || []).map((t) => ({
              name: t.name,
              tagFg: t.tag_fg,
              tagBg: t.tag_bg,
            })),
            parent: task.parent || null,
            syncedAt: admin.firestore.FieldValue.serverTimestamp(),
          }, { merge: true });
          
          totalTasks++;
        }
      } catch (listError) {
        logger.error(`Error syncing list ${listId}:`, listError);
      }
    }
    
    await batch.commit();
    
    // Update last sync timestamp
    await getOrgSettingsDoc(organizationId).update({
      lastSyncAt: admin.firestore.FieldValue.serverTimestamp(),
      lastIncrementalSyncTaskCount: totalTasks,
    });
    
    return {
      success: true,
      taskCount: totalTasks,
    };
  } catch (error) {
    logger.error("Error in incremental sync:", error);
    return { success: false, error: error.message };
  }
});

/**
 * ClickUp Webhook endpoint
 * Handles task created, updated, deleted events
 */
exports.clickupWebhook = onRequest(async (req, res) => {
  const organizationId = req.query.organizationId || req.body?.organizationId;
  if (!organizationId || typeof organizationId !== "string") {
    res.status(400).send("organizationId is required");
    return;
  }

  // Get settings
  const settingsDoc = await getOrgSettingsDoc(organizationId).get();
  const settings = settingsDoc.data() || {};
  
  const event = req.body;
  logger.info("ClickUp webhook received:", event);
  
  try {
    const { event: eventType, task_id: taskId } = event;
    
    // Check if this list is in our selected lists
    const selectedListIds = settings.selectedListIds || [];
    
    if (eventType === "taskCreated" || eventType === "taskUpdated") {
      // Fetch the full task data from ClickUp
      const apiToken = settings.apiToken;
      if (!apiToken) {
        res.status(500).send("API token not configured");
        return;
      }
      
      try {
        const task = await clickupRequest(`/task/${taskId}`, apiToken);
        
        // Check if task's list is in selected lists
        if (!selectedListIds.includes(task.list?.id)) {
          logger.info(`Task ${taskId} not in selected lists, skipping`);
          res.status(200).send("OK - Skipped");
          return;
        }
        
        // Update task in Firestore
        await getOrgTasksCollection(organizationId).doc(taskId).set({
          id: task.id,
          customId: task.custom_id || null,
          name: task.name,
          description: task.description || "",
          status: task.status?.status || "unknown",
          statusColor: task.status?.color || "#808080",
          priority: task.priority?.priority || null,
          priorityColor: task.priority?.color || null,
          listId: task.list?.id || null,
          listName: task.list?.name || "",
          folderId: task.folder?.id || null,
          folderName: task.folder?.name || "",
          spaceId: task.space?.id || null,
          spaceName: task.space?.name || "",
          url: task.url,
          dateCreated: task.date_created ? parseInt(task.date_created) : null,
          dateUpdated: task.date_updated ? parseInt(task.date_updated) : null,
          dateClosed: task.date_closed ? parseInt(task.date_closed) : null,
          dueDate: task.due_date ? parseInt(task.due_date) : null,
          startDate: task.start_date ? parseInt(task.start_date) : null,
          timeEstimate: task.time_estimate || null,
          timeSpent: task.time_spent || null,
          assignees: (task.assignees || []).map((a) => ({
            id: a.id,
            username: a.username,
            email: a.email,
            profilePicture: a.profilePicture,
          })),
          tags: (task.tags || []).map((t) => ({
            name: t.name,
            tagFg: t.tag_fg,
            tagBg: t.tag_bg,
          })),
          parent: task.parent || null,
          syncedAt: admin.firestore.FieldValue.serverTimestamp(),
        }, { merge: true });
        
        logger.info(`Task ${taskId} synced via webhook`);
      } catch (fetchError) {
        logger.error(`Error fetching task ${taskId}:`, fetchError);
      }
    } else if (eventType === "taskDeleted") {
      // Delete task from Firestore
      await getOrgTasksCollection(organizationId).doc(taskId).delete();
      logger.info(`Task ${taskId} deleted via webhook`);
    }
    
    res.status(200).send("OK");
  } catch (error) {
    logger.error("Error processing webhook:", error);
    res.status(500).send("Error processing webhook");
  }
});

/**
 * Create ClickUp webhook
 */
exports.createClickUpWebhook = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    const memberData = await getMemberData(organizationId, uid);
    if (!hasManagerAccess(memberData.role)) {
      throw new Error("Manager access is required");
    }
    const { workspaceId, webhookUrl } = request.data;
    
    if (!workspaceId || !webhookUrl) {
      throw new Error("workspaceId and webhookUrl are required");
    }
    
    const apiToken = await getClickUpToken(organizationId);
    
    const url = new URL(webhookUrl);
    url.searchParams.set("organizationId", organizationId);
    const scopedWebhookUrl = url.toString();

    const webhookData = await clickupRequest(
      `/team/${workspaceId}/webhook`,
      apiToken,
      "POST",
      {
        endpoint: scopedWebhookUrl,
        events: [
          "taskCreated",
          "taskUpdated",
          "taskDeleted",
        ],
      },
    );
    
    // Save webhook info to settings
    await getOrgSettingsDoc(organizationId).update({
      webhookId: webhookData.id,
      webhookUrl: scopedWebhookUrl,
      webhookSecret: webhookData.webhook?.secret || null,
    });
    
    return {
      success: true,
      webhook: webhookData,
    };
  } catch (error) {
    logger.error("Error creating ClickUp webhook:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Delete ClickUp webhook
 */
exports.deleteClickUpWebhook = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    const memberData = await getMemberData(organizationId, uid);
    if (!hasManagerAccess(memberData.role)) {
      throw new Error("Manager access is required");
    }
    const { webhookId } = request.data;
    
    if (!webhookId) {
      throw new Error("webhookId is required");
    }
    
    const apiToken = await getClickUpToken(organizationId);
    
    await clickupRequest(`/webhook/${webhookId}`, apiToken, "DELETE");
    
    // Remove webhook info from settings
    await getOrgSettingsDoc(organizationId).update({
      webhookId: admin.firestore.FieldValue.delete(),
      webhookUrl: admin.firestore.FieldValue.delete(),
      webhookSecret: admin.firestore.FieldValue.delete(),
    });
    
    return { success: true };
  } catch (error) {
    logger.error("Error deleting ClickUp webhook:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Save ClickUp settings (API token, selected lists)
 */
exports.saveClickUpSettings = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    const memberData = await getMemberData(organizationId, uid);
    if (!hasManagerAccess(memberData.role)) {
      throw new Error("Manager access is required");
    }
    const { apiToken, selectedListIds, workspaceId } = request.data;
    
    const updateData = {};
    
    if (apiToken !== undefined) {
      updateData.apiToken = apiToken;
    }
    
    if (selectedListIds !== undefined) {
      updateData.selectedListIds = selectedListIds;
    }
    
    if (workspaceId !== undefined) {
      updateData.workspaceId = workspaceId;
    }
    
    updateData.updatedAt = admin.firestore.FieldValue.serverTimestamp();
    
    await getOrgSettingsDoc(organizationId).set(updateData, { merge: true });
    
    return { success: true };
  } catch (error) {
    logger.error("Error saving ClickUp settings:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Get ClickUp settings
 */
exports.getClickUpSettings = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    await getMemberData(organizationId, uid);
    const settingsDoc = await getOrgSettingsDoc(organizationId).get();
    
    if (!settingsDoc.exists) {
      return {
        success: true,
        settings: {
          isConfigured: false,
          selectedListIds: [],
        },
      };
    }
    
    const settings = settingsDoc.data();
    
    return {
      success: true,
      settings: {
        isConfigured: !!settings.apiToken,
        hasApiToken: !!settings.apiToken,
        selectedListIds: settings.selectedListIds || [],
        workspaceId: settings.workspaceId || null,
        webhookId: settings.webhookId || null,
        webhookUrl: settings.webhookUrl || null,
        lastSyncAt: settings.lastSyncAt?.toDate()?.toISOString() || null,
        lastSyncTaskCount: settings.lastSyncTaskCount || 0,
      },
    };
  } catch (error) {
    logger.error("Error getting ClickUp settings:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Search ClickUp tasks in Firestore
 */
exports.searchClickUpTasks = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    await getMemberData(organizationId, uid);
    const { query, limit = 4 } = request.data;
    
    if (!query || query.length < 2) {
      return { success: true, tasks: [] };
    }
    
    const tasksCollection = getOrgTasksCollection(organizationId);
    const queryLower = query.toLowerCase();
    
    // Search by custom ID (exact match)
    let tasks = [];
    
    // First try to find by custom ID
    const customIdSnapshot = await tasksCollection
      .where("customId", "==", query.toUpperCase())
      .limit(limit)
      .get();
    
    tasks = customIdSnapshot.docs.map((doc) => doc.data());
    
    // If not enough results, search by name
    if (tasks.length < limit) {
      // Firestore doesn't support case-insensitive search or contains
      // We'll fetch recent tasks and filter client-side
      // In production, consider using Algolia or Elasticsearch
      const snapshot = await tasksCollection
        .orderBy("dateUpdated", "desc")
        .limit(100)
        .get();
      
      const nameTasks = snapshot.docs
        .map((doc) => doc.data())
        .filter((task) => 
          task.name.toLowerCase().includes(queryLower) ||
          (task.customId && task.customId.toLowerCase().includes(queryLower)),
        )
        .slice(0, limit - tasks.length);
      
      // Merge results, avoiding duplicates
      const existingIds = new Set(tasks.map((t) => t.id));
      for (const task of nameTasks) {
        if (!existingIds.has(task.id)) {
          tasks.push(task);
        }
      }
    }
    
    return {
      success: true,
      tasks: tasks.slice(0, limit),
    };
  } catch (error) {
    logger.error("Error searching ClickUp tasks:", error);
    return { success: false, error: error.message };
  }
});

/**
 * Get task count for statistics
 */
exports.getClickUpTaskCount = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    await getMemberData(organizationId, uid);
    const snapshot = await getOrgTasksCollection(organizationId).count().get();
    return {
      success: true,
      count: snapshot.data().count,
    };
  } catch (error) {
    logger.error("Error getting task count:", error);
    return { success: false, error: error.message };
  }
});

exports.inviteOrganizationMember = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    const memberData = await getMemberData(organizationId, uid);
    if (!hasManagerAccess(memberData.role)) {
      throw new Error("Manager access is required");
    }

    const email = (request.data?.email || "").trim();
    const role = request.data?.role;
    logger.info("inviteOrganizationMember request", {
      uid,
      organizationId,
      email,
      role,
    });
    if (!email) {
      throw new Error("email is required");
    }
    if (!isAllowedInviteRole(role)) {
      throw new Error("Invalid role");
    }

    const emailLower = email.toLowerCase();
    const orgRef = db.collection("organizations").doc(organizationId);
    const orgDoc = await orgRef.get();
    if (!orgDoc.exists) {
      throw new Error("Organization not found");
    }
    const organizationName = orgDoc.data()?.name || "";

    const existingInviteSnapshot = await orgRef
      .collection("invites")
      .where("emailLower", "==", emailLower)
      .where("status", "==", "pending")
      .limit(1)
      .get();

    if (!existingInviteSnapshot.empty) {
      logger.info("inviteOrganizationMember existing invite", {
        organizationId,
        emailLower,
        inviteId: existingInviteSnapshot.docs[0].id,
      });
      return {
        success: true,
        inviteId: existingInviteSnapshot.docs[0].id,
        alreadyExists: true,
      };
    }

    const inviteRef = orgRef.collection("invites").doc();
    await inviteRef.set({
      email,
      emailLower,
      role,
      status: "pending",
      organizationId,
      organizationName,
      createdByUserId: uid,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    logger.info("inviteOrganizationMember created", {
      organizationId,
      inviteId: inviteRef.id,
      emailLower,
      role,
    });

    return {
      success: true,
      inviteId: inviteRef.id,
      alreadyExists: false,
    };
  } catch (error) {
    logger.error("Error inviting organization member:", error);
    return { success: false, error: error.message };
  }
});

exports.listMyOrganizationInvites = onCall(async (request) => {
  try {
    requireAuthUid(request);
    const email = request.auth?.token?.email;
    logger.info("listMyOrganizationInvites request", {
      uid: request.auth?.uid,
      email,
    });
    if (!email) {
      return { success: true, invites: [] };
    }

    const emailLower = email.toLowerCase();
    const snapshot = await db
      .collectionGroup("invites")
      .where("emailLower", "==", emailLower)
      .where("status", "==", "pending")
      .get();

    const invites = snapshot.docs.map((doc) => {
      const data = doc.data() || {};
      const orgId = doc.ref.parent.parent?.id || data.organizationId || "";
      return {
        id: doc.id,
        organizationId: orgId,
        organizationName: data.organizationName || "",
        email: data.email || email,
        role: data.role || "member",
        status: data.status || "pending",
        createdAtMs: data.createdAt?.toMillis?.() || Date.now(),
      };
    });
    logger.info("listMyOrganizationInvites result", {
      emailLower,
      count: invites.length,
    });

    return {
      success: true,
      invites,
    };
  } catch (error) {
    logger.error("Error listing organization invites:", error);
    return { success: false, error: error.message };
  }
});

exports.acceptOrganizationInvite = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const organizationId = requireOrganizationId(request.data);
    const inviteId = request.data?.inviteId;
    logger.info("acceptOrganizationInvite request", {
      uid,
      organizationId,
      inviteId,
    });
    if (!inviteId || typeof inviteId !== "string") {
      throw new Error("inviteId is required");
    }

    const email = request.auth?.token?.email;
    if (!email) {
      throw new Error("User email is required");
    }
    const emailLower = email.toLowerCase();

    const orgRef = db.collection("organizations").doc(organizationId);
    const inviteRef = orgRef.collection("invites").doc(inviteId);
    const memberRef = orgRef.collection("members").doc(uid);
    const userRef = db.collection("users").doc(uid);

    await db.runTransaction(async (transaction) => {
      const inviteDoc = await transaction.get(inviteRef);
      if (!inviteDoc.exists) {
        throw new Error("Invite not found");
      }

      const inviteData = inviteDoc.data() || {};
      if (inviteData.status !== "pending") {
        throw new Error("Invite is no longer pending");
      }

      if ((inviteData.emailLower || "").toLowerCase() !== emailLower) {
        throw new Error("Invite email does not match current user");
      }

      const userDoc = await transaction.get(userRef);
      const userData = userDoc.exists ? (userDoc.data() || {}) : {};

      const now = admin.firestore.Timestamp.now();
      const role = isAllowedInviteRole(inviteData.role) ? inviteData.role : "member";

      transaction.set(memberRef, {
        userId: uid,
        email,
        role,
        isActive: true,
        invitedByUserId: inviteData.createdByUserId || null,
        createdAt: now,
      }, { merge: true });
      const userUpdate = {
        organizationIds: admin.firestore.FieldValue.arrayUnion(organizationId),
      };
      if (!userData.defaultOrganizationId) {
        userUpdate.defaultOrganizationId = organizationId;
      }
      if (!userData.activeOrganizationId) {
        userUpdate.activeOrganizationId = organizationId;
      }
      transaction.set(userRef, userUpdate, { merge: true });

      transaction.update(inviteRef, {
        status: "accepted",
        acceptedByUserId: uid,
        acceptedAt: now,
      });
    });

    // Best-effort identity binding for legacy/teamMembers documents.
    // We map Firebase UID to team member records with the same email.
    const teamMembersSnapshot = await orgRef.collection("teamMembers").get();
    const normalizedEmail = email.trim().toLowerCase();
    const matchingDocs = teamMembersSnapshot.docs.filter((doc) => {
      const data = doc.data() || {};
      const memberEmail = (data.email || "").toString().trim().toLowerCase();
      return memberEmail == normalizedEmail;
    });

    if (matchingDocs.length > 0) {
      const batch = db.batch();
      let hasWrites = false;
      for (const memberDoc of matchingDocs) {
        const data = memberDoc.data() || {};
        const currentFirebaseUid = data.firebaseUid || null;
        if (currentFirebaseUid !== uid) {
          batch.set(memberDoc.ref, { firebaseUid: uid }, { merge: true });
          hasWrites = true;
        }
      }
      if (hasWrites) {
        await batch.commit();
      }
      logger.info("acceptOrganizationInvite teamMembers firebaseUid synced", {
        uid,
        organizationId,
        matchedCount: matchingDocs.length,
        hasWrites,
      });
    } else {
      logger.info("acceptOrganizationInvite no matching teamMembers to sync", {
        uid,
        organizationId,
        email,
      });
    }

    logger.info("acceptOrganizationInvite success", {
      uid,
      organizationId,
      inviteId,
    });

    return { success: true };
  } catch (error) {
    logger.error("Error accepting organization invite:", error);
    return { success: false, error: error.message };
  }
});

exports.resolveMyOrganizations = onCall(async (request) => {
  try {
    const uid = requireAuthUid(request);
    const email = request.auth?.token?.email || "";
    const persistToUserDoc = request.data?.persistToUserDoc !== false;
    const userRef = db.collection("users").doc(uid);
    const userDoc = await userRef.get();
    const userData = userDoc.exists ? (userDoc.data() || {}) : {};

    const orgIds = new Set(
      (Array.isArray(userData.organizationIds) ? userData.organizationIds : [])
        .filter((value) => typeof value === "string" && value.length > 0),
    );

    const ownerSnapshot = await db
      .collection("organizations")
      .where("ownerUserId", "==", uid)
      .get();
    ownerSnapshot.docs.forEach((doc) => orgIds.add(doc.id));

    const byUidSnapshot = await db
      .collectionGroup("members")
      .where("userId", "==", uid)
      .get();
    byUidSnapshot.docs.forEach((doc) => {
      const orgId = doc.ref.parent.parent?.id;
      if (orgId) {
        orgIds.add(orgId);
      }
    });

    const byMemberDocIdSnapshot = await db
      .collectionGroup("members")
      .where(admin.firestore.FieldPath.documentId(), "==", uid)
      .get();
    byMemberDocIdSnapshot.docs.forEach((doc) => {
      const orgId = doc.ref.parent.parent?.id;
      if (orgId) {
        orgIds.add(orgId);
      }
    });

    const normalizedEmail = normalizeEmail(email);
    if (normalizedEmail) {
      const byEmailLowerSnapshot = await db
        .collectionGroup("members")
        .where("emailLower", "==", normalizedEmail)
        .get();
      byEmailLowerSnapshot.docs.forEach((doc) => {
        const orgId = doc.ref.parent.parent?.id;
        if (orgId) {
          orgIds.add(orgId);
        }
      });
    }

    const resolvedOrgIds = Array.from(orgIds);
    resolvedOrgIds.sort();
    const defaultOrganizationId = userData.defaultOrganizationId || resolvedOrgIds[0] || null;
    const activeOrganizationId = userData.activeOrganizationId || defaultOrganizationId;

    if (persistToUserDoc && resolvedOrgIds.length > 0) {
      const patch = {
        organizationIds: admin.firestore.FieldValue.arrayUnion(...resolvedOrgIds),
      };
      if (!userData.defaultOrganizationId) {
        patch.defaultOrganizationId = defaultOrganizationId;
      }
      if (!userData.activeOrganizationId) {
        patch.activeOrganizationId = activeOrganizationId;
      }
      if (!userData.email && normalizedEmail) {
        patch.email = normalizedEmail;
      }
      if (!userData.createdAt) {
        patch.createdAt = admin.firestore.FieldValue.serverTimestamp();
      }
      await userRef.set(patch, { merge: true });
    }

    logger.info("resolveMyOrganizations result", {
      uid,
      organizationCount: resolvedOrgIds.length,
      defaultOrganizationId,
      activeOrganizationId,
      persistToUserDoc,
    });

    return {
      success: true,
      organizationIds: resolvedOrgIds,
      defaultOrganizationId,
      activeOrganizationId,
    };
  } catch (error) {
    logger.error("Error resolving organizations for current user:", error);
    return { success: false, error: error.message };
  }
});
