Return-Path: <linux-kernel+bounces-531432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F55CA4407D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E6E3BFFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F22690EC;
	Tue, 25 Feb 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9yBI0JH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C0268FFE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489225; cv=none; b=F2KIlKdOZP20OWb9x7HozndOv28kKuNKlpcDpqTniK82fFnIvQr0dauCrsrKfbj+WUDhQNxSeSmRYRGtggcZWiGiaDxvlXDTKtf+GoTY7pdzko67DsAwYVzT5VRvUvSdG0cKpaDII7PLt6vL92Gb9RtRxj5Xbvw+Q7xiwgxZ/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489225; c=relaxed/simple;
	bh=v3vhG6xQGzI0DMMzaxCeUJboG/v/IKUZbpAI+vrakSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLgarXKPnfAZwzE0wphSnZBgeBe0xp5bZtlOCC+l7puPKo2JV/obW1mEDO7uCE572cmHuHAqMnNn3H5JubGVT6SlShqx1OQ30RscQqgVx2b4pyAZfCP/iYtEEu2SbgrxKgtzB6RFoAVaHvKDQBL0azD0ydMD4m8r4dBFOBza5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9yBI0JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B25FC4CEDD;
	Tue, 25 Feb 2025 13:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740489224;
	bh=v3vhG6xQGzI0DMMzaxCeUJboG/v/IKUZbpAI+vrakSc=;
	h=From:To:Cc:Subject:Date:From;
	b=n9yBI0JHpqPrL18vMSJt9LxihAY3EpUZS2131sVvk/Qz4+j+k04lIwd20biHupHfo
	 hA/aUBQu79CLxPm+whsGJXqXSYU3a6p9HGIxSV+CvqPBsqQIe3t7pQCdJwE0bTt7rd
	 SxKKe0wzxips2uw6hpPwFiwNl9fJUUz3dtrw801T5Ct9v9gjg2T3JaLljDnGf09Fx+
	 QfsdskoQDL2Oue9PMnfKPUltRhyWfM2MmlerpOUbEu3QZHwxTUZF7hwHtzzxemmNOl
	 0frKpBpeHZZfC4lNCkXe8B0TyS1xcYHgGVnpReMBo4lAJVIdpko0yEGJkH8P3Dz4Bh
	 wp5U3X3/Ts4ig==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/sched: Fix outdated comments referencing thread
Date: Tue, 25 Feb 2025 14:13:32 +0100
Message-ID: <20250225131332.83415-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU scheduler's comments refer to a "thread" at various places.
Those are leftovers stemming from a rework in which the scheduler was
ported from using a kthread to workqueues.

Replace all references to kthreads.

Fixes: a6149f039369 ("drm/sched: Convert drm scheduler to use a work queue rather than kthread")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c |  8 ++++----
 drivers/gpu/drm/scheduler/sched_main.c   | 21 +++++++++++----------
 include/drm/gpu_scheduler.h              | 12 ++++++------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 87f88259ddf6..f9811420c787 100644
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
index c634993f1346..015ee327fe52 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -389,7 +389,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
  *
- * Finish the job's fence and wake up the worker thread.
+ * Finish the job's fence and wake up the work item.
  */
 static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
 {
@@ -550,8 +550,8 @@ static void drm_sched_job_timedout(struct work_struct *work)
 	if (job) {
 		/*
 		 * Remove the bad job so it cannot be freed by concurrent
-		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
-		 * is parked at which point it's safe.
+		 * drm_sched_cleanup_jobs. It will be reinserted back after the
+		 * scheduler's workqueues are stopped at which point it's safe.
 		 */
 		list_del_init(&job->list);
 		spin_unlock(&sched->job_list_lock);
@@ -597,10 +597,10 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 
 	/*
 	 * Reinsert back the bad job here - now it's safe as
-	 * drm_sched_get_finished_job cannot race against us and release the
+	 * drm_sched_get_finished_job() cannot race against us and release the
 	 * bad job at this point - we parked (waited for) any in progress
-	 * (earlier) cleanups and drm_sched_get_finished_job will not be called
-	 * now until the scheduler thread is unparked.
+	 * (earlier) cleanups and drm_sched_get_finished_job() will not be
+	 * called now until the scheduler's workqueues are unparked.
 	 */
 	if (bad && bad->sched == sched)
 		/*
@@ -613,7 +613,8 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 	 * Iterate the job list from later to  earlier one and either deactive
 	 * their HW callbacks or remove them from pending list if they already
 	 * signaled.
-	 * This iteration is thread safe as sched thread is stopped.
+	 * This iteration is thread safe as the scheduler's workqueues are
+	 * stopped.
 	 */
 	list_for_each_entry_safe_reverse(s_job, tmp, &sched->pending_list,
 					 list) {
@@ -678,9 +679,9 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, int errno)
 	struct drm_sched_job *s_job, *tmp;
 
 	/*
-	 * Locking the list is not required here as the sched thread is parked
-	 * so no new jobs are being inserted or removed. Also concurrent
-	 * GPU recovers can't run in parallel.
+	 * Locking the list is not required here as the scheduler's workqueues
+	 * are paused, so no new jobs are being inserted or removed. Also
+	 * concurrent GPU recovers can't run in parallel.
 	 */
 	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
 		struct dma_fence *fence = s_job->s_fence->parent;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 50928a7ae98e..7da7b0b52a7e 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -192,8 +192,8 @@ struct drm_sched_entity {
 	 * @last_scheduled:
 	 *
 	 * Points to the finished fence of the last scheduled job. Only written
-	 * by the scheduler thread, can be accessed locklessly from
-	 * drm_sched_job_arm() if the queue is empty.
+	 * by &struct drm_gpu_scheduler.submit_wq. Can be accessed locklessly
+	 * from drm_sched_job_arm() if the queue is empty.
 	 */
 	struct dma_fence __rcu		*last_scheduled;
 
@@ -426,14 +426,14 @@ struct drm_sched_backend_ops {
 	 * Drivers typically issue a reset to recover from GPU hangs, and this
 	 * procedure usually follows the following workflow:
 	 *
-	 * 1. Stop the scheduler using drm_sched_stop(). This will park the
-	 *    scheduler thread and cancel the timeout work, guaranteeing that
-	 *    nothing is queued while we reset the hardware queue
+	 * 1. Stop the scheduler using drm_sched_stop(). This will stop the
+	 *    scheduler's workqueues and cancel the timeout work, guaranteeing
+	 *    that  nothing is queued while we reset the hardware queue
 	 * 2. Try to gracefully stop non-faulty jobs (optional)
 	 * 3. Issue a GPU reset (driver-specific)
 	 * 4. Re-submit jobs using drm_sched_resubmit_jobs()
 	 * 5. Restart the scheduler using drm_sched_start(). At that point, new
-	 *    jobs can be queued, and the scheduler thread is unblocked
+	 *    jobs can be queued, and the scheduler's workqueues be started again.
 	 *
 	 * Note that some GPUs have distinct hardware queues but need to reset
 	 * the GPU globally, which requires extra synchronization between the
-- 
2.48.1


