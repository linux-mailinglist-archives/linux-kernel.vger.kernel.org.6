Return-Path: <linux-kernel+bounces-553304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31DA58721
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D43188C1E7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56620E00D;
	Sun,  9 Mar 2025 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Nr6EjHG2"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800C1F09AA;
	Sun,  9 Mar 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544499; cv=none; b=i47lkYmbVF2QSZohTOmWaAWSaA569H8pez2J3aMS3JrS62lDcwq1rgtfIDJiY+d4XviwnJ4bzg12d/2OZkisdJYEYgn70my9kzd8fE/rs6WE6VL5lKJ6dofCbv7MgkSF3du1qwxol1My1DUmnYLLZRTHOEyLEsnyWkxQTldw91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544499; c=relaxed/simple;
	bh=zBqNaChTyZsIW4PxZhaVQ18l+iW2I704awpUdR2gPIk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvPT3Ia4eqPPqsSQaMpveOe5SKXzRaUKKDmkxU3nOiLkTw4naNBkz3P61rS31TA9rn+wyOsHMOiK2WwBl0600D9hVhcNKuf6Qh/Q6cT4J5AFOlBgnkZsgjybzzwXVjhDpGS/Vhmdl3EKmn1qo1lFdhUD0BmulVPol7eYAjd3ud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Nr6EjHG2; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1E3E1120009;
	Sun,  9 Mar 2025 21:21:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1E3E1120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544495;
	bh=s04pQk8rE0esUEfzS9Lzjv0hhk+AvT2AINnV/GWmDis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Nr6EjHG2LsM2hGMYfBirsyqFO1ws8KgiQ9vzcWZqJQXyhVmNNrxCsfNyptOG06HwU
	 ZON41RN3mVrPZ69V+Y/fv1b96YL+neHXCHhrewSJfDmeTW+DWleS8ELhmsrCv5gO2J
	 vEKF/F+dJrlnuPUeTDRga7HIxv+uIyh6JCA32VvNho0WWXPbtr2U6nv/7bt7OH5c9R
	 eicROhIJ8pIIDdMd1D1L+ijl8GQ/7Z0bKbRqUWV0uHmbGdLVq65jufS+Ju/Hzwao3X
	 402eII1lvNcx5tugomwdpvLSTWzW9iQS7Pdsyf8lKMxlgcmU4NrCBRhxXK2y7eNFxP
	 zdMSgCYKO6Hcg==
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
Subject: [PATCH v2 6/6] arm64: dts: ad402: enable audio
Date: Sun, 9 Mar 2025 21:21:27 +0300
Message-ID: <20250309182127.1322890-7-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

 * playback to speaker

   - setup:
     $ amixer set "FRDDR_A SINK 1 SEL" "OUT 0"
     $ amixer set "FRDDR_A SRC 1 EN" "on"
     $ amixer set "TDMOUT_A SRC SEL" "IN 0"
     $ amixer set "TOACODEC Source" "I2S A"
     $ amixer set "TOACODEC Lane Select" "0"
     $ amixer set "TOACODEC EN" "on"
     $ amixer set "ACODEC" "70%"
     $ amixer set "ACODEC Playback Channel Mode" "Mono"

   - usage:
     $ aplay -D hw:0,0 -f S16_LE -r 48000 /path/to/sample.wav

 * capture from digital mics

   - setup:
     $ amixer set "TODDR_B SRC SEL" "IN 4"

   - usage:
     $ arecord -D hw:0,1 -f S32_LE -r 48000 -c 2 -t wav /path/to/sample.wav

 * capture from analog mics

   - setup:
     $ amixer set "TDMIN_A SRC SEL" "IN 3"
     $ amixer set "TODDR_A SRC SEL" "IN 0"
     $ amixer set "TOACODEC Source" "I2S A"
     $ amixer set "TOACODEC Lane Select" "0"
     $ amixer set "TOACODEC EN" "on"
     $ amixer set "ACODEC ADC" "70%"
     $ amixer set "ACODEC ADC Filter" "on"
     $ amixer set "ACODEC ADC Filter Mode" "HiFi"
     $ amixer set "ACODEC ADC PGA" "50%"

   - usage:
     $ arecord -D hw:0,2 -f S16_LE -r 48000 -c 2 -t wav /path/to/sample.wav

 * capture from TDM loopback

   - setup:
     $ amixer set "TDMIN_LB SRC SEL" "IN 0"
     $ amixer set "TODDR_B SRC SEL" "IN 6"

   - usage:
     $ arecord -D hw:0,1 -f S16_LE -r 48000 -c 2 -t wav /path/to/sample.wav

   or

   - setup:
     $ amixer set "TDMIN_LB SRC SEL" "IN 0"
     $ amixer set "TODDR_A SRC SEL" "IN 6"

   - usage:
     $ arecord -D hw:0,2 -f S16_LE -r 48000 -c 2 -t wav /path/to/sample.wav

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
index 0d92f5253b64..09a5732f0981 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
@@ -9,6 +9,8 @@
 #include "meson-a1.dtsi"
 #include <dt-bindings/thermal/thermal.h>
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	compatible = "amlogic,ad402", "amlogic,a1";
 	model = "Amlogic Meson A1 AD402 Development Board";
