Return-Path: <linux-kernel+bounces-555707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A54CA5BBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE78F3AE431
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5422424D;
	Tue, 11 Mar 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IPqCIJR1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520E1CD205
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684190; cv=none; b=bL7/ckvj1frqh65RZsI6fmEbc0/PPSnPySXFhqgjjKBprO7sRTfIWzm3yVeGXzPatSO/svIh8RwJYsaSm8cqYPQfhm57Ne76gwEFJxtCI1JCfgAX5Ddnr243jlVbRiZq7WmROl+Ey1LTCHlxGCnXNrjq7vmEZ0XFwnl/9XthORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684190; c=relaxed/simple;
	bh=6Y/kqe4ESlLKPPwAdQRMQdrAIo89CgPRwwvqGj8Dd8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYDryc3HF86c8XL81S0WI1W/j/MHXg5qtXRkLTsz1SegxJR8OHUfCMoAqteujEM87NGJq3LM+ulTRZefWlQ/WMF97KyJfKFqTqdkjzrfcMDB9H25ShkMO+xGb4oJAgG7gZVYyakOpoGH8XALwyuIlMFR5xscfm/lfAF2mu5ur8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IPqCIJR1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741684182;
	bh=6Y/kqe4ESlLKPPwAdQRMQdrAIo89CgPRwwvqGj8Dd8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IPqCIJR154BY6tFPErElSqI5KpX6LmqlGrxjLYgykbMbKI4AhzvIyiebJs1qcEKcl
	 rS5yBrFJt4ENvvdHd3nD+eEz69JQuNKA/CXITBeYTe3s+yUlEbkamtX+AbLgRexF+P
	 ZiFTOB7eMEKXUFhPO3XCrVyMDSAKUwaTYW6UCyS00H6Idclv6vLEL3d3OGsSOjCnkH
	 4cZjsjvkxUwjm+fb2xfdS3m4m/G27lyBXBPWQYK9XdBFsXwXuy88TgxvvrEyT6Rlmn
	 N2f826TK0hYW7dofQ4k3u3aCvAJqBrcZezwtPyJFEhPcWQizhd6WaVzGjxC3jxtGY4
	 YBBORT+bdRvZA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 617C717E087E;
	Tue, 11 Mar 2025 10:09:41 +0100 (CET)
Message-ID: <55b8bc40-0a29-46c2-ba5d-c7cc7742cf5f@collabora.com>
Date: Tue, 11 Mar 2025 10:09:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] drm/panfrost: Enable AARCH64_4K page table format
 on mediatek_mt8188
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kernel@collabora.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sjoerd@collabora.com
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
 <20250310195921.157511-6-ariel.dalessandro@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250310195921.157511-6-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/03/25 20:59, Ariel D'Alessandro ha scritto:
> Now that Panfrost supports AARCH64_4K page table format, let's enable it
> on Mediatek MT8188.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 0f3935556ac76..d7b8bded6d784 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -824,6 +824,7 @@ static const struct panfrost_compatible mediatek_mt8188_data = {
>   	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
>   	.pm_domain_names = mediatek_mt8183_pm_domains,
>   	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
> +	.gpu_configs = BIT(GPU_CONFIG_AARCH64_4K),
>   };
>   
>   static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };

Didn't that work on MT8195/8395 as well? I also recall hearing that it was somewhat
giving ever-so-slightly better performance?

If it does, please enable it on 8195 as well :-)

also s/mediatek_mt8188/MediaTek MT8188/g

...and btw
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

