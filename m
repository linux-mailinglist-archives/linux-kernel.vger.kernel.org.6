Return-Path: <linux-kernel+bounces-409662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695D69C8FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B3D28400C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DA18C01A;
	Thu, 14 Nov 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="cRYHmOKy"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDD187FE8;
	Thu, 14 Nov 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601777; cv=none; b=pO4uAs92Iojy2oiVZfDaIvcSvVJmHg58Q9pg8OqxQMbGY1f4lS2u5bZ2cGjp/aLvfC5z6gna1eSpAeWZMoBt98ITHi1xIbkxdpL6k/s3lROU8LSIBoMD8va7hCo2FX/EPQBN2FH9IdHha0+iEpEKdclZ1Bnkq9Ru05Mk8MMoUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601777; c=relaxed/simple;
	bh=kh4FCrp3Z7IS55tSwCpokCXh2Boq1Zv69op0bZREeac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+lN1yOwJHdNsDkq1m3YHV0I5T1rUg9spKZmxSkY0I8hD92f3Odp6ruP6x1d+iR3Grx35IE0fi0JYWh+ykXyNf0F2i1AoA+kymtkuJMDwfYb7pej5LVQChfbw2X3mNoiX1qerCbfXq56Saq3XKLn+s43GT8po2G4kV2VB/JxDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=cRYHmOKy; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8BABA10000C;
	Thu, 14 Nov 2024 19:29:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8BABA10000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731601773;
	bh=JbDsYv7cu08zbtXV8EEGOIH5VNm7Wy08SWYNwx6otmY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=cRYHmOKy71p5KWR12GjiWXenLnWqyKys4w2AHNuy595SGRvgGn172jchZ6RKVcCjM
	 mErqV1uRjmk+7nlV0tt4EWlpql1PZtyI79N4mu7PqI3nfw9V1xev+h4usF26O1hVEX
	 3JoKbOHvcy8dBaiUfilfKK6QgRp0+E5c4uFl1WG2Ah+7QUDsgpwzn/IvHPgCFISawY
	 T+jDqaqwyBHxhYbphEdOI8BARSB3rl6u95vkO251h/SNObIH3cgOvq94aqDGjx0a3p
	 IzQYPB+r9lpai3pvgem0kwX8UJpIrr7W4dXWKm1vwf0SMmbLdZjJV66Txuvl0D+OvF
	 ZhFi1bN9YBSOw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Nov 2024 19:29:33 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH 3/3] clk: amlogic: axg-audio: get the rid of *_clk_regmaps
