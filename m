Return-Path: <linux-kernel+bounces-211266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D3904F47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08BC1F280E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F716DEB3;
	Wed, 12 Jun 2024 09:29:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537F21CFB5;
	Wed, 12 Jun 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184546; cv=none; b=QRJ1pzMbjVA/sUxeBwyQ45OHpPdKZdInXRtzdBa1KKxlSQyg3NGDtputkD0F16K9f3NoYQltxeeionuNSXSJdoBCOIIDKkejZdqPtoOPpj9UgOfZNI0NeY+rSrpv876lCERd0FJAGWga7EGPJ8WmJmKjmSXOz+nSLFlutA6VRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184546; c=relaxed/simple;
	bh=DsxnX5L2k3IkFgc1OU5UIunCZy/+2T26BRmIyb3T3R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPtHjq4uTrDF4Kb7q80MLHGm0gVkn9oM2McXyNhdCQBNFRLSnGbFxSzUARg4Ih/WPrZTg/gpseR4ZwBdYJzZJMvGaTO31XmHxIZT+hl640GCdcBUSZoEnvwJ/zvP7XKqYk03IyjtVNs9UvLzcjO4zswcBB6pGbUWS1koW3PpGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49AAE1595;
	Wed, 12 Jun 2024 02:29:27 -0700 (PDT)
Received: from [10.57.42.88] (unknown [10.57.42.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E497B3F64C;
	Wed, 12 Jun 2024 02:28:58 -0700 (PDT)
Message-ID: <6304a5a2-1ca0-4e6c-8c0a-e7b320f64c7d@arm.com>
Date: Wed, 12 Jun 2024 10:28:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/panfrost: Add support for Mali on the MT8188
 SoC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 boris.brezillon@collabora.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>
References: <20240611085602.491324-1-angelogioacchino.delregno@collabora.com>
 <20240611085602.491324-3-angelogioacchino.delregno@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240611085602.491324-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2024 09:56, AngeloGioacchino Del Regno wrote:
> MediaTek MT8188 has a Mali-G57 MC3 (Valhall-JM): add a new
> compatible and platform data using the same supplies and the
> same power domain lists as MT8183 (one regulator, three power
> domains).
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index ef9f6c0716d5..b43557b10ae3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -777,6 +777,15 @@ static const struct panfrost_compatible mediatek_mt8186_data = {
>  	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
>  };
>  
> +/* MT8188 uses the same power domains and power supplies as MT8183 */
> +static const struct panfrost_compatible mediatek_mt8188_data = {
> +	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
> +	.supply_names = mediatek_mt8183_b_supplies,
> +	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
> +	.pm_domain_names = mediatek_mt8183_pm_domains,
> +	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
> +};
> +
>  static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
>  static const char * const mediatek_mt8192_pm_domains[] = { "core0", "core1", "core2",
>  							   "core3", "core4" };
> @@ -808,6 +817,7 @@ static const struct of_device_id dt_match[] = {
>  	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
>  	{ .compatible = "mediatek,mt8183b-mali", .data = &mediatek_mt8183_b_data },
>  	{ .compatible = "mediatek,mt8186-mali", .data = &mediatek_mt8186_data },
> +	{ .compatible = "mediatek,mt8188-mali", .data = &mediatek_mt8188_data },
>  	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
>  	{}
>  };


