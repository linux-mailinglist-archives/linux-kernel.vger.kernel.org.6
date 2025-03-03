Return-Path: <linux-kernel+bounces-542437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D18A4C9B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395D618982CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912725DCF5;
	Mon,  3 Mar 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JjuYupJC"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E922FF35
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022038; cv=none; b=XYo50a4Nkj4gmUMRC6M18dkc75aVr45RN0fomTrISdlXkFvfCSLwB0qtukD+rNF820WSnDfdph/FWQu//Kh0cea3GtafuNcimZd9GncHt54Kgcr2Y4bgb5YYwhYyW7wHLOUqxoieqUJ+qg2UkcChppuMahtA1htlPQ1wDsWhm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022038; c=relaxed/simple;
	bh=OBHMspVaZTHJSO//EaTEp6DZlqtPbmtPOzpzMwxA+Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVlYNF0eht3obYhm/8CrS7Cg19RX7CZ4T4aF+VGOV0BNQXaoeyX/yUwHBB+DMW3hPZ+l0eZzfUQbAKEKUd02pzbonJP4mjP+1BiEz4lMj6Odfa/7mQHaSFDHACHZtFGqamVXQrR0cF9xl0SIIObl7RRHoTQXWyk2KBNaOPSZuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JjuYupJC; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RfoV1dR+3eFR8Th0VNFLGr0GH4T107s17ieZ/oYpqN0=; b=JjuYupJCD1ketdu2K/woa/nGZy
	zJ8qtx3UhpuKZcsVoZijDcWQF2/FzdESvR2Y6JTN+ytvjXBUTy0RL86zIg6RWbDPrpwjYcSmbA1iT
	9niUbNTzBthYuSXpVrFLedxjIMifYL1uuOEimBX2a13+nIyJmojOaV/I6/qyk8aYPvqMZ4DYjxbVc
	DzIdyV7laVeKXHfuFyDnUbym6zByxfo0g0ou1h6h1QodVV164E6tu8Ib7qLH2DAVwFthdCiuzpp86
	w8yasqUuvoEGW9JMhWEexma2CooO/hXz8j9CM8H/sOduFoybvYCji+/JIFYN1hFJnfbfoI2kX6Bbn
	jjVWk8ww==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tp9M9-003M6B-Bc; Mon, 03 Mar 2025 18:13:35 +0100
Message-ID: <d0de7ff5-0c48-4ad9-9a4f-2b7b4925a4e3@igalia.com>
Date: Mon, 3 Mar 2025 17:13:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: drm_sched_job_cleanup(): correct false doc
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250303143251.43793-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250303143251.43793-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/03/2025 14:32, Philipp Stanner wrote:
> drm_sched_job_cleanup()'s documentation claims that calling
> drm_sched_job_arm() is a "point of no return", implying that afterwards
> a job cannot be cancelled anymore.
> 
> This is not correct, as proven by the function's code itself, which
> takes a previous call to drm_sched_job_arm() into account. In truth, the
> decisive factors are whether fences have been shared (e.g., with other
> processes) and if the job has been submitted to an entity already.
> 
> Correct the wrong docstring.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index c634993f1346..db9e08e6e455 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1013,11 +1013,13 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
>    * Cleans up the resources allocated with drm_sched_job_init().
>    *
>    * Drivers should call this from their error unwind code if @job is aborted
> - * before drm_sched_job_arm() is called.
> + * before it was submitted to an entity with drm_sched_entity_push_job().
>    *
> - * After that point of no return @job is committed to be executed by the
> - * scheduler, and this function should be called from the
> - * &drm_sched_backend_ops.free_job callback.
> + * Since calling drm_sched_job_arm() causes the job's fences to be initialized,
> + * it is up to the driver to ensure that fences that were exposed to external
> + * parties get signaled. drm_sched_job_cleanup() does not ensure this.
> + *
> + * This function must also be called in &struct drm_sched_backend_ops.free_job
>    */
>   void drm_sched_job_cleanup(struct drm_sched_job *job)
>   {

I also do not see anything so special in the flows which would disallow 
"aborting" jobs after arming. And it definitely can happen in the 
practice. It was probably just unclear kerneldoc.

What I would suggest to add to the patch is to change the comment in 
drm_sched_job_cleanup() implementation:

This one:

		/* aborted job before committing to run it */

Probably just change to:

		/* aborted before arming */

With that you can add my r-b.

Regards,

Tvrtko


