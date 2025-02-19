Return-Path: <linux-kernel+bounces-521404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8BBA3BCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9967517117F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C61DF732;
	Wed, 19 Feb 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MIBNWvZG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE441DED5A;
	Wed, 19 Feb 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964561; cv=none; b=BE4mxjfU/25BrpylWYptFFuh/6ovHT+02uZ3O+yUpheE7zctXHRfFS4xZ3cH0NgLM/CFg/Fbi/zDRZe/L/gWmokyN5AZFv4o2SbVS4+ph1M6X276D3JyG2pEYQXrS3tAAsKxH29wnCTCH1bLxRKsoeQLah4XqesCMqiPqJCeszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964561; c=relaxed/simple;
	bh=vAETPhUxCaltgz1xm31LvU7WGrPLwGNUSW3Own/EjBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soc8xU5FePGmtZi+18pui6ogNGc5kMdyaiE+E7dJQMROoiZfDu6vFJqO1lxyuBhnJMJ/dIkXxcHsuwvSLa31aEJvtwB3YHshIEXTrkfUvc7YRxlQC3Vgf7hCkj+Yyj9YxQk8hrxgO7suuBw58Q/WAv7mabWkcTvQv7jmYjeHPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MIBNWvZG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739964556;
	bh=vAETPhUxCaltgz1xm31LvU7WGrPLwGNUSW3Own/EjBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MIBNWvZGklJTbBeYx4VtblF3mpZlJdSAX52NyDcoH3SbWiWmNtaQJ81tOdo4qkGls
	 syE7eatlgX3/uvqdMIOnsngF3k+pDtJ3Kdc41GqDOXZiRkGTVWeFa+KRauTRCY4Stu
	 IjkA4BMZjAU/9ijwb6pylqDEANBS55IeCDPnENGgg8XgoVXoPQUGj1A461rTktk8RE
	 +VGgSLTIOK/3rx1scUSP8V9dRecUzSY5j/wPVOEiV/gTAOaVZBCecbImFcpQ9e55fL
	 XpZIp5GBrB4fWtJF3aDyDYPG/Z06CK7DBER5D08+fmYo3SmpPzKEC+DdJGdYOKS/XV
	 yw5RctcA2FDXQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B9BE017E14D5;
	Wed, 19 Feb 2025 12:29:15 +0100 (CET)
Message-ID: <5ab4375d-f08b-4d55-b056-6f7b034b1607@collabora.com>
Date: Wed, 19 Feb 2025 12:29:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ASoC: mediatek: mt8188: Add DMIC DAI driver
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 parkeryang <Parker.Yang@mediatek.com>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-3-6bc653da60f7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250218-genio700-dmic-v1-3-6bc653da60f7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/02/25 21:52, Nícolas F. R. A. Prado ha scritto:
> From: parkeryang <Parker.Yang@mediatek.com>
> 
> Add support for the DMIC DAIs present on the MT8188 SoC.
> 
> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> Co-developed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-afe-pcm.c  |   4 -
>   sound/soc/mediatek/mt8188/mt8188-dai-dmic.c | 754 ++++++++++++++++++++++++++++
>   sound/soc/mediatek/mt8188/mt8188-reg.h      |  18 +-
>   3 files changed, 770 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
> index 73e5c63aeec8783905d656af225c42cd95069049..d36520c6272dd8c8302bc3f59da33f82f273f366 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
> @@ -2855,10 +2855,6 @@ static bool mt8188_is_volatile_reg(struct device *dev, unsigned int reg)
>   	case AFE_DMIC3_SRC_DEBUG_MON0:
>   	case AFE_DMIC3_UL_SRC_MON0:
>   	case AFE_DMIC3_UL_SRC_MON1:
> -	case DMIC_GAIN1_CUR:
> -	case DMIC_GAIN2_CUR:
> -	case DMIC_GAIN3_CUR:
> -	case DMIC_GAIN4_CUR:

Why are you removing those?!

If you really have to, that goes into a different commit.

>   	case ETDM_IN1_MONITOR:
>   	case ETDM_IN2_MONITOR:
>   	case ETDM_OUT1_MONITOR:
> diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9df08783ff80173095809c20538d0fb073ed7fae
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
> @@ -0,0 +1,754 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek ALSA SoC Audio DAI DMIC I/F Control
> + *
> + * Copyright (c) 2020 MediaTek Inc.
> + * Author: Bicycle Tsai <bicycle.tsai@mediatek.com>
> + *         Trevor Wu <trevor.wu@mediatek.com>
> + *         Parker Yang <parker.yang@mediatek.com>
> + */
> +

