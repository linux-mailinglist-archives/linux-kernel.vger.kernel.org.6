Return-Path: <linux-kernel+bounces-542101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD5A4C5A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3319B3A5469
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872412135B8;
	Mon,  3 Mar 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iphoS7GP"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4413D8A4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016924; cv=none; b=Cy1cxRosP88eMz8AGAkwgO1pmbybtoZgld0mEKLvBWLOEjHKBlcHonwcKCJxKzG3MIk+44nkcXP1Bb7S6EflEVT2VvYkbQ3cEsB74c0xUrYM8umOmJIIuYncHOodv3nX3VZwHJS5tQrncMc9J6/QxT79+7gNhxQeUJLer4gzXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016924; c=relaxed/simple;
	bh=yeSxlzRnv6GZ6LRCIdGY0ZSZzbOvn9sl2blVbn74LoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScNHFPcPNpyxUnLIFPXrFA8lsQoQDpCazfT/AowHQFOyulhOff0ajSQSjVulHKrPTA4cB89dPNvzy508O8GdMboxwZA4/MB6g52YW381Cw+Z3QbyyMEGKQJBabu/ffC66Wx0R84jlXRV7ysCjkmxFhjz3dZp3fXYyBqqVUDA7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iphoS7GP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z63Bb37RWz9sSk;
	Mon,  3 Mar 2025 16:48:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741016919; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1r3vVyElBlgvj9GdjtyX2ZKt6wEv7bHSFf8LmpnhPDk=;
	b=iphoS7GPrjxUVgnP7DDcpxHtCeqmCvwVSnrtuCmtzleWbeyjKZjHF2HiaLchd+1eYz4Lje
	rOLkRBUEhFvUkny9eL1H87i0272GrR5S31jrnWcz7TmnOmfcJ61w3wB5FkM+PTm4yAsnVw
	taWarFv5NWXphbAw7kGCK6czPVJ+ScBz8r7g/C2TKlRoQopHlSIubFjFeuTG0uNc8Laq+v
	JRTQdjvPi0vPIPX68bB9V59HMBfHwRAMwp7V/instL+6WiRfoS7q5NdUBBHsKCyRhyjYsB
	3hV/KIO6Ism2bWsa6LiEuj/+rpwLS5I0ORYTN8jAXr4GPvY+uYlDlZMHmdEFWg==
Message-ID: <d7308a0c8ea0fa95f0d4a93364e72e4a1eb15587.camel@mailbox.org>
Subject: Re: [PATCH 1/2] drm/sched: Fix outdated comments referencing thread
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 03 Mar 2025 16:48:36 +0100
In-Reply-To: <Z73LVBw7HXANVbHQ@cassiopeiae>
References: <20250225131332.83415-2-phasta@kernel.org>
	 <Z73LVBw7HXANVbHQ@cassiopeiae>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: dbe88d94682c9872b74
X-MBO-RS-META: 84bta3t4ko616qzjxstqpgirq9513z8u

