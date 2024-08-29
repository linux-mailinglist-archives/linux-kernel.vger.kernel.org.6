Return-Path: <linux-kernel+bounces-307397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20C964CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B241F21A77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A611B78F6;
	Thu, 29 Aug 2024 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+9B65ki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0FB1B5ECE;
	Thu, 29 Aug 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953203; cv=none; b=lVVs5ody9d48P1qf5lfT8C4eeYjpQAe1luy/gx2Cxj4Yhwk05k/GCQPfssPf/OGZdhHxyCqj4f/Zyz07DhJHncoI8Evzb/IGl9Z/2CMlCN1orfl0nV3C64zSOPT9nGKbADVZZN8/SEeNLbH2HOEo/mc22kkkpPjkA6sgexXiKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953203; c=relaxed/simple;
	bh=FJZdOA7Q0uPGc88oS6ZR10j6KaxkBtmgc09InDkmcIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+FpLIGSi+u2AwKtfdnX6/Vr5zlKEhhckw+fg96KUg/v4c2xEDtD4FhuXhT45fMdzobIilHGYf80aDMpQKecioSBIeUGdhwhVYYDerw+jNO83YLa3EJsccAWFUPFkXNg6Bhi7YcGMN4hN5tUemjqwpAobkRac9oFVmeWN7qVDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+9B65ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FD9C4CEC1;
	Thu, 29 Aug 2024 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953203;
	bh=FJZdOA7Q0uPGc88oS6ZR10j6KaxkBtmgc09InDkmcIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+9B65ki0D1IZzWGAGfVWOm/e2z7BGD3HPyL6kLl2jZ6bE18vDuZTbvrB0gojnnoc
	 w6TiDAtWYNv2ZmzHGyJxl8tBOY8JlCLFhEtVdX/I+OpYTI5UJ2VB7ms6qxwFNMrTXM
	 ouJCNK3XA/jBOyCeJ3LtGu5MIVHvxI999URnXH9VKCz3fjAMkfodm4rFhBX7Gf1Znf
	 UyCK2wrLlls4W5z5kUOkVz/XiSXsO4Jrg4SpC+1gqwQ1fOeWPd7+ZVZANdppG1mw0N
	 D0cmWLRdctG+AQsmK7tHz2Yyp6FMV5GLGirJwX7Itwqb9izrleggZSE8QyvfjsBHsM
	 ITqUNk/SC0MUg==
Date: Thu, 29 Aug 2024 23:09:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v4 2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
Message-ID: <ZtCyb7AzLmuUoBGT@vaman>
References: <20240828143452.1407532-1-christian.bruel@foss.st.com>
 <20240828143452.1407532-3-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828143452.1407532-3-christian.bruel@foss.st.com>

