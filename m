Return-Path: <linux-kernel+bounces-334910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D106897DE2D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09BF1F218EA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1C3BBF0;
	Sat, 21 Sep 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/b3Cp/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162024A08;
	Sat, 21 Sep 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726942200; cv=none; b=GUHHXgLG7FqEunX0pTqJkk8gsZcESvdXWh5z6/EbzlVM/PavrjyA0XF1mtXgypJh+3tB5/FHjMVL6R1FCp37C40cjgVTRM2+zsh14IkIZJ+sMbM/Va4VtMByNmPSrzvi/KUsGAD7ABpVRL3ZOrRrMADSOxqRXguXm+6BQ/Ixgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726942200; c=relaxed/simple;
	bh=faoqNButayVSCjVRMFLPewz3GeO158scG7bkVUHWenQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPOGxLE5fFoANapI8iklNv1A9dFNSNzCzjHptWW/DMmL7t9U+dG1DX4kiG8c2jFT+x2TP8q2F0fa03fQiwcuvwbU/OKSI/H8Y1HrDGaJx1xP2gRewPOEcKXma1JsYuqbAkMozGERT6qqRRFU0ejVeHiHfQgoZG2Yz/iqhRg0w3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/b3Cp/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4B4C4CEC2;
	Sat, 21 Sep 2024 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726942199;
	bh=faoqNButayVSCjVRMFLPewz3GeO158scG7bkVUHWenQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/b3Cp/M5LGAzYeZiEMQ+L40+0b4qH2V+cdHxWtqj2qYpfRirmCn5iZR6UGyawlfD
	 HCK4whhdYRVjLibmoXDajXTkxHWoASV8wqG8ety+Jy4EXvuThN8AmTpNJQ2a/Hxkxx
	 3gVfPmfQvSKjw1gTfLhTMxnkWUWSVihc3M/1+Ng8zoDpGzIIe5vHeS1lNkonrgYuYe
	 +Sgjid2m2R4ZsVea9wV7Vlb4rPxA7U0eUZF4n8d0YyXRkgTVIounk0AimTcwijIGbG
	 gU3fJ2OPF/akQZFuFTaKoUT+H4EXtKs8g6VDSpQ1oC4Pb+vojPipXORye0QFd9lc3H
	 CbFqYnVpfBsnA==
Date: Sat, 21 Sep 2024 20:09:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, prusovigor@gmail.com, kernel@salutedevices.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ASoC: codecs: Add NeoFidelity NTP8835 codec
Message-ID: <c67k2dmrwc4oghe25zjobiloeg5cqbtcypn5ibdqw4alb6y7wc@wmyrc6xyslbt>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
 <20240709172834.9785-7-ivprusov@salutedevices.com>
 <751ebf34-cd0d-4d3a-bf02-e25ca3dd350b@kernel.org>
 <20240920173312.mc2ylk4n3lliaelj@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920173312.mc2ylk4n3lliaelj@pc>

On Fri, Sep 20, 2024 at 08:33:12PM +0300, Igor Prusov wrote:
 > 
