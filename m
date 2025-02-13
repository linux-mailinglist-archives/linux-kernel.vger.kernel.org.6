Return-Path: <linux-kernel+bounces-512793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3BA33DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F84188C526
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2522156A;
	Thu, 13 Feb 2025 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YZ9OTZI4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA021D3DD;
	Thu, 13 Feb 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445652; cv=none; b=S+ZNpT0/ecyGAyRN40LRk/lp7NJXoUABkoLTk7Yqqf3K7X26XdIvsbmsA2dejfB8AtqaLYmJ1hPuJiM75xP0OPceVmeWwbwiuCU8wVq2S3WDao3kGN28r3CVPmOg+14miFfIqBZrK5+3hBKR1gM8EnLc71roCfgbcnxOHTlPXWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445652; c=relaxed/simple;
	bh=gl5uey3T1IdKoOqsi3qxWPdBdxW4KBhVaCWZJWYFlfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSDisdFpMXQAfkd8AnsOS3IfSwsUJb4ALQsDiJls1uG3WN7ZiLiIDj72VFidvy7xxlbsdO9zFwTYSDjDTggY8i5e6+0RtFRm4iu8ywGTkEck9eJqTtcv6ktfeMXhCMisYouJylUlzB8QJV3QHg6c7MjcH8sPY1cAIcrqUqQ6C8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YZ9OTZI4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739445649;
	bh=gl5uey3T1IdKoOqsi3qxWPdBdxW4KBhVaCWZJWYFlfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZ9OTZI4hUuzzzPyAu8/CmlchKp/NnRueQtyzM89S24VfAITDX/uDpqnMPEBH3HMl
	 2AichHBT60euNC1CsznTZB8ZzCgpy8W50XbmkK+8eARPXk3UrOM/Axjxmc9o8rZoj6
	 HzT6xU4M4/v4bEiyivmErpz33Fp6K3CVU+gQawlfFBwsV3fkS6jnMPhns5gRpamEha
	 SAuAOLnHecVZnV9kOTaj4lCHPTx+BG93Kbze+mM13hHhgs705XnEtoL9N/MdafYHeU
	 lk2HMCXsWfZirRH3cgzz6NNWD7V9K2AB1O7rYcmMDuFDftF6A/RFGd2tbpn0fTLQLJ
	 SN3bupdS4ejJQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A54DC17E0FC1;
	Thu, 13 Feb 2025 12:20:48 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v1 2/3] arm64: mediatek: mt8195-cherry: Add graph for eDP and DP displays
Date: Thu, 13 Feb 2025 12:20:07 +0100
Message-ID: <20250213112008.56394-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
References: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
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
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 184 +++++++++++++++++-
 1 file changed, 177 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 5056e07399e2..e70599807bb1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -297,12 +297,29 @@ &cpu7 {
 	cpu-supply = <&mt6315_6_vbuck1>;
 };
 
+&dither0_out {
+	remote-endpoint = <&dsc0_in>;
+};
+
 &dp_intf0 {
 	status = "okay";
 
-	port {
-		dp_intf0_out: endpoint {
-			remote-endpoint = <&edp_in>;
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dp_intf0_in: endpoint {
+				remote-endpoint = <&merge0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dp_intf0_out: endpoint {
+				remote-endpoint = <&edp_in>;
+			};
 		};
 	};
 };
@@ -310,9 +327,51 @@ dp_intf0_out: endpoint {
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
+		};
+	};
+};
+
+&dsc0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dsc0_in: endpoint {
+				remote-endpoint = <&dither0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dsc0_out: endpoint {
+				remote-endpoint = <&merge0_in>;
+			};
 		};
 	};
 };
@@ -357,6 +416,35 @@ panel_in: endpoint {
 	};
 };
 
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
 &disp_pwm0 {
 	status = "okay";
 
@@ -376,8 +464,12 @@ ports {
 		#size-cells = <0>;
 
 		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			reg = <0>;
-			dptx_in: endpoint {
+
+			dptx_in: endpoint@1 {
+				reg = <1>;
 				remote-endpoint = <&dp_intf1_out>;
 			};
 		};
@@ -511,6 +603,56 @@ pmic@34 {
 	};
 };
 
+&merge0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			merge0_in: endpoint {
+				remote-endpoint = <&dsc0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			merge0_out: endpoint {
+				remote-endpoint = <&dp_intf0_in>;
+			};
+		};
+	};
+};
+
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
 	domain-supply = <&mt6315_7_vbuck1>;
 };
@@ -612,6 +754,10 @@ flash@0 {
 	};
 };
 
+&ovl0_in {
+	remote-endpoint = <&vdosys0_ep_main>;
+};
+
 &pcie1 {
 	status = "okay";
 
@@ -1363,6 +1509,18 @@ &uart0 {
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
 /*
  * For the USB Type-C ports the role and alternate modes switching is
  * done by the EC so we set dr_mode to host to avoid interfering.
@@ -1385,6 +1543,18 @@ &ssusb3 {
 	status = "okay";
 };
 
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
 &xhci0 {
 	status = "okay";
 
-- 
2.48.1


