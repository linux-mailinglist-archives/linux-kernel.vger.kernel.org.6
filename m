Return-Path: <linux-kernel+bounces-320690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1871E970E69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E52B1F22767
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1822D1AE03D;
	Mon,  9 Sep 2024 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="R04FXvxd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FE1AE022
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864549; cv=pass; b=Lnie4n95uT8FOumZucAPEN35AgDzrz1HgGiwgq63/9w1/pCUdlPTV3ixUfyNrb/KV1lugNedxNUqDY/0hO86vcFAHIE+UY1uIFGHF001hrycfJR6BkhOiLMlAhCYM9SbbMAZXTFNMyTCz0bLD+Se9HZLHNo0f4e0phpisku8Bpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864549; c=relaxed/simple;
	bh=/C0vS5pR1D77oh+yk1Wziv9+Qp9fDRH/K5uBtUK3vN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsYKmq4IJSX8k8xPeMlGMoDCi0xDHwmK2oxr4AmTO3G7LmjYOfjr5gAu7YLDBx1s1DamKvpGKLCi/S03RYKFUcSMZavebrLmFPuJszkuwjiAYgmtNC8yV9FozOf+4NUcRu7WQAdDrfDdF2FSwrpZHqRbkQM1Q647/zaSBdKeDc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=R04FXvxd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725864533; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KDv3TGOOMlHAoFFRw2lgcKsMgU1s5CQciN6S3aWQIml9j041/LYA7sso4IO9z8D7Jlk4nGnwJ1mRyaozgcctr7NYbWD5KOkC0VwhbVDr4+3sdH/yr4hzlaRL0iNT3N9FdxUBmzu/YrxcSNlpw024POr/IDAo7rCH8ckdQK9q+p0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725864533; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=URFnd2Z77POtYk8MmvC3Vl5tyHzCCAlEp2xTpMqHwVQ=; 
	b=SUVFS/M97CeUNDsPQAd4nOejlMtb/IkBH9b/sYqhlIEUNdbBKHXce5S9n2pxrS5TnhNDvnK4iCqNq7THGHdJ34d6qibbKBy+Kr/wXpUvWqkhnRsH9tdfUHXkzc08+DgjkPmwVlWjB9j3Grxi8FNT3KI5b3L+2Od72G7LpO/FG4w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725864533;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=URFnd2Z77POtYk8MmvC3Vl5tyHzCCAlEp2xTpMqHwVQ=;
	b=R04FXvxd2ftbXhUwDGLUf5VqSsBvv6kzxFPDsMRC4+rGnR5K9kTmyWbARB/fAjjJ
	8argKeQVexvfyrFjzXc8urz0Fp4XmcDTlZ+EY31MngDxLex+IGvJsDZaaQ9H0szfCoB
	6Lm6i5+zd8V1yDp+sOZAvVWdbOTYvcwyKKYNDkIY=
Received: by mx.zohomail.com with SMTPS id 172586453261846.07654823838766;
	Sun, 8 Sep 2024 23:48:52 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christopher Healy <healych@amazon.com>,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 2/2] drm/panthor: Add DEV_QUERY_GROUP_PRIORITIES_INFO dev query
Date: Mon,  9 Sep 2024 08:48:21 +0200
Message-ID: <20240909064820.34982-4-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909064820.34982-2-mary.guillemard@collabora.com>
References: <20240909064820.34982-2-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Expose allowed group priorities with a new device query.

This new uAPI will be used in Mesa to properly report what priorities a
user can use for EGL_IMG_context_priority.

Since this extends the uAPI and because userland needs a way to
advertise priorities accordingly, this also bumps the driver minor
version.

v2:
- Remove drm_panthor_group_allow_priority_flags definition
- Document that allowed_mask is a bitmask of drm_panthor_group_priority

v3:
- Use BIT macro in panthor_query_group_priorities_info
- Add r-b from Steven Price and Boris Brezillon

Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 61 ++++++++++++++++++---------
 include/uapi/drm/panthor_drm.h        | 22 ++++++++++
 2 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 7b1db2adcb4c..0d825d63d712 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -170,6 +170,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
