Return-Path: <linux-kernel+bounces-364699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CAF99D81F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED41B2146A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F51D0946;
	Mon, 14 Oct 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UU5N9ShJ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B3149C47;
	Mon, 14 Oct 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937335; cv=none; b=jEdymRRUoIU9V12R5wSGIkXZS2pe81TAkBcyOnE5yeyssPRx9mFk+Bv09ejFk0+ir1Tua7nLW2++X6us3/DU0urM94Vtsb3262HXKDGbbfLi/vVSncpXiSoJgygbC4HutqO/94ozsHH00428Xu95oU4Oa83oDoSVDeEUM5FTeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937335; c=relaxed/simple;
	bh=lXZPVTFw4gS5XzAB5361QkBAbIlC7+nsYkzvztH3aYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EYqv7Iw9tzGbIdHn9sbvVdetw41BGgJp+pDTXyZfynflBx8q3Ke/wrf/6ptVimCj4PXePGo1UvMILEtj3ZYa5ktDnLqIQqfsHuDvQgxIcf1fNZpZfGItl6D8zJCuyWuBOCxvOTWbmU9DfdOWsHgcS1u2K/CfN+uA5yQRxkVQo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UU5N9ShJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728937323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fy6ip9Ec6sFQhLqMTPBcsRStEIPSb0Tf4hVebsrEnsM=;
	b=UU5N9ShJwbxTnwISU7ZdBgWCer8i20R+YJyW6dAlAqy5uPWjrG9oHzTOP35lk0nJM1+PFt
	TcKUAKz6a3GkPjUdlMma81tRZrVRNzBfZtxQ91c4Lo0Vqdxr4CGDD/7ASH4ATH0ro2xzLJ
	i1nTkOKh4wopwDPn+ScxUvlyXbGgNWI4oBKc2y/Nlk+K9c0jHGh5dLBvSPAGdNDjUlDSzy
	XxXG4Xuqb4d4M0DIxJDk6Nw6hQ3GAhd3zHq5PsnarrUzjzXD89kjm5WJ9MLIT3ZRKkGydh
	qzadr8z9AI1ynnWsokuGNLvruSYP/t0+If3KtB9LSoxJDqgyPJxszVg48x0TZQ==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH] arm64: dts: rockchip: Convert dts files used as parents to dtsi files
Date: Mon, 14 Oct 2024 22:21:57 +0200
Message-Id: <f3d789c14fe34a53327cac03cd3837e530e21f5c.1728937091.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Including a board dts file is not the right way to represent the hierarchical
nature of the board dts files and to create a dts file for another variant of
an ancestor board.  However, a few boards and their variants (ab)used this
approach, so let's clean that up by converting the common ancestors into dtsi
files, and by adding separate board-variant dts files.

No functional changes are introduced, which was validated by decompiling and
comparing all affected board dtb files before and after these changes.  In
more detail, the affected dtb files have some of their blocks shuffled around
a bit and some of their phandles have different values, as a result of the
changes to the order in which the building blocks from the parent dtsi files
are included, but they effectively remain the same as the originals.

The only perceivable introduced change is the turning of "roc-rk3328-cc" into
"ROC-RK3328-CC", which is the model name of one of the affected boards, which
was performed to match the styling of the official board name.

