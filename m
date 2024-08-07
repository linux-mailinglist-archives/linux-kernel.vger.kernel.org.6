Return-Path: <linux-kernel+bounces-278307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB6694AE8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40E21F22112
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECFD13DBBC;
	Wed,  7 Aug 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7Nn+AO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AD13D63E;
	Wed,  7 Aug 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049951; cv=none; b=hAijoYiPNqnBplGNM1/IK9Sxd2SRmnUg7xctpXxqmgZBGV+UyA3309UHaa+/2bWNJL1XZpdwvdtcpArNk2XJVC+EzMS5BI91Y6lhHLgrFJ6ScIPg3FxKgAC2MZElL460BiVeguainU5NyllcfxrKnKS1zuYE4KaYj2/JYPI6JMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049951; c=relaxed/simple;
	bh=x9q+3xwqwt6+MAUQr+R8TENXEykq6+8Foo497qCQFEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1wbaOJwdMpl4nCzRi13LZy4m7SQu6TSl2bG0SXfhQziLQtaeKRhLw5r3IGIeIVHwYUBFfecMVSIgLgX2eJ4DY7CA8gp/2JvxG6UMqT0dJnuvj9MayfNf0E4V57SCdYj8MDVYYsS7VDdhAIIuY+LX8SiII9rS+jrmVPpnrQ+Sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7Nn+AO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42A9C4AF0D;
	Wed,  7 Aug 2024 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723049950;
	bh=x9q+3xwqwt6+MAUQr+R8TENXEykq6+8Foo497qCQFEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B7Nn+AO2KCo4JuNO6EUvpcv9vOl1IDu/6s6uvPg3Qr6UCsMLVomsXm4yvv5Q7fg43
	 np66m1X3Eds6qiQZrVp7XV7mGt5SuyY7lPMe9Di5cvj4TN0+YmWrNWDm9RGbjw3uBh
	 Nr3TOyNeKud/YgGGva2/+PPrbeGiKGhSJfaNCWLLLPEMo6d3xYgkGgSuW2S7BExX/J
	 JMIfuVlqYnWDuog5FuV5js07Wn5ddsTKUHVqNcChX8jt73808i6ef8BMVIV2NxU2L2
	 3Zg4JbmQqo4FmdzppfmZ31dNQbPaiBw190zVmZxaws+qqEeaLt+SA99RR2oL891e27
	 dLl2Np/r30+QA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 07 Aug 2024 10:58:55 -0600
Subject: [PATCH 3/3] dt-bindings: clock: mediatek: Convert MediaTek clock
 syscons to schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-dt-mediatek-clk-v1-3-e8d568abfd48@kernel.org>
References: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>
In-Reply-To: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15-dev

Convert the various MediaTek syscon bindings which are a clock provider
into DT schema format. As they are all the same other than compatible
string, combine them into a single schema file.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/mediatek/mediatek,bdpsys.txt      | 24 ------
 .../bindings/arm/mediatek/mediatek,camsys.txt      | 24 ------
 .../bindings/arm/mediatek/mediatek,imgsys.txt      | 30 -------
 .../bindings/arm/mediatek/mediatek,ipesys.txt      | 22 -----
 .../bindings/arm/mediatek/mediatek,ipu.txt         | 43 ----------
 .../bindings/arm/mediatek/mediatek,jpgdecsys.txt   | 22 -----
 .../bindings/arm/mediatek/mediatek,mcucfg.txt      | 23 ------
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      | 25 ------
 .../bindings/arm/mediatek/mediatek,mipi0a.txt      | 28 -------
 .../bindings/arm/mediatek/mediatek,vcodecsys.txt   | 27 -------
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     | 29 -------
 .../bindings/arm/mediatek/mediatek,vencltsys.txt   | 22 -----
 .../bindings/arm/mediatek/mediatek,vencsys.txt     | 26 ------
 .../devicetree/bindings/clock/mediatek,syscon.yaml | 93 ++++++++++++++++++++++
 14 files changed, 93 insertions(+), 345 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
