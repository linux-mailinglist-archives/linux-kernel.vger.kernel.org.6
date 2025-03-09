Return-Path: <linux-kernel+bounces-553275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23180A586C2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59033A7D22
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1EE211C;
	Sun,  9 Mar 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="TU7XzauZ"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E51DE3DC;
	Sun,  9 Mar 2025 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543310; cv=none; b=RnLzKtiidteqTAtepOXppApXn2nInz6/A15hCWXlPon3S40m8kchvZjmLF8O8IPqI1PmP7kX8nZRVdMbcEdCwwFGpdb0k4eDJOC2ln/zEofesEAysb3yxYWPyKZ912r8QGAwX70RTJkKmiHoSpgdxNG92NQaiC8Xu3CjbtHsOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543310; c=relaxed/simple;
	bh=ZU1fmi6ivFzGpdhMZxzV6WGWRnvQLDDEPgysJT9TpQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iuaa2p9d1TvV+nHm5XkwZLyRP6g3Ioc6yyCv0I2yG3E9nQiJUvbP5QKNvNDN+Y6mftYyTHI83CO0uuvKMa2cnVlFrAs4BcPWydsh0Fdc7fhZlF9Zx3F7njCAWRvQNtXskK0eio5m9dMG5hj5XaqWbFSsKSCrZAeBod7yjdlD34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=TU7XzauZ; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8D0EB120007;
	Sun,  9 Mar 2025 21:01:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8D0EB120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741543305;
	bh=9fgA03LfHiWmeaRJrpYffPekor2V22pSrU9sNngs1OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=TU7XzauZelETrPd25UXeJRbLkUgWER7dXmF66zy26S4j56Z0nVG0MF6qPO9fq+DUh
	 OEzqKjO2fge1tOpyeYG3CokSPIbuMxisz71y0hPQW/8g3y23U880HGGkbbDXuqQSsr
	 mGMWlIk0rZLDJL9HHC2us8ZQ/l+OIPFFyur+a1BTRJZi5aZuhqtbAnvq8FANF/nhgk
	 ai3Vq5sXJdeeScyI/ZWMIAJYSaYP0j4W2b56lXEutuWOEu8qKasHbUi9lc/ot3kA7a
	 Dsgvgj8e/t3polS82zujWB2zSa/YDpCXfTvq9f5gtWGnbTb4cIqnLhaZ+oY3VxFtRP
	 nJoukniavVImw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:01:45 +0300 (MSK)
Message-ID: <5a5353e0-e49a-4b6b-b007-ea6cfcb2f827@salutedevices.com>
Date: Sun, 9 Mar 2025 21:01:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] clk: meson: axg: share the set of audio helper
 macros
To: Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome
 Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
