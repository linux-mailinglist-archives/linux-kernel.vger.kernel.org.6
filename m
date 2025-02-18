Return-Path: <linux-kernel+bounces-520545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC782A3AB52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404613B01C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43AF1CEAC3;
	Tue, 18 Feb 2025 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwIUOicn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA4286297;
	Tue, 18 Feb 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915333; cv=none; b=EV1Fg7AJlr9XUXdpZ5gZATFiDhNGSoCljLOjeLeax/PF9P4a6sZTHqZyRXzFSVRAuU8vII1DOpdhgoVd8w3Y4TPnnml5NdjNynb5e0zE1px1SjlM2qo2lnD7HIQPF6nTfGXfzlG++DzVJAzxmA4zdVYvriijrvyIoBmbfb8Iixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915333; c=relaxed/simple;
	bh=EugGlGZoUobHeKUBAsM8drMUib4rXoqmiPsoweWnBbY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=AFEJtFOoRd/2aOSAQ0Ggdyth7M0iu6pWii9MckKm682QjKcVgQ7dGTlsVv15uJFvHy97uO7dhT59mFSBe97ar2HcriNhqJDlPUtD7ugR/33IQbrBY5j4qfbBddts2Xixj4RGe+GX7MN/KvxSOPDI2+rxNFD7G2GYMafnzx1poQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwIUOicn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948E3C4CEE6;
	Tue, 18 Feb 2025 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739915331;
	bh=EugGlGZoUobHeKUBAsM8drMUib4rXoqmiPsoweWnBbY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KwIUOicnjE0Obq5hrEnVu4qaIUR563RcxnFCroSSItwhdNgxQvQnzaxUhTN+lvW/k
	 8Ms8bxrb9uOdBN4AxbH9Pm8rry/7PQ4dNQXlK7v87Hq4Mrs7DvwyDTNJrCygBP8U91
	 6RzbfPWJa4GI5VcJbt8rK9jEM0YsV0N4tpN/Y4ZJOZG0eaAJmCSahHuUf7XwOOZOBz
	 4jYwwrFrnZA5I9TY1iz8vYhGApkqPh6E16O+mpzI4vQgWIU/Jo++But65cA101gOVD
	 +VwPMU0LKY6bZujc3p0ZsDhe2Xd9uZA4t3t8iTgGXXrY27EzzoBPCKk5tTDSlBXEgc
	 KrAb2S+Gt2aBA==
Message-ID: <3fb73691f50e599c361dddaff08d3af5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250217-b4-k230-clk-v4-2-5a95a3458691@zohomail.com>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com> <20250217-b4-k230-clk-v4-2-5a95a3458691@zohomail.com>
Subject: Re: [PATCH v4 2/3] clk: canaan: Add clock driver for Canaan K230
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>, Troy Mitchell <TroyMitchell988@gmail.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Xukai Wang <kingxukai@zohomail.com>
Date: Tue, 18 Feb 2025 13:48:49 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Xukai Wang (2025-02-17 06:45:17)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 299bc678ed1b9fcd9110bb8c5937a1bd1ea60e23..f63355ab8adeeee90d29d1a97=
5607f5dc0a58bd6 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -464,6 +464,12 @@ config COMMON_CLK_K210
>         help
>           Support for the Canaan Kendryte K210 RISC-V SoC clocks.
> =20
> +config COMMON_CLK_K230
> +       bool "Clock driver for the Canaan Kendryte K230 SoC"
> +       depends on OF && (ARCH_CANAAN || COMPILE_TEST)

It doesn't depend on OF to build from what I can tell. This should
simply be

	depends on ARCH_CANAAN || COMPILE_TEST

right?

> +        help
> +          Support for the Canaan Kendryte K230 RISC-V SoC clocks.
> +
>  config COMMON_CLK_SP7021
>         tristate "Clock driver for Sunplus SP7021 SoC"
>         depends on SOC_SP7021 || COMPILE_TEST
> diff --git a/drivers/clk/clk-k230.c b/drivers/clk/clk-k230.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..017ecad9ec47ed751f75fe519=
7aa119ae35e05f9
> --- /dev/null
> +++ b/drivers/clk/clk-k230.c
> @@ -0,0 +1,1347 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Kendryte Canaan K230 Clock Drivers
> + *
> + * Author: Xukai Wang <kingxukai@zohomail.com>
> + * Author: Troy Mitchell <troymitchell988@gmail.com>
> + */
> +
> +#include <dt-bindings/clock/canaan,k230-clk.h>

Please put dt-bindigns at the end of the include list.

> +#include <linux/clk.h>

Is this include used? Ideally a clk provider (clk-provider.h) isn't also
a clk consumer (clk.h).

> +#include <linux/clkdev.h>

Hopefully clkdev isn't used.

> +#include <linux/clk-provider.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>

Is this include used?

> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>

Need to include mod_devicetable.h

> +
> +/* PLL control register bits. */
> +#define K230_PLL_BYPASS_ENABLE                         BIT(19)
> +#define K230_PLL_GATE_ENABLE                           BIT(2)
> +#define K230_PLL_GATE_WRITE_ENABLE                     BIT(18)
> +#define K230_PLL_OD_SHIFT                              24
> +#define K230_PLL_OD_MASK                               0xF
> +#define K230_PLL_R_SHIFT                               16
> +#define K230_PLL_R_MASK                                        0x3F
> +#define K230_PLL_F_SHIFT                               0
> +#define K230_PLL_F_MASK                                        0x1FFFF
> +#define K230_PLL0_OFFSET_BASE                          0x00
> +#define K230_PLL1_OFFSET_BASE                          0x10
> +#define K230_PLL2_OFFSET_BASE                          0x20
> +#define K230_PLL3_OFFSET_BASE                          0x30
> +#define K230_PLL_DIV_REG_OFFSET                                0x00
> +#define K230_PLL_BYPASS_REG_OFFSET                     0x04
> +#define K230_PLL_GATE_REG_OFFSET                       0x08
> +#define K230_PLL_LOCK_REG_OFFSET                       0x0C
> +
> +/* PLL lock register bits.  */
> +#define K230_PLL_STATUS_MASK                           BIT(0)
> +
> +/* K230 CLK registers offset */
> +#define K230_CLK_AUDIO_CLKDIV_OFFSET                   0x34
> +#define K230_CLK_PDM_CLKDIV_OFFSET                     0x40
> +#define K230_CLK_CODEC_ADC_MCLKDIV_OFFSET              0x38
> +#define K230_CLK_CODEC_DAC_MCLKDIV_OFFSET              0x3c
> +
> +/* K230 CLK OPS. */
> +#define K230_CLK_OPS_GATE                              \
> +       .enable         =3D k230_clk_enable,              \
> +       .disable        =3D k230_clk_disable,             \
> +       .is_enabled     =3D k230_clk_is_enabled
> +
> +#define K230_CLK_OPS_RATE                              \
> +       .set_rate       =3D k230_clk_set_rate,            \
> +       .round_rate     =3D k230_clk_round_rate,          \
> +       .recalc_rate    =3D k230_clk_get_rate
> +
> +#define K230_CLK_OPS_MUX                               \
> +       .set_parent     =3D k230_clk_set_parent,          \
> +       .get_parent     =3D k230_clk_get_parent,          \
> +       .determine_rate =3D clk_hw_determine_rate_no_reparent
> +
> +#define K230_CLK_OPS_ID_NONE                           0
> +#define K230_CLK_OPS_ID_GATE_ONLY                      1
> +#define K230_CLK_OPS_ID_RATE_ONLY                      2
> +#define K230_CLK_OPS_ID_RATE_GATE                      3
> +#define K230_CLK_OPS_ID_MUX_ONLY                       4
> +#define K230_CLK_OPS_ID_MUX_GATE                       5
> +#define K230_CLK_OPS_ID_MUX_RATE                       6
> +#define K230_CLK_OPS_ID_ALL                            7
> +#define K230_CLK_OPS_ID_NUM                            8
> +
> +/* K230 CLK MACROS */
> +#define K230_CLK_MAX_PARENT_NUM                                6
> +
> +#define K230_GATE_FORMAT(_reg, _bit, _reverse, _have_gate)              =
       \
