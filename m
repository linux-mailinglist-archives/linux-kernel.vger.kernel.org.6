Return-Path: <linux-kernel+bounces-331515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE0997ADBC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC781F21158
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38F4158DBA;
	Tue, 17 Sep 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3NBg7bP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59D14BFBF;
	Tue, 17 Sep 2024 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564798; cv=none; b=crv0i2HpTsXdk4kEtK5Bnb2Ccxg8S1/uS85+xluFZ7RGg8s2X9Y4IKQtqPIj4aq4ro5w0DApQuoW3idt9gQbRcC+L6Tnqi5MVTmCfiBPXfykwdFl0DtkVVxoBHPCM7wZaSJCqHdPuJGBdqg/XmIsG5yp0cK+Kphq9tEY0IfAyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564798; c=relaxed/simple;
	bh=N6LlSkUbGt+i7mOEB4yC6nRtyA+qbiO+7RVITLJQkxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiIQsPaIOHQW0nqOJPQ3zqwsNUJXkstEgLRnVbWD9IoPTQ5/KwFEOl/6bJ1DNbwh/1GlafbusZMUETtphGxTuolqaXLTcC8ICjoP2YHp+059xiAK0PebcpgGz+0RRC433uXYL1oYRwPR4BFCp6FGOBJLqMMB3bwnapm7x7nZfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3NBg7bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03DEC4CEC6;
	Tue, 17 Sep 2024 09:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726564797;
	bh=N6LlSkUbGt+i7mOEB4yC6nRtyA+qbiO+7RVITLJQkxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3NBg7bPjhG9cN6lgm/mPd5X+YtauDq1fXf6C1eqDxpCF9M1qwylNOEgOWVsZ1YaF
	 yND8I5zPJDZ5QwYjSKjlWCLV8Y1WDGmaHXvLUDXvKEXngtr1tsKvz5jqQSMoS80Jtk
	 pS0u7+F3ShqPWBgja5YggLSDVOWgw95fwfAWQGia02qcO/vDVGA4Iex4O1iRkq30OO
	 EbgkgHPGiC4RIrEkGrRb/3irNB2SXtyTM6ILAV7h+7cFky/YmlG10SMaEtuVfd908m
	 PIk9Y0ueCXoB1X6T06whc8Cmq9DI6fPiIi8BHImgzdOAypevFvO2+fw7ZJ+7LlJO7q
	 8rvL3vbYd4r5w==
Date: Tue, 17 Sep 2024 11:19:52 +0200
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator
 driver
Message-ID: <ZulJuCu-QcMYrphP@finisterre.sirena.org.uk>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
 <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+h+CYzyetNHuwcry"
Content-Disposition: inline
In-Reply-To: <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
X-Cookie: Editing is a rewording activity.


--+h+CYzyetNHuwcry
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 05:48:53PM +0100, Andr=E9 Draszik wrote:

> +config REGULATOR_MAX20339
> +       tristate "Maxim MAX20339 overvoltage protector with load switches"
> +       depends on GPIOLIB || COMPILE_TEST
> +       depends on I2C
> +       select GPIO_REGMAP if GPIOLIB

I don't see any dependency on gpiolib here, the GPIO functionality
appears unrelated to the regulator functionality (this could reasonably
be a MFD, though it's probably not worth it given how trivial the GPIO
functionality is).

> +++ b/drivers/regulator/max20339-regulator.c
> @@ -0,0 +1,912 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Linaro Ltd.

Nothing inherited from the original Pixel 6 kernel?

> + *
> + * Maxim MAX20339 load switch with over voltage protection

Please make the entire comment a C++ one so things look more
intentional.

> +static const struct regmap_config max20339_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX20339_LAST_REGISTER,
> +	.wr_table =3D &max20339_write_table,
> +	.rd_table =3D &max20339_rd_table,
> +	.volatile_table =3D &max20339_volatile_table,
> +	.precious_table =3D &max20339_precious_table,
> +};

You've specified volatile registers here but not configured a cache.

> +	if (status[3] & status[0] & MAX20339_INOVFAULT) {
> +		dev_warn(dev, "Over voltage on INput\n");
> +		regulator_notifier_call_chain(max20339->rdevs[MAX20339_REGULATOR_INSW],
> +					      REGULATOR_EVENT_OVER_VOLTAGE_WARN,
> +					      NULL);
> +	}

This is an error on the input, not an error from this regulator, so the
notification isn't appropriate here.

