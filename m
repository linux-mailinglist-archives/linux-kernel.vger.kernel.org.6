Return-Path: <linux-kernel+bounces-538581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F62A49A86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694AE18972DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27826D5B8;
	Fri, 28 Feb 2025 13:29:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA691D555;
	Fri, 28 Feb 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749368; cv=none; b=EPDwY2wBuD1NmiNhvwQjo1QMzskC3Yp774ZwsPNZJBZZKGKYMY3Yj+Ay6PS9fhZv9rQwIcWADfnpGWzR2vldEByDlXECjAmGUThKeQqcec5C5KnYrujGok9UQSmatS3rw6CkP2IEqzrVFYBshGXJRYP/V+PPxjqBW5+F6HNzB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749368; c=relaxed/simple;
	bh=9nEznCs8TmXppNEP6Ri/KXbhxb9P855Eu4NIWIxpH2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzhO+EoBU6UcOimA7met6ipEe0e85jjew7EaWDN+dmrkh3sQFUEXmePOyalkcyxh0oiUQJW3Fef8LY9kTvWf76Jove7yCRr8haeXS6jmLFHNjrg6HnPt2CFsrhaNFKM1sNJshzE/BJ5+2Cs+PjawMMeEEBMV7ajunAN+8sSWlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C7541688;
	Fri, 28 Feb 2025 05:29:39 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679E23F673;
	Fri, 28 Feb 2025 05:29:22 -0800 (PST)
Date: Fri, 28 Feb 2025 13:29:08 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] clk: sunxi-ng: Add support for the A523/T527
 CCU PLLs
Message-ID: <20250228132908.632b82dd@donnerap.manchester.arm.com>
In-Reply-To: <3341127.44csPzL39Z@jernej-laptop>
References: <20250214125359.5204-1-andre.przywara@arm.com>
	<20250214125359.5204-6-andre.przywara@arm.com>
	<3341127.44csPzL39Z@jernej-laptop>
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

On Tue, 18 Feb 2025 20:03:38 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

many thanks for having a look!

> Dne petek, 14. februar 2025 ob 13:53:49 Srednjeevropski standardni =C4=8D=
as je Andre Przywara napisal(a):
> > Add the PLL clocks of the main CCU of the Allwinner A523 and T527 SoCs.
> > The clocks were modelled after the A523 and T527 manual, and double
> > checked by writing all 1's into the respective register, to spot all
> > implemented bits.
> >=20
> > The PLL and mod clocks for the two CPU clusters and the DSU are part of
> > a separate CCU, also most audio clocks are collected in a DSP CCU, so
> > both of these clock groups are missing from this driver.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/clk/sunxi-ng/Kconfig           |   5 +
> >  drivers/clk/sunxi-ng/Makefile          |   2 +
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 481 +++++++++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523.h |  14 +
> >  drivers/clk/sunxi-ng/ccu_mp.h          |  14 +-
> >  5 files changed, 510 insertions(+), 6 deletions(-)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
> >=20
> > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> > index b547198a2c654..04efbda847cf9 100644
> > --- a/drivers/clk/sunxi-ng/Kconfig
> > +++ b/drivers/clk/sunxi-ng/Kconfig
> > @@ -52,6 +52,11 @@ config SUN50I_H6_R_CCU
> >  	default y
> >  	depends on ARM64 || COMPILE_TEST
> > =20
> > +config SUN55I_A523_CCU
> > +	tristate "Support for the Allwinner A523/T527 CCU"
> > +	default y
> > +	depends on ARM64 || COMPILE_TEST
> > +
> >  config SUN4I_A10_CCU
> >  	tristate "Support for the Allwinner A10/A20 CCU"
> >  	default y
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makef=
ile
> > index 6b3ae2b620db6..01a887f7824bb 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -33,6 +33,7 @@ obj-$(CONFIG_SUN50I_A100_R_CCU)	+=3D sun50i-a100-r-cc=
u.o
> >  obj-$(CONFIG_SUN50I_H6_CCU)	+=3D sun50i-h6-ccu.o
> >  obj-$(CONFIG_SUN50I_H6_R_CCU)	+=3D sun50i-h6-r-ccu.o
> >  obj-$(CONFIG_SUN50I_H616_CCU)	+=3D sun50i-h616-ccu.o
> > +obj-$(CONFIG_SUN55I_A523_CCU)	+=3D sun55i-a523-ccu.o
> >  obj-$(CONFIG_SUN4I_A10_CCU)	+=3D sun4i-a10-ccu.o
> >  obj-$(CONFIG_SUN5I_CCU)		+=3D sun5i-ccu.o
> >  obj-$(CONFIG_SUN6I_A31_CCU)	+=3D sun6i-a31-ccu.o
> > @@ -58,6 +59,7 @@ sun50i-a100-r-ccu-y		+=3D ccu-sun50i-a100-r.o
> >  sun50i-h6-ccu-y			+=3D ccu-sun50i-h6.o
> >  sun50i-h6-r-ccu-y		+=3D ccu-sun50i-h6-r.o
> >  sun50i-h616-ccu-y		+=3D ccu-sun50i-h616.o
> > +sun55i-a523-ccu-y		+=3D ccu-sun55i-a523.o
> >  sun4i-a10-ccu-y			+=3D ccu-sun4i-a10.o
> >  sun5i-ccu-y			+=3D ccu-sun5i.o
> >  sun6i-a31-ccu-y			+=3D ccu-sun6i-a31.o
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi=
-ng/ccu-sun55i-a523.c
> > new file mode 100644
> > index 0000000000000..8374e841e9d82
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > @@ -0,0 +1,481 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023-2024 Arm Ltd.
> > + * Based on the D1 CCU driver:
> > + *   Copyright (c) 2020 huangzhenwei@allwinnertech.com
> > + *   Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "../clk.h"
> > +
> > +#include "ccu_common.h"
> > +#include "ccu_reset.h"
> > +
> > +#include "ccu_div.h"
> > +#include "ccu_gate.h"
> > +#include "ccu_mp.h"
> > +#include "ccu_mult.h"
> > +#include "ccu_nk.h"
> > +#include "ccu_nkm.h"
> > +#include "ccu_nkmp.h"
> > +#include "ccu_nm.h"
> > +
> > +#include "ccu-sun55i-a523.h"
> > +
> > +/*
> > + * The 24 MHz oscillator, the root of most of the clock tree.
> > + * .fw_name is the string used in the DT "clock-names" property, used =
to
> > + * identify the corresponding clock in the "clocks" property.
> > + */
> > +static const struct clk_parent_data osc24M[] =3D {
> > +	{ .fw_name =3D "hosc" }
> > +};
> > +
> > +/*********************************************************************=
*****
> > + *                              PLLs                                  =
    *
> > + *********************************************************************=
*****/
> > +
> > +/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
> > +#define SUN55I_A523_PLL_DDR0_REG		0x010
> > +static struct ccu_nkmp pll_ddr0_clk =3D {
> > +	.enable		=3D BIT(27),
> > +	.lock		=3D BIT(28),
> > +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> > +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */ =20
>=20
> Newer manuals, for example A523 manual v1.4, don't mention input dividers=
 anymore.
> Newer BSP driver doesn't have them either. Should we drop them (for all P=
LLs)?