> > 
> > > +
> > > +static void ntp8835_reset_gpio(struct ntp8835_priv *ntp8835, bool active)
> > > +{
> > > +	if (active) {
> > > +		/*
> > > +		 * According to NTP8835 datasheet, 6.2 Timing Sequence (recommended):
> > > +		 * Deassert for T2 >= 1ms...
> > > +		 */
> > > +		reset_control_deassert(ntp8835->reset);
> > 
> > Explain in comment why do you need to power up device to perform
> > reset... This sounds odd.
> > 
> 
> This sequence comes from device datasheet, for some reason vendor
> recommends to drive /RESET low for 0.1us during initialization.
> Datasheet also describes (section 6.3) init sequence with simple reset
> deassert, but it's called legacy, though it works fine on my board. Do
> you mean to add more verbose comment than linking to a datasheet?

I think verbose comment would be better.

> 
> > > +		fsleep(1000);
> > > +
> > > +		/* ...Assert for T3 >= 0.1us... */
> > > +		reset_control_assert(ntp8835->reset);
> > > +		fsleep(1);
> > > +
> > > +		/* ...Deassert, and wait for T4 >= 0.5ms before sound on sequence. */
> > > +		reset_control_deassert(ntp8835->reset);
> > > +		fsleep(500);
> > > +	} else {
> > > +		reset_control_assert(ntp8835->reset);
> > 
> > This function is confusing. It is supposed to perform reset and leave
> > the device in active state, but here it leaves the device in reset.
> > 
> > 
> > 
> > > +
> > > +static struct snd_soc_dai_driver ntp8835_dai = {
> > 
> > Not const?
> > 
> 
> ntp8835_dai is passed to devm_snd_soc_register_component(), which takes
> non-const parameter.

Right, indeed.

> 
> > > +	.name = "ntp8835-amplifier",
> > > +	.playback = {
> > > +		.stream_name = "Playback",
> > > +		.channels_min = 1,
> > > +		.channels_max = 3,
> > > +		.rates = SNDRV_PCM_RATE_8000_192000,
> > > +		.formats = NTP8835_FORMATS,
> > > +	},
> > > +	.ops = &ntp8835_dai_ops,
> > > +};
> > > +
> > > +static struct regmap_config ntp8835_regmap = {
> > 
> > Not const?
> > 
> > Judging by weird includes and such simple issues, it looks like you try
> > to upstream downstream or old code. That's not how you are supposed to
> > bring new devices. You expect us to perform review on the same issues we
> > fixed already. Work on newest drivers - take them as template - so you
> > will not repeat the same issues we already fixed.
> > 
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.max_register = REG_MAX,
> > > +	.cache_type = REGCACHE_MAPLE,
> > > +};
> > > +
> > > +static int ntp8835_i2c_probe(struct i2c_client *i2c)
> > > +{
> > > +	struct ntp8835_priv *ntp8835;
> > > +	struct regmap *regmap;
> > > +	int ret;
> > > +
> > > +	ntp8835 = devm_kzalloc(&i2c->dev, sizeof(struct ntp8835_priv), GFP_KERNEL);
> > 
> > sizeof(*)
> > 
> > > +	if (!ntp8835)
> > > +		return -ENOMEM;
> > > +
> > > +	ntp8835->i2c = i2c;
> > > +
> > > +	ntp8835->reset = devm_reset_control_get_shared(&i2c->dev, NULL);
> > 
> > shared is on purpose?
> > 
> 
> Yes, we have a board with two amplifiers sharing same reset line, so
> shared allows to work around this hardware issue. Is it the wrong
> approach?

No, it's ok, I just want to be sure you added this consciously.

> 
> > > +	if (IS_ERR(ntp8835->reset))
> > > +		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
> > > +				     "Failed to get reset\n");
> > > +
> > > +	ret = reset_control_deassert(ntp8835->reset);
> > > +	if (ret)
> > > +		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
> > > +				     "Failed to deassert reset\n");
> > > +
> > > +	dev_set_drvdata(&i2c->dev, ntp8835);
> > > +
> > > +	ntp8835_reset_gpio(ntp8835, true);
> > > +
> > > +	regmap = devm_regmap_init_i2c(i2c, &ntp8835_regmap);
> > > +	if (IS_ERR(regmap))
> > > +		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
> > > +				     "Failed to allocate regmap\n");
> > > +
> > > +	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_ntp8835,
> > > +					      &ntp8835_dai, 1);
> > > +	if (ret)
> > > +		return dev_err_probe(&i2c->dev, ret,
> > > +				     "Failed to register component\n");
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct i2c_device_id ntp8835_i2c_id[] = {
> > > +	{ "ntp8835", 0 },
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, ntp8835_i2c_id);
> > > +
> > > +static const struct of_device_id ntp8835_of_match[] = {
> > > +	{.compatible = "neofidelity,ntp8835",},
> > > +	{.compatible = "neofidelity,ntp8835c",},
> > 
> > This does not match your i2c IDs, which leads to troubles when matching
> > variants.
> > 
> > Anyway, aren't they compatible?
> > 
> > 
> 
> They have identical programming interface and only differ in some output
> signal characteristics. Is it OK use single compatible string in such
> case?

Driver should have one compatible (and one entry in i2c device ID). You
add the second in the bindings as one followed by fallback.
Like this:
https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31

Best regards,
Krzysztof


