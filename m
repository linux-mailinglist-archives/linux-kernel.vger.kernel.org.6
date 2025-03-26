Return-Path: <linux-kernel+bounces-576826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFED9A714D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1784F189F1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1301B6CEF;
	Wed, 26 Mar 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hOqU4YT9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74E191461;
	Wed, 26 Mar 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984883; cv=none; b=G0QvYvj8nXzy0n3XtD1rL27gG21Sh0fMNkNMgyFhaDEkrRnBKsXUFnhke6TS5gGwF6SYw/IwyozEqfX/3UsA7Sg7DgnWTAuq9z0fzY2iMthw9m2k9UB3o2SIHkMDdtaSOMwSXgnXj3EgTkYbR8iUjKDsgRWoGhX+EJL4+LAQquA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984883; c=relaxed/simple;
	bh=MFDYnf2694t0mOYmpFojXv+RprLkigHE2Y2+IoiSk8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QamYYuNPKBfNQ5dWjGgNTXVjfTSt7F2leEqrq6Mq/WG+XGRoXoRhs+4K65YOYkfFc1OjmvJVkR6McMia8Mp7ZXFpPmU9fBPEnf6EUwnnwMtO38RfbU2hAjbIKLtWX6T9jttm8XYpj6sRqNGUInL18KpTjAx3fgk9RmsZYtwUngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hOqU4YT9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984879;
	bh=MFDYnf2694t0mOYmpFojXv+RprLkigHE2Y2+IoiSk8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hOqU4YT9l49LT0T+Cc9TGLCB/JBe8J7DN9KcaYt4NT11gj2I3PFz3zdtgHeYaOte7
	 m1yyyFNm18Gnf2b8eDzXmy34K88EUKw14a8VDPMyMvyBukjQs5SBL3aV+esBKW/A5M
	 gshy1Mk3Pl0MNsDvONAds7p0n57tigyjck1Vpw/+YkrXiRnZfcFla297XV6CPhc7x6
	 yHRrNOocUTGVvwHinchNnjMeT8dGJyOcMEM8fK1ie8OkSvRyrGOj3D45dqOWI8ElEN
	 bRrOhPvTWJL77uQAnVDKayqEim/7fmUjwXSDUvQh3cDtIo/f2SH3xbxmi6sr5lunro
	 RhGCsWjEq0T/Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B02D217E0B9D;
	Wed, 26 Mar 2025 11:27:58 +0100 (CET)
Message-ID: <ae533d2e-49ed-4be1-89de-a55b21f4d30c@collabora.com>
Date: Wed, 26 Mar 2025 11:27:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3,2/2] memory/mediatek: Add an interface to get current DDR
 data rate
To: Crystal Guo <crystal.guo@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250326063041.7126-1-crystal.guo@mediatek.com>
 <20250326063041.7126-3-crystal.guo@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250326063041.7126-3-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/03/25 07:30, Crystal Guo ha scritto:
> Add MediaTek DRAMC driver to provide an interface that can
> obtain current DDR data rate.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>   drivers/memory/Kconfig              |   1 +
>   drivers/memory/Makefile             |   1 +
>   drivers/memory/mediatek/Kconfig     |  21 +++
>   drivers/memory/mediatek/Makefile    |   2 +
>   drivers/memory/mediatek/mtk-dramc.c | 232 ++++++++++++++++++++++++++++
>   5 files changed, 257 insertions(+)
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

default y
depends on ARCH_MEDIATEK || COMPILE_TEST

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

           This driver is for the DRAM Controller found in MediaTek SoCs
           and provides a sysfs interface for reporting the current DRAM
           data rate.

The part saying select y or n can be avoided.

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
> index 000000000000..22042c9d8e42
> --- /dev/null
> +++ b/drivers/memory/mediatek/mtk-dramc.c
> @@ -0,0 +1,232 @@
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
> +static unsigned int read_reg_field(void __iomem *base, unsigned int offset, unsigned int mask)

Please move this function to before mtk_dramc_probe()

