Return-Path: <linux-kernel+bounces-538612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC42A49AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D88E174601
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B21E26E622;
	Fri, 28 Feb 2025 13:46:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705026B96A;
	Fri, 28 Feb 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750384; cv=none; b=OMBH53sbwBppkLkCQXpyQTU5Fjlf6dpmYXjvp7kdzOV9GQ7p/YS72zqIVIu3NP8TIav/40340e8+w0HmT50i9gTZ6kTYRKY458GukxcZ51l8rlQVBFW42nmGPLeOkS0qoJ8Frf7br+vy7vwlchG71BVWwD+aNa0J8fVw0KCwqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750384; c=relaxed/simple;
	bh=YtJUCOc+ZGXBpETPvzm2P3hkvCYavZ3axDuCJsbctHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBYvBtxFayGgJJUt2JgKlyelAPYElcolR+etmT3BhUxeBLhgfg8HIXMMaOPbyvfJD92SlQO4au6o8m4B1JbT0zo21SU5hoCpVHLyfr3Ki3LjCicJnyTXflGgYitVNq2vsUr9NBKWBz7eXlbhr/wBE2C2USyvDLJmUazC0i1PIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96C931515;
	Fri, 28 Feb 2025 05:46:37 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9627F3F5A1;
	Fri, 28 Feb 2025 05:46:20 -0800 (PST)
Date: Fri, 28 Feb 2025 13:46:18 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/15] clk: sunxi-ng: a523: add interface mod clocks
Message-ID: <20250228134618.71644cda@donnerap.manchester.arm.com>
In-Reply-To: <2641802.Lt9SDvczpP@jernej-laptop>
References: <20250214125359.5204-1-andre.przywara@arm.com>
	<20250214125359.5204-10-andre.przywara@arm.com>
	<2641802.Lt9SDvczpP@jernej-laptop>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 20:42:48 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

many thanks for staying on this and digging into the details!