On 28-08-24, 16:34, Christian Bruel wrote:
> Addition of the COMBOPHY driver found on STM32MP25 platforms
> 
> This single lane PHY is shared (exclusive) between the USB3 and PCIE
> controllers.
> Supports 5Gbit/s for PCIE gen2 or 2.5Gbit/s for PCIE gen1.
> 
> Supports wakeup-source capability to wakeup system using remote-wakeup
> capable USB device
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/phy/st/Kconfig              |  11 +
>  drivers/phy/st/Makefile             |   1 +
>  drivers/phy/st/phy-stm32-combophy.c | 607 ++++++++++++++++++++++++++++
>  3 files changed, 619 insertions(+)
>  create mode 100644 drivers/phy/st/phy-stm32-combophy.c
> 
> diff --git a/drivers/phy/st/Kconfig b/drivers/phy/st/Kconfig
> index 3fc3d0781fb8..304614b6dabf 100644
> --- a/drivers/phy/st/Kconfig
> +++ b/drivers/phy/st/Kconfig
> @@ -33,6 +33,17 @@ config PHY_STIH407_USB
>  	  Enable this support to enable the picoPHY device used by USB2
>  	  and USB3 controllers on STMicroelectronics STiH407 SoC families.
>  
> +config PHY_STM32_COMBOPHY
> +	tristate "STMicroelectronics COMBOPHY driver for STM32MP25"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the COMBOPHY device used by USB3 or PCIe
> +	  controllers on STMicroelectronics STM32MP25 SoC.
> +	  This driver controls the COMBOPHY block to generate the PCIe 100Mhz
> +	  reference clock from either the external clock generator or HSE
> +	  internal SoC clock source.
> +
>  config PHY_STM32_USBPHYC
>  	tristate "STMicroelectronics STM32 USB HS PHY Controller driver"
>  	depends on ARCH_STM32 || COMPILE_TEST
> diff --git a/drivers/phy/st/Makefile b/drivers/phy/st/Makefile
> index c862dd937b64..cb80e954ea9f 100644
> --- a/drivers/phy/st/Makefile
> +++ b/drivers/phy/st/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_PHY_MIPHY28LP) 		+= phy-miphy28lp.o
>  obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
>  obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
>  obj-$(CONFIG_PHY_STIH407_USB)		+= phy-stih407-usb.o
> +obj-$(CONFIG_PHY_STM32_COMBOPHY)	+= phy-stm32-combophy.o
>  obj-$(CONFIG_PHY_STM32_USBPHYC) 	+= phy-stm32-usbphyc.o
> diff --git a/drivers/phy/st/phy-stm32-combophy.c b/drivers/phy/st/phy-stm32-combophy.c
> new file mode 100644
> index 000000000000..7cd4193b0277
> --- /dev/null
> +++ b/drivers/phy/st/phy-stm32-combophy.c
> @@ -0,0 +1,607 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics COMBOPHY STM32MP25 Controller driver.
> + *
> + * Copyright (C) 2024 STMicroelectronics
> + * Author: Christian Bruel <christian.bruel@foss.st.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define SYSCFG_COMBOPHY_CR1 0x4C00
> +#define SYSCFG_COMBOPHY_CR2 0x4C04
> +#define SYSCFG_COMBOPHY_CR4 0x4C0C
> +#define SYSCFG_COMBOPHY_CR5 0x4C10
> +#define SYSCFG_COMBOPHY_SR  0x4C14

Lowercase hex values please

