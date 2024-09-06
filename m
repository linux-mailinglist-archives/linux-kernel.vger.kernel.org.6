Return-Path: <linux-kernel+bounces-318957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561FB96F5A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E1280EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA41CEADE;
	Fri,  6 Sep 2024 13:44:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AC1C9ED8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630278; cv=none; b=SAqL8zKS5Qcv99WFk5sJJ2vhFfN+8s6aqQaL6O7o0U4KtKwNwSfW0V5W8/O5mOLd+1fBlvzDqu0f+2e2mKDI97WlEJvVmJ1SGDtUga/j7tmg/NqavdPiXMZoOCmqwLSKR9fb1v48U0BegdF0Q5wqVjGDTAY9zqzwwXkHCBU9Pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630278; c=relaxed/simple;
	bh=bEYbfq9XMxPFEaHmk9LBWdxqgWrs/nVavRNPiqBb1+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gqllWbm33j77gVAsF5keXwzGma+1RIEPog2DbnFTZ3BhGlS4K3NIt8tJaaymdVvW1WI7xtg8jTjtFj9pAo3xo1zNqOS/B5XQkyrOCo3nuHMN3NaO6wVt5jAJFNeO2z3L0kchJXRS28aduGG5l9s3NCInVGGbAttAeUv1cGbcvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smZFt-0000Lh-1c; Fri, 06 Sep 2024 15:44:05 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smZFq-005xU3-5T; Fri, 06 Sep 2024 15:44:02 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smZFq-0009UL-0F;
	Fri, 06 Sep 2024 15:44:02 +0200
Message-ID: <d743de28a5dd643cf775f4d8a3baaabd09d48c48.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Christian Bruel <christian.bruel@foss.st.com>, vkoul@kernel.org, 
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org,  mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 fabrice.gasnier@foss.st.com
Date: Fri, 06 Sep 2024 15:44:01 +0200
In-Reply-To: <20240903121303.2953150-3-christian.bruel@foss.st.com>
References: <20240903121303.2953150-1-christian.bruel@foss.st.com>
	 <20240903121303.2953150-3-christian.bruel@foss.st.com>
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

Hi,

On Di, 2024-09-03 at 14:13 +0200, Christian Bruel wrote:
> Addition of the COMBOPHY driver found on STM32MP25 platforms
>=20
> This single lane PHY is shared (exclusive) between the USB3 and PCIE
> controllers.
> Supports 5Gbit/s for PCIE gen2 or 2.5Gbit/s for PCIE gen1.
>=20
> Supports wakeup-source capability to wakeup system using remote-wakeup
> capable USB device
>=20
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/phy/st/Kconfig              |  11 +
>  drivers/phy/st/Makefile             |   1 +
>  drivers/phy/st/phy-stm32-combophy.c | 590 ++++++++++++++++++++++++++++
>  3 files changed, 602 insertions(+)
>  create mode 100644 drivers/phy/st/phy-stm32-combophy.c
>=20
[...]
> diff --git a/drivers/phy/st/phy-stm32-combophy.c b/drivers/phy/st/phy-stm=
32-combophy.c
> new file mode 100644
> index 000000000000..305ba124d092
> --- /dev/null
> +++ b/drivers/phy/st/phy-stm32-combophy.c
> @@ -0,0 +1,590 @@
[...]
> +static int stm32_combophy_pll_init(struct stm32_combophy *combophy)
> +{
> +	int ret;
> +	u32 refclksel, pllmult, propcntrl, val;
> +	u32 clk_rate;
> +	struct clk *clk;
> +
> +	if (combophy->have_pad_clk)
> +		clk =3D combophy->clks[PAD_CLK].clk;
> +	else
> +		clk =3D combophy->clks[KER_CLK].clk;
> +
> +	clk_rate =3D clk_get_rate(clk);
> +
> +	reset_control_assert(combophy->phy_reset);
> +
> +	dev_dbg(combophy->dev, "%s pll init rate %d\n",
> +		combophy->have_pad_clk ? "External" : "Ker", clk_rate);
> +
> +	/*
> +	 * vddcombophy is interconnected with vddcore. Isolation bit should be =
unset
> +	 * before using the ComboPHY.
> +	 */
> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
> +			   SYSCFG_COMBOPHY_CR2_ISO_DIS, SYSCFG_COMBOPHY_CR2_ISO_DIS);
> +
> +	if (combophy->type !=3D PHY_TYPE_PCIE)
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +				   SYSCFG_COMBOPHY_CR1_REFSSPEN, SYSCFG_COMBOPHY_CR1_REFSSPEN);

Could the multiple accesses to SYSCFG_COMBOPHY_CR1 be consolidated into
a single regmap_update_bits()?

