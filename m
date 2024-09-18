Return-Path: <linux-kernel+bounces-332260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2697B76E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD8F1F22418
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8315443B;
	Wed, 18 Sep 2024 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV1yBtwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF413792B;
	Wed, 18 Sep 2024 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726637335; cv=none; b=Bk7X96YY/AHI4N5OndPQjCyI0j0oTajpq7F6bRxqP/sCat3q3CNaf6sRfJRhLRTPTEqJaEy2aDWSHdtdXS3rgp8RmSpahNz1nliuLAYAxH2fx0NA3ZKsCOsD2sfSuTuLP1LJmkOzhtkH25VVVjNbhdDotpGUglikqQKkf5WgmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726637335; c=relaxed/simple;
	bh=DRGqyEdnxs+3+UtdjxhUV+J+gQsMdPPoiM7bZWlsgeM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rSanol/BD7TkiI/6hi0bPeHcfUc8aBrD63VH7Z/ljJQ5iopy94GI5iIHfCFuk0GX88f20CUCTCX+iqlwqA25hUl3XT2QS4Q4CyllUaQ0CsYvuK++s88NIKC788KFkBsrbEMequac5mQsH0mreLXNajq40WTN/zhIS1//MSG06aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV1yBtwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7486BC4CEC3;
	Wed, 18 Sep 2024 05:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726637335;
	bh=DRGqyEdnxs+3+UtdjxhUV+J+gQsMdPPoiM7bZWlsgeM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZV1yBtwjwwl7t/VbtKRxkYN8AueENWCDlAlPOS65p6ARAJegTmi1xtcGEjINyEvKA
	 rdS3nTmu2s/JtXGQ6hD/eT7Qy5A1Nd0CM2vu4wH1RN3UiZxuKQgR8uMlS5z2xLg2Zl
	 qNPEKImg4FA5G9jZksG7Ysug7cxCvKH/40BEXWfw235zPg7xWAiVWyLJLMS4Sj5rGe
	 Rev11WXvp4BmhTCNZ3tSSpCq2TjamfCIuB6zha5EdCUaYUVU7FCDIHIb6FGNQUOEBm
	 X8Y0z1b39tpt+Vslvka9S09mj+uHmg59U9ALwkENGsAlQChXC6YMsPRC0jyGdtyq4b
	 gkPklJmc9iO4A==
Message-ID: <586966c515e15f455973e7c55bd3ac5e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240730-mbly-clk-v3-4-4f90fad2f203@bootlin.com>
References: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com> <20240730-mbly-clk-v3-4-4f90fad2f203@bootlin.com>
Subject: Re: [PATCH RESEND v3 4/4] clk: eyeq: add driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Tue, 17 Sep 2024 22:28:53 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-07-30 09:04:46)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3e9099504fad..31f48edf855c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -218,6 +218,19 @@ config COMMON_CLK_EN7523
>           This driver provides the fixed clocks and gates present on Airo=
ha
>           ARM silicon.
> =20
> +config COMMON_CLK_EYEQ
> +       bool "Clock driver for the Mobileye EyeQ platform"
> +       depends on 64BIT # for readq()
> +       depends on OF || COMPILE_TEST

What's the OF build dependency? If there isn't one please remove this
line.

> +       depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
> +       select AUXILIARY_BUS
> +       default MACH_EYEQ5 || MACH_EYEQ6H
> +       help
> +         This driver provides clocks found on Mobileye EyeQ5, EyeQ6L and=
 Eye6H
