Return-Path: <linux-kernel+bounces-388756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647C9B6401
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19F7B22CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523161E7C11;
	Wed, 30 Oct 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KyAF95dK"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6C1E32B7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294754; cv=none; b=qruIOl4tFPXWkjER5/GKwW9N8SVxl6NjSuzq0zOw/1tG3Fu81/dx/hRtu+ket5bLzpe5bWknj19w0d7m+ikw02uZDIqvrT2l80gVN3JPAszTqyllhLD9RqfGpCdHSxSGniGSsx+OTzmW2enKg12tUNLNxnChF9sQZ38t10U9VDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294754; c=relaxed/simple;
	bh=pvbXgR9Xm7QX5Wa1OLsladlfCU7PiLKDysLpnvQUIAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=josjI92MM/HuJLu7wG+zMJlENKK19ANkJe/5NgFnHY47sSojzudJhZJoBp+ldi10pMEtMuXIhpSKL4xQl7pNKo7dYPMhQoPyybjkocTYyPtm5EcRyQiuUiNDSXnx5uQ5cCBo1R7qmL9Pcots+Ut3kydb/KQPPulLoJ5qaMv0L1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KyAF95dK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Us9rkUfj+iE/u81ryKmhTooVo1HWmg71Ma4F5AMwC6Q=; b=KyAF95dK1Nks5OhjcOsFn2SV4I
	vhtp4D4K1TQjQavDtp5Akcb51zdOeyGXlCRb3RsZgGjDFIZr/EphZ5z9Pi8o+Q76rO00oSifV/+7P
	ct+pS9pMtYXneLOPfzlhbMU56PazAq5oWReh9nE/LxFEU6rpf066k6JANziPaUpyys9lt9pX2kJBH
	ZKXCd71qwryyoBi/gumwjpmnghcNyC9LWnrumDZrIGLLzPBYW5CXQLb8KpEKrzAzZreJ8RLv4bVPk
	aScWVUr8EiP99kV6nXFs+3i2jYvjnfZgBc9Hfz7DmxeXbnQMXHoZMCD298NaAe1Q5nRqV/EMcKKDe
	pl+vhmmg==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t68hg-00H6BY-7O; Wed, 30 Oct 2024 14:25:40 +0100
Message-ID: <8f432835-1e45-4e2e-b053-10d25a23d5fb@igalia.com>
Date: Wed, 30 Oct 2024 10:25:33 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/v3d: Drop allocation of object without mountpoint
To: matthias.bgg@kernel.org, Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20241029-v3d-v2-1-c0d3dd328d1b@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241029-v3d-v2-1-c0d3dd328d1b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matthias,

On 29/10/24 08:24, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Function drm_gem_shmem_create_with_mnt() creates an object
> without using the mountpoint if gemfs is NULL.
> 
> Drop the else branch calling drm_gem_shmem_create().
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Applied to misc/kernel.git (drm-misc-next).

Best Regards,
- Maíra

> ---
> Changes in v2:
> - Fix indentation
> - Link to v1: https://lore.kernel.org/r/20241028-v3d-v1-1-907bee355edf@gmail.com
> ---
>   drivers/gpu/drm/v3d/v3d_bo.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 7055f7c7bcfe5700aee10b09ecc0005197323b01..73ab7dd31b17b249b7688dcc9833fd161211b6d9 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -157,13 +157,8 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
>   	struct v3d_bo *bo;
>   	int ret;
>   
> -	/* Let the user opt out of allocating the BOs with THP */
> -	if (v3d->gemfs)
> -		shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
> -							  v3d->gemfs);
> -	else
> -		shmem_obj = drm_gem_shmem_create(dev, unaligned_size);
> -
> +	shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
> +						  v3d->gemfs);
>   	if (IS_ERR(shmem_obj))
>   		return ERR_CAST(shmem_obj);
>   	bo = to_v3d_bo(&shmem_obj->base);
> 
> ---
> base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
> change-id: 20241028-v3d-1d2546ed92d7
> 
> Best regards,


