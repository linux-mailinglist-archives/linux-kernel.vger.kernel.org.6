Return-Path: <linux-kernel+bounces-382313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A569B0C37
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4951C21AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8120BB3F;
	Fri, 25 Oct 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwPgzxk0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D220BB2D;
	Fri, 25 Oct 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878859; cv=none; b=p6Axd2Yx+7TZV4dzaK2qfXEqOa60OyBl9A58qKLDiJNplACyEVMJMcQrkUgh5ZjZfYi7TtgMahnkLfgV20IP+r8P7zoZjFClLlX+0R6H/HK5H/aYk+ePTX08vLl695nouCQYFSeRiSPtfhre4UbtRJIqhg+TmAPM1pV1q1JOo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878859; c=relaxed/simple;
	bh=J9UkJXDKjREDaa5XlvCsqgwwDGJh04HffsdX39Ryvz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TfI/N3TWtGX7feMn+pDv0loZ1dmT1OTxLc+M4kdUCamQeAAIjQ7APTb4OWIxcUp31eXPae83UJFf7mR+xgs8toDGFpCOsdcvjX77HJLhXSzSO+n0VUmQpra89IYvqAddSpwwOtCCPVZh6XGmg20WwbPExSfwnMTvhwiOzLbBt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwPgzxk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5BCC4CEE8;
	Fri, 25 Oct 2024 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729878859;
	bh=J9UkJXDKjREDaa5XlvCsqgwwDGJh04HffsdX39Ryvz0=;
	h=From:To:Cc:Subject:Date:From;
	b=uwPgzxk0fQqm56dIBtNbszXEA0MWRY8qYv3wuB5H+HE3BNRlocNvVCFLDPu/O2c3N
	 wqo8GXGyN9KSAxBXLA/SnGGt/bX4Z+qygMLexbxYdAFeRmsFWhKlcKRsYkWu0cJYio
	 8YDlkrfpkGjp+GMBp4DMvo0DT4WbOJXl/nZ6DJrsbtqr/rDQnJT0dsWOeXn/BgY4UN
	 /o1mtVRD/I/W318obiOIXO7jkeusPRA+cr+zzV+GmwKM2Gu+KLv3SEk4QiKjxuVoG+
	 hvmvnaBewe3lvjh5COaZMv9YW7bBqss29RB7nYCtRB2LB+YJTiGGX9nvWtxQsPIZe2
	 c054mgsyiz5PQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 21A4A5FCB4; Sat, 26 Oct 2024 01:54:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: orangepi-5-plus: Enable USB 3.0 ports
Date: Sat, 26 Oct 2024 01:54:15 +0800
Message-Id: <20241025175415.887368-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The Orange Pi 5 Plus has its first USB 3.0 interface on the SoC wired
directly to the USB type C port next to the MASKROM button, and the
second interface wired to a USB 3.0 hub which in turn is connected to
the USB 3.0 host ports on the board, as well as the USB 2.0 connection
on the M.2 E-key slot.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../dts/rockchip/rk3588-orangepi-5-plus.dts   | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index dd03c9db6953..b826c5e368aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -177,6 +177,18 @@ daicodec: simple-audio-card,codec {
 		};
 	};
 
+	vbus_typec: vbus-typec-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&typec5v_pwren>;
+		regulator-name = "vbus_typec";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -339,6 +351,56 @@ &i2c6 {
 	clock-frequency = <400000>;
 	status = "okay";
 
+	usbc0: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus_typec>;
+		status = "okay";
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			op-sink-microwatt = <1000000>;
+			power-role = "dual";
+			sink-pdos =
+				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "source";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usbc0_hs: endpoint {
+						remote-endpoint = <&usb_host0_xhci_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					usbc0_ss: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					usbc0_sbu: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_sbu>;
+					};
+				};
+			};
+		};
+	};
+
 	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
@@ -480,6 +542,16 @@ vcc5v0_usb20_en: vcc5v0-usb20-en {
 			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb-typec {
+		usbc0_int: usbc0-int {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		typec5v_pwren: typec5v-pwren {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm2 {
@@ -871,6 +943,22 @@ &tsadc {
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -899,6 +987,33 @@ &uart9 {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	mode-switch;
+	orientation-switch;
+	sbu1-dc-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_typec_ss: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_ss>;
+		};
+
+		usbdp_phy0_typec_sbu: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usbc0_sbu>;
+		};
+	};
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
@@ -907,6 +1022,18 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb_host0_xhci_drd_sw: endpoint {
+			remote-endpoint = <&usbc0_hs>;
+		};
+	};
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
@@ -915,6 +1042,11 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &vop_mmu {
 	status = "okay";
 };
-- 
2.39.5