..snip..

> +
> +static void mtk_dai_dmic_hw_gain_on(struct mtk_base_afe *afe,
> +				    unsigned int id, bool on)
> +{
> +	const struct mtk_dai_dmic_hw_gain_ctrl_reg *reg;
> +	unsigned int msk = DMIC_GAIN_CON0_GAIN_ON;

msk never changes here, just use that definition directly in the regmap calls
below.... and also, reg can be NULL, but you're not checking that, which may
result in a kernel panic.

So this function should look like....

static void mtk_dai_dmic_hw_gain_on(struct mtk_base_afe *afe,
				    unsigned int id, bool on)
{
	const struct mtk_dai_dmic_hw_gain_ctrl_reg *reg = get_dmic_hw_gain_ctrl_reg(afe, id);

	if (!reg)
		return;

	if (on)
		regmap_set_bits(afe->regmap, reg->con0, DMIC_GAIN_CON0_GAIN_ON);
	else
		regmap_clear_bits( ....)
};


> +
> +	reg = get_dmic_hw_gain_ctrl_reg(afe, id);
> +	if (!reg)
> +		return;
> +
> +	if (on)
> +		regmap_set_bits(afe->regmap, reg->con0, msk);
> +	else
> +		regmap_clear_bits(afe->regmap, reg->con0, msk);
> +}
> +

..snip..

> +
> +static int mtk_dai_dmic_configure_array(struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_dmic_priv *dmic_priv = NULL;
> +	unsigned int mask =
> +			PWR2_TOP_CON_DMIC8_SRC_SEL_MASK |
> +			PWR2_TOP_CON_DMIC7_SRC_SEL_MASK |
> +			PWR2_TOP_CON_DMIC6_SRC_SEL_MASK |
> +			PWR2_TOP_CON_DMIC5_SRC_SEL_MASK |
> +			PWR2_TOP_CON_DMIC4_SRC_SEL_MASK |
> +			PWR2_TOP_CON_DMIC3_SRC_SEL_MASK |
> +			PWR2_TOP_CON_DMIC2_SRC_SEL_MASK |
> +			PWR2_TOP_CON_DMIC1_SRC_SEL_MASK;

const u32 mask = ....

> +	unsigned int val = 0;

const u32 val = PWR2_TOP_CON ......

> +
> +	if (dai->id < 0)
> +		return -EINVAL;
> +
> +	dmic_priv = afe_priv->dai_priv[dai->id];
> +	val = PWR2_TOP_CON_DMIC8_SRC_SEL_VAL(DMIC8_SRC_SEL) |
> +	      PWR2_TOP_CON_DMIC7_SRC_SEL_VAL(DMIC7_SRC_SEL) |
> +	      PWR2_TOP_CON_DMIC6_SRC_SEL_VAL(DMIC6_SRC_SEL) |
> +	      PWR2_TOP_CON_DMIC5_SRC_SEL_VAL(DMIC5_SRC_SEL) |
> +	      PWR2_TOP_CON_DMIC4_SRC_SEL_VAL(DMIC4_SRC_SEL) |
> +	      PWR2_TOP_CON_DMIC3_SRC_SEL_VAL(DMIC3_SRC_SEL) |
> +	      PWR2_TOP_CON_DMIC2_SRC_SEL_VAL(DMIC2_SRC_SEL) |
> +	      PWR2_TOP_CON_DMIC1_SRC_SEL_VAL(DMIC1_SRC_SEL);
> +
> +	regmap_update_bits(afe->regmap, PWR2_TOP_CON0, mask, val);
> +
> +	return 0;
> +}
> +
> +static void mtk_dai_dmic_hw_gain_enable(struct mtk_base_afe *afe,
> +					unsigned int channels, bool enable)
> +{
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_dmic_priv *dmic_priv;
> +	unsigned int end;
> +	unsigned int id;
> +
> +	if (!channels)
> +		return;
> +
> +	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
> +	if (channels > 3)
> +		end = 3;

	else
		end = channels - 1;

way shorter :-)

