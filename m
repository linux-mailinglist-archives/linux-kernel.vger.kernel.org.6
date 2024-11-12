Return-Path: <linux-kernel+bounces-406825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B69C64AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544661F23D06
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040721A6F0;
	Tue, 12 Nov 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="tfqIf+D2"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140021A71D;
	Tue, 12 Nov 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452477; cv=none; b=gU7FQ+mFFsrViLtIw54zWS/cO0OZisbVf6AorSkOMg+N9h2fSRRyQi2Kx3KYlmaTHYvXt1U9mwiY6O501IcrgNVnk8rLSP5W78DuhtS1CjRzjBFuFT/SMUpKaDmbyQbaf5Ny9C9/VjhfYdnpgiZ1kT4rK1oaG+D2pemxAZ8LgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452477; c=relaxed/simple;
	bh=mICNe1S+9LRvNFhhGkvbfiJOntxHxtOYxhrITBJVBeg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0oFITfcr3QRX5bOV9r8mIbiOkJEyui5jyvbejO0Ftfq63KmDY/saASnVkvZlx2/iOeUQu+Ohl8IJSaNKX4ePz11p7DHeq7wLRQl0+V1Zgz/rHhAoL5FqyivN+6akZQrl4U4761ATKjptk/1owE+kYRIhXqJ7Bc7KijO45UKbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=tfqIf+D2; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 528CC12000F;
	Wed, 13 Nov 2024 02:01:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 528CC12000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731452463;
	bh=R6WWz//nSWu13Rk2hR17kLEi/SWTpz7lU17SkhzgBF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=tfqIf+D2WV3PG2BjQLgEsODuRAsdpGBhUM4IhaN5AQU3T8LjW83E/gY2p3Psz6HUN
	 fwEmKGhiAxQczKWcPdoOU/ENwfG1Q+ARivrcnz6OqoNjMw0dmUyTQAQauQxNt6oEWp
	 SPiBZn5dH6VzJpkhNrCc6UT7GNsdMkj6ahuKPy8LOGnAxa4vU/jabfY9XBx+nJ9QGg
	 HEuqz/WMQETjC81FAqbYyejehMW3myp7j4uu5cvLlGRsInanmuW7++zhSKjPP0+6hV
	 ajG5O/X3xqPIDvfMoYCwEhXQXYoM96JHaOT1jLkkuqPABw+WNHux9VK7fcqFGAmtND
	 YO9QGg/PR84WA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 13 Nov 2024 02:01:03 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Rob
 Herring" <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: reset: add bindings for A1 SoC audio reset controller
Date: Wed, 13 Nov 2024 02:00:55 +0300
Message-ID: <20241112230056.1406222-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112230056.1406222-1-jan.dakinevich@salutedevices.com>
References: <20241112230056.1406222-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 189131 [Nov 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/12 21:10:00 #26864167
X-KSMG-AntiVirus-Status: Clean, skipped

This reset controller is part of audio clock controller and handled by
auxiliary reset driver. Introduced defines supposed to be used together
with upcoming device tree nodes for audio clock controller fo A1 SoC.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../reset/amlogic,meson-a1-audio-reset.h      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h

diff --git a/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
new file mode 100644
index 000000000000..7693552f1507
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H
+
+#define AUD_RESET_DDRARB	0
+#define AUD_RESET_TDMIN_A	1
+#define AUD_RESET_TDMIN_B	2
+#define AUD_RESET_TDMIN_LB	3
+#define AUD_RESET_LOOPBACK	4
+#define AUD_RESET_TDMOUT_A	5
+#define AUD_RESET_TDMOUT_B	6
+#define AUD_RESET_FRDDR_A	7
+#define AUD_RESET_FRDDR_B	8
+#define AUD_RESET_TODDR_A	9
+#define AUD_RESET_TODDR_B	10
+#define AUD_RESET_SPDIFIN	11
+#define AUD_RESET_RESAMPLE	12
+#define AUD_RESET_EQDRC		13
+#define AUD_RESET_LOCKER	14
+#define AUD_RESET_TOACODEC	30
+#define AUD_RESET_CLKTREE	31
+
+#define AUD_VAD_RESET_DDRARB	0
+#define AUD_VAD_RESET_PDM	1
+#define AUD_VAD_RESET_TDMIN_VAD	2
+#define AUD_VAD_RESET_TODDR_VAD	3
+#define AUD_VAD_RESET_TOVAD	4
+#define AUD_VAD_RESET_CLKTREE	5
+
+#endif /* _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H */
-- 
2.34.1


