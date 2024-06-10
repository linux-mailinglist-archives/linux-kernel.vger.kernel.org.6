Return-Path: <linux-kernel+bounces-208836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3269029BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BCE285F02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3D14F9CC;
	Mon, 10 Jun 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="QuuLqwCx"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D41B812;
	Mon, 10 Jun 2024 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050230; cv=none; b=Q3Z+Sd1LmEIgKTQc25aY1IZFxzV9xYLyyPh9vh3RmmN4CZ8oYAv0Rh6hK+Hqb/u9LRnGAzYJEeBiLCtgNDwLvJEUgtlCNIhFBxWUf5Hxr1ArcD7mogirL2O9dBHF7osYOQY/OGOPWj1HLFr3K5cuxfZvzTsjX/mDomQMUBFpYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050230; c=relaxed/simple;
	bh=6uixyUWYSj3kgndB5cgUrZNGgpCXWIIZ9W1XOnK8m5k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeRdO0HjMfQlPS+niruuxYiqH+352kbh8Fr3z0JubopgeH6ojpSNt6a7+yG4XXfygx1MIZ62EGcSa6V5cQfsPkcvaOgpd5+55ESdrEUVteLmB2R+oQoeNrr9/x+dr2GHFRu61Wv0SXUSCBtwK8qYNj9FX56NVTTWcxNj7mYSHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=QuuLqwCx; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DDC78120002;
	Mon, 10 Jun 2024 23:10:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DDC78120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718050221;
	bh=CyjAD39Adp9YwtacIJu4i0hG6rQt5kSGw9YY6Ugq/9U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=QuuLqwCxereQliyq65cKfCVAjsgIdKyiQjvZOA4iEWZyIGzvCqXalBYideWIO4VAa
	 wF2FNblb8PntwV+ncoMago15ud6S3gi1d33ktZ2NpOLt1okDA0T99VQlo/XNmg98ZO
	 Gq2gWpToFdUkAJi3WkAFY2d1PDTUPPvQexK9Oo1BrksmA4Tk9Y35xcQMksjtJHAQkn
	 4uCNJL4saexygvckBqYOZ0IVkasb+UtvPe5Z+9tQxaH73GFMTG5JV5h8sg21xJssu8
	 O0WYwVkQqb+CPvMg9aO2YyZsJPbygBfyxd+khBgZ8Un8JK1jVz+qLJAhN9Kx6RGgv/
	 gJ40wS8EmnHyA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Jun 2024 23:10:21 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 10 Jun
 2024 23:10:21 +0300
Date: Mon, 10 Jun 2024 23:10:16 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 7/7] clk: meson: a1: add Amlogic A1 CPU clock
 controller driver
