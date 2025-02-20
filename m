Return-Path: <linux-kernel+bounces-524005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99074A3DDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351E6163CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93F1F5402;
	Thu, 20 Feb 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="UMNi/0Kl"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86281D54CF;
	Thu, 20 Feb 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064116; cv=pass; b=HMfwojcqQNgF/L0Tbxs6nh69Xk2aXI+y65E3IfR1FzMcYFNFczy6UWTp58Zpf8VTi7godPAtl6dyIIUeUd55yB/fVTc5DbHPnxEpvVbn+5A6VNI8xAO//dnF+3zYnZTGg6wLz4RfOVLbqKOe43wT8GgSGnJkbUO7YOFyw6vrdC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064116; c=relaxed/simple;
	bh=7wzkRgXTK1MkgliAOQ9A+pZA3keLjgr2E/2k0Vna2UQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KI2s1TkYBvYAi63Qzri0qwvUga4qaDb2RUTm6PVvWCjlqWv9q6j+nrvDJ9Pdc87phZUrFgKsBpUfBc9R12gypPQ/xU14kjDKZ5Pha815+rJQq7tkxhG3gwSEz4ILGP/RLiY1zVzJKoF3pufqvYS6Dt5aQwlOBxGefIInk3+TDoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=UMNi/0Kl; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1740064090; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GCwofrzwzVqcn3EBDYrJu6UaCHLzouaDPDey6nE8q0BV0qXFzlcTYjbEGqYnNkJ/KEpAnOfABaVx+hhDLQlteoCrZzGGDSKZ9LH91zX8WetrzaNRTadbOc8vx7EVBvKRW6Ryw2JkRG34FKxeE2R6ZjlgIP7VH3rtzlYHhEqVaTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740064090; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o9DUaY4QxzcIs491qcjx6Tn9zGSUHSAXAHKJJEvHT6A=; 
	b=CgAzTyBNF02Tf9yp011pPYUA8dyhy/4ZynGJYEi00KY+vWBhJbErMKvZBBfeaZAJLTVO7PeKm4PAYB2j9wcORG9sfkFnud2rty9NQUJuqSCFjJDP3sLyOz3AVwE4GmwnTJ5nRi/RQuX3L2paNpPI9KcSBW5vKKxdZztbLGvNs5g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740064090;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=o9DUaY4QxzcIs491qcjx6Tn9zGSUHSAXAHKJJEvHT6A=;
	b=UMNi/0KloDgrKz0feBYZEA5j//tuJMbtdkR3tpNvk5bv1J33BZnuVhSMfrscpVBF
	KrS4RwuszyWVC61nyC8vcaMKv9KuZttapIL58lJneqobq0uTGgfNarLjyZj9T/GqvcS
	ve09T55kKzGhr025xazk2L/6YTeZlsZpszfvDnKs=
Received: by mx.zohomail.com with SMTPS id 1740064086356275.5486112381868;
	Thu, 20 Feb 2025 07:08:06 -0800 (PST)
Message-ID: <364a8fbd-d78e-421d-a37b-cb7a29077802@zohomail.com>
Date: Thu, 20 Feb 2025 23:07:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xukai Wang <kingxukai@zohomail.com>
Subject: Re: [PATCH v4 2/3] clk: canaan: Add clock driver for Canaan K230
To: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
 <20250217-b4-k230-clk-v4-2-5a95a3458691@zohomail.com>
 <3fb73691f50e599c361dddaff08d3af5.sboyd@kernel.org>
Content-Language: en-US
In-Reply-To: <3fb73691f50e599c361dddaff08d3af5.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112279b4f65c2b10dd6a0bcf0a0d10000b97dde043e24bbdc941105ff0bb1e15d21580d678bef80d772:zu08011227047e203181c3efa6545db4590000b53d60b65ce4379ab5135ec25eb1d1bfc10c205fb1b62ee0c0:rf0801122b2228f1f3b4acc0d7ec6252ef000010777501b7a032a407cd27d79957881edfbbfd0ca4a59e5b8590653d6b:ZohoMail
X-ZohoMailClient: External