> +
> +	if (combophy->type =3D=3D PHY_TYPE_PCIE && !combophy->have_pad_clk)
> +		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
> +				   STM32MP25_PCIEPRGCR_EN, STM32MP25_PCIEPRGCR_EN);
> +
> +	if (of_property_present(combophy->dev->of_node, "st,ssc-on")) {
> +		dev_dbg(combophy->dev, "Enabling clock with SSC\n");
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +				   SYSCFG_COMBOPHY_CR1_SSCEN, SYSCFG_COMBOPHY_CR1_SSCEN);
> +	}
> +
> +	if (!of_property_read_u32(combophy->dev->of_node, "st,rx-equalizer", &v=
al)) {
> +		dev_dbg(combophy->dev, "Set RX equalizer %u\n", val);
> +		if (val > SYSCFG_COMBOPHY_CR4_RX0_EQ) {
> +			dev_err(combophy->dev, "Invalid value %u for rx0 equalizer\n", val);

This path looks like it should deassert the phy_reset as well.

> +			return -EINVAL;
> +		}
> +
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR4,
> +			   SYSCFG_COMBOPHY_CR4_RX0_EQ, val);
> +	}
> +
> +	if (combophy->type =3D=3D PHY_TYPE_PCIE) {
> +		ret =3D stm32_impedance_tune(combophy);
> +		if (ret) {
> +			reset_control_deassert(combophy->phy_reset);
> +			goto out;
> +		}
> +
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +				   SYSCFG_COMBOPHY_CR1_REFUSEPAD,
> +				   combophy->have_pad_clk ? SYSCFG_COMBOPHY_CR1_REFUSEPAD : 0);
> +	}
> +
> +	switch (clk_rate) {
> +	case 100000000:
> +		pllmult =3D MPLLMULT_100;
> +		refclksel =3D REFCLKSEL_0;
> +		propcntrl =3D 0x8u << 4;
> +		break;
> +	case 19200000:
> +		pllmult =3D MPLLMULT_19_2;
> +		refclksel =3D REFCLKSEL_1;
> +		propcntrl =3D 0x8u << 4;
> +		break;
> +	case 25000000:
> +		pllmult =3D MPLLMULT_25;
> +		refclksel =3D REFCLKSEL_0;
> +		propcntrl =3D 0xeu << 4;
> +		break;
> +	case 24000000:
> +		pllmult =3D MPLLMULT_24;
> +		refclksel =3D REFCLKSEL_1;
> +		propcntrl =3D 0xeu << 4;
> +		break;
> +	case 20000000:
> +		pllmult =3D MPLLMULT_20;
> +		refclksel =3D REFCLKSEL_0;
> +		propcntrl =3D 0xeu << 4;
> +		break;
> +	default:
> +		dev_err(combophy->dev, "Invalid rate 0x%x\n", clk_rate);
> +		reset_control_deassert(combophy->phy_reset);
> +		ret =3D -EINVAL;
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
> +			   SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS, SYSCFG_COMBOPHY_CR5_COMMON_CLOC=
KS);
> +
> +	reset_control_deassert(combophy->phy_reset);
> +
> +	ret =3D regmap_read_poll_timeout(combophy->regmap, SYSCFG_COMBOPHY_SR, =
val,
> +				       !(val & STM32MP25_PIPE0_PHYSTATUS),
> +				       10, 1000);
> +	if (ret) {
> +		dev_err(combophy->dev, "timeout, cannot lock PLL\n");
> +		goto out;
> +	}
> +
> +	if (combophy->type =3D=3D PHY_TYPE_PCIE) {
> +		val =3D readl_relaxed(combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL)=
;
> +		val &=3D ~COMBOPHY_PROP_CNTRL;
> +		val |=3D propcntrl;
> +		writel_relaxed(val, combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
> +	}
> +
> +	return 0;
> +
> +out:
> +	if (combophy->type =3D=3D PHY_TYPE_PCIE && !combophy->have_pad_clk)
> +		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
> +				   STM32MP25_PCIEPRGCR_EN, 0);
> +
> +	if (combophy->type !=3D PHY_TYPE_PCIE)
> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
> +				   SYSCFG_COMBOPHY_CR1_REFSSPEN, 0);
> +
> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
> +			   SYSCFG_COMBOPHY_CR2_ISO_DIS, 0);
> +
> +	return ret;
> +}
> +
[...]
> +
> +static int stm32_combophy_probe(struct platform_device *pdev)
> +{
> +	struct stm32_combophy *combophy;
> +	struct device *dev =3D &pdev->dev;
> +	struct phy_provider *phy_provider;
> +	int ret, irq;
> +
> +	combophy =3D devm_kzalloc(dev, sizeof(*combophy), GFP_KERNEL);
> +	if (!combophy)
> +		return -ENOMEM;
> +
> +	combophy->dev =3D dev;
> +
> +	dev_set_drvdata(dev, combophy);
> +
> +	combophy->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(combophy->base))
> +		return PTR_ERR(combophy->base);
> +
> +	if (stm32_combophy_get_clocks(combophy))
> +		return ret;
> +
> +	combophy->phy_reset =3D devm_reset_control_get(dev, "phy");

Please use devm_reset_control_get_exclusive() directly.

regards
Philipp