Message-ID: <20240610201016.3ufzf6oh43sccxqx@CAB-WSD-L081021>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
 <20240515185103.20256-8-ddrokosov@salutedevices.com>
 <1jmsntp0wo.fsf@starbuckisacylon.baylibre.com>
 <20240610130824.dt7matrj4tespizl@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240610130824.dt7matrj4tespizl@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185845 [Jun 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/10 15:05:00 #25537858
X-KSMG-AntiVirus-Status: Clean, skipped

On Mon, Jun 10, 2024 at 04:08:24PM +0300, Dmitry Rokosov wrote:
> On Mon, Jun 10, 2024 at 12:06:31PM +0200, Jerome Brunet wrote:
> > On Wed 15 May 2024 at 21:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> > 
> > > The CPU clock controller plays a general role in the Amlogic A1 SoC
> > > family by generating CPU clocks. As an APB slave module, it offers the
> > > capability to inherit the CPU clock from two sources: the internal fixed
> > > clock known as 'cpu fixed clock' and the external input provided by the
> > > A1 PLL clock controller, referred to as 'syspll'.
> > >
> > > It is important for the driver to handle cpu_clk rate switching
> > > effectively by transitioning to the CPU fixed clock to avoid any
> > > potential execution freezes.
> > >
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > ---
> > >  drivers/clk/meson/Kconfig  |  10 ++
> > >  drivers/clk/meson/Makefile |   1 +
> > >  drivers/clk/meson/a1-cpu.c | 331 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 342 insertions(+)
> > >  create mode 100644 drivers/clk/meson/a1-cpu.c
> > >
> > > diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> > > index 80c4a18c83d2..148d4495eee3 100644
> > > --- a/drivers/clk/meson/Kconfig
> > > +++ b/drivers/clk/meson/Kconfig
> > > @@ -111,6 +111,16 @@ config COMMON_CLK_AXG_AUDIO
> > >  	  Support for the audio clock controller on AmLogic A113D devices,
> > >  	  aka axg, Say Y if you want audio subsystem to work.
> > >  
> > > +config COMMON_CLK_A1_CPU
> > > +	tristate "Amlogic A1 SoC CPU controller support"
> > > +	depends on ARM64
> > > +	select COMMON_CLK_MESON_REGMAP
> > > +	select COMMON_CLK_MESON_CLKC_UTILS
> > > +	help
> > > +	  Support for the CPU clock controller on Amlogic A113L based
> > > +	  device, A1 SoC Family. Say Y if you want A1 CPU clock controller
> > > +	  to work.
> > > +
> > >  config COMMON_CLK_A1_PLL
> > >  	tristate "Amlogic A1 SoC PLL controller support"
> > >  	depends on ARM64
> > > diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> > > index 4968fc7ad555..2a06eb0303d6 100644
> > > --- a/drivers/clk/meson/Makefile
> > > +++ b/drivers/clk/meson/Makefile
> > > @@ -18,6 +18,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_AUDIO_RSTC) += meson-audio-rstc.o
> > >  
> > >  obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
> > >  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
> > > +obj-$(CONFIG_COMMON_CLK_A1_CPU) += a1-cpu.o
> > >  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
> > >  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
> > >  obj-$(CONFIG_COMMON_CLK_A1_AUDIO) += a1-audio.o
> > > diff --git a/drivers/clk/meson/a1-cpu.c b/drivers/clk/meson/a1-cpu.c
> > > new file mode 100644
> > > index 000000000000..a9edabeafea9
> > > --- /dev/null
> > > +++ b/drivers/clk/meson/a1-cpu.c
> > > @@ -0,0 +1,331 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Amlogic A1 SoC family CPU Clock Controller driver.
> > > + *
> > > + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> > > + * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/platform_device.h>
> > > +#include "clk-regmap.h"
> > > +#include "meson-clkc-utils.h"
> > > +
> > > +#include <dt-bindings/clock/amlogic,a1-cpu-clkc.h>
> > > +
> > > +/* CPU Clock Controller register offset */
> > > +#define CPUCTRL_CLK_CTRL0	0x0
> > > +#define CPUCTRL_CLK_CTRL1	0x4
> > > +
> > > +static u32 cpu_fsource_sel_table[] = { 0, 1, 2 };
> > > +static const struct clk_parent_data cpu_fsource_sel_parents[] = {
> > > +	{ .fw_name = "xtal" },
> > > +	{ .fw_name = "fclk_div2" },
> > > +	{ .fw_name = "fclk_div3" },
> > > +};
> > > +
> > > +static struct clk_regmap cpu_fsource_sel0 = {
> > > +	.data = &(struct clk_regmap_mux_data) {
> > > +		.offset = CPUCTRL_CLK_CTRL0,
> > > +		.mask = 0x3,
> > > +		.shift = 0,
> > > +		.table = cpu_fsource_sel_table,
> > > +	},
> > > +	.hw.init = &(struct clk_init_data) {
> > > +		.name = "cpu_fsource_sel0",
> > > +		.ops = &clk_regmap_mux_ops,
> > > +		.parent_data = cpu_fsource_sel_parents,
> > > +		.num_parents = ARRAY_SIZE(cpu_fsource_sel_parents),
> > > +		.flags = CLK_SET_RATE_PARENT,
> > 
> > I don't think setting the rates of controller parents is appropriate
> > 
> > > +	},
> > > +};
> > > +
> > > +static struct clk_regmap cpu_fsource_div0 = {
> > > +	.data = &(struct clk_regmap_div_data) {
> > > +		.offset = CPUCTRL_CLK_CTRL0,
> > > +		.shift = 4,
> > > +		.width = 6,
> > > +	},
> > > +	.hw.init = &(struct clk_init_data) {
> > > +		.name = "cpu_fsource_div0",
> > > +		.ops = &clk_regmap_divider_ops,
> > > +		.parent_hws = (const struct clk_hw *[]) {
> > > +			&cpu_fsource_sel0.hw
> > > +		},
> > > +		.num_parents = 1,
> > > +		.flags = CLK_SET_RATE_PARENT,
> > > +	},
> > > +};
> > > +
> > > +static struct clk_regmap cpu_fsel0 = {
> > > +	.data = &(struct clk_regmap_mux_data) {
> > > +		.offset = CPUCTRL_CLK_CTRL0,
> > > +		.mask = 0x1,
> > > +		.shift = 2,
> > > +	},
> > > +	.hw.init = &(struct clk_init_data) {
> > > +		.name = "cpu_fsel0",
> > > +		.ops = &clk_regmap_mux_ops,
> > > +		.parent_hws = (const struct clk_hw *[]) {
> > > +			&cpu_fsource_sel0.hw,
> > > +			&cpu_fsource_div0.hw,
> > > +		},
> > > +		.num_parents = 2,
> > > +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> > > +	},
> > > +};
> > > +
> > > +static struct clk_regmap cpu_fsource_sel1 = {
> > > +	.data = &(struct clk_regmap_mux_data) {
> > > +		.offset = CPUCTRL_CLK_CTRL0,
> > > +		.mask = 0x3,
> > > +		.shift = 16,
> > > +		.table = cpu_fsource_sel_table,
> > > +	},
> > > +	.hw.init = &(struct clk_init_data) {
> > > +		.name = "cpu_fsource_sel1",
> > > +		.ops = &clk_regmap_mux_ops,
> > > +		.parent_data = cpu_fsource_sel_parents,
> > > +		.num_parents = ARRAY_SIZE(cpu_fsource_sel_parents),
> > > +		.flags = CLK_SET_RATE_PARENT,
> > > +	},
> > > +};
> > > +
> > > +static struct clk_regmap cpu_fsource_div1 = {
> > > +	.data = &(struct clk_regmap_div_data) {
> > > +		.offset = CPUCTRL_CLK_CTRL0,
> > > +		.shift = 20,
> > > +		.width = 6,
> > > +	},
> > > +	.hw.init = &(struct clk_init_data) {
> > > +		.name = "cpu_fsource_div1",
> > > +		.ops = &clk_regmap_divider_ops,
> > > +		.parent_hws = (const struct clk_hw *[]) {
> > > +			&cpu_fsource_sel1.hw
> > > +		},
> > > +		.num_parents = 1,
> > > +		.flags = CLK_SET_RATE_PARENT,
> > > +	},
> > > +};
> > > +
> > > +static struct clk_regmap cpu_fsel1 = {
> > > +	.data = &(struct clk_regmap_mux_data) {
> > > +		.offset = CPUCTRL_CLK_CTRL0,
> > > +		.mask = 0x1,
> > > +		.shift = 18,
> > > +	},
> > > +	.hw.init = &(struct clk_init_data) {
> > > +		.name = "cpu_fsel1",
> > > +		.ops = &clk_regmap_mux_ops,
> > > +		.parent_hws = (const struct clk_hw *[]) {
> > > +			&cpu_fsource_sel1.hw,
> > > +			&cpu_fsource_div1.hw,
> > > +		},
> > > +		.num_parents = 2,
> > > +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> > > +	},
> > > +};
> > > +
> > > +static struct clk_regmap cpu_fclk = {
> > > +	.data = &(struct clk_regmap_mux_data) {
> > > +		.offset = CPUCTRL_CLK_CTRL0,
> > > +		.mask = 0x1,
> > > +		.shift = 10,
> > > +	},
> > > +	.hw.init = &(struct clk_init_data) {
> > > +		.name = "cpu_fclk",
> > > +		.ops = &clk_regmap_mux_ops,
> > > +		.parent_hws = (const struct clk_hw *[]) {
> > > +			&cpu_fsel0.hw,
> > > +			&cpu_fsel1.hw,
> > > +		},
> > > +		.num_parents = 2,
> > > +		.flags = CLK_SET_RATE_PARENT,
> > > +	},
> > > +};
> > > +
> > > +static struct clk_regmap cpu_clk = {
> > > +	.data = &(struct clk_regmap_mux_data) {
> > > +		.offset = CPUCTRL_CLK_CTRL0,
> > > +		.mask = 0x1,
> > > +		.shift = 11,
> > > +	},
> > > +	.hw.init = &(struct clk_init_data) {
> > > +		.name = "cpu_clk",
> > > +		.ops = &clk_regmap_mux_ops,
> > > +		.parent_data = (const struct clk_parent_data []) {
> > > +			{ .hw = &cpu_fclk.hw },
> > > +			{ .fw_name = "sys_pll", },
> > > +		},
> > 
> > You've put CLK_SET_RATE_GATE on fixed clock path but not the SYS_PLL
> > ... that is odd. IMO there should be a bypass input clock to the sys_pll
> > with that flag.
> > 
> 
> Apologies for any confusion caused. To clarify, are you proposing the
> idea of creating an additional sys_pll_input clock object with the
> CLK_SET_RATE_PARENT property, and then using it as the parent clock for
> cpu_clk?
> 
> > > +		.num_parents = 2,
> > > +		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> > > +	},
> > > +};
> > > +
> > > +/* Array of all clocks registered by this provider */
> > > +static struct clk_hw *a1_cpu_hw_clks[] = {
> > > +	[CLKID_CPU_FSOURCE_SEL0]	= &cpu_fsource_sel0.hw,
> > > +	[CLKID_CPU_FSOURCE_DIV0]	= &cpu_fsource_div0.hw,
> > > +	[CLKID_CPU_FSEL0]		= &cpu_fsel0.hw,
> > > +	[CLKID_CPU_FSOURCE_SEL1]	= &cpu_fsource_sel1.hw,
> > > +	[CLKID_CPU_FSOURCE_DIV1]	= &cpu_fsource_div1.hw,
> > > +	[CLKID_CPU_FSEL1]		= &cpu_fsel1.hw,
> > > +	[CLKID_CPU_FCLK]		= &cpu_fclk.hw,
> > > +	[CLKID_CPU_CLK]			= &cpu_clk.hw,
> > > +};
> > > +
> > > +static struct clk_regmap *const a1_cpu_regmaps[] = {
> > > +	&cpu_fsource_sel0,
> > > +	&cpu_fsource_div0,
> > > +	&cpu_fsel0,
> > > +	&cpu_fsource_sel1,
> > > +	&cpu_fsource_div1,
> > > +	&cpu_fsel1,
> > > +	&cpu_fclk,
> > > +	&cpu_clk,
> > > +};
> > > +
> > > +static struct regmap_config a1_cpu_regmap_cfg = {
> > > +	.reg_bits   = 32,
> > > +	.val_bits   = 32,
> > > +	.reg_stride = 4,
> > > +	.max_register = CPUCTRL_CLK_CTRL1,
> > > +};
> > > +
> > > +static struct meson_clk_hw_data a1_cpu_clks = {
> > > +	.hws = a1_cpu_hw_clks,
> > > +	.num = ARRAY_SIZE(a1_cpu_hw_clks),
> > > +};
> > > +
> > > +struct a1_sys_pll_nb_data {
> > > +	struct notifier_block nb;
> > > +	struct clk_hw *cpu_clk;
> > > +	struct clk_hw *cpu_fclk;
> > > +	struct clk *sys_pll;
> > > +};
> > 
> > There are number of things which are wrong with this notifier.
> > 
> > First, and foremost, this is a clock controller driver ... it should not
> > handle cpufreq policy. There is subsystem for that
> > 
> > > +
> > > +static int meson_a1_sys_pll_notifier_cb(struct notifier_block *nb,
> > > +					unsigned long event, void *data)
> > > +{
> > > +	struct a1_sys_pll_nb_data *nbd;
> > > +	int ret = 0;
> > > +
> > > +	nbd = container_of(nb, struct a1_sys_pll_nb_data, nb);
> > > +
> > > +	switch (event) {
> > > +	case PRE_RATE_CHANGE:
> > > +		/*
> > > +		 * Clock sys_pll will be changed to feed cpu_clk,
> > > +		 * configure cpu_clk to use cpu_fclk fixed clock.
> > > +		 */
> > > +		ret = clk_hw_set_parent(nbd->cpu_clk, nbd->cpu_fclk);
> > 
> > 
> > This jumps to whatever was the last frequency below 768MHz ... that does
> > not seems deterministic or safe.
> 
> Ah, that's an aspect I hadn't considered. You make a valid point. So,
> this implies that the g12a clock driver could potentially encounter the
> same issue, correct?
> 
> > > +
> > > +		/* Wait for clock propagation */
> > > +		if (!ret)
> > > +			udelay(100);
> > > +
> > > +		break;
> > > +
> > > +	case POST_RATE_CHANGE:
> > > +		 /*
> > > +		  * Clock sys_pll rate has ben calculated,
> > > +		  * switch back cpu_clk to sys_pll
> > > +		  */
> > > +		ret = clk_set_parent(nbd->cpu_clk->clk, nbd->sys_pll);
> > 
> > So whenever sys_pll changes, even if was not used by the CPU at that
> > time, this will change back to the sys_pll. Again, that seems fragile
> > 
> 
> From what I comprehend, only the GEN clock is capable of using sys_pll
> as its parent clock. The GEN clock seems more comparable to a diagnostic
> clock, implying that when utilized, it should be done with full
> awareness and control over its operations.
> 
> > > +
> > > +		/* Wait for clock propagation */
> > > +		if (!ret)
> > > +			udelay(100);
> > > +		break;
> > > +
> > > +	default:
> > > +		pr_warn("Unknown event %lu for sys_pll notifier\n", event);
> > > +		break;
> > > +	}
> > > +
> > > +	return notifier_from_errno(ret);
> > > +}
> > > +
> > > +static struct a1_sys_pll_nb_data a1_sys_pll_nb_data = {
> > > +	.nb.notifier_call = meson_a1_sys_pll_notifier_cb,
> > > +	.cpu_clk = &cpu_clk.hw,
> > > +	.cpu_fclk = &cpu_fclk.hw,
> > > +};
> > > +
> > > +static int meson_a1_dvfs_setup(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct clk *sys_pll;
> > > +	int ret;
> > > +
> > > +	/* Setup clock notifier for sys_pll clk */
> > > +	sys_pll = devm_clk_get(dev, "sys_pll");
> > > +	if (IS_ERR(sys_pll))
> > > +		return dev_err_probe(dev, PTR_ERR(sys_pll),
> > > +				     "can't get sys_pll as notifier clock\n");
> > > +
> > > +	a1_sys_pll_nb_data.sys_pll = sys_pll;
> > > +	ret = devm_clk_notifier_register(dev, sys_pll,
> > > +					 &a1_sys_pll_nb_data.nb);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret,
> > > +				     "can't register sys_pll notifier\n");
> > > +
> > > +	return ret;
> > > +}
> > 
> > I don't think these notifiers are appropriate to handle CPU frequency
> > change. Cpufreq has a .target_intermediate() callback that seems more
> > appropriate to switch the CPU to a safe clock while relocking a PLL.
> > 
> > You should have a look at it and probably at the imx-cpufreq-dt.c which
> > improves on cpufreq-dt.c to handle platform quirks
> > 
> 
> I believed that the same approach was employed with the g12a clock,
> which uses a sys_pll <-> cpu fixed clock transition to ensure stable CPU
> clocking. Am I overlooking something? Or does the g12a cpu clock
> maintain a fixed frequency, thus indicating it is not fragile?
> 
> [...]

Based on your suggestion, I explored the imx-cpufreq-dt driver and it
does seem like a more suitable place to implement CPU clock switching.
Thank you for pointing that out!

However, from my understanding, it appears that we also need to redesign
the g12a clock driver's CPU clock notifier. I would love to hear your
thoughts on this. It seems like a necessary step to ensure a
comprehensive solution.

-- 
Thank you,
Dmitry