> +         SoCs. Controllers live in shared register regions called OLB. D=
river
> +         provides read-only PLLs, derived from the main crystal clock (w=
hich
> +         must be constant). It also exposes some divider clocks.
> +
> diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
> new file mode 100644
> index 000000000000..dbf912aa1217
> --- /dev/null
> +++ b/drivers/clk/clk-eyeq.c
> @@ -0,0 +1,793 @@
> +// SPDX-License-Identifier: GPL-2.0-only
[...]
> +
> +static int eqc_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
> +                                  unsigned long *div, unsigned long *acc)
> +{
> +       if (r0 & PCSR0_BYPASS) {
> +               *mult =3D 1;
> +               *div =3D 1;
> +               *acc =3D 0;
> +               return 0;
> +       }
> +
> +       if (!(r0 & PCSR0_PLL_LOCKED))
> +               return -EINVAL;
> +
> +       *mult =3D FIELD_GET(PCSR0_INTIN, r0);
> +       *div =3D FIELD_GET(PCSR0_REF_DIV, r0);
> +       if (r0 & PCSR0_FOUTPOSTDIV_EN)
> +               *div *=3D FIELD_GET(PCSR0_POST_DIV1, r0) * FIELD_GET(PCSR=
0_POST_DIV2, r0);
> +
> +       /* Fractional mode, in 2^20 (0x100000) parts. */
> +       if (r0 & PCSR0_DSM_EN) {
> +               *div *=3D 0x100000;

I'd think 1 << 20 is more idiomatic to represent 2^20 because we don't
have to count the zeroes to make sure this is right.

> +               *mult =3D *mult * 0x100000 + FIELD_GET(PCSR1_FRAC_IN, r1);
> +       }
> +
> +       if (!*mult || !*div)
> +               return -EINVAL;
> +
> +       /* Spread spectrum. */
> +       if (!(r1 & (PCSR1_RESET | PCSR1_DIS_SSCG))) {
> +               /*
> +                * Spread is 1/1000 parts of frequency, accuracy is half =
of
> +                * that. To get accuracy, convert to ppb (parts per billi=
on).
> +                */
> +               u32 spread =3D FIELD_GET(PCSR1_SPREAD, r1);
> +
> +               *acc =3D spread * 500000;

Where does 500000 come from? Half a billion?

> +               if (r1 & PCSR1_DOWN_SPREAD) {
> +                       /*
> +                        * Downspreading: the central frequency is half a
> +                        * spread lower.
> +                        */
> +                       *mult *=3D 2000 - spread;
> +                       *div *=3D 2000;
> +
> +                       /*
> +                        * Previous operation might overflow 32 bits. If =
it
> +                        * does, throw away the least amount of low bits.
> +                        */
> +                       eqc_pll_downshift_factors(mult, div);
> +               }
> +       } else {
> +               *acc =3D 0;

I'd de-indent by inverting this and returning early when *acc =3D 0.

> +       }
> +
> +       return 0;
> +}
> +
[...]
> +
> +static const struct of_device_id eqc_match_table[] =3D {
> +       { .compatible =3D "mobileye,eyeq5-olb", .data =3D &eqc_eyeq5_matc=
h_data },
> +       { .compatible =3D "mobileye,eyeq6l-olb", .data =3D &eqc_eyeq6l_ma=
tch_data },
> +       { .compatible =3D "mobileye,eyeq6h-west-olb", .data =3D &eqc_eyeq=
6h_west_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-east-olb", .data =3D &eqc_eyeq=
6h_east_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-south-olb", .data =3D &eqc_eye=
q6h_south_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-ddr0-olb", .data =3D &eqc_eyeq=
6h_ddr0_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-ddr1-olb", .data =3D &eqc_eyeq=
6h_ddr1_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-acc-olb", .data =3D &eqc_eyeq6=
h_acc_match_data },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, eqc_match_table);

Module device table should be removed as this can't be a module.

> +
> +static struct platform_driver eqc_driver =3D {
> +       .probe =3D eqc_probe,
> +       .driver =3D {
> +               .name =3D "clk-eyeq",
> +               .of_match_table =3D eqc_match_table,
> +       },
> +};
> +builtin_platform_driver(eqc_driver);
> +
> +/* Required early for GIC timer (pll-cpu) and UARTs (pll-per). */
> +static const struct eqc_pll eqc_eyeq5_early_plls[] =3D {
> +       { .index =3D EQ5C_PLL_CPU, .name =3D "pll-cpu",  .reg64 =3D 0x02C=
 },
> +       { .index =3D EQ5C_PLL_PER, .name =3D "pll-per",  .reg64 =3D 0x05C=
 },
> +};
> +
> +static const struct eqc_early_match_data eqc_eyeq5_early_match_data =3D {
> +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq5_early_plls),
> +       .early_plls             =3D eqc_eyeq5_early_plls,
> +       .nb_late_clks =3D eqc_eyeq5_match_data.pll_count + eqc_eyeq5_matc=
h_data.div_count,
> +};
> +
> +/* Required early for GIC timer. */
> +static const struct eqc_pll eqc_eyeq6h_central_early_plls[] =3D {
> +       { .index =3D 0, .name =3D "pll-cpu", .reg64 =3D 0x02C },
> +};
> +
> +static const struct eqc_early_match_data eqc_eyeq6h_central_early_match_=
data =3D {
> +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq6h_central_early_p=
lls),
> +       .early_plls             =3D eqc_eyeq6h_central_early_plls,
> +       .nb_late_clks =3D 0,
> +};
> +
> +/* Required early for UART. */

Is this required for earlycon? Where is the UART not a device driver
that needs to get clks early?