Date: Thu, 14 Nov 2024 19:29:26 +0300
Message-ID: <20241114162926.3356551-4-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114162926.3356551-1-jan.dakinevich@salutedevices.com>
References: <20241114162926.3356551-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189183 [Nov 14 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/14 14:31:00 #26861614
X-KSMG-AntiVirus-Status: Clean, skipped

The only thing which these arrays used for is to initialize ->map field
during probe. However, the content of them is almost identical to their
*_audio_hw_clks counterparts.

So, we can make do the following: exclude AUD_CLKID_TOP from
*_audio_hw_clks arrays if the clock is not backed by hardware and then
use *_audio_hw_clks for both ->map initialization and for clock's
registering.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/axg-audio.c | 451 ++--------------------------------
 1 file changed, 15 insertions(+), 436 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 5d2901b2a964..8418c6cd7063 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -954,7 +954,6 @@ static struct clk_hw *axg_audio_hw_clks[] = {
 	[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
 	[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
 	[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
-	[AUD_CLKID_TOP]			= &axg_aud_top,
 };
 
 /*
@@ -1097,7 +1096,6 @@ static struct clk_hw *g12a_audio_hw_clks[] = {
 	[AUD_CLKID_TDM_SCLK_PAD2]	= &g12a_tdm_sclk_pad_2.hw,
 	[AUD_CLKID_TORAM]		= &toram.hw,
 	[AUD_CLKID_EQDRC]		= &eqdrc.hw,
-	[AUD_CLKID_TOP]			= &axg_aud_top,
 };
 
 /*
@@ -1261,427 +1259,6 @@ static struct clk_hw *sm1_audio_hw_clks[] = {
 	[AUD_CLKID_EARCRX_DMAC]		= &sm1_earcrx_dmac_clk.hw,
 };
 
-
-/* Convenience table to populate regmap in .probe(). */
-static struct clk_regmap *const axg_clk_regmaps[] = {
-	&ddr_arb,
-	&pdm,
-	&tdmin_a,
-	&tdmin_b,
-	&tdmin_c,
-	&tdmin_lb,
-	&tdmout_a,
-	&tdmout_b,
-	&tdmout_c,
-	&frddr_a,
-	&frddr_b,
-	&frddr_c,
-	&toddr_a,
-	&toddr_b,
-	&toddr_c,
-	&loopback,
-	&spdifin,
-	&spdifout,
-	&resample,
-	&power_detect,
-	&mst_a_mclk_sel,
-	&mst_b_mclk_sel,
-	&mst_c_mclk_sel,
-	&mst_d_mclk_sel,
-	&mst_e_mclk_sel,
-	&mst_f_mclk_sel,
-	&mst_a_mclk_div,
-	&mst_b_mclk_div,
-	&mst_c_mclk_div,
-	&mst_d_mclk_div,
-	&mst_e_mclk_div,
-	&mst_f_mclk_div,
-	&mst_a_mclk,
-	&mst_b_mclk,
-	&mst_c_mclk,
-	&mst_d_mclk,
-	&mst_e_mclk,
-	&mst_f_mclk,
-	&spdifout_clk_sel,
-	&spdifout_clk_div,
-	&spdifout_clk,
-	&spdifin_clk_sel,
-	&spdifin_clk_div,
-	&spdifin_clk,
-	&pdm_dclk_sel,
-	&pdm_dclk_div,
-	&pdm_dclk,
-	&pdm_sysclk_sel,
-	&pdm_sysclk_div,
-	&pdm_sysclk,
-	&mst_a_sclk_pre_en,
-	&mst_b_sclk_pre_en,
-	&mst_c_sclk_pre_en,
-	&mst_d_sclk_pre_en,
-	&mst_e_sclk_pre_en,
-	&mst_f_sclk_pre_en,
-	&mst_a_sclk_div,
-	&mst_b_sclk_div,
-	&mst_c_sclk_div,
-	&mst_d_sclk_div,
-	&mst_e_sclk_div,
-	&mst_f_sclk_div,
-	&mst_a_sclk_post_en,
-	&mst_b_sclk_post_en,
-	&mst_c_sclk_post_en,
-	&mst_d_sclk_post_en,
-	&mst_e_sclk_post_en,
-	&mst_f_sclk_post_en,
-	&mst_a_sclk,
-	&mst_b_sclk,
-	&mst_c_sclk,
-	&mst_d_sclk,
-	&mst_e_sclk,
-	&mst_f_sclk,
-	&mst_a_lrclk_div,
-	&mst_b_lrclk_div,
-	&mst_c_lrclk_div,
-	&mst_d_lrclk_div,
-	&mst_e_lrclk_div,
-	&mst_f_lrclk_div,
-	&mst_a_lrclk,
-	&mst_b_lrclk,
-	&mst_c_lrclk,
-	&mst_d_lrclk,
-	&mst_e_lrclk,
-	&mst_f_lrclk,
-	&tdmin_a_sclk_sel,
-	&tdmin_b_sclk_sel,
-	&tdmin_c_sclk_sel,
-	&tdmin_lb_sclk_sel,
-	&tdmout_a_sclk_sel,
-	&tdmout_b_sclk_sel,
-	&tdmout_c_sclk_sel,
-	&tdmin_a_sclk_pre_en,
-	&tdmin_b_sclk_pre_en,
-	&tdmin_c_sclk_pre_en,
-	&tdmin_lb_sclk_pre_en,
-	&tdmout_a_sclk_pre_en,
-	&tdmout_b_sclk_pre_en,
-	&tdmout_c_sclk_pre_en,
-	&tdmin_a_sclk_post_en,
-	&tdmin_b_sclk_post_en,
-	&tdmin_c_sclk_post_en,
-	&tdmin_lb_sclk_post_en,
-	&tdmout_a_sclk_post_en,
-	&tdmout_b_sclk_post_en,
-	&tdmout_c_sclk_post_en,
-	&tdmin_a_sclk,
-	&tdmin_b_sclk,
-	&tdmin_c_sclk,
-	&tdmin_lb_sclk,
-	&axg_tdmout_a_sclk,
-	&axg_tdmout_b_sclk,
-	&axg_tdmout_c_sclk,
-	&tdmin_a_lrclk,
-	&tdmin_b_lrclk,
-	&tdmin_c_lrclk,
-	&tdmin_lb_lrclk,
-	&tdmout_a_lrclk,
-	&tdmout_b_lrclk,
-	&tdmout_c_lrclk,
-};
-
-static struct clk_regmap *const g12a_clk_regmaps[] = {
-	&ddr_arb,
-	&pdm,
-	&tdmin_a,
-	&tdmin_b,
-	&tdmin_c,
-	&tdmin_lb,
-	&tdmout_a,
-	&tdmout_b,
-	&tdmout_c,
-	&frddr_a,
-	&frddr_b,
-	&frddr_c,
-	&toddr_a,
-	&toddr_b,
-	&toddr_c,
-	&loopback,
-	&spdifin,
-	&spdifout,
-	&resample,
-	&power_detect,
-	&spdifout_b,
-	&mst_a_mclk_sel,
-	&mst_b_mclk_sel,
-	&mst_c_mclk_sel,
-	&mst_d_mclk_sel,
-	&mst_e_mclk_sel,
-	&mst_f_mclk_sel,
-	&mst_a_mclk_div,
-	&mst_b_mclk_div,
-	&mst_c_mclk_div,
-	&mst_d_mclk_div,
-	&mst_e_mclk_div,
-	&mst_f_mclk_div,
-	&mst_a_mclk,
-	&mst_b_mclk,
-	&mst_c_mclk,
-	&mst_d_mclk,
-	&mst_e_mclk,
-	&mst_f_mclk,
-	&spdifout_clk_sel,
-	&spdifout_clk_div,
-	&spdifout_clk,
-	&spdifout_b_clk_sel,
-	&spdifout_b_clk_div,
-	&spdifout_b_clk,
-	&spdifin_clk_sel,
-	&spdifin_clk_div,
-	&spdifin_clk,
-	&pdm_dclk_sel,
-	&pdm_dclk_div,
-	&pdm_dclk,
-	&pdm_sysclk_sel,
-	&pdm_sysclk_div,
-	&pdm_sysclk,
-	&mst_a_sclk_pre_en,
-	&mst_b_sclk_pre_en,
-	&mst_c_sclk_pre_en,
-	&mst_d_sclk_pre_en,
-	&mst_e_sclk_pre_en,
-	&mst_f_sclk_pre_en,
-	&mst_a_sclk_div,
-	&mst_b_sclk_div,
-	&mst_c_sclk_div,
-	&mst_d_sclk_div,
-	&mst_e_sclk_div,
-	&mst_f_sclk_div,
-	&mst_a_sclk_post_en,
-	&mst_b_sclk_post_en,
-	&mst_c_sclk_post_en,
-	&mst_d_sclk_post_en,
-	&mst_e_sclk_post_en,
-	&mst_f_sclk_post_en,
-	&mst_a_sclk,
-	&mst_b_sclk,
-	&mst_c_sclk,
-	&mst_d_sclk,
-	&mst_e_sclk,
-	&mst_f_sclk,
-	&mst_a_lrclk_div,
-	&mst_b_lrclk_div,
-	&mst_c_lrclk_div,
-	&mst_d_lrclk_div,
-	&mst_e_lrclk_div,
-	&mst_f_lrclk_div,
-	&mst_a_lrclk,
-	&mst_b_lrclk,
-	&mst_c_lrclk,
-	&mst_d_lrclk,
-	&mst_e_lrclk,
-	&mst_f_lrclk,
-	&tdmin_a_sclk_sel,
-	&tdmin_b_sclk_sel,
-	&tdmin_c_sclk_sel,
-	&tdmin_lb_sclk_sel,
-	&tdmout_a_sclk_sel,
-	&tdmout_b_sclk_sel,
-	&tdmout_c_sclk_sel,
-	&tdmin_a_sclk_pre_en,
-	&tdmin_b_sclk_pre_en,
-	&tdmin_c_sclk_pre_en,
-	&tdmin_lb_sclk_pre_en,
-	&tdmout_a_sclk_pre_en,
-	&tdmout_b_sclk_pre_en,
-	&tdmout_c_sclk_pre_en,
-	&tdmin_a_sclk_post_en,
-	&tdmin_b_sclk_post_en,
-	&tdmin_c_sclk_post_en,
-	&tdmin_lb_sclk_post_en,
-	&tdmout_a_sclk_post_en,
-	&tdmout_b_sclk_post_en,
-	&tdmout_c_sclk_post_en,
-	&tdmin_a_sclk,
-	&tdmin_b_sclk,
-	&tdmin_c_sclk,
-	&tdmin_lb_sclk,
-	&g12a_tdmout_a_sclk,
-	&g12a_tdmout_b_sclk,
-	&g12a_tdmout_c_sclk,
-	&tdmin_a_lrclk,
-	&tdmin_b_lrclk,
-	&tdmin_c_lrclk,
-	&tdmin_lb_lrclk,
-	&tdmout_a_lrclk,
-	&tdmout_b_lrclk,
-	&tdmout_c_lrclk,
-	&g12a_tdm_mclk_pad_0,
-	&g12a_tdm_mclk_pad_1,
-	&g12a_tdm_lrclk_pad_0,
-	&g12a_tdm_lrclk_pad_1,
-	&g12a_tdm_lrclk_pad_2,
-	&g12a_tdm_sclk_pad_0,
-	&g12a_tdm_sclk_pad_1,
-	&g12a_tdm_sclk_pad_2,
-	&toram,
-	&eqdrc,
-};
-
-static struct clk_regmap *const sm1_clk_regmaps[] = {
-	&ddr_arb,
-	&pdm,
-	&tdmin_a,
-	&tdmin_b,
-	&tdmin_c,
-	&tdmin_lb,
-	&tdmout_a,
-	&tdmout_b,
-	&tdmout_c,
-	&frddr_a,
-	&frddr_b,
-	&frddr_c,
-	&toddr_a,
-	&toddr_b,
-	&toddr_c,
-	&loopback,
-	&spdifin,
-	&spdifout,
-	&resample,
-	&spdifout_b,
-	&sm1_mst_a_mclk_sel,
-	&sm1_mst_b_mclk_sel,
-	&sm1_mst_c_mclk_sel,
-	&sm1_mst_d_mclk_sel,
-	&sm1_mst_e_mclk_sel,
-	&sm1_mst_f_mclk_sel,
-	&sm1_mst_a_mclk_div,
-	&sm1_mst_b_mclk_div,
-	&sm1_mst_c_mclk_div,
-	&sm1_mst_d_mclk_div,
-	&sm1_mst_e_mclk_div,
-	&sm1_mst_f_mclk_div,
-	&sm1_mst_a_mclk,
-	&sm1_mst_b_mclk,
-	&sm1_mst_c_mclk,
-	&sm1_mst_d_mclk,
-	&sm1_mst_e_mclk,
-	&sm1_mst_f_mclk,
-	&spdifout_clk_sel,
-	&spdifout_clk_div,
-	&spdifout_clk,
-	&spdifout_b_clk_sel,
-	&spdifout_b_clk_div,
-	&spdifout_b_clk,
-	&spdifin_clk_sel,
-	&spdifin_clk_div,
-	&spdifin_clk,
-	&pdm_dclk_sel,
-	&pdm_dclk_div,
-	&pdm_dclk,
-	&pdm_sysclk_sel,
-	&pdm_sysclk_div,
-	&pdm_sysclk,
-	&mst_a_sclk_pre_en,
-	&mst_b_sclk_pre_en,
-	&mst_c_sclk_pre_en,
-	&mst_d_sclk_pre_en,
-	&mst_e_sclk_pre_en,
-	&mst_f_sclk_pre_en,
-	&mst_a_sclk_div,
-	&mst_b_sclk_div,
-	&mst_c_sclk_div,
-	&mst_d_sclk_div,
-	&mst_e_sclk_div,
-	&mst_f_sclk_div,
-	&mst_a_sclk_post_en,
-	&mst_b_sclk_post_en,
-	&mst_c_sclk_post_en,
-	&mst_d_sclk_post_en,
-	&mst_e_sclk_post_en,
-	&mst_f_sclk_post_en,
-	&mst_a_sclk,
-	&mst_b_sclk,
-	&mst_c_sclk,
-	&mst_d_sclk,
-	&mst_e_sclk,
-	&mst_f_sclk,
-	&mst_a_lrclk_div,
-	&mst_b_lrclk_div,
-	&mst_c_lrclk_div,
-	&mst_d_lrclk_div,
-	&mst_e_lrclk_div,
-	&mst_f_lrclk_div,
-	&mst_a_lrclk,
-	&mst_b_lrclk,
-	&mst_c_lrclk,
-	&mst_d_lrclk,
-	&mst_e_lrclk,
-	&mst_f_lrclk,
-	&tdmin_a_sclk_sel,
-	&tdmin_b_sclk_sel,
-	&tdmin_c_sclk_sel,
-	&tdmin_lb_sclk_sel,
-	&tdmout_a_sclk_sel,
-	&tdmout_b_sclk_sel,
-	&tdmout_c_sclk_sel,
-	&tdmin_a_sclk_pre_en,
-	&tdmin_b_sclk_pre_en,
-	&tdmin_c_sclk_pre_en,
-	&tdmin_lb_sclk_pre_en,
-	&tdmout_a_sclk_pre_en,
-	&tdmout_b_sclk_pre_en,
-	&tdmout_c_sclk_pre_en,
-	&tdmin_a_sclk_post_en,
-	&tdmin_b_sclk_post_en,
-	&tdmin_c_sclk_post_en,
-	&tdmin_lb_sclk_post_en,
-	&tdmout_a_sclk_post_en,
-	&tdmout_b_sclk_post_en,
-	&tdmout_c_sclk_post_en,
-	&tdmin_a_sclk,
-	&tdmin_b_sclk,
-	&tdmin_c_sclk,
-	&tdmin_lb_sclk,
-	&g12a_tdmout_a_sclk,
-	&g12a_tdmout_b_sclk,
-	&g12a_tdmout_c_sclk,
-	&tdmin_a_lrclk,
-	&tdmin_b_lrclk,
-	&tdmin_c_lrclk,
-	&tdmin_lb_lrclk,
-	&tdmout_a_lrclk,
-	&tdmout_b_lrclk,
-	&tdmout_c_lrclk,
-	&sm1_tdm_mclk_pad_0,
-	&sm1_tdm_mclk_pad_1,
-	&sm1_tdm_lrclk_pad_0,
-	&sm1_tdm_lrclk_pad_1,
-	&sm1_tdm_lrclk_pad_2,
-	&sm1_tdm_sclk_pad_0,
-	&sm1_tdm_sclk_pad_1,
-	&sm1_tdm_sclk_pad_2,
-	&sm1_aud_top,
-	&toram,
-	&eqdrc,
-	&resample_b,
-	&tovad,
-	&locker,
-	&spdifin_lb,
-	&frddr_d,
-	&toddr_d,
-	&loopback_b,
-	&sm1_clk81_en,
-	&sm1_sysclk_a_div,
-	&sm1_sysclk_a_en,
-	&sm1_sysclk_b_div,
-	&sm1_sysclk_b_en,
-	&earcrx,
-	&sm1_earcrx_cmdc_clk_sel,
-	&sm1_earcrx_cmdc_clk_div,
-	&sm1_earcrx_cmdc_clk,
-	&sm1_earcrx_dmac_clk_sel,
-	&sm1_earcrx_dmac_clk_div,
-	&sm1_earcrx_dmac_clk,
-};
-
 static struct regmap_config axg_audio_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -1689,8 +1266,6 @@ static struct regmap_config axg_audio_regmap_cfg = {
 };
 
 struct audioclk_data {
-	struct clk_regmap *const *regmap_clks;
-	unsigned int regmap_clk_num;
 	struct meson_clk_hw_data hw_clks;
 	unsigned int max_register;
 	const char *rst_drvname;
@@ -1702,7 +1277,6 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 	const struct audioclk_data *data;
 	struct regmap *map;
 	void __iomem *regs;
-	struct clk_hw *hw;
 	struct clk *clk;
 	int ret, i;
 
@@ -1728,19 +1302,30 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to reset device\n");
 
-	/* Populate regmap for the regmap backed clocks */
-	for (i = 0; i < data->regmap_clk_num; i++)
-		data->regmap_clks[i]->map = map;
+	/*
+	 * If AUD_CLKID_TOP is not listed data->hw_clks then 'aud_top' clock
+	 * doesn't have underlying hardware and it should be registered
+	 * separately of other clocks to provide respective signal name.
+	 */
+	if (data->hw_clks.num < AUD_CLKID_TOP ||
+	    !data->hw_clks.hws[AUD_CLKID_TOP]) {
+		ret = devm_clk_hw_register(dev, &axg_aud_top);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to register clock aud_top\n");
+	}
 
 	/* Take care to skip the registered input clocks */
 	for (i = AUD_CLKID_DDR_ARB; i < data->hw_clks.num; i++) {
+		struct clk_hw *hw = data->hw_clks.hws[i];
+		struct clk_regmap *clk_regmap = to_clk_regmap(hw);
 		const char *name;
 
-		hw = data->hw_clks.hws[i];
 		/* array might be sparse */
 		if (!hw)
 			continue;
 
+		clk_regmap->map = map;
+
 		name = hw->init->name;
 
 		ret = devm_clk_hw_register(dev, hw);
@@ -1761,8 +1346,6 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 }
 
 static const struct audioclk_data axg_audioclk_data = {
-	.regmap_clks = axg_clk_regmaps,
-	.regmap_clk_num = ARRAY_SIZE(axg_clk_regmaps),
 	.hw_clks = {
 		.hws = axg_audio_hw_clks,
 		.num = ARRAY_SIZE(axg_audio_hw_clks),
@@ -1771,8 +1354,6 @@ static const struct audioclk_data axg_audioclk_data = {
 };
 
 static const struct audioclk_data g12a_audioclk_data = {
-	.regmap_clks = g12a_clk_regmaps,
-	.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
 	.hw_clks = {
 		.hws = g12a_audio_hw_clks,
 		.num = ARRAY_SIZE(g12a_audio_hw_clks),
@@ -1782,8 +1363,6 @@ static const struct audioclk_data g12a_audioclk_data = {
 };
 
 static const struct audioclk_data sm1_audioclk_data = {
-	.regmap_clks = sm1_clk_regmaps,
-	.regmap_clk_num = ARRAY_SIZE(sm1_clk_regmaps),
 	.hw_clks = {
 		.hws = sm1_audio_hw_clks,
 		.num = ARRAY_SIZE(sm1_audio_hw_clks),
-- 
2.34.1


