Return-Path: <linux-kernel+bounces-328145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B0977F86
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F0828A4D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF771DA63F;
	Fri, 13 Sep 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="u88BGvsZ"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F071DA61F;
	Fri, 13 Sep 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229647; cv=none; b=mmbA8rt75jHKmoxwYwaSnYTylw1dEKxrSIjpWFJf+IX1LdUooXRyLhAzDZxcFqr8D9MOsnVVb3G20mCfKI72WB2HmlI9y9drreZaraMlBvTd69Mo3WTIN1iG+Wx1lnPMeD6yeCB5Cxhwq54V+vQf7wBeTPTNGVvWqbHOwbkFFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229647; c=relaxed/simple;
	bh=7CuqfBP/27/r7OJDJK9qkeWYOpYfeDymAalIYlW0/6A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPl8VQt2O4IrM8QqlTfa69N7XILP/iiWENil87gV+Db7deZcpDgooqzM6Y4HK79v0fxqcCfU+aJE3VUeCbW8DCZBxVBxOfPw4Hz+ggJ24dCvKtwsIfcG/k4RZzQ81Tep8WCtwUBLYM0oU4z6DgNqOpLjdpvVBWy7zRwQ3l7OOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=u88BGvsZ; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A405C10002C;
	Fri, 13 Sep 2024 15:13:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A405C10002C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726229633;
	bh=rPQw2F08Uz4xjVSwdhVa7ZBFlR+M5A8/MM2JJ0d09Ek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=u88BGvsZ7TlnGfnkgrQDbRP/2ei9GK8oGlsIr8txKU2lwG6DWZIqLa8nycsYdqKlv
	 JA5OZCpgR2k+jjwGkNRVT4/KVexp8+m+/NKvMk6R+876EWY95DHXyC4Q6obsHu76xD
	 jKtWsm0DJcx2Z3s86Lo5/lBJWJ8ud0+DINqcV+KXACfSEEO55/90NFuj01d/F7NMih
	 ZLGl2OvULDnnJd6plIrVKpDiq5bve3DKm+aHHdcriqfmUA6oGR9T6HotpjVbR1J9IL
	 rnPFn4E5nFCM4229RSljye7r5EAopOU5Er5s246pm7E0cZZZEkMJcStK6oh+LIFw/2
	 VvVHuLMmJZG3g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 13 Sep 2024 15:13:53 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH v4 1/5] reset: amlogic: add support for A1 SoC in auxiliary reset driver
Date: Fri, 13 Sep 2024 15:11:48 +0300
Message-ID: <20240913121152.817575-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187732 [Sep 13 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_smtp_not_equal_from}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/13 11:43:00 #26577866
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for the reset controller present in the audio clock
controller of A1 SoC families, using the auxiliary bus.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/reset/amlogic/reset-meson-aux.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/reset/amlogic/reset-meson-aux.c b/drivers/reset/amlogic/reset-meson-aux.c
index dd8453001db9..a385c0125836 100644
--- a/drivers/reset/amlogic/reset-meson-aux.c
+++ b/drivers/reset/amlogic/reset-meson-aux.c
@@ -26,6 +26,12 @@ struct meson_reset_adev {
 #define to_meson_reset_adev(_adev) \
 	container_of((_adev), struct meson_reset_adev, adev)
 
+static const struct meson_reset_param meson_a1_audio_param = {
+	.reset_ops	= &meson_reset_toggle_ops,
+	.reset_num	= 32,
+	.level_offset	= 0x28,
+};
+
 static const struct meson_reset_param meson_g12a_audio_param = {
 	.reset_ops	= &meson_reset_toggle_ops,
 	.reset_num	= 26,
@@ -40,6 +46,9 @@ static const struct meson_reset_param meson_sm1_audio_param = {
 
 static const struct auxiliary_device_id meson_reset_aux_ids[] = {
 	{
+		.name = "a1-audio-clkc.rst-a1",
+		.driver_data = (kernel_ulong_t)&meson_a1_audio_param,
+	}, {
 		.name = "axg-audio-clkc.rst-g12a",
 		.driver_data = (kernel_ulong_t)&meson_g12a_audio_param,
 	}, {
-- 
2.34.1


