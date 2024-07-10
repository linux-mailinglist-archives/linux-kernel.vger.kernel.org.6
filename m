Return-Path: <linux-kernel+bounces-247421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9BA92CF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5F9B23CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511818FDB7;
	Wed, 10 Jul 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMLsdwWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497112DDBF;
	Wed, 10 Jul 2024 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607518; cv=none; b=IKuo3jT7VP/dscWayyfbj2AUlsjeCIRQ+crFEbowAJeyd7oXmjQlZgixoFiR6VgStT/srRqfZIrtRnh5sTxM9G4zbJuiRtwHewflc0Mxn/mfr/wXakyX+FE+LsWYVXqDMg1XA05hCDSAvDP0tjMtMr+wXAuFPrzqmvEclZGRjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607518; c=relaxed/simple;
	bh=qZCBkedOnz4cUGI4ezY6Jbb/+7sW1blOaFzbW32X4Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbZxA4NNcYJHwPtrhvAj3IqJmGWkyPwgYC/YhVSzPNklCsJrVlwotmWgIRnZc5pOlkq9vXdZAKimCcYndP66zJZo0ifqjUx3VeqQWV9E091OsD8pm5dCanu1RgCi1+jnY+mB5lIlu+8N7PnjPrNuPfHB0i0s9n+oAsZ8y+j3Vjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMLsdwWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1C1C32781;
	Wed, 10 Jul 2024 10:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720607518;
	bh=qZCBkedOnz4cUGI4ezY6Jbb/+7sW1blOaFzbW32X4Rw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RMLsdwWjFLAUG6prdpUgAaFyvBgL0qdeJvtB6ZzodSnecMFSNU8mzH14cAC2zL6LW
	 6CjcdBpVbh/f26aHi9u90+t4mvunLaLTZvwIpOkPeIG8gFScTuDp8agttN/y1pMJWJ
	 5GLILe4qww+bXLDLmpS96LEmz9xC8ISLVnkFbi/6GPSx5WLI11i6Mhj/tuSaaxQthA
	 ATeF2tiFFE+5/FxLLDznSVdj2EN/ROxPpxGt3JEXNSnhKt5FltwnUebWwZm6KEG72I
	 fWd7TdKBoSiMQZF/0XN/uqeV23imHAdK5NnQZzPmD5N8AZkJiOcC2cRzL7BZVWs5G3
	 BFgjh2GwlSGJA==
Message-ID: <751ebf34-cd0d-4d3a-bf02-e25ca3dd350b@kernel.org>
Date: Wed, 10 Jul 2024 12:31:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] ASoC: codecs: Add NeoFidelity NTP8835 codec
To: Igor Prusov <ivprusov@salutedevices.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: prusovigor@gmail.com, kernel@salutedevices.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
 <20240709172834.9785-7-ivprusov@salutedevices.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240709172834.9785-7-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2024 19:28, Igor Prusov wrote:
> The NeoFidelity NTP8835 adn NTP8835C are 2.1 channel amplifiers with
> mixer and biquad filters. Both amplifiers have identical programming
> interfaces but differ in output signal characteristics.
> 


> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

Where do you use moduleparam?

> +#include <linux/bits.h>
> +#include <linux/gpio.h>

And gpio?

> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>

And this?

Please clean up the driver first.

> +#include <linux/reset.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +#include <sound/initval.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-component.h>
> +#include <sound/tlv.h>
> +
> +#include "ntpfw.h"
> +
> +#define NTP8835_FORMATS     (SNDRV_PCM_FMTBIT_S16_LE | \
> +			     SNDRV_PCM_FMTBIT_S20_3LE | \
> +			     SNDRV_PCM_FMTBIT_S24_LE | \
> +			     SNDRV_PCM_FMTBIT_S32_LE)
> +
> +#define NTP8835_INPUT_FMT			0x0
> +#define  NTP8835_INPUT_FMT_MASTER_MODE		BIT(0)
> +#define  NTP8835_INPUT_FMT_GSA_MODE		BIT(1)
> +#define NTP8835_GSA_FMT				0x1
> +#define  NTP8835_GSA_BS_MASK			GENMASK(3, 2)
> +#define  NTP8835_GSA_BS(x)			((x) << 2)
> +#define  NTP8835_GSA_RIGHT_J			BIT(0)
> +#define  NTP8835_GSA_LSB			BIT(1)
> +#define NTP8835_SOFT_MUTE			0x26
> +#define  NTP8835_SOFT_MUTE_SM1			BIT(0)
> +#define  NTP8835_SOFT_MUTE_SM2			BIT(1)
> +#define  NTP8835_SOFT_MUTE_SM3			BIT(2)
> +#define NTP8835_PWM_SWITCH			0x27
> +#define  NTP8835_PWM_SWITCH_POF1		BIT(0)
> +#define  NTP8835_PWM_SWITCH_POF2		BIT(1)
> +#define  NTP8835_PWM_SWITCH_POF3		BIT(2)
> +#define NTP8835_PWM_MASK_CTRL0			0x28
> +#define  NTP8835_PWM_MASK_CTRL0_OUT_LOW		BIT(1)
> +#define  NTP8835_PWM_MASK_CTRL0_FPMLD		BIT(2)
> +#define NTP8835_MASTER_VOL			0x2e
> +#define NTP8835_CHNL_A_VOL			0x2f
> +#define NTP8835_CHNL_B_VOL			0x30
> +#define NTP8835_CHNL_C_VOL			0x31
> +#define REG_MAX					NTP8835_CHNL_C_VOL
> +
> +#define NTP8835_FW_NAME				"eq_8835.bin"
> +#define NTP8835_FW_MAGIC			0x38383335	/* "8835" */
> +


