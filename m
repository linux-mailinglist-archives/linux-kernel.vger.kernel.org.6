Return-Path: <linux-kernel+bounces-559100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB0A5EF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E4C7A2E38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CC263C8A;
	Thu, 13 Mar 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B6u3mwIq"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAB2C80
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858082; cv=none; b=Tj9zkq75ElXOiKW9FT9OQJGBSInTJ+fCrnoRsvpl432EHx4Rr00cI+Tk8TleKzBQsxivbvx38uCnJfKIhR8a8xPkiQmgolFkso308+C0CmN6w+wHq7xc+3Z0BYSF4UWl2aiPUNzElYmr1cGltIGen3DRzrj3m1q1CTekkumsC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858082; c=relaxed/simple;
	bh=ZDstxwadDGSsYJzbCnuFa1I2f+aY774IELqLSpmCW4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nt+3n+HY/DR44NeR/6SjYhHedFJfJiwvSgfcgJno52fFlWTG8Rp63fFmBQRSu3lEI7r1SzPxEJlJqRGfp77wXs/Aw8b/oYEDxnBYBkgP/rjV80DFOlnuUvMRUqEW2WC7hwQ2dlYLrHt7HJtr3eLnv8Z48Dc5q5kOaE+4B/uI4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=B6u3mwIq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZD2Gg4C4Mz9tC9;
	Thu, 13 Mar 2025 10:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741858075; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/owROof6/yHp68LMof7mxfwygclLpA+nvxOoWveVXo4=;
	b=B6u3mwIq9Y6Vj6JMepIiz7/6Hvf3CgbwVkjQddiw0b6AOBHtMqwAtL1W1HjESJO9RBYMc6
	BynoAH9GegVixpmgX5pd033JXcea/kMZhBQTXm1mD2A0G87LHAV6wo94pqY8WGLQnrDNAR
	IQh8hCH3Lhl+LvMVqcI6/qGAC1ulteRDfF4Rb8Jsui67GTq7YcdVF/LHKAlxwIfSYwHEOb
	gMNIyieDqu4EQxKYxzxy700umdwbvMtND+C82y4uZE7L9bhdAHXWY4IGRaf+wtyzkn8D8G
	GQFbeIdPZLgp0wn2yO1VJIBW1zTP7q7F04gMdY+6CvAzDCkqdIUkXFWkqzez7g==
Message-ID: <06caacae8982b94c7668f4e9ca5c6b5f9940545e.camel@mailbox.org>
Subject: Re: [PATCH v2 1/2] drm/sched: Fix outdated comments referencing
 thread
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>
Date: Thu, 13 Mar 2025 10:27:48 +0100
In-Reply-To: <20250305155326.153596-2-phasta@kernel.org>
References: <20250305155326.153596-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 92f1d7acb4720b5950a
X-MBO-RS-META: 5g6xn87u3765hzm845omxwh44pgkbiur