> +	else if (channels > 2)
> +		end = 2;
> +	else if (channels > 1)
> +		end = 1;
> +	else if (channels > 0)
> +		end = 0;
> +
> +	for (id = DMIC0; id <= end; id++) {
> +		if (enable && dmic_priv->gain_on[id]) {
> +			mtk_dai_dmic_hw_gain_byass(afe, id, false);

by...what? LOL! :-)

That typo is hilarious, but still fix it.

> +			mtk_dai_dmic_hw_gain_on(afe, id, true);
> +		} else {
> +			mtk_dai_dmic_hw_gain_on(afe, id, false);
> +			mtk_dai_dmic_hw_gain_byass(afe, id, true);
> +		}
> +	}
> +}
> +
> +static int mtk_dmic_gain_event(struct snd_soc_dapm_widget *w,
> +			       struct snd_kcontrol *kcontrol,
> +			       int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_dmic_priv *dmic_priv = NULL;
> +	unsigned int channels;
> +
> +	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
> +		__func__, w->name, event);
> +
> +	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
> +	channels = dmic_priv->channels;

Either you check if afe_priv is NULL before assigning, or just stack-assign these.

> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		mtk_dai_dmic_hw_gain_enable(afe, channels, true);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		mtk_dai_dmic_hw_gain_enable(afe, channels, false);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_dmic_event(struct snd_soc_dapm_widget *w,
> +			  struct snd_kcontrol *kcontrol,
> +			  int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_dmic_priv *dmic_priv = NULL;
> +	const struct mtk_dai_dmic_ctrl_reg *reg = NULL;
> +	unsigned int channels;
> +	unsigned int msk;

	u8 dmic_num;

> +
> +	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
> +		__func__, w->name, event);
> +
> +	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
> +	channels = dmic_priv->channels;
> +

if (channels == 0) {
	dev_dbg(something);
	return -EINVAL;
}



/* This function assumes that the caller checked that channels is valid */
static u8 mtk_dmic_channels_to_dmic_number_or_another_name_you_choose(unsigned int 
channels)
{
	switch (channels) {
	case 1:
		return DMIC0;
	case 2:
		return DMIC1;
	case 3:
		return DMIC2;
	case 4:
	default:
		return DMIC3;
	}
}


dmic_num = mtk_dmic_channels_to_dmic_number_or_another_name_you_choose(channels);

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		/* request fifo soft rst */
> +		msk = 0;

for (i = dmic_num; i > 0; i--)
	msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);

> +		if (channels > 3)
> +			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC3);
> +		if (channels > 2)
> +			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC2);
> +		if (channels > 1)
> +			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC1);
> +		if (channels > 0)
> +			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC0);
> +
> +		regmap_set_bits(afe->regmap, PWR2_TOP_CON1, msk);
> +
> +		msk = 0;

msk = AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL |
       AFE_DMIC_UL ....

> +		msk |= AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL;
> +		msk |= AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL;
> +		msk |= AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL;
> +		msk |= AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL;
> +

reg = get_dmic_ctrl_reg(dmic_num);
if (reg)
	regmap_set_bits .....

> +		if (channels > 3) {
> +			reg = get_dmic_ctrl_reg(DMIC3);
> +			if (reg)
> +				regmap_set_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 2) {
> +			reg = get_dmic_ctrl_reg(DMIC2);
> +			if (reg)
> +				regmap_set_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 1) {
> +			reg = get_dmic_ctrl_reg(DMIC1);
> +			if (reg)
> +				regmap_set_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 0) {
> +			reg = get_dmic_ctrl_reg(DMIC0);
> +			if (reg)
> +				regmap_set_bits(afe->regmap, reg->con0, msk);
> +		}
> +		break;
> +	case SND_SOC_DAPM_POST_PMU:
> +		msk = AFE_DMIC_UL_SRC_CON0_UL_SRC_ON_TMP_CTL;

same comments apply here.

> +		if (channels > 3) {
> +			reg = get_dmic_ctrl_reg(DMIC3);
> +			if (reg)
> +				regmap_set_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 2) {
> +			reg = get_dmic_ctrl_reg(DMIC2);
> +			if (reg)
> +				regmap_set_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 1) {
> +			reg = get_dmic_ctrl_reg(DMIC1);
> +			if (reg)
> +				regmap_set_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 0) {
> +			reg = get_dmic_ctrl_reg(DMIC0);
> +			if (reg)
> +				regmap_set_bits(afe->regmap, reg->con0, msk);
> +		}
> +
> +		if (dmic_priv->hires_required) {
> +			mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES1]);
> +			mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES2]);
> +			mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES3]);
> +			mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES4]);
> +		}
> +
> +		mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC1]);
> +		mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC2]);
> +		mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC3]);
> +		mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC4]);
> +
> +		/* release fifo soft rst */
> +		msk = 0;

