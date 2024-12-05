Return-Path: <linux-kernel+bounces-433293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4849E5616
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F46316C701
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE921A440;
	Thu,  5 Dec 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LQ3Q+qn6"
Received: from mail-m11871.qiye.163.com (mail-m11871.qiye.163.com [115.236.118.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00281219A83;
	Thu,  5 Dec 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403543; cv=none; b=ssGg8wdFGetWo7sziFRluxjzGI2zo+nYHk4Pa1QN7bcNROL6wAMsDgDItDU8iNKP8Rx5pmqgyKpzANGJVKHx4FkTzlFzfMhYWgZSIS1n7a3cNKBNw53BnFPwmKXabRLpyes6VgFtRd/eEfkwc4BjYvrXOpSURvr+78QFSpb2QVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403543; c=relaxed/simple;
	bh=ujK5gNSvAwgjL9Tus9aUWWhqdmAH2OiddQIekMowhOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hax0pXWNV/TDs4mIOoUj+UdjHju/OPxCBXABX4fZ4PdxFRgaraWTehGZEUwT4hxrP0KY091emTnfPYqNbDIQJtRBy87qBhbDbsSg7D7powte8elQmsMReO+c4nz2E+bu+LJllbjUs+0NIyiUZ+i+2O+9CKr1BbOlcEHf1BrU31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LQ3Q+qn6; arc=none smtp.client-ip=115.236.118.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cf7c96e;
	Thu, 5 Dec 2024 18:36:31 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liang Chen <cl@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dts: arm64: rockchip: Add rk3576 pcie nodes
Date: Thu,  5 Dec 2024 18:36:20 +0800
Message-Id: <20241205103623.878181-4-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205103623.878181-1-kever.yang@rock-chips.com>
References: <20241205103623.878181-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pKSFZMTE1JTUtOGBpLHUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a939664885503afkunm4cf7c96e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6Txw*KjIvMw0OTCxPCxkv
	FxZPFB9VSlVKTEhISEJPQkJJT0lMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQktCNwY+
DKIM-Signature:a=rsa-sha256;
	b=LQ3Q+qn60/AGQS3EAHD+WipqNSolNfA08BN5ZnVmYZNpJXptOAZfbqhhNJzM2p0ALfsyj9XliK+w2/0tI9AffDFJK55Js4U2f3jlzfvKmINAbxWzAnQ2RgqzkK5X+0MDRnJOU8Pzt2XQK7+UqOT10ScZqAHfhvogBlVnlkb6NH8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nOjqWSTi8dqRWSxylXoTbFPFNKc68E/UXp6mVZs9+qY=;
	h=date:mime-version:subject:message-id:from;

rk3576 has two pcie controller, both are pcie2x1 used with
naneng-combphy.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 111 +++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 8938ec7c3bb4..888af56530e8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1016,6 +1016,117 @@ qos_npu_m1ro: qos@27f22100 {
 			reg = <0x0 0x27f22100 0x0 0x20>;
 		};
 
+		pcie0: pcie@2a200000 {
+			compatible = "rockchip,rk3576-pcie", "rockchip,rk3568-pcie";
+			bus-range = <0x0 0xf>;
+			clocks = <&cru ACLK_PCIE0_MST>, <&cru ACLK_PCIE0_SLV>,
+				 <&cru ACLK_PCIE0_DBI>, <&cru PCLK_PCIE0>,
+				 <&cru CLK_PCIE0_AUX>;
+
+			clock-names = "aclk_mst", "aclk_slv",
+				      "aclk_dbi", "pclk",
+				      "aux";
+			device_type = "pci";
+			interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "msi", "sys", "pmc", "msg", "legacy", "err";
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
+			ranges = <0x00000800 0x0 0x20000000 0x0 0x20000000 0x0 0x00100000
+				  0x81000000 0x0 0x20100000 0x0 0x20100000 0x0 0x00100000
+				  0x82000000 0x0 0x20200000 0x0 0x20200000 0x0 0x00e00000
+				  0x83000000 0x9 0x00000000 0x9 0x00000000 0x0 0x80000000>;
+			reg = <0x0 0x2a200000 0x0 0x00010000>,
+			      <0x0 0x22000000 0x0 0x00400000>,
+			      <0x0 0x20000000 0x0 0x00100000>;
+			reg-names = "apb", "dbi", "config";
+			resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
+			reset-names = "pipe", "p_pcie0";
+			#address-cells = <3>;
+			#size-cells = <2>;
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
+			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "msi", "sys", "pmc", "msg", "legacy", "err";
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
+			ranges = <0x00000800 0x0 0x21000000 0x0 0x21000000 0x0 0x00100000
+				  0x81000000 0x0 0x21100000 0x0 0x21100000 0x0 0x00100000
+				  0x82000000 0x0 0x21200000 0x0 0x21200000 0x0 0x00e00000
+				  0x83000000 0x9 0x80000000 0x9 0x80000000 0x0 0x80000000>;
+			reg = <0x0 0x2a210000 0x0 0x00010000>,
+			      <0x0 0x22400000 0x0 0x00400000>,
+			      <0x0 0x21000000 0x0 0x00100000>;
+			reg-names = "apb", "dbi", "config";
+			resets = <&cru SRST_PCIE1_POWER_UP>, <&cru SRST_P_PCIE1>;
+			reset-names = "pipe", "p_pcie1";
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


