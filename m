Return-Path: <linux-kernel+bounces-521406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AEAA3BCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146C71721EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988A01DED57;
	Wed, 19 Feb 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HBwcvFSA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD241DF755;
	Wed, 19 Feb 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964566; cv=none; b=YsJ987xCgl/FXjBmHFeo1xeq3WezZGI6D35yyLvqRDO8mLgSu9j3dvgUnbYToKnnYhH/xW5spGZuxS8wpd/rDBURRwZLZPodK4wKFKMwIuN/R/htglFEZIZJVPLYhz64hlOTRJB2qznKnSBxFElF2DcLPXOrt5Zj6cMc/1MotlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964566; c=relaxed/simple;
	bh=tN6WEDR1AiRFyMbMUMu3VS4saSRBZMCNYL/A1DybkbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4W74QLv9bdPYx4yrJvJZdLoJcpm+ql7PEX3Xb3YiStR+Ij59K8OzbBfnAiaIhI+KgL/n/H1BjKzoUCwab3WnBJbyVvPWyG/FQj7HBaVXYbcZFF+AQqJbv96/b/Pv4fbvFLZYhNNHFe4TRV9p+QDqG64Pu72oLrHmpSScGBkZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HBwcvFSA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739964562;
	bh=tN6WEDR1AiRFyMbMUMu3VS4saSRBZMCNYL/A1DybkbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HBwcvFSAJBqL0cqZaEXuOVDLwC85LkTybMrZkelTOGsFm/2GE5cwAP1wxNpgIC5oB
	 03D8YMmlDT44THbtloNW03EnzqJeRHjglYQTj/in5ZLYwdtA4WgTKAvNJVBLJ+DoAA
	 ccS6oJk05pETwYZTtQBcvxgpKnKFsGR9t1NgDx7E/szT1L47y9GI3UFJBpV/cKf4d0
	 bOR9db3RnHE2GnWL6T3mmqS7tvICsitVxqvmR0FH4tg7vkhclcvbpMWz1dT7ZMgtTb
	 clhwNcAOXlNpWAKpI1h4jjNNqHd/0vSPS+udXawIXharMCWecWWd8HpAgPvonA2WtL
	 BC6Qr2w9BtSxg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A7E617E00F0;
	Wed, 19 Feb 2025 12:29:21 +0100 (CET)
Message-ID: <1dc0da53-0bc1-41f2-8478-f72bd0f33115@collabora.com>
Date: Wed, 19 Feb 2025 12:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ASoC: mediatek: mt8188: Add reference for dmic clocks
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-2-6bc653da60f7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250218-genio700-dmic-v1-2-6bc653da60f7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/02/25 21:52, Nícolas F. R. A. Prado ha scritto:
> Add the names for the dmic clocks, aud_afe_dmic* and aud_dmic_hires*, so
> they can be acquired and enabled by the platform driver.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 8 ++++++++
>   sound/soc/mediatek/mt8188/mt8188-afe-clk.h | 8 ++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> index e69c1bb2cb239596dee50b166c20192d5408be10..44c25b6e3d873448163b22e70f5b94cb5070654d 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> @@ -58,6 +58,14 @@ static const char *aud_clks[MT8188_CLK_NUM] = {
>   	[MT8188_CLK_AUD_ADC] = "aud_adc",
>   	[MT8188_CLK_AUD_DAC_HIRES] = "aud_dac_hires",
>   	[MT8188_CLK_AUD_A1SYS_HP] = "aud_a1sys_hp",
> +	[MT8188_CLK_AUD_AFE_DMIC1] = "aud_afe_dmic1",
> +	[MT8188_CLK_AUD_AFE_DMIC2] = "aud_afe_dmic2",
> +	[MT8188_CLK_AUD_AFE_DMIC3] = "aud_afe_dmic3",
> +	[MT8188_CLK_AUD_AFE_DMIC4] = "aud_afe_dmic4",
> +	[MT8188_CLK_AUD_DMIC_HIRES1] = "aud_dmic_hires1",
> +	[MT8188_CLK_AUD_DMIC_HIRES2] = "aud_dmic_hires2",
> +	[MT8188_CLK_AUD_DMIC_HIRES3] = "aud_dmic_hires3",
> +	[MT8188_CLK_AUD_DMIC_HIRES4] = "aud_dmic_hires4",
>   	[MT8188_CLK_AUD_ADC_HIRES] = "aud_adc_hires",
>   	[MT8188_CLK_AUD_I2SIN] = "aud_i2sin",
>   	[MT8188_CLK_AUD_TDM_IN] = "aud_tdm_in",
> diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
> index ec53c171c170a8b4b47900e63ef79d53641e9b12..68c46feb72271b950d4e538f63cedf524354147e 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
> +++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
> @@ -54,6 +54,14 @@ enum {
>   	MT8188_CLK_AUD_ADC,
>   	MT8188_CLK_AUD_DAC_HIRES,
>   	MT8188_CLK_AUD_A1SYS_HP,
> +	MT8188_CLK_AUD_AFE_DMIC1,
> +	MT8188_CLK_AUD_AFE_DMIC2,
> +	MT8188_CLK_AUD_AFE_DMIC3,
> +	MT8188_CLK_AUD_AFE_DMIC4,
> +	MT8188_CLK_AUD_DMIC_HIRES1,
> +	MT8188_CLK_AUD_DMIC_HIRES2,
> +	MT8188_CLK_AUD_DMIC_HIRES3,
> +	MT8188_CLK_AUD_DMIC_HIRES4,
>   	MT8188_CLK_AUD_ADC_HIRES,

Following the comments from audsys, put those after CLK_AUD_ADC_HIRES.

Cheers,
Angelo

>   	MT8188_CLK_AUD_I2SIN,
>   	MT8188_CLK_AUD_TDM_IN,
> 