> Dne petek, 14. februar 2025 ob 13:53:53 Srednjeevropski standardni =C4=8D=
as je Andre Przywara napisal(a):
> > Add the clocks driving what the user manual summarises under "interface"
> > devices: raw NAND flash, MMC, SPI, EMAC, "IR" infrared, and the "GPADC"
> > general purpose analogue/digital converter.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 160 +++++++++++++++++++++++++
> >  1 file changed, 160 insertions(+)
> >=20
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi=
-ng/ccu-sun55i-a523.c
> > index b68c44bce825f..14d13fb16dfbb 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > @@ -113,6 +113,9 @@ static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "=
pll-periph0-150M",
> >  			    pll_periph0_2x_hws, 8, 1, 0);
> >  static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
> >  			    pll_periph0_480M_hws, 3, 1, 0);
> > +static const struct clk_hw *pll_periph0_150M_hws[] =3D {
> > +	&pll_periph0_150M_clk.hw
> > +};
> > =20
> >  #define SUN55I_A523_PLL_PERIPH1_REG	0x028
> >  static struct ccu_nm pll_periph1_4x_clk =3D {
> > @@ -537,6 +540,133 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dram_clk, "dr=
am", dram_parents, 0x800,
> >  static CLK_FIXED_FACTOR_HW(mbus_clk, "mbus",
> >  			   &dram_clk.common.hw, 4, 1, 0);
> > =20
> > +static const struct clk_parent_data nand_mmc_parents[] =3D {
> > +	{ .fw_name =3D "hosc" },
> > +	{ .hw =3D &pll_periph0_400M_clk.hw },
> > +	{ .hw =3D &pll_periph0_300M_clk.hw },
> > +	{ .hw =3D &pll_periph1_400M_clk.hw },
> > +	{ .hw =3D &pll_periph1_300M_clk.hw },
> > +};
> > +
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand0_clk, "nand0", nand_mmc_par=
ents,
> > +				    0x810,
> > +				    0, 5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0);
> > +
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand1_clk, "nand1", nand_mmc_par=
ents,
> > +				    0x814,
> > +				    0, 5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0);
> > +
> > +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc0_clk, "mmc0", nand_mmc_p=
arents,
> > +					   0x830,
> > +					   0, 5,	/* M */
> > +					   8, 5,	/* P */
> > +					   24, 3,	/* mux */
> > +					   BIT(31),	/* gate */
> > +					   2,		/* post div */
> > +					   0, CCU_FEATURE_DUAL_DIV);
> > +
> > +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc1_clk, "mmc1", nand_mmc_p=
arents,
> > +					   0x834,
> > +					   0, 5,	/* M */
> > +					   8, 5,	/* P */
> > +					   24, 3,	/* mux */
> > +					   BIT(31),	/* gate */
> > +					   2,		/* post div */
> > +					   0, CCU_FEATURE_DUAL_DIV);
> > +
> > +static const struct clk_parent_data mmc2_parents[] =3D {
> > +	{ .fw_name =3D "hosc" },
> > +	{ .hw =3D &pll_periph0_800M_clk.common.hw },
> > +	{ .hw =3D &pll_periph0_600M_clk.hw },
> > +	{ .hw =3D &pll_periph1_800M_clk.common.hw },
> > +	{ .hw =3D &pll_periph1_600M_clk.hw },
> > +};
> > +
> > +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc2_clk, "mmc2", mmc2_paren=
ts,
> > +					   0x838,
> > +					   0, 5,	/* M */
> > +					   8, 5,	/* P */
> > +					   24, 3,	/* mux */
> > +					   BIT(31),	/* gate */
> > +					   2,		/* post div */
> > +					   0, CCU_FEATURE_DUAL_DIV);
> > +
> > +static const struct clk_parent_data spi_parents[] =3D {
> > +	{ .fw_name =3D "hosc" },
> > +	{ .hw =3D &pll_periph0_300M_clk.hw },
> > +	{ .hw =3D &pll_periph0_200M_clk.hw },
> > +	{ .hw =3D &pll_periph1_300M_clk.hw },
> > +	{ .hw =3D &pll_periph1_200M_clk.hw },
> > +};
> > +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi0_clk, "spi0", spi_parents, =
0x940,
> > +				       0, 5,	/* M */
> > +				       8, 5,	/* P */
> > +				       24, 3,	/* mux */
> > +				       BIT(31),	/* gate */
> > +				       0);
> > +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi1_clk, "spi1", spi_parents, =
0x944,
> > +				       0, 5,	/* M */
> > +				       8, 5,	/* P */
> > +				       24, 3,	/* mux */
> > +				       BIT(31),	/* gate */
> > +				       0);
> > +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi2_clk, "spi2", spi_parents, =
0x948,
> > +				       0, 5,	/* M */
> > +				       8, 5,	/* P */
> > +				       24, 3,	/* mux */
> > +				       BIT(31),	/* gate */
> > +				       0);
> > +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spifc_clk, "spifc", nand_mmc_pa=
rents,
> > +				       0x950,
> > +				       0, 5,	/* M */
> > +				       8, 5,	/* P */
> > +				       24, 3,	/* mux */
> > +				       BIT(31),	/* gate */
> > +				       0); =20
>=20
> Missing CCU_FEATURE_DUAL_DIV flag.

Oh, indeed, for all SPI clocks, nice catch!  I introduced a new macro
for this type of clocks now: SUNXI_CCU_DUALDIV_MUX_GATE.

Cheers,
Andre

