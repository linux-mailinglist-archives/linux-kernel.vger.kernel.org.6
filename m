Return-Path: <linux-kernel+bounces-401647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E5C9C1D59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6B61F258A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD81E883E;
	Fri,  8 Nov 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+co3kpu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B571E7C2E;
	Fri,  8 Nov 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070274; cv=none; b=ODLTPsmSI1kfRXxt29Zf9ZYgk57bw7aQqt28EyMp5iQJwxgPXdXXqkILw64rs22xcGv3I2hc15hPfNJ4BIV3ZUN/fI3lk4RpVFa8hUJGUVMbfIm/j4oFCMMGeV+933kO9NYI3CMH+QG6QhTJ25NlP0IMLXZWFlgaQbKD9UVka7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070274; c=relaxed/simple;
	bh=9a3QZrzaYMtnDbILPbZ0qAy+WIpCJcwEcFNIQSsw3js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD7i/x1mT2cdjCDK8rLCLD6k5+AByXswxp2IbZcwd0DOZc0oazpPfXmgaZaziEGlJRLhXvh42rC7CimbUbu+6w5/6y0nzKZqFlIT8f6b/IytS6LG/Cnpi5VZytaPUA60RtSdYx7cDwl7L5f8/hzRNWZdq0rxyNf1ioTPUaL8Nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+co3kpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50732C4CECD;
	Fri,  8 Nov 2024 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731070273;
	bh=9a3QZrzaYMtnDbILPbZ0qAy+WIpCJcwEcFNIQSsw3js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+co3kpuN5yJJbb5w3dxeLoPhFeO5wKcx1aVJZ2TulD+VA5hLSuNhfh97ldfIbN5u
	 KwZJZflkxQARss6dyhWQgKjeUWw91itUQ1eg2XPCHFUeUevUWyH3SMaaVyJLiSLCva
	 3whqKdwbv51o50J8b3PxPKXskAeIAePev2SlIqqSHWmYSj7xSmIrhk8Sxzp3+ztEAf
	 r7T2VYC9vjxudHUHLcf1Hz/I5HPWJIx93VkY5xZOCZ4LYG9G2igRvOLyaq+5r+iBOK
	 AJkDrCKxLutFslb9LU+COZO/x4Ppv0Z10xwRoB+JhpABBfeJwMEwczEuJ8gtCRniZw
	 Ay+BJcKP0AZ4Q==
Date: Fri, 8 Nov 2024 12:51:07 +0000
From: Mark Brown <broonie@kernel.org>
To: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
Message-ID: <2cce3ad8-7a3a-47db-a18c-33c32e96c009@sirena.org.uk>
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
 <20241108093544.9492-2-ramoncristopher.calam@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eHxyWZJTCIL+iSkB"
Content-Disposition: inline
In-Reply-To: <20241108093544.9492-2-ramoncristopher.calam@analog.com>
X-Cookie: Do not overtax your powers.


--eHxyWZJTCIL+iSkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 05:35:43PM +0800, Ramon Cristopher M. Calam wrote:
> Add ADI LT8722 full bridge DC/DC converter driver.

> +++ b/drivers/regulator/lt8722-regulator.c
> @@ -0,0 +1,701 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices LT8722 Ultracompact Full Bridge Driver with SPI driver
> + *

Please make the entire comment a C++ one so things look more intentional.

> +static int lt8722_reg_read(struct spi_device *spi, u8 reg, u32 *val)
> +{

> +static int lt8722_reg_write(struct spi_device *spi, u8 reg, u32 val)
> +{

You can use these as reg_read() and reg_write() operations in regmap
which will allow the driver to use all the standard helpers and vastly
reduce the size of the driver.

> +static int lt8722_parse_fw(struct lt8722_chip_info *chip,
> +			   struct regulator_init_data *init_data)
> +{
> +	int ret;
> +
> +	/* Override the min_uV constraint with the minimum output voltage */
> +	init_data->constraints.min_uV = LT8722_MIN_VOUT;

Any modification of the constraints by the driver is a bug.  Adjust the
information the driver provides about the voltages it supports if you
need to do this.

> +static int lt8722_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct lt8722_chip_info *chip = rdev_get_drvdata(rdev);
> +	int ret;
> +	u32 reg_val;
> +	bool en_req, en_pin;
> +
> +	ret = lt8722_reg_read(chip->spi, LT8722_SPIS_COMMAND, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	en_req = FIELD_GET(LT8722_EN_REQ_MASK, reg_val);
> +	en_pin = gpiod_get_value(chip->en_gpio);
> +
> +	return en_req && en_pin;
> +}

Always adjusting both the GPIO and register all the time like this is
pointless, it turns the GPIO into just pure overhead.  Just use the
standard support for setting enables via registrers and GPIOs.  When
there's a GPIO leave the register permanently enabld.

> +	chip->en_gpio = devm_gpiod_get(&spi->dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(chip->en_gpio))
> +		return PTR_ERR(chip->en_gpio);

Presumably this is optional, it could just be tied off.

--eHxyWZJTCIL+iSkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuCTsACgkQJNaLcl1U
h9Cftgf/ZTZxCRv40vL8Cljm3uFRe5gz803VmW8ca1bO3d6mepvvo8smNZWtA1pG
Es1LbSDwa5HCH07wAW2Gw42Fb06JJJ0ZROT0KEwWydC3VPfcOeq80Hdt1mbZOEsj
ThqBegTd6SAaIHw6B2q66Huf2rbcOD3GpKsOU6/dIaPyCQ5bj9drHEiDpNMTbkAm
R6sPoWmaZFN205JIKGej0+qEBrN14IkS5bqPsUA8MP8DsZlc1c3qPfTlO/PaHH8F
dRWU11L2XuPPfMkgtcXfr+BnprL/ZAxTmpZOVfXxxp61ihqu9PGsLRiYlgoYIlla
126Da0zFh+JmgfDc4m1q3Cjnr8NJYA==
=bsjE
-----END PGP SIGNATURE-----

--eHxyWZJTCIL+iSkB--