On 2025/2/19 05:48, Stephen Boyd wrote:
> Quoting Xukai Wang (2025-02-17 06:45:17)
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 299bc678ed1b9fcd9110bb8c5937a1bd1ea60e23..f63355ab8adeeee90d29d1a975607f5dc0a58bd6 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -464,6 +464,12 @@ config COMMON_CLK_K210
>>         help
>>           Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>>  
>> +config COMMON_CLK_K230
>> +       bool "Clock driver for the Canaan Kendryte K230 SoC"
>> +       depends on OF && (ARCH_CANAAN || COMPILE_TEST)
> It doesn't depend on OF to build from what I can tell. This should
> simply be
>
> 	depends on ARCH_CANAAN || COMPILE_TEST
>
> right?
right, it doesn't depend on OF.
>
>> +        help
>> +          Support for the Canaan Kendryte K230 RISC-V SoC clocks.
>> +
>>  config COMMON_CLK_SP7021
>>         tristate "Clock driver for Sunplus SP7021 SoC"
>>         depends on SOC_SP7021 || COMPILE_TEST
>> diff --git a/drivers/clk/clk-k230.c b/drivers/clk/clk-k230.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..017ecad9ec47ed751f75fe5197aa119ae35e05f9
>> --- /dev/null
>> +++ b/drivers/clk/clk-k230.c
>> @@ -0,0 +1,1347 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Kendryte Canaan K230 Clock Drivers
>> + *
>> + * Author: Xukai Wang <kingxukai@zohomail.com>
>> + * Author: Troy Mitchell <troymitchell988@gmail.com>
>> + */
>> +
>> +#include <dt-bindings/clock/canaan,k230-clk.h>
> Please put dt-bindigns at the end of the include list.
OK, thanks for reminder.
>> +#include <linux/clk.h>
> Is this include used? Ideally a clk provider (clk-provider.h) isn't also
> a clk consumer (clk.h).
Here I use `clk_prepare_enable()` in `k230_pll_init()` to enable the
software if the hardware is automatically enabled.
>> +#include <linux/clkdev.h>
> Hopefully clkdev isn't used.
I use devm_clk_hw_register_clkdev() below and am explained why it was
used. Please check.
>> +#include <linux/clk-provider.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
> Is this include used?
Apologies, I'll drop it.
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
> Need to include mod_devicetable.h
Yes, it should be.
>> +
>> +/* PLL control register bits. */
>> +#define K230_PLL_BYPASS_ENABLE                         BIT(19)
>> +#define K230_PLL_GATE_ENABLE                           BIT(2)
>> +#define K230_PLL_GATE_WRITE_ENABLE                     BIT(18)
>> +#define K230_PLL_OD_SHIFT                              24
>> +#define K230_PLL_OD_MASK                               0xF
>> +#define K230_PLL_R_SHIFT                               16
>> +#define K230_PLL_R_MASK                                        0x3F
>> +#define K230_PLL_F_SHIFT                               0
>> +#define K230_PLL_F_MASK                                        0x1FFFF
>> +#define K230_PLL0_OFFSET_BASE                          0x00
>> +#define K230_PLL1_OFFSET_BASE                          0x10
>> +#define K230_PLL2_OFFSET_BASE                          0x20
>> +#define K230_PLL3_OFFSET_BASE                          0x30
>> +#define K230_PLL_DIV_REG_OFFSET                                0x00
>> +#define K230_PLL_BYPASS_REG_OFFSET                     0x04
>> +#define K230_PLL_GATE_REG_OFFSET                       0x08
>> +#define K230_PLL_LOCK_REG_OFFSET                       0x0C
>> +
>> +/* PLL lock register bits.  */
>> +#define K230_PLL_STATUS_MASK                           BIT(0)
>> +
>> +/* K230 CLK registers offset */
>> +#define K230_CLK_AUDIO_CLKDIV_OFFSET                   0x34
>> +#define K230_CLK_PDM_CLKDIV_OFFSET                     0x40
>> +#define K230_CLK_CODEC_ADC_MCLKDIV_OFFSET              0x38
>> +#define K230_CLK_CODEC_DAC_MCLKDIV_OFFSET              0x3c
>> +
>> +/* K230 CLK OPS. */
>> +#define K230_CLK_OPS_GATE                              \
>> +       .enable         = k230_clk_enable,              \
>> +       .disable        = k230_clk_disable,             \
>> +       .is_enabled     = k230_clk_is_enabled
>> +
>> +#define K230_CLK_OPS_RATE                              \
>> +       .set_rate       = k230_clk_set_rate,            \
>> +       .round_rate     = k230_clk_round_rate,          \
>> +       .recalc_rate    = k230_clk_get_rate
>> +
>> +#define K230_CLK_OPS_MUX                               \
>> +       .set_parent     = k230_clk_set_parent,          \
>> +       .get_parent     = k230_clk_get_parent,          \
>> +       .determine_rate = clk_hw_determine_rate_no_reparent
>> +
>> +#define K230_CLK_OPS_ID_NONE                           0
>> +#define K230_CLK_OPS_ID_GATE_ONLY                      1
>> +#define K230_CLK_OPS_ID_RATE_ONLY                      2
>> +#define K230_CLK_OPS_ID_RATE_GATE                      3
>> +#define K230_CLK_OPS_ID_MUX_ONLY                       4
>> +#define K230_CLK_OPS_ID_MUX_GATE                       5
>> +#define K230_CLK_OPS_ID_MUX_RATE                       6
>> +#define K230_CLK_OPS_ID_ALL                            7
>> +#define K230_CLK_OPS_ID_NUM                            8
>> +
>> +/* K230 CLK MACROS */
>> +#define K230_CLK_MAX_PARENT_NUM                                6
>> +
>> +#define K230_GATE_FORMAT(_reg, _bit, _reverse, _have_gate)                     \
>> +       .gate_reg_off = (_reg),                                                 \
>> +       .gate_bit_enable = (_bit),                                              \
>> +       .gate_bit_reverse = (_reverse),                                         \
>> +       .have_gate = (_have_gate)
>> +
>> +#define K230_RATE_FORMAT(_mul_min, _mul_max, _mul_shift, _mul_mask,            \
>> +                       _div_min, _div_max, _div_shift, _div_mask,              \
>> +                       _reg, _bit, _method, _reg_c, _bit_c,                    \
>> +                       _mul_min_c, _mul_max_c, _mul_shift_c, _mul_mask_c,      \
>> +                       _have_rate, _have_rate_c)                               \
>> +       .rate_mul_min = (_mul_min),                                             \
>> +       .rate_mul_max = (_mul_max),                                             \
>> +       .rate_mul_shift = (_mul_shift),                                         \
>> +       .rate_mul_mask = (_mul_mask),                                           \
>> +       .rate_mul_min_c = (_mul_min_c),                                         \
>> +       .rate_mul_max_c = (_mul_max_c),                                         \
>> +       .rate_mul_shift_c = (_mul_shift_c),                                     \
>> +       .rate_mul_mask_c = (_mul_mask_c),                                       \
>> +       .rate_div_min = (_div_min),                                             \
>> +       .rate_div_max = (_div_max),                                             \
>> +       .rate_div_shift = (_div_shift),                                         \
>> +       .rate_div_mask = (_div_mask),                                           \
>> +       .rate_reg_off = (_reg),                                                 \
>> +       .rate_reg_off_c = (_reg_c),                                             \
>> +       .rate_write_enable_bit = (_bit),                                        \
>> +       .rate_write_enable_bit_c = (_bit_c),                                    \
>> +       .method = (_method),                                                    \
>> +       .have_rate = (_have_rate),                                              \
>> +       .have_rate_c = (_have_rate_c)
>> +
>> +#define K230_MUX_FORMAT(_reg, _shift, _mask, _have_mux)                                \
>> +       .mux_reg_off = (_reg),                                                  \
>> +       .mux_reg_shift = (_shift),                                              \
>> +       .mux_reg_mask = (_mask),                                                \
>> +       .have_mux = (_have_mux)
>> +
>> +#define K230_GATE_FORMAT_ZERO  K230_GATE_FORMAT(0, 0, 0, false)
>> +#define K230_RATE_FORMAT_ZERO  K230_RATE_FORMAT(0, 0, 0, 0, 0, 0,              \
>> +                                               0, 0, 0, 0, 0, 0,               \
>> +                                               0, 0, 0, 0, 0, false, false)
>> +#define K230_MUX_FORMAT_ZERO   K230_MUX_FORMAT(0, 0, 0, false)
>> +
>> +struct k230_sysclk;
>> +
>> +/* K230 PLLs. */
>> +enum k230_pll_id {
>> +       K230_PLL0, K230_PLL1, K230_PLL2, K230_PLL3, K230_PLL_NUM
>> +};
>> +
>> +struct k230_pll {
>> +       enum k230_pll_id id;
>> +       struct k230_sysclk *ksc;
>> +       void __iomem *div, *bypass, *gate, *lock;
>> +       struct clk_hw hw;
>> +};
>> +
>> +#define to_k230_pll(_hw)       container_of(_hw, struct k230_pll, hw)
>> +
>> +struct k230_pll_cfg {
>> +       u32 reg;
>> +       enum k230_pll_id pll_id;
>> +       const char *name;
>> +};
>> +
>> +/* K230 PLL_DIVS. */
>> +struct k230_pll_div {
>> +       struct k230_sysclk *ksc;
>> +       struct clk_hw *hw;
>> +};
>> +
>> +struct k230_pll_div_cfg {
>> +       const char *parent_name, *name;
>> +       int div;
>> +};
>> +
>> +enum k230_pll_div_id {
>> +       K230_PLL0_DIV2,
>> +       K230_PLL0_DIV3,
>> +       K230_PLL0_DIV4,
>> +       K230_PLL1_DIV2,
>> +       K230_PLL1_DIV3,
>> +       K230_PLL1_DIV4,
>> +       K230_PLL2_DIV2,
>> +       K230_PLL2_DIV3,
>> +       K230_PLL2_DIV4,
>> +       K230_PLL3_DIV2,
>> +       K230_PLL3_DIV3,
>> +       K230_PLL3_DIV4,
>> +       K230_PLL_DIV_NUM
>> +};
>> +
>> +enum k230_clk_div_type {
>> +       K230_MUL,
>> +       K230_DIV,
>> +       K230_MUL_DIV,
>> +};
>> +
>> +/* K230 CLKS. */
>> +struct k230_clk {
>> +       int id;
>> +       struct k230_sysclk *ksc;
>> +       struct clk_hw hw;
>> +};
>> +
>> +#define to_k230_clk(_hw)       container_of(_hw, struct k230_clk, hw)
>> +
>> +enum k230_clk_parent_type {
>> +       K230_OSC24M,
>> +       K230_PLL,
>> +       K230_PLL_DIV,
>> +       K230_CLK_COMPOSITE,
>> +};
>> +
>> +struct k230_clk_parent {
>> +       enum k230_clk_parent_type type;
>> +       union {
>> +               enum k230_pll_div_id pll_div_id;
>> +               enum k230_pll_id pll_id;
>> +               int clk_id;
>> +       };
>> +};
>> +
>> +struct k230_clk_cfg {
>> +       /* attr */
>> +       const char *name;
>> +       /* 0-read & write; 1-read only */
>> +       bool read_only;
>> +       int num_parent;
>> +       struct k230_clk_parent parent[K230_CLK_MAX_PARENT_NUM];
>> +       bool status;
>> +       int flags;
>> +
>> +       /* rate reg */
>> +       u32 rate_reg_off;
>> +       u32 rate_reg_off_c;
>> +       void __iomem *rate_reg;
>> +       void __iomem *rate_reg_c;
>> +       /* rate info*/
>> +       u32 rate_write_enable_bit;
>> +       u32 rate_write_enable_bit_c;
>> +       enum k230_clk_div_type method;
>> +       bool have_rate;
>> +       bool have_rate_c;
>> +       /* rate mul */
>> +       u32 rate_mul_min;
>> +       u32 rate_mul_max;
>> +       u32 rate_mul_shift;
>> +       u32 rate_mul_mask;
>> +       /* rate mul-changable */
>> +       u32 rate_mul_min_c;
>> +       u32 rate_mul_max_c;
>> +       u32 rate_mul_shift_c;
>> +       u32 rate_mul_mask_c;
>> +       /* rate div */
>> +       u32 rate_div_min;
>> +       u32 rate_div_max;
>> +       u32 rate_div_shift;
>> +       u32 rate_div_mask;
>> +
>> +       /* gate reg */
>> +       u32 gate_reg_off;
>> +       void __iomem *gate_reg;
>> +       /* gate info*/
>> +       bool have_gate;
>> +       u32 gate_bit_enable;
>> +       u32 gate_bit_reverse;
>> +
>> +       /* mux reg */
>> +       u32 mux_reg_off;
>> +       void __iomem *mux_reg;
>> +       /* mux info */
>> +       bool have_mux;
>> +       u32 mux_reg_shift;
>> +       u32 mux_reg_mask;
>> +};
>> +
>> +/* K230 SYSCLK. */
>> +struct k230_sysclk {
>> +       struct platform_device *pdev;
>> +       void __iomem           *pll_regs, *regs;
>> +       spinlock_t             pll_lock, clk_lock;
>> +       struct k230_pll        *plls;
>> +       struct k230_clk        *clks;
>> +       struct k230_pll_div    *dclks;
>> +};
>> +
>> +static const struct k230_pll_cfg k230_pll_cfgs[] = {
>> +       [K230_PLL0] = {
>> +               .reg = K230_PLL0_OFFSET_BASE,
>> +               .pll_id = K230_PLL0,
>> +               .name = "pll0",
>> +       },
>> +       [K230_PLL1] = {
>> +               .reg = K230_PLL1_OFFSET_BASE,
>> +               .pll_id = K230_PLL1,
>> +               .name = "pll1",
>> +       },
>> +       [K230_PLL2] = {
>> +               .reg = K230_PLL2_OFFSET_BASE,
>> +               .pll_id = K230_PLL2,
>> +               .name = "pll2",
>> +       },
>> +       [K230_PLL3] = {
>> +               .reg = K230_PLL3_OFFSET_BASE,
>> +               .pll_id = K230_PLL3,
>> +               .name = "pll3",
>> +       },
>> +};
>> +
>> +static const struct k230_pll_div_cfg k230_pll_div_cfgs[] = {
>> +       [K230_PLL0_DIV2] = { "pll0", "pll0_div2", 2},
>> +       [K230_PLL0_DIV3] = { "pll0", "pll0_div3", 3},
>> +       [K230_PLL0_DIV4] = { "pll0", "pll0_div4", 4},
>> +       [K230_PLL1_DIV2] = { "pll1", "pll1_div2", 2},
>> +       [K230_PLL1_DIV3] = { "pll1", "pll1_div3", 3},
>> +       [K230_PLL1_DIV4] = { "pll1", "pll1_div4", 4},
>> +       [K230_PLL2_DIV2] = { "pll2", "pll2_div2", 2},
>> +       [K230_PLL2_DIV3] = { "pll2", "pll2_div3", 3},
>> +       [K230_PLL2_DIV4] = { "pll2", "pll2_div4", 4},
>> +       [K230_PLL3_DIV2] = { "pll3", "pll3_div2", 2},
>> +       [K230_PLL3_DIV3] = { "pll3", "pll3_div3", 3},
>> +       [K230_PLL3_DIV4] = { "pll3", "pll3_div4", 4},
>> +};
>> +
>> +static struct k230_clk_cfg k230_clk_cfgs[] = {
>> +       [K230_CPU0_SRC] = {
> Can these be named variables instead of array elements? Then we can map
> quickly to parents instead of going through an intermediate enum.

Yes, using named variables instead of array elements is a quick approach
to map parents.

However, I wonder how to access similar struct members without redundant
code. Would it be appropriate to use `struct list_head` to simplify
looping and access these members more efficiently?

>> +               .name = "cpu0_src",
>> +               .read_only = false,
>> +               .flags = 0,
>> +               .status = true,
>> +               .num_parent = 1,
>> +               .parent[0] = {
>> +                       .type = K230_PLL_DIV,
>> +                       .pll_div_id = K230_PLL0_DIV2,
>> +               },
>> +               K230_RATE_FORMAT(1, 16, 0, 0,
>> +                                16, 16, 1, 0xF,
>> +                                0x0, 31, K230_MUL, 0, 0,
>> +                                0, 0, 0, 0,
>> +                                true, false),
>> +               K230_GATE_FORMAT(0, 0, 0, true),
>> +               K230_MUX_FORMAT_ZERO,
>> +       },
>> +       [K230_CPU0_ACLK] = {
>> +               .name = "cpu0_aclk",
>> +               .read_only = false,
>> +               .flags = 0,
>> +               .status = true,
>> +               .num_parent = 1,
>> +               .parent[0] = {
>> +                       .type = K230_CLK_COMPOSITE,
>> +                       .clk_id = K230_CPU0_SRC,
>> +               },
>> +               K230_RATE_FORMAT(1, 1, 0, 0,
>> +                                1, 8, 7, 0x7,
>> +                                0x0, 31, K230_MUL, 0, 0,
>> +                                0, 0, 0, 0,
>> +                                true, false),
>> +               K230_GATE_FORMAT_ZERO,
>> +               K230_MUX_FORMAT_ZERO,
>> +       },
>> +       [K230_CPU0_PLIC] = {
>> +               .name = "cpu0_plic",
>> +               .read_only = false,
>> +               .flags = 0,
>> +               .status = true,
>> +               .num_parent = 1,
>> +               .parent[0] = {
>> +                       .type = K230_CLK_COMPOSITE,
>> +                       .clk_id = K230_CPU0_SRC,
>> +               },
>> +               K230_RATE_FORMAT(1, 1, 0, 0,
>> +                                1, 8, 10, 0x7,
>> +                                0x0, 31, K230_DIV, 0, 0,
>> +                                0, 0, 0, 0,
>> +                                true, false),
>> +               K230_GATE_FORMAT(0, 9, 0, true),
>> +               K230_MUX_FORMAT_ZERO,
>> +       },
>> +       [K230_CPU0_NOC_DDRCP4] = {
>> +               .name = "cpu0_noc_ddrcp4",
>> +               .read_only = false,
>> +               .flags = 0,
>> +               .status = true,
>> +               .num_parent = 1,
>> +               .parent[0] = {
>> +                       .type = K230_CLK_COMPOSITE,
>> +                       .clk_id = K230_CPU0_SRC,
>> +               },
>> +               K230_RATE_FORMAT_ZERO,
>> +               K230_GATE_FORMAT(0x60, 7, 0, true),
>> +               K230_MUX_FORMAT_ZERO,
>> +       },
>> +       [K230_CPU0_PCLK] = {
>> +               .name = "cpu0_pclk",
>> +               .read_only = false,
>> +               .flags = 0,
>> +               .status = true,
>> +               .num_parent = 1,
>> +               .parent[0] = {
>> +                       .type = K230_PLL_DIV,
>> +                       .pll_div_id = K230_PLL0_DIV4,
>> +               },
>> +               K230_RATE_FORMAT(1, 1, 0, 0,
>> +                                1, 8, 15, 0x7,
>> +                                0x0, 31, K230_DIV, 0, 0,
>> +                                0, 0, 0, 0,
>> +                                true, false),
>> +               K230_GATE_FORMAT(0, 13, 0, true),
>> +               K230_MUX_FORMAT_ZERO,
>> +       },
>> +       [K230_PMU_PCLK] = {
>> +               .name = "pmu_pclk",
>> +               .read_only = false,
>> +               .flags = 0,
>> +               .status = true,
>> +               .num_parent = 1,
>> +               .parent[0] = {
>> +                       .type = K230_OSC24M,
>> +               },
>> +               K230_RATE_FORMAT_ZERO,
>> +               K230_GATE_FORMAT(0x10, 0, 0, true),
>> +               K230_MUX_FORMAT_ZERO,
>> +       },
>> +       [K230_HS_OSPI_SRC] = {
>> +               .name = "hs_ospi_src",
>> +               .read_only = false,
>> +               .flags = 0,
>> +               .status = true,
>> +               .num_parent = 2,
>> +               .parent[0] = {
>> +                       .type = K230_PLL_DIV,
>> +                       .pll_div_id = K230_PLL0_DIV2,
>> +               },
>> +               .parent[1] = {
>> +                       .type = K230_PLL_DIV,
>> +                       .pll_div_id = K230_PLL2_DIV4,
>> +               },
>> +               K230_RATE_FORMAT_ZERO,
>> +               K230_GATE_FORMAT(0x18, 24, 0, true),
>> +               K230_MUX_FORMAT(0x20, 18, 0x1, true),
>> +       },
>> +};
>> +
>> +#define K230_CLK_NUM   ARRAY_SIZE(k230_clk_cfgs)
>> +
>> +static void k230_init_pll(void __iomem *regs, enum k230_pll_id pll_id,
>> +                         struct k230_pll *pll)
>> +{
>> +       void __iomem *base;
>> +
>> +       pll->id = pll_id;
>> +       base = regs + k230_pll_cfgs[pll_id].reg;
>> +       pll->div = base + K230_PLL_DIV_REG_OFFSET;
>> +       pll->bypass = base + K230_PLL_BYPASS_REG_OFFSET;
>> +       pll->gate = base + K230_PLL_GATE_REG_OFFSET;
>> +       pll->lock = base + K230_PLL_LOCK_REG_OFFSET;
>> +}
>> +
>> +static int k230_pll_prepare(struct clk_hw *hw)
>> +{
>> +       struct k230_pll *pll = to_k230_pll(hw);
>> +       u32 reg;
>> +
>> +       /* wait for PLL lock until it reachs lock status */
> s/reachs/reaches/
Apologies, I'll modify it.
>> +       return readl_poll_timeout(pll->lock, reg,
>> +                                 (reg & K230_PLL_STATUS_MASK) == K230_PLL_STATUS_MASK,
>> +                                 400, 0);
>> +}
>> +
>> +static bool k230_pll_hw_is_enabled(struct k230_pll *pll)
>> +{
>> +       return (readl(pll->gate) & K230_PLL_GATE_ENABLE) == K230_PLL_GATE_ENABLE;
>> +}
>> +
>> +static void k230_pll_enable_hw(void __iomem *regs, struct k230_pll *pll)
>> +{
>> +       u32 reg;
>> +
>> +       if (k230_pll_hw_is_enabled(pll))
>> +               return;
>> +
>> +       /* Set PLL factors */
>> +       reg = readl(pll->gate);
>> +       reg |= (K230_PLL_GATE_ENABLE | K230_PLL_GATE_WRITE_ENABLE);
>> +       writel(reg, pll->gate);
>> +}
>> +
>> +static int k230_pll_enable(struct clk_hw *hw)
>> +{
>> +       struct k230_pll *pll = to_k230_pll(hw);
>> +       struct k230_sysclk *ksc = pll->ksc;
>> +
>> +       guard(spinlock)(&ksc->pll_lock);
>> +       k230_pll_enable_hw(ksc->regs, pll);
>> +
>> +       return 0;
>> +}
>> +
>> +static void k230_pll_disable(struct clk_hw *hw)
>> +{
>> +       struct k230_pll *pll = to_k230_pll(hw);
>> +       struct k230_sysclk *ksc = pll->ksc;
>> +       u32 reg;
>> +
>> +       guard(spinlock)(&ksc->pll_lock);
>> +       reg = readl(pll->gate);
>> +
>> +       reg &= ~(K230_PLL_GATE_ENABLE);
>> +       reg |= (K230_PLL_GATE_WRITE_ENABLE);
>> +
>> +       writel(reg, pll->gate);
>> +}
>> +
>> +static int k230_pll_is_enabled(struct clk_hw *hw)
>> +{
>> +       return k230_pll_hw_is_enabled(to_k230_pll(hw));
>> +}
>> +
>> +static int k230_pll_init(struct clk_hw *hw)
>> +{
>> +       if (k230_pll_is_enabled(hw))
>> +               return clk_prepare_enable(hw->clk);
> Is this CLK_IS_CRITICAL?
I think it is not the case of CLK_IS_CRITICAL; it enables the software
if the hardware is automatically enabled.
>> +
>> +       return 0;
>> +}
>> +
>> +static unsigned long k230_pll_get_rate(struct clk_hw *hw, unsigned long parent_rate)
>> +{
>> +       struct k230_pll *pll = to_k230_pll(hw);
>> +       struct k230_sysclk *ksc = pll->ksc;
>> +       u32 reg;
>> +       u32 r, f, od;
>> +
>> +       reg = readl(pll->bypass);
>> +       if (reg & K230_PLL_BYPASS_ENABLE)
>> +               return parent_rate;
>> +
>> +       reg = readl(pll->lock);
>> +       if (!(reg & (K230_PLL_STATUS_MASK))) { /* unlocked */
>> +               dev_err(&ksc->pdev->dev, "%s is unlock.\n", clk_hw_get_name(hw));
>> +               return 0;
>> +       }
>> +
>> +       reg = readl(pll->div);
>> +       r = ((reg >> K230_PLL_R_SHIFT) & K230_PLL_R_MASK) + 1;
>> +       f = ((reg >> K230_PLL_F_SHIFT) & K230_PLL_F_MASK) + 1;
>> +       od = ((reg >> K230_PLL_OD_SHIFT) & K230_PLL_OD_MASK) + 1;
>> +
>> +       return div_u64((u64)parent_rate * f, r * od);
> Is this mul_u64_u32_div()?

Thanks for reminders.

It can be replaced with `mul_u64_u32_div(parent_rate, f, r * od)`

>> +}
>> +
>> +static const struct clk_ops k230_pll_ops = {
>> +       .init           = k230_pll_init,
>> +       .prepare        = k230_pll_prepare,
>> +       .enable         = k230_pll_enable,
>> +       .disable        = k230_pll_disable,
>> +       .is_enabled     = k230_pll_is_enabled,
>> +       .recalc_rate    = k230_pll_get_rate,
>> +};
>> +
>> +static int k230_register_pll(struct platform_device *pdev,
>> +                            struct k230_sysclk *ksc,
>> +                            enum k230_pll_id pll_id,
>> +                            const char *name,
>> +                            int num_parents,
>> +                            const struct clk_ops *ops)
>> +{
>> +       struct k230_pll *pll = &ksc->plls[pll_id];
>> +       struct clk_init_data init = {};
>> +       struct device *dev = &pdev->dev;
>> +       int ret;
>> +       const struct clk_parent_data parent_data[] = {
>> +               { .index = 0, },
>> +       };
>> +
>> +       init.name = name;
>> +       init.parent_data = parent_data;
>> +       init.num_parents = num_parents;
>> +       init.ops = ops;
>> +
>> +       pll->hw.init = &init;
>> +       pll->ksc = ksc;
>> +
>> +       ret = devm_clk_hw_register(dev, &pll->hw);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to register pll");
> Missing newline on printk.
OK, I get it.
>> +
>> +       return 0;
>> +}
>> +
>> +static int k230_register_plls(struct platform_device *pdev, struct k230_sysclk *ksc)
>> +{
>> +       int i, ret;
>> +       const struct k230_pll_cfg *cfg;
>> +
>> +       for (i = 0; i < K230_PLL_NUM; i++) {
>> +               cfg = &k230_pll_cfgs[i];
>> +
>> +               k230_init_pll(ksc->pll_regs, i, &ksc->plls[i]);
>> +
>> +               ret = k230_register_pll(pdev, ksc, cfg->pll_id, cfg->name, 1,
>> +                                       &k230_pll_ops);
>> +               if (ret)
>> +                       return dev_err_probe(&pdev->dev, ret,
>> +                                            "register %s failed\n", cfg->name);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int k230_register_pll_divs(struct platform_device *pdev, struct k230_sysclk *ksc)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct clk_hw *hw;
>> +
>> +       for (int i = 0; i < K230_PLL_DIV_NUM; i++) {
>> +               hw = devm_clk_hw_register_fixed_factor(dev, k230_pll_div_cfgs[i].name,
>> +                                                      k230_pll_div_cfgs[i].parent_name,
>> +                                                      0, 1, k230_pll_div_cfgs[i].div);
>> +               if (IS_ERR(hw))
>> +                       return PTR_ERR(hw);
>> +               ksc->dclks[i].hw = hw;
>> +               ksc->dclks[i].ksc = ksc;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int k230_clk_enable(struct clk_hw *hw)
>> +{
>> +       struct k230_clk *clk = to_k230_clk(hw);
>> +       struct k230_sysclk *ksc = clk->ksc;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +       u32 reg;
>> +
>> +       if (!cfg->have_gate)
>> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This clock doesn't have gate\n");
>> +
>> +       guard(spinlock)(&ksc->clk_lock);
>> +       reg = readl(cfg->gate_reg);
>> +       if (cfg->gate_bit_reverse)
>> +               reg &= ~BIT(cfg->gate_bit_enable);
>> +       else
>> +               reg |= BIT(cfg->gate_bit_enable);
>> +       writel(reg, cfg->gate_reg);
>> +
>> +       return 0;
>> +}
>> +
>> +static void k230_clk_disable(struct clk_hw *hw)
>> +{
>> +       struct k230_clk *clk = to_k230_clk(hw);
>> +       struct k230_sysclk *ksc = clk->ksc;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +       u32 reg;
>> +
>> +       if (!cfg->have_gate) {
>> +               dev_err(&ksc->pdev->dev, "This clock doesn't have gate\n");
> Why are the clk_ops assigned to this clk then?

If this clock doesn't have a gate, then the clk_ops will not be assigned to it. In this case, I'm simply checking it again. You can verify this in the k230_register_clk function to ensure it's handled correctly.

If you think this check is redundant, I can drop it.

>> +               return;
>> +       }
>> +
>> +       guard(spinlock)(&ksc->clk_lock);
>> +       reg = readl(cfg->gate_reg);
>> +
>> +       if (cfg->gate_bit_reverse)
>> +               reg |= BIT(cfg->gate_bit_enable);
>> +       else
>> +               reg &= ~BIT(cfg->gate_bit_enable);
>> +
>> +       writel(reg, cfg->gate_reg);
>> +}
>> +
>> +static int k230_clk_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct k230_clk *clk = to_k230_clk(hw);
>> +       struct k230_sysclk *ksc = clk->ksc;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +       u32 reg;
>> +
>> +       if (!cfg->have_gate)
>> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This clock doesn't have gate\n");
> Why are the clk_ops assigned to this clk then? 

ditto.

> Don't use
> dev_err_probe() here.
OK, I'll modify it.
>> +
>> +       guard(spinlock)(&ksc->clk_lock);
>> +       reg = readl(cfg->gate_reg);
>> +
>> +       /* Check gate bit condition based on configuration and then set ret */
>> +       if (cfg->gate_bit_reverse)
>> +               return (BIT(cfg->gate_bit_enable) & reg) ? 1 : 0;
>> +       else
>> +               return (BIT(cfg->gate_bit_enable) & ~reg) ? 1 : 0;
>> +}
>> +
>> +static int k230_clk_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +       struct k230_clk *clk = to_k230_clk(hw);
>> +       struct k230_sysclk *ksc = clk->ksc;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +       u8 reg;
>> +
>> +       if (!cfg->have_mux)
>> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This clock doesn't have mux\n");
> Why are the clk_ops assigned to this clk then? 
ditto.
> Don't use
> dev_err_probe() here.
OK. I'll modify it.
>> +
>> +       guard(spinlock)(&ksc->clk_lock);
>> +       reg = (cfg->mux_reg_mask & index) << cfg->mux_reg_shift;
>> +       writeb(reg, cfg->mux_reg);
>> +
>> +       return 0;
>> +}
>> +
>> +static u8 k230_clk_get_parent(struct clk_hw *hw)
>> +{
>> +       struct k230_clk *clk = to_k230_clk(hw);
>> +       struct k230_sysclk *ksc = clk->ksc;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +       u8 reg;
>> +
>> +       if (!cfg->have_mux)
>> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This clock doesn't have mux\n");
> All these checks should go away and we should have different clk_ops for
> different clk types.
OK, I'll remove these redundant check.
>> +
>> +       guard(spinlock)(&ksc->clk_lock);
>> +       reg = readb(cfg->mux_reg);
>> +
>> +       return reg;
>> +}
>> +
>> +static unsigned long k230_clk_get_rate(struct clk_hw *hw,
>> +                                      unsigned long parent_rate)
>> +{
>> +       struct k230_clk *clk = to_k230_clk(hw);
>> +       struct k230_sysclk *ksc = clk->ksc;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +       u32 mul, div;
>> +
>> +       if (!cfg->have_rate) /* no divider, return parents' clk */
>> +               return parent_rate;
>> +
>> +       guard(spinlock)(&ksc->clk_lock);
>> +       switch (cfg->method) {
>> +       /*
>> +        * K230_MUL: div_mask+1/div_max...
>> +        * K230_DIV: mul_max/div_mask+1
>> +        * K230_MUL_DIV: mul_mask/div_mask...
>> +        */
>> +       case K230_MUL:
>> +               div = cfg->rate_div_max;
>> +               mul = (readl(cfg->rate_reg) >> cfg->rate_div_shift)
>> +                       & cfg->rate_div_mask;
>> +               mul++;
>> +               break;
>> +       case K230_DIV:
>> +               mul = cfg->rate_mul_max;
>> +               div = (readl(cfg->rate_reg) >> cfg->rate_div_shift)
>> +                       & cfg->rate_div_mask;
>> +               div++;
>> +               break;
>> +       case K230_MUL_DIV:
>> +               if (!cfg->have_rate_c) {
>> +                       mul = (readl(cfg->rate_reg) >> cfg->rate_mul_shift)
>> +                               & cfg->rate_mul_mask;
>> +                       div = (readl(cfg->rate_reg) >> cfg->rate_div_shift)
>> +                               & cfg->rate_div_mask;
>> +               } else {
>> +                       mul = (readl(cfg->rate_reg_c) >> cfg->rate_mul_shift_c)
>> +                               & cfg->rate_mul_mask_c;
>> +                       div = (readl(cfg->rate_reg_c) >> cfg->rate_div_shift)
>> +                               & cfg->rate_div_mask;
>> +               }
>> +               break;
>> +       default:
>> +               return 0;
>> +       }
>> +
>> +       return div_u64((u64)parent_rate * mul, div);
>> +}
>> +
>> +static int k230_clk_find_approximate(struct k230_clk *clk,
>> +                                    u32 mul_min,
>> +                                    u32 mul_max,
>> +                                    u32 div_min,
>> +                                    u32 div_max,
>> +                                    enum k230_clk_div_type method,
>> +                                    unsigned long rate,
>> +                                    unsigned long parent_rate,
>> +                                    u32 *div,
>> +                                    u32 *mul)
>> +{
>> +       long abs_min;
>> +       long abs_current;
>> +       long perfect_divide;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +
>> +       const u32 codec_clk[9] = {
>> +               2048000,
>> +               3072000,
>> +               4096000,
>> +               6144000,
>> +               8192000,
>> +               11289600,
>> +               12288000,
>> +               24576000,
>> +               49152000
>> +       };
>> +
>> +       const u32 codec_div[9][2] = {
>> +               {3125, 16},
>> +               {3125, 24},
>> +               {3125, 32},
>> +               {3125, 48},
>> +               {3125, 64},
>> +               {15625, 441},
>> +               {3125, 96},
>> +               {3125, 192},
>> +               {3125, 384}
>> +       };
>> +
>> +       const u32 pdm_clk[20] = {
>> +               128000,
>> +               192000,
>> +               256000,
>> +               384000,
>> +               512000,
>> +               768000,
>> +               1024000,
>> +               1411200,
>> +               1536000,
>> +               2048000,
>> +               2822400,
>> +               3072000,
>> +               4096000,
>> +               5644800,
>> +               6144000,
>> +               8192000,
>> +               11289600,
>> +               12288000,
>> +               24576000,
>> +               49152000
>> +       };
>> +
>> +       const u32 pdm_div[20][2] = {
>> +               {3125, 1},
>> +               {6250, 3},
>> +               {3125, 2},
>> +               {3125, 3},
>> +               {3125, 4},
>> +               {3125, 6},
>> +               {3125, 8},
>> +               {125000, 441},
>> +               {3125, 12},
>> +               {3125, 16},
>> +               {62500, 441},
>> +               {3125, 24},
>> +               {3125, 32},
>> +               {31250, 441},
>> +               {3125, 48},
>> +               {3125, 64},
>> +               {15625, 441},
>> +               {3125, 96},
>> +               {3125, 192},
>> +               {3125, 384}
>> +       };
>> +
>> +       switch (method) {
>> +       /* only mul can be changeable 1/12,2/12,3/12...*/
>> +       case K230_MUL:
>> +               perfect_divide = (long)((parent_rate * 1000) / rate);
>> +               abs_min = abs(perfect_divide -
>> +                            (long)(((long)div_max * 1000) / (long)mul_min));
>> +               *mul = mul_min;
>> +
>> +               for (u32 i = mul_min + 1; i <= mul_max; i++) {
>> +                       abs_current = abs(perfect_divide -
>> +                                       (long)((long)((long)div_max * 1000) / (long)i));
>> +                       if (abs_min > abs_current) {
>> +                               abs_min = abs_current;
>> +                               *mul = i;
>> +                       }
>> +               }
>> +
>> +               *div = div_max;
>> +               break;
>> +       /* only div can be changeable, 1/1,1/2,1/3...*/
>> +       case K230_DIV:
>> +               perfect_divide = (long)((parent_rate * 1000) / rate);
>> +               abs_min = abs(perfect_divide -
>> +                            (long)(((long)div_min * 1000) / (long)mul_max));
>> +               *div = div_min;
>> +
>> +               for (u32 i = div_min + 1; i <= div_max; i++) {
>> +                       abs_current = abs(perfect_divide -
>> +                                        (long)((long)((long)i * 1000) / (long)mul_max));
>> +                       if (abs_min > abs_current) {
>> +                               abs_min = abs_current;
>> +                               *div = i;
>> +                       }
>> +               }
>> +
>> +               *mul = mul_max;
>> +               break;
>> +       /* mul and div can be changeable. */
>> +       case K230_MUL_DIV:
>> +               if (cfg->rate_reg_off == K230_CLK_CODEC_ADC_MCLKDIV_OFFSET ||
>> +                   cfg->rate_reg_off == K230_CLK_CODEC_DAC_MCLKDIV_OFFSET) {
>> +                       for (u32 j = 0; j < 9; j++) {
>> +                               if (0 == (rate - codec_clk[j])) {
>> +                                       *div = codec_div[j][0];
>> +                                       *mul = codec_div[j][1];
>> +                               }
>> +                       }
>> +               } else if (cfg->rate_reg_off == K230_CLK_AUDIO_CLKDIV_OFFSET ||
>> +                          cfg->rate_reg_off == K230_CLK_PDM_CLKDIV_OFFSET) {
>> +                       for (u32 j = 0; j < 20; j++) {
>> +                               if (0 == (rate - pdm_clk[j])) {
>> +                                       *div = pdm_div[j][0];
>> +                                       *mul = pdm_div[j][1];
>> +                               }
>> +                       }
>> +               } else {
>> +                       return -EINVAL;
>> +               }
>> +               break;
>> +       default:
>> +               WARN_ON_ONCE(true);
>> +               return -EPERM;
> This is impossible? Remove the default case and the compiler will warn
> if an enum case is missing.
Thanks for reminders. I get it.
>> +       }
>> +       return 0;
>> +}
>> +
>> +static long k230_clk_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *parent_rate)
>> +{
>> +       struct k230_clk *clk = to_k230_clk(hw);
>> +       struct k230_sysclk *ksc = clk->ksc;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +       u32 div = 0, mul = 0;
>> +
>> +       if (k230_clk_find_approximate(clk,
>> +                                     cfg->rate_mul_min, cfg->rate_mul_max,
>> +                                     cfg->rate_div_min, cfg->rate_div_max,
>> +                                     cfg->method, rate, *parent_rate, &div, &mul)) {
>> +               dev_err(&ksc->pdev->dev,
>> +                       "[%s]: clk %s round rate error!\n",
>> +                       __func__,
>> +                       clk_hw_get_name(hw));
>> +               return 0;
> Why isn't an error returned?

k230_clk_round_rate is indeed a callback function in clk_ops.

According to the documentation, the return value of this function should
be the final clock rate, not an error code[1].

This means that even when an error occurs, the function needs to return
a valid rate, rather than directly returning an error code.

Link:
https://elixir.bootlin.com/linux/v6.12.15/source/include/linux/clk-provider.h#L139
[1]

>> +       }
>> +
>> +       return div_u64((u64)(*parent_rate) * mul, div);
>> +}
>> +
>> +static int k230_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                            unsigned long parent_rate)
>> +{
>> +       struct k230_clk *clk = to_k230_clk(hw);
>> +       struct k230_sysclk *ksc = clk->ksc;
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[clk->id];
>> +       u32 div = 0, mul = 0, reg = 0, reg_c;
>> +
>> +       if (!cfg->have_rate || !cfg->rate_reg)
>> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "This clock may have no rate\n");
>> +
>> +       if (rate > parent_rate || rate == 0 || parent_rate == 0)
>> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "rate or parent_rate error\n");
>> +
>> +       if (cfg->read_only)
>> +               return dev_err_probe(&ksc->pdev->dev, -EPERM, "This clk rate is read only\n");
>> +
>> +       if (k230_clk_find_approximate(clk,
>> +                                     cfg->rate_mul_min, cfg->rate_mul_max,
>> +                                     cfg->rate_div_min, cfg->rate_div_max,
>> +                                     cfg->method, rate, parent_rate, &div, &mul))
>> +               return dev_err_probe(&ksc->pdev->dev, -EINVAL, "[%s]: clk %s set rate error!\n",
>> +                                    __func__, clk_hw_get_name(hw));
>> +
>> +       guard(spinlock)(&ksc->clk_lock);
>> +       if (!cfg->have_rate_c) {
>> +               reg = readl(cfg->rate_reg);
>> +               reg &= ~((cfg->rate_div_mask) << (cfg->rate_div_shift));
>> +
>> +               if (cfg->method == K230_DIV) {
>> +                       reg &= ~((cfg->rate_mul_mask) << (cfg->rate_mul_shift));
>> +                       reg |= ((div - 1) & cfg->rate_div_mask) << (cfg->rate_div_shift);
>> +               } else if (cfg->method == K230_MUL) {
>> +                       reg |= ((mul - 1) & cfg->rate_div_mask) << (cfg->rate_div_shift);
>> +               } else {
>> +                       reg |= (mul & cfg->rate_mul_mask) << (cfg->rate_mul_shift);
>> +                       reg |= (div & cfg->rate_div_mask) << (cfg->rate_div_shift);
>> +               }
>> +               reg |= BIT(cfg->rate_write_enable_bit);
>> +       } else {
>> +               reg = readl(cfg->rate_reg);
>> +               reg_c = readl(cfg->rate_reg_c);
>> +               reg &= ~((cfg->rate_div_mask) << (cfg->rate_div_shift));
>> +               reg_c &= ~((cfg->rate_mul_mask_c) << (cfg->rate_mul_shift_c));
>> +               reg_c |= BIT(cfg->rate_write_enable_bit_c);
>> +
>> +               reg_c |= (mul & cfg->rate_mul_mask_c) << (cfg->rate_mul_shift_c);
>> +               reg |= (div & cfg->rate_div_mask) << (cfg->rate_div_shift);
>> +
>> +               writel(reg_c, cfg->rate_reg_c);
>> +       }
>> +       writel(reg, cfg->rate_reg);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct clk_ops k230_clk_ops_arr[K230_CLK_OPS_ID_NUM] = {
>> +       [K230_CLK_OPS_ID_NONE] = {
>> +               /* Sentinel */
>> +       },
>> +       [K230_CLK_OPS_ID_GATE_ONLY] = {
>> +               K230_CLK_OPS_GATE,
>> +       },
>> +       [K230_CLK_OPS_ID_RATE_ONLY] = {
>> +               K230_CLK_OPS_RATE,
>> +       },
>> +       [K230_CLK_OPS_ID_RATE_GATE] = {
>> +               K230_CLK_OPS_RATE,
>> +               K230_CLK_OPS_GATE,
>> +       },
>> +       [K230_CLK_OPS_ID_MUX_ONLY] = {
>> +               K230_CLK_OPS_MUX,
>> +       },
>> +       [K230_CLK_OPS_ID_MUX_GATE] = {
>> +               K230_CLK_OPS_MUX,
>> +               K230_CLK_OPS_GATE,
>> +       },
>> +       [K230_CLK_OPS_ID_MUX_RATE] = {
>> +               K230_CLK_OPS_MUX,
>> +               K230_CLK_OPS_RATE,
>> +       },
>> +       [K230_CLK_OPS_ID_ALL] = {
>> +               K230_CLK_OPS_MUX,
>> +               K230_CLK_OPS_RATE,
>> +               K230_CLK_OPS_GATE,
>> +       },
>> +};
>> +
>> +static int k230_register_clk(struct platform_device *pdev,
>> +                            struct k230_sysclk *ksc,
>> +                            int id,
>> +                            const struct clk_parent_data *parent_data,
>> +                            u8 num_parents,
>> +                            unsigned long flags)
>> +{
>> +       struct k230_clk *clk = &ksc->clks[id];
>> +       struct k230_clk_cfg *cfg = &k230_clk_cfgs[id];
>> +       struct clk_init_data init = {};
>> +       int clk_id = 0;
>> +       int ret;
>> +
>> +       if (cfg->have_rate) {
>> +               cfg->rate_reg = (ksc->regs + cfg->rate_reg_off);
> Drop useless parenthesis please.
OK, I'll drop it.
>> +               clk_id += K230_CLK_OPS_ID_RATE_ONLY;
>> +       }
>> +
>> +       if (cfg->have_mux) {
>> +               cfg->mux_reg = (ksc->regs + cfg->mux_reg_off);
>> +               clk_id += K230_CLK_OPS_ID_MUX_ONLY;
>> +
>> +               /* mux clock doesn't match the case that num_parents less than 2 */
>> +               if (num_parents < 2)
>> +                       return -EINVAL;
>> +       }
>> +
>> +       if (cfg->have_gate) {
>> +               cfg->gate_reg = (ksc->regs + cfg->gate_reg_off);
> Drop useless parenthesis please.
OK, I'll drop it.
>> +               clk_id += K230_CLK_OPS_ID_GATE_ONLY;
>> +       }
>> +
>> +       if (cfg->have_rate_c)
>> +               cfg->rate_reg_c = (ksc->regs + cfg->rate_reg_off_c);
> Drop useless parenthesis please.
OK, I'll drop it.
>> +
>> +       init.name = k230_clk_cfgs[id].name;
>> +       init.flags = flags;
>> +       init.parent_data = parent_data;
>> +       init.num_parents = num_parents;
>> +       init.ops = &k230_clk_ops_arr[clk_id];
>> +
>> +       clk->id = id;
>> +       clk->ksc = ksc;
>> +       clk->hw.init = &init;
>> +
>> +       ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
>> +       if (ret)
>> +               return dev_err_probe(&pdev->dev,
>> +                                    ret,
>> +                                    "register clock %s failed\n",
>> +                                    k230_clk_cfgs[id].name);
>> +
>> +       return 0;
>> +}
>> +
>> +static int k230_register_mux_clk(struct platform_device *pdev,
>> +                                struct k230_sysclk *ksc,
>> +                                struct clk_parent_data *parent_data,
>> +                                int num_parent,
>> +                                int id)
>> +{
>> +       return k230_register_clk(pdev, ksc, id,
>> +                               (const struct clk_parent_data *)parent_data,
> Please remove useless cast.
OK, I'll drop it.
>> +                               num_parent, 0);
>> +}
>> +
>> +static int k230_register_osc24m_child(struct platform_device *pdev,
>> +                                     struct k230_sysclk *ksc,
>> +                                     int id)
>> +{
>> +       const struct clk_parent_data parent_data = {
>> +               .index = 0,
>> +       };
>> +       return k230_register_clk(pdev, ksc, id, &parent_data, 1, 0);
>> +}
>> +
>> +static int k230_register_pll_child(struct platform_device *pdev,
>> +                                  struct k230_sysclk *ksc,
>> +                                  int id,
>> +                                  enum k230_pll_id pll_id,
>> +                                  unsigned long flags)
>> +{
>> +       const struct clk_parent_data parent_data = {
>> +               .hw = &ksc->plls[pll_id].hw,
>> +       };
>> +       return k230_register_clk(pdev, ksc, id, &parent_data, 1, flags);
>> +}
>> +
>> +static int k230_register_pll_div_child(struct platform_device *pdev,
>> +                                      struct k230_sysclk *ksc,
>> +                                      int id,
>> +                                      enum k230_pll_div_id pll_div_id,
>> +                                      unsigned long flags)
>> +{
>> +       const struct clk_parent_data parent_data = {
>> +               .hw = ksc->dclks[pll_div_id].hw,
>> +       };
>> +       return k230_register_clk(pdev, ksc, id, &parent_data, 1, flags);
>> +}
>> +
>> +static int k230_register_clk_child(struct platform_device *pdev,
>> +                                  struct k230_sysclk *ksc,
>> +                                  int id,
>> +                                  int parent_id)
>> +{
>> +       const struct clk_parent_data parent_data = {
>> +               .hw = &ksc->clks[parent_id].hw,
>> +       };
>> +       return k230_register_clk(pdev, ksc, id, &parent_data, 1, 0);
>> +}
>> +
>> +static int _k230_clk_mux_get_parent_data(struct k230_sysclk *ksc,
>> +                                        struct k230_clk_parent *pclk,
>> +                                        struct clk_parent_data *parent_data)
>> +{
>> +       switch (pclk->type) {
>> +       case K230_OSC24M:
>> +               parent_data->index = 0;
>> +               break;
>> +       case K230_PLL:
>> +               parent_data->hw = &ksc->plls[pclk->pll_id].hw;
>> +               break;
>> +       case K230_PLL_DIV:
>> +               parent_data->hw = ksc->dclks[pclk->pll_div_id].hw;
>> +               break;
>> +       case K230_CLK_COMPOSITE:
>> +               parent_data->hw = &ksc->clks[pclk->clk_id].hw;
>> +               break;
>> +       default:
>> +               WARN_ON_ONCE(true);
>> +               return -EPERM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int k230_clk_mux_get_parent_data(struct k230_sysclk *ksc,
>> +                                       struct k230_clk_cfg *cfg,
>> +                                       struct clk_parent_data *parent_data,
>> +                                       int num_parent)
>> +{
>> +       int ret;
>> +       struct k230_clk_parent *pclk = cfg->parent;
>> +
>> +       for (int i = 0; i < num_parent; i++) {
>> +               ret = _k230_clk_mux_get_parent_data(ksc, &pclk[i], &parent_data[i]);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int k230_register_clks(struct platform_device *pdev, struct k230_sysclk *ksc)
>> +{
>> +       struct k230_clk_cfg *cfg;
>> +       struct k230_clk_parent *pclk;
>> +       struct clk_parent_data parent_data[K230_CLK_MAX_PARENT_NUM];
>> +       int ret, i;
>> +
>> +       /*
>> +        *  Single parent clock:
>> +        *  pll0_div2 sons: cpu0_src
>> +        *  pll0_div4 sons: cpu0_pclk
>> +        *  cpu0_src sons: cpu0_aclk, cpu0_plic, cpu0_noc_ddrcp4, pmu_pclk
>> +        *
>> +        *  Mux clock:
>> +        *  hs_ospi_src parents: pll0_div2, pll2_div4
>> +        */
>> +       for (i = 0; i < K230_CLK_NUM; i++) {
>> +               cfg = &k230_clk_cfgs[i];
>> +               if (!cfg->status)
>> +                       continue;
>> +
>> +               if (cfg->have_mux) {
>> +                       ret = k230_clk_mux_get_parent_data(ksc, cfg, parent_data,
>> +                                                          cfg->num_parent);
>> +                       if (ret)
>> +                               return dev_err_probe(&pdev->dev, ret,
>> +                                                    "Failed to get parent data\n");
>> +
>> +                       ret = k230_register_mux_clk(pdev, ksc, parent_data,
>> +                                                   cfg->num_parent, i);
>> +               } else {
>> +                       pclk = cfg->parent;
>> +                       switch (pclk->type) {
>> +                       case K230_OSC24M:
>> +                               ret = k230_register_osc24m_child(pdev, ksc, i);
>> +                               break;
>> +                       case K230_PLL:
>> +                               ret = k230_register_pll_child(pdev, ksc, i,
>> +                                                             pclk->pll_id, cfg->flags);
>> +                               break;
>> +                       case K230_PLL_DIV:
>> +                               ret = k230_register_pll_div_child(pdev, ksc, i,
>> +                                                                 pclk->pll_div_id, cfg->flags);
>> +                               break;
>> +                       case K230_CLK_COMPOSITE:
>> +                               ret = k230_register_clk_child(pdev, ksc, i,
>> +                                                             pclk->clk_id);
>> +                               break;
>> +                       default:
>> +                               return dev_err_probe(&pdev->dev, -EINVAL, "Invalid type\n");
>> +                       }
>> +               }
>> +               if (ret)
>> +                       return dev_err_probe(&pdev->dev, ret, "register child id %d failed\n", i);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static struct clk_hw *k230_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
>> +{
>> +       struct k230_sysclk *ksc;
>> +       unsigned int idx;
>> +
>> +       if (clkspec->args_count != 1)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       idx = clkspec->args[0];
>> +       if (idx >= K230_CLK_NUM)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!data)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       ksc = (struct k230_sysclk *)data;
> Drop useless cast please.
OK, I'll drop it.
>> +
>> +       return &ksc->clks[idx].hw;
>> +}
>> +
>> +static int k230_clk_init_plls(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct k230_sysclk *ksc = platform_get_drvdata(pdev);
>> +
>> +       spin_lock_init(&ksc->pll_lock);
>> +
>> +       ksc->pll_regs = devm_platform_ioremap_resource(pdev, 0);
>> +       if (!ksc->pll_regs)
> Does it return an error pointer or NULL on failure?The dev_err_probe()
> below is incorrect or the if condition above is.

Yes，I've checked it and confirmed that the if condition is incorrect [2].

So it should be:

if (IS_ERR(ksc->pll_regs))

Link:
https://elixir.bootlin.com/linux/v6.12.15/source/drivers/base/platform.c#L111
[2]

>
>> +               return dev_err_probe(&pdev->dev, PTR_ERR(ksc->pll_regs), "map registers failed\n");
> Doesn't this already print an error?
>
>> +
>> +       ret = k230_register_plls(pdev, ksc);
>> +       if (ret)
>> +               return dev_err_probe(&pdev->dev, ret, "register plls failed\n");
>> +
>> +       ret = k230_register_pll_divs(pdev, ksc);
>> +       if (ret)
>> +               return dev_err_probe(&pdev->dev, ret, "register pll_divs failed\n");
>> +
>> +       for (int i = 0; i < K230_PLL_DIV_NUM; i++) {
>> +               ret = devm_clk_hw_register_clkdev(&pdev->dev, ksc->dclks[i].hw,
>> +                                                 k230_pll_div_cfgs[i].name, NULL);
> Why is clkdev being used?

Here is my thought:

clkdev is used to register clock devices internally and associate them
with a specific device identifier (con_id). This allows some certain
clock consumers, can access the clock of PLL_DIVs using `clk_get()` and
related APIs.

In this case, while the PLL_DIVs are internal clocks, which not exposed
in the DT since they are only used within the driver. So I use
`register_clkdev()` to make PLLs clock accessible.

If there is anything I ignored or misunderstand, please feel free to
correct me.

>> +               if (ret)
>> +                       return dev_err_probe(&pdev->dev, ret, "clock_lookup create failed\n");
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int k230_clk_init_clks(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct k230_sysclk *ksc = platform_get_drvdata(pdev);
>> +
>> +       spin_lock_init(&ksc->clk_lock);
>> +
>> +       ksc->regs = devm_platform_ioremap_resource(pdev, 1);
>> +       if (!ksc->regs)
>> +               return dev_err_probe(&pdev->dev, PTR_ERR(ksc->regs), "failed to map registers\n");
>> +
>> +       ret = k230_register_clks(pdev, ksc);
>> +       if (ret)
>> +               return dev_err_probe(&pdev->dev, ret, "register clock provider failed\n");
>> +
>> +       ret = devm_of_clk_add_hw_provider(&pdev->dev, k230_clk_hw_onecell_get, ksc);
>> +       if (ret)
>> +               return dev_err_probe(&pdev->dev, ret, "add clock provider failed\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static int k230_clk_probe(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct k230_sysclk *ksc;
>> +
>> +       ksc = devm_kzalloc(&pdev->dev, sizeof(struct k230_sysclk), GFP_KERNEL);
>> +       if (!ksc)
>> +               return -ENOMEM;
>> +
>> +       ksc->plls = devm_kmalloc_array(&pdev->dev, K230_PLL_NUM,
> Any reason devm_kcalloc() isn't used?
Thanks for your reminder, I'll replace devm_kmalloc_array() with
devm_kcalloc() instead.
>> +                                      sizeof(struct k230_pll), GFP_KERNEL);
>> +       if (!ksc->plls)
>> +               return -ENOMEM;
>> +
>> +       ksc->dclks = devm_kmalloc_array(&pdev->dev, K230_PLL_DIV_NUM,
>> +                                       sizeof(struct k230_pll_div), GFP_KERNEL);
>> +       if (!ksc->dclks)
>> +               return -ENOMEM;
>> +
>> +       ksc->clks = devm_kmalloc_array(&pdev->dev, K230_CLK_NUM,
>> +                                      sizeof(struct k230_clk), GFP_KERNEL);
>> +       if (!ksc->clks)
>> +               return -ENOMEM;
>> +
>> +       ksc->pdev = pdev;
>> +       platform_set_drvdata(pdev, ksc);
>> +
>> +       ret = k230_clk_init_plls(pdev);
>> +       if (ret)
>> +               return dev_err_probe(&pdev->dev, ret, "init plls failed\n");
>> +
>> +       ret = k230_clk_init_clks(pdev);
>> +       if (ret)
>> +               return dev_err_probe(&pdev->dev, ret, "init clks failed\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id k230_clk_ids[] = {
>> +       { .compatible = "canaan,k230-clk" },
>> +       { /* Sentinel */ },
> Nitpick: Please drop last comma so that nothing can come after without
> causing a compilation error.
OK, I get it. Thanks for your reminder.
>> +};
>> +MODULE_DEVICE_TABLE(of, k230_clk_ids);
Thanks for your patient review!

