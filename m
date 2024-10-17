Return-Path: <linux-kernel+bounces-370439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F109A2C77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E461C219C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D232194A0;
	Thu, 17 Oct 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyWdtG9y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A421218D84;
	Thu, 17 Oct 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190888; cv=none; b=rmqwnXggqckYNgrEXwP11iUX2O9I5r+9XkXKE3luNQ/aL0Q/gBkJ3tVY/h5jZYcg/qcpT1Fohv/gOuqNHre/lPHO3dP8QAAR+LcRTqzryoquJRNccTKh9NZPR0o1AsSsNkM11dqvCgZYvjIVdU/ZWFr+7T+byiLt8vbl8FvrhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190888; c=relaxed/simple;
	bh=R1fTXPYghBFCnLBr4a/59yh3e9rLOOUfHsrNYnRfLTU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Qt68WAAPeBToLlKAJfO+7pA9X10xDw2/g1ZpLFOeKGwOhQfPYQqfrlTfttOM1nXYkOhwkiMUysW+Sy0n7uUYzi27bDPdl56Xwjz9IRrG4GIm39fa5ws+qU+cnmJL6NoT12eWSBo2vBf/gJim6Ovm7TGNpAqenXCxwxLh0bnWYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyWdtG9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F434C4CEC3;
	Thu, 17 Oct 2024 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729190888;
	bh=R1fTXPYghBFCnLBr4a/59yh3e9rLOOUfHsrNYnRfLTU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=iyWdtG9yI152Swu9/jocY6+ckvgPlCxEdDk05qoPEyANqsMeWWQdCcVwX1PfFrsZN
	 LmJRjYPrCi7PLN7KrBm+S1Q2IpeqzrZ+RC9JniGo3qldqgkPT8s+BOQ4mopfwk9f5o
	 wIuCODdjMvtpLvMflaevug7UZ+RYWytPPq0nJW8eJY6BIeq/3/cxlRxSetRfLcOkRC
	 vWBJaeucJLgEDgb3zC2LteLJK6ssTvAO5apSbrYOvbB88JxgYzs/CTYdysW7rVdLmi
	 qFmYKU+ATv3CqLzLoSDq0WOmYaST+5NgECEGza7pbxzVAOkLReGMskYTrz24/wp0dr
	 LaX5Tdj6/YEcA==
Message-ID: <b3f8bf0e933064a49d1a5e3527646200.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241007-mbly-clk-v5-4-e9d8994269cb@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com> <20241007-mbly-clk-v5-4-e9d8994269cb@bootlin.com>
Subject: Re: [PATCH v5 4/4] clk: eyeq: add driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Thu, 17 Oct 2024 11:48:06 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-10-07 06:49:19)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 299bc678ed1b9fcd9110bb8c5937a1bd1ea60e23..ae7caa28985481ce7280421de=
7d3f2340f8f9ab3 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -226,6 +226,18 @@ config COMMON_CLK_EP93XX
>         help
>           This driver supports the SoC clocks on the Cirrus Logic ep93xx.
> =20
> +config COMMON_CLK_EYEQ
> +       bool "Clock driver for the Mobileye EyeQ platform"
> +       depends on 64BIT # for readq()

This makes my build test script blow up. Please just pick one or the
other header as you don't really care. I will apply something like this
patch either way.

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ae7caa289854..bb8f4fb5f996 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -228,7 +228,6 @@ config COMMON_CLK_EP93XX
=20
 config COMMON_CLK_EYEQ
 	bool "Clock driver for the Mobileye EyeQ platform"
-	depends on 64BIT # for readq()
 	depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
 	select AUXILIARY_BUS
 	default MACH_EYEQ5 || MACH_EYEQ6H
diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
index 762885333c03..2fd44e0d27f6 100644
--- a/drivers/clk/clk-eyeq.c
+++ b/drivers/clk/clk-eyeq.c
@@ -28,7 +28,9 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/list.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>

> diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..762885333c0336e9ff1162a36=
77f5fb815fd461a
> --- /dev/null
> +++ b/drivers/clk/clk-eyeq.c
> @@ -0,0 +1,779 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PLL clock driver for the Mobileye EyeQ5, EyeQ6L and EyeQ6H platforms.
> + *
> + * This controller handles read-only PLLs, all derived from the same main
> + * crystal clock. It also exposes divider clocks, those are children to =
PLLs.
> + * Parent clock is expected to be constant. This driver's registers live=
 in
> + * a shared region called OLB. Some PLLs are initialised early by of_clk=
_init().
> + *
> + * We use eqc_ as prefix, as-in "EyeQ Clock", but way shorter.
> + *
> + * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
> + */
> +
> +/*
> + * Set pr_fmt() for printing from eqc_early_init().
> + * It is called at of_clk_init() stage (read: really early).
> + */
> +#define pr_fmt(fmt) "clk-eyeq: " fmt
> +
> +#include <linux/array_size.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>

You need mod_devicetable.h as well for of_device_id.

> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
> +
> +#define EQC_MAX_DIV_COUNT              4
> +
> +/* In frac mode, it enables fractional noise canceling DAC. Else, no fun=
ction. */
> +#define PCSR0_DAC_EN                   BIT(0)
> +/* Fractional or integer mode */
[...]
> +
> +/* Required early for GIC timer (pll-cpu) and UARTs (pll-per). */
> +static const struct eqc_pll eqc_eyeq5_early_plls[] =3D {
> +       { .index =3D EQ5C_PLL_CPU, .name =3D "pll-cpu",  .reg64 =3D 0x02C=
 },
> +       { .index =3D EQ5C_PLL_PER, .name =3D "pll-per",  .reg64 =3D 0x05C=
 },
> +};
> +
> +static const struct eqc_early_match_data eqc_eyeq5_early_match_data __in=
itconst =3D {
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
data __initconst =3D {
> +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq6h_central_early_p=
lls),
> +       .early_plls             =3D eqc_eyeq6h_central_early_plls,
> +       .nb_late_clks =3D 0,
> +};
> +
> +/* Required early for UART. */

I still don't get this. UART isn't an early device. It's only the
interrupt controller and the timer that matter. Does MIPS do something
special for UARTs?

> +static const struct eqc_pll eqc_eyeq6h_west_early_plls[] =3D {
> +       { .index =3D 0, .name =3D "pll-west", .reg64 =3D 0x074 },
> +};