> +       .gate_reg_off =3D (_reg),                                        =
         \
> +       .gate_bit_enable =3D (_bit),                                     =
         \
> +       .gate_bit_reverse =3D (_reverse),                                =
         \
> +       .have_gate =3D (_have_gate)
> +
> +#define K230_RATE_FORMAT(_mul_min, _mul_max, _mul_shift, _mul_mask,     =
       \
> +                       _div_min, _div_max, _div_shift, _div_mask,       =
       \
> +                       _reg, _bit, _method, _reg_c, _bit_c,             =
       \
> +                       _mul_min_c, _mul_max_c, _mul_shift_c, _mul_mask_c=
,      \
> +                       _have_rate, _have_rate_c)                        =
       \
> +       .rate_mul_min =3D (_mul_min),                                    =
         \
> +       .rate_mul_max =3D (_mul_max),                                    =
         \
> +       .rate_mul_shift =3D (_mul_shift),                                =
         \
> +       .rate_mul_mask =3D (_mul_mask),                                  =
         \
> +       .rate_mul_min_c =3D (_mul_min_c),                                =
         \
> +       .rate_mul_max_c =3D (_mul_max_c),                                =
         \
> +       .rate_mul_shift_c =3D (_mul_shift_c),                            =
         \
> +       .rate_mul_mask_c =3D (_mul_mask_c),                              =
         \
> +       .rate_div_min =3D (_div_min),                                    =
         \
> +       .rate_div_max =3D (_div_max),                                    =
         \
> +       .rate_div_shift =3D (_div_shift),                                =
         \
> +       .rate_div_mask =3D (_div_mask),                                  =
         \
> +       .rate_reg_off =3D (_reg),                                        =
         \
> +       .rate_reg_off_c =3D (_reg_c),                                    =
         \
> +       .rate_write_enable_bit =3D (_bit),                               =
         \
> +       .rate_write_enable_bit_c =3D (_bit_c),                           =
         \
> +       .method =3D (_method),                                           =
         \
> +       .have_rate =3D (_have_rate),                                     =
         \
> +       .have_rate_c =3D (_have_rate_c)
> +
> +#define K230_MUX_FORMAT(_reg, _shift, _mask, _have_mux)                 =
               \
> +       .mux_reg_off =3D (_reg),                                         =
         \
> +       .mux_reg_shift =3D (_shift),                                     =
         \
> +       .mux_reg_mask =3D (_mask),                                       =
         \
> +       .have_mux =3D (_have_mux)
> +
> +#define K230_GATE_FORMAT_ZERO  K230_GATE_FORMAT(0, 0, 0, false)
> +#define K230_RATE_FORMAT_ZERO  K230_RATE_FORMAT(0, 0, 0, 0, 0, 0,       =
       \
> +                                               0, 0, 0, 0, 0, 0,        =
       \