On Tue, 2025-02-25 at 14:53 +0100, Danilo Krummrich wrote:
> On Tue, Feb 25, 2025 at 02:13:32PM +0100, Philipp Stanner wrote:
> > The GPU scheduler's comments refer to a "thread" at various places.
> > Those are leftovers stemming from a rework in which the scheduler
> > was
>=20
> Maybe "leftovers from commit a6149f039369 ("drm/sched: Convert drm
> scheduler to
> use a work queue rather than kthread") [...]".
>=20
> > ported from using a kthread to workqueues.
> >=20
> > Replace all references to kthreads.
> >=20
> > Fixes: a6149f039369 ("drm/sched: Convert drm scheduler to use a
> > work queue rather than kthread")
>=20
> I suggest to drop the 'Fixes' tag, it's not a fix in the sense of
> this tag.
>=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_entity.c |=C2=A0 8 ++++----
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0 | 21 +++++++++=
++---------
> > -
> > =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++------
> > =C2=A03 files changed, 21 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > b/drivers/gpu/drm/scheduler/sched_entity.c
> > index 87f88259ddf6..f9811420c787 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -538,10 +538,10 @@ void drm_sched_entity_select_rq(struct
> > drm_sched_entity *entity)
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	/*
> > -	 * Only when the queue is empty are we guaranteed that the
> > scheduler
> > -	 * thread cannot change ->last_scheduled. To enforce
> > ordering we need
> > -	 * a read barrier here. See drm_sched_entity_pop_job() for
> > the other
> > -	 * side.
> > +	 * Only when the queue is empty are we guaranteed that
> > +	 * drm_sched_run_job_work() cannot change entity-
> > >last_scheduled. To
> > +	 * enforce ordering we need a read barrier here. See
> > +	 * drm_sched_entity_pop_job() for the other side.
> > =C2=A0	 */
> > =C2=A0	smp_rmb();
> > =C2=A0
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index c634993f1346..015ee327fe52 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -389,7 +389,7 @@ static void drm_sched_run_free_queue(struct
> > drm_gpu_scheduler *sched)
> > =C2=A0 * drm_sched_job_done - complete a job
> > =C2=A0 * @s_job: pointer to the job which is done
> > =C2=A0 *
> > - * Finish the job's fence and wake up the worker thread.
> > + * Finish the job's fence and wake up the work item.
> > =C2=A0 */
> > =C2=A0static void drm_sched_job_done(struct drm_sched_job *s_job, int
> > result)
> > =C2=A0{
> > @@ -550,8 +550,8 @@ static void drm_sched_job_timedout(struct
> > work_struct *work)
> > =C2=A0	if (job) {
> > =C2=A0		/*
> > =C2=A0		 * Remove the bad job so it cannot be freed by
> > concurrent
> > -		 * drm_sched_cleanup_jobs. It will be reinserted
> > back after sched->thread
>=20
> Not related to your patch, but I assume this means "cannot be freed
> by
> concurrent calls to drm_sched_job_cleanup()", which would still be
> incorrect,
> since drm_sched_job_cleanup() doesn't free the job itself. Maybe you
> want to fix
> this as well?
>=20
> > -		 * is parked at which point it's safe.
> > +		 * drm_sched_cleanup_jobs. It will be reinserted
> > back after the
> > +		 * scheduler's workqueues are stopped at which
> > point it's safe.
>=20
> You don't know whether the workqueues are "stopped". I think you want
> to say
> that run_job / free_job work isn't scheduled or running.

How about "after the scheduler's work items have been cancelled"?

P.

>=20
> Same for a couple more instances below.
>=20
> > =C2=A0		 */
> > =C2=A0		list_del_init(&job->list);
> > =C2=A0		spin_unlock(&sched->job_list_lock);
> > @@ -597,10 +597,10 @@ void drm_sched_stop(struct drm_gpu_scheduler
> > *sched, struct drm_sched_job *bad)
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * Reinsert back the bad job here - now it's safe as
> > -	 * drm_sched_get_finished_job cannot race against us and
> > release the
> > +	 * drm_sched_get_finished_job() cannot race against us and
> > release the
>=20
> Not related to the patch, but fine for me, since you do it for
> consistency with
> the change below.
>=20
> > =C2=A0	 * bad job at this point - we parked (waited for) any in
> > progress
> > -	 * (earlier) cleanups and drm_sched_get_finished_job will
> > not be called
> > -	 * now until the scheduler thread is unparked.
> > +	 * (earlier) cleanups and drm_sched_get_finished_job()
> > will not be
> > +	 * called now until the scheduler's workqueues are
> > unparked.
>=20
> workqueues are unparked?
>=20
> > =C2=A0	 */
> > =C2=A0	if (bad && bad->sched =3D=3D sched)
> > =C2=A0		/*
> > @@ -613,7 +613,8 @@ void drm_sched_stop(struct drm_gpu_scheduler
> > *sched, struct drm_sched_job *bad)
> > =C2=A0	 * Iterate the job list from later to=C2=A0 earlier one and
> > either deactive
> > =C2=A0	 * their HW callbacks or remove them from pending list if
> > they already
> > =C2=A0	 * signaled.
> > -	 * This iteration is thread safe as sched thread is
> > stopped.
> > +	 * This iteration is thread safe as the scheduler's
> > workqueues are
> > +	 * stopped.
> > =C2=A0	 */
> > =C2=A0	list_for_each_entry_safe_reverse(s_job, tmp, &sched-
> > >pending_list,
> > =C2=A0					 list) {
> > @@ -678,9 +679,9 @@ void drm_sched_start(struct drm_gpu_scheduler
> > *sched, int errno)
> > =C2=A0	struct drm_sched_job *s_job, *tmp;
> > =C2=A0
> > =C2=A0	/*
> > -	 * Locking the list is not required here as the sched
> > thread is parked
> > -	 * so no new jobs are being inserted or removed. Also
> > concurrent
> > -	 * GPU recovers can't run in parallel.
> > +	 * Locking the list is not required here as the
> > scheduler's workqueues
> > +	 * are paused, so no new jobs are being inserted or
> > removed. Also
> > +	 * concurrent GPU recovers can't run in parallel.
> > =C2=A0	 */
> > =C2=A0	list_for_each_entry_safe(s_job, tmp, &sched->pending_list,
> > list) {
> > =C2=A0		struct dma_fence *fence =3D s_job->s_fence->parent;
> > diff --git a/include/drm/gpu_scheduler.h
> > b/include/drm/gpu_scheduler.h
> > index 50928a7ae98e..7da7b0b52a7e 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -192,8 +192,8 @@ struct drm_sched_entity {
> > =C2=A0	 * @last_scheduled:
> > =C2=A0	 *
> > =C2=A0	 * Points to the finished fence of the last scheduled job.
> > Only written
> > -	 * by the scheduler thread, can be accessed locklessly
> > from
> > -	 * drm_sched_job_arm() if the queue is empty.
> > +	 * by &struct drm_gpu_scheduler.submit_wq. Can be accessed
> > locklessly
> > +	 * from drm_sched_job_arm() if the queue is empty.
> > =C2=A0	 */
> > =C2=A0	struct dma_fence __rcu		*last_scheduled;
> > =C2=A0
> > @@ -426,14 +426,14 @@ struct drm_sched_backend_ops {
> > =C2=A0	 * Drivers typically issue a reset to recover from GPU
> > hangs, and this
> > =C2=A0	 * procedure usually follows the following workflow:
> > =C2=A0	 *
> > -	 * 1. Stop the scheduler using drm_sched_stop(). This will
> > park the
> > -	 *=C2=A0=C2=A0=C2=A0 scheduler thread and cancel the timeout work,
> > guaranteeing that
> > -	 *=C2=A0=C2=A0=C2=A0 nothing is queued while we reset the hardware qu=
eue
> > +	 * 1. Stop the scheduler using drm_sched_stop(). This will
> > stop the
> > +	 *=C2=A0=C2=A0=C2=A0 scheduler's workqueues and cancel the timeout wo=
rk,
> > guaranteeing
> > +	 *=C2=A0=C2=A0=C2=A0 that=C2=A0 nothing is queued while we reset the =
hardware
> > queue
> > =C2=A0	 * 2. Try to gracefully stop non-faulty jobs (optional)
> > =C2=A0	 * 3. Issue a GPU reset (driver-specific)
> > =C2=A0	 * 4. Re-submit jobs using drm_sched_resubmit_jobs()
> > =C2=A0	 * 5. Restart the scheduler using drm_sched_start(). At
> > that point, new
> > -	 *=C2=A0=C2=A0=C2=A0 jobs can be queued, and the scheduler thread is
> > unblocked
> > +	 *=C2=A0=C2=A0=C2=A0 jobs can be queued, and the scheduler's workqueu=
es
> > be started again.
> > =C2=A0	 *
> > =C2=A0	 * Note that some GPUs have distinct hardware queues but
> > need to reset
> > =C2=A0	 * the GPU globally, which requires extra synchronization
> > between the
> > --=20
> > 2.48.1
> >=20


