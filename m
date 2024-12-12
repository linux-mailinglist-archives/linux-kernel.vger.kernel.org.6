Return-Path: <linux-kernel+bounces-442947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198569EE473
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC328282E43
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB821146F;
	Thu, 12 Dec 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IC5T7/rA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3631F2381;
	Thu, 12 Dec 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000388; cv=none; b=U00uY0XVfSYZAwhoctJh9L8XaBRl01rn/mLih9BtRa91Qy7A3h6F2dQ5oQK/HZEYO1RnTJ9eJPoI0osuxgqHY+MOiwFomu0PbW73AirMb2KQPYt/9YP4kiWM7g8Zl6tRMD4FxlHQCZ7IN4Gmel0yUBmE/JY602VyAJUq2iVtwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000388; c=relaxed/simple;
	bh=EeTQ0XJQcKIXk/QpK2b+bNdt51NhWlYIcFlc3AheHmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSaObgb3TlX/93dXdIQvLh+UjwXnSkNGPku3C00MrIuHlxdWhwOQkXgSi8RdxF9lXmm9Nz94gr4h0eYwbHSAn3t8pr0PLAN7y39Orq2a9ZT8cyxG0Lb1R52xC9N0QzrFTmUoMxHZLaeeDRKk0Ih3BJzKXgLYuEL+gLShp47nZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IC5T7/rA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734000382;
	bh=EeTQ0XJQcKIXk/QpK2b+bNdt51NhWlYIcFlc3AheHmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IC5T7/rAATOOMzQR8aRMTnJRxqSPfjBE7EmOAMxbdDOozaGmOCLqfDLIwG+ldJB0d
	 KFJMABHndpM3m6syy2UbmAiLs6ugv/VYlYpvXNfLswf5250J4fhBLc0uyon/7dUtNo
	 V+BL1NviHpgx8yLFbu/Yec0LQ6jXepNG3w7/J/hnxMww+qlVEswOwcL/j+1wuvFTMQ
	 04GeRDOpw/c0uynpNZ38nd//IOi7ZZmuT/ZoBQC+gtikmUcP7rT98VgADJoqGpHCX/
	 1K2cXWwMmnHGLGJ3em+VmnkrMOjkaeqv18X50F8s4nNrEXhSk1zeSLk6rJAItFn12U
	 Dwvc5f8tSeHFA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3084C17E360E;
	Thu, 12 Dec 2024 11:46:22 +0100 (CET)
Message-ID: <f1515081-14f3-4cde-9c9a-16390b8d3891@collabora.com>
Date: Thu, 12 Dec 2024 11:46:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory/mediatek: Add an interface to get current DDR
 data rate
To: Crystal Guo <crystal.guo@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241212090029.13692-1-crystal.guo@mediatek.com>
 <20241212090029.13692-2-crystal.guo@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241212090029.13692-2-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/12/24 09:59, Crystal Guo ha scritto:
> Add MediaTek DRAMC driver to provide an interface that can
> obtain current DDR data rate.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>   drivers/memory/Kconfig                 |   1 +
>   drivers/memory/Makefile                |   1 +
>   drivers/memory/mediatek/Kconfig        |  21 ++
>   drivers/memory/mediatek/Makefile       |   2 +
>   drivers/memory/mediatek/mtk-dramc.c    | 325 +++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-dramc.h |  41 ++++
>   6 files changed, 391 insertions(+)
>   create mode 100644 drivers/memory/mediatek/Kconfig
>   create mode 100644 drivers/memory/mediatek/Makefile
>   create mode 100644 drivers/memory/mediatek/mtk-dramc.c
>   create mode 100644 include/linux/soc/mediatek/mtk-dramc.h
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index c82d8d8a16ea..b1698549ff81 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -227,5 +227,6 @@ config STM32_FMC2_EBI
>   
>   source "drivers/memory/samsung/Kconfig"
>   source "drivers/memory/tegra/Kconfig"
> +source "drivers/memory/mediatek/Kconfig"
>   
>   endif
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index d2e6ca9abbe0..cf1091449d2e 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
>   
>   obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
>   obj-$(CONFIG_TEGRA_MC)		+= tegra/
> +obj-$(CONFIG_HAVE_MTK_MC)	+= mediatek/
>   obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
>   obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
>   
> diff --git a/drivers/memory/mediatek/Kconfig b/drivers/memory/mediatek/Kconfig
> new file mode 100644
> index 000000000000..00764cdb157e
> --- /dev/null
> +++ b/drivers/memory/mediatek/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HAVE_MTK_MC
> +	bool "MediaTek Memory Controller support"
> +	help
> +	  This option allows to enable MediaTek memory controller drivers,
> +	  which may include controllers for DRAM or others.
> +	  Select Y here if you need support for MediaTek memory controller.
> +	  If you don't need, select N.
> +
> +if HAVE_MTK_MC
> +
> +config MTK_DRAMC
> +	tristate "MediaTek DRAMC driver"
> +	depends on HAVE_MTK_MC
> +	help
> +	  This option selects the MediaTek DRAMC driver, which provides
> +	  an interface for reporting the current data rate of DRAM.
> +	  Select Y here if you need support for the MediaTek DRAMC driver.
> +	  If you don't need, select N.
> +
> +endif
> diff --git a/drivers/memory/mediatek/Makefile b/drivers/memory/mediatek/Makefile
> new file mode 100644
> index 000000000000..a1395fc55b41
> --- /dev/null
> +++ b/drivers/memory/mediatek/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_MTK_DRAMC)		+= mtk-dramc.o
> diff --git a/drivers/memory/mediatek/mtk-dramc.c b/drivers/memory/mediatek/mtk-dramc.c
> new file mode 100644
> index 000000000000..9c2c8e187a4a
> --- /dev/null
> +++ b/drivers/memory/mediatek/mtk-dramc.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 MediaTek Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/printk.h>
> +#include <linux/io.h>
> +#include <linux/soc/mediatek/mtk-dramc.h>
> +
> +static struct platform_device *dramc_pdev;
> +static struct platform_driver dramc_drv;

