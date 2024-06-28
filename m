Return-Path: <linux-kernel+bounces-233987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17FC91C071
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5FB255CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D11C0073;
	Fri, 28 Jun 2024 14:07:28 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259D1BF317;
	Fri, 28 Jun 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583647; cv=none; b=FzgleTysNqqljkNTxk2wNGD4g2ltuXMBnIZwnC3mFLtJhRVVpfZ4UHy0nP7uTOK/79rnWWUN2GxV1Jw8CWvCB41TeSojz1pXvVrSVRSucL4AZOoXnQ2eUogPpI44zRuYwbVk5xq9ezDVKNqVXrShTNFOQS9m0nwo56ZlUE4R014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583647; c=relaxed/simple;
	bh=CFrOZ3DwuyLEiXugSVYFUELxRoLgydn3KPMvhDBGPYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X92axZywqlmczrLQ9RO9KWd7vJd2tOl9GkyTSUPtgIZUIfssCtqgKweytVsgbr26dLh9MzcoNyKbZxsFHpwyoL/9d07blRtd7/QOp4/gSp6FV8/RgeAAvU+aDBSBjS+qD736smOEGimHdNFwW7KlUGCp4q2lbFkXz4riWAxnuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:1720:7e27:c507:902f:f5f3])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 2F6A07E0108;
	Fri, 28 Jun 2024 22:01:15 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/5] arm64: dts: rockchip: fix regulator and supply for Lunzn Fastrhino R6xS
Date: Fri, 28 Jun 2024 22:01:00 +0800
Message-Id: <20240628140104.551760-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkxIVkseSBkYSE1ISk9PGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtKQUpMSUtBTB5JTEEYTktMQUJLSR1BHU4dSFlXWRYaDx
	IVHRRZQVlPS0hVSktJT09PS1VKS0tVS1kG
X-HM-Tid: 0a905f2679ab03a2kunm2f6a07e0108
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46OCo*DDNRDRoYTg8MDzco
	ERYaCihVSlVKTEpCTkNISUxOQ0hDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBSkxJS0FMHklMQRhOS0xBQktJHUEdTh1IWVdZCAFZQU9CSE43Bg++

Make the regulator name and supply the same as those marked by schematics.

Fixes: c79dab407afd ("arm64: dts: rockchip: Add Lunzn Fastrhino R66S")
Fixes: b9f8ca655d80 ("arm64: dts: rockchip: Add Lunzn Fastrhino R68S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../dts/rockchip/rk3568-fastrhino-r66s.dts    |  4 +++
 .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 28 +++++++------------
 .../dts/rockchip/rk3568-fastrhino-r68s.dts    |  4 +++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
index 58ab7e9971db..b5e67990dd0f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
@@ -11,6 +11,10 @@ aliases {
 	};
 };
 
+&pmu_io_domains {
+	vccio3-supply = <&vccio_sd>;
+};
+
 &sdmmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
index 89e84e3a9262..82577eba31eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
@@ -39,9 +39,9 @@ status_led: led-status {
 		};
 	};
 
-	dc_12v: dc-12v-regulator {
+	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "dc_12v";
+		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <12000000>;
@@ -65,7 +65,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vcc5v0_sys: vcc5v0-sys-regulator {
@@ -75,16 +75,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
-	};
-
-	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb_host";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
@@ -94,8 +85,9 @@ vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vcc5v0_usb_otg_en>;
 		regulator-name = "vcc5v0_usb_otg";
-		regulator-always-on;
-		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 };
 
@@ -405,8 +397,8 @@ vcc5v0_usb_otg_en: vcc5v0-usb-otg-en {
 &pmu_io_domains {
 	pmuio1-supply = <&vcc3v3_pmu>;
 	pmuio2-supply = <&vcc3v3_pmu>;
-	vccio1-supply = <&vccio_acodec>;
-	vccio3-supply = <&vccio_sd>;
+	vccio1-supply = <&vcc_3v3>;
+	vccio2-supply = <&vcc_1v8>;
 	vccio4-supply = <&vcc_1v8>;
 	vccio5-supply = <&vcc_3v3>;
 	vccio6-supply = <&vcc_1v8>;
@@ -460,7 +452,7 @@ &usb2phy0 {
 };
 
 &usb2phy0_host {
-	phy-supply = <&vcc5v0_usb_host>;
+	phy-supply = <&vcc5v0_sys>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
index e1fe5e442689..a3339186e89c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
@@ -102,6 +102,10 @@ eth_phy1_reset_pin: eth-phy1-reset-pin {
 	};
 };
 
+&pmu_io_domains {
+	vccio3-supply = <&vcc_3v3>;
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.25.1


