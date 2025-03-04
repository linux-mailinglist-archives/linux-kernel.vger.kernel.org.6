Return-Path: <linux-kernel+bounces-544762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA1A4E58F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BDA3BFE00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2758298CA1;
	Tue,  4 Mar 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cVjvZFOO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEDF204697;
	Tue,  4 Mar 2025 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102778; cv=none; b=ZEP2cCHVUmcXQRjtdNR/0eLw7Rd59HWyeHlNtKjdewnbXajLNlMIM+pzjvPMWtxp//qIrxEZlTFiKGrJUKXQMuhbipPypxymV/uFnO8vJyf95OSVDJu2HqalvxQyh0A/ap6qcrRafOR1DB1V1Q2+iCOM2Ef4K9ypq4XJkvucPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102778; c=relaxed/simple;
	bh=rTHmT8TPyQxFKshMV+NQu7E2dxKgvKj/LvmOG4VU9oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlnCNLtEIp0/kQUl7IaAm3Ra7XLwGEI3eqlBJn2SA02s2UBJ2sNHSK8Mvg3nGmjf7ITIQCvxA1yxcb27wPj1w3rtrq7mKKHwWef7itCukxbyl+BzvtxZoMUeNcE/I5JfvQNzuqv3lhk1nyYowZTRjUGKXlARVoGeQC3a3q616e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cVjvZFOO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741102774;
	bh=rTHmT8TPyQxFKshMV+NQu7E2dxKgvKj/LvmOG4VU9oY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cVjvZFOOXNP5ur8KYe6/kegXSszckIo+mMM+zkWOZ/119TzPiTpmuCTjOW5jXnQwY
	 mClRlZKwAoI/WqSgONgZp4AD+S8wm/IT++GZbg6xFOC5pgGGa3XumVxCUT7pfeM03g
	 LXnYh8FNvU+mg8qAhgmmBRi+2cAN5oDfpjlEg1yoBEjGCuWPs6WyUGEdjX/NpNr3H5
	 gPNyqWEVSSbvRqrQQDV8tfOVpbbXsZsRUlXWCR04A4b/c1Lep7bEmIskFuj/WWPw5x
	 /R3usM2B5r9V6Z7G+0gWx26Ye5p9QqaimHhvT6jucLLcz/3QQCT14HwK+GVzjWDP1B
	 1WygIuFL+HwKA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9257D17E087F;
	Tue,  4 Mar 2025 16:39:33 +0100 (CET)
Message-ID: <d976b28d-f44f-4d51-8b61-4c046c571412@collabora.com>
Date: Tue, 4 Mar 2025 16:39:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: mediatek: mt8188-mt6359: Add headset jack
 detect support
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Trevor Wu <trevor.wu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Zoran Zhan <zoran.zhan@mediatek.com>
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
 <20250214-mt8188-accdet-v1-3-6bbd5483855b@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250214-mt8188-accdet-v1-3-6bbd5483855b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/25 16:14, Nícolas F. R. A. Prado ha scritto:
> Enable headset jack detection for MT8188 platforms using the MT6359
> ACCDET block for it.
> 
> Co-developed-by: Zoran Zhan <zoran.zhan@mediatek.com>
> Signed-off-by: Zoran Zhan <zoran.zhan@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 43 +++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> index 2d0d04e0232da07ba43a030b14853322427d55e7..4e19e6cfad1e1f42863b2e2f27131f880c5883bf 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> @@ -17,6 +17,7 @@
>   #include "mt8188-afe-common.h"
>   #include "../../codecs/nau8825.h"
>   #include "../../codecs/mt6359.h"
> +#include "../../codecs/mt6359-accdet.h"
>   #include "../../codecs/rt5682.h"
>   #include "../common/mtk-afe-platform-driver.h"
>   #include "../common/mtk-soundcard-driver.h"
> @@ -266,6 +267,17 @@ static struct snd_soc_jack_pin nau8825_jack_pins[] = {
>   	},
>   };
>   
> +static struct snd_soc_jack_pin mt8188_headset_jack_pins[] = {

This is the same as nau8825_jack_pins... perhaps we could reuse that?

> +	{
> +		.pin    = "Headphone",
> +		.mask   = SND_JACK_HEADPHONE,
> +	},
> +	{
> +		.pin    = "Headset Mic",
> +		.mask   = SND_JACK_MICROPHONE,
> +	},
> +};
> +
>   static const struct snd_kcontrol_new mt8188_dumb_spk_controls[] = {
>   	SOC_DAPM_PIN_SWITCH("Ext Spk"),
>   };
> @@ -500,6 +512,35 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>   	return 0;
>   }
>   
> +static int mt8188_mt6359_accdet_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
> +	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8188_JACK_HEADSET];
> +	int ret;
> +
> +	if (!soc_card_data->accdet)
> +		return 0;

I'm not sure... if we have mediatek,accdet (so accdet is present here), but we also
have a NAU8825, or RT5682S, or ES8326 codec, this function will create a headset
jack for MT6359, but then mt8188_headset_codec_init() will do the same again!

I think we should find a way to avoid that situation, as I'm mostly sure that this
will give issues in the long run.

Even if it wouldn't, having two headset jacks exposed, of which one doesn't work
because it doesn't exist on the physical board... would be confusing for the user.

I guess that the best option here would be:
  - Let the `for_each_card_prelinks()` loop finish
  - Check if any of the external codecs are providing 3.5mm jack
    - External codec providing jack means that the detection should be performed
      by the external codec, as the jack should not be physically routed to the
      MediaTek ACCDET related PMIC pins (right?)
    - No external codec means that the accessory detection can only be performed
      by the MediaTek ACCDET IP
  - If external codec manages 3.5mm jack: do nothing
  - If no external codec managing 3.5mm jack: check if accdet provided in DT and
    initialize it

....unless I'm wrong - and if I am, please explain why (and also add explanation
to the commit description).

Cheers,
Angelo

> +
> +	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
> +				   SND_JACK_HEADSET | SND_JACK_BTN_0 |
> +				   SND_JACK_BTN_1 | SND_JACK_BTN_2 |
> +				   SND_JACK_BTN_3,
> +				   jack, mt8188_headset_jack_pins,
> +				   ARRAY_SIZE(mt8188_headset_jack_pins));
> +	if (ret) {
> +		dev_err(rtd->dev, "Headset Jack create failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mt6359_accdet_enable_jack_detect(soc_card_data->accdet, jack);
> +	if (ret) {
> +		dev_err(rtd->dev, "Headset Jack enable failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int mt8188_mt6359_init(struct snd_soc_pcm_runtime *rtd)
>   {
>   	struct snd_soc_component *cmpnt_codec =
> @@ -512,6 +553,8 @@ static int mt8188_mt6359_init(struct snd_soc_pcm_runtime *rtd)
>   	/* mtkaif calibration */
>   	mt8188_mt6359_mtkaif_calibration(rtd);
>   
> +	mt8188_mt6359_accdet_init(rtd);
> +
>   	return 0;
>   }
>   
> 