for (i = dmic_num; i .... same as before
msk |= MACRO(i)

> +		if (channels > 3)
> +			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC3);
> +		if (channels > 2)
> +			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC2);
> +		if (channels > 1)
> +			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC1);
> +		if (channels > 0)
> +			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC0);
> +
> +		regmap_clear_bits(afe->regmap, PWR2_TOP_CON1, msk);
> +		break;
> +	case SND_SOC_DAPM_PRE_PMD:
> +		msk =  AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL |
> +			AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL |
> +			AFE_DMIC_UL_SRC_CON0_UL_SRC_ON_TMP_CTL |
> +			AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL |
> +			AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL;
> +

same fixes apply here.

> +		if (channels > 3) {
> +			reg = get_dmic_ctrl_reg(DMIC3);
> +			if (reg)
> +				regmap_clear_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 2) {
> +			reg = get_dmic_ctrl_reg(DMIC2);
> +			if (reg)
> +				regmap_clear_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 1) {
> +			reg = get_dmic_ctrl_reg(DMIC1);
> +			if (reg)
> +				regmap_clear_bits(afe->regmap, reg->con0, msk);
> +		}
> +		if (channels > 0) {
> +			reg = get_dmic_ctrl_reg(DMIC0);
> +			if (reg)
> +				regmap_clear_bits(afe->regmap, reg->con0, msk);
> +		}
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		/* should delayed 1/fs(smallest is 8k) = 125us before afe off */
> +		usleep_range(125, 126);
> +
> +		mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC1]);
> +		mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC2]);
> +		mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC3]);
> +		mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC4]);
> +
> +		if (dmic_priv->hires_required) {
> +			mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES1]);
> +			mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES2]);
> +			mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES3]);
> +			mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES4]);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_dai_dmic_hw_params(struct snd_pcm_substream *substream,
> +				  struct snd_pcm_hw_params *params,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_dmic_priv *dmic_priv = NULL;
> +	unsigned int rate = params_rate(params);
> +	unsigned int channels = params_channels(params);
> +	const struct mtk_dai_dmic_ctrl_reg *reg = NULL;
> +	unsigned int val = 0;
> +	unsigned int msk = 0;
> +
> +	if (dai->id < 0)
> +		return -EINVAL;
> +
> +	dmic_priv = afe_priv->dai_priv[dai->id];
> +
> +	val = AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_CH1(CLK_PHASE_SEL_CH1) |
> +	      AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_CH2(CLK_PHASE_SEL_CH2) |
> +	      AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL(0);
> +	msk = AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL_MASK |
> +	      AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_MASK |
> +	      AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL_MASK |
> +	      AFE_DMIC_UL_VOICE_MODE_MASK;

double assignment of both val and msk. fix it.

> +
> +	mtk_dai_dmic_configure_array(dai);
> +	dmic_priv->hires_required = 0;

repeat that assignment in all rate cases, don't do double assignments.

> +
> +	switch (rate) {
> +	case 96000:
> +		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_96K;
> +		dmic_priv->hires_required = 1;
> +		break;
> +	case 48000:
> +		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_48K;
> +		break;
> +	case 32000:
> +		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_32K;
> +		break;
> +	case 16000:
> +		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_16K;
> +		break;
> +	case 8000:
> +		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_8K;
> +		break;
> +	default:
> +		dev_dbg(afe->dev, "%s invalid rate %u, use 48000Hz\n", __func__, rate);
> +		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_48K;
> +		break;
> +	}
> +
> +	mtk_dai_dmic_load_iir_coeff_table(afe);
> +
> +	if (channels > 3) {

simplify that with the same comments as before... or actually you could even
commonize that pattern, as it seems to be duplicated over and over again.

> +		reg = get_dmic_ctrl_reg(DMIC3);
> +		if (reg)
> +			regmap_update_bits(afe->regmap, reg->con0, msk, val);
> +	}
> +	if (channels > 2) {
> +		reg = get_dmic_ctrl_reg(DMIC2);
> +		if (reg)
> +			regmap_update_bits(afe->regmap, reg->con0, msk, val);
> +	}
> +	if (channels > 1) {
> +		reg = get_dmic_ctrl_reg(DMIC1);
> +		if (reg)
> +			regmap_update_bits(afe->regmap, reg->con0, msk, val);
> +	}
> +	if (channels > 0) {
> +		reg = get_dmic_ctrl_reg(DMIC0);
> +		if (reg)
> +			regmap_update_bits(afe->regmap, reg->con0, msk, val);
> +	}
> +
> +	dmic_priv->channels = channels;
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dai_ops mtk_dai_dmic_ops = {
> +	.hw_params	= mtk_dai_dmic_hw_params,
> +};
> +
> +#define MTK_DMIC_RATES (SNDRV_PCM_RATE_8000 |\
> +		       SNDRV_PCM_RATE_16000 |\
> +		       SNDRV_PCM_RATE_32000 |\
> +		       SNDRV_PCM_RATE_48000 |\
> +		       SNDRV_PCM_RATE_96000)
> +
> +#define MTK_DMIC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			 SNDRV_PCM_FMTBIT_S32_LE)
> +
> +static struct snd_soc_dai_driver mtk_dai_dmic_driver[] = {
> +	{
> +		.name = "DMIC",
> +		.id = MT8188_AFE_IO_DMIC_IN,
> +		.capture = {
> +			.stream_name = "DMIC Capture",
> +			.channels_min = 1,
> +			.channels_max = 8,
> +			.rates = MTK_DMIC_RATES,
> +			.formats = MTK_DMIC_FORMATS,
> +		},
> +		.ops = &mtk_dai_dmic_ops,
> +	},
> +};
> +

