Return-Path: <linux-kernel+bounces-538617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1435DA49AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106A917455A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D326D5C9;
	Fri, 28 Feb 2025 13:51:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C441C3BE3;
	Fri, 28 Feb 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750665; cv=none; b=unDQpQ/AF8jqrS/TrictF2wcDGt1QEzy7PeXRzeaxqlSTkduCycNF2asL+1A6YcbnxQ2ZKr/KaYsN3DBrUwjQijNs2/CdT4PbHTWO6c61amEbKI1wgwg82Pp279bUJtOwUIlfHUyzb9Y9baoDMwAecdTnmPKXk+SARzbWLnnsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750665; c=relaxed/simple;
	bh=bAaBOyYHnMJl0iYLWqCkAYNz6FWQF9QRNVJt1sHroaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H71Diu/bwyRlsVgq5PQXQ3uOWcPNq2zFEgs3EOfku7Bodadhhj7i7U8/iY13VRPV48ONT76VQSeUwJb9z+HxthJ+0SqJaosiBhJzMsiSvu40aE3+//ZkWsVkI3tIB6DOEJUzEia31YZJ8n+h6N4bsdedyDaiIf15CfFYdhaEj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DABB1515;
	Fri, 28 Feb 2025 05:51:18 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 107F03F6A8;
	Fri, 28 Feb 2025 05:51:00 -0800 (PST)
Date: Fri, 28 Feb 2025 13:50:58 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/15] clk: sunxi-ng: a523: remaining mod clocks
Message-ID: <20250228135058.47f03a66@donnerap.manchester.arm.com>
In-Reply-To: <47026132.fMDQidcC6G@jernej-laptop>
References: <20250214125359.5204-1-andre.przywara@arm.com>
	<20250214125359.5204-12-andre.przywara@arm.com>
	<47026132.fMDQidcC6G@jernej-laptop>
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

On Tue, 18 Feb 2025 20:55:34 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Dne petek, 14. februar 2025 ob 13:53:55 Srednjeevropski standardni =C4=8D=
as je Andre Przywara napisal(a):
> > Add the remaining mod clocks, driving various parts of the SoC: the "LE=
DC"
> > LED controller, the "CSI" camera interface, the "ISP" image processor,
> > the DSP clock, and the "fanout" clocks, which allow to put clock signals
> > on external pins.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 190 +++++++++++++++++++++++++
> >  1 file changed, 190 insertions(+)
> >=20
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi=
-ng/ccu-sun55i-a523.c
> > index 59cc31f89ae77..6a4340f1fd041 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > @@ -354,6 +354,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", =
ahb_apb0_parents, 0x520,
> >  				 0, 5,		/* M */
> >  				 24, 2,	/* mux */
> >  				 0);
> > +static const struct clk_hw *apb0_hws[] =3D { &apb0_clk.common.hw };
> > =20
> >  static const struct clk_parent_data apb1_parents[] =3D {
> >  	{ .fw_name =3D "hosc" },
> > @@ -832,6 +833,153 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp=
", edp_parents, 0xbb0,
> >  				    BIT(31),	/* gate */
> >  				    0);
> > =20
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ir_tx_ledc_par=
ents,
> > +				      0xbf0,
> > +				      0, 4,	/* M */
> > +				      24, 1,	/* mux */
> > +				      BIT(31),	/* gate */
> > +				      0);
> > +
> > +static const struct clk_hw *csi_top_parents[] =3D {
> > +	&pll_periph0_300M_clk.hw,
> > +	&pll_periph0_400M_clk.hw,
> > +	&pll_periph0_480M_clk.common.hw,
> > +	&pll_video3_4x_clk.common.hw,
> > +	&pll_video3_3x_clk.hw,
> > +};
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_top_clk, "csi-top", csi_top_pa=
rents,
> > +				    0xc04,
> > +				    0, 5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0);
> > +
> > +static const struct clk_parent_data csi_mclk_parents[] =3D {
> > +	{ .fw_name =3D "hosc" },
> > +	{ .hw =3D &pll_video3_4x_clk.common.hw },
> > +	{ .hw =3D &pll_video0_4x_clk.common.hw },
> > +	{ .hw =3D &pll_video1_4x_clk.common.hw },
> > +	{ .hw =3D &pll_video2_4x_clk.common.hw },
> > +};
> > +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk0_clk, "csi-mclk0",
> > +				       csi_mclk_parents, 0xc08,
> > +				       0, 5,	/* M */
> > +				       8, 5,	/* P */
> > +				       24, 3,	/* mux */
> > +				       BIT(31),	/* gate */
> > +				       0); =20
>=20
> Missing dual div flag for csi-mclk clocks.

Nice one, another case for the new macro ...

