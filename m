Return-Path: <linux-kernel+bounces-528344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA72A416B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B227A10E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8445241663;
	Mon, 24 Feb 2025 07:55:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D8207DF7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383753; cv=none; b=VFI5LqxJFbiZMIYVvKRWDiIhe47srBfk4AjQcOHV2f/ftKQuUdsy3ueG5jaxAwPuBqZCd8JiehZLuyZ9ZSgRcAaA3ClFyqk6UbA3wDH+pHWkB3Imd2hl5MrDgDp9ei0YMY8WfNuhgNS0hLL2882VYSgQtlv2ntkVguSYTKVVpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383753; c=relaxed/simple;
	bh=Rmom2qkXeLYVVxaAC+CYsG2On1lDNH+srFbmeOI+SKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2Tb2848alsgxkdHcMA5h7Dlpd8rJAGQZ7f/LTmqHOiZ2/keVB1tzxm6cyDs6JN+x5SAls42dHS1le4dnWlGT0RWhCVia/B8mTZWEqTL5ry9sKyHbn0NlzlPaAcwCkGPJNyC3zbmvfc6h+5MlxJLDSPMi+GNMuFw7PHea9FUJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tmTJS-00024I-Up; Mon, 24 Feb 2025 08:55:38 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tmTJS-002YWc-1Y;
	Mon, 24 Feb 2025 08:55:38 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tmTJS-00FNGw-1D;
	Mon, 24 Feb 2025 08:55:38 +0100
Date: Mon, 24 Feb 2025 08:55:38 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev
Subject: Re: [PATCH 3/5] bus: add driver for IMX AIPSTZ bridge
Message-ID: <20250224075538.7oetjzllqqr2mlnt@pengutronix.de>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-4-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221191909.31874-4-laurentiumihalcea111@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Laurentiu,

thanks for your patch.

On 25-02-21, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> The secure AHB to IP Slave (AIPSTZ) bus bridge provides access control
> configurations meant to restrict access to certain peripherals.
> Some of the configurations include:
> 
> 	1) Marking masters as trusted for R/W. Based on this
> 	(and the configuration of the accessed peripheral), the bridge
> 	may choose to abort the R/W transactions issued by certain
> 	masters.

Setting these bits requires very often that the core is running at EL3
(e.g. secure-monitor) which is not the case for Linux. Can you please
provide more information how Linux can set these bits?

Regards,
  Marco


> 
> 	2) Allowing/disallowing write accesses to peripherals.
> 
> Add driver for this IP. Since there's currently no framework for
> access controllers (and since there's currently no need for having
> flexibility w.r.t the configurations) all this driver does is it
> applies a relaxed, "default" configuration, in which all masters
> are trusted for R/W.
> 
> Note that some instances of this IP may be tied to a power domain and may
> lose their configuration when the domain is powered off. This is why the
> configuration has to be restored when the domain is powered on.
> 
> Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/bus/Kconfig      |  6 +++
>  drivers/bus/Makefile     |  1 +
>  drivers/bus/imx-aipstz.c | 92 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 drivers/bus/imx-aipstz.c
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index ff669a8ccad9..fe7600283e70 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -87,6 +87,12 @@ config HISILICON_LPC
>  	  Driver to enable I/O access to devices attached to the Low Pin
>  	  Count bus on the HiSilicon Hip06/7 SoC.
>  
> +config IMX_AIPSTZ
> +	tristate "Support for IMX Secure AHB to IP Slave bus (AIPSTZ) bridge"
> +	depends on ARCH_MXC
> +	help
> +	  Enable support for IMX AIPSTZ bridge.
> +
>  config IMX_WEIM
>  	bool "Freescale EIM DRIVER"
>  	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index cddd4984d6af..8e693fe8a03a 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
>  
>  obj-$(CONFIG_BT1_APB)		+= bt1-apb.o
>  obj-$(CONFIG_BT1_AXI)		+= bt1-axi.o
> +obj-$(CONFIG_IMX_AIPSTZ)	+= imx-aipstz.o
>  obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
>  obj-$(CONFIG_INTEL_IXP4XX_EB)	+= intel-ixp4xx-eb.o
>  obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
> diff --git a/drivers/bus/imx-aipstz.c b/drivers/bus/imx-aipstz.c
> new file mode 100644
> index 000000000000..75696eac8ba2
> --- /dev/null
> +++ b/drivers/bus/imx-aipstz.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#define IMX_AIPSTZ_MPR0 0x0
> +
> +struct imx_aipstz_config {
> +	u32 mpr0;
> +};
> +
> +static void imx_aipstz_apply_default(void __iomem *base,
> +				     const struct imx_aipstz_config *default_cfg)
> +{
> +	writel(default_cfg->mpr0, base + IMX_AIPSTZ_MPR0);
> +}
> +
> +static int imx_aipstz_probe(struct platform_device *pdev)
> +{
> +	void __iomem *base;
> +	const struct imx_aipstz_config *default_cfg;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +	if (IS_ERR(base))
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "failed to get/ioremap memory\n");
> +
> +	default_cfg = of_device_get_match_data(&pdev->dev);
> +
> +	imx_aipstz_apply_default(base, default_cfg);
> +
> +	dev_set_drvdata(&pdev->dev, base);
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	devm_pm_runtime_enable(&pdev->dev);
> +
> +	return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static int imx_aipstz_runtime_resume(struct device *dev)
> +{
> +	void __iomem *base;
> +	const struct imx_aipstz_config *default_cfg;
> +
> +	base = dev_get_drvdata(dev);
> +	default_cfg = of_device_get_match_data(dev);
> +
> +	/* restore potentially lost configuration during domain power-off */
> +	imx_aipstz_apply_default(base, default_cfg);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops imx_aipstz_pm_ops = {
> +	RUNTIME_PM_OPS(NULL, imx_aipstz_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +};
> +
> +/*
> + * following configuration is equivalent to:
> + *	masters 0-7 => trusted for R/W + use AHB's HPROT[1] to det. privilege
> + */
> +static const struct imx_aipstz_config imx8mp_aipstz_default_cfg = {
> +	.mpr0 = 0x77777777,
> +};
> +
> +static const struct of_device_id imx_aipstz_of_ids[] = {
> +	{ .compatible = "fsl,imx8mp-aipstz", .data = &imx8mp_aipstz_default_cfg },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_aipstz_of_ids);
> +
> +static struct platform_driver imx_aipstz_of_driver = {
> +	.probe = imx_aipstz_probe,
> +	.driver = {
> +		.name = "imx-aipstz",
> +		.of_match_table = imx_aipstz_of_ids,
> +		.pm = pm_ptr(&imx_aipstz_pm_ops),
> +	},
> +};
> +module_platform_driver(imx_aipstz_of_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("IMX secure AHB to IP Slave bus (AIPSTZ) bridge driver");
> +MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
> -- 
> 2.34.1
> 
> 
> 

