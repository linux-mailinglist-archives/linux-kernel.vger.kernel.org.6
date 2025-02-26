Return-Path: <linux-kernel+bounces-535020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB5FA46DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2D416CEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BAE26139A;
	Wed, 26 Feb 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWY08T6v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F3260A37;
	Wed, 26 Feb 2025 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606492; cv=none; b=nEz9cVMN8Ryn7+yA7E4BBlWJ+ymlBzU/zia1Y+ZNt/fjxRwHcT4FqHyl9W6Qrj1/l1Z3qtmMXklMDPQU5rzFwdyI6U0b29LQJQoI6OJOfkfWQWKHMad/TlzCjh8NM0iCZHzlMlppkRRD04ZbVTTm5REtYpa3OD6a7/TzbV45PBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606492; c=relaxed/simple;
	bh=J57eJSnjO9hXPRLMhrrFdrkaisb+OAmoFXPVZ3hF/jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iA6WiX/pNWs5mQl+Rzqufzv/yRckUZUQJVPzhzFB4mEqU/0HU2Po7o8pqznp0JxJzKydpe8XAGTl8yCRgwwB4/nvcFbdTXKzUhUjXXWNbKmDiTHn3u62P0M9Ed9u7S4M/Z1Clwfjm+nwxK9hK3/fjK8Ggglh7z3XxWYRPGJm9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWY08T6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F00C4CEE7;
	Wed, 26 Feb 2025 21:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606492;
	bh=J57eJSnjO9hXPRLMhrrFdrkaisb+OAmoFXPVZ3hF/jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWY08T6vgHpnlSjh0KJs2h8tm5GRSji3ze++I1jgIbPZtxMJZNeNcQlT0OQC8rvN/
	 f8Qg6RYbOoUHcelW/Ouexvoh+8UC+GBLAMZHyLAbqokvUxv2ODzND/hIgLuTkPIj+0
	 JkB1W1+Pp2fLtSfbpFAydneyD8icWy3ORUfqVG+4Qq0dWt/tjFArdTBdYIexF5p3kO
	 QFdzQS3kRadOu9dcusq28grytgPTC5tkkxbPL5xo1/8WW2xMYolJ1YEOrZsdn8QiES
	 +izQB/pEhFtlXgQpSb8MfiFzBP7Egwnr6EgC92diAh/aK8CMkIAu5nGa3SqBRhIW8E
	 ou5kM4D4cJilA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: marvell: Use preferred node names for "simple-bus"
Date: Wed, 26 Feb 2025 15:47:49 -0600
Message-ID: <20250226214751.3751865-3-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226214751.3751865-1-robh@kernel.org>
References: <20250226214751.3751865-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "simple-bus" binding has preferred node names such as "bus",
".*-bus", or "soc". Rename the Marvell platforms to use these names.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi     | 2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 2 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi     | 1 -
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi     | 1 -
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi     | 4 ++--
 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi | 4 ++--
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi     | 4 ++--
 7 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
index 75377c292bcb..605f5be1538c 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -78,7 +78,7 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
-		internal-regs@7f000000 {
+		bus@7f000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 9603223dd761..6ec22eaaf816 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -78,7 +78,7 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
-		internal-regs@d0000000 {
+		bus@d0000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 866628679ac7..e421d454daa7 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -5,7 +5,6 @@
  * Device Tree file for Marvell Armada AP806.
  */
 
-#define AP_NAME		ap806
 #include "armada-ap80x.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
index a3328d05fc94..7150ce83abf2 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Marvell Technology Group Ltd.
  */
 
-#define AP_NAME		ap807
 #include "armada-ap80x.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index e206d03a2867..40e146982921 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -63,14 +63,14 @@ pmu {
 		interrupts = <17>;
 	};
 
-	AP_NAME {
+	soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
 		ranges;
 
-		config-space@f0000000 {
+		bus@f0000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
index f5a89af154d4..a143d84bcf23 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
@@ -34,13 +34,13 @@ timer {
 				<GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	ap810-ap0 {
+	soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
 		ranges;
 
-		config-space@e8000000 {
+		bus@e8000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 161beec0b6b0..a057e119492f 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -17,7 +17,7 @@ / {
 	 * The contents of the node are defined below, in order to
 	 * save one indentation level
 	 */
-	CP11X_NAME: CP11X_NAME { };
+	CP11X_NAME: CP11X_NODE_NAME(bus) { };
 
 	/*
 	 * CPs only have one sensor in the thermal IC.
@@ -51,7 +51,7 @@ &CP11X_NAME {
 	interrupt-parent = <&CP11X_LABEL(icu_nsr)>;
 	ranges;
 
-	config-space@CP11X_BASE {
+	bus@CP11X_BASE {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-- 
2.47.2