> +static int max20339_insw_is_enabled(struct regulator_dev *rdev)
> +{
> +	unsigned int val;
> +	int ret;
> +	struct device *dev =3D rdev_get_dev(rdev);
> +
> +	ret =3D regmap_read(rdev_get_regmap(rdev), MAX20339_STATUS1, &val);
> +	if (ret) {
> +		dev_err(dev, "error reading STATUS1: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(dev, "%s: %s: %c\n", __func__, rdev->desc->name,
> +		"ny"[FIELD_GET(MAX20339_INSWCLOSED, val)]);

In addition to the log spam issues I've no idea how anyone is supposed
to interpret this log :/

> +
> +	return FIELD_GET(MAX20339_INSWCLOSED, val) =3D=3D 1;
> +}

This does not appear to be an enable control, it's reading back a status
register rather than turning on or off a regulator.  It's not clear to
me what the status actually is (possibly saying if there's a voltage
present?) but it should be reported with a get_status() operation.

> +static int max20339_set_voltage_sel(struct regulator_dev *rdev,
> +				    unsigned int sel)
> +{
> +	return max20339_set_ovlo_helper(rdev,
> +					FIELD_PREP(MAX20339_OVLOSEL_INOVLOSEL,
> +						   sel));
> +}

This device does not appear to be a voltage regualtor, it is a
protection device.  A set_voltage() operation is therfore inappropriate
for it, any voltage configuration would need to be done on the parent
regulator.

> +static const struct regulator_ops max20339_insw_ops =3D {
> +	.enable =3D regulator_enable_regmap,
> +	.disable =3D regulator_disable_regmap,
> +	.is_enabled =3D max20339_insw_is_enabled,

The is_enabled() operation should match the enable() and disable(), it
should reflect what the device is being told to do.

> +static int max20339_lsw_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct max20339_regulator *data =3D rdev_get_drvdata(rdev);
> +	unsigned int val;
> +	int ret;
> +	struct device *dev =3D rdev_get_dev(rdev);
> +
> +	ret =3D regmap_read(rdev_get_regmap(rdev), data->status_reg, &val);
> +	if (ret) {
> +		dev_err(dev, "error reading STATUS%d: %d\n",
> +			data->status_reg, ret);
> +		return ret;
> +	}

Same issues here.

> +	if (val & MAX20339_LSWxSHORTFAULT)
> +		*flags |=3D REGULATOR_ERROR_OVER_CURRENT;
> +
> +	if (val & MAX20339_LSWxOVFAULT)
> +		*flags |=3D REGULATOR_ERROR_OVER_VOLTAGE_WARN;
> +
> +	if (val & MAX20339_LSWxOCFAULT)
> +		*flags |=3D REGULATOR_ERROR_OVER_CURRENT;

These statuses should be flagged ot the core.

> +static int max20339_setup_irq(struct i2c_client *client,
> +			      struct regmap *regmap,
> +			      struct regulator_dev *rdevs[])
> +{
> +	u8 enabled_irqs[3];
> +	struct max20339_irq_data *max20339;
> +	int ret;
> +	unsigned long irq_flags;
> +
> +	/* the IRQ is optional */
> +	if (!client->irq) {
> +		enabled_irqs[0] =3D enabled_irqs[1] =3D enabled_irqs[2] =3D 0;

Please just write a normal series of assignments, it's much clearer.
`
> +		dev_info(&client->dev, "registered MAX20339 regulator %s\n",
> +			 max20339_regulators[i].desc.name);

This is just noise, remove it.

--+h+CYzyetNHuwcry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbpSbcACgkQJNaLcl1U
h9BRzwf+KEKw9eD78PbFbAThDy0JoZEkPtjx6vuMotDaiP5iBbcA+awC/CAGkVoV
8ZIJjcGU89UCcBn2xGZM+MdW+6GgYc1DXWRJcCiQI8HBpPMBKkecmeEEHEGRQv3J
M8HpqxXni8Af/zpDsHqW4cuAh5ZlLcJzeqZA/Uc9ngXEmad8X337VQ/5wwwVs1Fr
eFVRZZBbXlAjuoWf+0eGc43kY3KgxiEgUT9SlKIH32RwMgpAlyoFCb90k/4TyT+p
MVWlXaewGnZTHYY1P6gB/5pv5Ega0bd5uqRDxl01p7bfenPPR9CKF2OkPi/bg38T
SeikReG7DYDULpdeJhtjdml57EQp2g==
=XvxX
-----END PGP SIGNATURE-----

--+h+CYzyetNHuwcry--

