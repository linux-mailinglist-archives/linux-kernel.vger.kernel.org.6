Return-Path: <linux-kernel+bounces-531670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B57A44364
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C74176327
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB04274241;
	Tue, 25 Feb 2025 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZO2QbpmM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20CE26FD82;
	Tue, 25 Feb 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494524; cv=none; b=j04eyLka+Q+g3upcMWx6O+VR8Wq+sIYzsFg1qhYQGXQ1BOU/WiUf/6q1ra47K4XOZT20Kshjc2rdtF5Z0oCV41oRgoSwSaZPUQOVbDvgOc3ob3Tqm1QFlYuEkIrObVaM55GEpPatFQSiUKk2JrQFduVVLS23jJJ5MUBDpsYl7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494524; c=relaxed/simple;
	bh=HfTj5K9Kjj+z5exhuyb8N2wVDV/qu3WxEJW/q8QSD6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMAFcHDTfAzpaU4ygD0O+gAnk5yIMk0iiP3fQVBd0cK1pns1x8P8r8ks1+jpf2BddcIc9J07gLMWhmT1+n/D4+jtaM2pKB9575o3pZQ3n+4h4tLcHS/hgNkvOFi7wcjrSQRrvQPQiQK6qCq9xlF9G2MqO1oNH9I1y/q67LgWEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZO2QbpmM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494521;
	bh=HfTj5K9Kjj+z5exhuyb8N2wVDV/qu3WxEJW/q8QSD6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZO2QbpmMUpNVhvsrZelu+P5KHnWA9JLuq5mB+DNwu9jzh6np56CMors6MuuU5BYNQ
	 qTcApVXJ+jXzhYyExUzIdQuNvScXRyLM+iU+WCNBqn+PHsbvF0ziLgqa+CQbDI97I3
	 He4GS6mZXSvWXlXmFeXvu/kRQSLz5MtzASQCIkKTH335dP0DR3RBCadLEmsJ6p9B+S
	 ciLHsybTC7UUJpmUO6HkLs+QeI8N7vC542vW4QTU8xjGAGwzkVoRUxmptFkZVmQ+Ys
	 8La6q6JxOluCZMBIWKN8W/2gb6f5eCZebzXEi8WOE8hjAnmSKxlsn/aJEAe2+9BU1Q
	 1GDGtjXCg8XSg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4FE0217E0E91;
	Tue, 25 Feb 2025 15:42:00 +0100 (CET)
Message-ID: <7ca0eb8a-de9d-48a1-87ca-f563c607929c@collabora.com>
Date: Tue, 25 Feb 2025 15:42:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] ASoC: mediatek: mt8188: Add audsys hires clocks
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
 <20250225-genio700-dmic-v2-1-3076f5b50ef7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-genio700-dmic-v2-1-3076f5b50ef7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/02/25 15:33, Nícolas F. R. A. Prado ha scritto:
> Describe and register the aud_dmic_hires audsys clocks, which are needed
> when recording the DMIC at a sample rate of 96k.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8188/mt8188-audsys-clk.c   | 4 ++++
>   sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
> index c796ad8b62eeaa929f24c09755f428116b105404..40d2ab0a7677b64985f9fc9eb38f67bca7ecd4f9 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
> @@ -84,6 +84,10 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
>   	GATE_AUD1(CLK_AUD_AFE_26M_DMIC_TM, "aud_afe_26m_dmic_tm", "top_a1sys_hp", 14),
>   	GATE_AUD1(CLK_AUD_UL_TML_HIRES, "aud_ul_tml_hires", "top_audio_h", 16),
>   	GATE_AUD1(CLK_AUD_ADC_HIRES, "aud_adc_hires", "top_audio_h", 17),
> +	GATE_AUD1(CLK_AUD_DMIC_HIRES1, "aud_dmic_hires1", "top_audio_h", 20),
> +	GATE_AUD1(CLK_AUD_DMIC_HIRES2, "aud_dmic_hires2", "top_audio_h", 21),
> +	GATE_AUD1(CLK_AUD_DMIC_HIRES3, "aud_dmic_hires3", "top_audio_h", 22),
> +	GATE_AUD1(CLK_AUD_DMIC_HIRES4, "aud_dmic_hires4", "top_audio_h", 23),
>   
>   	/* AUD3 */
>   	GATE_AUD3(CLK_AUD_LINEIN_TUNER, "aud_linein_tuner", "top_apll5", 5),
> diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
> index 6f34ffc760e03beddc3001046e554edd7ea2c478..9cb732863c104383b9859b4bb5b3f5c289ad1864 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
> +++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
> @@ -33,6 +33,10 @@ enum{
>   	CLK_AUD_AFE_26M_DMIC_TM,
>   	CLK_AUD_UL_TML_HIRES,
>   	CLK_AUD_ADC_HIRES,
> +	CLK_AUD_DMIC_HIRES1,
> +	CLK_AUD_DMIC_HIRES2,
> +	CLK_AUD_DMIC_HIRES3,
> +	CLK_AUD_DMIC_HIRES4,
>   	CLK_AUD_LINEIN_TUNER,
>   	CLK_AUD_EARC_TUNER,
>   	CLK_AUD_I2SIN,
> 



