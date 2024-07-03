Return-Path: <linux-kernel+bounces-239179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2BD9257AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED7B1F27543
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57953155C81;
	Wed,  3 Jul 2024 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="e4QaRo7X"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278561E4AB;
	Wed,  3 Jul 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000864; cv=none; b=Xk5juqfUYrEdzeNFiT9wcaM52iklb6pGYSFs7pGjFNtWj9r9JdY3h1DKJ573zTQglJT7Gp+iS5RJM4F/oLgs42ircxODMNyUxuafgkNLQypYp8QRC29ssT7A5qkx4pKC8T7DR5KyIaxTV2uEBFHyN18nXat810DipRXyzmV0v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000864; c=relaxed/simple;
	bh=9NlfXRK7mCQj3Wfx81FSxF/OjgyIU2vcoKoo/675pK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnQrf6oXJRqblyC/4ez//O0khZVJOHxTLN1LELIgVNgZgPYCButbAIkWLOxixOptPzKioVmnfZOTIf3SHuVuMQOcEnYe4FtXQ46y3qAq+sDgWyKFmU8+IhB/+6OLnQ/j7zXqgBGv/g8V0QK27yyJpLomJ6mSweyumCpNd+zG7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=e4QaRo7X; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 6D1D61F9FF;
	Wed,  3 Jul 2024 12:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1720000857;
	bh=mNHo4Nb6oWQND234v3Z//rfVwuUjQ+JtZjr11w8RLXU=; h=From:To:Subject;
	b=e4QaRo7XnAU06TO9kWTB5JUfOEv8Xu5cPBruzA0rvVJkxreS3hsh+VjBMEsV9G8UY
	 9KLhL9tD5u3kgK+Vk3wWGx4gNf0pBaBVBa/KQ3K35WQ2T1sVjqJRS7ZiDD/whIGGeG
	 ljPozeODkI4q+WXENF+mv9R5jJZHxCeQQlBHILfTSF6BqgAUSMqp0Wr+n2Nir25+UE
	 u+ZuQdv7WbmRvpT7/d2i5V4Qx1uzuizUFgs0CZDqRwdnkY9knXlV07F5uVdDBkwG5h
	 ARGSeEzFOln0RMcMX1AtcG9ONz1AupVhjlzyOOhMGbehC4gNf/6oqILCRF0w7P0wh6
	 c1yYi41imHAxQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/2] arm64: dts: ti: Mark PCIe PERST# polarity active low in DT
Date: Wed,  3 Jul 2024 12:00:35 +0200
Message-Id: <20240703100036.17896-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703100036.17896-1-francesco@dolcini.it>
References: <20240703100036.17896-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

As the name indicates, PERST# is active low. Fix the DT description to
match the HW behaviour.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                  | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts         | 2 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                    | 6 +++---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts    | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts       | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts    | 6 +++---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts   | 2 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                  | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                 | 4 ++--
 12 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 6bb1ad2e56ec..afefce706647 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -785,7 +785,7 @@ serdes0_pcie_link: phy@0 {
 
 &pcie0_rc {
 	status = "okay";
-	reset-gpios = <&exp1 5 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 5 GPIO_ACTIVE_LOW>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index cc619bbec181..0ea5edb830cb 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -86,7 +86,7 @@ &pcie0_rc {
 	num-lanes = <2>;
 	phys = <&serdes0 PHY_TYPE_PCIE 1>, <&serdes1 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy0","pcie-phy1";
-	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
index b829f4bcab69..0a23c7f4e1cd 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
@@ -180,7 +180,7 @@ &pcie0_rc {
 	num-lanes = <1>;
 	phys = <&serdes0 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy0";
-	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 90dbe31c5b81..ba7bd40f1535 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -713,7 +713,7 @@ serdes0_usb_link: phy@2 {
 
 &pcie1_rc {
 	status = "okay";
-	reset-gpios = <&exp1 10 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 10 GPIO_ACTIVE_LOW>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 3f655852244e..c62ab4caf354 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -1266,14 +1266,14 @@ serdes1_pcie_link: phy@0 {
 
 &pcie0_rc {
 	status = "okay";
-	reset-gpios = <&exp1 4 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 4 GPIO_ACTIVE_LOW>;
 	phys = <&serdes1_pcie_link>;
 	phy-names = "pcie-phy";
 };
 
 &pcie1_rc {
 	status = "okay";
-	reset-gpios = <&exp1 5 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 5 GPIO_ACTIVE_LOW>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
@@ -1281,7 +1281,7 @@ &pcie1_rc {
 
 &pcie3_rc {
 	status = "okay";
-	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 6 GPIO_ACTIVE_LOW>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 6593c5da82c0..8cf336c2d5c5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -445,7 +445,7 @@ serdes0_qsgmii_link: phy@1 {
 
 &pcie1_rc {
 	status = "okay";
-	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_LOW>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index a2925555fe81..4c4fdda146ab 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -858,7 +858,7 @@ &pcie1_rc {
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
 	max-link-speed = <3>;
-	reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_LOW>;
 };
 
 &ufs_wrapper {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8230d53cd696..8709fb11bb6a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -925,7 +925,7 @@ &mhdp {
 
 &pcie0_rc {
 	status = "okay";
-	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 6 GPIO_ACTIVE_LOW>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <1>;
@@ -933,7 +933,7 @@ &pcie0_rc {
 
 &pcie1_rc {
 	status = "okay";
-	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_LOW>;
 	phys = <&serdes1_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
@@ -941,7 +941,7 @@ &pcie1_rc {
 
 &pcie2_rc {
 	status = "okay";
-	reset-gpios = <&exp2 20 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp2 20 GPIO_ACTIVE_LOW>;
 	phys = <&serdes2_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 89fbfb21e5d3..6dc9966b52a1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1179,7 +1179,7 @@ &pcie0_rc {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ekey_reset_pins_default>;
-	reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_LOW>;
 
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
@@ -1190,7 +1190,7 @@ &pcie1_rc {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mkey_reset_pins_default>;
-	reset-gpios = <&wkup_gpio0 11 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&wkup_gpio0 11 GPIO_ACTIVE_LOW>;
 
 	phys = <&serdes1_pcie_link>;
 	phy-names = "pcie-phy";
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index c5a0b7cbb14f..0830cba9dc61 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -474,7 +474,7 @@ flash@0 {
 
 &pcie1_rc {
 	status = "okay";
-	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_LOW>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index dd3b5f7039d7..001c6fe7e95e 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -522,7 +522,7 @@ serdes1_pcie_link: phy@0 {
 };
 
 &pcie0_rc {
-	reset-gpios = <&exp1 18 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 18 GPIO_ACTIVE_LOW>;
 	phys = <&serdes1_pcie_link>;
 	phy-names = "pcie-phy";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 9338d987180d..e3a393740997 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1406,7 +1406,7 @@ &serdes_wiz0 {
 &pcie1_rc {
 	status = "okay";
 	num-lanes = <2>;
-	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_LOW>;
 	phys = <&serdes0_pcie1_link>;
 	phy-names = "pcie-phy";
 };
@@ -1429,7 +1429,7 @@ &serdes_wiz1 {
 
 &pcie0_rc {
 	status = "okay";
-	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&exp1 6 GPIO_ACTIVE_LOW>;
 	phys = <&serdes1_pcie0_link>;
 	phy-names = "pcie-phy";
 };
-- 
2.39.2


