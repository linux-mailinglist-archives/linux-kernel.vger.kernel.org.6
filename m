Return-Path: <linux-kernel+bounces-553303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B810A58724
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EDB3AB38F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E899214A7D;
	Sun,  9 Mar 2025 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="K7gA5KDD"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE71F09A0;
	Sun,  9 Mar 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544498; cv=none; b=OGbqfl/6luW5LH1RHQfORk8A5PWhus6wqgFDCPvjk/7WmtXCGxk9nqW3qmwuvLgoSbMelgtOEBslpyI2VOocTMZu/3gxL2d1QSuSiABLkb5m4SwQiDZWFt84Bjk691a6AyOK0px0yByA9m6/vSEpz8r6GPbsInJ1Zx9RmXbtwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544498; c=relaxed/simple;
	bh=RDWZ0lH0FL3PW+6h3nf/wnvEnJXrZMnSaazEmRt5NDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHAcUHlZ5cxFfbDiOX6iZZ6zplbDVxW9RjMODsulE4f8vSjwVphtD7HunqyPLEg+bRBckDQr2Gmqccdf8cJu4wCNDQDJdrda/C/U/bNou20SuXgUVK8Ny5z40/wCtQO0ldYOXLLaqx3UOs0QJZmnSvr8xvky/1JwHhir46TZTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=K7gA5KDD; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B848110000A;
	Sun,  9 Mar 2025 21:21:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B848110000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544494;
	bh=PsuE9FrIXsRPBDeMdPlBaE6v7BVynX/M7rzn67mMUac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=K7gA5KDDj/GUhr0vgZugfy0YNjXJ0XBVTNIKXKNGdGnIg9vICJ3fEILP7SnTedXp5
	 2WndWcjuna+3+J3j/jZNkG+GMzEnwRGXDkAoHbp6Usvalbabj8fd8MSu+ecUmXz4EI
	 hvYGi4TMb/eyUjs6gINpTx6wtDfCzH0ICNfcuZ02GoIgrKxls/5fmE39Nt5BRkGytd
	 pvXHJghMnJGHP3ATRVn9SJ5PEmNgnYp8799+I2OJn+EhCSPzY4Tlcf8ybEOEfpXzK+
	 3X5NvlgcHn2gXbTZ8cN92Ec35Sk1ld1uYBEmmHKk3Us0AXXww5Qzb77NLx9v7BW5hc
	 R0Qveu1MVp8pg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:21:34 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob
 Herring <robh@kernel.org>
Subject: [PATCH v2 5/6] arm64: dts: meson: a1: add audio devices
Date: Sun, 9 Mar 2025 21:21:26 +0300
Message-ID: <20250309182127.1322890-6-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
References: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

This commit adds the declarartion of currently supported audio devices
and their pins found Amlog A1 SoC family. SPDIF declaration is missing
here becase there are no publicly available boards with it.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 443 ++++++++++++++++++++++
 1 file changed, 443 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index cf0247fce740..b09df1da81c3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -11,6 +11,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/meson-a1-power.h>
 #include <dt-bindings/reset/amlogic,meson-a1-reset.h>
+#include <dt-bindings/reset/amlogic,meson-a1-audio-reset.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+#include <dt-bindings/sound/meson-g12a-toacodec.h>
 
 / {
 	compatible = "amlogic,a1";
@@ -465,6 +468,250 @@ mux {
 						function = "spif";
 					};
 				};