As a side note, due to the nature of introduced changes, this commit is best
viewed using "-B80%/80% -M20% -C5%" as the set of options for git-log(1).

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 ...8-nanopi-r2s.dts => rk3328-nanopi-r2.dtsi} | 16 -------
 .../dts/rockchip/rk3328-nanopi-r2c-plus.dts   |  3 +-
 .../boot/dts/rockchip/rk3328-nanopi-r2c.dts   | 28 +----------
 ...-nanopi-r2c.dts => rk3328-nanopi-r2c.dtsi} |  9 +---
 .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 20 +++++++-
 ...s-nanopi-r6c.dts => rk3328-nanopi-r2s.dts} | 13 +++--
 ...pi-r2s-plus.dts => rk3328-nanopi-r2s.dtsi} | 35 +++++++-------
 .../rockchip/rk3328-orangepi-r1-plus-lts.dts  |  6 +--
 ...pi-r2c.dts => rk3328-orangepi-r1-plus.dts} | 34 +++++---------
 ...-plus.dts => rk3328-orangepi-r1-plus.dtsi} | 16 -------
 ...3588s-nanopi-r6c.dts => rk3328-roc-cc.dts} | 23 +++++++--
 .../arm64/boot/dts/rockchip/rk3328-roc-pc.dts |  3 +-
 .../{rk3328-roc-cc.dts => rk3328-roc.dtsi}    | 11 +----
 .../boot/dts/rockchip/rk3399-nanopi-m4.dts    | 47 +------------------
 ...99-nanopi-m4.dts => rk3399-nanopi-m4.dtsi} |  8 +---
 .../boot/dts/rockchip/rk3399-nanopi-m4b.dts   |  3 +-
 .../rockchip/rk3399-nanopi-r4s-enterprise.dts |  3 +-
 ...s-nanopi-r6c.dts => rk3399-nanopi-r4s.dts} | 13 +++--
 ...-nanopi-r4s.dts => rk3399-nanopi-r4s.dtsi} |  6 +--
 ...-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} |  4 --
 .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  |  2 +-
 ...-nanopi-r6c.dts => rk3588s-nanopi-r6s.dts} |  8 ++--
 22 files changed, 104 insertions(+), 207 deletions(-)
 rename arch/arm64/boot/dts/rockchip/{rk3328-nanopi-r2s.dts => rk3328-nanopi-r2.dtsi} (95%)
 copy arch/arm64/boot/dts/rockchip/{rk3328-nanopi-r2c.dts => rk3328-nanopi-r2c.dtsi} (80%)
 copy arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6c.dts => rk3328-nanopi-r2s.dts} (25%)
 copy arch/arm64/boot/dts/rockchip/{rk3328-nanopi-r2s-plus.dts => rk3328-nanopi-r2s.dtsi} (39%)
 copy arch/arm64/boot/dts/rockchip/{rk3328-nanopi-r2c.dts => rk3328-orangepi-r1-plus.dts} (27%)
 rename arch/arm64/boot/dts/rockchip/{rk3328-orangepi-r1-plus.dts => rk3328-orangepi-r1-plus.dtsi} (94%)
 copy arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6c.dts => rk3328-roc-cc.dts} (14%)
 rename arch/arm64/boot/dts/rockchip/{rk3328-roc-cc.dts => rk3328-roc.dtsi} (96%)
 copy arch/arm64/boot/dts/rockchip/{rk3399-nanopi-m4.dts => rk3399-nanopi-m4.dtsi} (88%)
 copy arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6c.dts => rk3399-nanopi-r4s.dts} (25%)
 rename arch/arm64/boot/dts/rockchip/{rk3399-nanopi-r4s.dts => rk3399-nanopi-r4s.dtsi} (93%)
 rename arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} (99%)
 copy arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6c.dts => rk3588s-nanopi-r6s.dts} (35%)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
similarity index 95%
rename from arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
rename to arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
index a4399da7d8b1..f9fab35aed23 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
@@ -10,9 +10,6 @@
 #include "rk3328.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R2S";
