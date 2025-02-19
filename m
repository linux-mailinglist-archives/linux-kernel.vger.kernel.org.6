Return-Path: <linux-kernel+bounces-521408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D337A3BCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541AF7A772F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4081DFE32;
	Wed, 19 Feb 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ALgXkMpC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9C1DF25D;
	Wed, 19 Feb 2025 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964576; cv=none; b=MNimodOZwfabCylE0WxxEeVZWCV1Plcv3CLYCBW+H7WacZJTsLnMuMDq3fAlti5fDeVlvUM3LGLHjEFOezN0QVQodU6xnJfdHJtacWaMZmFq5JjklnM2etfMOVtFFR3rpttbtXxLweNpnywEsmCqm1v5M8fc4ACpE9FXrmS4D38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964576; c=relaxed/simple;
	bh=nIunaYmNY6dLMbhvaiWgmcAb/hSE9AiSrnJJ32wEXds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYE4e4w/oODdphygtQHBKJO/MuyteTsctJuKWAxqOl6CKHHbXwlU1kL9ErlZUNmt2LlYCBpmm12TVX/REm7XEp9sznfObvM3C3gosYN6MNxp+UWQcEM1MmlLYd8X8C89+AVWfGt7duFYE10XyOo1lyroOwm19WFE1hCTVlid0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ALgXkMpC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739964572;
	bh=nIunaYmNY6dLMbhvaiWgmcAb/hSE9AiSrnJJ32wEXds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ALgXkMpCetPWAO/3Eta1T7gOHhTLKbz45W0fIZKWkRwKysZBIDvWK/wjUdBbQcY/X
	 575dE/HvAkMk//ONjd/r0MgehqbacGigq6SNRWTM20tjT97Js4ZWdv8SjzY2UPHml2
	 ArLIoLTv5TxBshjXm3uHoxLwoQCvi8TvvhVPlpwxhOM3uTxXFSGlG5Q7ENkJh17Ova
	 tFTyL0hf6hA4brKssoYxBOV4KGmvF/jaH8/CVE7u88lc2GAE9VJD8xwedWdt6yT15e
	 rDYi3w5BxpJXap5/FvYGXn2aXFvLonKOkFrqWR3aX+awKnfC+pjCinmvh0ZYFzt3sM
	 mxVZw4zhrPHpQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 16C0217E00F0;
	Wed, 19 Feb 2025 12:29:32 +0100 (CET)
Message-ID: <214560ed-699e-4f1a-a562-8cd1f8e661bc@collabora.com>
Date: Wed, 19 Feb 2025 12:29:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ASoC: mediatek: mt8188: Add audsys hires clocks
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-1-6bc653da60f7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250218-genio700-dmic-v1-1-6bc653da60f7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/02/25 21:52, Nícolas F. R. A. Prado ha scritto:
> Describe and register the aud_dmic_hires audsys clocks, which are needed
> when recording the DMIC at a sample rate of 96k.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-audsys-clk.c   | 4 ++++
>   sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
> index c796ad8b62eeaa929f24c09755f428116b105404..e7b2c9da61f6b5dbe9002a294ebbb7f4415fe54c 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
> @@ -81,6 +81,10 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
>   	GATE_AUD1(CLK_AUD_AFE_DMIC2, "aud_afe_dmic2", "top_a1sys_hp", 11),
>   	GATE_AUD1(CLK_AUD_AFE_DMIC3, "aud_afe_dmic3", "top_a1sys_hp", 12),
>   	GATE_AUD1(CLK_AUD_AFE_DMIC4, "aud_afe_dmic4", "top_a1sys_hp", 13),
> +	GATE_AUD1(CLK_AUD_DMIC_HIRES1, "aud_dmic_hires1", "top_audio_h", 20),
> +	GATE_AUD1(CLK_AUD_DMIC_HIRES2, "aud_dmic_hires2", "top_audio_h", 21),
> +	GATE_AUD1(CLK_AUD_DMIC_HIRES3, "aud_dmic_hires3", "top_audio_h", 22),
> +	GATE_AUD1(CLK_AUD_DMIC_HIRES4, "aud_dmic_hires4", "top_audio_h", 23),
>   	GATE_AUD1(CLK_AUD_AFE_26M_DMIC_TM, "aud_afe_26m_dmic_tm", "top_a1sys_hp", 14),
>   	GATE_AUD1(CLK_AUD_UL_TML_HIRES, "aud_ul_tml_hires", "top_audio_h", 16),
>   	GATE_AUD1(CLK_AUD_ADC_HIRES, "aud_adc_hires", "top_audio_h", 17),
> diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
> index 6f34ffc760e03beddc3001046e554edd7ea2c478..820f2aef17ea40be1a80aece604b4a319934312f 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
> +++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
> @@ -30,6 +30,10 @@ enum{
>   	CLK_AUD_AFE_DMIC2,
>   	CLK_AUD_AFE_DMIC3,
>   	CLK_AUD_AFE_DMIC4,
> +	CLK_AUD_DMIC_HIRES1,
> +	CLK_AUD_DMIC_HIRES2,
> +	CLK_AUD_DMIC_HIRES3,
> +	CLK_AUD_DMIC_HIRES4,
>   	CLK_AUD_AFE_26M_DMIC_TM,
>   	CLK_AUD_UL_TML_HIRES,
>   	CLK_AUD_ADC_HIRES,

Please either put it after CLK_AUD_ADC_HIRES, which corresponds to the end of AUD1
and also orders that alphabetically.

Same for the addition in audsys-clk.c, that would order the clocks also per bit.

Thanks,
Angelo







