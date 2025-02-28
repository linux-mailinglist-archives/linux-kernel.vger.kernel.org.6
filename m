Return-Path: <linux-kernel+bounces-538603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB6A49AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F301741C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E226D5CB;
	Fri, 28 Feb 2025 13:42:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141C26B2B5;
	Fri, 28 Feb 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750154; cv=none; b=e2wyLbvOD0zHhhiqPNvRw8FMlVxA5GpLIujnMiKg99UET9dh171RPzH4+/waGakrqZbg+NGdxb20l1ik5Cz8wVvHl8J4vmWvKUejGppvFIn99bfmJji2H1BzWDBkpfa8akXEqBOH+gFweab+pWwYsV3AsDtQsIyHvJK2gI6zA3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750154; c=relaxed/simple;
	bh=W2w9ZNg8iB9YklEV1CdbhvEXiJbivO5K+LxJOETPskg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jm6VbS647DLYOrybG5xfG4TIcZfsgEObzWerIlvZ9wpCDxKYvMSeby633ErgFDmDn7MxOGRh2YNo2Z7tCa5vVLCtezArDPxKf9tOE1iWJ1RKNELJc+w2pmFjQwadTglQBlWrerVwOXSGu6Mns5FgFnLRxbLn6ZzwVTF3Z2eU1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC8441515;
	Fri, 28 Feb 2025 05:42:46 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDAAA3F5A1;
	Fri, 28 Feb 2025 05:42:29 -0800 (PST)
Date: Fri, 28 Feb 2025 13:42:27 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] clk: sunxi-ng: a523: add video mod clocks
Message-ID: <20250228134227.4a955168@donnerap.manchester.arm.com>
In-Reply-To: <9406479.CDJkKcVGEf@jernej-laptop>
References: <20250214125359.5204-1-andre.przywara@arm.com>
	<20250214125359.5204-8-andre.przywara@arm.com>
	<9406479.CDJkKcVGEf@jernej-laptop>
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

On Tue, 18 Feb 2025 20:26:31 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Dne petek, 14. februar 2025 ob 13:53:51 Srednjeevropski standardni =C4=8D=
as je Andre Przywara napisal(a):
> > Add the clocks driving the various video subsystems of the SoC: the "DE"
> > display engine, the "DI" deinterlacer, the "G2D" 2D graphics system, the
> > Mali "GPU", the "VE" video engine, its associated IOMMU, as well as the
> > clocks for the various video output drivers (HDMI, DP, LCDs).
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 219 +++++++++++++++++++++++++
> >  1 file changed, 219 insertions(+)
> >=20
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi=
-ng/ccu-sun55i-a523.c
> > index 59f45e7c0904b..0ef1fd71a1ca5 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > @@ -364,6 +364,192 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1"=
, apb1_parents, 0x524,
> >  				 24, 3,		/* mux */
> >  				 0);
> > =20
> > +
> > +/*********************************************************************=
*****
> > + *                          mod clocks                                =
    *
> > + *********************************************************************=
*****/
> > +
> > +static const struct clk_hw *de_parents[] =3D {
> > +	&pll_periph0_300M_clk.hw,
> > +	&pll_periph0_400M_clk.hw,
> > +	&pll_video3_4x_clk.common.hw,
> > +	&pll_video3_3x_clk.hw,
> > +};
> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(de_clk, "de", de_parents, 0x600,
> > +				    0, 5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT);
> > +
> > +static const struct clk_hw *di_parents[] =3D {
> > +	&pll_periph0_300M_clk.hw,
> > +	&pll_periph0_400M_clk.hw,
> > +	&pll_video0_4x_clk.common.hw,
> > +	&pll_video1_4x_clk.common.hw,
> > +};
> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0x620,
> > +				    0, 5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT);
> > +
> > +static const struct clk_hw *g2d_parents[] =3D {
> > +	&pll_periph0_400M_clk.hw,
> > +	&pll_periph0_300M_clk.hw,
> > +	&pll_video0_4x_clk.common.hw,
> > +	&pll_video1_4x_clk.common.hw,
> > +};
> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", g2d_parents, 0x630,
> > +				    0, 5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0);
> > +
> > +static const struct clk_hw *gpu_parents[] =3D {
> > +	&pll_gpu_clk.common.hw,
> > +	&pll_periph0_800M_clk.common.hw,
> > +	&pll_periph0_600M_clk.hw,
> > +	&pll_periph0_400M_clk.hw,
> > +	&pll_periph0_300M_clk.hw,
> > +	&pll_periph0_200M_clk.hw,
> > +};
> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > +				    0, 4,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0); =20
>=20
> GPU clock should have CLK_SET_RATE_FLAG.

