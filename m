Return-Path: <linux-kernel+bounces-576646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C1A71263
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463C0189B674
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574461A23A9;
	Wed, 26 Mar 2025 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nE5nNb8m"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D31A0BFD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976884; cv=none; b=Fvwn+4fR+FhZmmpZKwnw9dRVrCkRYaIPVpO/INuXCuBcgJKgi3s5hevHyj5oC0BCsS+S5OKZwjRh1k0OCwjHF9q/shPAEQ9MRWZOXVOvm1c04LMtzzSbed2z1AN9/iqRzj6sLzzD7kBw5+B6qG+lJlR4PMQ6CsN/lH1nxsIG4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976884; c=relaxed/simple;
	bh=d94Wug1j448Vfloe6YPhxvFw+vcX7h6NTaCwAPlBwtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGCf3GT3AGqlK7MSx9GtFUaHLqSETx1ZUpznJhe+7REguKvksMzDGdQpdJYoCRMDe1dwCo5+nNWZQ3BrYZRb+N/IwB8kmsB4oMtky0D9Z8x5qENG6fi0Qb1Bdhh7JxwBTLp5js5LuHGRxW5LXYtfrB7YRu1lhERwW2k/TnjNh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nE5nNb8m; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZN0206w5Hz9vqS;
	Wed, 26 Mar 2025 09:14:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1742976873; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDJA3AFDro/Gd5EG3lHw9enC/cyhwBJuPgmUI1A4KUE=;
	b=nE5nNb8m8bZemKMCNX24G3Le0cffXoaY/iJvd1FWcLTn9VvjyezQ1jXVRvi1B0agxn8aki
	ROuIguCRba8UOmxbLRvhfHLUelFM7stYMXw1V8NzJZnR1cOxLknFzOC7aiEC5svGfDOcnO
	EoN1ZTzBPOvhvo3vssjN/1TWOZSIK3IIwHHTm6VdY3V0ByiL6f8OuH98+Xx/98Rc4l75Sg
	Hmshs9urgCo4E09TSqRbe40CR8wicQfnSmRuG/+wuoPO7iFpVPTQJd0vzjPKWN4hQYWc6d
	EwQjvSY/VSXOkzvi4+kpWRIMh8je9xyqRu2DN2YxwPkK4YUZwBYHU9YDVP0WpQ==
Message-ID: <8e636b5ec44b8b5d859a18a4a21ca95d74e45587.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Add return value for
 drm_sched_entity_push_job
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Qianyi Liu <liuqianyi125@gmail.com>, airlied@gmail.com, 
 ckoenig.leichtzumerken@gmail.com, dakr@kernel.org, daniel@ffwll.ch, 
 maarten.lankhorst@linux.intel.com, matthew.brost@intel.com,
 mripard@kernel.org,  phasta@kernel.org, tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Mar 2025 09:14:28 +0100
In-Reply-To: <20250326070441.1515428-1-liuqianyi125@gmail.com>
References: <20250326070441.1515428-1-liuqianyi125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: idg8pyi8xtpzbgx6zcuj4mk6zjejcrna
X-MBO-RS-ID: 1dd07560aa5f956bd1a

Hello,

thanks for your patch

On Wed, 2025-03-26 at 15:04 +0800, Qianyi Liu wrote:
> Currently drm_sched_entity_push_job() has no return value to indicate
> operation status. This makes it difficult for callers to handle error
> conditions properly.
>=20
> Add a int return value to drm_sched_entity_push_job() that returns 0
> on
> success or a negative error code (e.g., -EINVAL) on failure. This
> allows
> callers to:
>=20
> 1. Detect when job submission fails
> 2. Perform proper cleanup (e.g., release job and fence allocations)
> 3. Avoid potential memory leaks in error paths
>=20
> Signed-off-by: Qianyi Liu <liuqianyi125@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 8 ++++++--
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A02 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index bd39db7bb240..f31964e76062 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -579,8 +579,10 @@ void drm_sched_entity_select_rq(struct
> drm_sched_entity *entity)
> =C2=A0 * fence sequence number this function should be called with
> drm_sched_job_arm()
> =C2=A0 * under common lock for the struct drm_sched_entity that was set u=
p
> for
> =C2=A0 * @sched_job in drm_sched_job_init().
> + *
> + * Returns 0 on success or a negative error code on failure.
> =C2=A0 */
> -void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
> +int drm_sched_entity_push_job(struct drm_sched_job *sched_job)

I am not convinced this is a justified change, because:
   1. The entity being dead is the only error that might occur
   2. That error is extremely unlikely
   3. It does not occur in all existing upstream drivers
   4. Drivers typically first prevent userspace from pushing stuff to
      an entity, then tear the entity down, then (in case of firmware
      schedulers) tear the entire scheduler down.
   5. Your patch doesn't add an upstream user for the error code,
      showing how it's better / different from how existing drivers
      handle their entity-pushing.

Thus, pushing to a killed entity is a gross misdesign of the driver,
which should become visible during development and can't be handled
during runtime in a reasonable manner.

P.

> =C2=A0{
> =C2=A0 struct drm_sched_entity *entity =3D sched_job->entity;
> =C2=A0 bool first;
> @@ -609,7 +611,7 @@ void drm_sched_entity_push_job(struct
> drm_sched_job *sched_job)
> =C2=A0 spin_unlock(&entity->lock);
> =C2=A0
> =C2=A0 DRM_ERROR("Trying to push to a killed entity\n");
> - return;
> + return -EINVAL;
> =C2=A0 }
> =C2=A0
> =C2=A0 rq =3D entity->rq;
> @@ -626,5 +628,7 @@ void drm_sched_entity_push_job(struct
> drm_sched_job *sched_job)
> =C2=A0
> =C2=A0 drm_sched_wakeup(sched);
> =C2=A0 }
> +
> + return 0;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_entity_push_job);
> diff --git a/include/drm/gpu_scheduler.h
> b/include/drm/gpu_scheduler.h
> index 50928a7ae98e..48a263571bab 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -589,7 +589,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_entity *enti=
ty,
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 credits, void *owner);
> =C2=A0void drm_sched_job_arm(struct drm_sched_job *job);
> -void drm_sched_entity_push_job(struct drm_sched_job *sched_job);
> +int drm_sched_entity_push_job(struct drm_sched_job *sched_job);
> =C2=A0int drm_sched_job_add_dependency(struct drm_sched_job *job,
> =C2=A0 struct dma_fence *fence);
> =C2=A0int drm_sched_job_add_syncobj_dependency(struct drm_sched_job *job,


