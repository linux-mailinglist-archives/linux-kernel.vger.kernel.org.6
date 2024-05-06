Return-Path: <linux-kernel+bounces-169709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF88BCC68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68F91F234DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7692142E87;
	Mon,  6 May 2024 10:51:48 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6E1339A2;
	Mon,  6 May 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992708; cv=none; b=ReSq3Ak+sz/sEZlQGE04xD4c+K/hK5TjwTZA/RH74fGyrf2CiOfJQiLcpw4xQLAUFCaD+P9+pzV8AW00+zPuLu5QdnG/gDzoUtRZ24LNBQ3PnDEq9CSWezX+x5RcTrt3fB4zTUh2M7KPnRat6tpmCcrPny+SU/g986AlUJqHQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992708; c=relaxed/simple;
	bh=Qw3TWGhB2UKnexnJuUVEzsDnGUQy1HuP5qKz6mA8wOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8G6WCJCTl++vEafFBWtIvCQlhPDGpYjTH35rN5rYRJrzlxc1BzfXZphIuCF2nRsXnrCnikIHNobjMht+3Ur1Osekq1RgD/aFLlMo3wfweE6T1LEAZMVikmLgcBDgZ8CkX+siBAs/cCGSnnMMvmOG7D68XpqOF7NRmFJ2SfJhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 6 May
 2024 18:51:21 +0800
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 May
 2024 18:51:20 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 6 May 2024 18:51:20 +0800
From: Dylan Hung <dylan_hung@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>,
	<alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [PATCH 1/2] [RFC] ARM: dts: aspeed-g6: Add AST2600 I3Cs
Date: Mon, 6 May 2024 18:51:19 +0800
Message-ID: <20240506105120.3028083-2-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
References: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of dylan_hung@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;

The AST2600 has 6 I3Cs which are based on dw-i3c along with Aspeed
proprietary enhancements.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 137 ++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 29f94696d8b1..d0d685747b74 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -13,6 +13,12 @@ / {
 	interrupt-parent = <&gic>;
 
 	aliases {
+		i3c0 = &i3c0;
+		i3c1 = &i3c1;
+		i3c2 = &i3c2;
+		i3c3 = &i3c3;
+		i3c4 = &i3c4;
+		i3c5 = &i3c5;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -579,6 +585,13 @@ wdt4: watchdog@1e7850c0 {
 				status = "disabled";
 			};
 
+			i3c: bus@1e7a0000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e7a0000 0x8000>;
+			};
+
 			peci0: peci-controller@1e78b000 {
 				compatible = "aspeed,ast2600-peci";
 				reg = <0x1e78b000 0x100>;
@@ -1125,3 +1138,127 @@ i2c15: i2c-bus@800 {
 		status = "disabled";
 	};
 };
+
+&i3c {
+	i3c_global: i3c-global {
+		compatible = "aspeed,ast2600-i3c-global", "simple-mfd", "syscon";
+		resets = <&syscon ASPEED_RESET_I3C>;
+		reg = <0x0 0x1000>;
+	};
+
+	i3c0: i3c@2000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x2000 0x1000>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C0CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c1_default>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 0>;
+		status = "disabled";
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <2000000>;
+		i3c-od-scl-hi-period-ns = <380>;
+		i3c-od-scl-lo-period-ns = <620>;
+		i3c-pp-scl-hi-period-ns = <250>;
+		i3c-pp-scl-lo-period-ns = <250>;
+		sda-tx-hold-ns = <70>;
+		sda-pullup-ohms = <2000>;
+	};
+
+	i3c1: i3c@3000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x3000 0x1000>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C1CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c2_default>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 1>;
+		status = "disabled";
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <2000000>;
+		i3c-od-scl-hi-period-ns = <380>;
+		i3c-od-scl-lo-period-ns = <620>;
+		i3c-pp-scl-hi-period-ns = <250>;
+		i3c-pp-scl-lo-period-ns = <250>;
+		sda-tx-hold-ns = <70>;
+		sda-pullup-ohms = <2000>;
+	};
+
+	i3c2: i3c@4000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x4000 0x1000>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C2CLK>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 2>;
+		status = "disabled";
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <2000000>;
+		i3c-od-scl-hi-period-ns = <380>;
+		i3c-od-scl-lo-period-ns = <620>;
+		i3c-pp-scl-hi-period-ns = <250>;
+		i3c-pp-scl-lo-period-ns = <250>;
+		sda-tx-hold-ns = <70>;
+		sda-pullup-ohms = <2000>;
+	};
+
+	i3c3: i3c@5000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x5000 0x1000>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C3CLK>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 3>;
+		status = "disabled";
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <2000000>;
+		i3c-od-scl-hi-period-ns = <380>;
+		i3c-od-scl-lo-period-ns = <620>;
+		i3c-pp-scl-hi-period-ns = <250>;
+		i3c-pp-scl-lo-period-ns = <250>;
+		sda-tx-hold-ns = <70>;
+		sda-pullup-ohms = <2000>;
+	};
+
+	i3c4: i3c@6000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x6000 0x1000>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C4CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c5_default>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 4>;
+		status = "disabled";
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <2000000>;
+		i3c-od-scl-hi-period-ns = <380>;
+		i3c-od-scl-lo-period-ns = <620>;
+		i3c-pp-scl-hi-period-ns = <250>;
+		i3c-pp-scl-lo-period-ns = <250>;
+		sda-tx-hold-ns = <70>;
+		sda-pullup-ohms = <2000>;
+	};
+
+	i3c5: i3c@7000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x7000 0x1000>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C5CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c6_default>;
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 5>;
+		status = "disabled";
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <2000000>;
+		i3c-od-scl-hi-period-ns = <380>;
+		i3c-od-scl-lo-period-ns = <620>;
+		i3c-pp-scl-hi-period-ns = <250>;
+		i3c-pp-scl-lo-period-ns = <250>;
+		sda-tx-hold-ns = <70>;
+		sda-pullup-ohms = <2000>;
+	};
+};
-- 
2.25.1


