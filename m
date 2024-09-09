Return-Path: <linux-kernel+bounces-322161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE7972523
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E5728581C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB117D373;
	Mon,  9 Sep 2024 22:15:11 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8E54278;
	Mon,  9 Sep 2024 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920111; cv=none; b=gVgKT+ypT2aAUTkLj4o58ezuLG1T56u4EiBlgB9xpaHy+nLGJ5r8ihmoOiuDg6kPWmE1cjPhDPt7lmo6fi2JolZ9gJ5maByd7NXvFw3cCEu25UJXxqkstFriZg1Pax725kytJ/45uEnOqI5CrV9xUdUriFmUN7LSLKCmA8cIfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920111; c=relaxed/simple;
	bh=4YpFMu5mLQq5ecwsKN0zbUgFUfNc0iBFf+YCWyCTUYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ISHZpqgCdjP5bZmVkUmJCebvXDefhuKleERfT4K3cVMfjscKQsd0hADGhffFsIr9uZPVeRy2HtDCpf7AWNxJ47k4XEu42XCmBDlL2RlADQmsnX/Dj67CnBWuyGlht67OQiBc2PBgLDLnYntH2kOMpF71pQkLdXovYf5P5OZQ+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1snmf1-00FFIg-Mf;
	Mon, 09 Sep 2024 22:15:03 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mm-venice-*: add RTC aliases
Date: Mon,  9 Sep 2024 15:15:01 -0700
Message-Id: <20240909221501.806515-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add aliases for the RTCs on the Gateworks Venice boards and on the imx8m
SoC. This ensures that the primary RTC is always the one on-board
provided by the Gateworks System Controller (GSC) which is battery
backed as opposed to the one in the IMX8M.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi | 7 ++++++-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts  | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts  | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts  | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts  | 7 ++++++-
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts  | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts  | 4 +++-
 8 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
index 36803b038cd5..5a3b1142ddf4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
@@ -9,6 +9,11 @@
 #include <dt-bindings/net/ti-dp83867.h>
 
 / {
+	aliases {
+		rtc0 = &gsc_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0 0x80000000>;
@@ -292,7 +297,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	gsc_rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 35ae0faa815b..d8b67e12f7d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -22,6 +22,8 @@ aliases {
 		ethernet2 = &lan2;
 		ethernet3 = &lan3;
 		ethernet4 = &lan4;
+		rtc0 = &gsc_rtc;
+		rtc1 = &snvs_rtc;
 		usb0 = &usbotg1;
 		usb1 = &usbotg2;
 	};
@@ -497,7 +499,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	gsc_rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index c11260c26d0b..46d1ee0a4ee8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -19,6 +19,8 @@ / {
 
 	aliases {
 		ethernet1 = &eth1;
+		rtc0 = &gsc_rtc;
+		rtc1 = &snvs_rtc;
 		usb0 = &usbotg1;
 		usb1 = &usbotg2;
 	};
@@ -564,7 +566,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	gsc_rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index db1737bf637d..c0aadff4e25b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -18,6 +18,8 @@ / {
 
 	aliases {
 		ethernet0 = &fec1;
+		rtc0 = &gsc_rtc;
+		rtc1 = &snvs_rtc;
 		usb0 = &usbotg1;
 	};
 
@@ -394,7 +396,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	gsc_rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
index 05489a31e7fd..86a610de84fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
@@ -16,6 +16,11 @@ / {
 	model = "Gateworks Venice GW7904 i.MX8MM board";
 	compatible = "gateworks,imx8mm-gw7904", "fsl,imx8mm";
 
+	aliases {
+		rtc0 = &gsc_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
 	chosen {
 		stdout-path = &uart2;
 	};
@@ -438,7 +443,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	gsc_rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 0b1fa04f1d67..30c286b34aa5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -17,6 +17,8 @@ / {
 	compatible = "gw,imx8mn-gw7902", "fsl,imx8mn";
 
 	aliases {
+		rtc0 = &gsc_rtc;
+		rtc1 = &snvs_rtc;
 		usb0 = &usbotg1;
 	};
 
@@ -562,7 +564,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	gsc_rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index f0211a96855b..d34701409e88 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -11,6 +11,8 @@
 / {
 	aliases {
 		ethernet0 = &eqos;
+		rtc0 = &gsc_rtc;
+		rtc1 = &snvs_rtc;
 	};
 
 	memory@40000000 {
@@ -280,7 +282,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	gsc_rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 8a04b66a4afc..9a515f25e218 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -25,6 +25,8 @@ aliases {
 		ethernet4 = &lan3;
 		ethernet5 = &lan4;
 		ethernet6 = &lan5;
+		rtc0 = &gsc_rtc;
+		rtc1 = &snvs_rtc;
 	};
 
 	chosen {
@@ -481,7 +483,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	gsc_rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
-- 
2.25.1


