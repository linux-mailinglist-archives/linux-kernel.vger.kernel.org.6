Return-Path: <linux-kernel+bounces-445273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E69F1399
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA5E188924D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD81E4928;
	Fri, 13 Dec 2024 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="e2TJocpo"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6621657C9F;
	Fri, 13 Dec 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110897; cv=none; b=dspMW2FrZFSsCDbRHxW+gFnvcXtIBL/Pula3S2AU/xM8eU7TNgBEPfSf1KarIbOETI8efqVyRF2t9c+jacDZPSynKwmkJLW80mUaI19pTE5QD7RZ0OIvkRwbrPiPObcqPctvUzTADDaJTqGOEP2Ivn+pgkJtiLWYdVhPNV0y3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110897; c=relaxed/simple;
	bh=haH3Rn5PYN3U2wPwvi1COnmwL40Uvl3whX0M0/7EE+c=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=HbkSd7jyw0BAZ0GR1sfJsvQ1jUlEMEF6n7AoRZGeHLPkp1BXuENbRNEyDhIcvV67t3Sh9n+iD1xQFeHzmF8F+8iI5yc1/mwg78qRb9GCfG5HGJZzr2VwqD2QAf+YQagR9ye0eQG9mXY/cv4aY8+C557JcGEPBtg0comOcWdIcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=e2TJocpo; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id M9SQtfQ8j16pxM9SQtU7u4; Fri, 13 Dec 2024 18:28:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734110887;
	bh=s4uiRQCfXe+FdF52hvdqt171dAmo/jnoIJf3tzdSEcc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=e2TJocpoiVNnyK3QX7uoulgNaqGjw567eVLSNvbbeIKHZMz2Kz/zSEnP1kMKoQP0J
	 xJQCt2p8WxKECeZZixAbbMysmBQablAYOew0huzvDqMpFKizZyYOzyzh23ZRuqg61U
	 wkT8IUSdKpRMjXjqEbcW468HzLPtWfJ+xAKRH4Rlrt2skVSqiYSUQ0c64kQZ+m5Ka3
	 Iao5X+giwmgXSBIRwtq6uwVqZD3J13oc4JIdEW0Ao3Q6YiJqSBBrNx5E+M5rN7YN2C
	 aBsWpYBc0ZtGPOwyKmPldd4uKUyHr78oGZ+ComU3KB4hHNgDBD8saYpS+gzIeUt/ee
	 oGQ7npBIzFsJg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Dec 2024 18:28:07 +0100
X-ME-IP: 90.11.132.44
Message-ID: <e0bba4d8-8015-482a-b08d-c30aafcae924@wanadoo.fr>
Date: Fri, 13 Dec 2024 18:28:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] regulator: pf9453: add PMIC PF9453 support
References: <20241212-pf9453-v2-0-f59d2c096356@nxp.com>
 <20241212-pf9453-v2-2-f59d2c096356@nxp.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20241212-pf9453-v2-2-f59d2c096356@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/12/2024 à 23:26, Frank Li a écrit :
> From: Joy Zou <joy.zou-3arQi8VN3Tc@public.gmane.org>
> 
> Support new PMIC PF9453, which is totally difference with PCA9450. So
> create new file for it.
> 
> The PF9453 is a single chip Power Management IC (PMIC) specifically
> designed for i.MX 91 processor. It provides power supply solutions for IoT
> (Internet of Things), smart appliance, and portable applications where size
> and efficiency are critical. The device provides four high efficiency
> step-down regulators, three LDOs, one 400 mA load switch and 32.768 kHz
> crystal oscillator driver.

Hi, a few nitpicks, should a v3 be needed.

...