> > +
> > +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk1_clk, "csi-mclk1",
> > +				       csi_mclk_parents, 0xc0c,
> > +				       0, 5,	/* M */
> > +				       8, 5,	/* P */
> > +				       24, 3,	/* mux */
> > +				       BIT(31),	/* gate */
> > +				       0);
> > +
> > +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk2_clk, "csi-mclk2",
> > +				       csi_mclk_parents, 0xc10,
> > +				       0, 5,	/* M */
> > +				       8, 5,	/* P */
> > +				       24, 3,	/* mux */
> > +				       BIT(31),	/* gate */
> > +				       0);
> > +
> > +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk3_clk, "csi-mclk3",
> > +				       csi_mclk_parents, 0xc14,
> > +				       0, 5,	/* M */
> > +				       8, 5,	/* P */
> > +				       24, 3,	/* mux */
> > +				       BIT(31),	/* gate */
> > +				       0);
> > +
> > +static const struct clk_hw *isp_parents[] =3D {
> > +	&pll_periph0_300M_clk.hw,
> > +	&pll_periph0_400M_clk.hw,
> > +	&pll_video2_4x_clk.common.hw,
> > +	&pll_video3_4x_clk.common.hw,
> > +};
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(isp_clk, "isp", isp_parents, 0xc20,
> > +				    0, 5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0);
> > +
> > +static const struct clk_parent_data dsp_parents[] =3D {
> > +	{ .fw_name =3D "hosc" },
> > +	{ .fw_name =3D "losc" },
> > +	{ .fw_name =3D "iosc" },
> > +	{ .hw =3D &pll_periph0_2x_clk.common.hw },
> > +	{ .hw =3D &pll_periph0_400M_clk.hw, }, =20
>=20
> Last one should be pll_periph0_480M_clk.

Right, spotting the difference between an 8 and a 0 earns you some extra
points! Fixed.

>=20
> > +};
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(dsp_clk, "dsp", dsp_parents, 0xc=
70,
> > +				      0, 5,	/* M */
> > +				      24, 3,	/* mux */
> > +				      BIT(31),	/* gate */
> > +				      0);
> > +
> > +static SUNXI_CCU_GATE_DATA(fanout_24M_clk, "fanout-24M", osc24M,
> > +			   0xf30, BIT(0), 0);
> > +static SUNXI_CCU_GATE_DATA_WITH_PREDIV(fanout_12M_clk, "fanout-12M", o=
sc24M,
> > +				       0xf30, BIT(1), 2, 0);
> > +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_16M_clk, "fanout-16M",
> > +				      pll_periph0_480M_hws,
> > +				      0xf30, BIT(2), 30, 0);
> > +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_25M_clk, "fanout-25M",
> > +				      pll_periph0_2x_hws,
> > +				      0xf30, BIT(3), 48, 0);
> > +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_50M_clk, "fanout-50M",
> > +				      pll_periph0_2x_hws,
> > +				      0xf30, BIT(4), 24, 0);
> > +
> > +/* These clocks have a second divider that is not modelled and forced =
to 0. */ =20
>=20
> Any specific reason for that?

Laziness? Being annoyed about Allwinner doing those random changes without
good reason? I sighed audibly, then added a new macro that uses the dual
divider feature. This allows us to get rid of the initialisation of those
registers below.

Thanks for poking into this ;-)

Cheers,
Andre