On Wed, 2025-03-05 at 16:53 +0100, Philipp Stanner wrote:
> The GPU scheduler's comments refer to a "thread" at various places.
> Those are leftovers from commit a6149f039369 ("drm/sched: Convert drm
> scheduler to use a work queue rather than kthread").
>=20
> Replace all references to kthreads.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Changes in v2:
> =C2=A0 - Speak consistently about work items. (Danilo)
> =C2=A0 - Remove Fixes: tags. (Danilo)

Can someone review this series pls?

thx
P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c |=C2=A0 8 ++++----
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0 | 24 +++++++++++=
++---------
> --
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++-----
> =C2=A03 files changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index 87f88259ddf6..f9811420c787 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -538,10 +538,10 @@ void drm_sched_entity_select_rq(struct
> drm_sched_entity *entity)
> =C2=A0		return;
> =C2=A0
> =C2=A0	/*
> -	 * Only when the queue is empty are we guaranteed that the
> scheduler
> -	 * thread cannot change ->last_scheduled. To enforce
> ordering we need
> -	 * a read barrier here. See drm_sched_entity_pop_job() for
> the other
> -	 * side.
> +	 * Only when the queue is empty are we guaranteed that
> +	 * drm_sched_run_job_work() cannot change entity-
> >last_scheduled. To
> +	 * enforce ordering we need a read barrier here. See
> +	 * drm_sched_entity_pop_job() for the other side.
> =C2=A0	 */
> =C2=A0	smp_rmb();
> =C2=A0
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index c634993f1346..c97655aa7ab4 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -389,7 +389,7 @@ static void drm_sched_run_free_queue(struct
> drm_gpu_scheduler *sched)
> =C2=A0 * drm_sched_job_done - complete a job
> =C2=A0 * @s_job: pointer to the job which is done
> =C2=A0 *
> - * Finish the job's fence and wake up the worker thread.
> + * Finish the job's fence and resubmit the work items.
> =C2=A0 */
> =C2=A0static void drm_sched_job_done(struct drm_sched_job *s_job, int
> result)
> =C2=A0{
> @@ -549,9 +549,10 @@ static void drm_sched_job_timedout(struct
> work_struct *work)
> =C2=A0
> =C2=A0	if (job) {
> =C2=A0		/*
> -		 * Remove the bad job so it cannot be freed by
> concurrent
> -		 * drm_sched_cleanup_jobs. It will be reinserted
> back after sched->thread
> -		 * is parked at which point it's safe.
> +		 * Remove the bad job so it cannot be freed by a
> concurrent
> +		 * &struct drm_sched_backend_ops.free_job. It will
> be
> +		 * reinserted after the scheduler's work items have
> been
> +		 * cancelled, at which point it's safe.
> =C2=A0		 */
> =C2=A0		list_del_init(&job->list);
> =C2=A0		spin_unlock(&sched->job_list_lock);
> @@ -597,10 +598,10 @@ void drm_sched_stop(struct drm_gpu_scheduler
> *sched, struct drm_sched_job *bad)
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Reinsert back the bad job here - now it's safe as
> -	 * drm_sched_get_finished_job cannot race against us and
> release the
> +	 * drm_sched_get_finished_job() cannot race against us and
> release the
> =C2=A0	 * bad job at this point - we parked (waited for) any in
> progress
> -	 * (earlier) cleanups and drm_sched_get_finished_job will
> not be called
> -	 * now until the scheduler thread is unparked.
> +	 * (earlier) cleanups and drm_sched_get_finished_job() will
> not be
> +	 * called now until the scheduler's work items are submitted
> again.
> =C2=A0	 */
> =C2=A0	if (bad && bad->sched =3D=3D sched)
> =C2=A0		/*
> @@ -613,7 +614,8 @@ void drm_sched_stop(struct drm_gpu_scheduler
> *sched, struct drm_sched_job *bad)
> =C2=A0	 * Iterate the job list from later to=C2=A0 earlier one and
> either deactive
> =C2=A0	 * their HW callbacks or remove them from pending list if
> they already
> =C2=A0	 * signaled.
> -	 * This iteration is thread safe as sched thread is stopped.
> +	 * This iteration is thread safe as the scheduler's work
> items have been
> +	 * cancelled.
> =C2=A0	 */
> =C2=A0	list_for_each_entry_safe_reverse(s_job, tmp, &sched-
> >pending_list,
> =C2=A0					 list) {
> @@ -678,9 +680,9 @@ void drm_sched_start(struct drm_gpu_scheduler
> *sched, int errno)
> =C2=A0	struct drm_sched_job *s_job, *tmp;
> =C2=A0
> =C2=A0	/*
> -	 * Locking the list is not required here as the sched thread
> is parked
> -	 * so no new jobs are being inserted or removed. Also
> concurrent
> -	 * GPU recovers can't run in parallel.
> +	 * Locking the list is not required here as the scheduler's
> work items
> +	 * are currently not running, so no new jobs are being
> inserted or
> +	 * removed. Also concurrent GPU recovers can't run in
> parallel.
> =C2=A0	 */
> =C2=A0	list_for_each_entry_safe(s_job, tmp, &sched->pending_list,
> list) {
> =C2=A0		struct dma_fence *fence =3D s_job->s_fence->parent;
> diff --git a/include/drm/gpu_scheduler.h
> b/include/drm/gpu_scheduler.h
> index 50928a7ae98e..d8bfd46c1117 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -192,7 +192,7 @@ struct drm_sched_entity {
> =C2=A0	 * @last_scheduled:
> =C2=A0	 *
> =C2=A0	 * Points to the finished fence of the last scheduled job.
> Only written
> -	 * by the scheduler thread, can be accessed locklessly from
> +	 * by drm_sched_entity_pop_job(). Can be accessed locklessly
> from
> =C2=A0	 * drm_sched_job_arm() if the queue is empty.
> =C2=A0	 */
> =C2=A0	struct dma_fence __rcu		*last_scheduled;
> @@ -426,14 +426,14 @@ struct drm_sched_backend_ops {
> =C2=A0	 * Drivers typically issue a reset to recover from GPU
> hangs, and this
> =C2=A0	 * procedure usually follows the following workflow:
> =C2=A0	 *
> -	 * 1. Stop the scheduler using drm_sched_stop(). This will
> park the
> -	 *=C2=A0=C2=A0=C2=A0 scheduler thread and cancel the timeout work,
> guaranteeing that
> -	 *=C2=A0=C2=A0=C2=A0 nothing is queued while we reset the hardware queu=
e
> +	 * 1. Stop the scheduler using drm_sched_stop(). This will
> cancel the
> +	 *=C2=A0=C2=A0=C2=A0 scheduler's work items, guaranteeing that nothing =
is
> queued while
> +	 *=C2=A0=C2=A0=C2=A0 we reset the hardware queue.
> =C2=A0	 * 2. Try to gracefully stop non-faulty jobs (optional)
> =C2=A0	 * 3. Issue a GPU reset (driver-specific)
> =C2=A0	 * 4. Re-submit jobs using drm_sched_resubmit_jobs()
> =C2=A0	 * 5. Restart the scheduler using drm_sched_start(). At that
> point, new
> -	 *=C2=A0=C2=A0=C2=A0 jobs can be queued, and the scheduler thread is
> unblocked
> +	 *=C2=A0=C2=A0=C2=A0 jobs can be queued, and the scheduler's work items=
 are
> resubmitted.
> =C2=A0	 *
> =C2=A0	 * Note that some GPUs have distinct hardware queues but
> need to reset
> =C2=A0	 * the GPU globally, which requires extra synchronization
> between the


