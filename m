Return-Path: <linux-kernel+bounces-525623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE6AA3F262
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1E9188F856
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE2207656;
	Fri, 21 Feb 2025 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QFH26siR"
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com [45.254.49.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F8204C3A;
	Fri, 21 Feb 2025 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134669; cv=none; b=UToK56rSe2ibxS7PKjqLQFjf14pEpoDVw3mvJhtir0STPm3z5c9gb0t/LPPrQgkyJcjlLtLBWJ1pnLEEHPNddAOe0yR4IRy1rai27JalbxPN39DARVySgFjIUsEE5Ndo6OGJeUlHH9ASOV18VMAnONB1bMLEFWvn1UDeAIFHQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134669; c=relaxed/simple;
	bh=j5KCACYN/OJuCD6P05XQ/GtFAu5HmVoQqpiBN/SU1Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBrGwg7CXwjeEkZKr4mcLxAk2yZSoge+Z8y4diMAfLoThxmk4Gd6naLrLxP5GnZHV/b3Kfygz8b+v2CLDhe9nwVshmAyyMxGQI5c1gVtzx3NOX6V424UvO1CghRxSq3nMBO8SIOU2LQrz2vwmRre/wBG7RKUKW/gVOfuj2U+U4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QFH26siR; arc=none smtp.client-ip=45.254.49.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bca250c1;
	Fri, 21 Feb 2025 18:44:15 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Liang Chen <cl@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v6 2/2] arm64: dts: rockchip: Add rk3576 pcie nodes
Date: Fri, 21 Feb 2025 18:43:57 +0800
Message-Id: <20250221104357.1514128-3-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221104357.1514128-1-kever.yang@rock-chips.com>
References: <20250221104357.1514128-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwfS1YYQhlMSxpLH0JNSE5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95281ba4f803afkunmbca250c1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgw6Pgw*IzIJQhkZGQMPGAEj
	DxgwFCtVSlVKTE9LSkhPTU5NTktNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQkhPNwY+
DKIM-Signature:a=rsa-sha256;
	b=QFH26siRGVcCZyIMEOMBXhpxRMjqpng20geAqyTffKjmHdP0ZSkO9tH+QSpZZUhtplCAun2hctJmV0k48FeOlB/glVsPnQTxPOgAynnaw5zt6yPwQrvHLuGTSejJX5ye2lb5hBMdAWr4yBJLwovT65txiES3E/zJH2AW1gVaNNQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=YLtGowOkt8ndAKlUsXif47m975sM/2ZzAAVHl3AULBw=;
	h=date:mime-version:subject:message-id:from;

rk3576 has two pcie controllers, both are pcie2x1 work with
naneng-combphy.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- Update the subject

Changes in v2:
- Update clock and reset names and sequence to pass DTB check

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 109 +++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 4dde954043ef..b4f396421686 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1127,6 +1127,115 @@ qos_npu_m1ro: qos@27f22100 {
 			reg = <0x0 0x27f22100 0x0 0x20>;
 		};
 
+		pcie0: pcie@2a200000 {
+			compatible = "rockchip,rk3576-pcie", "rockchip,rk3568-pcie";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x0 0xf>;
+			clocks = <&cru ACLK_PCIE0_MST>, <&cru ACLK_PCIE0_SLV>,
+				 <&cru ACLK_PCIE0_DBI>, <&cru PCLK_PCIE0>,
+				 <&cru CLK_PCIE0_AUX>;
+
+			clock-names = "aclk_mst", "aclk_slv",
+				      "aclk_dbi", "pclk",
+				      "aux";
+			device_type = "pci";
+			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "sys", "pmc", "msg", "legacy", "err", "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+					<0 0 0 2 &pcie0_intc 1>,
+					<0 0 0 3 &pcie0_intc 2>,
+					<0 0 0 4 &pcie0_intc 3>;
+			linux,pci-domain = <0>;
+			num-ib-windows = <8>;
+			num-viewport = <8>;
+			num-ob-windows = <2>;
+			max-link-speed = <2>;
+			num-lanes = <1>;
+			phys = <&combphy0_ps PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&power RK3576_PD_PHP>;
+			ranges = <0x01000000 0x0 0x20100000 0x0 0x20100000 0x0 0x00100000
+				  0x02000000 0x0 0x20200000 0x0 0x20200000 0x0 0x00e00000
+				  0x03000000 0x9 0x00000000 0x9 0x00000000 0x0 0x80000000>;
+			reg = <0x0 0x22000000 0x0 0x00400000>,
+			      <0x0 0x2a200000 0x0 0x00010000>,
+			      <0x0 0x20000000 0x0 0x00100000>;
+			reg-names = "dbi", "apb", "config";
+			resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
+			reset-names = "pwr", "pipe";
+			status = "disabled";
+
+			pcie0_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
+
+		pcie1: pcie@2a210000 {
+			compatible = "rockchip,rk3576-pcie", "rockchip,rk3568-pcie";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x20 0x2f>;
+			clocks = <&cru ACLK_PCIE1_MST>, <&cru ACLK_PCIE1_SLV>,
+				 <&cru ACLK_PCIE1_DBI>, <&cru PCLK_PCIE1>,
+				 <&cru CLK_PCIE1_AUX>;
+			clock-names = "aclk_mst", "aclk_slv",
+				      "aclk_dbi", "pclk",
+				      "aux";
+			device_type = "pci";
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "sys", "pmc", "msg", "legacy", "err", "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+					<0 0 0 2 &pcie1_intc 1>,
+					<0 0 0 3 &pcie1_intc 2>,
+					<0 0 0 4 &pcie1_intc 3>;
+			linux,pci-domain = <0>;
+			num-ib-windows = <8>;
+			num-viewport = <8>;
+			num-ob-windows = <2>;
+			max-link-speed = <2>;
+			num-lanes = <1>;
+			phys = <&combphy1_psu PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&power RK3576_PD_SUBPHP>;
+			ranges = <0x01000000 0x0 0x21100000 0x0 0x21100000 0x0 0x00100000
+				  0x02000000 0x0 0x21200000 0x0 0x21200000 0x0 0x00e00000
+				  0x03000000 0x9 0x80000000 0x9 0x80000000 0x0 0x80000000>;
+			reg = <0x0 0x22400000 0x0 0x00400000>,
+			      <0x0 0x2a210000 0x0 0x00010000>,
+			      <0x0 0x21000000 0x0 0x00100000>;
+			reg-names = "dbi", "apb", "config";
+			resets = <&cru SRST_PCIE1_POWER_UP>, <&cru SRST_P_PCIE1>;
+			reset-names = "pwr", "pipe";
+			status = "disabled";
+
+			pcie1_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 266 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
+
 		gmac0: ethernet@2a220000 {
 			compatible = "rockchip,rk3576-gmac", "snps,dwmac-4.20a";
 			reg = <0x0 0x2a220000 0x0 0x10000>;
-- 
2.25.1


