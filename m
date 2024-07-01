Return-Path: <linux-kernel+bounces-236452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6383A91E280
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE001F26C08
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E816A93E;
	Mon,  1 Jul 2024 14:31:12 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A0167DA0;
	Mon,  1 Jul 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844272; cv=none; b=IPNt1r9p1tS7EvWCGlOGu61A/ioMUGdFeTQZJYF6eHF4WPBuKMLfQmnMNP84rBn4Bg24SCDF3tlk3ZBL7RBRcPDuJMxOpJ1+zed8RBHh0JIiuiYks3kl2v6+mx5/oK4+HweqXGubK8+nXaNWUKzxu3iFAc3KEU5+K2R5jUYFxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844272; c=relaxed/simple;
	bh=Ydo6IeCAYm/Htl+UqVy30jaJhyLZJozPLceq8yBsyKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUwLdtQQBOsHKMuZ6F2HwHyRVHiPSKQJp7yB3R9Oc7cHjvZFGhiBdilQxWf0VOFPdsruBybwJE6fd6FhUVWb8GxSzsHD73kAYVnk8NlTEpMiVtaAdL5BpdrKCdADucGZ9cjvpaFuUh/gnrh5Jk0zG2cfa27vbloq/9cp1Tef5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:7a80:98d3:5fc8:a2a:615f])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 9C9757E0193;
	Mon,  1 Jul 2024 22:30:35 +0800 (CST)
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
Subject: [PATCH v2 7/9] arm64: dts: rockchip: use generic Ethernet PHY reset bindings for Lunzn Fastrhino R68S
Date: Mon,  1 Jul 2024 22:30:28 +0800
Message-Id: <20240701143028.1203997-4-amadeus@jmu.edu.cn>
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
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkMYVh4eGB1CGhhPQkpMSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUwaQ0tBQkMfSEFOHRhDQRpJGkFNSk4dWVdZFhoPEh
	UdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQY+
X-HM-Tid: 0a906eb46a4703a2kunm9c9757e0193
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzY6CTo5OjNRFRcwM00hT0gY
	PUkaFB5VSlVKTEpCQ09PSUhNSkxIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTBpDS0FCQx9IQU4dGENBGkkaQU1KTh1ZV1kIAVlBSElCSDcG

Replace the deprecated snps,reset-xxx bindings to the generic Ethernet
PHY reset GPIO bindings. Also updates the delays based on the vendor
recommendations.

Fixes: b9f8ca655d80 ("arm64: dts: rockchip: Add Lunzn Fastrhino R68S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../boot/dts/rockchip/rk3568-fastrhino-r68s.dts    | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
index ce2a5e1ccefc..02d966d218fd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
@@ -39,10 +39,6 @@ &gmac0_tx_bus2
 		     &gmac0_rx_bus2
 		     &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
-	snps,reset-gpio = <&gpio1 RK_PB0 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	/* Reset time is 15ms, 50ms for rtl8211f */
-	snps,reset-delays-us = <0 15000 50000>;
 	tx_delay = <0x3c>;
 	rx_delay = <0x2f>;
 	status = "okay";
@@ -61,10 +57,6 @@ &gmac1m1_tx_bus2
 		     &gmac1m1_rx_bus2
 		     &gmac1m1_rgmii_clk
 		     &gmac1m1_rgmii_bus>;
-	snps,reset-gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	/* Reset time is 15ms, 50ms for rtl8211f */
-	snps,reset-delays-us = <0 15000 50000>;
 	tx_delay = <0x4f>;
 	rx_delay = <0x26>;
 	status = "okay";
@@ -76,6 +68,9 @@ rgmii_phy0: ethernet-phy@1 {
 		reg = <0x1>;
 		pinctrl-0 = <&eth_phy0_reset_pin>;
 		pinctrl-names = "default";
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -85,6 +80,9 @@ rgmii_phy1: ethernet-phy@1 {
 		reg = <0x1>;
 		pinctrl-0 = <&eth_phy1_reset_pin>;
 		pinctrl-names = "default";
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio1 RK_PB1 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.25.1


