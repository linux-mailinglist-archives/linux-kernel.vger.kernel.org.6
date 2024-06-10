Return-Path: <linux-kernel+bounces-208219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC51690227A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4367C1F2567E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41477823CD;
	Mon, 10 Jun 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="cZI00csU"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013261FF6;
	Mon, 10 Jun 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025151; cv=none; b=hK5DkvHUHzoiMaQrBmVqRDpQf14L8Xygv2N+xDdrssDre4eCdMxI3PGSIYoFglquDzL7pQnYAP8fQLdPWsyKym203iPGD8i0fhDJclpOitFBX9M5H2EaeUENU7dOV4IXGHemSUXk5hd6ODkV9b1XZLV+de5t5WuqYEjb3MWyEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025151; c=relaxed/simple;
	bh=ymeOZU7Z2tgdqyG1BMQRe55vCcHS2BQDdDO3NvijkUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfyJcKMrA4CKz2H0XXTpig0GRa6hjB1IEH7EvHTyCyIcGZrU6r2AOtKr55sipqZ0tsEfnu+CtbUvkJHzqrANCZKoEYEkJaM66JcFBp+40Z2Bni0DG79gOjsYZr4uEmWFfDi7CZvKigzVx4MmyuEw838LZB/A4RRIR43j/86fgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=cZI00csU; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5C69A120006;
	Mon, 10 Jun 2024 16:12:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5C69A120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718025145;
	bh=IWZrEwuTJkoogvnkxqBjRGrdkBJ1nExW1PH+tGB1JV4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=cZI00csUWK7nsz5ngl+sFZ+eEfWCnXrncjuMczxN/ArQhIZ7r7L5u4GAAb68huASr
	 9tjxRx5AIudNcD5P2QwlaOx3m3PZXeheTRpwO/3vkqS+yzq+YylytunwafIr/aGvQh
	 Paj8M/Q9hJW1wGGO3EdrUV98EdkuVzX5VYj3aKkDcdd+9VtbS1COF244zaYd5ZmCCm
	 19sBZVIUftbQbZvIcZkkjYnm4h4wgRi1xVacIFSiJx+6SosLbhKSBfxT8UstcPCHBP
	 y6m0xWqLnJJodoAdKCHaWLA1+L4ihH0LM7olgnHlGdwZTPGG9kqzcZRbvcXC5OVS8m
	 zLF1TRnQXxIUg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Jun 2024 16:12:25 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 10 Jun
 2024 16:12:24 +0300
Date: Mon, 10 Jun 2024 16:12:24 +0300
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
Subject: Re: [PATCH v3 3/7] clk: meson: a1: pll: support 'syspll'
 general-purpose PLL for CPU clock