> +#define SYSCFG_PCIEPRGCR    0x6080
> +
> +/* SYSCFG PCIEPRGCR */
> +#define STM32MP25_PCIEPRGCR_EN	  BIT(0)
> +#define STM32MP25_PCIEPRG_IMPCTRL_OHM     GENMASK(3, 1)
> +#define STM32MP25_PCIEPRG_IMPCTRL_VSWING  GENMASK(5, 4)
> +
> +/* SYSCFG SYSCFG_COMBOPHY_SR */
> +#define STM32MP25_PIPE0_PHYSTATUS BIT(1)
> +
> +/* SYSCFG CR1 */
> +#define SYSCFG_COMBOPHY_CR1_REFUSEPAD BIT(0)
> +#define SYSCFG_COMBOPHY_CR1_MPLLMULT GENMASK(7, 1)
> +#define SYSCFG_COMBOPHY_CR1_REFCLKSEL GENMASK(16, 8)
> +#define SYSCFG_COMBOPHY_CR1_REFCLKDIV2 BIT(17)
> +#define SYSCFG_COMBOPHY_CR1_REFSSPEN BIT(18)
> +#define SYSCFG_COMBOPHY_CR1_SSCEN BIT(19)
> +
> +/* SYSCFG CR4 */
> +#define SYSCFG_COMBOPHY_CR4_RX0_EQ GENMASK(2, 0)
> +
> +#define MPLLMULT_19_2 (0x02u << 1)
> +#define MPLLMULT_20   (0x7Du << 1)
> +#define MPLLMULT_24   (0x68u << 1)
> +#define MPLLMULT_25   (0x64u << 1)
> +#define MPLLMULT_26   (0x60u << 1)
> +#define MPLLMULT_38_4 (0x41u << 1)
> +#define MPLLMULT_48   (0x6Cu << 1)
> +#define MPLLMULT_50   (0x32u << 1)
> +#define MPLLMULT_52   (0x30u << 1)
> +#define MPLLMULT_100  (0x19u << 1)
> +
> +#define REFCLKSEL_0   0
> +#define REFCLKSEL_1   (0x108u << 8)
> +
> +#define REFCLDIV_0    0
> +
> +/* SYSCFG CR2 */
> +#define SYSCFG_COMBOPHY_CR2_MODESEL GENMASK(1, 0)
> +#define SYSCFG_COMBOPHY_CR2_ISO_DIS BIT(15)
> +
> +#define COMBOPHY_MODESEL_PCIE 0
> +#define COMBOPHY_MODESEL_USB  3
> +
> +/* SYSCFG CR5 */
> +#define SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS BIT(12)
> +
> +#define COMBOPHY_SUP_ANA_MPLL_LOOP_CTL 0xC0
> +#define COMBOPHY_PROP_CNTRL GENMASK(7, 4)
> +
> +struct stm32_combophy {
> +	struct phy *phy;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	void __iomem *base;
> +	struct reset_control *phy_reset;
> +	struct clk *phy_clk;
> +	struct clk *pad_clk;
> +	struct clk *ker_clk;
> +	unsigned int type;
> +	bool is_init;
> +	int irq_wakeup;
> +};
> +
> +struct clk_impedance  {
> +	u32 microohm;
> +	u32 vswing[4];
> +};
> +
> +/*
> + * lookup table to hold the settings needed for a ref clock frequency
> + * impedance, the offset is used to set the IMP_CTL and DE_EMP bit of the
> + * PRG_IMP_CTRL register
> + */
> +static const struct clk_impedance imp_lookup[] = {
> +	{ 6090000, { 442000, 564000, 684000, 802000 } },
> +	{ 5662000, { 528000, 621000, 712000, 803000 } },
> +	{ 5292000, { 491000, 596000, 700000, 802000 } },
> +	{ 4968000, { 558000, 640000, 722000, 803000 } },
> +	{ 4684000, { 468000, 581000, 692000, 802000 } },
> +	{ 4429000, { 554000, 613000, 717000, 803000 } },
> +	{ 4204000, { 511000, 609000, 706000, 802000 } },
> +	{ 3999000, { 571000, 648000, 726000, 803000 } }
> +};
> +
> +static int stm32_impedance_tune(struct stm32_combophy *combophy)
> +{
> +	u8 imp_size = ARRAY_SIZE(imp_lookup);
> +	u8 vswing_size = ARRAY_SIZE(imp_lookup[0].vswing);
> +	u8 imp_of, vswing_of;
> +	u32 max_imp = imp_lookup[0].microohm;
> +	u32 min_imp = imp_lookup[imp_size - 1].microohm;

table is ordered, pls mention that in comments somewhere

> +	u32 max_vswing = imp_lookup[imp_size - 1].vswing[vswing_size - 1];
> +	u32 min_vswing = imp_lookup[0].vswing[0];
> +	u32 val;
> +
> +	if (!of_property_read_u32(combophy->dev->of_node, "st,output-micro-ohms", &val)) {
> +		if (val < min_imp || val > max_imp) {
> +			dev_err(combophy->dev, "Invalid value %u for output ohm\n", val);
> +			return -EINVAL;
> +		}
> +
> +		for (imp_of = 0 ; imp_of < ARRAY_SIZE(imp_lookup); imp_of++)
> +			if (imp_lookup[imp_of].microohm <= val)
> +				break;
> +
> +		dev_dbg(combophy->dev, "Set %u micro-ohms output impedance\n",
> +			imp_lookup[imp_of].microohm);
> +
> +		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
> +				   STM32MP25_PCIEPRG_IMPCTRL_OHM,
> +				   FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_OHM, imp_of));
> +	} else {
> +		regmap_read(combophy->regmap, SYSCFG_PCIEPRGCR, &val);
> +		imp_of = FIELD_GET(STM32MP25_PCIEPRG_IMPCTRL_OHM, val);
> +	}
> +
> +	if (!of_property_read_u32(combophy->dev->of_node, "st,output-vswing-microvolt", &val)) {
> +		if (val < min_vswing || val > max_vswing) {
> +			dev_err(combophy->dev, "Invalid value %u for output vswing\n", val);
> +			return -EINVAL;
> +		}
> +
> +		for (vswing_of = 0 ; vswing_of < ARRAY_SIZE(imp_lookup[imp_of].vswing); vswing_of++)
> +			if (imp_lookup[imp_of].vswing[vswing_of] >= val)
> +				break;
> +
> +		dev_dbg(combophy->dev, "Set %u microvolt swing\n",
> +			 imp_lookup[imp_of].vswing[vswing_of]);
> +
> +		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
> +				   STM32MP25_PCIEPRG_IMPCTRL_VSWING,
> +				   FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_VSWING, vswing_of));
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_combophy_pll_init(struct stm32_combophy *combophy)
> +{
> +	int ret;
> +	u32 refclksel, pllmult, propcntrl, val;
> +	u32 clk_rate;
> +
> +	if (combophy->pad_clk)
> +		clk_rate = clk_get_rate(combophy->pad_clk);
> +	else
> +		clk_rate = clk_get_rate(combophy->ker_clk);
> +
> +	reset_control_assert(combophy->phy_reset);
> +
> +	dev_dbg(combophy->dev, "%s pll init rate %d\n",
> +		combophy->pad_clk ? "External" : "Ker", clk_rate);
> +
> +	/*
> +	 * vddcombophy is interconnected with vddcore. Isolation bit should be unset
> +	 * before using the ComboPHY.
> +	 */
> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
> +			   SYSCFG_COMBOPHY_CR2_ISO_DIS, SYSCFG_COMBOPHY_CR2_ISO_DIS);
> +
> +	if (combophy->type != PHY_TYPE_PCIE)
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +				   SYSCFG_COMBOPHY_CR1_REFSSPEN, SYSCFG_COMBOPHY_CR1_REFSSPEN);
> +
> +	if (combophy->type == PHY_TYPE_PCIE && !combophy->pad_clk)
> +		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
> +				   STM32MP25_PCIEPRGCR_EN, STM32MP25_PCIEPRGCR_EN);
> +
> +	if (of_property_read_bool(combophy->dev->of_node, "st,ssc-on")) {
> +		dev_dbg(combophy->dev, "Enabling clock with SSC\n");
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +				   SYSCFG_COMBOPHY_CR1_SSCEN, SYSCFG_COMBOPHY_CR1_SSCEN);
> +	}
> +
> +	if (!of_property_read_u32(combophy->dev->of_node, "st,rx-equalizer", &val)) {
> +		dev_dbg(combophy->dev, "Set RX equalizer %u\n", val);
> +		if (val > SYSCFG_COMBOPHY_CR4_RX0_EQ) {
> +			dev_err(combophy->dev, "Invalid value %u for rx0 equalizer\n", val);
> +			return -EINVAL;
> +		}
> +
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR4,
> +			   SYSCFG_COMBOPHY_CR4_RX0_EQ, val);
> +	}
> +
> +	if (combophy->type == PHY_TYPE_PCIE) {
> +		ret = stm32_impedance_tune(combophy);
> +		if (ret) {
> +			reset_control_deassert(combophy->phy_reset);
> +			goto out;
> +		}
> +
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +				   SYSCFG_COMBOPHY_CR1_REFUSEPAD,
> +				   combophy->pad_clk ? SYSCFG_COMBOPHY_CR1_REFUSEPAD : 0);
> +	}
> +
> +	switch (clk_rate) {
> +	case 100000000:
> +		pllmult = MPLLMULT_100;
> +		refclksel = REFCLKSEL_0;
> +		propcntrl = 0x8u << 4;
> +		break;
> +	case 19200000:
> +		pllmult = MPLLMULT_19_2;
> +		refclksel = REFCLKSEL_1;
> +		propcntrl = 0x8u << 4;
> +		break;
> +	case 25000000:
> +		pllmult = MPLLMULT_25;
> +		refclksel = REFCLKSEL_0;
> +		propcntrl = 0xEu << 4;
> +		break;
> +	case 24000000:
> +		pllmult = MPLLMULT_24;
> +		refclksel = REFCLKSEL_1;
> +		propcntrl = 0xEu << 4;
> +		break;
> +	case 20000000:
> +		pllmult = MPLLMULT_20;
> +		refclksel = REFCLKSEL_0;
> +		propcntrl = 0xEu << 4;
> +		break;
> +	default:
> +		dev_err(combophy->dev, "Invalid rate 0x%x\n", clk_rate);
> +		reset_control_deassert(combophy->phy_reset);
> +		ret = -EINVAL;
> +		goto out;
> +	};
> +
> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +			   SYSCFG_COMBOPHY_CR1_REFCLKDIV2, REFCLDIV_0);
> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +			   SYSCFG_COMBOPHY_CR1_REFCLKSEL, refclksel);
> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +			   SYSCFG_COMBOPHY_CR1_MPLLMULT, pllmult);
> +
> +	/*
> +	 * Force elasticity buffer to be tuned for the reference clock as
> +	 * the separated clock model is not supported
> +	 */
> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR5,
> +			   SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS, SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS);
> +
> +	reset_control_deassert(combophy->phy_reset);
> +
> +	ret = regmap_read_poll_timeout(combophy->regmap, SYSCFG_COMBOPHY_SR, val,
> +				       !(val & STM32MP25_PIPE0_PHYSTATUS),
> +				       10, 1000);
> +	if (ret) {
> +		dev_err(combophy->dev, "timeout, cannot lock PLL\n");
> +		goto out;
> +	}
> +
> +	if (combophy->type == PHY_TYPE_PCIE) {
> +		val = readl_relaxed(combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
> +		val &= ~COMBOPHY_PROP_CNTRL;
> +		val |= propcntrl;
> +		writel_relaxed(val, combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
> +	}
> +
> +	return 0;
> +
> +out:
> +	if (combophy->type == PHY_TYPE_PCIE && !combophy->pad_clk)
> +		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
> +				   STM32MP25_PCIEPRGCR_EN, 0);
> +
> +	if (combophy->type != PHY_TYPE_PCIE)
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +				   SYSCFG_COMBOPHY_CR1_REFSSPEN, 0);
> +
> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
> +			   SYSCFG_COMBOPHY_CR2_ISO_DIS, 0);
> +
> +	return ret;
> +}
> +
> +static struct phy *stm32_combophy_xlate(struct device *dev,
> +					const struct of_phandle_args *args)
> +{
> +	struct stm32_combophy *combophy = dev_get_drvdata(dev);
> +	unsigned int type;
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev, "invalid number of cells in 'phy' property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	type = args->args[0];
> +	if (type != PHY_TYPE_USB3 && type != PHY_TYPE_PCIE) {
> +		dev_err(dev, "unsupported device type: %d\n", type);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (combophy->pad_clk && type != PHY_TYPE_PCIE) {
> +		dev_err(dev, "Invalid use of clk_pad for USB3 mode\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	combophy->type = type;
> +
> +	return combophy->phy;
> +}
> +
> +static int stm32_combophy_set_mode(struct stm32_combophy *combophy)
> +{
> +	int type = combophy->type;
> +	u32 val;
> +
> +	switch (type) {
> +	case PHY_TYPE_PCIE:
> +		dev_dbg(combophy->dev, "setting PCIe ComboPHY\n");
> +		val = COMBOPHY_MODESEL_PCIE;
> +		break;
> +	case PHY_TYPE_USB3:
> +		dev_dbg(combophy->dev, "setting USB3 ComboPHY\n");
> +		val = COMBOPHY_MODESEL_USB;
> +		break;
> +	default:
> +		dev_err(combophy->dev, "Invalid PHY mode %d\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
> +				  SYSCFG_COMBOPHY_CR2_MODESEL, val);
> +}
> +
> +static int stm32_combophy_enable_clocks(struct stm32_combophy *combophy)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(combophy->phy_clk);
> +	if (ret) {
> +		dev_err(combophy->dev, "Core clock enable failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(combophy->ker_clk);
> +	if (ret) {
> +		dev_err(combophy->dev, "ker_usb3pcie clock enable failed %d\n", ret);
> +		clk_disable_unprepare(combophy->phy_clk);
> +		return ret;
> +	}
> +
> +	if (combophy->pad_clk) {
> +		ret = clk_prepare_enable(combophy->pad_clk);
> +		if (ret) {
> +			dev_err(combophy->dev, "External clock enable failed %d\n", ret);
> +			clk_disable_unprepare(combophy->ker_clk);
> +			clk_disable_unprepare(combophy->phy_clk);
> +			return ret;
> +		}
> +	}

Can you use bulk_prepare for this?

-- 
~Vinod