> Best regards,
> Jernej
>=20
> > +
> > +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac0_25M_clk, "emac0-25M",
> > +				      pll_periph0_150M_hws,
> > +				      0x970, BIT(31) | BIT(30), 6, 0);
> > +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac1_25M_clk, "emac1-25M",
> > +				      pll_periph0_150M_hws,
> > +				      0x974, BIT(31) | BIT(30), 6, 0);
> > +
> > +static const struct clk_parent_data ir_rx_parents[] =3D {
> > +	{ .fw_name =3D "losc" },
> > +	{ .fw_name =3D "hosc" },
> > +};
> > +
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_rx_clk, "ir-rx", ir_rx_parent=
s, 0x990,
> > +				      0, 5,	/* M */
> > +				      24, 1,	/* mux */
> > +				      BIT(31),	/* gate */
> > +				      0);
> > +static const struct clk_parent_data ir_tx_ledc_parents[] =3D {
> > +	{ .fw_name =3D "hosc" },
> > +	{ .hw =3D &pll_periph1_600M_clk.hw },
> > +};
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_tx_clk, "ir-tx", ir_tx_ledc_p=
arents,
> > +				      0x9c0,
> > +				      0, 5,	/* M */
> > +				      24, 1,	/* mux */
> > +				      BIT(31),	/* gate */
> > +				      0);
> > +
> > +static SUNXI_CCU_M_WITH_GATE(gpadc0_clk, "gpadc0", "hosc", 0x9e0,
> > +				 0, 5,		/* M */
> > +				 BIT(31),	/* gate */
> > +				 0);
> > +static SUNXI_CCU_M_WITH_GATE(gpadc1_clk, "gpadc1", "hosc", 0x9e4,
> > +				 0, 5,		/* M */
> > +				 BIT(31),	/* gate */
> > +				 0);
> > +
> >  static const struct clk_parent_data losc_hosc_parents[] =3D {
> >  	{ .fw_name =3D "hosc" },
> >  	{ .fw_name =3D "losc" },
> > @@ -693,6 +823,21 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =
=3D {
> >  	&hstimer5_clk.common,
> >  	&iommu_clk.common,
> >  	&dram_clk.common,
> > +	&nand0_clk.common,
> > +	&nand1_clk.common,
> > +	&mmc0_clk.common,
> > +	&mmc1_clk.common,
> > +	&mmc2_clk.common,
> > +	&spi0_clk.common,
> > +	&spi1_clk.common,
> > +	&spi2_clk.common,
> > +	&spifc_clk.common,
> > +	&emac0_25M_clk.common,
> > +	&emac1_25M_clk.common,
> > +	&ir_rx_clk.common,
> > +	&ir_tx_clk.common,
> > +	&gpadc0_clk.common,
> > +	&gpadc1_clk.common,
> >  	&pcie_aux_clk.common,
> >  	&hdmi_24M_clk.common,
> >  	&hdmi_cec_32k_clk.common,
> > @@ -767,6 +912,21 @@ static struct clk_hw_onecell_data sun55i_a523_hw_c=
lks =3D {
> >  		[CLK_HSTIMER5]		=3D &hstimer5_clk.common.hw,
> >  		[CLK_IOMMU]		=3D &iommu_clk.common.hw,
> >  		[CLK_DRAM]		=3D &dram_clk.common.hw,
> > +		[CLK_NAND0]		=3D &nand0_clk.common.hw,
> > +		[CLK_NAND1]		=3D &nand1_clk.common.hw,
> > +		[CLK_MMC0]		=3D &mmc0_clk.common.hw,
> > +		[CLK_MMC1]		=3D &mmc1_clk.common.hw,
> > +		[CLK_MMC2]		=3D &mmc2_clk.common.hw,
> > +		[CLK_SPI0]		=3D &spi0_clk.common.hw,
> > +		[CLK_SPI1]		=3D &spi1_clk.common.hw,
> > +		[CLK_SPI2]		=3D &spi2_clk.common.hw,
> > +		[CLK_SPIFC]		=3D &spifc_clk.common.hw,
> > +		[CLK_EMAC0_25M]		=3D &emac0_25M_clk.common.hw,
> > +		[CLK_EMAC1_25M]		=3D &emac1_25M_clk.common.hw,
> > +		[CLK_IR_RX]		=3D &ir_rx_clk.common.hw,
> > +		[CLK_IR_TX]		=3D &ir_tx_clk.common.hw,
> > +		[CLK_GPADC0]		=3D &gpadc0_clk.common.hw,
> > +		[CLK_GPADC1]		=3D &gpadc1_clk.common.hw,
> >  		[CLK_PCIE_AUX]		=3D &pcie_aux_clk.common.hw,
> >  		[CLK_HDMI_24M]		=3D &hdmi_24M_clk.common.hw,
> >  		[CLK_HDMI_CEC_32K]	=3D &hdmi_cec_32k_clk.common.hw,
> >  =20
>=20
>=20
>=20
>=20


