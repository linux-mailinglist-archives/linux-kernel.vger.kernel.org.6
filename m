Return-Path: <linux-kernel+bounces-524075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41FFA3DEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF591692FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044B1D63F8;
	Thu, 20 Feb 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CgwDOyNJ"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2410FD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065833; cv=none; b=PDthiPk7ePNRo9Y1Fg+1+29Uh1OMcvze0jQDymLs7Y2o+qblWxVx/DfISkXcZj/+L5d2tGQZW/ZXhW/SSGZ3gw3Rj0zHACrJfL+KFDep71JMAr+UZCDtYwE4Io9BvWsM1FUzkCdQuzTBmM3bs1pG0cxvZVjR4hinaOczcRAjcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065833; c=relaxed/simple;
	bh=XO2M/uUJ2p1SoPlvI7dxH/htt72CWdzIoaf7Tozisz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NnCz/omp0/u3v3qHHN3+tJ1my+Ru86HCclNJROoaBd7DpZHyuVrlgn8zTFar81JC8gpJEvzqpBamBCcuWhXwbS6HEu9UfrUbWiX+3Oa2XfQTIB3CX0R9yqBcl/EAev/uhbKgmqvVNrxAPRf2Q4sQrLVFhp9Q3Wpxy0kEj6D9A5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CgwDOyNJ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YzHH14NZ7z9spX;
	Thu, 20 Feb 2025 16:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1740065341; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moBIYW5c22y5U9ZUMoNmX9PjRve/TYLKT2xP88T6GNk=;
	b=CgwDOyNJ9frMDol6i9GuBnEYEJ9ZZ81FtxQmDD8lk03pzpp8Zbb+Kp444xjUC6hhQY2X/y
	q+LWv5eM/C+31tBZhn+dHj5YPGue7FIgb7+i6t/T07lubhwUcTo0f2P2CJgwG1ONyq+mWk
	j2uh9oFC+Pmt9DbLmu7hZ+NNSqjD/+0AnsihkGRaW0tR5I5/Syi6628iNDDT2cNEOt6/G4
	x+1TfPekeh9aqWktEWtgjwZzfz5NUEV97Wuh5P+yWAB0jEyl6zN+PSERAIYxm9R2zKKGoY
	AHqXvSMWhQpBe77/tws8dccCK+mrCE9J5dGDeSWVc2QcqSx1ViPT7D03Re1Tcg==
Message-ID: <1457e985f88e02cd04b2152d2468a65b7a513e63.camel@mailbox.org>
Subject: Re: [PATCH v5 2/3] drm/sched: Adjust outdated docu for run_job()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Philipp Stanner
 <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 16:28:57 +0100
In-Reply-To: <12c53d41-21c4-443d-a572-fd22c3cc56ad@igalia.com>
References: <20250220112813.87992-2-phasta@kernel.org>
	 <20250220112813.87992-4-phasta@kernel.org>
	 <12c53d41-21c4-443d-a572-fd22c3cc56ad@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: rcyh97uoydj6trykgde1o673ouj3r9dy
X-MBO-RS-ID: 993dd54fa9f0bb66e38

On Thu, 2025-02-20 at 10:28 -0300, Ma=C3=ADra Canal wrote:
> Hi Philipp,
>=20
> On 20/02/25 08:28, Philipp Stanner wrote:
> > The documentation for drm_sched_backend_ops.run_job() mentions a
> > certain
> > function called drm_sched_job_recovery(). This function does not
> > exist.
> > What's actually meant is drm_sched_resubmit_jobs(), which is by now
> > also
> > deprecated.
> >=20
> > Remove the mention of the removed function.
> >=20
> > Discourage the behavior of drm_sched_backend_ops.run_job() being
> > called
> > multiple times for the same job.
>=20
> It looks odd to me that this patch removes lines that were added in
> patch 1/3. Maybe you could change the patchset order and place this
> one
> as the first.
>=20
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0 include/drm/gpu_scheduler.h | 19 +++++++++++++------
> > =C2=A0 1 file changed, 13 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/drm/gpu_scheduler.h
> > b/include/drm/gpu_scheduler.h
> > index 916279b5aa00..29e5bda91806 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -421,20 +421,27 @@ struct drm_sched_backend_ops {
> > =C2=A0=20
> > =C2=A0=C2=A0	/**
> > =C2=A0=C2=A0	 * @run_job: Called to execute the job once all of the
> > dependencies
> > -	 * have been resolved. This may be called multiple times,
> > if
> > -	 * timedout_job() has happened and
> > drm_sched_job_recovery() decides to
> > -	 * try it again.
> > +	 * have been resolved.
> > +	 *
> > +	 * The deprecated drm_sched_resubmit_jobs() (called from
> > +	 * drm_sched_backend_ops.timedout_job()) can invoke this
> > again with the
>=20
> I think it would be "@timedout_job".

Not sure, isn't referencing in docstrings done with '&'?

>=20
> > +	 * same parameters. Using this is discouraged because it,
> > presumably,
> > +	 * violates dma_fence rules.
>=20
> I believe it would be "struct dma_fence".

Well, in this case strictly speaking not IMO, because it's about the
rules of the "DMA Fence Subsystem", not about the struct itself.

I'd just keep it that way or call it "dma fence"

>=20
> > +	 *
> > +	 * TODO: Document which fence rules above.
> > =C2=A0=C2=A0	 *
> > =C2=A0=C2=A0	 * @sched_job: the job to run
> > =C2=A0=C2=A0	 *
> > -	 * Returns: dma_fence the driver must signal once the
> > hardware has
> > -	 *	completed the job ("hardware fence").
> > -	 *
> > =C2=A0=C2=A0	 * Note that the scheduler expects to 'inherit' its own
> > reference to
> > =C2=A0=C2=A0	 * this fence from the callback. It does not invoke an
> > extra
> > =C2=A0=C2=A0	 * dma_fence_get() on it. Consequently, this callback must
> > take a
> > =C2=A0=C2=A0	 * reference for the scheduler, and additional ones for
> > the driver's
> > =C2=A0=C2=A0	 * respective needs.
>=20
> Would it be possible to add a comment that `run_job()` must check if
> `s_fence->finished.error` is different than 0? If you increase the
> karma
> of a job and don't check for `s_fence->finished.error`, you might run
> a
> cancelled job.

s_fence->finished is only signaled and its error set once the hardware
fence got signaled; or when the entity is killed.

In any case, signaling "finished" will cause the job to be prevented
from being executed (again), and will never reach run_job() in the
first place.

Correct me if I am mistaken.

Or are you suggesting that there is a race?


P.

>=20
> > +	 *
> > +	 * Return:
> > +	 * * On success: dma_fence the driver must signal once the
> > hardware has
> > +	 * completed the job ("hardware fence").
>=20
> A suggestion: "the fence that the driver must signal once the
> hardware
> has completed the job".
>=20
> Best Regards,
> - Ma=C3=ADra
>=20
> > +	 * * On failure: NULL or an ERR_PTR.
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	struct dma_fence *(*run_job)(struct drm_sched_job
> > *sched_job);
> > =C2=A0=20
>=20


