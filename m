Return-Path: <linux-kernel+bounces-572932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D2A6D084
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B716B841
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6E5190052;
	Sun, 23 Mar 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OelJyDht"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBA27452;
	Sun, 23 Mar 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753432; cv=none; b=adWgIceu8LreT4apeq+q0044eoiRDL1fYBiPt21gwvw8C0+nyDzVFSVYWeVs/GLA25FxOGaA672UX2Iy/TryV1/lHtEWcQ03S9d5N4XQgXzQ5bf288cPFR7uKqFigxG2opQxywB8diMxt93igWPZualPDv2bXvOOzJEwWt6a7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753432; c=relaxed/simple;
	bh=0SGq6OSE+vSulCHu5kl1qv4hinnRfdlAm6vhArLGlBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE+Ged5nvTp4SBL48Ay/D8k5pi6aDA3uWDSg2ienfr2HBe5AwZKdsyxRI8LyVMk/gxazXrRl15A8OjBwvk/23MhnUyNdf2qwfU/9p++nQbMoH1jVodlCYnV1H7cQu7Bkq7WabNd6sA17bamcqJK1x/9gm8+TOEH34Sodb4YYKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OelJyDht; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wPdZtqcs4vQV0wPdctbi88; Sun, 23 Mar 2025 19:01:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742752895;
	bh=zp3UcKJhUjE7ySXeU2dEz0mIKPMzZc8r54esOzKpgeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OelJyDhtUiXn/3ZG0LOI5TjhwxvoaXoK9D1LUxe7j9eMo7tyWD+Si2DSO2zHRbynE
	 8E18tkmJ1GiiQuKPDzLThmDhtE6TTjrdNI1edhccNt6tPcfIN9Xmwr3O3UMyflNSYP
	 mlxRUzsl5jps9W+KhAyT6AiVmkDkPH7fmeEE3mv/L5EtmPq7C1q84INnpvO6//bpdm
	 cWI4ORMUWlw2FcMDY9foxevsA6WfP7rCkr7ChmR8+CyaSlqmip9jZr+SLNQTbUc9JN
	 Pn6urrO6ViumWpAlyYxfRPfY7FIqe+/Kpu9jElZ/ItY2E3MRkICnAK4CjqYJ1h0euN
	 1y//Erg9ytZVA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 23 Mar 2025 19:01:35 +0100
X-ME-IP: 90.11.132.44
Message-ID: <b212955e-eac6-4eff-b666-5a830e9d1537@wanadoo.fr>
Date: Sun, 23 Mar 2025 19:01:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/svm: fix dereferencing error pointer in
 drm_gpusvm_range_alloc()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20250323124907.3946370-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250323124907.3946370-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/03/2025 à 13:49, Harshit Mogalapalli a écrit :
> xe_svm_range_alloc() returns ERR_PTR(-ENOMEM) on failure and there is a
> dereference of "range" after that:
> 
> 	-->     range->gpusvm = gpusvm;
> 
> In xe_svm_range_alloc(), when memory allocation fails return NULL
> instead to handle this situation.
> 
> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/adaef4dd-5866-48ca-bc22-4a1ddef20381@stanley.mountain/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis and only compile tested.
> ---
>   drivers/gpu/drm/xe/xe_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 52e04e7e343f..a79df8cf1f36 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -80,7 +80,7 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
>   
>   	range = kzalloc(sizeof(*range), GFP_KERNEL);
>   	if (!range)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>   
>   	INIT_LIST_HEAD(&range->garbage_collector_link);
>   	xe_vm_get(gpusvm_to_vm(gpusvm));

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

