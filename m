Return-Path: <linux-kernel+bounces-544554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEADA4E259
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37A67AC73F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FAE25DB16;
	Tue,  4 Mar 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BAOf+Mdm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50603265637;
	Tue,  4 Mar 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100375; cv=none; b=ifIWSmAPzLI4/HMtcDqgMb5IfRZx/vltRbExAw93ojYyCZmYf6o1IALGVp+/qiqDfK15SI0xeXnxlK+2+nixQ139zwrAlGOSTjJ1ZdKOcZ08+f9HaOY+FX6onqRctKaIG3Q1eRuiRUXh6puXlB07KxqKvEIcsmaQQd8v2j+kku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100375; c=relaxed/simple;
	bh=9HyvFC1aYme/RE3vNGSw0sgKg28mD1z9kYUKkFIiyxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hkw/gOgFFZRKjvWnn3VXNRWN7cHtTtsA431qz4QToMA/WjWx4wPUqORF+fry4FKMhL176tToynImwN4XDrAjVPqfdm41dByv8hMDcjnGQ48DCdXrBT/hBFYqAGrd5MGFUVHhUHBTguOMPr4vXw9rGbzrWM1Q+KMP1FOx4/sZRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BAOf+Mdm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741100371;
	bh=9HyvFC1aYme/RE3vNGSw0sgKg28mD1z9kYUKkFIiyxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BAOf+MdmjNQkuO6XVmZbYvjFtPzDoVUkHmJ1ScRZt5kzyXivP8i9Zp34UBSUCVJfy
	 lCr2algJccz8KqhxZub5KBIPIOtHFOPEKGJuvDB/GmYeZFfPuWcQ5AU73hNIngyWEW
	 9uHvEr3MshsNsWznMkgi9/VFJ37wdP4MLuY//CImaB2yyD1sM+/GFOiTfDEWpZdWAw
	 +5I0nwCU4vlGjY2pJSNwu5wWL/KAjc8zlDCg0FqbU1ZSkxhh0jszO9tAkv71DJ41wr
	 knC/SRFiaQT/d5YGvgO3xDyVsyz5P7oOpFP0r4SMGSKiuHtmIgGsS++PwvukBKRlGJ
	 aah2Yh6fcfKNw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A37B17E0A4E;
	Tue,  4 Mar 2025 15:59:30 +0100 (CET)
Message-ID: <10163a0b-5865-4088-b38b-6c5680548fc4@collabora.com>
Date: Tue, 4 Mar 2025 15:59:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,1/2] memory/mediatek: Add an interface to get current DDR
 data rate
To: Crystal Guo <crystal.guo@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 kernel test robot <lkp@intel.com>
References: <20250207014437.17920-1-crystal.guo@mediatek.com>
 <20250207014437.17920-2-crystal.guo@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250207014437.17920-2-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/02/25 02:42, Crystal Guo ha scritto:
> Add MediaTek DRAMC driver to provide an interface that can
> obtain current DDR data rate.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412210955.FvO0Pee3-lkp@intel.
> com/
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>   drivers/memory/Kconfig              |   1 +
>   drivers/memory/Makefile             |   1 +
>   drivers/memory/mediatek/Kconfig     |  21 +++
>   drivers/memory/mediatek/Makefile    |   2 +
>   drivers/memory/mediatek/mtk-dramc.c | 196 ++++++++++++++++++++++++++++
>   5 files changed, 221 insertions(+)
>   create mode 100644 drivers/memory/mediatek/Kconfig
>   create mode 100644 drivers/memory/mediatek/Makefile
>   create mode 100644 drivers/memory/mediatek/mtk-dramc.c
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
> index d2e6ca9abbe0..c0facf529803 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
>   
>   obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
>   obj-$(CONFIG_TEGRA_MC)		+= tegra/
> +obj-$(CONFIG_MEDIATEK_MC)	+= mediatek/
>   obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
>   obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
>   
> diff --git a/drivers/memory/mediatek/Kconfig b/drivers/memory/mediatek/Kconfig
> new file mode 100644
> index 000000000000..3f238e0d9647
> --- /dev/null
> +++ b/drivers/memory/mediatek/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config MEDIATEK_MC
> +	bool "MediaTek Memory Controller support"
> +	help
> +	  This option allows to enable MediaTek memory controller drivers,
> +	  which may include controllers for DRAM or others.
> +	  Select Y here if you need support for MediaTek memory controller.
> +	  If you don't need, select N.
> +
> +if MEDIATEK_MC
> +
> +config MTK_DRAMC
> +	tristate "MediaTek DRAMC driver"
> +	default y
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
> index 000000000000..d452483a98ce
> --- /dev/null
> +++ b/drivers/memory/mediatek/mtk-dramc.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + */
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +
> +#define POSDIV_PURIFY	BIT(2)
> +#define PREDIV		7
> +#define REF_FREQUENCY	26

