Return-Path: <linux-kernel+bounces-523519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5BA3D7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BB019C2151
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8361F3B94;
	Thu, 20 Feb 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YUIefjQK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29361F0E3A;
	Thu, 20 Feb 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049804; cv=none; b=VuJuzziVX04e3NDvA8kAUZi8FHqhqAI0uSTo4Ik90ZjCQ4Jv4AMpZhKxcFqUdeqtgEHkWQ2gZveb+P+wxW8zqRvplaAuonAHZEBQhPbJXUB7RiN4u5D5VSFDyVMmmysjEohyOwuuXuKCMKVGYrTfc1bebIOOGpO7jHh1S0JXrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049804; c=relaxed/simple;
	bh=CgnTh2SgXWfWMsbA62uV8poLmBzORUJLbZLqZihFI3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMv17Om3j2vfDcVBiR6wSs0P/8dznmKu29ThkwFKAUTYzoGTEuVOMZZXrjzskQwA+b3+aD2sepfiWriYIS1YtkL9rCCV2PjhZIE3CkAK00tMfIQOZNSyuyVlcMcpvtlcZWWJ9hZsGuX3gSc4F416+QeJCbiJlzLX6ycNUEiku/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YUIefjQK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740049801;
	bh=CgnTh2SgXWfWMsbA62uV8poLmBzORUJLbZLqZihFI3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUIefjQKKUvm5ZQ6wRnlU7fYJLC3zcRmYt3Vl+aYKLx6yw5+uy8VskdXG7J/8Qk96
	 dY1woKR2wsWtDL9ce3urS9YqSdr0QSBwCF7LUQih0XKK6j/xLSA+QBcocB4Nk7ez0E
	 kMUrTklbsJCgApVPVyKqRw9J+CmA6a7a3a0970SRAogrfeYULhQvQzFkrrlCbhBxkH
	 jKsX0Dgs/8OHnbKmIfUHTFB7UlN+LI5FoBeYrcMkLJwSz7EoxjhN0cnjK9DIPbq/LB
	 i86WydurZ2F8O6irQ3gC5UzuFwlKXNjJ/iI6a3HdF0bpm5RITVokmgUDnVnca5hA6L
	 zLtIOdNxb0BtA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7499517E156B;
	Thu, 20 Feb 2025 12:10:00 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v1 3/4] arm64: dts: mediatek: mt8188-geralt: Add graph for DSI and DP displays
Date: Thu, 20 Feb 2025 12:09:47 +0100
Message-ID: <20250220110948.45596-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
References: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The base SoC devicetree now defines a display controller graph:
connect the board specific outputs (eDP internal display, DP
external display) to fully migrate Cherry and make it finally
possible to make Chromebooks and other board types to coexist
without per-board driver modifications.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 155 +++++++++++++++++-
 1 file changed, 148 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index faed5c8bc721..c5254ae0bb99 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -9,6 +9,7 @@
 
 / {
 	aliases {
+		dsi0 = &disp_dsi0;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -273,14 +274,27 @@ dsi_panel: panel@0 {
 
 		port {
 			dsi_panel_in: endpoint {
-				remote-endpoint = <&dsi_out>;
+				remote-endpoint = <&dsi0_out>;
 			};
 		};
 	};
 
-	port {
-		dsi_out: endpoint {
-			remote-endpoint = <&dsi_panel_in>;
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dsi0_in: endpoint {
+				remote-endpoint = <&dither0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dsi0_out: endpoint {
+				remote-endpoint = <&dsi_panel_in>;
+			};
 		};
 	};
 };
@@ -296,12 +310,74 @@ &disp_pwm1 {
 	pinctrl-0 = <&disp_pwm1_pins>;
 };
 
+&dither0_in {
+	remote-endpoint = <&postmask0_out>;
+};
+
+&dither0_out {
+	remote-endpoint = <&dsi0_in>;
+};
+
+&ethdr0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			ethdr0_in: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&vdosys1_ep_ext>;
+			};
+		};
+
+		port@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			ethdr0_out: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&merge5_in>;
+			};
+		};
+	};
+};
+
+&gamma0_out {
+	remote-endpoint = <&postmask0_in>;
+};
+
 &dp_intf1 {
 	status = "okay";
 
-	port {
-		dp_intf1_out: endpoint {
-			remote-endpoint = <&dptx_in>;
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			dp_intf1_in: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&merge5_out>;
+			};
+		};
+
+		port@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			dp_intf1_out: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&dptx_in>;
+			};
 		};
 	};
 };
@@ -394,6 +470,35 @@ &i2c6 {
 	status = "okay";
 };
 
+&merge5 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			merge5_in: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&ethdr0_out>;
+			};
+		};
+
+		port@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			merge5_out: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&dp_intf1_in>;
+			};
+		};
+	};
+};
+
 &mfg0 {
 	domain-supply = <&mt6359_vproc2_buck_reg>;
 };
@@ -513,6 +618,10 @@ flash@0 {
 	};
 };
 
+&ovl0_in {
+	remote-endpoint = <&vdosys0_ep_main>;
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
@@ -1029,6 +1138,14 @@ &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&postmask0_in {
+	remote-endpoint = <&gamma0_out>;
+};
+
+&postmask0_out {
+	remote-endpoint = <&dither0_in>;
+};
+
 &sound {
 	pinctrl-names = "aud_etdm_hp_on", "aud_etdm_hp_off",
 			"aud_etdm_spk_on", "aud_etdm_spk_off",
@@ -1135,6 +1252,30 @@ &ssusb2 {
 	status = "okay";
 };
 
+&vdosys0 {
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdosys0_ep_main: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&ovl0_in>;
+		};
+	};
+};
+
+&vdosys1 {
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdosys1_ep_ext: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&ethdr0_in>;
+		};
+	};
+};
+
 &xhci2 {
 	/* no power supply since MT7921's power is controlled by PCIe */
 	/* MT7921's USB BT has issues with USB2 LPM */
-- 
2.48.1