> +static const struct eqc_pll eqc_eyeq6h_west_early_plls[] =3D {
> +       { .index =3D 0, .name =3D "pll-west", .reg64 =3D 0x074 },
> +};
> +
> +static const struct eqc_early_match_data eqc_eyeq6h_west_early_match_dat=
a =3D {
> +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq6h_west_early_plls=
),
> +       .early_plls             =3D eqc_eyeq6h_west_early_plls,
> +       .nb_late_clks =3D 0,
> +};
> +
> +static const struct of_device_id eqc_early_match_table[] =3D {

Can be __initconst

> +       {
> +               .compatible =3D "mobileye,eyeq5-olb",
> +               .data =3D &eqc_eyeq5_early_match_data,
> +       },
> +       {
> +               .compatible =3D "mobileye,eyeq6h-central-olb",
> +               .data =3D &eqc_eyeq6h_central_early_match_data,
> +       },
> +       {
> +               .compatible =3D "mobileye,eyeq6h-west-olb",
> +               .data =3D &eqc_eyeq6h_west_early_match_data,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, eqc_early_match_table);

This isn't needed because this isn't a module.

> +
> +static void __init eqc_init(struct device_node *np)
> +{
> +       const struct eqc_early_match_data *early_data;
> +       const struct of_device_id *early_match_data;
> +       unsigned int nb_clks =3D 0;

Drop useless assignment please.

> +       struct eqc_priv *priv;
> +       void __iomem *base;
> +       unsigned int i;
> +       int ret;
> +
> +       early_match_data =3D of_match_node(eqc_early_match_table, np);

We've already matched before calling this function. I'd prefer a wrapper

	static void __init eqc_init(struct device_node *np, const struct eqc_early=
_match_data *early_data)
	{
	}

	static void __init eqc_eyeq5_early_init(struct device_node *np)
	{
		eqc_init(np, &eqc_eyeq5_early_match_data);
	}

then we don't need a match table, and skip the string comparison again.

> +       if (!early_match_data)
> +               return;
> +
> +       early_data =3D early_match_data->data;
> +       /* No reason to early init this clock provider. Delay until probe=
. */
> +       if (!early_data || early_data->early_pll_count =3D=3D 0)
> +               return;

I suspect this code can be removed too because it's purely defensive.

> +
> +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +
> +       priv->np =3D np;
> +       priv->early_data =3D early_data;
> +
> +       nb_clks =3D early_data->early_pll_count + early_data->nb_late_clk=
s;
> +       priv->cells =3D kzalloc(struct_size(priv->cells, hws, nb_clks), G=
FP_KERNEL);
> +       if (!priv->cells) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +
> +       priv->cells->num =3D nb_clks;
> +
> +       /*
> +        * Mark all clocks as deferred; some are registered here, the res=
t at
> +        * platform device probe.
> +        */
> +       for (i =3D 0; i < nb_clks; i++)
> +               priv->cells->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> +
> +       /* Offsets (reg64) of early PLLs are relative to OLB block. */
> +       base =3D of_iomap(np, 0);
> +       if (!base) {
> +               ret =3D -ENODEV;
> +               goto err;
> +       }
> +
> +       for (i =3D 0; i < early_data->early_pll_count; i++) {
> +               const struct eqc_pll *pll =3D &early_data->early_plls[i];
> +               unsigned long mult, div, acc;
> +               struct clk_hw *hw;
> +               u32 r0, r1;
> +               u64 val;
> +
> +               val =3D readq(base + pll->reg64);
> +               r0 =3D val;
> +               r1 =3D val >> 32;
> +
> +               ret =3D eqc_pll_parse_registers(r0, r1, &mult, &div, &acc=
);
> +               if (ret) {
> +                       pr_err("failed parsing state of %s\n", pll->name);
> +                       goto err;
> +               }
> +
> +               hw =3D clk_hw_register_fixed_factor_with_accuracy_fwname(=
NULL,
> +                               np, pll->name, "ref", 0, mult, div, acc);
> +               priv->cells->hws[pll->index] =3D hw;
> +               if (IS_ERR(hw)) {
> +                       pr_err("failed registering %s: %pe\n", pll->name,=
 hw);
> +                       ret =3D PTR_ERR(hw);
> +                       goto err;
> +               }
> +       }
> +
> +       /* When providing a single clock, require no cell. */
> +       if (nb_clks =3D=3D 1)
> +               ret =3D of_clk_add_hw_provider(np, of_clk_hw_simple_get, =
priv->cells->hws[0]);
> +       else
> +               ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get,=
 priv->cells);
> +       if (ret) {
> +               pr_err("failed registering clk provider: %d\n", ret);
> +               goto err;
> +       }
> +
> +       spin_lock(&eqc_list_slock);

I don't see how the spinlock provides any value. This function will run
before any struct devices have been created.

> +       list_add_tail(&priv->list, &eqc_list);

The list is also kind of unnecessary. Set a bool in the match_data and
move on? We could have some sort of static_assert() check to make sure
if there's a CLK_OF_DECLARE_DRIVER() then the bool is set in the
match_data for the driver. Such a design is cheaper than taking a lock,
adding to a list.

> +       spin_unlock(&eqc_list_slock);
> +
> +       return;
> +