Yes indeed, fixed.

> > +
> > +static const struct clk_hw *ve_parents[] =3D {
> > +	&pll_ve_clk.common.hw,
> > +	&pll_periph0_480M_clk.common.hw,
> > +	&pll_periph0_400M_clk.hw,
> > +	&pll_periph0_300M_clk.hw,
> > +};
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
> > +				    0, 5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT);
> > +
> > +static const struct clk_parent_data iommu_parents[] =3D {
> > +	{ .hw =3D &pll_periph0_600M_clk.hw },
> > +	{ .hw =3D &pll_ddr0_clk.common.hw },
> > +	{ .hw =3D &pll_periph0_480M_clk.common.hw },
> > +	{ .hw =3D &pll_periph0_400M_clk.hw },
> > +	{ .hw =3D &pll_periph0_150M_clk.hw },
> > +	{ .fw_name =3D "hosc" },
> > +};
> > +
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(iommu_clk, "iommu", iommu_parent=
s, 0x7b0,
> > +				      0, 5,	/* M */
> > +				      24, 3,	/* mux */
> > +				      BIT(31),	/* gate */
> > +				      CLK_SET_RATE_PARENT); =20
>=20
> This won't work. IOMMU clock has also update bit, which must be set to ac=
tually
> apply the new value, same as DDR clock.

Good point, I actually missed that. I now added a new feature flag in a
new patch to flag those clocks that need bit 27 set whenever we change
something. An update bitmask, defaulting to 0, sounds more elegant, but
gets tricky because we would need that in all those clock routines (gate,
div, mux), so hardcoding bit 27 behind a flag (which is already available
to all those functions) gives a much easier implementation. Feel free to
disagree on that new patch ;-)

> > +
> > +static SUNXI_CCU_GATE_DATA(hdmi_24M_clk, "hdmi-24M", osc24M, 0xb04, BI=
T(31), 0);
> > +
> > +/* TODO: add mux between 32kOSC and PERIPH0/18750 */ =20
>=20
> Not sure what this TODO means.

Mhh, I don't remember either, and cannot find 18750 anywhere in the
manuals. Maybe I forgot to remove this comment when implementing the below
clock? Just removed it.

> > +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k",
> > +				      pll_periph0_2x_hws,
> > +				      0xb10, BIT(30), 36621, 0);
> > +
> > +static const struct clk_parent_data hdmi_cec_parents[] =3D {
> > +	{ .fw_name =3D "losc" },
> > +	{ .hw =3D &hdmi_cec_32k_clk.common.hw },
> > +};
> > +static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_cec_clk, "hdmi-cec", hdmi_cec=
_parents,
> > +				    0xb10,
> > +				    24, 1,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0);
> > +
> > +static const struct clk_parent_data mipi_dsi_parents[] =3D {
> > +	{ .fw_name =3D "hosc" },
> > +	{ .hw =3D &pll_periph0_200M_clk.hw },
> > +	{ .hw =3D &pll_periph0_150M_clk.hw },
> > +};
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi0_clk, "mipi-dsi0",
> > +				      mipi_dsi_parents, 0xb24,
> > +				      0, 5,	/* M */
> > +				      24, 3,	/* mux */
> > +				      BIT(31),	/* gate */
> > +				      CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi1_clk, "mipi-dsi1",
> > +				      mipi_dsi_parents, 0xb28,
> > +				      0, 5,	/* M */
> > +				      24, 3,	/* mux */
> > +				      BIT(31),	/* gate */
> > +				      CLK_SET_RATE_PARENT);
> > +
> > +static const struct clk_hw *tcon_parents[] =3D {
> > +	&pll_video0_4x_clk.common.hw,
> > +	&pll_video1_4x_clk.common.hw,
> > +	&pll_video2_4x_clk.common.hw,
> > +	&pll_video3_4x_clk.common.hw,
> > +	&pll_periph0_2x_clk.common.hw,
> > +	&pll_video0_3x_clk.hw,
> > +	&pll_video1_3x_clk.hw,
> > +};
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd0_clk, "tcon-lcd0", tcon_p=
arents,
> > +				    0xb60,
> > +				    0,  5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd1_clk, "tcon-lcd1", tcon_p=
arents,
> > +				    0xb64,
> > +				    0,  5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT); =20
>=20
> Missing tcon-lcd2 - see T527 manual.

Thanks, I added this.

> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(combophy_dsi0_clk, "combophy-dsi0",
> > +				    tcon_parents, 0xb6c,
> > +				    0,  5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(combophy_dsi1_clk, "combophy-dsi1",
> > +				    tcon_parents, 0xb70,
> > +				    0,  5,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0", tcon_par=
ents,
> > +				    0xb80,
> > +				    0, 4,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv1_clk, "tcon-tv1", tcon_par=
ents,
> > +				    0xb84,
> > +				    0, 4,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    CLK_SET_RATE_PARENT); =20
>=20
> TCON TV0-1 parents are subset of others, according to T527 manual.

Nice catch, fixed.

> > +
> > +static const struct clk_hw *edp_parents[] =3D {
> > +	&pll_video0_4x_clk.common.hw,
> > +	&pll_video1_4x_clk.common.hw,
> > +	&pll_video2_4x_clk.common.hw,
> > +	&pll_video3_4x_clk.common.hw,
> > +	&pll_periph0_2x_clk.common.hw,
> > +};
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp", edp_parents, 0xbb0,
> > +				    0, 4,	/* M */
> > +				    24, 3,	/* mux */
> > +				    BIT(31),	/* gate */
> > +				    0);
> > + =20
>=20
> Missing CLK_SET_RATE_PARENT flag.

Yes, thanks, added.

Cheers,
Andre

>=20
> Best regards,
> Jernej
>=20
> >  /*
> >   * Contains all clocks that are controlled by a hardware register. They
> >   * have a (sunxi) .common member, which needs to be initialised by the=
 common
> > @@ -394,6 +580,22 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =
=3D {
> >  	&ahb_clk.common,
> >  	&apb0_clk.common,
> >  	&apb1_clk.common,
> > +	&de_clk.common,
> > +	&di_clk.common,
> > +	&g2d_clk.common,
> > +	&gpu_clk.common,
> > +	&ve_clk.common,
> > +	&iommu_clk.common,
> > +	&hdmi_24M_clk.common,
> > +	&hdmi_cec_32k_clk.common,
> > +	&hdmi_cec_clk.common,
> > +	&mipi_dsi0_clk.common,
> > +	&mipi_dsi1_clk.common,
> > +	&tcon_lcd0_clk.common,
> > +	&tcon_lcd1_clk.common,
> > +	&tcon_tv0_clk.common,
> > +	&tcon_tv1_clk.common,
> > +	&edp_clk.common,
> >  };
> > =20
> >  static struct clk_hw_onecell_data sun55i_a523_hw_clks =3D {
> > @@ -442,6 +644,23 @@ static struct clk_hw_onecell_data sun55i_a523_hw_c=
lks =3D {
> >  		[CLK_AHB]		=3D &ahb_clk.common.hw,
> >  		[CLK_APB0]		=3D &apb0_clk.common.hw,
> >  		[CLK_APB1]		=3D &apb1_clk.common.hw,
> > +		[CLK_DE]		=3D &de_clk.common.hw,
> > +		[CLK_DI]		=3D &di_clk.common.hw,
> > +		[CLK_G2D]		=3D &g2d_clk.common.hw,
> > +		[CLK_GPU]		=3D &gpu_clk.common.hw,
> > +		[CLK_VE]		=3D &ve_clk.common.hw,
> > +		[CLK_HDMI_24M]		=3D &hdmi_24M_clk.common.hw,
> > +		[CLK_HDMI_CEC_32K]	=3D &hdmi_cec_32k_clk.common.hw,
> > +		[CLK_HDMI_CEC]		=3D &hdmi_cec_clk.common.hw,
> > +		[CLK_MIPI_DSI0]		=3D &mipi_dsi0_clk.common.hw,
> > +		[CLK_MIPI_DSI1]		=3D &mipi_dsi1_clk.common.hw,
> > +		[CLK_TCON_LCD0]		=3D &tcon_lcd0_clk.common.hw,
> > +		[CLK_TCON_LCD1]		=3D &tcon_lcd1_clk.common.hw,
> > +		[CLK_COMBOPHY_DSI0]	=3D &combophy_dsi0_clk.common.hw,
> > +		[CLK_COMBOPHY_DSI1]	=3D &combophy_dsi1_clk.common.hw,
> > +		[CLK_TCON_TV0]		=3D &tcon_tv0_clk.common.hw,
> > +		[CLK_TCON_TV1]		=3D &tcon_tv1_clk.common.hw,
> > +		[CLK_EDP]		=3D &edp_clk.common.hw,
> >  	},
> >  };
> > =20
> >  =20
>=20
>=20
>=20
>=20