...


> +
> +static void ntp8835_reset_gpio(struct ntp8835_priv *ntp8835, bool active)
> +{
> +	if (active) {
> +		/*
> +		 * According to NTP8835 datasheet, 6.2 Timing Sequence (recommended):
> +		 * Deassert for T2 >= 1ms...
> +		 */
> +		reset_control_deassert(ntp8835->reset);

Explain in comment why do you need to power up device to perform
reset... This sounds odd.

> +		fsleep(1000);
> +
> +		/* ...Assert for T3 >= 0.1us... */
> +		reset_control_assert(ntp8835->reset);
> +		fsleep(1);
> +
> +		/* ...Deassert, and wait for T4 >= 0.5ms before sound on sequence. */
> +		reset_control_deassert(ntp8835->reset);
> +		fsleep(500);
> +	} else {
> +		reset_control_assert(ntp8835->reset);

This function is confusing. It is supposed to perform reset and leave
the device in active state, but here it leaves the device in reset.



> +
> +static struct snd_soc_dai_driver ntp8835_dai = {

Not const?

> +	.name = "ntp8835-amplifier",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 1,
> +		.channels_max = 3,
> +		.rates = SNDRV_PCM_RATE_8000_192000,
> +		.formats = NTP8835_FORMATS,
> +	},
> +	.ops = &ntp8835_dai_ops,
> +};
> +
> +static struct regmap_config ntp8835_regmap = {

Not const?

Judging by weird includes and such simple issues, it looks like you try
to upstream downstream or old code. That's not how you are supposed to
bring new devices. You expect us to perform review on the same issues we
fixed already. Work on newest drivers - take them as template - so you
will not repeat the same issues we already fixed.

> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = REG_MAX,
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
> +static int ntp8835_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct ntp8835_priv *ntp8835;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	ntp8835 = devm_kzalloc(&i2c->dev, sizeof(struct ntp8835_priv), GFP_KERNEL);

sizeof(*)

> +	if (!ntp8835)
> +		return -ENOMEM;
> +
> +	ntp8835->i2c = i2c;
> +
> +	ntp8835->reset = devm_reset_control_get_shared(&i2c->dev, NULL);

shared is on purpose?

> +	if (IS_ERR(ntp8835->reset))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
> +				     "Failed to get reset\n");
> +
> +	ret = reset_control_deassert(ntp8835->reset);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
> +				     "Failed to deassert reset\n");
> +
> +	dev_set_drvdata(&i2c->dev, ntp8835);
> +
> +	ntp8835_reset_gpio(ntp8835, true);
> +
> +	regmap = devm_regmap_init_i2c(i2c, &ntp8835_regmap);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
> +				     "Failed to allocate regmap\n");
> +
> +	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_ntp8835,
> +					      &ntp8835_dai, 1);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to register component\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ntp8835_i2c_id[] = {
> +	{ "ntp8835", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ntp8835_i2c_id);
> +
> +static const struct of_device_id ntp8835_of_match[] = {
> +	{.compatible = "neofidelity,ntp8835",},
> +	{.compatible = "neofidelity,ntp8835c",},

This does not match your i2c IDs, which leads to troubles when matching
variants.

Anyway, aren't they compatible?


> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ntp8835_of_match);
> +
> +static struct i2c_driver ntp8835_i2c_driver = {
> +	.probe = ntp8835_i2c_probe,
> +	.id_table = ntp8835_i2c_id,
> +	.driver = {
> +		.name = "NTP8835",

Driver names are lowercase

> +		.of_match_table = ntp8835_of_match,
> +	},
> +};
> +module_i2c_driver(ntp8835_i2c_driver);
> +
> +MODULE_AUTHOR("Igor Prusov <ivprusov@salutedevices.com>");
> +MODULE_DESCRIPTION("NTP8835 Audio Amplifier Driver");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof


