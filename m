Return-Path: <linux-kernel+bounces-396628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876909BCFC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463322837F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783C71D86CE;
	Tue,  5 Nov 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="arTxF/M2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1BEAD2;
	Tue,  5 Nov 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818441; cv=pass; b=lGZIhzO719duY3sYOlFvzLY0msBkq/wB2Z61cnDIbK4rEvIMTZCIDnrhMHVcwAu4Y7eb5Pzu5mAJpxjl70Ba3HHr2lLmXVw/QJSz6w+Q2Huo7V1NiNT9brWVUE255A6XnpMGmFZFtccKF7NY0e8EsZuFOPeSXPbgyz8mruQiICY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818441; c=relaxed/simple;
	bh=CLcGmCMNSBsbZK9TCBoAitB5hTQKQvqtUIlGVVU6yRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgXNE3MlKTVSmWQD5qECWjgH4iqm/bzkptJqtO+X2/GG8H5FQJSHjVMjf2/GZDoUBe81CbZxbUECWM5e39DH+qr+hye6+sAC7F+SKymjVdrFW8stc8YuPmyF2soc66WsYwPekUyuROMG0GxWP7aJBTgX6zK0fkbn/FPSxD0uImI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=arTxF/M2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730818427; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jxi2GQmxwbDRHoAb/jV/nhdQX7emwZgYCiM1D7UWm/jb0SghLxNUkj9Ickp6rB73yWEqWFlvITJIGIXOC7hmcD2qxvjPMXtGeWYMCCdijaPrfIbyIkiKsee5xDyRS0M4yPijxYbEmk2daNQb4z/sMUFnPop3LNXa7q3wuD75dV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730818427; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ee32TdMulUx3I73v+H9UKmfuOkSjV3xf62bP7n6clmg=; 
	b=M9mfj52Qug8z93qsGiDGcSjsT0Yy9Zn2lGkBB0gboQqQ4XnuHmw0HiZ9d0lQrZ8O2WstyvIp+SV7ZO0wt2p9RLk3z74827eKc9eRb7S1FSnX09eJbsWxjhyYl8FHNkzfO8C1a2CI3/hijQLBAhqCVRNL2t5JJon9OcuPGiRh2AE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730818427;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Ee32TdMulUx3I73v+H9UKmfuOkSjV3xf62bP7n6clmg=;
	b=arTxF/M2IohZlL4d+0q9FMY/vZrAbFVQQ1Gff5Mx38cL5CKqDx8zuxiECbxZUMSI
	J3F+mhj7lY7P3g6QZ9yXz3j4twt3ltOhEF4PGnqlSkyT7dOfXyMv0W35WwSV5U2HPjm
	KY6tlGpJ6atorq0rsmcebvn2OFAXozf5fA7WS6NA=
Received: by mx.zohomail.com with SMTPS id 1730818425742722.1607904366261;
	Tue, 5 Nov 2024 06:53:45 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id A289A10604C3; Tue, 05 Nov 2024 15:53:40 +0100 (CET)
Date: Tue, 5 Nov 2024 15:53:40 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/2] phy: rockchip: Add Samsung CSI/DSI Combo DCPHY
 driver
Message-ID: <fynyo2amqillioxwfyydvztakba5ecwa2qrtdtuoaffyvwc62c@3vizyubfqvsf>
References: <20241104111121.99274-1-heiko@sntech.de>
 <20241104111121.99274-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6mir4f2i4nre6yc"
Content-Disposition: inline
In-Reply-To: <20241104111121.99274-3-heiko@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/230.797.52
X-ZohoMailClient: External


--i6mir4f2i4nre6yc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] phy: rockchip: Add Samsung CSI/DSI Combo DCPHY
 driver
MIME-Version: 1.0

Hi,

On Mon, Nov 04, 2024 at 12:11:16PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> Add phy driver needed to drive either a MIPI DSI output to a DSI display
> or MIPI CSI input from a camera on rk3588.
>=20
> Right now only the DSI portion is implemented as the whole camera part
> needs more work in general.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---

Do you have a git branch with the DSI controller driver, so that
this can actually be tested? :)

>  drivers/phy/rockchip/Kconfig                  |   12 +
>  drivers/phy/rockchip/Makefile                 |    1 +
>  .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1654 +++++++++++++++++
>  3 files changed, 1667 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
>=20
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 2f7a05f21dc5..2bfb42996503 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -83,6 +83,18 @@ config PHY_ROCKCHIP_PCIE
>  	help
>  	  Enable this to support the Rockchip PCIe PHY.
> =20
> +config PHY_ROCKCHIP_SAMSUNG_DCPHY
> +	tristate "Rockchip Samsung MIPI DCPHY driver"
> +	depends on (ARCH_ROCKCHIP || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select GENERIC_PHY_MIPI_DPHY
> +	help
> +	  Enable this to support the Rockchip MIPI DCPHY with
> +	  Samsung IP block.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called phy-rockchip-samsung-dcphy
> +
>  config PHY_ROCKCHIP_SAMSUNG_HDPTX
>  	tristate "Rockchip Samsung HDMI/eDP Combo PHY driver"
>  	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index 010a824e32ce..117aaffd037d 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+=3D phy-rockchip-in=
no-hdmi.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+=3D phy-rockchip-inno-usb2.o
>  obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+=3D phy-rockchip-naneng-com=
bphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+=3D phy-rockchip-pcie.o
> +obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_DCPHY)	+=3D phy-rockchip-samsung-dcphy=
=2Eo
>  obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX)	+=3D phy-rockchip-samsung-hdptx=
=2Eo
>  obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+=3D phy-rockchip-snps-pcie3.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+=3D phy-rockchip-typec.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c b/drivers/=
phy/rockchip/phy-rockchip-samsung-dcphy.c
> new file mode 100644
> index 000000000000..a2f897fa5516
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
> @@ -0,0 +1,1654 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) Rockchip Electronics Co.Ltd
> + * Author:
> + *      Guochun Huang <hero.huang@rock-chips.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

I think this should be

#include <linux/mod_devicetable.h>

> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +

[...]

> +static void samsung_mipi_dcphy_bias_block_enable(struct samsung_mipi_dcp=
hy *samsung)
> +{
> +	u32 bias_con2 =3D 0x3223;
> +
> +	regmap_write(samsung->regmap, BIAS_CON0, 0x0010);
> +	regmap_write(samsung->regmap, BIAS_CON1, 0x0110);
> +	regmap_write(samsung->regmap, BIAS_CON2, bias_con2);
> +
> +	/* default output voltage select:
> +	 * dphy: 400mv
> +	 * cphy: 530mv
> +	 */
> +	regmap_update_bits(samsung->regmap, BIAS_CON4,
> +			   I_MUX_SEL_MASK, I_MUX_SEL_400MV);
> +}
> +
> +static void samsung_mipi_dcphy_bias_block_disable(struct samsung_mipi_dc=
phy *samsung)
> +{
> +}

uhm? :)

[...]

> +static const struct samsung_mipi_dphy_timing *
> +samsung_mipi_dphy_get_timing(struct samsung_mipi_dcphy *samsung)
> +{
> +	const struct samsung_mipi_dphy_timing *timings;
> +	unsigned int num_timings;
> +	unsigned int lane_mbps =3D div64_ul(samsung->pll.rate, USEC_PER_SEC);
> +	unsigned int i;
> +
> +	timings =3D samsung_mipi_dphy_timing_table;
> +	num_timings =3D ARRAY_SIZE(samsung_mipi_dphy_timing_table);
> +
> +	for (i =3D num_timings; i > 0; i--)
> +		if (lane_mbps <=3D timings[i - 1].max_lane_mbps)
> +			break;
> +
> +	if (i =3D=3D 0)
> +		++i;

I guess you can just do 'for (i =3D max; i > 1; i--)' instead of
counting to 0 and then go back to 1?

> +
> +	return &timings[i - 1];
> +}

[...]

> +static int samsung_mipi_dphy_power_on(struct samsung_mipi_dcphy *samsung)
> +{
> +	int ret;
> +
> +	reset_control_assert(samsung->m_phy_rst);
> +
> +	samsung_mipi_dcphy_bias_block_enable(samsung);
> +	samsung_mipi_dcphy_pll_configure(samsung);
> +	samsung_mipi_dphy_clk_lane_timing_init(samsung);
> +	samsung_mipi_dphy_data_lane_timing_init(samsung);
> +	ret =3D samsung_mipi_dcphy_pll_enable(samsung);
> +	if (ret < 0) {
> +		samsung_mipi_dcphy_bias_block_disable(samsung);
> +		return ret;
> +	}
> +
> +	samsung_mipi_dphy_lane_enable(samsung);
> +
> +	reset_control_deassert(samsung->m_phy_rst);
> +
> +	/* The TSKEWCAL maximum is 100 =B5sec
> +	 * at initial calibration.
> +	 */
> +	usleep_range(100, 110);
> +
> +	return 0;
> +}
> +
> +static int samsung_mipi_dcphy_power_on(struct phy *phy)
> +{
> +	struct samsung_mipi_dcphy *samsung =3D phy_get_drvdata(phy);
> +	enum phy_mode mode =3D phy_get_mode(phy);
> +
> +	pm_runtime_get_sync(samsung->dev);

This already happened in samsung_mipi_dcphy_init?

> +	reset_control_assert(samsung->apb_rst);
> +	udelay(1);
> +	reset_control_deassert(samsung->apb_rst);
> +
> +	switch (mode) {
> +	case PHY_MODE_MIPI_DPHY:
> +		return samsung_mipi_dphy_power_on(samsung);
> +	default:
> +		/* CSI cphy part to be implemented later */
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int samsung_mipi_dcphy_power_off(struct phy *phy)
> +{
> +	struct samsung_mipi_dcphy *samsung =3D phy_get_drvdata(phy);
> +	enum phy_mode mode =3D phy_get_mode(phy);
> +
> +	switch (mode) {
> +	case PHY_MODE_MIPI_DPHY:
> +		samsung_mipi_dphy_lane_disable(samsung);
> +		break;
> +	default:
> +		/* CSI cphy part to be implemented later */
> +		return -EOPNOTSUPP;
> +	}
> +
> +	samsung_mipi_dcphy_pll_disable(samsung);
> +	samsung_mipi_dcphy_bias_block_disable(samsung);
> +
> +	pm_runtime_put(samsung->dev);
> +
> +	return 0;
> +}
> +
> +static int samsung_mipi_dcphy_set_mode(struct phy *phy, enum phy_mode mo=
de,
> +				       int submode)
> +{
> +	return 0;
> +}

You can just remove this. phy_set_mode_ext() will return 0 byself if
the callback is NULL.

[...]

> +static int samsung_mipi_dcphy_init(struct phy *phy)
> +{
> +	struct samsung_mipi_dcphy *samsung =3D phy_get_drvdata(phy);
> +
> +	pm_runtime_get_sync(samsung->dev);

return pm_runtime_resume_and_get(samsung->dev);

> +	return 0;
> +}
> +
> +static int samsung_mipi_dcphy_exit(struct phy *phy)
> +{
> +	struct samsung_mipi_dcphy *samsung =3D phy_get_drvdata(phy);
> +
> +	pm_runtime_put(samsung->dev);

return pm_runtime_put(samsung->dev);

> +
> +	return 0;
> +}

[...]

> +static __maybe_unused int samsung_mipi_dcphy_runtime_suspend(struct devi=
ce *dev)
> +{
> +	struct samsung_mipi_dcphy *samsung =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(samsung->pclk);
> +	clk_disable_unprepare(samsung->ref_clk);
> +
> +	return 0;
> +}
> +
> +static __maybe_unused int samsung_mipi_dcphy_runtime_resume(struct devic=
e *dev)
> +{
> +	struct samsung_mipi_dcphy *samsung =3D dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(samsung->pclk);
> +	clk_prepare_enable(samsung->ref_clk);
> +
> +	return 0;
> +}

No error checking for managing the clocks?

[...]

> +static const struct of_device_id samsung_mipi_dcphy_of_match[] =3D {
> +	{
> +		.compatible =3D "rockchip,rk3576-mipi-dcphy",
> +		.data =3D &rk3576_samsung_mipi_dcphy_plat_data,
> +	}, {
> +		.compatible =3D "rockchip,rk3588-mipi-dcphy",
> +		.data =3D &rk3588_samsung_mipi_dcphy_plat_data,
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, samsung_mipi_dcphy_of_match);
> +
> +static struct platform_driver samsung_mipi_dcphy_driver =3D {
> +	.driver =3D {
> +		.name =3D "samsung-mipi-dcphy",
> +		.of_match_table	=3D of_match_ptr(samsung_mipi_dcphy_of_match),

drop of_match_ptr(). The way it is used right now just brings
a compiler warning for CONFIG_OF=3Dn.

> +		.pm =3D &samsung_mipi_dcphy_pm_ops,
> +	},
> +	.probe	=3D samsung_mipi_dcphy_probe,
> +};
> +module_platform_driver(samsung_mipi_dcphy_driver);
> +
> +MODULE_AUTHOR("Guochun Huang<hero.huang@rock-chips.com>");

space before <

> +MODULE_DESCRIPTION("Samsung MIPI DCPHY Driver");
> +MODULE_LICENSE("GPL");

Greetings,

-- Sebastian

--i6mir4f2i4nre6yc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmcqMWgACgkQ2O7X88g7
+pqVJg/7BGqrI9xyIPDlozpRxfCLRIU82nO2vXrSxFG+rkgDHEdifsnhLRhYX2k9
Jf886rm7pohlqTxtViKnn4hOE4yqNW3NuSXuKjZO6TnWHldvUzt4s7/fFQkViQEi
Pr+/QJ9AUZxGH0hhN9FmUUcjhi0qShlqnsLiO42t9aaxyLktdp8N68xw9ZpX8F9K
avZ8xSHbKBI37kMyqgU9cjFZ9pkAcf5JpMQusVCT6IqeuDzfvEbM08P7yPxPusPc
UKxYS/YQGTOniKmpSZHQKtIcf6AFNZS1JoakYgv7tzWtNY7Vgswlg9KrzCEmFvIg
aXNfFA1IUXngFtzlJL9KDOwqwMEowDjZzLUJCkzWl9DNo/qM2XjVXVwer6uDMdMm
bIV3AVGamiBlvBghK+Rjd/9CiCFKUz4rl3rjgpFE+odrUvxff9gFYT/xow3YyvNN
OBwD5VGijFHPq6jbra+nY/v6BroGSStHoY+JB4NVta515BI3ZYALpKxW4HTW5kcV
5eABPItHa9+3rw23N6y/cGpjwbRBavnI1PJYclo5hLc4mDRW9O6j2C9luRxXVOnF
Hq/sXX+c6h50U63Kd6msyt8qBIokhm7bxn6YGVvC23XoXhbZfg8yrYHEthkXl6bG
2NM7FHwRAmylSkstCg9gzYfxdwSP8p3m8RA9ubJ7HVoHPGLML9I=
=O1X7
-----END PGP SIGNATURE-----

--i6mir4f2i4nre6yc--

