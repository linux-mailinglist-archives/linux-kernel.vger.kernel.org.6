Return-Path: <linux-kernel+bounces-334574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5A97D910
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757852826C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CFC17F389;
	Fri, 20 Sep 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vP26Pdae"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946B27466;
	Fri, 20 Sep 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853609; cv=none; b=pIdocZngUciwwBTlaamfSrODCPqa+sM6nRxsQVXjXdwsBSGK6Qrx/r90a0RzsiN64oH2EAgivUJ/BbNdMOOuTeBpFJxUOavwlQoR9G9j8b2I4TRJCX70FPoexurZfAQld0a9I+QrJ3I+vuaQlT8S0BkB3jbxWagubfBZ86yp78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853609; c=relaxed/simple;
	bh=Y6lxOub/26ndx8n1Lj3on6tzWH6EjcfJkpByenSLYWA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naFxpz5ft8J8QkaG6AT96hPggzvnh1Hv0SSBk5cobTtUsLn62A8he8IwU+GuUMtqfqNKANjjyQIWcf4Wch/K9226q33e0j7l13bXvzsQSu/xfPizSrXInepVTLARn7jvabCMYXre/e99P227K2L26Cb4UvVvgVD57IxAntDxaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vP26Pdae; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 59DC8100008;
	Fri, 20 Sep 2024 20:33:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 59DC8100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726853595;
	bh=mfVfaUmGMTdMZo6H7znn440n/Ednn8LG0UZiPhBtyMA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=vP26PdaeuP/oN/WtFkHLkmhcnUgTVA1R77+d4vCUT4o/LRI0BYzkIH3rq5KkXbuMi
	 ohhLhCu2wP+Cf6zl9rRXCM4s9IQj3QbX+BdBQ6iwxNeba7Yo8DbFcdXG051GvrCz0i
	 N2edmUjfItBAXmViPRXg1/D9S6Rgy2JAcr9b5VROnbyWa8riy61Gd9mUBuw9JVAg4+
	 t421Xn0+5I8bxhGwHhNR/cWKjmyOGEVwGZX3NqMTkLAA3lxPyCD5y8ZY2ZdEOj55kA
	 iVVTn8EPT8rfUYk9/kRnIIy5YYBCLfkNp9EguTSQ/fgnxOnXhG0tHu1MGb0AH/ldON
	 Nciy8SoJzUiCw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 20 Sep 2024 20:33:15 +0300 (MSK)