> +                                               0, 0, 0, 0, 0, false, fal=
se)
> +#define K230_MUX_FORMAT_ZERO   K230_MUX_FORMAT(0, 0, 0, false)
> +
> +struct k230_sysclk;
> +
> +/* K230 PLLs. */
> +enum k230_pll_id {
> +       K230_PLL0, K230_PLL1, K230_PLL2, K230_PLL3, K230_PLL_NUM
> +};
> +
> +struct k230_pll {
> +       enum k230_pll_id id;
> +       struct k230_sysclk *ksc;
> +       void __iomem *div, *bypass, *gate, *lock;
> +       struct clk_hw hw;
> +};
> +
> +#define to_k230_pll(_hw)       container_of(_hw, struct k230_pll, hw)
> +
> +struct k230_pll_cfg {
> +       u32 reg;
> +       enum k230_pll_id pll_id;
> +       const char *name;
> +};
> +
> +/* K230 PLL_DIVS. */
> +struct k230_pll_div {
> +       struct k230_sysclk *ksc;
> +       struct clk_hw *hw;
> +};
> +
> +struct k230_pll_div_cfg {
> +       const char *parent_name, *name;
> +       int div;
> +};
> +
> +enum k230_pll_div_id {
> +       K230_PLL0_DIV2,
> +       K230_PLL0_DIV3,
> +       K230_PLL0_DIV4,
> +       K230_PLL1_DIV2,
> +       K230_PLL1_DIV3,
> +       K230_PLL1_DIV4,
> +       K230_PLL2_DIV2,
> +       K230_PLL2_DIV3,
> +       K230_PLL2_DIV4,
> +       K230_PLL3_DIV2,
> +       K230_PLL3_DIV3,
> +       K230_PLL3_DIV4,
> +       K230_PLL_DIV_NUM
> +};
> +
> +enum k230_clk_div_type {
> +       K230_MUL,
> +       K230_DIV,
> +       K230_MUL_DIV,
> +};
> +
> +/* K230 CLKS. */
> +struct k230_clk {
> +       int id;
> +       struct k230_sysclk *ksc;
> +       struct clk_hw hw;
> +};
> +
> +#define to_k230_clk(_hw)       container_of(_hw, struct k230_clk, hw)
> +
> +enum k230_clk_parent_type {
> +       K230_OSC24M,
> +       K230_PLL,
> +       K230_PLL_DIV,
> +       K230_CLK_COMPOSITE,
> +};
> +
> +struct k230_clk_parent {
> +       enum k230_clk_parent_type type;
> +       union {
> +               enum k230_pll_div_id pll_div_id;
> +               enum k230_pll_id pll_id;
> +               int clk_id;
> +       };
> +};
> +
> +struct k230_clk_cfg {
> +       /* attr */
> +       const char *name;
> +       /* 0-read & write; 1-read only */
> +       bool read_only;
> +       int num_parent;
> +       struct k230_clk_parent parent[K230_CLK_MAX_PARENT_NUM];
> +       bool status;
> +       int flags;
> +
> +       /* rate reg */
> +       u32 rate_reg_off;
> +       u32 rate_reg_off_c;
> +       void __iomem *rate_reg;
> +       void __iomem *rate_reg_c;
> +       /* rate info*/
> +       u32 rate_write_enable_bit;
> +       u32 rate_write_enable_bit_c;
> +       enum k230_clk_div_type method;
> +       bool have_rate;
> +       bool have_rate_c;
> +       /* rate mul */
> +       u32 rate_mul_min;
> +       u32 rate_mul_max;
> +       u32 rate_mul_shift;
> +       u32 rate_mul_mask;
> +       /* rate mul-changable */
> +       u32 rate_mul_min_c;
> +       u32 rate_mul_max_c;
> +       u32 rate_mul_shift_c;
> +       u32 rate_mul_mask_c;
> +       /* rate div */
> +       u32 rate_div_min;
> +       u32 rate_div_max;
> +       u32 rate_div_shift;
> +       u32 rate_div_mask;
> +
> +       /* gate reg */
> +       u32 gate_reg_off;
> +       void __iomem *gate_reg;
> +       /* gate info*/
> +       bool have_gate;
> +       u32 gate_bit_enable;
> +       u32 gate_bit_reverse;
> +
> +       /* mux reg */
> +       u32 mux_reg_off;
> +       void __iomem *mux_reg;
> +       /* mux info */
> +       bool have_mux;
> +       u32 mux_reg_shift;
> +       u32 mux_reg_mask;
> +};
> +
> +/* K230 SYSCLK. */
> +struct k230_sysclk {
> +       struct platform_device *pdev;
> +       void __iomem           *pll_regs, *regs;
> +       spinlock_t             pll_lock, clk_lock;
> +       struct k230_pll        *plls;
> +       struct k230_clk        *clks;
> +       struct k230_pll_div    *dclks;
> +};
> +
> +static const struct k230_pll_cfg k230_pll_cfgs[] =3D {
> +       [K230_PLL0] =3D {
> +               .reg =3D K230_PLL0_OFFSET_BASE,
> +               .pll_id =3D K230_PLL0,
> +               .name =3D "pll0",
> +       },
> +       [K230_PLL1] =3D {
> +               .reg =3D K230_PLL1_OFFSET_BASE,
> +               .pll_id =3D K230_PLL1,
> +               .name =3D "pll1",
> +       },
> +       [K230_PLL2] =3D {
> +               .reg =3D K230_PLL2_OFFSET_BASE,
> +               .pll_id =3D K230_PLL2,
> +               .name =3D "pll2",
> +       },
> +       [K230_PLL3] =3D {
> +               .reg =3D K230_PLL3_OFFSET_BASE,
> +               .pll_id =3D K230_PLL3,
> +               .name =3D "pll3",
> +       },
> +};
> +
> +static const struct k230_pll_div_cfg k230_pll_div_cfgs[] =3D {
> +       [K230_PLL0_DIV2] =3D { "pll0", "pll0_div2", 2},
> +       [K230_PLL0_DIV3] =3D { "pll0", "pll0_div3", 3},
> +       [K230_PLL0_DIV4] =3D { "pll0", "pll0_div4", 4},
> +       [K230_PLL1_DIV2] =3D { "pll1", "pll1_div2", 2},
> +       [K230_PLL1_DIV3] =3D { "pll1", "pll1_div3", 3},
> +       [K230_PLL1_DIV4] =3D { "pll1", "pll1_div4", 4},
> +       [K230_PLL2_DIV2] =3D { "pll2", "pll2_div2", 2},
> +       [K230_PLL2_DIV3] =3D { "pll2", "pll2_div3", 3},
> +       [K230_PLL2_DIV4] =3D { "pll2", "pll2_div4", 4},
> +       [K230_PLL3_DIV2] =3D { "pll3", "pll3_div2", 2},
> +       [K230_PLL3_DIV3] =3D { "pll3", "pll3_div3", 3},
> +       [K230_PLL3_DIV4] =3D { "pll3", "pll3_div4", 4},
> +};
> +
> +static struct k230_clk_cfg k230_clk_cfgs[] =3D {
> +       [K230_CPU0_SRC] =3D {

Can these be named variables instead of array elements? Then we can map
quickly to parents instead of going through an intermediate enum.

> +               .name =3D "cpu0_src",
> +               .read_only =3D false,
> +               .flags =3D 0,
> +               .status =3D true,
> +               .num_parent =3D 1,
> +               .parent[0] =3D {
> +                       .type =3D K230_PLL_DIV,
> +                       .pll_div_id =3D K230_PLL0_DIV2,
> +               },
> +               K230_RATE_FORMAT(1, 16, 0, 0,
> +                                16, 16, 1, 0xF,
> +                                0x0, 31, K230_MUL, 0, 0,
> +                                0, 0, 0, 0,
> +                                true, false),
> +               K230_GATE_FORMAT(0, 0, 0, true),
> +               K230_MUX_FORMAT_ZERO,
> +       },
> +       [K230_CPU0_ACLK] =3D {
> +               .name =3D "cpu0_aclk",
> +               .read_only =3D false,
> +               .flags =3D 0,
> +               .status =3D true,
> +               .num_parent =3D 1,
> +               .parent[0] =3D {
> +                       .type =3D K230_CLK_COMPOSITE,
> +                       .clk_id =3D K230_CPU0_SRC,
> +               },
> +               K230_RATE_FORMAT(1, 1, 0, 0,
> +                                1, 8, 7, 0x7,
> +                                0x0, 31, K230_MUL, 0, 0,
> +                                0, 0, 0, 0,
> +                                true, false),
> +               K230_GATE_FORMAT_ZERO,
> +               K230_MUX_FORMAT_ZERO,
> +       },
> +       [K230_CPU0_PLIC] =3D {
> +               .name =3D "cpu0_plic",
> +               .read_only =3D false,
> +               .flags =3D 0,
> +               .status =3D true,
> +               .num_parent =3D 1,
> +               .parent[0] =3D {
> +                       .type =3D K230_CLK_COMPOSITE,
> +                       .clk_id =3D K230_CPU0_SRC,
> +               },
> +               K230_RATE_FORMAT(1, 1, 0, 0,
> +                                1, 8, 10, 0x7,
> +                                0x0, 31, K230_DIV, 0, 0,
> +                                0, 0, 0, 0,
> +                                true, false),
> +               K230_GATE_FORMAT(0, 9, 0, true),
> +               K230_MUX_FORMAT_ZERO,
> +       },
> +       [K230_CPU0_NOC_DDRCP4] =3D {
> +               .name =3D "cpu0_noc_ddrcp4",
> +               .read_only =3D false,
> +               .flags =3D 0,
> +               .status =3D true,
> +               .num_parent =3D 1,
> +               .parent[0] =3D {
> +                       .type =3D K230_CLK_COMPOSITE,
> +                       .clk_id =3D K230_CPU0_SRC,
> +               },
> +               K230_RATE_FORMAT_ZERO,
> +               K230_GATE_FORMAT(0x60, 7, 0, true),
> +               K230_MUX_FORMAT_ZERO,
> +       },
> +       [K230_CPU0_PCLK] =3D {
> +               .name =3D "cpu0_pclk",
> +               .read_only =3D false,
> +               .flags =3D 0,
> +               .status =3D true,
> +               .num_parent =3D 1,
> +               .parent[0] =3D {
> +                       .type =3D K230_PLL_DIV,
> +                       .pll_div_id =3D K230_PLL0_DIV4,
> +               },
> +               K230_RATE_FORMAT(1, 1, 0, 0,
> +                                1, 8, 15, 0x7,
> +                                0x0, 31, K230_DIV, 0, 0,
> +                                0, 0, 0, 0,
> +                                true, false),
> +               K230_GATE_FORMAT(0, 13, 0, true),
> +               K230_MUX_FORMAT_ZERO,
> +       },
> +       [K230_PMU_PCLK] =3D {
> +               .name =3D "pmu_pclk",
> +               .read_only =3D false,
> +               .flags =3D 0,
> +               .status =3D true,
> +               .num_parent =3D 1,
> +               .parent[0] =3D {
> +                       .type =3D K230_OSC24M,
> +               },
> +               K230_RATE_FORMAT_ZERO,
> +               K230_GATE_FORMAT(0x10, 0, 0, true),
> +               K230_MUX_FORMAT_ZERO,
> +       },
> +       [K230_HS_OSPI_SRC] =3D {
> +               .name =3D "hs_ospi_src",
> +               .read_only =3D false,
> +               .flags =3D 0,
> +               .status =3D true,
> +               .num_parent =3D 2,
> +               .parent[0] =3D {
> +                       .type =3D K230_PLL_DIV,
> +                       .pll_div_id =3D K230_PLL0_DIV2,
> +               },
> +               .parent[1] =3D {
> +                       .type =3D K230_PLL_DIV,
> +                       .pll_div_id =3D K230_PLL2_DIV4,
> +               },
> +               K230_RATE_FORMAT_ZERO,
> +               K230_GATE_FORMAT(0x18, 24, 0, true),
> +               K230_MUX_FORMAT(0x20, 18, 0x1, true),
> +       },
> +};
> +
> +#define K230_CLK_NUM   ARRAY_SIZE(k230_clk_cfgs)
> +
> +static void k230_init_pll(void __iomem *regs, enum k230_pll_id pll_id,
> +                         struct k230_pll *pll)
> +{
> +       void __iomem *base;
> +
> +       pll->id =3D pll_id;
> +       base =3D regs + k230_pll_cfgs[pll_id].reg;
> +       pll->div =3D base + K230_PLL_DIV_REG_OFFSET;
> +       pll->bypass =3D base + K230_PLL_BYPASS_REG_OFFSET;
> +       pll->gate =3D base + K230_PLL_GATE_REG_OFFSET;
> +       pll->lock =3D base + K230_PLL_LOCK_REG_OFFSET;
> +}
> +
> +static int k230_pll_prepare(struct clk_hw *hw)
> +{
> +       struct k230_pll *pll =3D to_k230_pll(hw);
> +       u32 reg;
> +
> +       /* wait for PLL lock until it reachs lock status */

s/reachs/reaches/

> +       return readl_poll_timeout(pll->lock, reg,
> +                                 (reg & K230_PLL_STATUS_MASK) =3D=3D K23=
0_PLL_STATUS_MASK,
> +                                 400, 0);
> +}
> +
> +static bool k230_pll_hw_is_enabled(struct k230_pll *pll)
> +{
> +       return (readl(pll->gate) & K230_PLL_GATE_ENABLE) =3D=3D K230_PLL_=
GATE_ENABLE;
> +}
> +
> +static void k230_pll_enable_hw(void __iomem *regs, struct k230_pll *pll)
> +{
> +       u32 reg;
> +
> +       if (k230_pll_hw_is_enabled(pll))
> +               return;
> +
> +       /* Set PLL factors */
> +       reg =3D readl(pll->gate);
> +       reg |=3D (K230_PLL_GATE_ENABLE | K230_PLL_GATE_WRITE_ENABLE);
> +       writel(reg, pll->gate);
> +}
> +
> +static int k230_pll_enable(struct clk_hw *hw)
> +{
> +       struct k230_pll *pll =3D to_k230_pll(hw);
> +       struct k230_sysclk *ksc =3D pll->ksc;
> +
> +       guard(spinlock)(&ksc->pll_lock);
> +       k230_pll_enable_hw(ksc->regs, pll);
> +
> +       return 0;
> +}
> +
> +static void k230_pll_disable(struct clk_hw *hw)
> +{
> +       struct k230_pll *pll =3D to_k230_pll(hw);
> +       struct k230_sysclk *ksc =3D pll->ksc;
> +       u32 reg;
> +
> +       guard(spinlock)(&ksc->pll_lock);
> +       reg =3D readl(pll->gate);
> +
> +       reg &=3D ~(K230_PLL_GATE_ENABLE);
> +       reg |=3D (K230_PLL_GATE_WRITE_ENABLE);
> +
> +       writel(reg, pll->gate);
> +}
> +
> +static int k230_pll_is_enabled(struct clk_hw *hw)
> +{
> +       return k230_pll_hw_is_enabled(to_k230_pll(hw));
> +}
> +
> +static int k230_pll_init(struct clk_hw *hw)
> +{
> +       if (k230_pll_is_enabled(hw))
> +               return clk_prepare_enable(hw->clk);

Is this CLK_IS_CRITICAL?

> +
> +       return 0;
> +}
> +
> +static unsigned long k230_pll_get_rate(struct clk_hw *hw, unsigned long =
parent_rate)
> +{
> +       struct k230_pll *pll =3D to_k230_pll(hw);
> +       struct k230_sysclk *ksc =3D pll->ksc;
> +       u32 reg;
> +       u32 r, f, od;
> +
> +       reg =3D readl(pll->bypass);
> +       if (reg & K230_PLL_BYPASS_ENABLE)
> +               return parent_rate;
> +
> +       reg =3D readl(pll->lock);
> +       if (!(reg & (K230_PLL_STATUS_MASK))) { /* unlocked */
> +               dev_err(&ksc->pdev->dev, "%s is unlock.\n", clk_hw_get_na=
me(hw));
> +               return 0;
> +       }
> +
> +       reg =3D readl(pll->div);
> +       r =3D ((reg >> K230_PLL_R_SHIFT) & K230_PLL_R_MASK) + 1;
> +       f =3D ((reg >> K230_PLL_F_SHIFT) & K230_PLL_F_MASK) + 1;
> +       od =3D ((reg >> K230_PLL_OD_SHIFT) & K230_PLL_OD_MASK) + 1;
> +
> +       return div_u64((u64)parent_rate * f, r * od);

Is this mul_u64_u32_div()?

> +}
> +
> +static const struct clk_ops k230_pll_ops =3D {
> +       .init           =3D k230_pll_init,
> +       .prepare        =3D k230_pll_prepare,
> +       .enable         =3D k230_pll_enable,
> +       .disable        =3D k230_pll_disable,
> +       .is_enabled     =3D k230_pll_is_enabled,
> +       .recalc_rate    =3D k230_pll_get_rate,
> +};
> +
> +static int k230_register_pll(struct platform_device *pdev,
> +                            struct k230_sysclk *ksc,
> +                            enum k230_pll_id pll_id,
> +                            const char *name,
> +                            int num_parents,
> +                            const struct clk_ops *ops)
> +{
> +       struct k230_pll *pll =3D &ksc->plls[pll_id];
> +       struct clk_init_data init =3D {};
> +       struct device *dev =3D &pdev->dev;
> +       int ret;
> +       const struct clk_parent_data parent_data[] =3D {
> +               { .index =3D 0, },
> +       };
> +
> +       init.name =3D name;
> +       init.parent_data =3D parent_data;
> +       init.num_parents =3D num_parents;
> +       init.ops =3D ops;
> +
> +       pll->hw.init =3D &init;
> +       pll->ksc =3D ksc;
> +
> +       ret =3D devm_clk_hw_register(dev, &pll->hw);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to register pll");

Missing newline on printk.

> +
> +       return 0;
> +}
> +
> +static int k230_register_plls(struct platform_device *pdev, struct k230_=
sysclk *ksc)
> +{
> +       int i, ret;
> +       const struct k230_pll_cfg *cfg;
> +
> +       for (i =3D 0; i < K230_PLL_NUM; i++) {
> +               cfg =3D &k230_pll_cfgs[i];
> +
> +               k230_init_pll(ksc->pll_regs, i, &ksc->plls[i]);
> +
> +               ret =3D k230_register_pll(pdev, ksc, cfg->pll_id, cfg->na=
me, 1,
> +                                       &k230_pll_ops);
> +               if (ret)
> +                       return dev_err_probe(&pdev->dev, ret,
> +                                            "register %s failed\n", cfg-=
>name);
> +       }
> +
> +       return 0;
> +}
> +
> +static int k230_register_pll_divs(struct platform_device *pdev, struct k=
230_sysclk *ksc)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct clk_hw *hw;
> +
> +       for (int i =3D 0; i < K230_PLL_DIV_NUM; i++) {
> +               hw =3D devm_clk_hw_register_fixed_factor(dev, k230_pll_di=
v_cfgs[i].name,
> +                                                      k230_pll_div_cfgs[=
i].parent_name,
> +                                                      0, 1, k230_pll_div=
_cfgs[i].div);
> +               if (IS_ERR(hw))
> +                       return PTR_ERR(hw);
> +               ksc->dclks[i].hw =3D hw;
> +               ksc->dclks[i].ksc =3D ksc;
> +       }
> +
> +       return 0;
> +}
> +
> +static int k230_clk_enable(struct clk_hw *hw)
> +{
> +       struct k230_clk *clk =3D to_k230_clk(hw);
> +       struct k230_sysclk *ksc =3D clk->ksc;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +       u32 reg;
> +
> +       if (!cfg->have_gate)
> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This cloc=
k doesn't have gate\n");
> +
> +       guard(spinlock)(&ksc->clk_lock);
> +       reg =3D readl(cfg->gate_reg);
> +       if (cfg->gate_bit_reverse)
> +               reg &=3D ~BIT(cfg->gate_bit_enable);
> +       else
> +               reg |=3D BIT(cfg->gate_bit_enable);
> +       writel(reg, cfg->gate_reg);
> +
> +       return 0;
> +}
> +
> +static void k230_clk_disable(struct clk_hw *hw)
> +{
> +       struct k230_clk *clk =3D to_k230_clk(hw);
> +       struct k230_sysclk *ksc =3D clk->ksc;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +       u32 reg;
> +
> +       if (!cfg->have_gate) {
> +               dev_err(&ksc->pdev->dev, "This clock doesn't have gate\n"=
);

Why are the clk_ops assigned to this clk then?

> +               return;
> +       }
> +
> +       guard(spinlock)(&ksc->clk_lock);
> +       reg =3D readl(cfg->gate_reg);
> +
> +       if (cfg->gate_bit_reverse)
> +               reg |=3D BIT(cfg->gate_bit_enable);
> +       else
> +               reg &=3D ~BIT(cfg->gate_bit_enable);
> +
> +       writel(reg, cfg->gate_reg);
> +}
> +
> +static int k230_clk_is_enabled(struct clk_hw *hw)
> +{
> +       struct k230_clk *clk =3D to_k230_clk(hw);
> +       struct k230_sysclk *ksc =3D clk->ksc;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +       u32 reg;
> +
> +       if (!cfg->have_gate)
> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This cloc=
k doesn't have gate\n");

Why are the clk_ops assigned to this clk then? Don't use
dev_err_probe() here.

> +
> +       guard(spinlock)(&ksc->clk_lock);
> +       reg =3D readl(cfg->gate_reg);
> +
> +       /* Check gate bit condition based on configuration and then set r=
et */
> +       if (cfg->gate_bit_reverse)
> +               return (BIT(cfg->gate_bit_enable) & reg) ? 1 : 0;
> +       else
> +               return (BIT(cfg->gate_bit_enable) & ~reg) ? 1 : 0;
> +}
> +
> +static int k230_clk_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct k230_clk *clk =3D to_k230_clk(hw);
> +       struct k230_sysclk *ksc =3D clk->ksc;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +       u8 reg;
> +
> +       if (!cfg->have_mux)
> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This cloc=
k doesn't have mux\n");