-	compatible = "friendlyarm,nanopi-r2s", "rockchip,rk3328";
-
 	aliases {
 		ethernet0 = &gmac2io;
 		ethernet1 = &rtl8153;
@@ -141,29 +138,16 @@ &gmac2io {
 	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
 	assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
 	clock_in_out = "input";
-	phy-handle = <&rtl8211e>;
 	phy-mode = "rgmii";
 	phy-supply = <&vcc_io_33>;
 	pinctrl-0 = <&rgmiim1_pins>;
 	pinctrl-names = "default";
-	rx_delay = <0x18>;
 	snps,aal;
-	tx_delay = <0x24>;
-	status = "okay";
 
 	mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		rtl8211e: ethernet-phy@1 {
-			reg = <1>;
-			pinctrl-0 = <&eth_phy_reset_pin>;
-			pinctrl-names = "default";
-			reset-assert-us = <10000>;
-			reset-deassert-us = <50000>;
-			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
-		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts
index 16a1958e4572..3709ba30bbd4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts
@@ -7,7 +7,8 @@
  */
 
 /dts-v1/;
-#include "rk3328-nanopi-r2c.dts"
+
+#include "rk3328-nanopi-r2c.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi R2C Plus";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
index a07a26b944a0..e8ab773dc245 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
@@ -7,34 +7,10 @@
  */
 
 /dts-v1/;
-#include "rk3328-nanopi-r2s.dts"
+
+#include "rk3328-nanopi-r2c.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi R2C";
 	compatible = "friendlyarm,nanopi-r2c", "rockchip,rk3328";
 };
-
-&gmac2io {
-	phy-handle = <&yt8521s>;
-	tx_delay = <0x22>;
-	rx_delay = <0x12>;
-
-	mdio {
-		/delete-node/ ethernet-phy@1;
-
-		yt8521s: ethernet-phy@3 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <3>;
-
-			motorcomm,clk-out-frequency-hz = <125000000>;
-			motorcomm,keep-pll-enabled;
-			motorcomm,auto-sleep-disabled;
-
-			pinctrl-0 = <&eth_phy_reset_pin>;
-			pinctrl-names = "default";
-			reset-assert-us = <10000>;
-			reset-deassert-us = <50000>;
-			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtsi
similarity index 80%
copy from arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
copy to arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtsi
index a07a26b944a0..3b0457de2a98 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtsi
@@ -7,21 +7,16 @@
  */
 
 /dts-v1/;
-#include "rk3328-nanopi-r2s.dts"
 
-/ {
-	model = "FriendlyElec NanoPi R2C";
-	compatible = "friendlyarm,nanopi-r2c", "rockchip,rk3328";
-};
+#include "rk3328-nanopi-r2.dtsi"
 
 &gmac2io {
 	phy-handle = <&yt8521s>;
 	tx_delay = <0x22>;
 	rx_delay = <0x12>;
+	status = "okay";
 
 	mdio {
-		/delete-node/ ethernet-phy@1;
-
 		yt8521s: ethernet-phy@3 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <3>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
index cb81ba3f23ff..8ae9b7550816 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
@@ -7,7 +7,8 @@
  */
 
 /dts-v1/;
-#include "rk3328-nanopi-r2s.dts"
+
+#include "rk3328-nanopi-r2s.dtsi"
 
 / {
 	compatible = "friendlyarm,nanopi-r2s-plus", "rockchip,rk3328";
@@ -30,3 +31,20 @@ &emmc {
 	supports-emmc;
 	status = "okay";
 };
+
+&gmac2io {
+	phy-handle = <&rtl8211e>;
+	tx_delay = <0x24>;
+	rx_delay = <0x18>;
+
+	mdio {
+		rtl8211e: ethernet-phy@1 {
+			reg = <1>;
+			pinctrl-0 = <&eth_phy_reset_pin>;
+			pinctrl-names = "default";
+			reset-assert-us = <10000>;
+			reset-deassert-us = <50000>;
+			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
similarity index 25%
copy from arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
copy to arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
index 497bbb57071f..8579f22a1942 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
@@ -1,14 +1,13 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 David Bauer <mail@david-bauer.net>
+ */
 
 /dts-v1/;
 
-#include "rk3588s-nanopi-r6s.dts"
+#include "rk3328-nanopi-r2s.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R6C";
-	compatible = "friendlyarm,nanopi-r6c", "rockchip,rk3588s";
-};
-
-&lan2_led {
-	label = "user_led";
+	model = "FriendlyElec NanoPi R2S";
+	compatible = "friendlyarm,nanopi-r2s", "rockchip,rk3328";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtsi
similarity index 39%
copy from arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
copy to arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtsi
index cb81ba3f23ff..308e526c2861 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtsi
@@ -7,26 +7,23 @@
  */
 
 /dts-v1/;
-#include "rk3328-nanopi-r2s.dts"
 
-/ {
-	compatible = "friendlyarm,nanopi-r2s-plus", "rockchip,rk3328";
-	model = "FriendlyElec NanoPi R2S Plus";
+#include "rk3328-nanopi-r2.dtsi"
 
-	aliases {
-		mmc1 = &emmc;
-	};
-};
-
-&emmc {
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	disable-wp;
-	mmc-hs200-1_8v;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
-	supports-emmc;
+&gmac2io {
+	phy-handle = <&rtl8211e>;
+	tx_delay = <0x24>;
+	rx_delay = <0x18>;
 	status = "okay";
+
+	mdio {
+		rtl8211e: ethernet-phy@1 {
+			reg = <1>;
+			pinctrl-0 = <&eth_phy_reset_pin>;
+			pinctrl-names = "default";
+			reset-assert-us = <10000>;
+			reset-deassert-us = <50000>;
+			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
index 4237f2ee8fee..67c246ad8b8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -7,21 +7,21 @@
  */
 
 /dts-v1/;
-#include "rk3328-orangepi-r1-plus.dts"
+
+#include "rk3328-orangepi-r1-plus.dtsi"
 
 / {
 	model = "Xunlong Orange Pi R1 Plus LTS";
 	compatible = "xunlong,orangepi-r1-plus-lts", "rockchip,rk3328";
 };
 
 &gmac2io {
 	phy-handle = <&yt8531c>;
 	tx_delay = <0x19>;
 	rx_delay = <0x05>;
+	status = "okay";
 
 	mdio {
-		/delete-node/ ethernet-phy@1;
-
 		yt8531c: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
similarity index 27%
copy from arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
copy to arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
index a07a26b944a0..324a8e951f7e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
@@ -1,35 +1,27 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright (c) 2021 FriendlyElec Computer Tech. Co., Ltd.
- * (http://www.friendlyarm.com)
- *
- * Copyright (c) 2021-2023 Tianling Shen <cnsztl@gmail.com>
+ * Based on rk3328-nanopi-r2s.dts, which is:
+ *   Copyright (c) 2020 David Bauer <mail@david-bauer.net>
  */
 
 /dts-v1/;
-#include "rk3328-nanopi-r2s.dts"
+
+#include "rk3328-orangepi-r1-plus.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R2C";
-	compatible = "friendlyarm,nanopi-r2c", "rockchip,rk3328";
+	model = "Xunlong Orange Pi R1 Plus";
+	compatible = "xunlong,orangepi-r1-plus", "rockchip,rk3328";
 };
 
 &gmac2io {
-	phy-handle = <&yt8521s>;
-	tx_delay = <0x22>;
-	rx_delay = <0x12>;
+	phy-handle = <&rtl8211e>;
+	tx_delay = <0x24>;
+	rx_delay = <0x18>;
+	status = "okay";
 
 	mdio {
-		/delete-node/ ethernet-phy@1;
-
-		yt8521s: ethernet-phy@3 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <3>;
-
-			motorcomm,clk-out-frequency-hz = <125000000>;
-			motorcomm,keep-pll-enabled;
-			motorcomm,auto-sleep-disabled;
-
+		rtl8211e: ethernet-phy@1 {
+			reg = <1>;
 			pinctrl-0 = <&eth_phy_reset_pin>;
 			pinctrl-names = "default";
 			reset-assert-us = <10000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
similarity index 94%
rename from arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
rename to arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
index f20662929c77..181ec6de0019 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
@@ -11,9 +11,6 @@
 #include "rk3328.dtsi"
 
 / {
-	model = "Xunlong Orange Pi R1 Plus";
-	compatible = "xunlong,orangepi-r1-plus", "rockchip,rk3328";
-
 	aliases {
 		ethernet0 = &gmac2io;
 		ethernet1 = &rtl8153;
@@ -112,29 +109,16 @@ &gmac2io {
 	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
 	assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
 	clock_in_out = "input";
-	phy-handle = <&rtl8211e>;
 	phy-mode = "rgmii";
 	phy-supply = <&vcc_io>;
 	pinctrl-0 = <&rgmiim1_pins>;
 	pinctrl-names = "default";
 	snps,aal;
-	rx_delay = <0x18>;
-	tx_delay = <0x24>;
-	status = "okay";
 
 	mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		rtl8211e: ethernet-phy@1 {
-			reg = <1>;
-			pinctrl-0 = <&eth_phy_reset_pin>;
-			pinctrl-names = "default";
-			reset-assert-us = <10000>;
-			reset-deassert-us = <50000>;
-			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
-		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
similarity index 14%
copy from arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
copy to arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 497bbb57071f..1ea4b2a95a09 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -1,14 +1,27 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
+ */
 
 /dts-v1/;
 
-#include "rk3588s-nanopi-r6s.dts"
+#include <dt-bindings/input/input.h>
+#include "rk3328-roc.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R6C";
-	compatible = "friendlyarm,nanopi-r6c", "rockchip,rk3588s";
+	model = "Firefly ROC-RK3328-CC";
+	compatible = "firefly,roc-rk3328-cc", "rockchip,rk3328";
 };
 
-&lan2_led {
-	label = "user_led";
+&rk805 {
+	interrupt-parent = <&gpio1>;
+	interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&vcc_host1_5v {
+	gpio = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+};
+
+&vcc_sdio {
+	gpios = <&grf_gpio 0 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
index e3e3984d01d4..329d03172433 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
@@ -4,8 +4,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-
-#include "rk3328-roc-cc.dts"
+#include "rk3328-roc.dtsi"
 
 / {
 	model = "Firefly ROC-RK3328-PC";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
similarity index 96%
rename from arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
rename to arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
index 414897a57e75..6b274e91ee07 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
@@ -4,12 +4,10 @@
  */
 
 /dts-v1/;
+
 #include "rk3328.dtsi"
 
 / {
-	model = "Firefly roc-rk3328-cc";
-	compatible = "firefly,roc-rk3328-cc", "rockchip,rk3328";
-
 	aliases {
 		ethernet0 = &gmac2io;
 		mmc0 = &sdmmc;
@@ -50,21 +48,18 @@ vcc_sd: sdmmc-regulator {
 
 	vcc_sdio: sdmmcio-regulator {
 		compatible = "regulator-gpio";
-		gpios = <&grf_gpio 0 GPIO_ACTIVE_HIGH>;
-		states = <1800000 0x1>,
-			 <3300000 0x0>;
+		states = <1800000 0x1>, <3300000 0x0>;
 		regulator-name = "vcc_sdio";
 		regulator-type = "voltage";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 		vin-supply = <&vcc_sys>;
 	};
 
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";
@@ -183,8 +178,6 @@ &i2c1 {
 	rk805: pmic@18 {
 		compatible = "rockchip,rk805";
 		reg = <0x18>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk805-clkout2";
 		gpio-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
index 60358ab8c7df..e091b20c2d1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
@@ -10,57 +10,14 @@
  */
 
 /dts-v1/;
-#include "rk3399-nanopi4.dtsi"
+
+#include "rk3399-nanopi-m4.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi M4";
 	compatible = "friendlyarm,nanopi-m4", "rockchip,rk3399";
-
-	vdd_5v: vdd-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_5v";
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc5v0_core: vcc5v0-core {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_core";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vdd_5v>;
-	};
-
-	vcc5v0_usb1: vcc5v0-usb1 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb1";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc5v0_usb2: vcc5v0-usb2 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb2";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-};
-
-&vcc3v3_sys {
-	vin-supply = <&vcc5v0_core>;
 };
 
 &u2phy0_host {
 	phy-supply = <&vcc5v0_usb1>;
 };
-
-&u2phy1_host {
-	phy-supply = <&vcc5v0_usb2>;
-};
-
-&vbus_typec {
-	regulator-always-on;
-	vin-supply = <&vdd_5v>;
-};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtsi
similarity index 88%
copy from arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
copy to arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtsi
index 60358ab8c7df..5cd69ddf9891 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtsi
@@ -10,12 +10,10 @@
  */
 
 /dts-v1/;
+
 #include "rk3399-nanopi4.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi M4";
-	compatible = "friendlyarm,nanopi-m4", "rockchip,rk3399";
-
 	vdd_5v: vdd-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v";
@@ -52,10 +50,6 @@ &vcc3v3_sys {
 	vin-supply = <&vcc5v0_core>;
 };
 
-&u2phy0_host {
-	phy-supply = <&vcc5v0_usb1>;
-};
-
 &u2phy1_host {
 	phy-supply = <&vcc5v0_usb2>;
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts
index 65cb21837b0c..d03ce6fa5bf6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts
@@ -6,7 +6,8 @@
  */
 
 /dts-v1/;
-#include "rk3399-nanopi-m4.dts"
+
+#include "rk3399-nanopi-m4.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi M4B";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dts
index a23d11ca0eb6..b76f98962076 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dts
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 /dts-v1/;
-#include "rk3399-nanopi-r4s.dts"
+
+#include "rk3399-nanopi-r4s.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi R4S Enterprise Edition";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
similarity index 25%
copy from arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
copy to arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index 497bbb57071f..ec3883f6221e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -1,14 +1,13 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 FriendlyElec Computer Tech. Co., Ltd.
+ */
 
 /dts-v1/;
 
-#include "rk3588s-nanopi-r6s.dts"
+#include "rk3399-nanopi-r4s.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R6C";
-	compatible = "friendlyarm,nanopi-r6c", "rockchip,rk3588s";
-};
-
-&lan2_led {
-	label = "user_led";
+	model = "FriendlyElec NanoPi R4S";
+	compatible = "friendlyarm,nanopi-r4s", "rockchip,rk3399";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
similarity index 93%
rename from arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
rename to arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
index fe5b52610010..f5f8b9c7c166 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
@@ -1,24 +1,22 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * FriendlyElec NanoPC-T4 board device tree source
+ * FriendlyElec NanoPC-R4 board device tree source
  *
  * Copyright (c) 2020 FriendlyElec Computer Tech. Co., Ltd.
  * (http://www.friendlyarm.com)
  *
  * Copyright (c) 2018 Collabora Ltd.
  *
  * Copyright (c) 2020 Jensen Huang <jensenhuang@friendlyarm.com>
  * Copyright (c) 2020 Marty Jones <mj8263788@gmail.com>
  * Copyright (c) 2021 Tianling Shen <cnsztl@gmail.com>
  */
 
 /dts-v1/;
+
 #include "rk3399-nanopi4.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R4S";
-	compatible = "friendlyarm,nanopi-r4s", "rockchip,rk3399";
-
 	/delete-node/ display-subsystem;
 
 	gpio-leds {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
rename to arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index 4fa644ae510c..eef4851844bc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -8,9 +8,6 @@
 #include "rk3588s.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R6S";
-	compatible = "friendlyarm,nanopi-r6s", "rockchip,rk3588s";
-
 	aliases {
 		ethernet0 = &gmac1;
 		mmc0 = &sdmmc;
@@ -74,7 +71,6 @@ lan1_led: led-2 {
 		};
 
 		lan2_led: led-3 {
-			label = "lan2_led";
 			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&lan2_led_pin>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
index 497bbb57071f..ccc5e4627517 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
@@ -2,7 +2,7 @@
 
 /dts-v1/;
 
-#include "rk3588s-nanopi-r6s.dts"
+#include "rk3588s-nanopi-r6.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi R6C";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
similarity index 35%
copy from arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
copy to arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
index 497bbb57071f..9c3e0b0daaac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
@@ -2,13 +2,13 @@
 
 /dts-v1/;
 
-#include "rk3588s-nanopi-r6s.dts"
+#include "rk3588s-nanopi-r6.dtsi"
 
 / {
-	model = "FriendlyElec NanoPi R6C";
-	compatible = "friendlyarm,nanopi-r6c", "rockchip,rk3588s";
+	model = "FriendlyElec NanoPi R6S";
+	compatible = "friendlyarm,nanopi-r6s", "rockchip,rk3588s";
 };
 
 &lan2_led {
-	label = "user_led";
+	label = "lan2_led";
 };