@@ -128,6 +130,98 @@ map1 {
 			};
 		};
 	};
+
+	amplifier: amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "AMPLIFIER";
+		enable-gpios = <&gpio GPIOF_4 GPIO_ACTIVE_HIGH>;
+		VCC-supply = <&battery_4v2>;
+	};
+
+	dmics: dmics {
+		compatible = "dmic-codec";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "MIC";
+		num-channels = <4>;
+		wakeup-delay-ms = <50>;
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "AD402";
+		audio-aux-devs = <&tdmout_a>,
+				 <&amplifier>,
+				 <&tdmin_lb>,
+				 <&tdmin_a>;
+		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
+				"TDM_A Playback", "TDMOUT_A OUT",
+				"AMPLIFIER INL", "ACODEC LOLP",
+				"AMPLIFIER INR", "ACODEC LORP",
+
+				"TODDR_B IN 4", "PDM Capture",
+
+				"TDMIN_LB IN 0", "TDM_A Loopback",
+				"TODDR_A IN 6", "TDMIN_LB OUT",
+				"TODDR_B IN 6", "TDMIN_LB OUT",
+
+				"TDMIN_A IN 3", "TDM_A Capture",
+				"TODDR_A IN 0", "TDMIN_A OUT";
+		assigned-clocks = <&clkc_pll CLKID_HIFI_PLL>;
+		assigned-clock-parents = <0>;
+		assigned-clock-rates = <1536000000>;
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-3 {
+			sound-dai = <&tdmif_a>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-rx-mask-0 = <1 1>;
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&toacodec TOACODEC_IN_A>;
+			};
+
+			codec-1 {
+				sound-dai = <&toacodec TOACODEC_CAPTURE_OUT_A>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&toacodec TOACODEC_OUT>;
+
+			codec {
+				sound-dai = <&acodec>;
+			};
+		};
+
+		dai-link-5 {
+			sound-dai = <&toacodec TOACODEC_CAPTURE_IN>;
+
+			codec {
+				sound-dai = <&acodec>;
+			};
+		};
+
+		dai-link-6 {
+			sound-dai = <&pdm>;
+
+			codec {
+				sound-dai = <&dmics>;
+			};
+		};
+	};
 };
 
 /* Bluetooth HCI H4 */
@@ -190,3 +284,19 @@ &sd_emmc {
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_1v8>;
 };
+
+&acodec {
+	AVDD-supply = <&vddio_1v8>;
+	lineout-left = "right-inverted";
+	lineout-right = "right";
+	linein-left = "differential";
+	linein-right = "differential";
+	micbias = "2.5V";
+};
+
+&pdm {
+	pinctrl-0 = <&pdm_din0_a_pins>,
+		    <&pdm_din1_a_pins>,
+		    <&pdm_dclk_a_pins>;
+	pinctrl-names = "default";
+};
-- 
2.34.1