> +static int pf9453_i2c_probe(struct i2c_client *i2c)
> +{
> +	const struct pf9453_regulator_desc *regulator_desc = of_device_get_match_data(&i2c->dev);
> +	struct regulator_config config = { };
> +	unsigned int reset_ctrl;
> +	unsigned int device_id;
> +	struct pf9453 *pf9453;
> +	int ret;
> +
> +	if (!i2c->irq)
> +		return dev_err_probe(&i2c->dev, -EINVAL, "No IRQ configured?\n");
> +
> +	pf9453 = devm_kzalloc(&i2c->dev, sizeof(struct pf9453), GFP_KERNEL);
> +	if (!pf9453)
> +		return -ENOMEM;
> +
> +	pf9453->regmap = devm_regmap_init_i2c(i2c, &pf9453_regmap_config);
> +	if (IS_ERR(pf9453->regmap))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->regmap),
> +				     "regmap initialization failed\n");
> +
> +	pf9453->irq = i2c->irq;
> +	pf9453->dev = &i2c->dev;
> +
> +	dev_set_drvdata(&i2c->dev, pf9453);
> +
> +	ret = regmap_read(pf9453->regmap, PF9453_REG_DEV_ID, &device_id);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,  "Read device id error\n");

Nitpick: 2 spaces

> +
> +	/* Check your board and dts for match the right pmic */
> +	if ((device_id >> 4) != 0xB)
> +		return dev_err_probe(&i2c->dev, -EINVAL, "Device id(%x) mismatched\n",
> +				     device_id >> 4);
> +
> +	while (regulator_desc->desc.name) {
> +		const struct regulator_desc *desc;
> +		struct regulator_dev *rdev;
> +
> +		desc = &regulator_desc->desc;
> +
> +		config.regmap = pf9453->regmap;
> +		config.dev = pf9453->dev;
> +
> +		rdev = devm_regulator_register(pf9453->dev, desc, &config);
> +		if (IS_ERR(rdev))
> +			return dev_err_probe(pf9453->dev, PTR_ERR(rdev),
> +					     "Failed to register regulator(%s)\n", desc->name);
> +
> +		regulator_desc++;
> +	}
> +
> +	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL,
> +					pf9453_irq_handler,
> +					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
> +					"pf9453-irq", pf9453);
> +	if (ret)
> +		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
> +
> +	/* Unmask all interrupt except PWRON/WDOG/RSVD */
> +	ret = pf9453_pmic_write(pf9453, PF9453_REG_INT1_MSK,
> +				IRQ_ONKEY | IRQ_RESETKEY | IRQ_RSTB | IRQ_VR_FLT1
> +				| IRQ_LOWVSYS | IRQ_THERM_100 | IRQ_THERM_80,
> +				IRQ_RSVD);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,  "Unmask irq error\n");

Nitpick: 2 spaces

> +
> +	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
> +		reset_ctrl = WDOG_B_CFG_WARM;
> +	else
> +		reset_ctrl = WDOG_B_CFG_COLD;

...

> diff --git a/drivers/regulator/pf9453.h b/drivers/regulator/pf9453.h
> new file mode 100644
> index 0000000000000..14d6343d42658
> --- /dev/null
> +++ b/drivers/regulator/pf9453.h
> @@ -0,0 +1,171 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright 2024 NXP. */
> +
> +#ifndef __LINUX_REG_PF9453_H__
> +#define __LINUX_REG_PF9453_H__
> +
> +#include <linux/regmap.h>

This .h file does not need it.
Should it be placed in the .c file?

> +
> +enum {
> +	PF9453_BUCK1 = 0,
> +	PF9453_BUCK2,
> +	PF9453_BUCK3,
> +	PF9453_BUCK4,
> +	PF9453_LDO1,
> +	PF9453_LDO2,
> +	PF9453_LDOSNVS,
> +	PF9453_REGULATOR_CNT,

Nitpick: such terminator don't need an ending comma

> +};
> +
> +enum {
> +	PF9453_DVS_LEVEL_RUN = 0,
> +	PF9453_DVS_LEVEL_STANDBY,
> +	PF9453_DVS_LEVEL_DPSTANDBY,
> +	PF9453_DVS_LEVEL_MAX,

Nitpick: such terminator don't need an ending comma

> +};

...

