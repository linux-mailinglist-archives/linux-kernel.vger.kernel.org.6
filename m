Return-Path: <linux-kernel+bounces-278240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE73A94ADC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65ADF282D2E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8D13DDD1;
	Wed,  7 Aug 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="DD6GQlZM"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4A13DDAB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047012; cv=pass; b=qRF4BbXNqgY7q/RuKWsSmRh71AR0MLEkHbgRCaswp6yaWaJTMcJcxjD2ZCL/ejAht5uuSgpojFF+zaE0SwdQEIrCoukUiW28PhK7Q29YMlxvCF3W/cZMLiIrYq5Ar1q7rlPyJ321nVVCrg2z5SnDdn+OG8Rk1zLiCEf+poYerQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047012; c=relaxed/simple;
	bh=sROwnvTcKTfH5gVoAWXbqJpei36CUEbmi71WPQC0ZvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol1re8iIoiyWcEJl7BUi6H3XVoyTRlOMAi6IoRLXiWVM4QALL5s7qHdWVpgXdc8GGZ1x5mABL3E6SYmlfHVT2lUfGyhflJIOR7o7CK4BUih6yQQhWSEisVGE5wqTRpUdfpFrbmDV+gARdzD2D6fFlUnp3/gPxQrBbheiWjZN7w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=DD6GQlZM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723046997; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W4Zus2hENAMm5ZsWBInsQ7YmSnMaVHxCP3fyXlLNKxM6XYxDZgkpBa6ZidE8xOX4aExDfS44oDkEyf6qCb6X5J5axGgzGTgVhZrSxgR2htTdshK8qnxA9T3xCm0cqkBrJ5z5/pvIToHAc0tkwJzJXv4qPibHsMCMGkIk8gljqdo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723046997; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=11EFsbnPxyKsf7C0lUvlu5OAIQuBwlJBo38EBnGl8NM=; 
	b=JuM2X7IxN2ir8+zmss1385fx3nafSIOLwZV/+hg1waJ/1a8/CGdpKOqGZmLSH+q0jOfh+NXAjHxZzwUVss0XUQqACL3vggqbPNtMHRvUSX9jyy8hsgJgYA6KxRICQrvgtkppQZhRyy5E6n+PQhgzLgin50NPy6oAy2wj3D8y0RM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723046997;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=11EFsbnPxyKsf7C0lUvlu5OAIQuBwlJBo38EBnGl8NM=;
	b=DD6GQlZM74wIqHMdSHGvkxgpPDo8AariMILBPvvPTmBcqYnOGHynmXkB89eMcZ+n
	p6z2Qq2N6isSNJ+dxnX7K1LLtz5/nmq4WTO+mZ+Mlbd8hfgxLvoBSuvT4TG6ksEPE/u
	SuhMsP/2h+rnn46nUmOE+EbtEUsntyHfm17at28k=
Received: by mx.zohomail.com with SMTPS id 1723046995358371.2106901029101;
	Wed, 7 Aug 2024 09:09:55 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 3/3] drm/panfrost: Handle JD_REQ_CYCLE_COUNT
Date: Wed,  7 Aug 2024 18:08:59 +0200
Message-ID: <20240807160900.149154-4-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160900.149154-1-mary.guillemard@collabora.com>
References: <20240807160900.149154-1-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

If a job requires cycle counters or system timestamps propagation, we
must enable cycle counting before issuing a job and disable it right
after the job completes.

Since this extends the uAPI and because userland needs a way to advertise
features like VK_KHR_shader_clock conditionally, we bumps the driver
minor version.

Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c |  8 ++++++--
 drivers/gpu/drm/panfrost/panfrost_job.c | 10 ++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index d94c9bf5a7f9..fe983defdfdf 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -21,6 +21,8 @@
 #include "panfrost_gpu.h"
 #include "panfrost_perfcnt.h"
 
+#define JOB_REQUIREMENTS (PANFROST_JD_REQ_FS | PANFROST_JD_REQ_CYCLE_COUNT)
+
 static bool unstable_ioctls;
 module_param_unsafe(unstable_ioctls, bool, 0600);
 
@@ -262,7 +264,7 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 	if (!args->jc)
 		return -EINVAL;
 
-	if (args->requirements && args->requirements != PANFROST_JD_REQ_FS)
+	if (args->requirements && args->requirements & ~JOB_REQUIREMENTS)
 		return -EINVAL;
 
 	if (args->out_sync > 0) {
@@ -601,6 +603,8 @@ static const struct file_operations panfrost_drm_driver_fops = {
  * - 1.0 - initial interface
  * - 1.1 - adds HEAP and NOEXEC flags for CREATE_BO
  * - 1.2 - adds AFBC_FEATURES query
+ * - 1.3 - adds JD_REQ_CYCLE_COUNT job requirement for SUBMIT
+ *       - adds SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY queries
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
@@ -614,7 +618,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.desc			= "panfrost DRM",
 	.date			= "20180908",
 	.major			= 1,
-	.minor			= 2,
+	.minor			= 3,
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import_sg_table = panfrost_gem_prime_import_sg_table,
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index df49d37d0e7e..d8c215c0c672 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -159,6 +159,9 @@ panfrost_dequeue_job(struct panfrost_device *pfdev, int slot)
 	struct panfrost_job *job = pfdev->jobs[slot][0];
 
 	WARN_ON(!job);
+	if (job->requirements & PANFROST_JD_REQ_CYCLE_COUNT)
+		panfrost_cycle_counter_put(pfdev);
+
 	if (job->is_profiled) {
 		if (job->engine_usage) {
 			job->engine_usage->elapsed_ns[slot] +=
@@ -219,6 +222,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 
 	panfrost_job_write_affinity(pfdev, job->requirements, js);
 
+	if (job->requirements & PANFROST_JD_REQ_CYCLE_COUNT)
+		panfrost_cycle_counter_get(pfdev);
+
 	/* start MMU, medium priority, cache clean/flush on end, clean/flush on
 	 * start */
 	cfg |= JS_CONFIG_THREAD_PRI(8) |
@@ -693,8 +699,12 @@ panfrost_reset(struct panfrost_device *pfdev,
 	spin_lock(&pfdev->js->job_lock);
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		for (j = 0; j < ARRAY_SIZE(pfdev->jobs[0]) && pfdev->jobs[i][j]; j++) {
+			if (pfdev->jobs[i][j]->requirements & PANFROST_JD_REQ_CYCLE_COUNT)
+				panfrost_cycle_counter_put(pfdev);
+
 			if (pfdev->jobs[i][j]->is_profiled)
 				panfrost_cycle_counter_put(pfdev->jobs[i][j]->pfdev);
+
 			pm_runtime_put_noidle(pfdev->dev);
 			panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
 		}
-- 
2.45.2