I don't know, as you figured, I found them in my copy of the manual. For
the PLLs we need today (PLL_PERIPH0) it shouldn't matter anyway: it's
programmed already, and AFAICS Linux actually never reprograms it(?).

In any case, I just left it in for now: the bit is definitely there, I
verified that in U-Boot by only seeing half of the MMC performance with
bit 1 set. We can remove them anytime later, without issue, can't we?

Actually, thinking about that: the manual pretty clearly says that for
instance PLL_PERIPH0 should be set to 1.2GHz and never changed or even
touched. I wonder if we should honour this somehow in the code? It seems
like the CCF doesn't do this anyway at the moment, but it could, I guess?

>=20
> > +	.p		=3D _SUNXI_CCU_DIV(0, 1), /* output divider */
> > +	.common		=3D {
> > +		.reg		=3D 0x010,
> > +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-ddr0", osc24M,
> > +							   &ccu_nkmp_ops,
> > +							   CLK_SET_RATE_GATE |
> > +							   CLK_IS_CRITICAL),
> > +	},
> > +};
> > +

....

> > diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_m=
p.h
> > index 687bd2ec798e2..5311835a4db60 100644
> > --- a/drivers/clk/sunxi-ng/ccu_mp.h
> > +++ b/drivers/clk/sunxi-ng/ccu_mp.h
> > @@ -100,20 +100,22 @@ struct ccu_mp { =20
>=20
> These changes doesn't belong in this commit.

Ah, indeed, I missed that. Moved that out into another patch now.

Cheers,
Andre

> Other than that, this looks like a good start. Thanks!
>=20
> Best regards,
> Jernej
>=20
> >  				   _muxshift, _muxwidth,		\
> >  				   0, _flags)
> > =20
> > -#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents,=
 _reg, \
> > +#define SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(_struct, _name, _parents, _=
reg, \
> >  					_mshift, _mwidth,		\
> >  					_pshift, _pwidth,		\
> >  					_muxshift, _muxwidth,		\
> > -					_gate, _flags,			\
> > -					_features)			\
> > +					_gate, _postdiv,		\
> > +					_flags, _features)		\
> >  	struct ccu_mp _struct =3D {					\
> >  		.enable	=3D _gate,					\
> >  		.m	=3D _SUNXI_CCU_DIV(_mshift, _mwidth),		\
> >  		.p	=3D _SUNXI_CCU_DIV(_pshift, _pwidth),		\
> >  		.mux	=3D _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
> > +		.fixed_post_div =3D _postdiv,				\
> >  		.common	=3D {						\
> >  			.reg		=3D _reg,				\
> > -			.features	=3D _features,			\
> > +			.features	=3D CCU_FEATURE_FIXED_POSTDIV |	\
> > +						_features,		\
> >  			.hw.init	=3D CLK_HW_INIT_PARENTS_DATA(_name, \
> >  								   _parents, \
> >  								   &ccu_mp_ops,\
> > @@ -126,11 +128,11 @@ struct ccu_mp {
> >  					_pshift, _pwidth,		\
> >  					_muxshift, _muxwidth,		\
> >  					_gate, _flags)			\
> > -	SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents,	\
> > +	SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(_struct, _name, _parents,	\
> >  					     _reg, _mshift, _mwidth,	\
> >  					     _pshift, _pwidth,		\
> >  					     _muxshift, _muxwidth,	\
> > -					     _gate, _flags, 0)
> > +					     _gate, 1, _flags, 0)
> > =20
> >  #define SUNXI_CCU_MP_DATA_WITH_MUX(_struct, _name, _parents, _reg,	\
> >  				   _mshift, _mwidth,			\
> >  =20
>=20
>=20
>=20
>=20