..snip..

> +
> +static int mtk_dai_dmic_hw_gain_ctrl_put(struct snd_kcontrol *kcontrol,
> +					 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_dmic_priv *dmic_priv;
> +	unsigned int source = ucontrol->value.enumerated.item[0];
> +	unsigned int *cached = 0;

Why are you initializing *cached?

There's no way it can be used uninitialized in this function, as if anything is
wrong you're either returning -EINVAL or assigning `source` to it later.

> +
> +	if (source >= e->items)
> +		return -EINVAL;
> +
> +	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
> +
> +	if (!strcmp(kcontrol->id.name, "DMIC1_HW_GAIN_EN"))
> +		cached = &dmic_priv->gain_on[0];
> +	else if (!strcmp(kcontrol->id.name, "DMIC2_HW_GAIN_EN"))
> +		cached = &dmic_priv->gain_on[1];
> +	else if (!strcmp(kcontrol->id.name, "DMIC3_HW_GAIN_EN"))
> +		cached = &dmic_priv->gain_on[2];
> +	else if (!strcmp(kcontrol->id.name, "DMIC4_HW_GAIN_EN"))
> +		cached = &dmic_priv->gain_on[3];
> +	else
> +		return -EINVAL;
> +
> +	if (source == *cached)
> +		return 0;
> +
> +	*cached = source;
> +	return 1;
> +}
> +
> +static int mtk_dai_dmic_hw_gain_ctrl_get(struct snd_kcontrol *kcontrol,
> +					 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
> +	struct mt8188_afe_private *afe_priv = afe->platform_priv;
> +	struct mtk_dai_dmic_priv *dmic_priv;
> +	unsigned int val = 0;

double assignment again

> +
> +	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];

stack initialize dmic_priv instead.

> +
> +	if (!strcmp(kcontrol->id.name, "DMIC1_HW_GAIN_EN"))
> +		val = dmic_priv->gain_on[0];
> +	else if (!strcmp(kcontrol->id.name, "DMIC2_HW_GAIN_EN"))
> +		val = dmic_priv->gain_on[1];
> +	else if (!strcmp(kcontrol->id.name, "DMIC3_HW_GAIN_EN"))
> +		val = dmic_priv->gain_on[2];
> +	else if (!strcmp(kcontrol->id.name, "DMIC4_HW_GAIN_EN"))
> +		val = dmic_priv->gain_on[3];

else
	val = 0;

> +
> +	ucontrol->value.enumerated.item[0] = val;
> +	return 0;
> +}
> +


