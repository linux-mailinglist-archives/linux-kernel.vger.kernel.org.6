Return-Path: <linux-kernel+bounces-222422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47310910148
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2743A1C21919
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3631AAE2E;
	Thu, 20 Jun 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NY2U30ZA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B504500E;
	Thu, 20 Jun 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878628; cv=none; b=s7fdxe2bcOt74Ta/Jltd6LUxvpp4KqZwtCY/qPSt7bGuqIEWRXBmhMPprhaWcCSnBwkmWCCpQDl/cSGGowYNqTm4aJakKRZL6TUTVTi26yy72W6HB4ESCHD2WgrlHQIfekaXDsc3w9MfJVo5zLIGxcmrjeHWJGz2bFfMIjI7t9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878628; c=relaxed/simple;
	bh=xzrS59hbUBkr2k9yR5uBvEzaG4iOlLQ3QDX01MkRSVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhW5lsPLve7BeNMzSYNdC6d+KBOlyAvdg5knY7XNshhhTBVRLAUPVpunUb2gAIhtcrnu0v5obbhzHnn1+6wk6d/rWw2SlMOuSnMV74rwKCgwsfViMmUKE6ImYu83bpLGcH/U4jkJkgrfCrfPlagzN9QZmrq3R+XE1XdlG3Bwft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NY2U30ZA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878624;
	bh=xzrS59hbUBkr2k9yR5uBvEzaG4iOlLQ3QDX01MkRSVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NY2U30ZAchD2HC2B/EgzcKIaCg5++2AFXwZ7POUz5N0EhDt5fOs6lupcNg/1AUUab
	 qMf9micf6H+eumGtniDsHPdv0UWB9Ddle9mcVvCHT0D7kVNjLptJQsHQ/QCSnkGwwC
	 XqYfwo6sGOuxo0/FlaZR9+x4GlhGXWotamT0bXhjMl1xkXvoEph9Nn1p9sgq5lVqfh
	 QgO44RIhhtFdVy+R36Pj2604Ioki9oIDdX+ucyESsFQiazjrYZvACJogqYHBfUWioA
	 JBA3Elyd1gKTYhhPwNJdCXu8uGDZuVss98p2DcWoI3GTnKA0ZgLI2EOSWaZOAShCRM
	 a199tjgu7fzXA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DA7793782159;
	Thu, 20 Jun 2024 10:17:03 +0000 (UTC)
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
	kernel@collabora.com
Subject: [PATCH 1/2] arm64: dts: mediatek: Declare drive-strength numerically
Date: Thu, 20 Jun 2024 12:16:55 +0200
Message-ID: <20240620101656.1096374-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620101656.1096374-1-angelogioacchino.delregno@collabora.com>
References: <20240620101656.1096374-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some devicetrees, the drive-strength property gets assigned a
MTK_DRIVE_(x)_mA definition, which matches with (x).

For example, MTK_DRIVE_8mA equals to 8 and MTK_DRIVE_30mA equals
to 30.

