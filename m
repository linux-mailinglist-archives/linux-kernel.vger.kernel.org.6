Return-Path: <linux-kernel+bounces-175576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8068C21BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E609D1F23DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCB16D324;
	Fri, 10 May 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aLBC1eT2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D32168AE2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335766; cv=none; b=AvXORrHYDNxPzehnIjBx3MCW3744jOEk1J7RYqtwCe1FKLmFa3Syn1n+UAX+oJZwxp0ihSe1DNkQ/VJ3C/bCyvVPp3L21fYwybGDy6hYY8/9fNtf6+vZ4Gx3sT7/wd/4yisNZQ8722MOYTBeg2zeUUKw5tjB4+Gh08wIAAALJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335766; c=relaxed/simple;
	bh=zDhfa47N/P77GAGDKEYJOkBZbcpC4MiLu1UflRoPcVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWfxlt/dHpuw1y85dvVbBsdYEXzUG31+0fezKAdPZqDiFQ1v1Maseifj6+2hEVKLOudpdGIjFWyNeAcT48Ec8sYOdLW0WnYv2lBd5ovIoNxx847xhXCoeLJ6JFY/TR8ea/MCsrqNmbfBtNsekoy2RiHjvsSY28YelDp5FCfPb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aLBC1eT2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715335762;
	bh=zDhfa47N/P77GAGDKEYJOkBZbcpC4MiLu1UflRoPcVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aLBC1eT2R2dCqcM7+JHgnygWVN3zXRbup1PZw4+H4WZFP2gLlgg52G7fr5GTPYBbx
	 V40TPp85Db6ALfgjx7CC+OUUtfJZLGErdoZ1GSTV9ZHDfRxK39VehOxAH/me6URBiG
	 YznTW9cH7Zoggwav0qrtBhLfuN/Ud+XwY4Te/tEZO2wUNj57S+iMtdjsoZ+YkhQ5xN
	 SWRByM1ofUgHo6dT5UI4zjzfa7/WN6gg4JKzreWu37FcxUPt0iUnrQCcmzXZUhs9+/
	 Es3N6PakVVcePdDYKeN2zm2fWGthULnr8h8X7ttYz5tOVia5EnMGNbXZuRu88UQw+M
	 Ljtm9G0NnqYDQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C8E9E3782185;
	Fri, 10 May 2024 10:09:21 +0000 (UTC)
Message-ID: <f72b241f-11ab-4165-af51-14413d4e9f7a@collabora.com>
Date: Fri, 10 May 2024 12:09:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Fix get efuse issue for MT8188 DPTX
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 matthias.bgg@gmail.com, jitao.shi@mediatek.com, mac.shen@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240510061716.31103-1-liankun.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240510061716.31103-1-liankun.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/05/24 08:16, Liankun Yang ha scritto:
> Fix get efuse issue for MT8188 DPTX.
> 
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>

I may agree with this commit, but:
1. The commit title is incorrect - I don't see "drm/mediatek:" - please look at
    the history to find out the right titles for your commits; and
2. The commit description isn't describing anything, you're just repeating the
    title: please add a description. What was wrong? What did you fix precisely?
3. There's no Fixes tag. Please add the relevant one.

Regards,
Angelo

> ---
>   drivers/gpu/drm/mediatek/mtk_dp.c | 85 ++++++++++++++++++++++++++++++-
>   1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index 2136a596efa1..32b36b63a4e1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -145,6 +145,89 @@ struct mtk_dp_data {
>   	u16 audio_m_div2_bit;
>   };
>   
> +static const struct mtk_dp_efuse_fmt mt8188_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
> +	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
> +		.idx = 0,
> +		.shift = 10,
> +		.mask = 0x1f,
> +		.min_val = 1,
> +		.max_val = 0x1e,
> +		.default_val = 0xf,
> +	},
> +	[MTK_DP_CAL_CLKTX_IMPSE] = {
> +		.idx = 0,
> +		.shift = 15,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_0] = {
> +		.idx = 1,
> +		.shift = 0,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_1] = {
> +		.idx = 1,
> +		.shift = 8,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_2] = {
> +		.idx = 1,
> +		.shift = 16,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_3] = {
> +		.idx = 1,
> +		.shift = 24,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_0] = {
> +		.idx = 1,
> +		.shift = 4,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_1] = {
> +		.idx = 1,
> +		.shift = 12,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_2] = {
> +		.idx = 1,
> +		.shift = 20,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_3] = {
> +		.idx = 1,
> +		.shift = 28,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +};
> +
>   static const struct mtk_dp_efuse_fmt mt8195_edp_efuse_fmt[MTK_DP_CAL_MAX] = {
>   	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
>   		.idx = 3,
> @@ -2758,7 +2841,7 @@ static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops, mtk_dp_suspend, mtk_dp_resume);
>   static const struct mtk_dp_data mt8188_dp_data = {
>   	.bridge_type = DRM_MODE_CONNECTOR_DisplayPort,
>   	.smc_cmd = MTK_DP_SIP_ATF_VIDEO_UNMUTE,
> -	.efuse_fmt = mt8195_dp_efuse_fmt,
> +	.efuse_fmt = mt8188_dp_efuse_fmt,
>   	.audio_supported = true,
>   	.audio_pkt_in_hblank_area = true,
>   	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,


