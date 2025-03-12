Return-Path: <linux-kernel+bounces-557572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E2A5DAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4D63A516D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF0723E23D;
	Wed, 12 Mar 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn119/Il"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32F23C8AF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776871; cv=none; b=tu4CnBxWqL/6UAlxRWkfopIWv0Bgw1jk8NsA1sEegHcbv/2OZhZs3X+FvPNFtn+tKWR6Z/qR118GIbsIITaK050NWS2YCF0LO9nZM8KwW9090+6D19qQ+2ELA1X6bwo5drNWO1FhgLd633TdacvFp41owCsSHhAY1lO3ijzyGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776871; c=relaxed/simple;
	bh=QBj9MPRhfNPCNVRIvIod4Gn+rYF2+EisbH1ikQuqblc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9PL8c8ivQPhPff87xOFw+oty2E+3D+o4kEdTxB16k0x4HRqIbXzDyJp1K7I6//sgpyvVqCW2/68XCVRq7nPsvfgj5LbHnNGHJlE/LCaWFNaUEI2S+WIrvgZ4Wxz044JZtwquVYa10760eVsJwYJ7Y8usKNw1k7F5hfmDbi4nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn119/Il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C24C4CEE3;
	Wed, 12 Mar 2025 10:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741776871;
	bh=QBj9MPRhfNPCNVRIvIod4Gn+rYF2+EisbH1ikQuqblc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nn119/IljdlidLnBXw5BA8I+TeQ7YF27/DfdazrFIGhFOyvQmeUfrKLhAh7pofuKL
	 zlf3EVmAIq0tKbwCjNqRRfDMS0Q2m1zFPsrFFG+rW4110hZa7Jqa2nQtmUFrP4KFSP
	 57GSUlPA7VhiSveOcwNofTHErc7XE4XcaJwKVgAwu9dSkmL485nvI+AU5FoXB3rffp
	 WDaWSWikLlN7lNEnsnBSE70mZ9ZEOLW6fVgTSTdnxCSrxzgmUQol6McS+TA/n7iMx/
	 HkasIrJIUCnujOVkTbTj2Rex8B9ui/g7MhZJY//CyIDQmU74cIra6T2A+QGcmDiTzt
	 BT4c9MBF/jpoQ==
Message-ID: <51ed5660-10fe-4a6f-ad99-9741187341b1@kernel.org>
Date: Wed, 12 Mar 2025 11:54:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drivers/misc: add silex multipk driver
To: Nipun Gupta <nipun.gupta@amd.com>, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: praveen.jain@amd.com, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
 srivatsa@csail.mit.edu, code@tyhicks.com, ptsm@linux.microsoft.com
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250312095421.1839220-1-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/03/2025 10:54, Nipun Gupta wrote:
> +
>  SILICON LABS WIRELESS DRIVERS (for WFxxx series)
>  M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
>  S:	Supported
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 56bc72c7ce4a..8c5c72c540a6 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -632,6 +632,12 @@ config MCHP_LAN966X_PCI
>  	    - lan966x-miim (MDIO_MSCC_MIIM)
>  	    - lan966x-switch (LAN966X_SWITCH)
> 
> +config SILEX_MPK
> +	tristate "Silex MultiPK driver"
> +	depends on OF

Why can't this be compile tested?

Which arch uses it? Which hardware?

> +	help
> +	  Enable Silex MultiPK support
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 545aad06d088..456758b29f71 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -75,3 +75,4 @@ lan966x-pci-objs		:= lan966x_pci.o
>  lan966x-pci-objs		+= lan966x_pci.dtbo.o
>  obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
>  obj-y				+= keba/
> +obj-$(CONFIG_SILEX_MPK)		+= silex_mpk.o
> diff --git a/drivers/misc/silex_mpk.c b/drivers/misc/silex_mpk.c
> new file mode 100644
> index 000000000000..e03579780761
> --- /dev/null
> +++ b/drivers/misc/silex_mpk.c
> @@ -0,0 +1,860 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018-2021 Silex Insight sa
> + * Copyright (c) 2018-2021 Beerten Engineering scs
> + * Copyright (c) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/version.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>