@@ -777,11 +778,41 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	return 0;
 }
 
+static int group_priority_permit(struct drm_file *file,
+				 u8 priority)
+{
+	/* Ensure that priority is valid */
+	if (priority > PANTHOR_GROUP_PRIORITY_REALTIME)
+		return -EINVAL;
+
+	/* Medium priority and below are always allowed */
+	if (priority <= PANTHOR_GROUP_PRIORITY_MEDIUM)
+		return 0;
+
+	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
+	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
+		return 0;
+
+	return -EACCES;
+}
+
+static void panthor_query_group_priorities_info(struct drm_file *file,
+						struct drm_panthor_group_priorities_info *arg)
+{
+	int prio;
+
+	for (prio = PANTHOR_GROUP_PRIORITY_REALTIME; prio >= 0; prio--) {
+		if (!group_priority_permit(file, prio))
+			arg->allowed_mask |= BIT(prio);
+	}
+}
+
 static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct drm_file *file)
 {
 	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
 	struct drm_panthor_dev_query *args = data;
 	struct drm_panthor_timestamp_info timestamp_info;
+	struct drm_panthor_group_priorities_info priorities_info;
 	int ret;
 
 	if (!args->pointer) {
@@ -798,6 +829,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(timestamp_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO:
+			args->size = sizeof(priorities_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -818,6 +853,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, timestamp_info);
 
+	case DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO:
+		panthor_query_group_priorities_info(file, &priorities_info);
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, priorities_info);
+
 	default:
 		return -EINVAL;
 	}
@@ -1037,24 +1076,6 @@ static int panthor_ioctl_group_destroy(struct drm_device *ddev, void *data,
 	return panthor_group_destroy(pfile, args->group_handle);
 }
 
-static int group_priority_permit(struct drm_file *file,
-				 u8 priority)
-{
-	/* Ensure that priority is valid */
-	if (priority > PANTHOR_GROUP_PRIORITY_REALTIME)
-		return -EINVAL;
-
-	/* Medium priority and below are always allowed */
-	if (priority <= PANTHOR_GROUP_PRIORITY_MEDIUM)
-		return 0;
-
-	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
-	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
-		return 0;
-
-	return -EACCES;
-}
-
 static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 				      struct drm_file *file)
 {
@@ -1436,6 +1457,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * PanCSF driver version:
  * - 1.0 - initial interface
  * - 1.1 - adds DEV_QUERY_TIMESTAMP_INFO query
+ * - 1.2 - adds DEV_QUERY_GROUP_PRIORITIES_INFO query
+ *       - adds PANTHOR_GROUP_PRIORITY_REALTIME priority
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1449,7 +1472,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.desc = "Panthor DRM driver",
 	.date = "20230801",
 	.major = 1,
-	.minor = 1,
+	.minor = 2,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 011a555e4674..87c9cb555dd1 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -263,6 +263,11 @@ enum drm_panthor_dev_query_type {
 
 	/** @DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO: Query timestamp information. */
 	DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO,
+
+	/**
+	 * @DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO: Query allowed group priorities information.
+	 */
+	DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO,
 };
 
 /**
@@ -399,6 +404,23 @@ struct drm_panthor_timestamp_info {
 	__u64 timestamp_offset;
 };
 
+/**
+ * struct drm_panthor_group_priorities_info - Group priorities information
+ *
+ * Structure grouping all queryable information relating to the allowed group priorities.
+ */
+struct drm_panthor_group_priorities_info {
+	/**
+	 * @allowed_mask: Bitmask of the allowed group priorities.
+	 *
+	 * Each bit represents a variant of the enum drm_panthor_group_priority.
+	 */
+	__u8 allowed_mask;
+
+	/** @pad: Padding fields, MBZ. */
+	__u8 pad[3];
+};
+
 /**
  * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
  */
-- 
2.46.0