> +enum {
> +	PF9453_REG_DEV_ID              = 0x00,
> +	PF9453_REG_OTP_VER             = 0x01,
> +	PF9453_REG_INT1                = 0x02,
> +	PF9453_REG_INT1_MSK            = 0x03,
> +	PF9453_REG_INT1_STATUS         = 0x04,
> +	PF9453_REG_VRFLT1_INT          = 0x05,
> +	PF9453_REG_VRFLT1_MASK         = 0x06,
> +	PF9453_REG_PWRON_STAT          = 0x07,
> +	PF9453_REG_RESET_CTRL          = 0x08,
> +	PF9453_REG_SW_RST              = 0x09,
> +	PF9453_REG_PWR_CTRL            = 0x0a,
> +	PF9453_REG_CONFIG1             = 0x0b,
> +	PF9453_REG_CONFIG2             = 0x0c,
> +	PF9453_REG_32K_CONFIG          = 0x0d,
> +	PF9453_REG_BUCK1CTRL           = 0x10,
> +	PF9453_REG_BUCK1OUT            = 0x11,
> +	PF9453_REG_BUCK2CTRL           = 0x14,
> +	PF9453_REG_BUCK2OUT            = 0x15,
> +	PF9453_REG_BUCK2OUT_STBY       = 0x1D,
> +	PF9453_REG_BUCK2OUT_MAX_LIMIT  = 0x1F,
> +	PF9453_REG_BUCK2OUT_MIN_LIMIT  = 0x20,
> +	PF9453_REG_BUCK3CTRL           = 0x21,
> +	PF9453_REG_BUCK3OUT            = 0x22,
> +	PF9453_REG_BUCK4CTRL           = 0x2e,
> +	PF9453_REG_BUCK4OUT            = 0x2f,
> +	PF9453_REG_LDO1OUT_L           = 0x36,
> +	PF9453_REG_LDO1CFG             = 0x37,
> +	PF9453_REG_LDO1OUT_H           = 0x38,
> +	PF9453_REG_LDOSNVS_CFG1        = 0x39,
> +	PF9453_REG_LDOSNVS_CFG2        = 0x3a,
> +	PF9453_REG_LDO2CFG             = 0x3b,
> +	PF9453_REG_LDO2OUT             = 0x3c,
> +	PF9453_REG_BUCK_POK            = 0x3d,
> +	PF9453_REG_LSW_CTRL1           = 0x40,
> +	PF9453_REG_LSW_CTRL2           = 0x41,
> +	PF9453_REG_LOCK                = 0x4e,
> +	PF9453_MAX_REG,

Nitpick: such terminator don't need an ending comma

> +};
> +
> +#define PF9453_UNLOCK_KEY               0x5c
> +#define PF9453_LOCK_KEY			0x0
> +
> +/* PF9453 BUCK ENMODE bits */
> +#define BUCK_ENMODE_OFF			0x00
> +#define BUCK_ENMODE_ONREQ		0x01
> +#define BUCK_ENMODE_ONREQ_STBY		0x02
> +#define BUCK_ENMODE_ONREQ_STBY_DPSTBY	0x03
> +
> +/* PF9453 BUCK ENMODE bits */
> +#define LDO_ENMODE_OFF			0x00
> +#define LDO_ENMODE_ONREQ		0x01
> +#define LDO_ENMODE_ONREQ_STBY		0x02
> +#define LDO_ENMODE_ONREQ_STBY_DPSTBY	0x03
> +
> +/* PF9453_REG_BUCK1_CTRL bits */
> +#define BUCK1_LPMODE			0x30
> +#define BUCK1_AD			0x08
> +#define BUCK1_FPWM			0x04
> +#define BUCK1_ENMODE_MASK		0x03
> +
> +/* PF9453_REG_BUCK2_CTRL bits */
> +#define BUCK2_RAMP_MASK			0xC0

Here and below some uppercase alpha are used, while above only lowercase 
are used. Below is apparently for masks.

Maybe masks could be written with GENMASK()?
(no strong opinion if this would help readability)

> +#define BUCK2_RAMP_25MV			0x0
> +#define BUCK2_RAMP_12P5MV		0x1
> +#define BUCK2_RAMP_6P25MV		0x2
> +#define BUCK2_RAMP_3P125MV		0x3
> +#define BUCK2_LPMODE			0x30
> +#define BUCK2_AD			0x08
> +#define BUCK2_FPWM			0x04
> +#define BUCK2_ENMODE_MASK		0x03

...

CJ