> +{
> +	unsigned int val = readl(base + offset);
> +	unsigned int shift = __ffs(mask);
> +
> +	return (val & mask) >> shift;
> +}
> +
> +struct mtk_dramc_pdata {
> +	u8 fmeter_version;
> +	u8 ref_freq_mhz;
> +	const u16 *regs;
> +	const u32 *masks;
> +	u32 posdiv_purify;
> +	u8 prediv;
> +	u16 shuffle_offset;
> +};
> +
> +struct mtk_dramc_dev_t {

That may be confused with a typedef so, please, just "struct mtk_dramc"

> +	void __iomem *anaphy_base;
> +	void __iomem *ddrphy_base;
> +	const struct mtk_dramc_pdata *pdata;
> +};
> +
> +enum mtk_dramc_reg_index {
> +	DRAMC_DPHY_DVFS_STA,
> +	DRAMC_APHY_SHU_PHYPLL2,
> +	DRAMC_APHY_SHU_CLRPLL2,
> +	DRAMC_APHY_SHU_PHYPLL3,
> +	DRAMC_APHY_SHU_CLRPLL3,
> +	DRAMC_APHY_SHU_PHYPLL4,
> +	DRAMC_APHY_ARPI0,
> +	DRAMC_APHY_CA_ARDLL1,
> +	DRAMC_APHY_B0_TX0,
> +};
> +
> +enum mtk_dramc_mask_index {
> +	DRAMC_DPHY_DVFS_SHU_LV,
> +	DRAMC_DPHY_DVFS_PLL_SEL,
> +	DRAMC_APHY_PLL2_SDMPCW,
> +	DRAMC_APHY_PLL3_POSDIV,
> +	DRAMC_APHY_PLL4_FBKSEL,
> +	DRAMC_APHY_ARPI0_SOPEN,
> +	DRAMC_APHY_ARDLL1_CK_EN,
> +	DRAMC_APHY_B0_TX0_SER_MODE,
> +};
> +
> +static const u16 mtk_dramc_regs_mt8196[] = {
> +	[DRAMC_DPHY_DVFS_STA] = 0xe98,
> +	[DRAMC_APHY_SHU_PHYPLL2] = 0x908,
> +	[DRAMC_APHY_SHU_CLRPLL2] = 0x928,
> +	[DRAMC_APHY_SHU_PHYPLL3] = 0x90c,
> +	[DRAMC_APHY_SHU_CLRPLL3] = 0x92c,
> +	[DRAMC_APHY_SHU_PHYPLL4] = 0x910,
> +	[DRAMC_APHY_ARPI0] = 0x0d94,
> +	[DRAMC_APHY_CA_ARDLL1] = 0x0d08,
> +	[DRAMC_APHY_B0_TX0] = 0x0dc4,
> +};
> +
> +static const u32 mtk_dramc_masks_mt8196[] = {
> +	[DRAMC_DPHY_DVFS_SHU_LV] = GENMASK(15, 14),
> +	[DRAMC_DPHY_DVFS_PLL_SEL] = GENMASK(25, 25),
> +	[DRAMC_APHY_PLL2_SDMPCW] = GENMASK(18, 3),
> +	[DRAMC_APHY_PLL3_POSDIV] = GENMASK(13, 11),
> +	[DRAMC_APHY_PLL4_FBKSEL] = GENMASK(6, 6),
> +	[DRAMC_APHY_ARPI0_SOPEN] = GENMASK(26, 26),
> +	[DRAMC_APHY_ARDLL1_CK_EN] = GENMASK(0, 0),
> +	[DRAMC_APHY_B0_TX0_SER_MODE] = GENMASK(4, 3),
> +};
> +

function read_reg_field goes here.