You don't need these globals.

> +
> +static int fmeter_init(struct platform_device *pdev,
> +		       struct fmeter_dev_t *fmeter_dev_ptr, unsigned int fmeter_version)
> +{
> +	struct device_node *dramc_node = pdev->dev.of_node;
> +	int ret;
> +
> +	ret = of_property_read_u32(dramc_node,
> +				   "crystal-freq", &(fmeter_dev_ptr->crystal_freq));
> +	ret |= of_property_read_u32(dramc_node,
> +				    "shu-of", &(fmeter_dev_ptr->shu_of));

ret |= x doesn't make sense.

ret = ...
if (ret)
	return ret;

> +	ret |= of_property_read_u32_array(dramc_node,
> +					  "shu-lv", (unsigned int *)&(fmeter_dev_ptr->shu_lv), 3);
> +	ret |= of_property_read_u32_array(dramc_node,
> +					  "pll-id", (unsigned int *)&(fmeter_dev_ptr->pll_id), 3);
> +	ret |= of_property_read_u32_array(dramc_node,
> +					  "sdmpcw", (unsigned int *)(fmeter_dev_ptr->sdmpcw), 6);
> +	ret |= of_property_read_u32_array(dramc_node,
> +					  "posdiv", (unsigned int *)(fmeter_dev_ptr->posdiv), 6);
> +	ret |= of_property_read_u32_array(dramc_node,
> +					  "fbksel", (unsigned int *)(fmeter_dev_ptr->fbksel), 6);
> +	ret |= of_property_read_u32_array(dramc_node,
> +					  "dqsopen", (unsigned int *)(fmeter_dev_ptr->dqsopen), 6);
> +	if (fmeter_version == 1) {
> +		fmeter_dev_ptr->version = 1;
> +		ret |= of_property_read_u32_array(dramc_node,
> +			"async-ca", (unsigned int *)(fmeter_dev_ptr->async_ca), 6);
> +		ret |= of_property_read_u32_array(dramc_node,
> +			"dq-ser-mode", (unsigned int *)(fmeter_dev_ptr->dq_ser_mode), 6);
> +	}
> +	return ret;
> +}
> +
> +static ssize_t dram_data_rate_show(struct device_driver *driver, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "DRAM data rate = %d\n",
> +		mtk_dramc_get_data_rate());
> +}
> +
> +static DRIVER_ATTR_RO(dram_data_rate);> +
> +static int dramc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *dramc_node = pdev->dev.of_node;
> +	struct dramc_dev_t *dramc_dev_ptr;
> +	unsigned int fmeter_version;
> +	struct resource *res;
> +	unsigned int i, size;
> +	int ret;
> +
> +	pr_info("%s: module probe.\n", __func__);

This pr_info makes no sense. Please remove.

