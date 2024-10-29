Return-Path: <linux-kernel+bounces-386484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294539B4409
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0CCB220D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781D20125B;
	Tue, 29 Oct 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cCBhpok4"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9298201027
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190003; cv=none; b=fIO7GowseAJE4/+iIUkIztw2uohj48cHf0nv7deuGcu+KF4J1PSKdpVOBKCZMXm5vK8zHtZyhhrgTR6do3jzSrGdR+rvboYWm/YxP2Y9auW83bJH/K+AWKyz7A+KF/WaQMN8k+bn/G1JW96KN+evowGxvAlOv1QCbmb4HqJBx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190003; c=relaxed/simple;
	bh=MqfTXgXebuqUfq5BoS0etg/IqCiNGzeGMIiFC8Df4g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N767h1/87D6yFr31/p1TVSOesk/M7sW1MHYFAad7fFeozlqxSIXkBLXdyA94qDcw+KotqjGeJ60X4osGJ9NlpwBLciN+eB3XI0g0WMJvaUnKkALEelB+8zWS4P9SJHG46W66FAXEGKKxP6KlnltxTtQZiQqoQ3U9HRG+c14a6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cCBhpok4; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 5hR7twWHkhwv35hR7tySSs; Tue, 29 Oct 2024 09:18:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730189928;
	bh=b+GxDsuZC4j8RNTX1hXyuIOyIWp5LC02jZqsiJ2B6H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=cCBhpok4W6M/oxZwRUtwfYmiunXFw2E7NgZPIMpIdvch+Ejyefnv6D6xwtGAAkbvN
	 9KEpDHsq8nKlSd+9H03Z+lSynoDGS/Ht/U7JR+yXFw3JpbIBX+JWIOXpbI/brqaUkK
	 yzTDzyiJ6YevTb+IW1qwNrYJzUafqtyGTBeRrzSyotm61wTO90fnDnAB+cSiTMvKLs
	 0B2YPNZQ75ngSPjRJ4msmoL4749u35tNwdoLCwlpvAudICOhmT30JOYSyY1MCBMqpA
	 MN3B1+w7EBpkGleABZ/ZEgcszSvDdgFRNSckXb+6psXEdPXWm7xJ+AwyyH2+fEAKUh
	 /Qpab+NbMgirQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 29 Oct 2024 09:18:48 +0100
X-ME-IP: 90.11.132.44
Message-ID: <2a070669-aa48-413e-959c-4107d9c2f97c@wanadoo.fr>
Date: Tue, 29 Oct 2024 09:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix possible NULL pointer dereference
To: Li Huafei <lihuafei1@huawei.com>, alexander.deucher@amd.com,
 lijo.lazar@amd.com
Cc: christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, Hawking.Zhang@amd.com, yifan1.zhang@amd.com,
 Likun.Gao@amd.com, Tim.Huang@amd.com, pratap.nirujogi@amd.com,
 victorchengchi.lu@amd.com, Jun.Ma2@amd.com, le.ma@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241029101839.2605713-1-lihuafei1@huawei.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241029101839.2605713-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/10/2024 à 11:18, Li Huafei a écrit :
> Fix the potential NULL pointer dereference on mem_ranges in
> amdgpu_discovery_get_nps_info(). Additionally, assign the output
> parameters nps_type and range_cnt after the kvzalloc() call to prevent
> modifying the output parameters in case of an error return.
> 
> Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
> Changes in v2:
>   - kvzalloc() call uses 'nps_info->v1.count' instead of '*range_cnt'
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 4bd61c169ca8..9a0b1b208a9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
>   
>   	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
>   	case 1:
> -		*nps_type = nps_info->v1.nps_type;
> -		*range_cnt = nps_info->v1.count;
>   		mem_ranges = kvzalloc(

Not strictly related to your fix, but this could also be kvcalloc() to 
avoid potential overflow in the multiplication.

CJ

> -			*range_cnt * sizeof(struct amdgpu_gmc_memrange),
> +			nps_info->v1.count * sizeof(struct amdgpu_gmc_memrange),
>   			GFP_KERNEL);
> +		if (!mem_ranges)
> +			return -ENOMEM;
> +		*nps_type = nps_info->v1.nps_type;
> +		*range_cnt = nps_info->v1.count;
>   		for (i = 0; i < *range_cnt; i++) {
>   			mem_ranges[i].base_address =
>   				nps_info->v1.instance_info[i].base_address;


