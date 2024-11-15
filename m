Return-Path: <linux-kernel+bounces-411248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 187959CF52F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F0DB33E60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75181E6DCF;
	Fri, 15 Nov 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKkE6O4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9041E285D;
	Fri, 15 Nov 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699550; cv=none; b=nUJXTLtRqErOfADqC4a1Z95o7Ty+q17RKB8zi9bt91CHwJgKHlZbO7z2+HSlrgecO2nXpH/38PKDn0aUohSi58y0ujLpoWyMB5GOV9xlYeVvGLP7agN309Bca7ek93hhYd3OSeRV7XPgBSdZEwyw7pkpJ1Kt1rzlfc+ZkA/V4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699550; c=relaxed/simple;
	bh=ZgK5lNGMN4OonmhY1/VBlb02ULM6gIQ2UorUmZYTdgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rak2M0WVdoP0Rcm5/AKfrFaVrTUNAhi7SyAC2qlT5cloSm5J6cFXIt/J4vnXyUDtwbbtJEO8xJOXW9kYkitExK4TrdzklPqTu+SRxIkMH5lo3kzT9hJf69Of4+AakXkPCwryl+tEOen9+L2MzdQSoOgfPd6h+hDIjtbfNMKqY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKkE6O4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96DFC4CECF;
	Fri, 15 Nov 2024 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699550;
	bh=ZgK5lNGMN4OonmhY1/VBlb02ULM6gIQ2UorUmZYTdgo=;
	h=From:To:Cc:Subject:Date:From;
	b=PKkE6O4Jk4FaZZrNimzqApd4wdNSxTnM/vNaJAA4gSm9XFAIVR5fJBpxGQcmSyRK2
	 DZcIQuIWLmuMjFWhlWEfj0lNV9gnqQY1OH+IFZSzKo59Zpei5WC4dDugtZkN4iftiK
	 p5m2sOg8Tx5BC8yw/5cgD2D0ocVRjA4EtYrewSXYz5YOXPxmQ/G/xUWHErH3gR/j2w
	 3SnFB7YaS25R4lk1NXYWi38eNN5Y/Ty6zHK+PIwURZv1F8uxDh6zXC/LFo+Vmjnivn
	 dKxYR5p/SX8venYlitFcAsXd8r7fnX7b8pyYyTlmWC27alGlycvkTvQyBkGXfTNtn2
	 J1rgV0ADJe0Zw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: dts: broadcom: Remove unused and undocumented properties
Date: Fri, 15 Nov 2024 13:39:01 -0600
Message-ID: <20241115193904.3624350-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove properties which are both unused in the kernel and undocumented.
Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dts | 1 -
 arch/arm/boot/dts/broadcom/bcm953012hr.dts                 | 1 -
 arch/arm/boot/dts/broadcom/bcm953012k.dts                  | 1 -
 arch/arm/boot/dts/broadcom/bcm958522er.dts                 | 1 -
 arch/arm/boot/dts/broadcom/bcm958525er.dts                 | 1 -
 arch/arm/boot/dts/broadcom/bcm958525xmc.dts                | 1 -
 arch/arm/boot/dts/broadcom/bcm958622hr.dts                 | 1 -
 arch/arm/boot/dts/broadcom/bcm958623hr.dts                 | 1 -
 arch/arm/boot/dts/broadcom/bcm958625hr.dts                 | 1 -
 arch/arm/boot/dts/broadcom/bcm958625k.dts                  | 1 -
 arch/arm/boot/dts/broadcom/bcm988312hr.dts                 | 1 -
 11 files changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dts b/arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dts
index 975f854f652f..08cf1220b655 100644
--- a/arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dts
+++ b/arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dts
@@ -32,7 +32,6 @@ &uart1 {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 
 	flash: flash@0 {
 		compatible = "m25p80";
diff --git a/arch/arm/boot/dts/broadcom/bcm953012hr.dts b/arch/arm/boot/dts/broadcom/bcm953012hr.dts
index b070b69466bd..b728cd54715e 100644
--- a/arch/arm/boot/dts/broadcom/bcm953012hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm953012hr.dts
@@ -74,7 +74,6 @@ partition@1000000 {
 &spi_nor {
 	status = "okay";
 	spi-max-frequency = <62500000>;
-	m25p,default-addr-width = <3>;
 
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm953012k.dts b/arch/arm/boot/dts/broadcom/bcm953012k.dts
index f1e6bcaa1edd..27c0992f1855 100644
--- a/arch/arm/boot/dts/broadcom/bcm953012k.dts
+++ b/arch/arm/boot/dts/broadcom/bcm953012k.dts
@@ -84,7 +84,6 @@ partition@1000000 {
 &spi_nor {
 	status = "okay";
 	spi-max-frequency = <62500000>;
-	m25p,default-addr-width = <3>;
 
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm958522er.dts b/arch/arm/boot/dts/broadcom/bcm958522er.dts
index 15f023656df0..2f20f86bd31c 100644
--- a/arch/arm/boot/dts/broadcom/bcm958522er.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958522er.dts
@@ -135,7 +135,6 @@ nand_sel: nand_sel {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm958525er.dts b/arch/arm/boot/dts/broadcom/bcm958525er.dts
index 9b9c225a1fb3..980c03f74a19 100644
--- a/arch/arm/boot/dts/broadcom/bcm958525er.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958525er.dts
@@ -135,7 +135,6 @@ nand_sel: nand_sel {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm958525xmc.dts b/arch/arm/boot/dts/broadcom/bcm958525xmc.dts
index ca9311452739..440bb2d617f2 100644
--- a/arch/arm/boot/dts/broadcom/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958525xmc.dts
@@ -151,7 +151,6 @@ nand_sel: nand_sel {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm958622hr.dts b/arch/arm/boot/dts/broadcom/bcm958622hr.dts
index 9db3c851451a..116f3a7c3bc6 100644
--- a/arch/arm/boot/dts/broadcom/bcm958622hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958622hr.dts
@@ -139,7 +139,6 @@ nand_sel: nand_sel {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm958623hr.dts b/arch/arm/boot/dts/broadcom/bcm958623hr.dts
index 32786e7c4e12..fc6ab73ecf56 100644
--- a/arch/arm/boot/dts/broadcom/bcm958623hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958623hr.dts
@@ -143,7 +143,6 @@ &sata_phy0 {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm958625hr.dts b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
index 74263d98de73..a9b6aa04d573 100644
--- a/arch/arm/boot/dts/broadcom/bcm958625hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
@@ -150,7 +150,6 @@ nand_sel: nand_sel {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm958625k.dts b/arch/arm/boot/dts/broadcom/bcm958625k.dts
index 69ebc7a913a7..7996116fc923 100644
--- a/arch/arm/boot/dts/broadcom/bcm958625k.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958625k.dts
@@ -154,7 +154,6 @@ &pwm {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/broadcom/bcm988312hr.dts b/arch/arm/boot/dts/broadcom/bcm988312hr.dts
index e96bc3f2d5cf..663a3f27b6e4 100644
--- a/arch/arm/boot/dts/broadcom/bcm988312hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm988312hr.dts
@@ -139,7 +139,6 @@ nand_sel: nand_sel {
 
 &qspi {
 	status = "okay";
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.45.2