> +	dramc_pdev = pdev;
> +	dramc_dev_ptr = devm_kmalloc(&pdev->dev,
> +				     sizeof(struct dramc_dev_t), GFP_KERNEL);
> +
> +	if (!dramc_dev_ptr)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32(dramc_node,
> +				   "support-ch-cnt", &dramc_dev_ptr->support_ch_cnt);
> +	if (ret) {
> +		pr_info("%s: get support_ch_cnt fail\n", __func__);

that's an error, and you want dev_err_probe().

> +		return -EINVAL;
> +	}
> +
> +	dramc_dev_ptr->sleep_base = of_iomap(dramc_node,
> +					     dramc_dev_ptr->support_ch_cnt * 4);
> +	if (IS_ERR(dramc_dev_ptr->sleep_base)) {
> +		pr_info("%s: unable to map sleep base\n", __func__);

same, here and everywhere else

> +		return -EINVAL;
> +	}
> +
> +	size = sizeof(phys_addr_t) * dramc_dev_ptr->support_ch_cnt;
> +	dramc_dev_ptr->dramc_chn_base_ao = devm_kmalloc(&pdev->dev,
> +							size, GFP_KERNEL);
> +	if (!(dramc_dev_ptr->dramc_chn_base_ao))
> +		return -ENOMEM;
> +	dramc_dev_ptr->dramc_chn_base_nao = devm_kmalloc(&pdev->dev,
> +							 size, GFP_KERNEL);
> +	if (!(dramc_dev_ptr->dramc_chn_base_nao))
> +		return -ENOMEM;
> +	dramc_dev_ptr->ddrphy_chn_base_ao = devm_kmalloc(&pdev->dev,
> +							 size, GFP_KERNEL);
> +	if (!(dramc_dev_ptr->ddrphy_chn_base_ao))
> +		return -ENOMEM;
> +	dramc_dev_ptr->ddrphy_chn_base_nao = devm_kmalloc(&pdev->dev,
> +							  size, GFP_KERNEL);
> +	if (!(dramc_dev_ptr->ddrphy_chn_base_nao))
> +		return -ENOMEM;
> +
> +	for (i = 0; i < dramc_dev_ptr->support_ch_cnt; i++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		dramc_dev_ptr->dramc_chn_base_ao[i] =
> +			devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(dramc_dev_ptr->dramc_chn_base_ao[i])) {
> +			pr_info("%s: unable to map ch%d DRAMC AO base\n",
> +				__func__, i);
> +			return -EINVAL;
> +		}
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM,
> +					    i + dramc_dev_ptr->support_ch_cnt);
> +		dramc_dev_ptr->dramc_chn_base_nao[i] =
> +			devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(dramc_dev_ptr->dramc_chn_base_nao[i])) {
> +			pr_info("%s: unable to map ch%d DRAMC NAO base\n",
> +				__func__, i);
> +			return -EINVAL;
> +		}
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM,
> +					    i + dramc_dev_ptr->support_ch_cnt * 2);
> +		dramc_dev_ptr->ddrphy_chn_base_ao[i] =
> +			devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(dramc_dev_ptr->ddrphy_chn_base_ao[i])) {
> +			pr_info("%s: unable to map ch%d DDRPHY AO base\n",
> +				__func__, i);
> +			return -EINVAL;
> +		}
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM,
> +					    i + dramc_dev_ptr->support_ch_cnt * 3);
> +		dramc_dev_ptr->ddrphy_chn_base_nao[i] =
> +			devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(dramc_dev_ptr->ddrphy_chn_base_nao[i])) {
> +			pr_info("%s: unable to map ch%d DDRPHY NAO base\n",
> +				__func__, i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ret = of_property_read_u32(dramc_node, "fmeter-version", &fmeter_version);

This is something for platform data, not devicetree.

> +	if (ret) {
> +		pr_info("%s: get fmeter_version fail\n", __func__);
> +		return -EINVAL;
> +	}
> +	pr_info("%s: fmeter_version(%d)\n", __func__, fmeter_version);
> +
> +	if (fmeter_version == 1) {
> +		dramc_dev_ptr->fmeter_dev_ptr = devm_kmalloc(&pdev->dev,
> +							     sizeof(struct fmeter_dev_t),
> +							     GFP_KERNEL);
> +		if (!(dramc_dev_ptr->fmeter_dev_ptr)) {
> +			pr_info("%s: memory  alloc fail\n", __func__);
> +			return -ENOMEM;
> +		}
> +		ret = fmeter_init(pdev, dramc_dev_ptr->fmeter_dev_ptr, fmeter_version);
> +		if (ret) {
> +			pr_info("%s: fmeter_init fail\n", __func__);
> +			return -EINVAL;
> +		}
> +	} else {
> +		dramc_dev_ptr->fmeter_dev_ptr = NULL;
> +	}
> +	ret = driver_create_file(pdev->dev.driver, &driver_attr_dram_data_rate);
> +	if (ret) {
> +		pr_info("%s: fail to create dram_data_rate sysfs\n", __func__);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, dramc_dev_ptr);
> +	pr_info("%s: DRAM data rate = %d\n", __func__,
> +		mtk_dramc_get_data_rate());
> +
> +	return ret;
> +}
> +
> +static unsigned int fmeter_v1(struct dramc_dev_t *dramc_dev_ptr)
> +{
> +	struct fmeter_dev_t *fmeter_dev_ptr =
> +		(struct fmeter_dev_t *)dramc_dev_ptr->fmeter_dev_ptr;
> +	unsigned int shu_lv_val;
> +	unsigned int pll_id_val;
> +	unsigned int sdmpcw_val;
> +	unsigned int posdiv_val;
> +	unsigned int ckdiv4_val;
> +	unsigned int offset;
> +	unsigned int vco_freq;
> +	unsigned int fbksel;
> +	unsigned int dqsopen;
> +	unsigned int async_ca;
> +	unsigned int dq_ser_mode;
> +
> +	shu_lv_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] +
> +		fmeter_dev_ptr->shu_lv.offset) &
> +		fmeter_dev_ptr->shu_lv.mask) >>
> +		fmeter_dev_ptr->shu_lv.shift;
> +
> +	pll_id_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] +
> +		fmeter_dev_ptr->pll_id.offset) &
> +		fmeter_dev_ptr->pll_id.mask) >>
> +		fmeter_dev_ptr->pll_id.shift;
> +
> +	offset = fmeter_dev_ptr->sdmpcw[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	sdmpcw_val = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->sdmpcw[pll_id_val].mask) >>
> +		fmeter_dev_ptr->sdmpcw[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->posdiv[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	posdiv_val = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->posdiv[pll_id_val].mask) >>
> +		fmeter_dev_ptr->posdiv[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->fbksel[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	fbksel = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->fbksel[pll_id_val].mask) >>
> +		fmeter_dev_ptr->fbksel[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->dqsopen[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	dqsopen = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->dqsopen[pll_id_val].mask) >>
> +		fmeter_dev_ptr->dqsopen[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->async_ca[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	async_ca = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->async_ca[pll_id_val].mask) >>
> +		fmeter_dev_ptr->async_ca[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->dq_ser_mode[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	dq_ser_mode = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->dq_ser_mode[pll_id_val].mask) >>
> +		fmeter_dev_ptr->dq_ser_mode[pll_id_val].shift;
> +	ckdiv4_val = (dq_ser_mode == 1); // 1: DIV4, 2: DIV8, 3: DIV16
> +
> +	posdiv_val &= ~(0x4);
> +
> +	vco_freq = ((fmeter_dev_ptr->crystal_freq) *
> +		(sdmpcw_val >> 7)) >> posdiv_val >> 1 >> ckdiv4_val
> +		<< fbksel;

That vco_freq calculation is seriously unreadable :\

> +
> +	if ((dqsopen == 1) && (async_ca == 1))
> +		vco_freq >>= 1;
> +
> +	return vco_freq;
> +}
> +
> +/*
> + * mtk_dramc_get_data_rate - calculate DRAM data rate
> + *
> + * Returns DRAM data rate (MB/s)
> + */
> +unsigned int mtk_dramc_get_data_rate(void)
> +{
> +	struct dramc_dev_t *dramc_dev_ptr;
> +	struct fmeter_dev_t *fmeter_dev_ptr;
> +
> +	if (!dramc_pdev)
> +		return 0;
> +
> +	dramc_dev_ptr =
> +		(struct dramc_dev_t *)platform_get_drvdata(dramc_pdev);
> +
> +	fmeter_dev_ptr = (struct fmeter_dev_t *)dramc_dev_ptr->fmeter_dev_ptr;
> +	if (!fmeter_dev_ptr)
> +		return 0;
> +
> +	if (fmeter_dev_ptr->version == 1)
> +		return fmeter_v1(dramc_dev_ptr);
> +	return 0;
> +}
> +EXPORT_SYMBOL(mtk_dramc_get_data_rate);

Not sure about mtk_dramc_get_data_rate().

Please show an example of how you're actually using it in the external driver,
as there are many ways to expose this value.

> +
> +static int dramc_remove(struct platform_device *pdev)
> +{
> +	dramc_pdev = NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dramc_of_ids[] = {
> +	{.compatible = "mediatek,common-dramc",},

{ .compatible = "mediatek,something" },
{ /* sentinel */ }

> +	{}
> +};
> +
> +static struct platform_driver dramc_drv = {
> +	.probe = dramc_probe,
> +	.remove = dramc_remove,
> +	.driver = {
> +		.name = "dramc_drv",
> +		.owner = THIS_MODULE,
> +		.of_match_table = dramc_of_ids,
> +	},
> +};

module_platform_driver(...)

> +
> +static int __init dramc_drv_init(void)

...so that function is not needed.

> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&dramc_drv);
> +	if (ret) {
> +		pr_info("%s: init fail, ret 0x%x\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +module_init(dramc_drv_init);
> +
> +MODULE_AUTHOR("Mediatek Corporation");

MODULE_AUTHOR("Author Name <your.email@mediatek.com>");

> +MODULE_DESCRIPTION("MediaTek DRAMC Driver");

MODULE_DESCRIPTION("MediaTek DRAM Controller driver");



...and I have a hunch that this series will need many versions before the code
quality bar reaches a nice level...

Cheers,
Angelo

> +MODULE_LICENSE("GPL");