> Best regards,
> Jernej
>=20
> > +#define SUN55I_A523_FANOUT_27M_REG	0xf34
> > +static const struct clk_hw *fanout_27M_parents[] =3D {
> > +	&pll_video0_4x_clk.common.hw,
> > +	&pll_video1_4x_clk.common.hw,
> > +	&pll_video2_4x_clk.common.hw,
> > +	&pll_video3_4x_clk.common.hw,
> > +};
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(fanout_27M_clk, "fanout-27M",
> > +				    fanout_27M_parents, 0xf34,
> > +				    0, 5,	/* M */
> > +				    24, 2,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0);
> > +
> > +#define SUN55I_A523_FANOUT_PCLK_REG	0xf38
> > +static SUNXI_CCU_M_HWS_WITH_GATE(fanout_pclk_clk, "fanout-pclk", apb0_=
hws,
> > +				 0xf38,
> > +				 0, 5,		/* M */
> > +				 BIT(31),	/* gate */
> > +				 0);
> > +
> > +static const struct clk_parent_data fanout_parents[] =3D {
> > +	{ .fw_name =3D "osc32k-out" },
> > +	{ .hw =3D &fanout_12M_clk.common.hw, },
> > +	{ .hw =3D &fanout_16M_clk.common.hw, },
> > +	{ .hw =3D &fanout_24M_clk.common.hw, },
> > +	{ .hw =3D &fanout_25M_clk.common.hw, },
> > +	{ .hw =3D &fanout_27M_clk.common.hw, },
> > +	{ .hw =3D &fanout_pclk_clk.common.hw, },
> > +	{ .hw =3D &fanout_50M_clk.common.hw, },
> > +};
> > +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout0_clk, "fanout0", fanout_par=
ents,
> > +				    0xf3c,
> > +				    0, 3,	/* mux */
> > +				    BIT(21),	/* gate */
> > +				    0);
> > +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout1_clk, "fanout1", fanout_par=
ents,
> > +				    0xf3c,
> > +				    3, 3,	/* mux */
> > +				    BIT(22),	/* gate */
> > +				    0);
> > +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout2_clk, "fanout2", fanout_par=
ents,
> > +				    0xf3c,
> > +				    6, 3,	/* mux */
> > +				    BIT(23),	/* gate */
> > +				    0);
> > +
> >  /*
> >   * Contains all clocks that are controlled by a hardware register. They
> >   * have a (sunxi) .common member, which needs to be initialised by the=
 common
> > @@ -904,6 +1052,23 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =
=3D {
> >  	&tcon_tv0_clk.common,
> >  	&tcon_tv1_clk.common,
> >  	&edp_clk.common,
> > +	&ledc_clk.common,
> > +	&csi_top_clk.common,
> > +	&csi_mclk0_clk.common,
> > +	&csi_mclk1_clk.common,
> > +	&csi_mclk2_clk.common,
> > +	&csi_mclk3_clk.common,
> > +	&isp_clk.common,
> > +	&dsp_clk.common,
> > +	&fanout_24M_clk.common,
> > +	&fanout_12M_clk.common,
> > +	&fanout_16M_clk.common,
> > +	&fanout_25M_clk.common,
> > +	&fanout_27M_clk.common,
> > +	&fanout_pclk_clk.common,
> > +	&fanout0_clk.common,
> > +	&fanout1_clk.common,
> > +	&fanout2_clk.common,
> >  };
> > =20
> >  static struct clk_hw_onecell_data sun55i_a523_hw_clks =3D {
> > @@ -997,6 +1162,23 @@ static struct clk_hw_onecell_data sun55i_a523_hw_=
clks =3D {
> >  		[CLK_TCON_TV0]		=3D &tcon_tv0_clk.common.hw,
> >  		[CLK_TCON_TV1]		=3D &tcon_tv1_clk.common.hw,
> >  		[CLK_EDP]		=3D &edp_clk.common.hw,
> > +		[CLK_LEDC]		=3D &ledc_clk.common.hw,
> > +		[CLK_CSI_TOP]		=3D &csi_top_clk.common.hw,
> > +		[CLK_CSI_MCLK0]		=3D &csi_mclk0_clk.common.hw,
> > +		[CLK_CSI_MCLK1]		=3D &csi_mclk1_clk.common.hw,
> > +		[CLK_CSI_MCLK2]		=3D &csi_mclk2_clk.common.hw,
> > +		[CLK_CSI_MCLK3]		=3D &csi_mclk3_clk.common.hw,
> > +		[CLK_ISP]		=3D &isp_clk.common.hw,
> > +		[CLK_DSP]		=3D &dsp_clk.common.hw,
> > +		[CLK_FANOUT_24M]	=3D &fanout_24M_clk.common.hw,
> > +		[CLK_FANOUT_12M]	=3D &fanout_12M_clk.common.hw,
> > +		[CLK_FANOUT_16M]	=3D &fanout_16M_clk.common.hw,
> > +		[CLK_FANOUT_25M]	=3D &fanout_25M_clk.common.hw,
> > +		[CLK_FANOUT_27M]	=3D &fanout_27M_clk.common.hw,
> > +		[CLK_FANOUT_PCLK]	=3D &fanout_pclk_clk.common.hw,
> > +		[CLK_FANOUT0]		=3D &fanout0_clk.common.hw,
> > +		[CLK_FANOUT1]		=3D &fanout1_clk.common.hw,
> > +		[CLK_FANOUT2]		=3D &fanout2_clk.common.hw,
> >  	},
> >  };
> > =20
> > @@ -1048,6 +1230,14 @@ static int sun55i_a523_ccu_probe(struct platform=
_device *pdev)
> >  	val &=3D ~(BIT(1) | BIT(0));
> >  	writel(val, reg + SUN55I_A523_PLL_AUDIO0_REG);
> > =20
> > +	/* Force fanout factors N to 0. */
> > +	val =3D readl(reg + SUN55I_A523_FANOUT_27M_REG);
> > +	val &=3D ~GENMASK(12, 8);
> > +	writel(val, reg + SUN55I_A523_FANOUT_27M_REG);
> > +	val =3D readl(reg + SUN55I_A523_FANOUT_PCLK_REG);
> > +	val &=3D ~GENMASK(9, 5);
> > +	writel(val, reg + SUN55I_A523_FANOUT_PCLK_REG);
> > +
> >  	ret =3D devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_ccu_desc);
> >  	if (ret)
> >  		return ret;
> >  =20
>=20
>=20
>=20
>=20