+
+				tdm_a_din0_pins: tdm-a-din0 {
+					mux {
+						groups = "tdm_a_din0";
+						function = "tdm_a";
+						bias-disable;
+					};
+				};
+
+				tdm_a_din1_pins: tdm-a-din1 {
+					mux {
+						groups = "tdm_a_din1";
+						function = "tdm_a";
+						bias-disable;
+					};
+				};
+
+				tdm_a_dout0_pins: tdm-a-dout0 {
+					mux {
+						groups = "tdm_a_dout0";
+						function = "tdm_a";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_a_dout1_pins: tdm-a-dout1 {
+					mux {
+						groups = "tdm_a_dout1";
+						function = "tdm_a";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_a_fs_pins: tdm-a-fs {
+					mux {
+						groups = "tdm_a_fs";
+						function = "tdm_a";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_a_sclk_pins: tdm-a-sclk {
+					mux {
+						groups = "tdm_a_sclk";
+						function = "tdm_a";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_a_slv_fs_pins: tdm-a-slv-fs {
+					mux {
+						groups = "tdm_a_slv_fs";
+						function = "tdm_a";
+						bias-disable;
+					};
+				};
+
+				tdm_a_slv_sclk_pins: tdm-a-slv-sclk {
+					mux {
+						groups = "tdm_a_slv_sclk";
+						function = "tdm_a";
+						bias-disable;
+					};
+				};
+
+				tdm_b_din0_pins: tdm-b-din0 {
+					mux {
+						groups = "tdm_b_din0";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				tdm_b_din1_pins: tdm-b-din1 {
+					mux {
+						groups = "tdm_b_din1";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				tdm_b_din2_pins: tdm-b-din2 {
+					mux {
+						groups = "tdm_b_din2";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				tdm_b_dout0_pins: tdm-b-dout0 {
+					mux {
+						groups = "tdm_b_dout0";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout1_pins: tdm-b-dout1 {
+					mux {
+						groups = "tdm_b_dout1";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout2_pins: tdm-b-dout2 {
+					mux {
+						groups = "tdm_b_dout2";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout3_pins: tdm-b-dout3 {
+					mux {
+						groups = "tdm_b_dout3";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout4_pins: tdm-b-dout4 {
+					mux {
+						groups = "tdm_b_dout4";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout5_pins: tdm-b-dout5 {
+					mux {
+						groups = "tdm_b_dout5";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_fs_pins: tdm-b-fs {
+					mux {
+						groups = "tdm_b_fs";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_sclk_pins: tdm-b-sclk {
+					mux {
+						groups = "tdm_b_sclk";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_slv_fs_pins: tdm-b-slv-fs {
+					mux {
+						groups = "tdm_b_slv_fs";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				tdm_b_slv_sclk_pins: tdm-b-slv-sclk {
+					mux {
+						groups = "tdm_b_slv_sclk";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				pdm_din0_a_pins: pdm-din0-a {
+					mux {
+						groups = "pdm_din0_a";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din0_x_pins: pdm-din0-x {
+					mux {
+						groups = "pdm_din0_x";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din1_a_pins: pdm-din1-a {
+					mux {
+						groups = "pdm_din1_a";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din1_x_pins: pdm-din1-x {
+					mux {
+						groups = "pdm_din1_x";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din2_a_pins: pdm-din2-a {
+					mux {
+						groups = "pdm_din2_a";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din2_x_pins: pdm-din2-x {
+					mux {
+						groups = "pdm_din2_x";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_dclk_a_pins: pdm-dclk-a {
+					mux {
+						groups = "pdm_dclk_a";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_dclk_x_pins: pdm-dclk-x {
+					mux {
+						groups = "pdm_dclk_x";
+						function = "pdm";
+						bias-disable;
+					};
+				};
 			};
 
 			gpio_intc: interrupt-controller@440 {
@@ -666,6 +913,17 @@ sd_emmc: mmc@10000 {
 				status = "disabled";
 			};
 
+			acodec: audio-controller@4800 {
+				compatible = "amlogic,t9015-a1";
+				reg = <0x0 0x4800 0x0 0x14>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "ACODEC";
+				clocks = <&clkc_periphs CLKID_AUDIO>;
+				clock-names = "pclk";
+				resets = <&reset RESET_ACODEC>;
+				power-domains = <&pwrc PWRC_ACODEC_ID>;
+			};
+
 			audio: bus@50000 {
 				compatible = "simple-bus";
 				#address-cells = <2>;
@@ -712,6 +970,171 @@ clkc_audio_vad: clock-controller@4800 {
 						      "mst_in4";
 					resets = <&reset RESET_AUDIO_VAD>;
 				};
+
+				toddr_a: audio-controller@100 {
+					compatible = "amlogic,a1-toddr",
+						     "amlogic,sm1-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x100 0x0 0x2c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_A";
+					interrupts = <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
+					resets = <&arb AXG_ARB_TODDR_A>,
+						 <&clkc_audio AUD_RESET_TODDR_A>;
+					reset-names = "arb", "rst";
+					amlogic,fifo-depth = <128>;
+				};
+
+				toddr_b: audio-controller@140 {
+					compatible = "amlogic,a1-toddr",
+						     "amlogic,sm1-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x140 0x0 0x2c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_B";
+					interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
+					resets = <&arb AXG_ARB_TODDR_B>,
+						 <&clkc_audio AUD_RESET_TODDR_B>;
+					reset-names = "arb", "rst";
+					amlogic,fifo-depth = <128>;
+				};
+
+				frddr_a: audio-controller@1c0 {
+					compatible = "amlogic,a1-frddr",
+						     "amlogic,sm1-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x1c0 0x0 0x2c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_A";
+					interrupts = <GIC_SPI 40 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+					resets = <&arb AXG_ARB_FRDDR_A>,
+						 <&clkc_audio AUD_RESET_FRDDR_A>;
+					reset-names = "arb", "rst";
+					amlogic,fifo-depth = <128>;
+				};
+
+				frddr_b: audio-controller@200 {
+					compatible = "amlogic,a1-frddr",
+						     "amlogic,sm1-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x200 0x0 0x2c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_B";
+					interrupts = <GIC_SPI 41 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
+					resets = <&arb AXG_ARB_FRDDR_B>,
+						 <&clkc_audio AUD_RESET_FRDDR_B>;
+					reset-names = "arb", "rst";
+					amlogic,fifo-depth = <128>;
+				};
+
+				arb: reset-controller@280 {
+					compatible = "amlogic,meson-a1-audio-arb",
+						     "amlogic,meson-sm1-audio-arb";
+					reg = <0x0 0x280 0x0 0x4>;
+					#reset-cells = <1>;
+					clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
+				};
+
+				tdmin_a: audio-controller@300 {
+					compatible = "amlogic,a1-tdmin",
+						     "amlogic,sm1-tdmin";
+					reg = <0x0 0x300 0x0 0x40>;
+					sound-name-prefix = "TDMIN_A";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMIN_A>;
+				};
+
+				tdmin_b: audio-controller@340 {
+					compatible = "amlogic,a1-tdmin",
+						     "amlogic,sm1-tdmin";
+					reg = <0x0 0x340 0x0 0x40>;
+					sound-name-prefix = "TDMIN_B";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMIN_B>;
+				};
+
+				tdmin_lb: audio-controller@3c0 {
+					compatible = "amlogic,a1-tdmin",
+						     "amlogic,sm1-tdmin";
+					reg = <0x0 0x3c0 0x0 0x40>;
+					sound-name-prefix = "TDMIN_LB";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMIN_LB>;
+				};
+
+				tdmout_a: audio-controller@500 {
+					compatible = "amlogic,a1-tdmout",
+						     "amlogic,sm1-tdmout";
+					reg = <0x0 0x500 0x0 0x40>;
+					sound-name-prefix = "TDMOUT_A";
+					clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
+				};
+
+				tdmout_b: audio-controller@540 {
+					compatible = "amlogic,a1-tdmout",
+						     "amlogic,sm1-tdmout";
+					reg = <0x0 0x540 0x0 0x40>;
+					sound-name-prefix = "TDMOUT_B";
+					clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_B>;
+				};
+
+				toacodec: audio-controller@740 {
+					compatible = "amlogic,a1-toacodec",
+						     "amlogic,g12a-toacodec";
+					reg = <0x0 0x740 0x0 0x4>;
+					#sound-dai-cells = <1>;
+					sound-name-prefix = "TOACODEC";
+					resets = <&clkc_audio AUD_RESET_TOACODEC>;
+				};
+
+				pdm: audio-controller@1000 {
+					compatible = "amlogic,a1-pdm",
+						     "amlogic,axg-pdm";
+					reg = <0x0 0x1000 0x0 0x34>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "PDM";
+					clocks = <&clkc_audio_vad AUD_VAD_CLKID_PDM>,
+						 <&clkc_audio_vad AUD_VAD_CLKID_PDM_DCLK>,
+						 <&clkc_audio_vad AUD_VAD_CLKID_PDM_SYSCLK>;
+					clock-names = "pclk", "dclk", "sysclk";
+					power-domains = <&pwrc PWRC_PDMIN_ID>;
+				};
 			};
 		};
 
@@ -794,4 +1217,24 @@ xtal: xtal-clk {
 		clock-output-names = "xtal";
 		#clock-cells = <0>;
 	};
+
+	tdmif_a: audio-controller-0 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_A";
+		clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_MCLK>;
+		clock-names = "sclk", "lrclk", "mclk";
+	};
+
+	tdmif_b: audio-controller-1 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_B";
+		clocks = <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_MCLK>;
+		clock-names = "sclk", "lrclk", "mclk";
+	};
 };
-- 
2.34.1


