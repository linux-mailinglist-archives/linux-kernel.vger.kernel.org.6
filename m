Return-Path: <linux-kernel+bounces-356518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8309C99627C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE261F231BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3702188A1B;
	Wed,  9 Oct 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="Sp6FeLyY";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="uQ/0JWKl"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D5175D4C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462408; cv=none; b=E4VxcrVoAENt59DL/+XB7fquuZAxzv4ymNNHS11hMJBXnOmqrfHdTUiTuIzpriPseGjg06foU/hywHk7bs5jRBhAgBPYDfD+TvAQdDJCLZdDg1EsRZReb0B6Y8R6asYRGGfop/ixDJzqkoeC0lGmSCIo4OZ7tBt33EItG5Z4eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462408; c=relaxed/simple;
	bh=WpU7IDNItE4PqhOYJLXofqM0PKJOyPxuV74gffsAiHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/M7LHZ7tn79QuDGoav2YvbOzvkHwDcuYSG/qRVKVt27Vi06QdUKEjaTzDiX49Ml6uVEfBzhP07Bu5OzH4I+WPidVYBiV04RT7eHFGqhGNM+cqvCQwL8YfQkIi/TPLQjmdlqhcnilY4OEb1DtnVaxSAOfgiEFmbi9j9Y718XdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=Sp6FeLyY; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=uQ/0JWKl; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1728462165; bh=vZBRkEYozxZuTs1P5xDq7FC
	HWdy39DrdwAYvDZH+ywQ=; b=Sp6FeLyYsW4um7LgeLsLMNs9VCRV5VBnol8ZjvBRIzxavSSrHa
	ikVEgqSthe+DeVE+VR6kM3fSrdX//R2r9GaTu9689uvORNJeR/oOWEJ9G7GHm4tO9T8+Dgj0KYx
	LSIycteHvSCQIdmk+15FIlxvxVqc/VfPT9MPpdZKWO1HH4aMjSf45uxPFFjA74glgTxRcXu1AT8
	hJ8yPqNYg5bD30Cuuvib1NbBFyj2UAoOqwZkTS8HHarqtqjVQr/uGTazHHvSMyTZmWVHknWldER
	xRLh102rwDeZXAWfGi9jYBS6XTF+Bt1aFfle1+v582bdsnOxVkriUNzBFLVanIsWUxg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1728462165; bh=vZBRkEYozxZuTs1P5xDq7FC
	HWdy39DrdwAYvDZH+ywQ=; b=uQ/0JWKlTjJ9bNwn0FkgIJaa/iyKj8EMlIZIomDWTjjVvVLnKE
	y3X0tTLEI7A5OBydCiZdwSDIH1eZ60XJD8Cg==;
Message-ID: <d9a3fee4-bb14-4162-95b1-06177d0a9949@damsy.net>
Date: Wed, 9 Oct 2024 10:22:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prevent BO_HANDLES error from being
 overwritten
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 David Wu <David.Wu3@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
References: <20241004235904.8605-1-pvmohammedanees2003@gmail.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20241004235904.8605-1-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 05/10/2024 à 01:59, Mohammed Anees a écrit :
> Before this patch, if multiple BO_HANDLES chunks were submitted,
> the error -EINVAL would be correctly set but could be overwritten
> by the return value from amdgpu_cs_p1_bo_handles(). This patch
> ensures that once an error condition is detected, the function
> returns immediately, avoiding the overwriting of the error code.
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 1e475eb01417..543db0df9a31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -266,8 +266,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   			/* Only a single BO list is allowed to simplify handling. */
>   			if (p->bo_list)
>   				ret = -EINVAL;
> +			else
> +				ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
>   
> -			ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);

My bad, I've merged the wrong version of the patch.

That being said, I think it'd be nicer to follow the same pattern as the other checks and do:

    if (p->bo_list)
       goto free_partial_kdata;

Since "ret" is initialized to -EINVAL already.

Also can you add a reference to the broken commit in the commit message?
Something like:

Fixes: fec5f8e8c6bcf83 ("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit")

Thanks,
Pierre-Eric

>   			if (ret)
>   				goto free_partial_kdata;
>   			break;


