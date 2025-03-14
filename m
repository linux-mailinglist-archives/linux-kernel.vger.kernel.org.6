Return-Path: <linux-kernel+bounces-561178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C0A60E56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B53F3B351C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4981F418E;
	Fri, 14 Mar 2025 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZEsz4Hm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D11F3FF1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947065; cv=none; b=lzThcYLP2CdXRMhdtZ7ktCAfCX2N4rtJK9j8FvTYPy5PWA3F0MPi6HrZpCg0ZonlXeHzFv2e+Ka74/LCedNrEC4Ym9GldzDzTWyz/x35OP6XALW0KSMKLRC7DcfZRBR9yNv7occ05FsAT01mwD3Cl6YlC90SN35fOsGkJFz+9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947065; c=relaxed/simple;
	bh=o9ZTDiWOwXVSnaEoWbLhRGBffUva+c1LJjT5za8v/Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DcXvwxstSFMnn1S2N2SCuS7LT6KnjK8vDImFJB/sn5lq/wInH0JBtEyUkZbCMGzU3OEYyz2eNFK8DwVy1krQkve8C8rk6FANY8L9UJ2eeSlwjGq9PDRpqQtMmRHhOdSS7oTy34WUGJPNrp5NddW8P3Wi1zg9bdABY5sfLExPu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZEsz4Hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADC3C4CEE3;
	Fri, 14 Mar 2025 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741947064;
	bh=o9ZTDiWOwXVSnaEoWbLhRGBffUva+c1LJjT5za8v/Tw=;
	h=From:To:Cc:Subject:Date:From;
	b=NZEsz4HmIi/nKDi5l2KzxRWHXfO03OXg7v8xmix2ljScqv0XXM9nkawcvvIuvLhzY
	 r2OOunq90yggnANXyvmhmaAQ37LvnnxlW4INpAFg9Sbd0m3NnrpcoAhIXTyvcyZ05F
	 yd1Lghq1o+rNHdh/93Of1wUc0FWzR9S46Tuhwh3VOA7hVJO2tK+61kKfciGS4XzWPP
	 jTapPzb95rXFcAuJc2hpB8n1xGyq3J/RGPdP+Jov9l8W5gqJE5hJsPkNqqKbDdyPrD
	 cVxntuV7RUHMDTtteQlPddl8OY6IREprYnezpTPvAmzd9KKYJs1BbyIdlxrUioKAMh
	 rJjijHrZLJEsg==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 1/2] drm/sched: Fix outdated comments referencing thread
Date: Fri, 14 Mar 2025 11:10:23 +0100
Message-ID: <20250314101023.111248-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU scheduler's comments refer to a "thread" at various places.
Those are leftovers from commit a6149f039369 ("drm/sched: Convert drm
scheduler to use a work queue rather than kthread").

Replace all references to kthreads.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
Changes in v3:
  - Turns out I had to rebase for drm-misc-next because we changed the
    docu for timedout_job() there. I simply dropped the redundant docu
    change from this patch.
    Sending v3 for transparency.
---
 drivers/gpu/drm/scheduler/sched_entity.c |  8 ++++----
 drivers/gpu/drm/scheduler/sched_main.c   | 24 +++++++++++++-----------
 include/drm/gpu_scheduler.h              |  2 +-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index a6d2a4722d82..74a72c0a9c0a 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -538,10 +538,10 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		return;
 
 	/*
-	 * Only when the queue is empty are we guaranteed that the scheduler
-	 * thread cannot change ->last_scheduled. To enforce ordering we need
-	 * a read barrier here. See drm_sched_entity_pop_job() for the other
-	 * side.
+	 * Only when the queue is empty are we guaranteed that
+	 * drm_sched_run_job_work() cannot change entity->last_scheduled. To
+	 * enforce ordering we need a read barrier here. See
+	 * drm_sched_entity_pop_job() for the other side.
 	 */
 	smp_rmb();
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 829579c41c6b..f7118497e47a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -391,7 +391,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
  *
- * Finish the job's fence and wake up the worker thread.
+ * Finish the job's fence and resubmit the work items.
  */
 static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
 {
@@ -551,9 +551,10 @@ static void drm_sched_job_timedout(struct work_struct *work)
 
 	if (job) {
 		/*
-		 * Remove the bad job so it cannot be freed by concurrent
-		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
-		 * is parked at which point it's safe.
+		 * Remove the bad job so it cannot be freed by a concurrent
+		 * &struct drm_sched_backend_ops.free_job. It will be
+		 * reinserted after the scheduler's work items have been
+		 * cancelled, at which point it's safe.
 		 */
 		list_del_init(&job->list);
 		spin_unlock(&sched->job_list_lock);
@@ -599,10 +600,10 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 
 	/*
 	 * Reinsert back the bad job here - now it's safe as
-	 * drm_sched_get_finished_job cannot race against us and release the
+	 * drm_sched_get_finished_job() cannot race against us and release the
 	 * bad job at this point - we parked (waited for) any in progress
-	 * (earlier) cleanups and drm_sched_get_finished_job will not be called
-	 * now until the scheduler thread is unparked.
+	 * (earlier) cleanups and drm_sched_get_finished_job() will not be
+	 * called now until the scheduler's work items are submitted again.
 	 */
 	if (bad && bad->sched == sched)
 		/*
@@ -615,7 +616,8 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 	 * Iterate the job list from later to  earlier one and either deactive
 	 * their HW callbacks or remove them from pending list if they already
 	 * signaled.
-	 * This iteration is thread safe as sched thread is stopped.
+	 * This iteration is thread safe as the scheduler's work items have been
+	 * cancelled.
 	 */
 	list_for_each_entry_safe_reverse(s_job, tmp, &sched->pending_list,
 					 list) {
@@ -680,9 +682,9 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, int errno)
 	struct drm_sched_job *s_job, *tmp;
 
 	/*
-	 * Locking the list is not required here as the sched thread is parked
-	 * so no new jobs are being inserted or removed. Also concurrent
-	 * GPU recovers can't run in parallel.
+	 * Locking the list is not required here as the scheduler's work items
+	 * are currently not running, so no new jobs are being inserted or
+	 * removed. Also concurrent GPU recovers can't run in parallel.
 	 */
 	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
 		struct dma_fence *fence = s_job->s_fence->parent;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 1a7e377d4cbb..d860db087ea5 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -192,7 +192,7 @@ struct drm_sched_entity {
 	 * @last_scheduled:
 	 *
 	 * Points to the finished fence of the last scheduled job. Only written
-	 * by the scheduler thread, can be accessed locklessly from
+	 * by drm_sched_entity_pop_job(). Can be accessed locklessly from
 	 * drm_sched_job_arm() if the queue is empty.
 	 */
 	struct dma_fence __rcu		*last_scheduled;
-- 
2.48.1