Why are the clk_ops assigned to this clk then? Don't use
dev_err_probe() here.

> +
> +       guard(spinlock)(&ksc->clk_lock);
> +       reg =3D (cfg->mux_reg_mask & index) << cfg->mux_reg_shift;
> +       writeb(reg, cfg->mux_reg);
> +
> +       return 0;
> +}
> +
> +static u8 k230_clk_get_parent(struct clk_hw *hw)
> +{
> +       struct k230_clk *clk =3D to_k230_clk(hw);
> +       struct k230_sysclk *ksc =3D clk->ksc;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +       u8 reg;
> +
> +       if (!cfg->have_mux)
> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This cloc=
k doesn't have mux\n");

All these checks should go away and we should have different clk_ops for
different clk types.

> +
> +       guard(spinlock)(&ksc->clk_lock);
> +       reg =3D readb(cfg->mux_reg);
> +
> +       return reg;
> +}
> +
> +static unsigned long k230_clk_get_rate(struct clk_hw *hw,
> +                                      unsigned long parent_rate)
> +{
> +       struct k230_clk *clk =3D to_k230_clk(hw);
> +       struct k230_sysclk *ksc =3D clk->ksc;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +       u32 mul, div;
> +
> +       if (!cfg->have_rate) /* no divider, return parents' clk */
> +               return parent_rate;
> +
> +       guard(spinlock)(&ksc->clk_lock);
> +       switch (cfg->method) {
> +       /*
> +        * K230_MUL: div_mask+1/div_max...
> +        * K230_DIV: mul_max/div_mask+1
> +        * K230_MUL_DIV: mul_mask/div_mask...
> +        */
> +       case K230_MUL:
> +               div =3D cfg->rate_div_max;
> +               mul =3D (readl(cfg->rate_reg) >> cfg->rate_div_shift)
> +                       & cfg->rate_div_mask;
> +               mul++;
> +               break;
> +       case K230_DIV:
> +               mul =3D cfg->rate_mul_max;
> +               div =3D (readl(cfg->rate_reg) >> cfg->rate_div_shift)
> +                       & cfg->rate_div_mask;
> +               div++;
> +               break;
> +       case K230_MUL_DIV:
> +               if (!cfg->have_rate_c) {
> +                       mul =3D (readl(cfg->rate_reg) >> cfg->rate_mul_sh=
ift)
> +                               & cfg->rate_mul_mask;
> +                       div =3D (readl(cfg->rate_reg) >> cfg->rate_div_sh=
ift)
> +                               & cfg->rate_div_mask;
> +               } else {
> +                       mul =3D (readl(cfg->rate_reg_c) >> cfg->rate_mul_=
shift_c)
> +                               & cfg->rate_mul_mask_c;
> +                       div =3D (readl(cfg->rate_reg_c) >> cfg->rate_div_=
shift)
> +                               & cfg->rate_div_mask;
> +               }
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       return div_u64((u64)parent_rate * mul, div);
> +}
> +
> +static int k230_clk_find_approximate(struct k230_clk *clk,
> +                                    u32 mul_min,
> +                                    u32 mul_max,
> +                                    u32 div_min,
> +                                    u32 div_max,
> +                                    enum k230_clk_div_type method,
> +                                    unsigned long rate,
> +                                    unsigned long parent_rate,
> +                                    u32 *div,
> +                                    u32 *mul)
> +{
> +       long abs_min;
> +       long abs_current;
> +       long perfect_divide;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +
> +       const u32 codec_clk[9] =3D {
> +               2048000,
> +               3072000,
> +               4096000,
> +               6144000,
> +               8192000,
> +               11289600,
> +               12288000,
> +               24576000,
> +               49152000
> +       };
> +
> +       const u32 codec_div[9][2] =3D {
> +               {3125, 16},
> +               {3125, 24},
> +               {3125, 32},
> +               {3125, 48},
> +               {3125, 64},
> +               {15625, 441},
> +               {3125, 96},
> +               {3125, 192},
> +               {3125, 384}
> +       };
> +
> +       const u32 pdm_clk[20] =3D {
> +               128000,
> +               192000,
> +               256000,
> +               384000,
> +               512000,
> +               768000,
> +               1024000,
> +               1411200,
> +               1536000,
> +               2048000,
> +               2822400,
> +               3072000,
> +               4096000,
> +               5644800,
> +               6144000,
> +               8192000,
> +               11289600,
> +               12288000,
> +               24576000,
> +               49152000
> +       };
> +
> +       const u32 pdm_div[20][2] =3D {
> +               {3125, 1},
> +               {6250, 3},
> +               {3125, 2},
> +               {3125, 3},
> +               {3125, 4},
> +               {3125, 6},
> +               {3125, 8},
> +               {125000, 441},
> +               {3125, 12},
> +               {3125, 16},
> +               {62500, 441},
> +               {3125, 24},
> +               {3125, 32},
> +               {31250, 441},
> +               {3125, 48},
> +               {3125, 64},
> +               {15625, 441},
> +               {3125, 96},
> +               {3125, 192},
> +               {3125, 384}
> +       };
> +
> +       switch (method) {
> +       /* only mul can be changeable 1/12,2/12,3/12...*/
> +       case K230_MUL:
> +               perfect_divide =3D (long)((parent_rate * 1000) / rate);
> +               abs_min =3D abs(perfect_divide -
> +                            (long)(((long)div_max * 1000) / (long)mul_mi=
n));
> +               *mul =3D mul_min;
> +
> +               for (u32 i =3D mul_min + 1; i <=3D mul_max; i++) {
> +                       abs_current =3D abs(perfect_divide -
> +                                       (long)((long)((long)div_max * 100=
0) / (long)i));
> +                       if (abs_min > abs_current) {
> +                               abs_min =3D abs_current;
> +                               *mul =3D i;
> +                       }
> +               }
> +
> +               *div =3D div_max;
> +               break;
> +       /* only div can be changeable, 1/1,1/2,1/3...*/
> +       case K230_DIV:
> +               perfect_divide =3D (long)((parent_rate * 1000) / rate);
> +               abs_min =3D abs(perfect_divide -
> +                            (long)(((long)div_min * 1000) / (long)mul_ma=
x));
> +               *div =3D div_min;
> +
> +               for (u32 i =3D div_min + 1; i <=3D div_max; i++) {
> +                       abs_current =3D abs(perfect_divide -
> +                                        (long)((long)((long)i * 1000) / =
(long)mul_max));
> +                       if (abs_min > abs_current) {
> +                               abs_min =3D abs_current;
> +                               *div =3D i;
> +                       }
> +               }
> +
> +               *mul =3D mul_max;
> +               break;
> +       /* mul and div can be changeable. */
> +       case K230_MUL_DIV:
> +               if (cfg->rate_reg_off =3D=3D K230_CLK_CODEC_ADC_MCLKDIV_O=
FFSET ||
> +                   cfg->rate_reg_off =3D=3D K230_CLK_CODEC_DAC_MCLKDIV_O=
FFSET) {
> +                       for (u32 j =3D 0; j < 9; j++) {
> +                               if (0 =3D=3D (rate - codec_clk[j])) {
> +                                       *div =3D codec_div[j][0];
> +                                       *mul =3D codec_div[j][1];
> +                               }
> +                       }
> +               } else if (cfg->rate_reg_off =3D=3D K230_CLK_AUDIO_CLKDIV=
_OFFSET ||
> +                          cfg->rate_reg_off =3D=3D K230_CLK_PDM_CLKDIV_O=
FFSET) {
> +                       for (u32 j =3D 0; j < 20; j++) {
> +                               if (0 =3D=3D (rate - pdm_clk[j])) {
> +                                       *div =3D pdm_div[j][0];
> +                                       *mul =3D pdm_div[j][1];
> +                               }
> +                       }
> +               } else {
> +                       return -EINVAL;
> +               }
> +               break;
> +       default:
> +               WARN_ON_ONCE(true);
> +               return -EPERM;

This is impossible? Remove the default case and the compiler will warn
if an enum case is missing.

> +       }
> +       return 0;
> +}
> +
> +static long k230_clk_round_rate(struct clk_hw *hw, unsigned long rate, u=
nsigned long *parent_rate)
> +{
> +       struct k230_clk *clk =3D to_k230_clk(hw);
> +       struct k230_sysclk *ksc =3D clk->ksc;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +       u32 div =3D 0, mul =3D 0;
> +
> +       if (k230_clk_find_approximate(clk,
> +                                     cfg->rate_mul_min, cfg->rate_mul_ma=
x,
> +                                     cfg->rate_div_min, cfg->rate_div_ma=
x,
> +                                     cfg->method, rate, *parent_rate, &d=
iv, &mul)) {
> +               dev_err(&ksc->pdev->dev,
> +                       "[%s]: clk %s round rate error!\n",
> +                       __func__,
> +                       clk_hw_get_name(hw));
> +               return 0;

Why isn't an error returned?

> +       }
> +
> +       return div_u64((u64)(*parent_rate) * mul, div);
> +}
> +
> +static int k230_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                            unsigned long parent_rate)
> +{
> +       struct k230_clk *clk =3D to_k230_clk(hw);
> +       struct k230_sysclk *ksc =3D clk->ksc;
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[clk->id];
> +       u32 div =3D 0, mul =3D 0, reg =3D 0, reg_c;
> +
> +       if (!cfg->have_rate || !cfg->rate_reg)
> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This cloc=
k may have no rate\n");
> +
> +       if (rate > parent_rate || rate =3D=3D 0 || parent_rate =3D=3D 0)
> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "rate or p=
arent_rate error\n");
> +
> +       if (cfg->read_only)
> +               return dev_err_probe(&ksc->pdev->dev, -EPERM, "This clk r=
ate is read only\n");
> +
> +       if (k230_clk_find_approximate(clk,
> +                                     cfg->rate_mul_min, cfg->rate_mul_ma=
x,
> +                                     cfg->rate_div_min, cfg->rate_div_ma=
x,
> +                                     cfg->method, rate, parent_rate, &di=
v, &mul))
> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "[%s]: clk=
 %s set rate error!\n",
> +                                    __func__, clk_hw_get_name(hw));
> +
> +       guard(spinlock)(&ksc->clk_lock);
> +       if (!cfg->have_rate_c) {
> +               reg =3D readl(cfg->rate_reg);
> +               reg &=3D ~((cfg->rate_div_mask) << (cfg->rate_div_shift));
> +
> +               if (cfg->method =3D=3D K230_DIV) {
> +                       reg &=3D ~((cfg->rate_mul_mask) << (cfg->rate_mul=
_shift));
> +                       reg |=3D ((div - 1) & cfg->rate_div_mask) << (cfg=
->rate_div_shift);
> +               } else if (cfg->method =3D=3D K230_MUL) {
> +                       reg |=3D ((mul - 1) & cfg->rate_div_mask) << (cfg=
->rate_div_shift);
> +               } else {
> +                       reg |=3D (mul & cfg->rate_mul_mask) << (cfg->rate=
_mul_shift);
> +                       reg |=3D (div & cfg->rate_div_mask) << (cfg->rate=
_div_shift);
> +               }
> +               reg |=3D BIT(cfg->rate_write_enable_bit);
> +       } else {
> +               reg =3D readl(cfg->rate_reg);
> +               reg_c =3D readl(cfg->rate_reg_c);
> +               reg &=3D ~((cfg->rate_div_mask) << (cfg->rate_div_shift));
> +               reg_c &=3D ~((cfg->rate_mul_mask_c) << (cfg->rate_mul_shi=
ft_c));
> +               reg_c |=3D BIT(cfg->rate_write_enable_bit_c);
> +
> +               reg_c |=3D (mul & cfg->rate_mul_mask_c) << (cfg->rate_mul=
_shift_c);
> +               reg |=3D (div & cfg->rate_div_mask) << (cfg->rate_div_shi=
ft);
> +
> +               writel(reg_c, cfg->rate_reg_c);
> +       }
> +       writel(reg, cfg->rate_reg);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops k230_clk_ops_arr[K230_CLK_OPS_ID_NUM] =3D {
> +       [K230_CLK_OPS_ID_NONE] =3D {
> +               /* Sentinel */
> +       },
> +       [K230_CLK_OPS_ID_GATE_ONLY] =3D {
> +               K230_CLK_OPS_GATE,
> +       },
> +       [K230_CLK_OPS_ID_RATE_ONLY] =3D {
> +               K230_CLK_OPS_RATE,
> +       },
> +       [K230_CLK_OPS_ID_RATE_GATE] =3D {
> +               K230_CLK_OPS_RATE,
> +               K230_CLK_OPS_GATE,
> +       },
> +       [K230_CLK_OPS_ID_MUX_ONLY] =3D {
> +               K230_CLK_OPS_MUX,
> +       },
> +       [K230_CLK_OPS_ID_MUX_GATE] =3D {
> +               K230_CLK_OPS_MUX,
> +               K230_CLK_OPS_GATE,
> +       },
> +       [K230_CLK_OPS_ID_MUX_RATE] =3D {
> +               K230_CLK_OPS_MUX,
> +               K230_CLK_OPS_RATE,
> +       },
> +       [K230_CLK_OPS_ID_ALL] =3D {
> +               K230_CLK_OPS_MUX,
> +               K230_CLK_OPS_RATE,
> +               K230_CLK_OPS_GATE,
> +       },
> +};
> +
> +static int k230_register_clk(struct platform_device *pdev,
> +                            struct k230_sysclk *ksc,
> +                            int id,
> +                            const struct clk_parent_data *parent_data,
> +                            u8 num_parents,
> +                            unsigned long flags)
> +{
> +       struct k230_clk *clk =3D &ksc->clks[id];
> +       struct k230_clk_cfg *cfg =3D &k230_clk_cfgs[id];
> +       struct clk_init_data init =3D {};
> +       int clk_id =3D 0;
> +       int ret;
> +
> +       if (cfg->have_rate) {
> +               cfg->rate_reg =3D (ksc->regs + cfg->rate_reg_off);

Drop useless parenthesis please.

> +               clk_id +=3D K230_CLK_OPS_ID_RATE_ONLY;
> +       }
> +
> +       if (cfg->have_mux) {
> +               cfg->mux_reg =3D (ksc->regs + cfg->mux_reg_off);
> +               clk_id +=3D K230_CLK_OPS_ID_MUX_ONLY;
> +
> +               /* mux clock doesn't match the case that num_parents less=
 than 2 */
> +               if (num_parents < 2)
> +                       return -EINVAL;
> +       }
> +
> +       if (cfg->have_gate) {
> +               cfg->gate_reg =3D (ksc->regs + cfg->gate_reg_off);

Drop useless parenthesis please.

> +               clk_id +=3D K230_CLK_OPS_ID_GATE_ONLY;
> +       }
> +
> +       if (cfg->have_rate_c)
> +               cfg->rate_reg_c =3D (ksc->regs + cfg->rate_reg_off_c);

Drop useless parenthesis please.

> +
> +       init.name =3D k230_clk_cfgs[id].name;
> +       init.flags =3D flags;
> +       init.parent_data =3D parent_data;
> +       init.num_parents =3D num_parents;
> +       init.ops =3D &k230_clk_ops_arr[clk_id];
> +
> +       clk->id =3D id;
> +       clk->ksc =3D ksc;
> +       clk->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(&pdev->dev, &clk->hw);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev,
> +                                    ret,
> +                                    "register clock %s failed\n",
> +                                    k230_clk_cfgs[id].name);
> +
> +       return 0;
> +}
> +
> +static int k230_register_mux_clk(struct platform_device *pdev,
> +                                struct k230_sysclk *ksc,
> +                                struct clk_parent_data *parent_data,
> +                                int num_parent,
> +                                int id)
> +{
> +       return k230_register_clk(pdev, ksc, id,
> +                               (const struct clk_parent_data *)parent_da=
ta,

Please remove useless cast.

> +                               num_parent, 0);
> +}
> +
> +static int k230_register_osc24m_child(struct platform_device *pdev,
> +                                     struct k230_sysclk *ksc,
> +                                     int id)
> +{
> +       const struct clk_parent_data parent_data =3D {
> +               .index =3D 0,
> +       };
> +       return k230_register_clk(pdev, ksc, id, &parent_data, 1, 0);
> +}
> +
> +static int k230_register_pll_child(struct platform_device *pdev,
> +                                  struct k230_sysclk *ksc,
> +                                  int id,
> +                                  enum k230_pll_id pll_id,
> +                                  unsigned long flags)
> +{
> +       const struct clk_parent_data parent_data =3D {
> +               .hw =3D &ksc->plls[pll_id].hw,
> +       };
> +       return k230_register_clk(pdev, ksc, id, &parent_data, 1, flags);
> +}
> +
> +static int k230_register_pll_div_child(struct platform_device *pdev,
> +                                      struct k230_sysclk *ksc,
> +                                      int id,
> +                                      enum k230_pll_div_id pll_div_id,
> +                                      unsigned long flags)
> +{
> +       const struct clk_parent_data parent_data =3D {
> +               .hw =3D ksc->dclks[pll_div_id].hw,
> +       };
> +       return k230_register_clk(pdev, ksc, id, &parent_data, 1, flags);
> +}
> +
> +static int k230_register_clk_child(struct platform_device *pdev,
> +                                  struct k230_sysclk *ksc,
> +                                  int id,
> +                                  int parent_id)
> +{
> +       const struct clk_parent_data parent_data =3D {
> +               .hw =3D &ksc->clks[parent_id].hw,
> +       };
> +       return k230_register_clk(pdev, ksc, id, &parent_data, 1, 0);
> +}
> +
> +static int _k230_clk_mux_get_parent_data(struct k230_sysclk *ksc,
> +                                        struct k230_clk_parent *pclk,
> +                                        struct clk_parent_data *parent_d=
ata)
> +{
> +       switch (pclk->type) {
> +       case K230_OSC24M:
> +               parent_data->index =3D 0;
> +               break;
> +       case K230_PLL:
> +               parent_data->hw =3D &ksc->plls[pclk->pll_id].hw;
> +               break;
> +       case K230_PLL_DIV:
> +               parent_data->hw =3D ksc->dclks[pclk->pll_div_id].hw;
> +               break;
> +       case K230_CLK_COMPOSITE:
> +               parent_data->hw =3D &ksc->clks[pclk->clk_id].hw;
> +               break;
> +       default:
> +               WARN_ON_ONCE(true);
> +               return -EPERM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int k230_clk_mux_get_parent_data(struct k230_sysclk *ksc,
> +                                       struct k230_clk_cfg *cfg,
> +                                       struct clk_parent_data *parent_da=
ta,
> +                                       int num_parent)
> +{
> +       int ret;
> +       struct k230_clk_parent *pclk =3D cfg->parent;
> +
> +       for (int i =3D 0; i < num_parent; i++) {
> +               ret =3D _k230_clk_mux_get_parent_data(ksc, &pclk[i], &par=
ent_data[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int k230_register_clks(struct platform_device *pdev, struct k230_=
sysclk *ksc)
> +{
> +       struct k230_clk_cfg *cfg;
> +       struct k230_clk_parent *pclk;
> +       struct clk_parent_data parent_data[K230_CLK_MAX_PARENT_NUM];
> +       int ret, i;
> +
> +       /*
> +        *  Single parent clock:
> +        *  pll0_div2 sons: cpu0_src
> +        *  pll0_div4 sons: cpu0_pclk
> +        *  cpu0_src sons: cpu0_aclk, cpu0_plic, cpu0_noc_ddrcp4, pmu_pclk
> +        *
> +        *  Mux clock:
> +        *  hs_ospi_src parents: pll0_div2, pll2_div4
> +        */
> +       for (i =3D 0; i < K230_CLK_NUM; i++) {
> +               cfg =3D &k230_clk_cfgs[i];
> +               if (!cfg->status)
> +                       continue;
> +
> +               if (cfg->have_mux) {
> +                       ret =3D k230_clk_mux_get_parent_data(ksc, cfg, pa=
rent_data,
> +                                                          cfg->num_paren=
t);
> +                       if (ret)
> +                               return dev_err_probe(&pdev->dev, ret,
> +                                                    "Failed to get paren=
t data\n");
> +
> +                       ret =3D k230_register_mux_clk(pdev, ksc, parent_d=
ata,
> +                                                   cfg->num_parent, i);
> +               } else {
> +                       pclk =3D cfg->parent;
> +                       switch (pclk->type) {
> +                       case K230_OSC24M:
> +                               ret =3D k230_register_osc24m_child(pdev, =
ksc, i);
> +                               break;
> +                       case K230_PLL:
> +                               ret =3D k230_register_pll_child(pdev, ksc=
, i,
> +                                                             pclk->pll_i=
d, cfg->flags);
> +                               break;
> +                       case K230_PLL_DIV:
> +                               ret =3D k230_register_pll_div_child(pdev,=
 ksc, i,
> +                                                                 pclk->p=
ll_div_id, cfg->flags);
> +                               break;
> +                       case K230_CLK_COMPOSITE:
> +                               ret =3D k230_register_clk_child(pdev, ksc=
, i,
> +                                                             pclk->clk_i=
d);
> +                               break;
> +                       default:
> +                               return dev_err_probe(&pdev->dev, -EINVAL,=
 "Invalid type\n");
> +                       }
> +               }
> +               if (ret)
> +                       return dev_err_probe(&pdev->dev, ret, "register c=
hild id %d failed\n", i);
> +       }
> +
> +       return 0;
> +}
> +
> +static struct clk_hw *k230_clk_hw_onecell_get(struct of_phandle_args *cl=
kspec, void *data)
> +{
> +       struct k230_sysclk *ksc;
> +       unsigned int idx;
> +
> +       if (clkspec->args_count !=3D 1)
> +               return ERR_PTR(-EINVAL);
> +
> +       idx =3D clkspec->args[0];
> +       if (idx >=3D K230_CLK_NUM)
> +               return ERR_PTR(-EINVAL);
> +
> +       if (!data)
> +               return ERR_PTR(-EINVAL);
> +
> +       ksc =3D (struct k230_sysclk *)data;

Drop useless cast please.

> +
> +       return &ksc->clks[idx].hw;
> +}
> +
> +static int k230_clk_init_plls(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct k230_sysclk *ksc =3D platform_get_drvdata(pdev);
> +
> +       spin_lock_init(&ksc->pll_lock);
> +
> +       ksc->pll_regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (!ksc->pll_regs)

Does it return an error pointer or NULL on failure? The dev_err_probe()
below is incorrect or the if condition above is.

> +               return dev_err_probe(&pdev->dev, PTR_ERR(ksc->pll_regs), =
"map registers failed\n");

Doesn't this already print an error?

> +
> +       ret =3D k230_register_plls(pdev, ksc);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "register plls fail=
ed\n");
> +
> +       ret =3D k230_register_pll_divs(pdev, ksc);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "register pll_divs =
failed\n");
> +
> +       for (int i =3D 0; i < K230_PLL_DIV_NUM; i++) {
> +               ret =3D devm_clk_hw_register_clkdev(&pdev->dev, ksc->dclk=
s[i].hw,
> +                                                 k230_pll_div_cfgs[i].na=
me, NULL);

Why is clkdev being used?

> +               if (ret)
> +                       return dev_err_probe(&pdev->dev, ret, "clock_look=
up create failed\n");
> +       }
> +
> +       return 0;
> +}
> +
> +static int k230_clk_init_clks(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct k230_sysclk *ksc =3D platform_get_drvdata(pdev);
> +
> +       spin_lock_init(&ksc->clk_lock);
> +
> +       ksc->regs =3D devm_platform_ioremap_resource(pdev, 1);
> +       if (!ksc->regs)
> +               return dev_err_probe(&pdev->dev, PTR_ERR(ksc->regs), "fai=
led to map registers\n");
> +
> +       ret =3D k230_register_clks(pdev, ksc);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "register clock pro=
vider failed\n");
> +
> +       ret =3D devm_of_clk_add_hw_provider(&pdev->dev, k230_clk_hw_onece=
ll_get, ksc);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "add clock provider=
 failed\n");
> +
> +       return 0;
> +}
> +
> +static int k230_clk_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct k230_sysclk *ksc;
> +
> +       ksc =3D devm_kzalloc(&pdev->dev, sizeof(struct k230_sysclk), GFP_=
KERNEL);
> +       if (!ksc)
> +               return -ENOMEM;
> +
> +       ksc->plls =3D devm_kmalloc_array(&pdev->dev, K230_PLL_NUM,

Any reason devm_kcalloc() isn't used?

> +                                      sizeof(struct k230_pll), GFP_KERNE=
L);
> +       if (!ksc->plls)
> +               return -ENOMEM;
> +
> +       ksc->dclks =3D devm_kmalloc_array(&pdev->dev, K230_PLL_DIV_NUM,
> +                                       sizeof(struct k230_pll_div), GFP_=
KERNEL);
> +       if (!ksc->dclks)
> +               return -ENOMEM;
> +
> +       ksc->clks =3D devm_kmalloc_array(&pdev->dev, K230_CLK_NUM,
> +                                      sizeof(struct k230_clk), GFP_KERNE=
L);
> +       if (!ksc->clks)
> +               return -ENOMEM;
> +
> +       ksc->pdev =3D pdev;
> +       platform_set_drvdata(pdev, ksc);
> +
> +       ret =3D k230_clk_init_plls(pdev);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "init plls failed\n=
");
> +
> +       ret =3D k230_clk_init_clks(pdev);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "init clks failed\n=
");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id k230_clk_ids[] =3D {
> +       { .compatible =3D "canaan,k230-clk" },
> +       { /* Sentinel */ },

Nitpick: Please drop last comma so that nothing can come after without
causing a compilation error.

> +};
> +MODULE_DEVICE_TABLE(of, k230_clk_ids);

