Return-Path: <linux-kernel+bounces-446937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216A9F2B28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFDE163C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88F1FF615;
	Mon, 16 Dec 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ObbzxO3Z"
Received: from mail-m127161.xmail.ntesmail.com (mail-m127161.xmail.ntesmail.com [115.236.127.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3851AAA24;
	Mon, 16 Dec 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335360; cv=none; b=c70fQGYNGIJYhhhZMqBhDtxsWJk4YpIR+jtUwqsXNkA9C+IcXePaKahAIneokxWliqCTHWWgqmfcmAA01+ne+OLvViZP9B35sYICW1eBoBvXsCrbZxi7cssxRZH49iT70FkQ23bJDiHZlfdOXdTddUMC0pBTFOxfTI/XicRu95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335360; c=relaxed/simple;
	bh=FvrLiLtbSDNnfBPjBpN5SkxWu5egWUxGZ/8lK3D4v68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rO9NmQzFOaj8SHro3DGQTi7mULLHgcVJraSgbD9h0bkFYVkGNQayVew/CTo1QUNX5zZ7ZIZdW4IFTI7UoH7qh/7kw5nl0AQoKgE8MeNQkgGe4R8LgJZ679RyhSLgvLgqOmhXx6f09Y9Ej3NuS1pn6MYmi/owy76sotK6raUH2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ObbzxO3Z; arc=none smtp.client-ip=115.236.127.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5cf7993e;
	Mon, 16 Dec 2024 11:13:08 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rfoss@kernel.org,
	vkoul@kernel.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	l.stach@pengutronix.de,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	algea.cao@rock-chips.com,
	kever.yang@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 11/11] arm64: dts: rockchip: Add nodes related to eDP1 for RK3588
Date: Mon, 16 Dec 2024 11:12:25 +0800
Message-Id: <20241216031225.3746-12-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216031225.3746-1-damon.ding@rock-chips.com>
References: <20241216031225.3746-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhkZS1YeT08eGElDT09KQkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93cd7490e403a3kunm5cf7993e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PhQ6NRw5EzIJSSEtFE8#QkIM
	H0swCgFVSlVKTEhPSEpDTEJLT0NCVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0lCNwY+
DKIM-Signature:a=rsa-sha256;
	b=ObbzxO3ZYBIEacGgl+8dc20s4yn7Vp8x/wYPQrPif0dAonoeCtFJil9+Ju3kk7EACCANXJs8opQge2Qmy0JOtib1KTMzGtjZrQ5b4ZGRmkVnzz151+Jwy5UsLL2Qm+Oo7oKeJy+AWQ5sRRDie/jxGyMleyltACy2vhhXKV8fS5Y=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=cAtS5tAFtjz6hZ6HldahUJm+IWPmGZTig9XKH9PZYVc=;
	h=date:mime-version:subject:message-id:from;

The related nodes are hdptxphy1_grf, hdptxphy1 and edp1. And the
aliases edp0 and edp1 are added to separate two independent eDP
devices.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../arm64/boot/dts/rockchip/rk3588-extra.dtsi | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 0ce0934ec6b7..17cc0b619744 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -7,6 +7,11 @@
 #include "rk3588-extra-pinctrl.dtsi"
 
 / {
+	aliases {
+		edp0 = &edp0;
+		edp1 = &edp1;
+	};
+
 	usb_host1_xhci: usb@fc400000 {
 		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
 		reg = <0x0 0xfc400000 0x0 0x400000>;
@@ -67,6 +72,11 @@ u2phy1_otg: otg-port {
 		};
 	};
 
+	hdptxphy1_grf: syscon@fd5e4000 {
+		compatible = "rockchip,rk3588-hdptxphy-grf", "syscon";
+		reg = <0x0 0xfd5e4000 0x0 0x100>;
+	};
+
 	i2s8_8ch: i2s@fddc8000 {
 		compatible = "rockchip,rk3588-i2s-tdm";
 		reg = <0x0 0xfddc8000 0x0 0x1000>;
@@ -135,6 +145,35 @@ i2s10_8ch: i2s@fde00000 {
 		status = "disabled";
 	};
 
+	edp1: edp@fded0000 {
+		compatible = "rockchip,rk3588-edp";
+		reg = <0x0 0xfded0000 0x0 0x1000>;
+		clocks = <&cru CLK_EDP1_24M>, <&cru PCLK_EDP1>, <&cru CLK_EDP1_200M>;
+		clock-names = "dp", "pclk", "spdif";
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH 0>;
+		phys = <&hdptxphy1>;
+		phy-names = "dp";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_EDP1_24M>, <&cru SRST_P_EDP1>;
+		reset-names = "dp", "apb";
+		rockchip,grf = <&vo1_grf>;
+		#sound-dai-cells = <1>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp1_in: port@0 {
+				reg = <0>;
+			};
+
+			edp1_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	pcie3x4: pcie@fe150000 {
 		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
 		#address-cells = <3>;
@@ -395,6 +434,22 @@ sata-port@0 {
 		};
 	};
 
+	hdptxphy1: phy@fed70000 {
+		compatible = "rockchip,rk3588-hdptx-phy";
+		reg = <0x0 0xfed70000 0x0 0x2000>;
+		clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>, <&cru PCLK_HDPTX1>;
+		clock-names = "ref", "apb";
+		#phy-cells = <0>;
+		resets = <&cru SRST_HDPTX1>, <&cru SRST_P_HDPTX1>,
+			 <&cru SRST_HDPTX1_INIT>, <&cru SRST_HDPTX1_CMN>,
+			 <&cru SRST_HDPTX1_LANE>, <&cru SRST_HDPTX1_ROPLL>,
+			 <&cru SRST_HDPTX1_LCPLL>;
+		reset-names = "phy", "apb", "init", "cmn", "lane", "ropll",
+			      "lcpll";
+		rockchip,grf = <&hdptxphy1_grf>;
+		status = "disabled";
+	};
+
 	usbdp_phy1: phy@fed90000 {
 		compatible = "rockchip,rk3588-usbdp-phy";
 		reg = <0x0 0xfed90000 0x0 0x10000>;
-- 
2.34.1


