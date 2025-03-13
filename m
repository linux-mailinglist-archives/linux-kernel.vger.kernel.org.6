Return-Path: <linux-kernel+bounces-559218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F9A5F100
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C70217D379
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD431F0E21;
	Thu, 13 Mar 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kH7PQNm8"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1D16BE17
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862083; cv=none; b=K+jbDkD0uK1uxT8OZE3SS8Vb7NfBQ29u3ZvYUH/xvl/6japVk/shuyJjBD+suV/I9rXrUYyfgH3312//iUygu4WDwm2WaqscGIG9ckjS6OlcSJTfDK0x+6PZh8blQPKErwfjazMfv2nWaC4pP7RPq/4NEnK9PfT2aLEzv7KGPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862083; c=relaxed/simple;
	bh=dWrZK2Che0Oj1K8eXjyyR/nMtqhjsvb9o7XC/B4TG1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k5aFFj7pHHb/ifQjAiOIRw/YznKQesGFidBqVhJRqjIk7J7BmY9mgHiz3b2O8OYhQ2Iv3FriXaYVqWdoNiXelVdGX1Isgt0kxmi3l8/QQ+uhUZDSsF84lFHozc+t362iJiD8NK6d/Y9i7fBayq2A1xSPw1rD5iFuMLi6p/qsDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kH7PQNm8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZD3ZL61Ldz9shm;
	Thu, 13 Mar 2025 11:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741861594; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3/0fiTphVhNpO3GO8VF4Utcp8LrQmjfthlEnqhlIL0=;
	b=kH7PQNm8X1ch8L7/Af0/YNi0ikA6/yuC013LCL7FrgV/82/etT3kX8PA5Ap0iAH+gU+vT5
	ThtX4gyhEVIf4sbzhJDSUgnhwb0ZS6vBiMX4qhUTlLSccRxEq1hGJKq4HBxc89f7GvY3en
	fjq2mH7QK9qzB88pmix90amH6hmErm81ToQA/+2C9WRHN9TwzUz8xWIQhZZwn2pXCHL0WF
	1iGywYo1QnYhXcFUhkF+DVT86gpLJ1wuUFbAmxgqMFuV5JxVRQiOJRutc7xVJUvFJtbj+J
	h2E2yp8ZitbbebU4gO/QpH6HRkwMNost6yaOO5yUyOYLBRpikkMxBkb+eAfcDg==
Message-ID: <db82a8a37e548f7c893c999bb476551c6793b411.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Clarify docu concerning drm_sched_job_arm()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2025 11:26:30 +0100
In-Reply-To: <d02a205a-c7e7-45a5-bcba-b5a5a6bebf4e@amd.com>
References: <20250313093053.65001-2-phasta@kernel.org>
	 <d02a205a-c7e7-45a5-bcba-b5a5a6bebf4e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: dufrggazb1dtq9n4wp46d3dgp4wc13eh
X-MBO-RS-ID: b4c9879f8d01a5ce94b

On Thu, 2025-03-13 at 11:07 +0100, Christian K=C3=B6nig wrote:
> Am 13.03.25 um 10:30 schrieb Philipp Stanner:
> > The documentation for drm_sched_job_arm() and especially
> > drm_sched_job_cleanup() does not make it very clear why
> > drm_sched_job_arm() is a point of no return, which it indeed is.
> >=20
> > Make the nature of drm_sched_job_arm() in the docu as clear as
> > possible.
> >=20
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thx

>=20
> I'm currently looking into how to fix the amdgpu CS path for gang
> submission regarding this.
>=20
> Any objections that I add a preload function to allocate the memory
> for the XA outside of the critical section?

I can't fully follow, you mean when creating the dependencies xarray?

I think in a perfect world we wouldn't have any more functions that
only have 1 user to work around driver-internal problems. That said, I
realize that the world isn't perfect. Would still be cool if every
function we add would be useful to >1 driver.

I think it's probably best if you just propose sth in form of a patch
and we discuss it there

Gr=C3=BC=C3=9Fe
P.


>=20
> Regards,
> Christian.
>=20
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 24 ++++++++++++++++++---=
-
> > --
> > =C2=A01 file changed, 18 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index 4d4219fbe49d..829579c41c6b 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -828,11 +828,15 @@ EXPORT_SYMBOL(drm_sched_job_init);
> > =C2=A0 *
> > =C2=A0 * This arms a scheduler job for execution. Specifically it
> > initializes the
> > =C2=A0 * &drm_sched_job.s_fence of @job, so that it can be attached to
> > struct dma_resv
> > - * or other places that need to track the completion of this job.
> > + * or other places that need to track the completion of this job.
> > It also
> > + * initializes sequence numbers, which are fundamental for fence
> > ordering.
> > =C2=A0 *
> > =C2=A0 * Refer to drm_sched_entity_push_job() documentation for locking
> > =C2=A0 * considerations.
> > =C2=A0 *
> > + * Once this function was called, you *must* submit @job with
> > + * drm_sched_entity_push_job().
> > + *
> > =C2=A0 * This can only be called if drm_sched_job_init() succeeded.
> > =C2=A0 */
> > =C2=A0void drm_sched_job_arm(struct drm_sched_job *job)
> > @@ -1017,9 +1021,12 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
> > =C2=A0 * Drivers should call this from their error unwind code if @job
> > is aborted
> > =C2=A0 * before drm_sched_job_arm() is called.
> > =C2=A0 *
> > - * After that point of no return @job is committed to be executed
> > by the
> > - * scheduler, and this function should be called from the
> > - * &drm_sched_backend_ops.free_job callback.
> > + * drm_sched_job_arm() is a point of no return since it
> > initializes the fences
> > + * and their sequence number etc. Once that function has been
> > called, you *must*
> > + * submit it with drm_sched_entity_push_job() and cannot simply
> > abort it by
> > + * calling drm_sched_job_cleanup().
> > + *
> > + * This function should be called in the
> > &drm_sched_backend_ops.free_job callback.
> > =C2=A0 */
> > =C2=A0void drm_sched_job_cleanup(struct drm_sched_job *job)
> > =C2=A0{
> > @@ -1027,10 +1034,15 @@ void drm_sched_job_cleanup(struct
> > drm_sched_job *job)
> > =C2=A0	unsigned long index;
> > =C2=A0
> > =C2=A0	if (kref_read(&job->s_fence->finished.refcount)) {
> > -		/* drm_sched_job_arm() has been called */
> > +		/* The job has been processed by the scheduler,
> > i.e.,
> > +		 * drm_sched_job_arm() and
> > drm_sched_entity_push_job() have
> > +		 * been called.
> > +		 */
> > =C2=A0		dma_fence_put(&job->s_fence->finished);
> > =C2=A0	} else {
> > -		/* aborted job before committing to run it */
> > +		/* The job was aborted before it has been
> > committed to be run;
> > +		 * notably, drm_sched_job_arm() has not been
> > called.
> > +		 */
> > =C2=A0		drm_sched_fence_free(job->s_fence);
> > =C2=A0	}
> > =C2=A0
>=20