REF_FREQUENCY should be platform data, not a definition, as this is
different in other SoCs.

> +#define SHUFFLE_OFFSET	0x700
> +
> +/*--------------------------------------------------------------------------*/
> +/* Register Offset                                                          */
> +/*--------------------------------------------------------------------------*/
> +#define DPHY_DVFS_STA		0x0e98
> +#define APHY_PHYPLL2		0x0908
> +#define APHY_CLRPLL2		0x0928
> +#define APHY_PHYPLL3		0x090c
> +#define APHY_CLRPLL3		0x092c
> +#define APHY_PHYPLL4		0x0910
> +#define APHY_ARPI0		0x0d94
> +#define APHY_CA_ARDLL1		0x0d08
> +#define APHY_B0_TX0		0x0dc4

Aren't those also SoC-dependant?

enum mtk_dramc_reg_index {
	DRAMC_DPHY_DVFS_STA,
	DRAMC_APHY_SHU_PHYPLL2,
	....etc
}

static const u16 mtk_dramc_regs_mt8195[] = {
	[DRAMC_DPHY_DVFS_STA] = 0x50c, /* ddrphy_config_NAO */
	[DRAMC_APHY_SHU_PHYPLL2] = 0x704,
	[DRAMC_APHY_SHU_CLRPLL2] = 0x724,
	[DRAMC_APHY_SHU_PHYPLL3] = 0x708,
	[DRAMC_APHY_SHU_CLRPLL3] = 0x728,
	[DRAMC_APHY_SHU_PHYPLL4] = 0x70c,
	...etc
}

static const u16 mtk_dramc_regs_mt8196[] = {
	[DRAMC_DPHY_DVFS_STA] = 0xe98, /* ddrphy_config_misc */
	[DRAMC_APHY_SHU_PHYPLL2] = 0x908,
	[DRAMC_APHY_SHU_CLRPLL2] = 0x928,
	.... etc
}

> +
> +/*--------------------------------------------------------------------------*/
> +/* Register Mask                                                            */
> +/*--------------------------------------------------------------------------*/
> +#define DPHY_DVFS_SHU_LV	GENMASK(15, 14)
> +#define DPHY_DVFS_PLL_SEL	GENMASK(25, 25)
> +#define APHY_PLL2_SDMPCW	GENMASK(18, 3)
> +#define APHY_PLL3_POSDIV	GENMASK(13, 11)
> +#define APHY_PLL4_FBKSEL	GENMASK(6, 6)
> +#define APHY_ARPI0_SOPEN	GENMASK(26, 26)
> +#define APHY_ARDLL1_CK_EN	GENMASK(0, 0)
> +#define APHY_B0_TX0_SER_MODE	GENMASK(4, 3)

And those masks should also be platform data, as those are also different
in other SoCs.