deleted file mode 100644
index 149567a38215..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Mediatek bdpsys controller
-============================
-
-The Mediatek bdpsys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt2701-bdpsys", "syscon"
-	- "mediatek,mt2712-bdpsys", "syscon"
-	- "mediatek,mt7623-bdpsys", "mediatek,mt2701-bdpsys", "syscon"
-- #clock-cells: Must be 1
-
-The bdpsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-bdpsys: clock-controller@1c000000 {
-	compatible = "mediatek,mt2701-bdpsys", "syscon";
-	reg = <0 0x1c000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
deleted file mode 100644
index a0ce82085ad0..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-MediaTek CAMSYS controller
-============================
-
-The MediaTek camsys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt6765-camsys", "syscon"
-	- "mediatek,mt6779-camsys", "syscon"
-	- "mediatek,mt8183-camsys", "syscon"
-- #clock-cells: Must be 1
-
-The camsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-camsys: camsys@1a000000  {
-	compatible = "mediatek,mt8183-camsys", "syscon";
-	reg = <0 0x1a000000  0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
deleted file mode 100644
index dce4c9241932..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Mediatek imgsys controller
-============================
-
-The Mediatek imgsys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2701-imgsys", "syscon"
-	- "mediatek,mt2712-imgsys", "syscon"
-	- "mediatek,mt6765-imgsys", "syscon"
-	- "mediatek,mt6779-imgsys", "syscon"
-	- "mediatek,mt6797-imgsys", "syscon"
-	- "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
-	- "mediatek,mt8167-imgsys", "syscon"
-	- "mediatek,mt8173-imgsys", "syscon"
-	- "mediatek,mt8183-imgsys", "syscon"
-- #clock-cells: Must be 1
-
-The imgsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-imgsys: clock-controller@15000000 {
-	compatible = "mediatek,mt8173-imgsys", "syscon";
-	reg = <0 0x15000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt
deleted file mode 100644
index 2ce889b023d9..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Mediatek ipesys controller
-============================
-
-The Mediatek ipesys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt6779-ipesys", "syscon"
-- #clock-cells: Must be 1
-
-The ipesys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-ipesys: clock-controller@1b000000 {
-	compatible = "mediatek,mt6779-ipesys", "syscon";
-	reg = <0 0x1b000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
deleted file mode 100644
index aabc8c5c8ed2..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Mediatek IPU controller
-============================
-
-The Mediatek ipu controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt8183-ipu_conn", "syscon"
-	- "mediatek,mt8183-ipu_adl", "syscon"
-	- "mediatek,mt8183-ipu_core0", "syscon"
-	- "mediatek,mt8183-ipu_core1", "syscon"
-- #clock-cells: Must be 1
-
-The ipu controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-ipu_conn: syscon@19000000 {
-	compatible = "mediatek,mt8183-ipu_conn", "syscon";
-	reg = <0 0x19000000 0 0x1000>;
-	#clock-cells = <1>;
-};
-
-ipu_adl: syscon@19010000 {
-	compatible = "mediatek,mt8183-ipu_adl", "syscon";
-	reg = <0 0x19010000 0 0x1000>;
-	#clock-cells = <1>;
-};
-
-ipu_core0: syscon@19180000 {
-	compatible = "mediatek,mt8183-ipu_core0", "syscon";
-	reg = <0 0x19180000 0 0x1000>;
-	#clock-cells = <1>;
-};
-
-ipu_core1: syscon@19280000 {
-	compatible = "mediatek,mt8183-ipu_core1", "syscon";
-	reg = <0 0x19280000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt
deleted file mode 100644
index 2df799cd06a7..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Mediatek jpgdecsys controller
-============================
-
-The Mediatek jpgdecsys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt2712-jpgdecsys", "syscon"
-- #clock-cells: Must be 1
-
-The jpgdecsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-jpgdecsys: syscon@19000000 {
-	compatible = "mediatek,mt2712-jpgdecsys", "syscon";
-	reg = <0 0x19000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
deleted file mode 100644
index 2b882b7ca72e..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Mediatek mcucfg controller
-============================
-
-The Mediatek mcucfg controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2712-mcucfg", "syscon"
-	- "mediatek,mt8183-mcucfg", "syscon"
-- #clock-cells: Must be 1
-
-The mcucfg controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-mcucfg: syscon@10220000 {
-	compatible = "mediatek,mt2712-mcucfg", "syscon";
-	reg = <0 0x10220000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
deleted file mode 100644
index 054424fb64b4..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Mediatek mfgcfg controller
-============================
-
-The Mediatek mfgcfg controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2712-mfgcfg", "syscon"
-	- "mediatek,mt6779-mfgcfg", "syscon"
-	- "mediatek,mt8167-mfgcfg", "syscon"
-	- "mediatek,mt8183-mfgcfg", "syscon"
-- #clock-cells: Must be 1
-
-The mfgcfg controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-mfgcfg: syscon@13000000 {
-	compatible = "mediatek,mt2712-mfgcfg", "syscon";
-	reg = <0 0x13000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
deleted file mode 100644
index 1c671943ce4d..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Mediatek mipi0a (mipi_rx_ana_csi0a) controller
-============================
-
-The Mediatek mipi0a controller provides various clocks
-to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt6765-mipi0a", "syscon"
-- #clock-cells: Must be 1
-
-The mipi0a controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-The mipi0a controller also uses the common power domain from
-Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
-The available power domains are defined in dt-bindings/power/mt*-power.h.
-
-Example:
-
-mipi0a: clock-controller@11c10000 {
-	compatible = "mediatek,mt6765-mipi0a", "syscon";
-	reg = <0 0x11c10000 0 0x1000>;
-	power-domains = <&scpsys MT6765_POWER_DOMAIN_CAM>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
deleted file mode 100644
index f090147b7f1e..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Mediatek vcodecsys controller
-============================
-
-The Mediatek vcodecsys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt6765-vcodecsys", "syscon"
-- #clock-cells: Must be 1
-
-The vcodecsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-The vcodecsys controller also uses the common power domain from
-Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
-The available power domains are defined in dt-bindings/power/mt*-power.h.
-
-Example:
-
-venc_gcon: clock-controller@17000000 {
-	compatible = "mediatek,mt6765-vcodecsys", "syscon";
-	reg = <0 0x17000000 0 0x10000>;
-	power-domains = <&scpsys MT6765_POWER_DOMAIN_VCODEC>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
deleted file mode 100644
index 98195169176a..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Mediatek vdecsys controller
-============================
-
-The Mediatek vdecsys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2701-vdecsys", "syscon"
-	- "mediatek,mt2712-vdecsys", "syscon"
-	- "mediatek,mt6779-vdecsys", "syscon"
-	- "mediatek,mt6797-vdecsys", "syscon"
-	- "mediatek,mt7623-vdecsys", "mediatek,mt2701-vdecsys", "syscon"
-	- "mediatek,mt8167-vdecsys", "syscon"
-	- "mediatek,mt8173-vdecsys", "syscon"
-	- "mediatek,mt8183-vdecsys", "syscon"
-- #clock-cells: Must be 1
-
-The vdecsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-vdecsys: clock-controller@16000000 {
-	compatible = "mediatek,mt8173-vdecsys", "syscon";
-	reg = <0 0x16000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
deleted file mode 100644
index 3cc299fd7857..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Mediatek vencltsys controller
-============================
-
-The Mediatek vencltsys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt8173-vencltsys", "syscon"
-- #clock-cells: Must be 1
-
-The vencltsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-vencltsys: clock-controller@19000000 {
-	compatible = "mediatek,mt8173-vencltsys", "syscon";
-	reg = <0 0x19000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
deleted file mode 100644
index 6a6a14e15cd7..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Mediatek vencsys controller
-============================
-
-The Mediatek vencsys controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2712-vencsys", "syscon"
-	- "mediatek,mt6779-vencsys", "syscon"
-	- "mediatek,mt6797-vencsys", "syscon"
-	- "mediatek,mt8173-vencsys", "syscon"
-	- "mediatek,mt8183-vencsys", "syscon"
-- #clock-cells: Must be 1
-
-The vencsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-vencsys: clock-controller@18000000 {
-	compatible = "mediatek,mt8173-vencsys", "syscon";
-	reg = <0 0x18000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml b/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
new file mode 100644
index 000000000000..10483e26878f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Clock controller syscon's
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The MediaTek clock controller syscon's provide various clocks to the system.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-bdpsys
+              - mediatek,mt2701-imgsys
+              - mediatek,mt2701-vdecsys
+              - mediatek,mt2712-bdpsys
+              - mediatek,mt2712-imgsys
+              - mediatek,mt2712-jpgdecsys
+              - mediatek,mt2712-mcucfg
+              - mediatek,mt2712-mfgcfg
+              - mediatek,mt2712-vdecsys
+              - mediatek,mt2712-vencsys
+              - mediatek,mt6765-camsys
+              - mediatek,mt6765-imgsys
+              - mediatek,mt6765-mipi0a
+              - mediatek,mt6765-vcodecsys
+              - mediatek,mt6779-camsys
+              - mediatek,mt6779-imgsys
+              - mediatek,mt6779-ipesys
+              - mediatek,mt6779-mfgcfg
+              - mediatek,mt6779-vdecsys
+              - mediatek,mt6779-vencsys
+              - mediatek,mt6797-imgsys
+              - mediatek,mt6797-vdecsys
+              - mediatek,mt6797-vencsys
+              - mediatek,mt8167-imgsys
+              - mediatek,mt8167-mfgcfg
+              - mediatek,mt8167-vdecsys
+              - mediatek,mt8173-imgsys
+              - mediatek,mt8173-vdecsys
+              - mediatek,mt8173-vencltsys
+              - mediatek,mt8173-vencsys
+              - mediatek,mt8183-camsys
+              - mediatek,mt8183-imgsys
+              - mediatek,mt8183-ipu_conn
+              - mediatek,mt8183-ipu_adl
+              - mediatek,mt8183-ipu_core0
+              - mediatek,mt8183-ipu_core1
+              - mediatek,mt8183-mcucfg
+              - mediatek,mt8183-mfgcfg
+              - mediatek,mt8183-vdecsys
+              - mediatek,mt8183-vencsys
+          - const: syscon
+      - items:
+          - const: mediatek,mt7623-bdpsys
+          - const: mediatek,mt2701-bdpsys
+          - const: syscon
+      - items:
+          - const: mediatek,mt7623-imgsys
+          - const: mediatek,mt2701-imgsys
+          - const: syscon
+      - items:
+          - const: mediatek,mt7623-vdecsys
+          - const: mediatek,mt2701-vdecsys
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@11220000 {
+        compatible = "mediatek,mt2701-bdpsys", "syscon";
+        reg = <0x11220000 0x2000>;
+        #clock-cells = <1>;
+    };

-- 
2.43.0


