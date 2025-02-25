Return-Path: <linux-kernel+bounces-531528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77FA44191
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F843A9894
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7726AA92;
	Tue, 25 Feb 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDls7+Wl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556225EF8A;
	Tue, 25 Feb 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491685; cv=none; b=ifnycI7ru+fspkt3+bPoxXzHY6lpcwc6wX8nW45Bq5HwzVePJKv7I1pc2c2e69bkqsWTaHX17HkKxzoMhmfaa8qxwzk134pkyIIbJPrR9eUQEMsuNjwN6B4RBZPAfq1DUfeJIKabpRwFXjvGWwePwu5ewEu0KodZ1BXZlh4Wh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491685; c=relaxed/simple;
	bh=gS2xO6D8bUTJqMR0xbZMq+vAJRUEGZh4cXX1yn4mHGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDZOg5wF9jwwb/RmRndvYkoYZUtlurkjGBhW2vAnLlXQxCSuy3H+TLwIS1cHYZ2z3CHyv8spU6AEmpdlnDGgkWQ3zMXdu6Ralh6+UuGreQwCpUCqlNhrz7X7qwnYtdd60Dy7yRkaoJhqOBf7XO2SFsznQU7mXRD4vIhs2ELQXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDls7+Wl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA087C4CEDD;
	Tue, 25 Feb 2025 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740491685;
	bh=gS2xO6D8bUTJqMR0xbZMq+vAJRUEGZh4cXX1yn4mHGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDls7+WlVCqDVQs/pO7nZNzo+UnxZQTqr1cHoPGE67hHBlXU7uj/SvQa6/xzl/PzY
	 fSfha2qJinHo7WG827jCwuB+loYlVaXiNa1cOmvl02UdmSFl6jYYauhT+wYsKcJ+n2
	 Un7BQ80ugYzpTjhWJvDbua4P3fjRm10K/qaHh9+Mv/1DMezBNXZ6p+2DH07imkXR+r
	 mpJ8urnBNVBf7bUuIhstNaNSpYMpdC/vyukHiWmBOLNtgUuL/TM5Lr6BvpReOcyAuN
	 UB6ptUjFbhzYDrx8uKSRFrvDdRTBacVzD712jshNsfYtOmpyupudr1Y2hvL9B4XeMX
	 UW+WyJ1B//hLA==
Date: Tue, 25 Feb 2025 13:54:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Message-ID: <a7f7d4dc-283a-40b9-bb1b-0bc8aceb99c1@sirena.org.uk>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JWMBj3vKa0cR7fF4"
Content-Disposition: inline
In-Reply-To: <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
X-Cookie: I'm not available for comment..


--JWMBj3vKa0cR7fF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 05:08:34PM +0800, Alexis Czezar Torreno wrote:

> Add ADI ADP5055 driver support. The device consists
> of 3 buck regulators able to connect to high input voltages of up to 18V
> with no preregulators.

There's a bunch of stuff here which should be using core features, I'll
comment some of those on the DT binding patch.

> +config REGULATOR_ADP5055
> +	tristate "Analog Devices ADP5055 Triple Buck Regulator"
> +	depends on I2C
> +        select REGMAP_I2C
> +	help
> +	  This driver controls an Analog Devices ADP5055 with triple buck
> +          regulators using an I2C interface.

The indentation for the select and the second line of the description is
weird.

> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Regulator driver for Analog Devices ADP5055
> + *
> + * Copyright (C) 2025 Analog Devices, Inc.
> + */

Please make the entire comment block a C++ one so things look more
intentional.

> +static const struct regmap_range adp5055_reg_ranges[] = {
> +	regmap_reg_range(0xD1, 0xE0),
> +};
> +
> +static const struct regmap_access_table adp5055_write_ranges_table = {
> +	.yes_ranges	= adp5055_reg_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(adp5055_reg_ranges),
> +};
> +
> +static const struct regmap_access_table adp5055_read_ranges_table = {
> +	.yes_ranges	= adp5055_reg_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(adp5055_reg_ranges),
> +};

The read and write ranges could just be one variable.

> +static const struct regmap_config adp5055_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0xFF,

max_register is set to 0xff but the largest read or write register is
0xe0.  Might be worth considering adding cache support too, there's
read/modify/write cycles here.

> +	if (!adp5055->hw_en_array_gpios)
> +		if (adp5055->hw_en_array_gpios->ndescs != ADP5055_NUM_CH)
> +			return dev_err_probe(dev, adp5055->hw_en_array_gpios->ndescs,
> +				     "Invalid amount of channels described\n");

Are we sure that ndescs is going to be an error code?

> +static int adp5055_en_func(struct regulator_dev *dev, int en_val)
> +{
> +	struct adp5055 *adp5055 = rdev_get_drvdata(dev);
> +	int id;
> +	int mask;
> +
> +	id = rdev_get_id(dev);
> +	mask = BIT(id);
> +
> +	if (!adp5055->hw_en_array_gpios)
> +		return regmap_update_bits(adp5055->regmap, ADP5055_CTRL_MODE1, mask, en_val);
> +
> +	gpiod_set_value_cansleep(adp5055->hw_en_array_gpios->desc[id], en_val);

Just use the standard GPIO and regmap helpers for this.

--JWMBj3vKa0cR7fF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme9y6AACgkQJNaLcl1U
h9CsOQf/RisYYkTZwKSbO9Hwzq+ULIBDwfdJw7yxR7M/dbHfxoKTiqEEVhg0W4P9
k0pruUMPuh/lNE6xQTbUT0tAWT48q+IFPKLwUD+2S2LaU7A/9yMRo4O/vmrpFn4z
vIBZ/yik6sisvBnAJiUXTEY8hbmwRC4fpZDEE5eCmX9gUadR79LlrfRMBfuOKaLe
5KevWIFq1DoPrip9G/cnCffFj1eOYwjeWD1smR97JXO5lOTl4IE9+tX719FVdvK4
r+i8cbb7cHmz+iFk3qkFgLNw0sIrCiDc/3aqC/Y43edSjhi/R/O0V6TWfTcRQpnY
S30W4F0UPovHsUZTGHDb3/C6Vx/QDg==
=uI3w
-----END PGP SIGNATURE-----

--JWMBj3vKa0cR7fF4--