> +
> +static unsigned int read_reg_field(void __iomem *base, unsigned int offset, unsigned int mask)
> +{
> +	unsigned int val = readl(base + offset);
> +	unsigned int shift = __ffs(mask);
> +
> +	return (val & mask) >> shift;
> +}
> +
> +struct mtk_dramc_pdata {
> +	unsigned int fmeter_version;

u8 fmeter_version;
u8 ref_freq_mhz;
const u16 *regs;

...etc etc


> +};
> +
> +struct mtk_dramc_dev_t {
> +	void __iomem *anaphy_base;
> +	void __iomem *ddrphy_base;
> +	const struct mtk_dramc_pdata *pdata;
> +};
> +
> +static int mtk_dramc_probe(struct platform_device *pdev)
> +{
> +	struct mtk_dramc_dev_t *dramc;
> +	const struct mtk_dramc_pdata *pdata;
> +	int ret;
> +
> +	dramc = devm_kzalloc(&pdev->dev, sizeof(struct mtk_dramc_dev_t), GFP_KERNEL);
> +	if (!dramc)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allocate memory\n");
> +
> +	pdata = of_device_get_match_data(&pdev->dev);
> +	if (!pdata)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "No platform data available\n");
> +
> +	dramc->pdata = pdata;
> +
> +	dramc->anaphy_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dramc->anaphy_base)) {
> +		ret = PTR_ERR(dramc->anaphy_base);
> +		return dev_err_probe(&pdev->dev, ret, "Unable to map DDRPHY NAO base\n");
> +	}
> +
> +	dramc->ddrphy_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(dramc->ddrphy_base)) {
> +		ret = PTR_ERR(dramc->ddrphy_base);
> +		return dev_err_probe(&pdev->dev, ret, "Unable to map DDRPHY AO base\n");
> +	}
> +
> +	platform_set_drvdata(pdev, dramc);
> +	return 0;
> +}
> +
> +static unsigned int mtk_fmeter_v1(struct mtk_dramc_dev_t *dramc)
> +{
> +	unsigned int shu_level, pll_sel, offset;
> +	unsigned int sdmpcw, posdiv, ckdiv4, fbksel, sopen, async_ca, ser_mode;
> +	unsigned int perdiv_freq, posdiv_freq, vco_freq;
> +	unsigned int final_rate;
> +
> +	shu_level = read_reg_field(dramc->ddrphy_base, DPHY_DVFS_STA, DPHY_DVFS_SHU_LV);
> +	pll_sel = read_reg_field(dramc->ddrphy_base, DPHY_DVFS_STA, DPHY_DVFS_PLL_SEL);
> +	offset = SHUFFLE_OFFSET * shu_level;
> +
> +	sdmpcw = read_reg_field(dramc->anaphy_base,
> +				((pll_sel == 0) ? APHY_PHYPLL2 : APHY_CLRPLL2) + offset,
> +				APHY_PLL2_SDMPCW);
> +	posdiv = read_reg_field(dramc->anaphy_base,
> +				((pll_sel == 0) ? APHY_PHYPLL3 : APHY_CLRPLL3) + offset,
> +				APHY_PLL3_POSDIV);
> +	fbksel = read_reg_field(dramc->anaphy_base, APHY_PHYPLL4 + offset, APHY_PLL4_FBKSEL);
> +	sopen = read_reg_field(dramc->anaphy_base, APHY_ARPI0 + offset, APHY_ARPI0_SOPEN);
> +	async_ca = read_reg_field(dramc->anaphy_base, APHY_CA_ARDLL1 + offset, APHY_ARDLL1_CK_EN);
> +	ser_mode = read_reg_field(dramc->anaphy_base, APHY_B0_TX0 + offset, APHY_B0_TX0_SER_MODE);
> +
> +	ckdiv4 = (ser_mode == 1) ? 1 : 0;
> +	posdiv &= ~(POSDIV_PURIFY);
> +
> +	perdiv_freq = REF_FREQUENCY * (sdmpcw >> PREDIV);

s/perdiv/prediv/g

> +	posdiv_freq = (perdiv_freq >> posdiv) >> 1;
> +	vco_freq = posdiv_freq << fbksel;
> +	final_rate = vco_freq >> ckdiv4;
> +

there's also one case in which `final_rate >>= 2`... please check if it is
applicable to this driver (it should).

Cheers,
Angelo

> +	if (sopen == 1 && async_ca == 1)
> +		final_rate >>= 1;
> +
> +	return final_rate;
> +}
> +
> +/*
> + * mtk_dramc_get_data_rate - calculate DRAM data rate
> + *
> + * Returns DRAM data rate (MB/s)
> + */
> +static unsigned int mtk_dramc_get_data_rate(struct device *dev)
> +{
> +	struct mtk_dramc_dev_t *dramc_dev = dev_get_drvdata(dev);
> +
> +	if (!dramc_dev) {
> +		dev_err(dev, "DRAMC device data not found\n");
> +		return -EINVAL;
> +	}
> +
> +	if (dramc_dev->pdata) {
> +		if (dramc_dev->pdata->fmeter_version == 1)
> +			return mtk_fmeter_v1(dramc_dev);
> +
> +		dev_err(dev, "Unsupported fmeter version\n");
> +		return -EINVAL;
> +	}
> +	dev_err(dev, "DRAMC platform data not found\n");
> +	return -EINVAL;
> +}
> +
> +static ssize_t dram_data_rate_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "DRAM data rate = %u\n",
> +			mtk_dramc_get_data_rate(dev));
> +}
> +
> +static DEVICE_ATTR_RO(dram_data_rate);
> +
> +static struct attribute *mtk_dramc_attrs[] = {
> +	&dev_attr_dram_data_rate.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(mtk_dramc);
> +
> +static const struct mtk_dramc_pdata dramc_pdata_mt8196 = {
> +	.fmeter_version = 1
> +};
> +
> +static const struct of_device_id mtk_dramc_of_ids[] = {
> +	{ .compatible = "mediatek,mt8196-dramc", .data = &dramc_pdata_mt8196 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mtk_dramc_of_ids);
> +
> +static struct platform_driver mtk_dramc_driver = {
> +	.probe = mtk_dramc_probe,
> +	.driver = {
> +		.name = "mtk_dramc_drv",
> +		.of_match_table = mtk_dramc_of_ids,
> +		.dev_groups = mtk_dramc_groups,
> +	},
> +};
> +
> +module_platform_driver(mtk_dramc_driver);
> +
> +MODULE_AUTHOR("Crystal Guo <crystal.guo@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek DRAM Controller Driver");
> +MODULE_LICENSE("GPL");


