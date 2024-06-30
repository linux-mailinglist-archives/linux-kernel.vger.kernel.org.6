Return-Path: <linux-kernel+bounces-235573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5E91D6C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7AB5B2154E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE42A1DC;
	Mon,  1 Jul 2024 03:57:25 +0000 (UTC)
Received: from mail-m1018.netease.com (mail-m1018.netease.com [154.81.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A52F29;
	Mon,  1 Jul 2024 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719806245; cv=none; b=OpTSjVFt4OlyOAj8Ce0K0QiFN+jhrX4sy0I0mBJjPDh6LI5zmtkiBOg2vkKri2dR0t1U3rEkD7pGDkytl5Fw9RrKTohFNvlcEFoQ1+YMeLkligTHhFJPuZcBNIX6AQF5jJVhyv4+nhntWgErsoQDxaRhcCby2rgy3j32Wm65KH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719806245; c=relaxed/simple;
	bh=7cVXzSADnuSc9av+rN6I6zT0OSGXAj6cgg+zl+Z9DeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JgtSZe7SUQO2iYDCGouMo8j8g76gBbg/+ydgp3hoHEXyVE7xT+yDDA3tBr31BrdeQcubuuLgPqyJHpiQDpaXv6EZZMX4cM4J1mzj0QvqQ86yCjsSoNDZgtVtIYRQmdIeNddnoiZNQ61l/WpzlZ0DQ+FBFTRWBtxlT8N0b4jVtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=154.81.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:1720:3110:52ea:d52a:84f0])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 028B27E0189;
	Sun, 30 Jun 2024 23:00:17 +0800 (CST)
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
Subject: [PATCH v2 6/9] arm64: dts: rockchip: fixes PHY reset for Lunzn Fastrhino R68S
Date: Sun, 30 Jun 2024 23:00:07 +0800
Message-Id: <20240630150010.55729-7-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240630150010.55729-1-amadeus@jmu.edu.cn>
References: <20240630150010.55729-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEkeVh9PSBlIGkMeQ0lPGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtKQUpMSUtBSEpKS0FOSR4aQR9OSRpBQ08dS1lXWRYaDx
	IVHRRZQVlPS0hVSktJT09PS1VKS0tVS1kG
X-HM-Tid: 0a9069a940b803a2kunm028b27e0189
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTo6Dyo6DjMMQhwQVjABSDoo
	MSxPCgtVSlVKTEpCTE5CTUpDTUlCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBSkxJS0FISkpLQU5JHhpBH05JGkFDTx1LWVdZCAFZQUhJSkg3Bg++

Fixed the PHY address and reset GPIOs (does not match the corresponding
pinctrl) for gmac0 and gmac1.

Fixes: b9f8ca655d80 ("arm64: dts: rockchip: Add Lunzn Fastrhino R68S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../boot/dts/rockchip/rk3568-fastrhino-r68s.dts      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
index a3339186e89c..ce2a5e1ccefc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
@@ -39,7 +39,7 @@ &gmac0_tx_bus2
 		     &gmac0_rx_bus2
 		     &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
-	snps,reset-gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio1 RK_PB0 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	/* Reset time is 15ms, 50ms for rtl8211f */
 	snps,reset-delays-us = <0 15000 50000>;
@@ -61,7 +61,7 @@ &gmac1m1_tx_bus2
 		     &gmac1m1_rx_bus2
 		     &gmac1m1_rgmii_clk
 		     &gmac1m1_rgmii_bus>;
-	snps,reset-gpio = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	/* Reset time is 15ms, 50ms for rtl8211f */
 	snps,reset-delays-us = <0 15000 50000>;
@@ -71,18 +71,18 @@ &gmac1m1_rgmii_clk
 };
 
 &mdio0 {
-	rgmii_phy0: ethernet-phy@0 {
+	rgmii_phy0: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
+		reg = <0x1>;
 		pinctrl-0 = <&eth_phy0_reset_pin>;
 		pinctrl-names = "default";
 	};
 };
 
 &mdio1 {
-	rgmii_phy1: ethernet-phy@0 {
+	rgmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
+		reg = <0x1>;
 		pinctrl-0 = <&eth_phy1_reset_pin>;
 		pinctrl-names = "default";
 	};
-- 
2.25.1


