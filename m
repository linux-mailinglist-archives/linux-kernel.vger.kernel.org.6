Return-Path: <linux-kernel+bounces-409661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164E59C8FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0FC2835C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B429B189B9C;
	Thu, 14 Nov 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="NTk0EQQq"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBA187870;
	Thu, 14 Nov 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601777; cv=none; b=G34jW/YiT19QEYSI5oYM7IuoHUeAt3yO8JDQGqyUFoaazP4Nj06sb1WUP2RQOYI+Qo7bWfQs6U+oIMUZc3uncM6RyQ7m1uz+xYP+kDIXW/pc2vhOedfkBU+tkhgVXfW7rw4OiQLzaXXcbqxrdUauaL6jGVp2bWELqPdGMyQom9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601777; c=relaxed/simple;
	bh=TNcL7hW1ImAKbcrBlK5LIHg5QbOs3jt/SwseNyxcBJs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNX4GXF/Uzqw/nkBdzjnVVWspw4r2ZB0uwg+jj0kRDI72xLIgWuKtg/Ar96v0/fhym0WzPZHQGsXzsis6ndsQ4cnMvjWIAbM4EZXLo/2pWYdCia/46JEryVoeeoqxWTQa8nKURLlM/wksLkAslIJhZ0HIIMygbL5DOvCsaETXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=NTk0EQQq; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 488DB12000F;
	Thu, 14 Nov 2024 19:29:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 488DB12000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731601773;
	bh=uWFM2OIDny8aQRNfF/FtlMduc/pXhoIYLcpFwT4ifvg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NTk0EQQq1dTOoLVAR6GaTO++UVCib4kqHgC5/08c3yFCw4g/2aPtLZLuSqF5Iu77/
	 4afD9B1yly2t5vKet6TX2wtmprg6tC217vm7GHcKy2mVpRIN4SNSBKIOm/Ylo1hvFG
	 MycBb4j0nIYBd/sQRWscVnsTdtyYYSDNe+xQjghLZPxHSKW4MRF7bWtb/E5jeXGL8m
	 1J56xNkZApekA3xLCyCEJgQswh2pmiZQ+PvOZYkgX1nWIFH5YXlafBrQgbf6cvCaOR
	 7qIXDkkXiMCxb/j1b00WSIrrkbP/xPmDAaAb7RMFqfZ46CO5KZgVRqZZIKj4tP8PNm
	 TR/k7qKZIe4rA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
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
Subject: [RFC PATCH 2/3] clk: amlogic: axg-audio: synchronize *_audio_hw_clks and *_clk_regmaps arrays
Date: Thu, 14 Nov 2024 19:29:25 +0300
Message-ID: <20241114162926.3356551-3-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/14 14:31:00 #26861614
X-KSMG-AntiVirus-Status: Clean, skipped

To simplify review, synchronize the content and order of clocks listed
in these arrays.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/axg-audio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 05a72a199ebd..5d2901b2a964 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -1095,6 +1095,8 @@ static struct clk_hw *g12a_audio_hw_clks[] = {
 	[AUD_CLKID_TDM_SCLK_PAD0]	= &g12a_tdm_sclk_pad_0.hw,
 	[AUD_CLKID_TDM_SCLK_PAD1]	= &g12a_tdm_sclk_pad_1.hw,
 	[AUD_CLKID_TDM_SCLK_PAD2]	= &g12a_tdm_sclk_pad_2.hw,
+	[AUD_CLKID_TORAM]		= &toram.hw,
+	[AUD_CLKID_EQDRC]		= &eqdrc.hw,
 	[AUD_CLKID_TOP]			= &axg_aud_top,
 };
 
@@ -1428,6 +1430,9 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&spdifout_clk_sel,
 	&spdifout_clk_div,
 	&spdifout_clk,
+	&spdifout_b_clk_sel,
+	&spdifout_b_clk_div,
+	&spdifout_b_clk,
 	&spdifin_clk_sel,
 	&spdifin_clk_div,
 	&spdifin_clk,
@@ -1508,9 +1513,6 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&tdmout_a_lrclk,
 	&tdmout_b_lrclk,
 	&tdmout_c_lrclk,
-	&spdifout_b_clk_sel,
-	&spdifout_b_clk_div,
-	&spdifout_b_clk,
 	&g12a_tdm_mclk_pad_0,
 	&g12a_tdm_mclk_pad_1,
 	&g12a_tdm_lrclk_pad_0,
@@ -1565,6 +1567,9 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
 	&spdifout_clk_sel,
 	&spdifout_clk_div,
 	&spdifout_clk,
+	&spdifout_b_clk_sel,
+	&spdifout_b_clk_div,
+	&spdifout_b_clk,
 	&spdifin_clk_sel,
 	&spdifin_clk_div,
 	&spdifin_clk,
@@ -1645,9 +1650,6 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
 	&tdmout_a_lrclk,
 	&tdmout_b_lrclk,
 	&tdmout_c_lrclk,
-	&spdifout_b_clk_sel,
-	&spdifout_b_clk_div,
-	&spdifout_b_clk,
 	&sm1_tdm_mclk_pad_0,
 	&sm1_tdm_mclk_pad_1,
 	&sm1_tdm_lrclk_pad_0,
-- 
2.34.1