Drop, won't be needed.

> +#include <linux/of_platform.h>

Where do you use it?


> +#include <linux/of_address.h>

Where do you use it?

> +#include <linux/cdev.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/idr.h>
> +#include <linux/atomic.h>
> +#include <linux/delay.h>
> +#include <linux/eventfd.h>
> +#include <linux/kthread.h>
> +#include <linux/sched/signal.h>
> +#include <linux/bitops.h>
> +#include <uapi/linux/eventpoll.h>
> +#include <uapi/misc/silex_mpk.h>
> +
> +#include "silex_mpk_defs.h"


...

> +
> +static int multipk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct multipk_dev *mpkdev;
> +	struct resource *memres;
> +	int irq, ret;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret < 0)
> +		return ret;
> +
> +	mpkdev = devm_kzalloc(dev, sizeof(*mpkdev), GFP_KERNEL);
> +	if (!mpkdev)
> +		return -ENOMEM;
> +	mpkdev->dev = dev;
> +
> +	memres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mpkdev->regs = devm_ioremap_resource(dev, memres);

Use wrapper for both.


> +	if (IS_ERR(mpkdev->regs))
> +		return PTR_ERR(mpkdev->regs);
> +	mpkdev->regsphys = memres->start;
> +	memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	mpkdev->dbrg_regs = devm_ioremap_resource(dev, memres);

Use wrapper for both.


> +	if (IS_ERR(mpkdev->dbrg_regs))
> +		return PTR_ERR(mpkdev->dbrg_regs);
> +	mpkdev->dbrg_regsphys = memres->start;
> +	platform_set_drvdata(pdev, mpkdev);
> +
> +	/* Only a single IRQ is supported */
> +	if (platform_irq_count(pdev) != 1)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENODEV;
> +
> +	return multipk_create_device(mpkdev, dev, irq);
> +}
> +
> +static void multipk_remove(struct platform_device *pdev)
> +{
> +	struct multipk_dev *mpkdev = platform_get_drvdata(pdev);
> +
> +	multipk_remove_device(mpkdev);
> +}
> +
> +static const struct of_device_id multipk_match[] = {
> +	{ .compatible = "multipk" },

NAK, you do not have such compatible.

> +	{ },
> +};
> +
> +static struct platform_driver multipk_pdrv = {
> +	.probe = multipk_probe,
> +	.remove = multipk_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = of_match_ptr(multipk_match),

Drop of_match_ptr, you have warnings here.

> +	},
> +};
> +
> +static int __init multipk_init(void)
> +{
> +	dev_t devt;
> +	int ret;
> +
> +	multipk_class = class_create("multipk");
> +	if (IS_ERR(multipk_class)) {
> +		ret = PTR_ERR(multipk_class);
> +		pr_err("can't register class\n");
> +		goto err;
> +	}
> +	ret = alloc_chrdev_region(&devt, 0, MULTIPK_MAX_DEVICES, "multipk");
> +	if (ret) {
> +		pr_err("can't register character device\n");
> +		goto err_class;
> +	}
> +	multipk_major = MAJOR(devt);
> +	multipk_minor = MINOR(devt);
> +
> +	ret = platform_driver_register(&multipk_pdrv);
> +	if (ret) {
> +		pr_err("can't register platform driver\n");
> +		goto err_unchr;
> +	}
> +
> +	return 0;
> +err_unchr:
> +	unregister_chrdev_region(devt, MULTIPK_MAX_DEVICES);
> +err_class:
> +	class_destroy(multipk_class);
> +err:
> +	return ret;
> +}
> +
> +static void __exit multipk_exit(void)
> +{
> +	platform_driver_unregister(&multipk_pdrv);
> +
> +	unregister_chrdev_region(MKDEV(multipk_major, 0), MULTIPK_MAX_DEVICES);
> +
> +	class_destroy(multipk_class);
> +}
> +
> +module_init(multipk_init);
> +module_exit(multipk_exit);

I don't understand why loading a standard driver creates all this on my
device.

> +
> +MODULE_DESCRIPTION("Driver for Silex Multipk Asymmetric crypto accelerator");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
Drop

Best regards,
Krzysztof