> +static int mtk_dramc_probe(struct platform_device *pdev)
> +{
> +	struct mtk_dramc_dev_t *dramc;
> +	const struct mtk_dramc_pdata *pdata;
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
> +	if (IS_ERR(dramc->anaphy_base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dramc->anaphy_base),
> +				     "Unable to map ANAPHY base\n");
> +
> +	dramc->ddrphy_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(dramc->ddrphy_base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dramc->ddrphy_base),
> +				     "Unable to map DDRPHY base\n");
> +
> +	platform_set_drvdata(pdev, dramc);
> +	return 0;
> +}
> +
> +static unsigned int mtk_fmeter_v1(struct mtk_dramc_dev_t *dramc)
> +{
> +	const struct mtk_dramc_pdata *pdata = dramc->pdata;
> +	unsigned int shu_level, pll_sel, offset;
> +	unsigned int sdmpcw, posdiv, clkdiv, fbksel, sopen, async_ca, ser_mode;
> +	unsigned int prediv_freq, posdiv_freq, vco_freq;
> +	unsigned int final_rate;
> +
> +	shu_level = read_reg_field(dramc->ddrphy_base, pdata->regs[DRAMC_DPHY_DVFS_STA],
> +				   pdata->masks[DRAMC_DPHY_DVFS_SHU_LV]);
> +	pll_sel = read_reg_field(dramc->ddrphy_base, pdata->regs[DRAMC_DPHY_DVFS_STA],
> +				 pdata->masks[DRAMC_DPHY_DVFS_PLL_SEL]);
> +	offset = pdata->shuffle_offset * shu_level;
> +
> +	sdmpcw = read_reg_field(dramc->anaphy_base,
> +				((pll_sel == 0) ?
> +				pdata->regs[DRAMC_APHY_SHU_PHYPLL2] :
> +				pdata->regs[DRAMC_APHY_SHU_CLRPLL2]) + offset,
> +				pdata->masks[DRAMC_APHY_PLL2_SDMPCW]);
> +	posdiv = read_reg_field(dramc->anaphy_base,
> +				((pll_sel == 0) ?
> +				pdata->regs[DRAMC_APHY_SHU_PHYPLL3] :
> +				pdata->regs[DRAMC_APHY_SHU_CLRPLL3]) + offset,
> +				pdata->masks[DRAMC_APHY_PLL3_POSDIV]);
> +	fbksel = read_reg_field(dramc->anaphy_base, pdata->regs[DRAMC_APHY_SHU_PHYPLL4] + offset,
> +				pdata->masks[DRAMC_APHY_PLL4_FBKSEL]);
> +	sopen = read_reg_field(dramc->anaphy_base, pdata->regs[DRAMC_APHY_ARPI0] + offset,
> +			       pdata->masks[DRAMC_APHY_ARPI0_SOPEN]);
> +	async_ca = read_reg_field(dramc->anaphy_base, pdata->regs[DRAMC_APHY_CA_ARDLL1] + offset,
> +				  pdata->masks[DRAMC_APHY_ARDLL1_CK_EN]);
> +	ser_mode = read_reg_field(dramc->anaphy_base, pdata->regs[DRAMC_APHY_B0_TX0] + offset,
> +				  pdata->masks[DRAMC_APHY_B0_TX0_SER_MODE]);
> +
> +	clkdiv = (ser_mode == 1) ? 1 : 0;
> +	posdiv &= ~(pdata->posdiv_purify);
> +
> +	prediv_freq = pdata->ref_freq_mhz * (sdmpcw >> pdata->prediv);
> +	posdiv_freq = (prediv_freq >> posdiv) >> 1;
> +	vco_freq = posdiv_freq << fbksel;
> +	final_rate = vco_freq >> clkdiv;
> +
> +	if (sopen == 1 && async_ca == 1)
> +		final_rate >>= 1;
> +
> +	return final_rate;
> +}
> +
> +/*

You're so near to kerneldoc that you might just as well use it.

/**
  * mtk_dramc_get_data_rate - Calculate DRAM data rate
  * @dev - Device pointer
  *
  * Return: DRAM Data Rate in MB/s or negative number for error
  */

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

That can't happen, because you're assigning drvdata in the probe function

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

That also can't happen.

> +	return -EINVAL;
> +}

/**
  * mtk_dramc_get_data_rate - Calculate DRAM data rate
  * @dev - Device pointer
  *
  * Return: DRAM Data Rate in MB/s or negative number for error
  */
static unsigned int mtk_dramc_get_data_rate(struct device *dev)
{
	struct mtk_dramc *dramc = dev_get_drvdata(dev);

	if (dramc_dev->pdata->fmeter_version == 1)
		return mtk_fmeter_v1(dramc_dev);

	dev_err(dev, "Frequency meter version %u not supported\n");
	return -EINVAL;
};

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
> +	.fmeter_version = 1,
> +	.ref_freq_mhz = 26,
> +	.regs = mtk_dramc_regs_mt8196,
> +	.masks = mtk_dramc_masks_mt8196,
> +	.posdiv_purify = BIT(2),
> +	.prediv = 7,
> +	.shuffle_offset = 0x700,
> +};
> +
> +static const struct of_device_id mtk_dramc_of_ids[] = {
> +	{ .compatible = "mediatek,mt8196-dramc", .data = &dramc_pdata_mt8196 },
> +	{}

{ /* sentinel */ }

> +};
> +MODULE_DEVICE_TABLE(of, mtk_dramc_of_ids);
> +
> +static struct platform_driver mtk_dramc_driver = {
> +	.probe = mtk_dramc_probe,
> +	.driver = {
> +		.name = "mtk_dramc_drv",

.name = "mtk-dramc"

> +		.of_match_table = mtk_dramc_of_ids,
> +		.dev_groups = mtk_dramc_groups,
> +	},
> +};
> +

No blank line here:

};
module_platform_driver(....)

I think that v4 will be the final version :-)

Cheers,
Angelo

> +module_platform_driver(mtk_dramc_driver);
> +
> +MODULE_AUTHOR("Crystal Guo <crystal.guo@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek DRAM Controller Driver");
> +MODULE_LICENSE("GPL");



