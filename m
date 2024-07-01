Return-Path: <linux-kernel+bounces-236451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F4991E281
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37B51C21B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA63116A941;
	Mon,  1 Jul 2024 14:31:12 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC8167D9E;
	Mon,  1 Jul 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844272; cv=none; b=IGWnkWpCM+6x88fAwA5jxoWTyNwisIBGVH7A9v1wt92QLQXSf6f7MDfPIc5V0oYbb9E/g13QF4UqMlyQj8MWqRBEUUVidxx0NS0g6MR18aFW//dcvgo1ZPYj5RI1wuzux5CMoq8kmdaNM+vdEV8hJWMMYbRwyOdP03ClqGGHfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844272; c=relaxed/simple;
	bh=lr1X8ohb20202VPLRbep99YyUoVA0vyuiwqleEaQyGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHH6dWdO7iBeImvpWYeNDJFd43a/phd+tYT6wJmrxRekXz3eGWbMtJOzn5Felk/0ushucLQL4EScaiiWcxVNR1IL/hbvUGdYgpkKUZZYqz3mXawYOEOGmGjHcJM3EpIbJn1vDZoYV56VVC5SR1Sir/1eVRhAh5wMCd/vnzo7DOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:7a80:98d3:5fc8:a2a:615f])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 760847E0180;
	Mon,  1 Jul 2024 22:30:34 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: amadeus@jmu.edu.cn
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: [PATCH v2 2/9] arm64: dts: rockchip: fix usb regulator for Lunzn Fastrhino R6xS
Date: Mon,  1 Jul 2024 22:30:26 +0800
Message-Id: <20240701143028.1203997-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701143028.1203997-1-amadeus@jmu.edu.cn>
References: <20240630150010.55729-1-amadeus@jmu.edu.cn>
 <20240701143028.1203997-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUJLVhlJQ0kfHU4aHU1JTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUwaQ0tBQkMfSEFOHRhDQRpJGkFNSk4dWVdZFhoPEh
	UdFFlBWU9LSFVKS0lIQktDVUpLS1VKQlkG
X-HM-Tid: 0a906eb465bd03a2kunm760847e0180
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6PSo6AzMBThcJFUI8T0NJ
	OQtPCipVSlVKTEpCQ09PSUhPQkxMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTBpDS0FCQx9IQU4dGENBGkkaQU1KTh1ZV1kIAVlBSUJCQjcG

Remove the non-existent usb_host regulator and fix the supply according
to the schematic. Also remove the unnecessary always-on and boot-on for
the usb_otg regulator.

Fixes: c79dab407afd ("arm64: dts: rockchip: Add Lunzn Fastrhino R66S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
index 93987c8740f7..8f587978fa3b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
@@ -78,15 +78,6 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
-	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb_host";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
 	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
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
 
@@ -460,7 +452,7 @@ &usb2phy0 {
 };
 
 &usb2phy0_host {
-	phy-supply = <&vcc5v0_usb_host>;
+	phy-supply = <&vcc5v0_sys>;
 	status = "okay";
 };
 
-- 
2.25.1