References: <20250309175838.1322014-1-jan.dakinevich@salutedevices.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20250309175838.1322014-1-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191599 [Mar 09 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

Please, ignore the series.

On 3/9/25 20:58, Jan Dakinevich wrote:
>  - These macros will be used in upcoming audio clock controller
>     for A1 SoC;
> 
>  - AUD_PCLK_GATE() macro got an extra parameter to be more flexible.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  drivers/clk/meson/axg-audio.c   | 215 ++++++--------------------------
>  drivers/clk/meson/meson-audio.h | 156 +++++++++++++++++++++++
>  2 files changed, 191 insertions(+), 180 deletions(-)
>  create mode 100644 drivers/clk/meson/meson-audio.h
> 
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 3948f5d0faca..7c4b0c722a94 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  
>  #include "meson-clkc-utils.h"
> +#include "meson-audio.h"
>  #include "axg-audio.h"
>  #include "clk-regmap.h"
>  #include "clk-phase.h"
> @@ -23,155 +24,9 @@
>  
>  #include <dt-bindings/clock/axg-audio-clkc.h>
>  
> -#define AUD_GATE(_name, _reg, _bit, _pname, _iflags) {			\
> -	.data = &(struct clk_regmap_gate_data){				\
> -		.offset = (_reg),					\
> -		.bit_idx = (_bit),					\
> -	},								\
> -	.hw.init = &(struct clk_init_data) {				\
> -		.name = "aud_"#_name,					\
> -		.ops = &clk_regmap_gate_ops,				\
> -		.parent_names = (const char *[]){ #_pname },		\
> -		.num_parents = 1,					\
> -		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
> -	},								\
> -}
> -
> -#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags) {	\
> -	.data = &(struct clk_regmap_mux_data){				\
> -		.offset = (_reg),					\
> -		.mask = (_mask),					\
> -		.shift = (_shift),					\
> -		.flags = (_dflags),					\
> -	},								\
> -	.hw.init = &(struct clk_init_data){				\
> -		.name = "aud_"#_name,					\
> -		.ops = &clk_regmap_mux_ops,				\
> -		.parent_data = _pdata,					\
> -		.num_parents = ARRAY_SIZE(_pdata),			\
> -		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
> -	},								\
> -}
> -
> -#define AUD_DIV(_name, _reg, _shift, _width, _dflags, _pname, _iflags) { \
> -	.data = &(struct clk_regmap_div_data){				\
> -		.offset = (_reg),					\
> -		.shift = (_shift),					\
> -		.width = (_width),					\
> -		.flags = (_dflags),					\
> -	},								\
> -	.hw.init = &(struct clk_init_data){				\
> -		.name = "aud_"#_name,					\
> -		.ops = &clk_regmap_divider_ops,				\
> -		.parent_names = (const char *[]){ #_pname },		\
> -		.num_parents = 1,					\
> -		.flags = (_iflags),					\
> -	},								\
> -}
> -
> -#define AUD_PCLK_GATE(_name, _reg, _bit) {				\
> -	.data = &(struct clk_regmap_gate_data){				\
> -		.offset = (_reg),					\
> -		.bit_idx = (_bit),					\
> -	},								\
> -	.hw.init = &(struct clk_init_data) {				\
> -		.name = "aud_"#_name,					\
> -		.ops = &clk_regmap_gate_ops,				\
> -		.parent_names = (const char *[]){ "aud_top" },		\
> -		.num_parents = 1,					\
> -	},								\
> -}
> -
> -#define AUD_SCLK_DIV(_name, _reg, _div_shift, _div_width,		\
> -		     _hi_shift, _hi_width, _pname, _iflags) {		\
> -	.data = &(struct meson_sclk_div_data) {				\
> -		.div = {						\
> -			.reg_off = (_reg),				\
> -			.shift   = (_div_shift),			\
> -			.width   = (_div_width),			\
> -		},							\
> -		.hi = {							\
> -			.reg_off = (_reg),				\
> -			.shift   = (_hi_shift),				\
> -			.width   = (_hi_width),				\
> -		},							\
> -	},								\
> -	.hw.init = &(struct clk_init_data) {				\
> -		.name = "aud_"#_name,					\
> -		.ops = &meson_sclk_div_ops,				\
> -		.parent_names = (const char *[]){ #_pname },		\
> -		.num_parents = 1,					\
> -		.flags = (_iflags),					\
> -	},								\
> -}
> -
> -#define AUD_TRIPHASE(_name, _reg, _width, _shift0, _shift1, _shift2,	\
> -		     _pname, _iflags) {					\
> -	.data = &(struct meson_clk_triphase_data) {			\
> -		.ph0 = {						\
> -			.reg_off = (_reg),				\
> -			.shift   = (_shift0),				\
> -			.width   = (_width),				\
> -		},							\
> -		.ph1 = {						\
> -			.reg_off = (_reg),				\
> -			.shift   = (_shift1),				\
> -			.width   = (_width),				\
> -		},							\
> -		.ph2 = {						\
> -			.reg_off = (_reg),				\
> -			.shift   = (_shift2),				\
> -			.width   = (_width),				\
> -		},							\
> -	},								\
> -	.hw.init = &(struct clk_init_data) {				\
> -		.name = "aud_"#_name,					\
> -		.ops = &meson_clk_triphase_ops,				\
> -		.parent_names = (const char *[]){ #_pname },		\
> -		.num_parents = 1,					\
> -		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
> -	},								\
> -}
> -
> -#define AUD_PHASE(_name, _reg, _width, _shift, _pname, _iflags) {	\
> -	.data = &(struct meson_clk_phase_data) {			\
> -		.ph = {							\
> -			.reg_off = (_reg),				\
> -			.shift   = (_shift),				\
> -			.width   = (_width),				\
> -		},							\
> -	},								\
> -	.hw.init = &(struct clk_init_data) {				\
> -		.name = "aud_"#_name,					\
> -		.ops = &meson_clk_phase_ops,				\
> -		.parent_names = (const char *[]){ #_pname },		\
> -		.num_parents = 1,					\
> -		.flags = (_iflags),					\
> -	},								\
> -}
> -
> -#define AUD_SCLK_WS(_name, _reg, _width, _shift_ph, _shift_ws, _pname,	\
> -		    _iflags) {						\
> -	.data = &(struct meson_sclk_ws_inv_data) {			\
> -		.ph = {							\
> -			.reg_off = (_reg),				\
> -			.shift   = (_shift_ph),				\
> -			.width   = (_width),				\
> -		},							\
> -		.ws = {							\
> -			.reg_off = (_reg),				\
> -			.shift   = (_shift_ws),				\
> -			.width   = (_width),				\
> -		},							\
> -	},								\
> -	.hw.init = &(struct clk_init_data) {				\
> -		.name = "aud_"#_name,					\
> -		.ops = &meson_clk_phase_ops,				\
> -		.parent_names = (const char *[]){ #_pname },		\
> -		.num_parents = 1,					\
> -		.flags = (_iflags),					\
> -	},								\
> -}
> +static const struct clk_parent_data pclk_parent_data[] = {
> +	{ .name = "aud_top" },
> +};
>  
>  /* Audio Master Clocks */
>  static const struct clk_parent_data mst_mux_parent_data[] = {
> @@ -325,45 +180,45 @@ static const struct clk_parent_data lrclk_pad_ctrl_parent_data[] = {
>  
>  /* Common Clocks */
>  static struct clk_regmap ddr_arb =
> -	AUD_PCLK_GATE(ddr_arb, AUDIO_CLK_GATE_EN, 0);
> +	AUD_PCLK_GATE(ddr_arb, AUDIO_CLK_GATE_EN, 0, pclk_parent_data);
>  static struct clk_regmap pdm =
> -	AUD_PCLK_GATE(pdm, AUDIO_CLK_GATE_EN, 1);
> +	AUD_PCLK_GATE(pdm, AUDIO_CLK_GATE_EN, 1, pclk_parent_data);
>  static struct clk_regmap tdmin_a =
> -	AUD_PCLK_GATE(tdmin_a, AUDIO_CLK_GATE_EN, 2);
> +	AUD_PCLK_GATE(tdmin_a, AUDIO_CLK_GATE_EN, 2, pclk_parent_data);
>  static struct clk_regmap tdmin_b =
> -	AUD_PCLK_GATE(tdmin_b, AUDIO_CLK_GATE_EN, 3);
> +	AUD_PCLK_GATE(tdmin_b, AUDIO_CLK_GATE_EN, 3, pclk_parent_data);
>  static struct clk_regmap tdmin_c =
> -	AUD_PCLK_GATE(tdmin_c, AUDIO_CLK_GATE_EN, 4);
> +	AUD_PCLK_GATE(tdmin_c, AUDIO_CLK_GATE_EN, 4, pclk_parent_data);
>  static struct clk_regmap tdmin_lb =
> -	AUD_PCLK_GATE(tdmin_lb, AUDIO_CLK_GATE_EN, 5);
> +	AUD_PCLK_GATE(tdmin_lb, AUDIO_CLK_GATE_EN, 5, pclk_parent_data);
>  static struct clk_regmap tdmout_a =
> -	AUD_PCLK_GATE(tdmout_a, AUDIO_CLK_GATE_EN, 6);
> +	AUD_PCLK_GATE(tdmout_a, AUDIO_CLK_GATE_EN, 6, pclk_parent_data);
>  static struct clk_regmap tdmout_b =
> -	AUD_PCLK_GATE(tdmout_b, AUDIO_CLK_GATE_EN, 7);
> +	AUD_PCLK_GATE(tdmout_b, AUDIO_CLK_GATE_EN, 7, pclk_parent_data);
>  static struct clk_regmap tdmout_c =
> -	AUD_PCLK_GATE(tdmout_c, AUDIO_CLK_GATE_EN, 8);
> +	AUD_PCLK_GATE(tdmout_c, AUDIO_CLK_GATE_EN, 8, pclk_parent_data);
>  static struct clk_regmap frddr_a =
> -	AUD_PCLK_GATE(frddr_a, AUDIO_CLK_GATE_EN, 9);
> +	AUD_PCLK_GATE(frddr_a, AUDIO_CLK_GATE_EN, 9, pclk_parent_data);
>  static struct clk_regmap frddr_b =
> -	AUD_PCLK_GATE(frddr_b, AUDIO_CLK_GATE_EN, 10);
> +	AUD_PCLK_GATE(frddr_b, AUDIO_CLK_GATE_EN, 10, pclk_parent_data);
>  static struct clk_regmap frddr_c =
> -	AUD_PCLK_GATE(frddr_c, AUDIO_CLK_GATE_EN, 11);
> +	AUD_PCLK_GATE(frddr_c, AUDIO_CLK_GATE_EN, 11, pclk_parent_data);
>  static struct clk_regmap toddr_a =
> -	AUD_PCLK_GATE(toddr_a, AUDIO_CLK_GATE_EN, 12);
> +	AUD_PCLK_GATE(toddr_a, AUDIO_CLK_GATE_EN, 12, pclk_parent_data);
>  static struct clk_regmap toddr_b =
> -	AUD_PCLK_GATE(toddr_b, AUDIO_CLK_GATE_EN, 13);
> +	AUD_PCLK_GATE(toddr_b, AUDIO_CLK_GATE_EN, 13, pclk_parent_data);
>  static struct clk_regmap toddr_c =
> -	AUD_PCLK_GATE(toddr_c, AUDIO_CLK_GATE_EN, 14);
> +	AUD_PCLK_GATE(toddr_c, AUDIO_CLK_GATE_EN, 14, pclk_parent_data);
>  static struct clk_regmap loopback =
> -	AUD_PCLK_GATE(loopback, AUDIO_CLK_GATE_EN, 15);
> +	AUD_PCLK_GATE(loopback, AUDIO_CLK_GATE_EN, 15, pclk_parent_data);
>  static struct clk_regmap spdifin =
> -	AUD_PCLK_GATE(spdifin, AUDIO_CLK_GATE_EN, 16);
> +	AUD_PCLK_GATE(spdifin, AUDIO_CLK_GATE_EN, 16, pclk_parent_data);
>  static struct clk_regmap spdifout =
> -	AUD_PCLK_GATE(spdifout, AUDIO_CLK_GATE_EN, 17);
> +	AUD_PCLK_GATE(spdifout, AUDIO_CLK_GATE_EN, 17, pclk_parent_data);
>  static struct clk_regmap resample =
> -	AUD_PCLK_GATE(resample, AUDIO_CLK_GATE_EN, 18);
> +	AUD_PCLK_GATE(resample, AUDIO_CLK_GATE_EN, 18, pclk_parent_data);
>  static struct clk_regmap power_detect =
> -	AUD_PCLK_GATE(power_detect, AUDIO_CLK_GATE_EN, 19);
> +	AUD_PCLK_GATE(power_detect, AUDIO_CLK_GATE_EN, 19, pclk_parent_data);
>  
>  static struct clk_regmap spdifout_clk_sel =
>  	AUD_MST_MCLK_MUX(spdifout_clk, AUDIO_CLK_SPDIFOUT_CTRL);
> @@ -631,11 +486,11 @@ static struct clk_regmap g12a_tdmout_c_sclk =
>  	AUD_TDM_SCLK_WS(out_c, AUDIO_CLK_TDMOUT_C_CTRL);
>  
>  static struct clk_regmap toram =
> -	AUD_PCLK_GATE(toram, AUDIO_CLK_GATE_EN, 20);
> +	AUD_PCLK_GATE(toram, AUDIO_CLK_GATE_EN, 20, pclk_parent_data);
>  static struct clk_regmap spdifout_b =
> -	AUD_PCLK_GATE(spdifout_b, AUDIO_CLK_GATE_EN, 21);
> +	AUD_PCLK_GATE(spdifout_b, AUDIO_CLK_GATE_EN, 21, pclk_parent_data);
>  static struct clk_regmap eqdrc =
> -	AUD_PCLK_GATE(eqdrc, AUDIO_CLK_GATE_EN, 22);
> +	AUD_PCLK_GATE(eqdrc, AUDIO_CLK_GATE_EN, 22, pclk_parent_data);
>  
>  /* SM1 Clocks */
>  static struct clk_regmap sm1_clk81_en = {
> @@ -740,21 +595,21 @@ static struct clk_regmap sm1_aud_top = {
>  };
>  
>  static struct clk_regmap resample_b =
> -	AUD_PCLK_GATE(resample_b, AUDIO_CLK_GATE_EN, 26);
> +	AUD_PCLK_GATE(resample_b, AUDIO_CLK_GATE_EN, 26, pclk_parent_data);
>  static struct clk_regmap tovad =
> -	AUD_PCLK_GATE(tovad, AUDIO_CLK_GATE_EN, 27);
> +	AUD_PCLK_GATE(tovad, AUDIO_CLK_GATE_EN, 27, pclk_parent_data);
>  static struct clk_regmap locker =
> -	AUD_PCLK_GATE(locker, AUDIO_CLK_GATE_EN, 28);
> +	AUD_PCLK_GATE(locker, AUDIO_CLK_GATE_EN, 28, pclk_parent_data);
>  static struct clk_regmap spdifin_lb =
> -	AUD_PCLK_GATE(spdifin_lb, AUDIO_CLK_GATE_EN, 29);
> +	AUD_PCLK_GATE(spdifin_lb, AUDIO_CLK_GATE_EN, 29, pclk_parent_data);
>  static struct clk_regmap frddr_d =
> -	AUD_PCLK_GATE(frddr_d, AUDIO_CLK_GATE_EN1, 0);
> +	AUD_PCLK_GATE(frddr_d, AUDIO_CLK_GATE_EN1, 0, pclk_parent_data);
>  static struct clk_regmap toddr_d =
> -	AUD_PCLK_GATE(toddr_d, AUDIO_CLK_GATE_EN1, 1);
> +	AUD_PCLK_GATE(toddr_d, AUDIO_CLK_GATE_EN1, 1, pclk_parent_data);
>  static struct clk_regmap loopback_b =
> -	AUD_PCLK_GATE(loopback_b, AUDIO_CLK_GATE_EN1, 2);
> +	AUD_PCLK_GATE(loopback_b, AUDIO_CLK_GATE_EN1, 2, pclk_parent_data);
>  static struct clk_regmap earcrx =
> -	AUD_PCLK_GATE(earcrx, AUDIO_CLK_GATE_EN1, 6);
> +	AUD_PCLK_GATE(earcrx, AUDIO_CLK_GATE_EN1, 6, pclk_parent_data);
>  
>  
>  static struct clk_regmap sm1_mst_a_mclk_sel =
> diff --git a/drivers/clk/meson/meson-audio.h b/drivers/clk/meson/meson-audio.h
> new file mode 100644
> index 000000000000..16dd044d52bd
> --- /dev/null
> +++ b/drivers/clk/meson/meson-audio.h
> @@ -0,0 +1,156 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +
> +#ifndef __MESON_AUDIO_H__
> +#define __MESON_AUDIO_H__
> +
> +#define AUD_PCLK_GATE(_name, _reg, _bit, _pdata) {			\
> +	.data = &(struct clk_regmap_gate_data){				\
> +		.offset = (_reg),					\
> +		.bit_idx = (_bit),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = "aud_"#_name,					\
> +		.ops = &clk_regmap_gate_ops,				\
> +		.parent_data = (_pdata),				\
> +		.num_parents = 1,					\
> +	},								\
> +}
> +
> +#define AUD_GATE(_name, _reg, _bit, _pname, _iflags) {			\
> +	.data = &(struct clk_regmap_gate_data){				\
> +		.offset = (_reg),					\
> +		.bit_idx = (_bit),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = "aud_"#_name,					\
> +		.ops = &clk_regmap_gate_ops,				\
> +		.parent_names = (const char *[]){ #_pname },		\
> +		.num_parents = 1,					\
> +		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
> +	},								\
> +}
> +
> +#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags) {	\
> +	.data = &(struct clk_regmap_mux_data){				\
> +		.offset = (_reg),					\
> +		.mask = (_mask),					\
> +		.shift = (_shift),					\
> +		.flags = (_dflags),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data){				\
> +		.name = "aud_"#_name,					\
> +		.ops = &clk_regmap_mux_ops,				\
> +		.parent_data = _pdata,					\
> +		.num_parents = ARRAY_SIZE(_pdata),			\
> +		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
> +	},								\
> +}
> +
> +#define AUD_DIV(_name, _reg, _shift, _width, _dflags, _pname, _iflags) { \
> +	.data = &(struct clk_regmap_div_data){				\
> +		.offset = (_reg),					\
> +		.shift = (_shift),					\
> +		.width = (_width),					\
> +		.flags = (_dflags),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data){				\
> +		.name = "aud_"#_name,					\
> +		.ops = &clk_regmap_divider_ops,				\
> +		.parent_names = (const char *[]){ #_pname },		\
> +		.num_parents = 1,					\
> +		.flags = (_iflags),					\
> +	},								\
> +}
> +
> +#define AUD_SCLK_DIV(_name, _reg, _div_shift, _div_width,		\
> +		     _hi_shift, _hi_width, _pname, _iflags) {		\
> +	.data = &(struct meson_sclk_div_data) {				\
> +		.div = {						\
> +			.reg_off = (_reg),				\
> +			.shift   = (_div_shift),			\
> +			.width   = (_div_width),			\
> +		},							\
> +		.hi = {							\
> +			.reg_off = (_reg),				\
> +			.shift   = (_hi_shift),				\
> +			.width   = (_hi_width),				\
> +		},							\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = "aud_"#_name,					\
> +		.ops = &meson_sclk_div_ops,				\
> +		.parent_names = (const char *[]){ #_pname },		\
> +		.num_parents = 1,					\
> +		.flags = (_iflags),					\
> +	},								\
> +}
> +
> +#define AUD_TRIPHASE(_name, _reg, _width, _shift0, _shift1, _shift2,	\
> +		     _pname, _iflags) {					\
> +	.data = &(struct meson_clk_triphase_data) {			\
> +		.ph0 = {						\
> +			.reg_off = (_reg),				\
> +			.shift   = (_shift0),				\
> +			.width   = (_width),				\
> +		},							\
> +		.ph1 = {						\
> +			.reg_off = (_reg),				\
> +			.shift   = (_shift1),				\
> +			.width   = (_width),				\
> +		},							\
> +		.ph2 = {						\
> +			.reg_off = (_reg),				\
> +			.shift   = (_shift2),				\
> +			.width   = (_width),				\
> +		},							\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = "aud_"#_name,					\
> +		.ops = &meson_clk_triphase_ops,				\
> +		.parent_names = (const char *[]){ #_pname },		\
> +		.num_parents = 1,					\
> +		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
> +	},								\
> +}
> +
> +#define AUD_PHASE(_name, _reg, _width, _shift, _pname, _iflags) {	\
> +	.data = &(struct meson_clk_phase_data) {			\
> +		.ph = {							\
> +			.reg_off = (_reg),				\
> +			.shift   = (_shift),				\
> +			.width   = (_width),				\
> +		},							\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = "aud_"#_name,					\
> +		.ops = &meson_clk_phase_ops,				\
> +		.parent_names = (const char *[]){ #_pname },		\
> +		.num_parents = 1,					\
> +		.flags = (_iflags),					\
> +	},								\
> +}
> +
> +#define AUD_SCLK_WS(_name, _reg, _width, _shift_ph, _shift_ws, _pname,	\
> +		    _iflags) {						\
> +	.data = &(struct meson_sclk_ws_inv_data) {			\
> +		.ph = {							\
> +			.reg_off = (_reg),				\
> +			.shift   = (_shift_ph),				\
> +			.width   = (_width),				\
> +		},							\
> +		.ws = {							\
> +			.reg_off = (_reg),				\
> +			.shift   = (_shift_ws),				\
> +			.width   = (_width),				\
> +		},							\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = "aud_"#_name,					\
> +		.ops = &meson_clk_phase_ops,				\
> +		.parent_names = (const char *[]){ #_pname },		\
> +		.num_parents = 1,					\
> +		.flags = (_iflags),					\
> +	},								\
> +}
> +
> +#endif /* __MESON_AUDIO_H__ */

-- 
Best regards
Jan Dakinevich

