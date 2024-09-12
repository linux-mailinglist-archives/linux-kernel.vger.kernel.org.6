Return-Path: <linux-kernel+bounces-326841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA08976D98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C5A28843D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E51BBBC5;
	Thu, 12 Sep 2024 15:19:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B91B1507
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154346; cv=none; b=dd2ZAzXEnUPOtpzUq+GOAdJFk2f14rDsHIiE0SGQbaFaJn9nM2Gs4w+bDlJZBFBG0lxlmjSd4H87GgYjpJmaP5dTNEes9NhgYVFTPSGThxUClPPnWeYd4As9PsZv+Ei44mMi2VelghQr4ahs6SNiDULiKfwQiaC69R5khh8F4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154346; c=relaxed/simple;
	bh=OsLJojm96pMS4IXnyVQSRLVdKdQHtsLTw4J4pA0PcfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQe5j47F3cg/x/SrNckORu6p3rUMRhfGrOcrU1PS4puSjRyPimQo0WBEfFuNPAMbfpkTKJFVAkpxpPZ9eAdiKAvgu+4gbCEuhPHacUFa6vbgNrRXNRltlGX6pafG+jfZnzlZSqWYhF8mL03mu+lsKvy84F8UPc38TEuPXHu/3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1solae-0001q5-UB; Thu, 12 Sep 2024 17:18:36 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1solad-007PUI-AE; Thu, 12 Sep 2024 17:18:35 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1solad-000BWk-0l;
	Thu, 12 Sep 2024 17:18:35 +0200
Message-ID: <d003cb854f9aea30c7d26b4d2b7f50cf467bf225.camel@pengutronix.de>
Subject: Re: [PATCH RESEND v27 2/3] reset: npcm: register npcm8xx clock
 auxiliary bus device
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tomer Maimon <tmaimon77@gmail.com>, mturquette@baylibre.com, 
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
 yuenn@google.com,  benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 12 Sep 2024 17:18:35 +0200
In-Reply-To: <20240815150255.3996258-3-tmaimon77@gmail.com>
References: <20240815150255.3996258-1-tmaimon77@gmail.com>
	 <20240815150255.3996258-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2024-08-15 at 18:02 +0300, Tomer Maimon wrote:
> Add NPCM8xx clock controller auxiliary bus device registration.
>=20
> The NPCM8xx clock controller is registered as an aux device because the
> reset and the clock controller share the same register region.
>=20
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Benjamin Fair <benjaminfair@google.com>
> ---
>  drivers/reset/Kconfig               |  1 +
>  drivers/reset/reset-npcm.c          | 74 ++++++++++++++++++++++++++++-
>  include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
>  3 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100755 include/soc/nuvoton/clock-npcm8xx.h
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 67bce340a87e..c6bf5275cca2 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -157,6 +157,7 @@ config RESET_MESON_AUDIO_ARB
>  config RESET_NPCM
>  	bool "NPCM BMC Reset Driver" if COMPILE_TEST
>  	default ARCH_NPCM
> +	select AUXILIARY_BUS
>  	help
>  	  This enables the reset controller driver for Nuvoton NPCM
>  	  BMC SoCs.
> diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> index 8935ef95a2d1..aa68b947226a 100644
> --- a/drivers/reset/reset-npcm.c
> +++ b/drivers/reset/reset-npcm.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2019 Nuvoton Technology corporation.
> =20
> +#include <linux/auxiliary_bus.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -10,11 +11,14 @@
>  #include <linux/property.h>
>  #include <linux/reboot.h>
>  #include <linux/reset-controller.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <linux/of_address.h>
> =20
> +#include <soc/nuvoton/clock-npcm8xx.h>
> +
>  /* NPCM7xx GCR registers */
>  #define NPCM_MDLR_OFFSET	0x7C
>  #define NPCM7XX_MDLR_USBD0	BIT(9)
> @@ -89,6 +93,7 @@ struct npcm_rc_data {
>  	const struct npcm_reset_info *info;
>  	struct regmap *gcr_regmap;
>  	u32 sw_reset_number;
> +	struct device *dev;
>  	void __iomem *base;
>  	spinlock_t lock;
>  };
> @@ -372,6 +377,67 @@ static const struct reset_control_ops npcm_rc_ops =
=3D {
>  	.status		=3D npcm_rc_status,
>  };
> =20
> +static void npcm_clock_unregister_adev(void *_adev)
> +{
> +	struct auxiliary_device *adev =3D _adev;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static void npcm_clock_adev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +	struct npcm_clock_adev *rdev =3D to_npcm_clock_adev(adev);
> +
> +	kfree(rdev);
> +}
> +
> +static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_dat=
a *rst_data, char *clk_name)
> +{
> +	struct npcm_clock_adev *rdev;
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +	if (!rdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rdev->base =3D rst_data->base;
> +
> +	adev =3D &rdev->adev;
> +	adev->name =3D clk_name;
> +	adev->dev.parent =3D rst_data->dev;
> +	adev->dev.release =3D npcm_clock_adev_release;
> +	adev->id =3D 555u;
> +
> +	ret =3D auxiliary_device_init(adev);
> +	if (ret) {
> +		kfree(rdev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return adev;
> +}
> +
> +static int npcm8xx_clock_controller_register(struct npcm_rc_data *rst_da=
ta, char *clk_name)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev =3D npcm_clock_adev_alloc(rst_data, clk_name);
> +	if (IS_ERR(adev))
> +		return PTR_ERR(adev);
> +
> +	ret =3D auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(rst_data->dev, npcm_clock_unregister_ad=
ev, adev);
> +}
> +
>  static int npcm_rc_probe(struct platform_device *pdev)
>  {
>  	struct npcm_rc_data *rc;
> @@ -392,6 +458,7 @@ static int npcm_rc_probe(struct platform_device *pdev=
)
>  	rc->rcdev.of_node =3D pdev->dev.of_node;
>  	rc->rcdev.of_reset_n_cells =3D 2;
>  	rc->rcdev.of_xlate =3D npcm_reset_xlate;
> +	rc->dev =3D &pdev->dev;
> =20
>  	ret =3D devm_reset_controller_register(&pdev->dev, &rc->rcdev);
>  	if (ret) {
> @@ -413,7 +480,12 @@ static int npcm_rc_probe(struct platform_device *pde=
v)
>  		}
>  	}
> =20
> -	return ret;
> +	switch (rc->info->bmc_id) {
> +	case BMC_NPCM8XX:

Here ret is ignored, which may be the return value from
register_restart_handler() above.

> +		return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
> +	default:
> +		return ret;
> +	}
>  }
> =20
>  static struct platform_driver npcm_rc_driver =3D {
> diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/cl=
ock-npcm8xx.h
> new file mode 100755
> index 000000000000..139130e98c51
> --- /dev/null
> +++ b/include/soc/nuvoton/clock-npcm8xx.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_NPCM8XX_CLOCK_H
> +#define __SOC_NPCM8XX_CLOCK_H
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/container_of.h>
> +
> +struct npcm_clock_adev {
> +	void __iomem *base;
> +	struct auxiliary_device adev;
> +};
> +
> +#define to_npcm_clock_adev(_adev) \
> +	container_of((_adev), struct npcm_clock_adev, adev)

Could you make this an inline function instead?

With those two issues addressed,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