Also keeping in mind that the drive-strength property is, by
(binding) definition, taking a number in milliamperes unit,
change all devicetrees to avoid the usage of any MTK_DRIVE_(x)
definition.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts   |  4 +-
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    |  8 ++--
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts   | 12 +++---
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      |  2 +-
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      |  2 +-
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  6 +--
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  8 ++--
 .../boot/dts/mediatek/mt8183-pumpkin.dts      |  4 +-
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts  | 26 ++++++------
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts   |  4 +-
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 40 +++++++++----------
 .../dts/mediatek/mt8395-genio-1200-evk.dts    | 28 ++++++-------
 12 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 234e3b23d7a8..c84c47c1352f 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -137,7 +137,7 @@ tx_pins {
 				 <MT2712_PIN_74_GBE_TXD0__FUNC_GBE_TXD0>,
 				 <MT2712_PIN_75_GBE_TXC__FUNC_GBE_TXC>,
 				 <MT2712_PIN_76_GBE_TXEN__FUNC_GBE_TXEN>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 		};
 		rx_pins {
 			pinmux = <MT2712_PIN_78_GBE_RXD3__FUNC_GBE_RXD3>,
@@ -151,7 +151,7 @@ rx_pins {
 		mdio_pins {
 			pinmux = <MT2712_PIN_85_GBE_MDC__FUNC_GBE_MDC>,
 				 <MT2712_PIN_86_GBE_MDIO__FUNC_GBE_MDIO>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			input-enable;
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index 7364c7278276..91de920c2245 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -288,25 +288,25 @@ pins-cmd-dat {
 				 <PINMUX_GPIO161__FUNC_MSDC0_DAT7>,
 				 <PINMUX_GPIO162__FUNC_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins-clk {
 			pinmux = <PINMUX_GPIO163__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins-rst {
 			pinmux = <PINMUX_GPIO165__FUNC_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins-ds {
 			pinmux = <PINMUX_GPIO164__FUNC_MSDC0_DSL>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 3fab21f59d18..bb4671c18e3b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -213,14 +213,14 @@ pins_cmd_dat {
 				 <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
 				 <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins_clk {
 			pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
 			bias-pull-down;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 		};
 
 		pins_insert {
@@ -241,13 +241,13 @@ pins_cmd_dat {
 				 <MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
 				 <MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_2mA>;
+			drive-strength = <2>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins_clk {
 			pinmux = <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_2mA>;
+			drive-strength = <2>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
 		};
 
@@ -265,13 +265,13 @@ pins_cmd_dat {
 				 <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
 				 <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins_clk {
 			pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
index 4eb2a0d571af..ddb993521bbf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
@@ -19,6 +19,6 @@ &qca_wifi {
 
 &mmc1_pins_uhs {
 	pins-clk {
-		drive-strength = <MTK_DRIVE_6mA>;
+		drive-strength = <6>;
 	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
index 6a733361e8ae..10c4f920a7d8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
@@ -19,6 +19,6 @@ &qca_wifi {
 
 &mmc1_pins_uhs {
 	pins-clk {
-		drive-strength = <MTK_DRIVE_6mA>;
+		drive-strength = <6>;
 	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
index 6a7ae616512d..46fc3a00cc5a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
@@ -68,16 +68,16 @@ pins-wifi-enable {
 
 &mmc1_pins_default {
 	pins-cmd-dat {
-		drive-strength = <MTK_DRIVE_6mA>;
+		drive-strength = <6>;
 	};
 	pins-clk {
-		drive-strength = <MTK_DRIVE_6mA>;
+		drive-strength = <6>;
 	};
 };
 
 &mmc1_pins_uhs {
 	pins-clk {
-		drive-strength = <MTK_DRIVE_6mA>;
+		drive-strength = <6>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 5472cd0be63a..cbca8cc08068 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -488,7 +488,7 @@ pins-bus {
 				<PINMUX_GPIO172__FUNC_TDM_DATA1_2ND>,
 				<PINMUX_GPIO173__FUNC_TDM_DATA2_2ND>,
 				<PINMUX_GPIO10__FUNC_TDM_DATA3>; /*8ch-i2s to it6505*/
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 		};
 	};
 
@@ -502,7 +502,7 @@ pins-bus {
 				<PINMUX_GPIO10__FUNC_GPIO10>;
 			input-enable;
 			bias-pull-down;
-			drive-strength = <MTK_DRIVE_2mA>;
+			drive-strength = <2>;
 		};
 	};
 
@@ -673,14 +673,14 @@ pins-cmd-dat {
 				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
 				 <PINMUX_GPIO33__FUNC_MSDC1_DAT2>,
 				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			input-enable;
 			mediatek,pull-up-adv = <10>;
 		};
 
 		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			mediatek,pull-down-adv = <10>;
 			input-enable;
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 81f6c205fa98..1aa668c3ccf9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -350,14 +350,14 @@ pins_cmd_dat {
 				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
 				 <PINMUX_GPIO33__FUNC_MSDC1_DAT2>,
 				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			input-enable;
 			mediatek,pull-up-adv = <10>;
 		};
 
 		pins_clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			mediatek,pull-down-adv = <10>;
 			input-enable;
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index b82f7176b4a1..31d424b8fc7c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -305,14 +305,14 @@ pins-txd {
 				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
 				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
 				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 		};
 		pins-cc {
 			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
 				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
 				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
 				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 		};
 		pins-rxd {
 			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
@@ -377,7 +377,7 @@ pins {
 	mmc0_default_pins: mmc0-default-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -392,13 +392,13 @@ pins-cmd-dat {
 				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
 				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins-rst {
 			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -406,7 +406,7 @@ pins-rst {
 	mmc0_uhs_pins: mmc0-uhs-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -421,19 +421,19 @@ pins-cmd-dat {
 				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
 				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins-ds {
 			pinmux = <PINMUX_GPIO127__FUNC_MSDC0_DSL>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins-rst {
 			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -441,7 +441,7 @@ pins-rst {
 	mmc1_default_pins: mmc1-default-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -452,7 +452,7 @@ pins-cmd-dat {
 				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
 				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
@@ -465,7 +465,7 @@ pins-insert {
 	mmc1_uhs_pins: mmc1-uhs-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -476,7 +476,7 @@ pins-cmd-dat {
 				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
 				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 50cbaefa1a99..4211a992dd9d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -308,7 +308,7 @@ cmd-dat-pins {
 	mmc1_uhs_pins: mmc1-uhs-pins {
 		clk-pins {
 			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -319,7 +319,7 @@ cmd-dat-pins {
 				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
 				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 6bb1d5d112ef..1474bef7e754 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -383,13 +383,13 @@ pins-cc {
 				 <PINMUX_GPIO140__FUNC_I0_GBE_RXC>,
 				 <PINMUX_GPIO141__FUNC_I0_GBE_RXDV>,
 				 <PINMUX_GPIO142__FUNC_O_GBE_TXEN>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 		};
 
 		pins-mdio {
 			pinmux = <PINMUX_GPIO143__FUNC_O_GBE_MDC>,
 				 <PINMUX_GPIO144__FUNC_B1_GBE_MDIO>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			input-enable;
 		};
 
@@ -404,7 +404,7 @@ pins-rxd {
 				 <PINMUX_GPIO136__FUNC_I0_GBE_RXD2>,
 				 <PINMUX_GPIO137__FUNC_I0_GBE_RXD1>,
 				 <PINMUX_GPIO138__FUNC_I0_GBE_RXD0>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 		};
 
 		pins-txd {
@@ -412,7 +412,7 @@ pins-txd {
 				 <PINMUX_GPIO132__FUNC_O_GBE_TXD2>,
 				 <PINMUX_GPIO133__FUNC_O_GBE_TXD1>,
 				 <PINMUX_GPIO134__FUNC_O_GBE_TXD0>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 		};
 	};
 
@@ -520,7 +520,7 @@ pins {
 	mmc0_default_pins: mmc0-default-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -535,13 +535,13 @@ pins-cmd-dat {
 				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
 				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins-rst {
 			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -549,7 +549,7 @@ pins-rst {
 	mmc0_uhs_pins: mmc0-uhs-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -564,19 +564,19 @@ pins-cmd-dat {
 				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
 				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins-ds {
 			pinmux = <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins-rst {
 			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -584,7 +584,7 @@ pins-rst {
 	mmc1_default_pins: mmc1-default-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO164__FUNC_B1_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -595,7 +595,7 @@ pins-cmd-dat {
 				 <PINMUX_GPIO167__FUNC_B1_MSDC1_DAT2>,
 				 <PINMUX_GPIO168__FUNC_B1_MSDC1_DAT3>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
@@ -608,7 +608,7 @@ pins-insert {
 	mmc1_uhs_pins: mmc1-uhs-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO164__FUNC_B1_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -619,7 +619,7 @@ pins-cmd-dat {
 				 <PINMUX_GPIO167__FUNC_B1_MSDC1_DAT2>,
 				 <PINMUX_GPIO168__FUNC_B1_MSDC1_DAT3>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -627,7 +627,7 @@ pins-cmd-dat {
 	mmc2_default_pins: mmc2-default-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO170__FUNC_B1_MSDC2_CLK>;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -638,7 +638,7 @@ pins-cmd-dat {
 				 <PINMUX_GPIO173__FUNC_B1_MSDC2_DAT2>,
 				 <PINMUX_GPIO174__FUNC_B1_MSDC2_DAT3>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
@@ -650,7 +650,7 @@ pins-pcm {
 	mmc2_uhs_pins: mmc2-uhs-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO170__FUNC_B1_MSDC2_CLK>;
-			drive-strength = <MTK_DRIVE_4mA>;
+			drive-strength = <4>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -661,7 +661,7 @@ pins-cmd-dat {
 				 <PINMUX_GPIO173__FUNC_B1_MSDC2_DAT2>,
 				 <PINMUX_GPIO174__FUNC_B1_MSDC2_DAT3>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -678,7 +678,7 @@ mmc2_dat1_pins: mmc2-dat1-pins {
 		pins-dat1 {
 			pinmux = <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index a1b613808780..a06610fff8ad 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -475,7 +475,7 @@ pins-cc {
 				 <PINMUX_GPIO86__FUNC_GBE_RXC>,
 				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
 				 <PINMUX_GPIO88__FUNC_GBE_TXEN>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 		};
 
 		pins-mdio {
@@ -502,7 +502,7 @@ pins-txd {
 				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
 				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
 				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 		};
 	};
 
@@ -567,7 +567,7 @@ pins {
 			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
 				 <PINMUX_GPIO13__FUNC_SCL2>;
 			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 		};
 	};
 
@@ -582,7 +582,7 @@ pins {
 	mmc0_default_pins: mmc0-default-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -597,13 +597,13 @@ pins-cmd-dat {
 				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
 				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins-rst {
 			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <6>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -611,7 +611,7 @@ pins-rst {
 	mmc0_uhs_pins: mmc0-uhs-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -626,19 +626,19 @@ pins-cmd-dat {
 				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
 				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins-ds {
 			pinmux = <PINMUX_GPIO127__FUNC_MSDC0_DSL>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
 		pins-rst {
 			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -646,7 +646,7 @@ pins-rst {
 	mmc1_default_pins: mmc1-default-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -657,7 +657,7 @@ pins-cmd-dat {
 				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
 				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
@@ -665,7 +665,7 @@ pins-cmd-dat {
 	mmc1_uhs_pins: mmc1-uhs-pins {
 		pins-clk {
 			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 
@@ -676,7 +676,7 @@ pins-cmd-dat {
 				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
 				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
+			drive-strength = <8>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
-- 
2.45.2