..snip..

> diff --git a/sound/soc/mediatek/mt8188/mt8188-reg.h b/sound/soc/mediatek/mt8188/mt8188-reg.h
> index bdd885419ff3874bab80549ea3ff4617172b8245..4154548aca36108667036f9889476c30f9b6171a 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-reg.h
> +++ b/sound/soc/mediatek/mt8188/mt8188-reg.h
> @@ -2837,9 +2837,20 @@
>   #define PWR2_TOP_CON_DMIC3_SRC_SEL_MASK     GENMASK(16, 14)
>   #define PWR2_TOP_CON_DMIC2_SRC_SEL_MASK     GENMASK(13, 11)
>   #define PWR2_TOP_CON_DMIC1_SRC_SEL_MASK     GENMASK(10, 8)
> +#define PWR2_TOP_CON_DMIC8_SRC_SEL_VAL(x)   ((x) << 29)
> +#define PWR2_TOP_CON_DMIC7_SRC_SEL_VAL(x)   ((x) << 26)
> +#define PWR2_TOP_CON_DMIC6_SRC_SEL_VAL(x)   ((x) << 23)
> +#define PWR2_TOP_CON_DMIC5_SRC_SEL_VAL(x)   ((x) << 20)
> +#define PWR2_TOP_CON_DMIC4_SRC_SEL_VAL(x)   ((x) << 17)
> +#define PWR2_TOP_CON_DMIC3_SRC_SEL_VAL(x)   ((x) << 14)
> +#define PWR2_TOP_CON_DMIC2_SRC_SEL_VAL(x)   ((x) << 11)
> +#define PWR2_TOP_CON_DMIC1_SRC_SEL_VAL(x)   ((x) << 8)
>   
>   /* PWR2_TOP_CON1 */
> -#define PWR2_TOP_CON1_DMIC_CKDIV_ON        BIT(1)
> +#define PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(x)	BIT((5 + 6 * x))
> +#define PWR2_TOP_CON1_DMIC_CKDIV_ON             BIT(1)
> +#define PWR2_TOP_CON1_DMIC_CKDIV_ON_SHIFT       1
> +
>   
>   /* PCM_INTF_CON1 */
>   #define PCM_INTF_CON1_SYNC_OUT_INV     BIT(23)
> @@ -2919,15 +2930,17 @@
>   #define AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_CH2(x)	(((x) & 0x7) << 24)
>   #define AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_MASK		GENMASK(29, 24)
>   #define AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL	BIT(23)
> +#define AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL_MASK  BIT(23)

That's the same as AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL, drop it.

>   #define AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL	BIT(22)
>   #define AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL	BIT(21)
> -
> +#define AFE_DMIC_UL_VOICE_MODE(x)			(((x) & 0x7) << 17)

(((x) & GENMASK(2, 0) << 17)

>   #define AFE_DMIC_UL_VOICE_MODE_MASK			GENMASK(19, 17)
>   #define AFE_DMIC_UL_CON0_VOCIE_MODE_8K			AFE_DMIC_UL_VOICE_MODE(0)
>   #define AFE_DMIC_UL_CON0_VOCIE_MODE_16K			AFE_DMIC_UL_VOICE_MODE(1)
>   #define AFE_DMIC_UL_CON0_VOCIE_MODE_32K			AFE_DMIC_UL_VOICE_MODE(2)
>   #define AFE_DMIC_UL_CON0_VOCIE_MODE_48K			AFE_DMIC_UL_VOICE_MODE(3)
>   #define AFE_DMIC_UL_CON0_VOCIE_MODE_96K			AFE_DMIC_UL_VOICE_MODE(4)
> +#define AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL(x)		(((x) & 0x7) << 7)

same here

>   #define AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL_MASK	GENMASK(9, 7)
>   #define AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL		BIT(10)
>   #define AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL		BIT(1)
> @@ -2944,6 +2957,7 @@
>   
>   /* DMIC_GAINx_CON0 */
>   #define DMIC_GAIN_CON0_GAIN_ON			BIT(0)
> +#define DMIC_GAIN_CON0_SAMPLE_PER_STEP_SHIFT	8
>   #define DMIC_GAIN_CON0_SAMPLE_PER_STEP_MASK	GENMASK(15, 8)
>   
>   /* DMIC_GAINx_CON1 */
> 


Cheers,
Angelo


