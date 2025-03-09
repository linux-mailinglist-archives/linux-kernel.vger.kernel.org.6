Return-Path: <linux-kernel+bounces-553273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB3A586B3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD451884CF5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B241F4C81;
	Sun,  9 Mar 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SV/xjMQP"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4D1EF398;
	Sun,  9 Mar 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543130; cv=none; b=U1NDBcErtsYD0TeHvrDaF5MfcMTbIE61bMyxSGNG5bJD6drQV/2YDclMRq/jk+eNvhTabOh4xOyLW9HxU8yce7yqCbe/9PpMCSZiRCjUNCNjxRhMf7IOCWLFSIuzW7MqrLxsUkSIwhvxpfdJ1xU2ELfYpO/PA/iqu1Ft3MUiK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543130; c=relaxed/simple;
	bh=YR5F62nzTkm61DF6L9OZv0/1q2kDXISugNqaQYKb2YQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=to1tXcI4ZS5i1o4VrkWmMcYc74O7CDoDEcjWU4DJXo+L3Eee5npJZZ4rHDJXU5d2zfZjhvRM+6VLU0jzkRIn9OPoVpqgAkE8ByXiKzw6nLyMYdOu1r1rBB4TUlX98WHJbpGlv8tNgLOfYalrcKZV7u2CgERQbli4urjia37Igr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SV/xjMQP; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0EA68100006;
	Sun,  9 Mar 2025 20:58:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0EA68100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741543125;
	bh=kPV/BnBSZwkzP1CAXcGTb/b489Qh5Q8Y01cLz+m8DDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SV/xjMQPBne/db251hG70CMder/nAcykeam1/SebWkoPALHpNCchFEexp3K6rwUJT
	 BNXJfzOgReRFa8vm5ECqdRFljQ7OWoMi1mTMG8GlDvNYmWsV6e0p2U3W1r2N1JG5Df
	 bxYio3dMuO5eG5kJynjA81EJX6eePOfnm595oyvGgjH4Wgnb81ihO5/BamamjjQwyt
	 Kz7NVTY7RKNVRaUjucQ2wdsqLdkTxeL/0qzKKAsjyMV0f2qJOBnaZJ1YOweyjFd9+L
	 PkysgKHDzKutMFtCv61ux/2GXADKwTihXdKaR8kXUiV/EosCpm6zVsdj6rfQHwfe6C
	 nGPpSQInKNlOQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 20:58:44 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v6 2/4] dt-bindings: clock: axg-audio: document A1 SoC audio clock controller driver
Date: Sun, 9 Mar 2025 20:58:36 +0300
Message-ID: <20250309175838.1322014-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309175838.1322014-1-jan.dakinevich@salutedevices.com>
References: <20250309175838.1322014-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, smtp.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

Add device tree bindings for A1 SoC audio clock and reset controllers.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../clock/amlogic,axg-audio-clkc.yaml         |   4 +
 .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 139 ++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
index fd7982dd4cea..10202b749001 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
@@ -18,6 +18,8 @@ description:
 properties:
   compatible:
     enum:
+      - amlogic,a1-audio-clkc
+      - amlogic,a1-audio-vad-clkc
       - amlogic,axg-audio-clkc
       - amlogic,g12a-audio-clkc
       - amlogic,sm1-audio-clkc
@@ -114,6 +116,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - amlogic,a1-audio-clkc
+              - amlogic,a1-audio-vad-clkc
               - amlogic,g12a-audio-clkc
               - amlogic,sm1-audio-clkc
     then:
diff --git a/include/dt-bindings/clock/amlogic,a1-audio-clkc.h b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
new file mode 100644
index 000000000000..78e7a432d439
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
+ */
+
+#ifndef __A1_AUDIO_CLKC_BINDINGS_H
+#define __A1_AUDIO_CLKC_BINDINGS_H
+
+#define AUD_CLKID_DDR_ARB			1
+#define AUD_CLKID_TDMIN_A			2
+#define AUD_CLKID_TDMIN_B			3
+#define AUD_CLKID_TDMIN_LB			4
+#define AUD_CLKID_LOOPBACK			5
+#define AUD_CLKID_TDMOUT_A			6
+#define AUD_CLKID_TDMOUT_B			7
+#define AUD_CLKID_FRDDR_A			8
+#define AUD_CLKID_FRDDR_B			9
+#define AUD_CLKID_TODDR_A			10
+#define AUD_CLKID_TODDR_B			11
+#define AUD_CLKID_SPDIFIN			12
+#define AUD_CLKID_RESAMPLE			13
+#define AUD_CLKID_EQDRC				14
+#define AUD_CLKID_LOCKER			15
+#define AUD_CLKID_MST_A_MCLK_SEL		16
+#define AUD_CLKID_MST_A_MCLK_DIV		17
+#define AUD_CLKID_MST_A_MCLK			18
+#define AUD_CLKID_MST_B_MCLK_SEL		19
+#define AUD_CLKID_MST_B_MCLK_DIV		20
+#define AUD_CLKID_MST_B_MCLK			21
+#define AUD_CLKID_MST_C_MCLK_SEL		22
+#define AUD_CLKID_MST_C_MCLK_DIV		23
+#define AUD_CLKID_MST_C_MCLK			24
+#define AUD_CLKID_MST_D_MCLK_SEL		25
+#define AUD_CLKID_MST_D_MCLK_DIV		26
+#define AUD_CLKID_MST_D_MCLK			27
+#define AUD_CLKID_MST_A_SCLK_PRE_EN		28
+#define AUD_CLKID_MST_A_SCLK_DIV		29
+#define AUD_CLKID_MST_A_SCLK_POST_EN		30
+#define AUD_CLKID_MST_A_SCLK			31
+#define AUD_CLKID_MST_B_SCLK_PRE_EN		32
+#define AUD_CLKID_MST_B_SCLK_DIV		33
+#define AUD_CLKID_MST_B_SCLK_POST_EN		34
+#define AUD_CLKID_MST_B_SCLK			35
+#define AUD_CLKID_MST_C_SCLK_PRE_EN		36
+#define AUD_CLKID_MST_C_SCLK_DIV		37
+#define AUD_CLKID_MST_C_SCLK_POST_EN		38
+#define AUD_CLKID_MST_C_SCLK			39
+#define AUD_CLKID_MST_D_SCLK_PRE_EN		40
+#define AUD_CLKID_MST_D_SCLK_DIV		41
+#define AUD_CLKID_MST_D_SCLK_POST_EN		42
+#define AUD_CLKID_MST_D_SCLK			43
+#define AUD_CLKID_MST_A_LRCLK_DIV		44
+#define AUD_CLKID_MST_A_LRCLK			45
+#define AUD_CLKID_MST_B_LRCLK_DIV		46
+#define AUD_CLKID_MST_B_LRCLK			47
+#define AUD_CLKID_MST_C_LRCLK_DIV		48
+#define AUD_CLKID_MST_C_LRCLK			49
+#define AUD_CLKID_MST_D_LRCLK_DIV		50
+#define AUD_CLKID_MST_D_LRCLK			51
+#define AUD_CLKID_TDMIN_A_SCLK_SEL		52
+#define AUD_CLKID_TDMIN_A_SCLK_PRE_EN		53
+#define AUD_CLKID_TDMIN_A_SCLK_POST_EN		54
+#define AUD_CLKID_TDMIN_A_SCLK			55
+#define AUD_CLKID_TDMIN_A_LRCLK			56
+#define AUD_CLKID_TDMIN_B_SCLK_SEL		57
+#define AUD_CLKID_TDMIN_B_SCLK_PRE_EN		58
+#define AUD_CLKID_TDMIN_B_SCLK_POST_EN		59
+#define AUD_CLKID_TDMIN_B_SCLK			60
+#define AUD_CLKID_TDMIN_B_LRCLK			61
+#define AUD_CLKID_TDMIN_LB_SCLK_SEL		62
+#define AUD_CLKID_TDMIN_LB_SCLK_PRE_EN		63
+#define AUD_CLKID_TDMIN_LB_SCLK_POST_EN		64
+#define AUD_CLKID_TDMIN_LB_SCLK			65
+#define AUD_CLKID_TDMIN_LB_LRCLK		66
+#define AUD_CLKID_TDMOUT_A_SCLK_SEL		67
+#define AUD_CLKID_TDMOUT_A_SCLK_PRE_EN		68
+#define AUD_CLKID_TDMOUT_A_SCLK_POST_EN		69
+#define AUD_CLKID_TDMOUT_A_SCLK			70
+#define AUD_CLKID_TDMOUT_A_LRCLK		71
+#define AUD_CLKID_TDMOUT_B_SCLK_SEL		72
+#define AUD_CLKID_TDMOUT_B_SCLK_PRE_EN		73
+#define AUD_CLKID_TDMOUT_B_SCLK_POST_EN		74
+#define AUD_CLKID_TDMOUT_B_SCLK			75
+#define AUD_CLKID_TDMOUT_B_LRCLK		76
+#define AUD_CLKID_SPDIFIN_CLK_SEL		77
+#define AUD_CLKID_SPDIFIN_CLK_DIV		78
+#define AUD_CLKID_SPDIFIN_CLK			79
+#define AUD_CLKID_RESAMPLE_CLK_SEL		80
+#define AUD_CLKID_RESAMPLE_CLK_DIV		81
+#define AUD_CLKID_RESAMPLE_CLK			82
+#define AUD_CLKID_EQDRC_CLK_SEL			83
+#define AUD_CLKID_EQDRC_CLK_DIV			84
+#define AUD_CLKID_EQDRC_CLK			85
+#define AUD_CLKID_LOCKER_IN_CLK_SEL		86
+#define AUD_CLKID_LOCKER_IN_CLK_DIV		87
+#define AUD_CLKID_LOCKER_IN_CLK			88
+#define AUD_CLKID_LOCKER_OUT_CLK_SEL		89
+#define AUD_CLKID_LOCKER_OUT_CLK_DIV		90
+#define AUD_CLKID_LOCKER_OUT_CLK		91
+
+#define AUD_VAD_CLKID_CLK81			1
+#define AUD_VAD_CLKID_SYSCLK_A_DIV		2
+#define AUD_VAD_CLKID_SYSCLK_A			3
+#define AUD_VAD_CLKID_SYSCLK_B_DIV		4
+#define AUD_VAD_CLKID_SYSCLK_B			5
+#define AUD_VAD_CLKID_SYSCLK			6
+#define AUD_VAD_CLKID_DDR_ARB			7
+#define AUD_VAD_CLKID_PDM			8
+#define AUD_VAD_CLKID_TDMIN_VAD			9
+#define AUD_VAD_CLKID_TODDR_VAD			10
+#define AUD_VAD_CLKID_TOVAD			11
+#define AUD_VAD_CLKID_TOAUDIOTOP		12
+#define AUD_VAD_CLKID_MST_VAD_MCLK_SEL		13
+#define AUD_VAD_CLKID_MST_VAD_MCLK_DIV		14
+#define AUD_VAD_CLKID_MST_VAD_MCLK		15
+#define AUD_VAD_CLKID_MST_VAD_SCLK_PRE_EN	16
+#define AUD_VAD_CLKID_MST_VAD_SCLK_DIV		17
+#define AUD_VAD_CLKID_MST_VAD_SCLK_POST_EN	18
+#define AUD_VAD_CLKID_MST_VAD_SCLK		19
+#define AUD_VAD_CLKID_MST_VAD_LRCLK_DIV		20
+#define AUD_VAD_CLKID_MST_VAD_LRCLK		21
+#define AUD_VAD_CLKID_TDMIN_VAD_SCLK_SEL	22
+#define AUD_VAD_CLKID_TDMIN_VAD_SCLK_PRE_EN	23
+#define AUD_VAD_CLKID_TDMIN_VAD_SCLK_POST_EN	24
+#define AUD_VAD_CLKID_TDMIN_VAD_SCLK		25
+#define AUD_VAD_CLKID_TDMIN_VAD_LRCLK		26
+#define AUD_VAD_CLKID_PDM_DCLK_SEL		27
+#define AUD_VAD_CLKID_PDM_DCLK_DIV		28
+#define AUD_VAD_CLKID_PDM_DCLK			29
+#define AUD_VAD_CLKID_PDM_SYSCLK_SEL		30
+#define AUD_VAD_CLKID_PDM_SYSCLK_DIV		31
+#define AUD_VAD_CLKID_PDM_SYSCLK		32
+#define AUD_VAD_CLKID_VAD_CLK_SEL		33
+#define AUD_VAD_CLKID_VAD_CLK_DIV		34
+#define AUD_VAD_CLKID_VAD_CLK			35
+
+#endif /* __A1_AUDIO_CLKC_BINDINGS_H */
-- 
2.34.1