Date: Fri, 20 Sep 2024 20:33:12 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] ASoC: codecs: Add NeoFidelity NTP8835 codec
Message-ID: <20240920173312.mc2ylk4n3lliaelj@pc>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
 <20240709172834.9785-7-ivprusov@salutedevices.com>
 <751ebf34-cd0d-4d3a-bf02-e25ca3dd350b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <751ebf34-cd0d-4d3a-bf02-e25ca3dd350b@kernel.org>
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187889 [Sep 20 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/20 14:03:00 #26646385
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Krzysztof,

Thank you for review and apologies for late response. I'm about to send
next version with all comments addressed, just wanted to ask some
questions before.

On Wed, Jul 10, 2024 at 12:31:53PM +0200, Krzysztof Kozlowski wrote:
> On 09/07/2024 19:28, Igor Prusov wrote:
> > The NeoFidelity NTP8835 adn NTP8835C are 2.1 channel amplifiers with
> > mixer and biquad filters. Both amplifiers have identical programming
> > interfaces but differ in output signal characteristics.
> > 
> 
> 
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> 
> Where do you use moduleparam?
> 
> > +#include <linux/bits.h>
> > +#include <linux/gpio.h>
> 
> And gpio?
> 
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/of_gpio.h>
> 
> And this?
> 
> Please clean up the driver first.
> 
> > +#include <linux/reset.h>
> > +#include <linux/init.h>
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <sound/initval.h>
> > +#include <sound/core.h>
> > +#include <sound/pcm.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc.h>
> > +#include <sound/soc-component.h>
> > +#include <sound/tlv.h>
> > +
> > +#include "ntpfw.h"
> > +
> > +#define NTP8835_FORMATS     (SNDRV_PCM_FMTBIT_S16_LE | \
> > +			     SNDRV_PCM_FMTBIT_S20_3LE | \
> > +			     SNDRV_PCM_FMTBIT_S24_LE | \
> > +			     SNDRV_PCM_FMTBIT_S32_LE)
> > +
> > +#define NTP8835_INPUT_FMT			0x0
> > +#define  NTP8835_INPUT_FMT_MASTER_MODE		BIT(0)
> > +#define  NTP8835_INPUT_FMT_GSA_MODE		BIT(1)
> > +#define NTP8835_GSA_FMT				0x1
> > +#define  NTP8835_GSA_BS_MASK			GENMASK(3, 2)
> > +#define  NTP8835_GSA_BS(x)			((x) << 2)
> > +#define  NTP8835_GSA_RIGHT_J			BIT(0)
> > +#define  NTP8835_GSA_LSB			BIT(1)
> > +#define NTP8835_SOFT_MUTE			0x26
> > +#define  NTP8835_SOFT_MUTE_SM1			BIT(0)
> > +#define  NTP8835_SOFT_MUTE_SM2			BIT(1)
> > +#define  NTP8835_SOFT_MUTE_SM3			BIT(2)
> > +#define NTP8835_PWM_SWITCH			0x27
> > +#define  NTP8835_PWM_SWITCH_POF1		BIT(0)
> > +#define  NTP8835_PWM_SWITCH_POF2		BIT(1)
> > +#define  NTP8835_PWM_SWITCH_POF3		BIT(2)
> > +#define NTP8835_PWM_MASK_CTRL0			0x28
> > +#define  NTP8835_PWM_MASK_CTRL0_OUT_LOW		BIT(1)
> > +#define  NTP8835_PWM_MASK_CTRL0_FPMLD		BIT(2)
> > +#define NTP8835_MASTER_VOL			0x2e
> > +#define NTP8835_CHNL_A_VOL			0x2f
> > +#define NTP8835_CHNL_B_VOL			0x30
> > +#define NTP8835_CHNL_C_VOL			0x31
> > +#define REG_MAX					NTP8835_CHNL_C_VOL
> > +
> > +#define NTP8835_FW_NAME				"eq_8835.bin"
> > +#define NTP8835_FW_MAGIC			0x38383335	/* "8835" */
> > +
> 
> 
> ...
> 
> 
> > +
> > +static void ntp8835_reset_gpio(struct ntp8835_priv *ntp8835, bool active)
> > +{
> > +	if (active) {
> > +		/*
> > +		 * According to NTP8835 datasheet, 6.2 Timing Sequence (recommended):
> > +		 * Deassert for T2 >= 1ms...
> > +		 */
> > +		reset_control_deassert(ntp8835->reset);
> 
> Explain in comment why do you need to power up device to perform
> reset... This sounds odd.
> 

This sequence comes from device datasheet, for some reason vendor
recommends to drive /RESET low for 0.1us during initialization.
Datasheet also describes (section 6.3) init sequence with simple reset
deassert, but it's called legacy, though it works fine on my board. Do
you mean to add more verbose comment than linking to a datasheet?

> > +		fsleep(1000);
> > +
> > +		/* ...Assert for T3 >= 0.1us... */
> > +		reset_control_assert(ntp8835->reset);
> > +		fsleep(1);
> > +
> > +		/* ...Deassert, and wait for T4 >= 0.5ms before sound on sequence. */
> > +		reset_control_deassert(ntp8835->reset);
> > +		fsleep(500);
> > +	} else {
> > +		reset_control_assert(ntp8835->reset);
> 
> This function is confusing. It is supposed to perform reset and leave
> the device in active state, but here it leaves the device in reset.
> 
> 
> 
> > +
> > +static struct snd_soc_dai_driver ntp8835_dai = {
> 
> Not const?
> 

ntp8835_dai is passed to devm_snd_soc_register_component(), which takes
non-const parameter.

> > +	.name = "ntp8835-amplifier",
> > +	.playback = {
> > +		.stream_name = "Playback",
> > +		.channels_min = 1,
> > +		.channels_max = 3,
> > +		.rates = SNDRV_PCM_RATE_8000_192000,
> > +		.formats = NTP8835_FORMATS,
> > +	},
> > +	.ops = &ntp8835_dai_ops,
> > +};
> > +
> > +static struct regmap_config ntp8835_regmap = {
> 
> Not const?
> 
> Judging by weird includes and such simple issues, it looks like you try
> to upstream downstream or old code. That's not how you are supposed to
> bring new devices. You expect us to perform review on the same issues we
> fixed already. Work on newest drivers - take them as template - so you
> will not repeat the same issues we already fixed.
> 
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = REG_MAX,
> > +	.cache_type = REGCACHE_MAPLE,
> > +};
> > +
> > +static int ntp8835_i2c_probe(struct i2c_client *i2c)
> > +{
> > +	struct ntp8835_priv *ntp8835;
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	ntp8835 = devm_kzalloc(&i2c->dev, sizeof(struct ntp8835_priv), GFP_KERNEL);
> 
> sizeof(*)
> 
> > +	if (!ntp8835)
> > +		return -ENOMEM;
> > +
> > +	ntp8835->i2c = i2c;
> > +
> > +	ntp8835->reset = devm_reset_control_get_shared(&i2c->dev, NULL);
> 
> shared is on purpose?
> 

Yes, we have a board with two amplifiers sharing same reset line, so
shared allows to work around this hardware issue. Is it the wrong
approach?

> > +	if (IS_ERR(ntp8835->reset))
> > +		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
> > +				     "Failed to get reset\n");
> > +
> > +	ret = reset_control_deassert(ntp8835->reset);
> > +	if (ret)
> > +		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
> > +				     "Failed to deassert reset\n");
> > +
> > +	dev_set_drvdata(&i2c->dev, ntp8835);
> > +
> > +	ntp8835_reset_gpio(ntp8835, true);
> > +
> > +	regmap = devm_regmap_init_i2c(i2c, &ntp8835_regmap);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
> > +				     "Failed to allocate regmap\n");
> > +
> > +	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_ntp8835,
> > +					      &ntp8835_dai, 1);
> > +	if (ret)
> > +		return dev_err_probe(&i2c->dev, ret,
> > +				     "Failed to register component\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id ntp8835_i2c_id[] = {
> > +	{ "ntp8835", 0 },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ntp8835_i2c_id);
> > +
> > +static const struct of_device_id ntp8835_of_match[] = {
> > +	{.compatible = "neofidelity,ntp8835",},
> > +	{.compatible = "neofidelity,ntp8835c",},
> 
> This does not match your i2c IDs, which leads to troubles when matching
> variants.
> 
> Anyway, aren't they compatible?
> 
> 

They have identical programming interface and only differ in some output
signal characteristics. Is it OK use single compatible string in such
case?

> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, ntp8835_of_match);
> > +
> > +static struct i2c_driver ntp8835_i2c_driver = {
> > +	.probe = ntp8835_i2c_probe,
> > +	.id_table = ntp8835_i2c_id,
> > +	.driver = {
> > +		.name = "NTP8835",
> 
> Driver names are lowercase
> 
> > +		.of_match_table = ntp8835_of_match,
> > +	},
> > +};
> > +module_i2c_driver(ntp8835_i2c_driver);
> > +
> > +MODULE_AUTHOR("Igor Prusov <ivprusov@salutedevices.com>");
> > +MODULE_DESCRIPTION("NTP8835 Audio Amplifier Driver");
> > +MODULE_LICENSE("GPL");
> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Igor Prusov