Message-ID: <20240610131224.u7u4ov245igatavj@CAB-WSD-L081021>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
 <20240515185103.20256-4-ddrokosov@salutedevices.com>
 <1jzfrtp12h.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jzfrtp12h.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185833 [Jun 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/10 11:09:00 #25535815
X-KSMG-AntiVirus-Status: Clean, skipped

On Mon, Jun 10, 2024 at 12:03:02PM +0200, Jerome Brunet wrote:
> On Wed 15 May 2024 at 21:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > The 'syspll' PLL, also known as the system PLL, is a general and
> > essential PLL responsible for generating the CPU clock frequency.
> > With its wide-ranging capabilities, it is designed to accommodate
> > frequencies within the range of 768MHz to 1536MHz.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  drivers/clk/meson/a1-pll.c | 72 ++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/meson/a1-pll.h |  6 ++++
> >  2 files changed, 78 insertions(+)
> >
> > diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> > index 60b2e53e7e51..286e83199d17 100644
> > --- a/drivers/clk/meson/a1-pll.c
> > +++ b/drivers/clk/meson/a1-pll.c
> > @@ -138,6 +138,76 @@ static struct clk_regmap hifi_pll = {
> >  	},
> >  };
> >  
> > +static const struct pll_mult_range sys_pll_mult_range = {
> > +	.min = 32,
> > +	.max = 64,
> > +};
> > +
> > +static const struct reg_sequence sys_pll_init_regs[] = {
> > +	{ .reg = ANACTRL_SYSPLL_CTRL1, .def = 0x01800000 },
> > +	{ .reg = ANACTRL_SYSPLL_CTRL2, .def = 0x00001100 },
> > +	{ .reg = ANACTRL_SYSPLL_CTRL3, .def = 0x10022300 },
> > +	{ .reg = ANACTRL_SYSPLL_CTRL4, .def = 0x00300000 },
> > +	{ .reg = ANACTRL_SYSPLL_CTRL0, .def = 0x01f18432 },
> 
> That last entry is clearly an hard coded rate being poked.
> Drop it please
> 

Ah, of course, you are totally right. I will remove hard coded rate in
the next version.

> > +};
> > +
> > +static struct clk_regmap sys_pll = {
> > +	.data = &(struct meson_clk_pll_data){
> > +		.en = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 28,
> > +			.width   = 1,
> > +		},
> > +		.m = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 0,
> > +			.width   = 8,
> > +		},
> > +		.n = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 10,
> > +			.width   = 5,
> > +		},
> > +		.frac = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL1,
> > +			.shift   = 0,
> > +			.width   = 19,
> > +		},
> > +		.l = {
> > +			.reg_off = ANACTRL_SYSPLL_STS,
> > +			.shift   = 31,
> > +			.width   = 1,
> > +		},
> > +		.current_en = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 26,
> > +			.width   = 1,
> > +		},
> > +		.l_detect = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL2,
> > +			.shift   = 6,
> > +			.width   = 1,
> > +		},
> > +		.range = &sys_pll_mult_range,
> > +		.init_regs = sys_pll_init_regs,
> > +		.init_count = ARRAY_SIZE(sys_pll_init_regs),
> > +		/*
> > +		 * The sys_pll clock is usually enabled and initialized in the
> > +		 * bootloader stage. Additionally, the cpu_clk is connected to
> > +		 * sys_pll. As a result, it is not allowed to initialize the
> > +		 * cpu_clk again, as doing so would prevent the CPU from
> > +		 * executing any instructions.
> > +		 */
> > +		.flags = CLK_MESON_PLL_NOINIT_ENABLED,
> > +	},
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "sys_pll",
> > +		.ops = &meson_clk_pll_ops,
> > +		.parent_names = (const char *[]){ "syspll_in" },
> > +		.num_parents = 1,
> > +	},
> > +};
> > +
> >  static struct clk_fixed_factor fclk_div2_div = {
> >  	.mult = 1,
> >  	.div = 2,
> > @@ -283,6 +353,7 @@ static struct clk_hw *a1_pll_hw_clks[] = {
> >  	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
> >  	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
> >  	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
> > +	[CLKID_SYS_PLL]		= &sys_pll.hw,
> >  };
> >  
> >  static struct clk_regmap *const a1_pll_regmaps[] = {
> > @@ -293,6 +364,7 @@ static struct clk_regmap *const a1_pll_regmaps[] = {
> >  	&fclk_div5,
> >  	&fclk_div7,
> >  	&hifi_pll,
> > +	&sys_pll,
> >  };
> >  
> >  static struct regmap_config a1_pll_regmap_cfg = {
> > diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> > index 4be17b2bf383..666d9b2137e9 100644
> > --- a/drivers/clk/meson/a1-pll.h
> > +++ b/drivers/clk/meson/a1-pll.h
> > @@ -18,6 +18,12 @@
> >  #define ANACTRL_FIXPLL_CTRL0	0x0
> >  #define ANACTRL_FIXPLL_CTRL1	0x4
> >  #define ANACTRL_FIXPLL_STS	0x14
> > +#define ANACTRL_SYSPLL_CTRL0	0x80
> > +#define ANACTRL_SYSPLL_CTRL1	0x84
> > +#define ANACTRL_SYSPLL_CTRL2	0x88
> > +#define ANACTRL_SYSPLL_CTRL3	0x8c
> > +#define ANACTRL_SYSPLL_CTRL4	0x90
> > +#define ANACTRL_SYSPLL_STS	0x94
> >  #define ANACTRL_HIFIPLL_CTRL0	0xc0
> >  #define ANACTRL_HIFIPLL_CTRL1	0xc4
> >  #define ANACTRL_HIFIPLL_CTRL2	0xc8
> 
> -- 
> Jerome

-- 
Thank you,
Dmitry

