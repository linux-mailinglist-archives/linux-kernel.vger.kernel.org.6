Return-Path: <linux-kernel+bounces-247426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1092CF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DECDB25951
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722A190480;
	Wed, 10 Jul 2024 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU4+DIki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49318FC89;
	Wed, 10 Jul 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607693; cv=none; b=asY3j2GZCMc0bjpSlBm2PlZXrLuSAGKdlOudpc9bcmZUCP87z/kNo+e8JQki2+m44qg+hf8l8yuWpOcicmOaEvA8/6p6uNLFEyR85WrCVVSE0h1UbMG5ez4te8BUX94WjQB1q/V5ryGILn36qYWtjjbMTjHI55Ey9fccJg+qVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607693; c=relaxed/simple;
	bh=8WdRmuyLpXfw6l4a1GwdoX0mS8F1vUEiws7qIN6fA1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXs/TAL+yJ1bDVqiqBb3SP/wBn7MieZ9PNYvsG2ShGwbkQERGO/d0KrtW2oklzxDiimD7Nn7oqPhl0+wuwWImXtb1k67jVBwoff3xu1QoepVQzO6gTUpeJQU+qdNgFAhakLvdngNy3ssBeV4B8IViZSy1sF/ZiwnyTDf5FgAmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU4+DIki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4BBC32781;
	Wed, 10 Jul 2024 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720607692;
	bh=8WdRmuyLpXfw6l4a1GwdoX0mS8F1vUEiws7qIN6fA1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CU4+DIki6TGMsLcTq0tv7w4+ItVU85rVMGBmVkAgIkj3ruLsFylO/OVerYIq5DTWj
	 ZK1K3e+mYmmwUKUo2ZhqkTHSRGGdo8VfcE1DVizTDJ3nPf8Ijp0ONkDASlyzn+wlRj
	 a8xZaiOfjlJZFBxXmljcAJUo2l5aa38k+BzJi79WkmlW8AouRP8G7q3MqK34/q6TC0
	 RucCN+5PiL3oWus78Cp5iuHHJ+GfdpX+ZgY+STTK/yWgN8jYuLxfrhhEuabRi7ioar
	 cVJnt06p4Ea3SxKcMg4LZ9+JyDghkCgp58eRWwU/Q3D9qlRFQ51zPYIEztIj9BVU+H
	 PicTuLmZvsg3Q==
Message-ID: <05ed39c6-3c0b-4a43-b655-d26c69f686fa@kernel.org>
Date: Wed, 10 Jul 2024 12:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: codecs: add ES7243E ADC driver
To: Igor Prusov <ivprusov@salutedevices.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: prusovigor@gmail.com, kernel@salutedevices.com,
 David Yang <yangxiaohua@everest-semi.com>,
 Viktor Prutyanov <vvprutyanov@sberdevices.ru>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240709104117.33431-1-ivprusov@salutedevices.com>
 <20240709104117.33431-3-ivprusov@salutedevices.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240709104117.33431-3-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2024 12:41, Igor Prusov wrote:
> Add support for Everest Semi es7243e, which is a 24 bit, 8 to 48 kHz
> stereo audio ADC with I2C control and I2S output.
> 
> Datasheet: https://www.pawpaw.cn/media/documents/2022-04/ES7243E_DS_pawpaw%E6%9C%A8%E7%93%9C%E7%A7%91%E6%8A%80.pdf
> 
> Signed-off-by: David Yang <yangxiaohua@everest-semi.com>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> Signed-off-by: Viktor Prutyanov <vvprutyanov@sberdevices.ru>
> ---
>  sound/soc/codecs/Kconfig   |   3 +
>  sound/soc/codecs/Makefile  |   2 +
>  sound/soc/codecs/es7243e.c | 676 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 681 insertions(+)
>  create mode 100644 sound/soc/codecs/es7243e.c
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 4afc43d3f71f..bfc21073ea24 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1097,6 +1097,9 @@ config SND_SOC_ES7134
>  config SND_SOC_ES7241
>  	tristate "Everest Semi ES7241 CODEC"
>  
> +config SND_SOC_ES7243E
> +	tristate "Everest Semi ES7243E CODEC"
> +
>  config SND_SOC_ES83XX_DSM_COMMON
>  	depends on ACPI
>  	tristate
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index b4df22186e25..9469903662f8 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -118,6 +118,7 @@ snd-soc-da9055-y := da9055.o
>  snd-soc-dmic-y := dmic.o
>  snd-soc-es7134-y := es7134.o
>  snd-soc-es7241-y := es7241.o
> +snd-soc-es7243-y := es7243.o
>  snd-soc-es83xx-dsm-common-y := es83xx-dsm-common.o
>  snd-soc-es8316-y := es8316.o
>  snd-soc-es8326-y := es8326.o
> @@ -515,6 +516,7 @@ obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
>  obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
>  obj-$(CONFIG_SND_SOC_ES7134)	+= snd-soc-es7134.o
>  obj-$(CONFIG_SND_SOC_ES7241)	+= snd-soc-es7241.o
> +obj-$(CONFIG_SND_SOC_ES7243E)	+= snd-soc-es7243e.o
>  obj-$(CONFIG_SND_SOC_ES83XX_DSM_COMMON)    += snd-soc-es83xx-dsm-common.o
>  obj-$(CONFIG_SND_SOC_ES8316)    += snd-soc-es8316.o
>  obj-$(CONFIG_SND_SOC_ES8326)    += snd-soc-es8326.o
> diff --git a/sound/soc/codecs/es7243e.c b/sound/soc/codecs/es7243e.c
> new file mode 100644
> index 000000000000..be877d980cec
> --- /dev/null
> +++ b/sound/soc/codecs/es7243e.c
> @@ -0,0 +1,676 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/**
> + * es7243e.c - ASoC Everest Semiconductor ES7243E audio ADC driver
> + *
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Authors: Viktor Prutyanov <vvprutyanov@sberdevices.ru>
> + *	    Igor Prusov <ivprusov@salutedevices.com>
> + *
> + * Based on ES7243E driver by David Yang <yangxiaohua@everest-semi.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

Same issues.


> +
> +static const struct regmap_config es7243e_regmap_config = {

But this one is correct...

> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ES7243E_CHIP_VER,
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
> +struct coeff_div {

declarations go before definitions.

> +	u32 mclk;		/* mclk frequency */
> +	u32 sr_rate;		/* sample rate */
> +	u8 osr;			/* ADC over sample rate */
> +	u8 mclk_pre;		/* mclk prediv/premult */
> +	u8 cf_dsp_div;		/* adclrck divider and daclrck divider */
> +	u8 scale;		/* ADC gain scale up */
> +	u8 lrckdiv;		/* lrck divider */
> +	u8 bclkdiv;		/* sclk divider */
> +};
> +
> +static const struct coeff_div coeff_div[] = {
> +	/* mclk     lrck   osr   pre   div   scale lrdiv bclkdiv */
> +	{ 24576000, 8000,  0x20, 0x50, 0x00, 0x00, 0x0b, 0x2f },
> +	{ 24576000, 12000, 0x20, 0x30, 0x00, 0x00, 0x07, 0x1f },
> +	{ 24576000, 16000, 0x20, 0x20, 0x00, 0x00, 0x05, 0x17 },
> +	{ 24576000, 24000, 0x20, 0x10, 0x00, 0x00, 0x03, 0x0f },
> +	{ 24576000, 32000, 0x20, 0x21, 0x00, 0x00, 0x02, 0x0b },
> +	{ 24576000, 48000, 0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 12288000, 8000,  0x20, 0x20, 0x00, 0x00, 0x05, 0x17 },
> +	{ 12288000, 12000, 0x20, 0x10, 0x00, 0x00, 0x03, 0x0f },
> +	{ 12288000, 16000, 0x20, 0x21, 0x00, 0x00, 0x02, 0x0b },
> +	{ 12288000, 24000, 0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 12288000, 32000, 0x20, 0x22, 0x00, 0x00, 0x01, 0x05 },
> +	{ 12288000, 48000, 0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 6144000,  8000,  0x20, 0x21, 0x00, 0x00, 0x02, 0x0b },
> +	{ 6144000,  12000, 0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 6144000,  16000, 0x20, 0x22, 0x00, 0x00, 0x01, 0x05 },
> +	{ 6144000,  24000, 0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 6144000,  32000, 0x20, 0x23, 0x00, 0x00, 0x00, 0x02 },
> +	{ 6144000,  48000, 0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 3072000,  8000,  0x20, 0x22, 0x00, 0x00, 0x01, 0x05 },
> +	{ 3072000,  12000, 0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 3072000,  16000, 0x20, 0x23, 0x00, 0x00, 0x00, 0x02 },
> +	{ 3072000,  24000, 0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 3072000,  32000, 0x10, 0x03, 0x20, 0x04, 0x00, 0x02 },
> +	{ 3072000,  48000, 0x20, 0x03, 0x00, 0x00, 0x00, 0x00 },
> +	{ 1536000,  8000,  0x20, 0x23, 0x00, 0x00, 0x00, 0x02 },
> +	{ 1536000,  12000, 0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 1536000,  16000, 0x10, 0x03, 0x20, 0x04, 0x00, 0x00 },
> +	{ 1536000,  24000, 0x20, 0x03, 0x00, 0x00, 0x00, 0x00 },
> +	{ 32768000, 8000,  0x20, 0x70, 0x00, 0x00, 0x0f, 0x3f },
> +	{ 32768000, 16000, 0x20, 0x30, 0x00, 0x00, 0x07, 0x1f },
> +	{ 32768000, 32000, 0x20, 0x10, 0x00, 0x00, 0x03, 0x0f },
> +	{ 16384000, 8000,  0x20, 0x30, 0x00, 0x00, 0x07, 0x1f },
> +	{ 16384000, 16000, 0x20, 0x10, 0x00, 0x00, 0x03, 0x0f },
> +	{ 16384000, 32000, 0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 8192000,  8000,  0x20, 0x10, 0x00, 0x00, 0x03, 0x0f },
> +	{ 8192000,  16000, 0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 8192000,  32000, 0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 4096000,  8000,  0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 4096000,  16000, 0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 4096000,  32000, 0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 2048000,  8000,  0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 2048000,  16000, 0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 2048000,  32000, 0x20, 0x03, 0x00, 0x00, 0x00, 0x00 },
> +	{ 1024000,  8000,  0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 1024000,  16000, 0x20, 0x03, 0x00, 0x00, 0x00, 0x00 },
> +	{ 22579200, 11025, 0x20, 0x30, 0x00, 0x00, 0x07, 0x1f },
> +	{ 22579200, 22050, 0x20, 0x10, 0x00, 0x00, 0x03, 0x0f },
> +	{ 22579200, 44100, 0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 11289600, 11025, 0x20, 0x10, 0x00, 0x00, 0x03, 0x0f },
> +	{ 11289600, 22050, 0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 11289600, 44100, 0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 56448000, 11025, 0x20, 0x00, 0x00, 0x00, 0x01, 0x07 },
> +	{ 56448000, 22050, 0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 56448000, 44100, 0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 28224000, 11025, 0x20, 0x01, 0x00, 0x00, 0x00, 0x03 },
> +	{ 28224000, 22050, 0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 28224000, 44100, 0x20, 0x03, 0x00, 0x00, 0x00, 0x00 },
> +	{ 14112000, 11025, 0x20, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	{ 14112000, 22050, 0x20, 0x03, 0x00, 0x00, 0x00, 0x00 },
> +};
> +
> +static const struct coeff_div *get_coeff(int mclk, int rate)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(coeff_div); i++)
> +		if (coeff_div[i].sr_rate == rate && coeff_div[i].mclk == mclk)
> +			return &coeff_div[i];
> +
> +	return NULL;
> +}
> +
> +static unsigned int rates_12288[] = {

Not a const?

Best regards,
Krzysztof


