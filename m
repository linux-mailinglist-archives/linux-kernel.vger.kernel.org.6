Return-Path: <linux-kernel+bounces-553437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6DA58997
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386661692A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC5BE6C;
	Mon, 10 Mar 2025 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="eHPZ7Sgz"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A3BA3D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565593; cv=none; b=a/rBZc6OyOPp8c1E0WKGMNdqC6Ml5lGQZF4l/hBDAyy8Ne084i+GJae6aub2k0yeCSTEdYbo0R5PtWBxF5/J7tY5XBd27qheKtHC1Nj+E2lkMzoYJebm2hNd6RS0OfIv6RpzjGaelL1zPtEa/1QD6CL+enD/hDglvovWP8RCK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565593; c=relaxed/simple;
	bh=JJr8VGiStJuZ/9IIRdfs96Ide6Bv6cWnArzpa3My7vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyBhJsvJDGD1kFrn5Uqv+t46H46bwiO7mZPfaJ4Q4XICVZGNQ7wUMNkPGYtFGMSaYWqmgKqL3jbuZFdLcRWzsL4vOCNfhHHhCrp4BLcbEseccJIG4uYaSM4UZVMTZgsh99k9jOY0RVr6mHSW9i1jAhEIMN8NmcVe0kdSZOPJVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=eHPZ7Sgz; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741565591; bh=2XkeNvTS3SSQVo18wjKfb+aIkG+6ibmdSyCn5Cfxy74=;
 b=eHPZ7SgzqJWSSks5y/pZ/30iLzqiK5+5J39s7ZUNFK3UlymJ93cluoqAIPdVT54EwpXB0W+qY
 6udTARxazpxiC0wfbSg33Hb1Z9Bmsp6c9bNQKC1nERqH67jRcSqD7Z653dNu0UIBcJUMwJbsgWl
 Je9yB8LO0bTLUqp4VC4OQr5PtG9JVUDVAPZdmd5GEqz3Ue9T3ADwzR+2x0jkz9rVU1aKJxSA/fL
 GaPYXS4L8N5rxd//rC8Li7xumrAuAbwkOwH2+JFma54XrGh7zniamPfp73Ji7YvxkV/nbCoijtZ
 LgZg5rurKj1JOTospufnkBGwTJeLCRpJKt7lRerXbmoA==
X-Forward-Email-ID: 67ce2e93f812de2512d1f55a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/2] arm64: dts: rockchip: Add GMAC nodes for RK3528
Date: Mon, 10 Mar 2025 00:12:50 +0000
Message-ID: <20250310001254.1516138-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310001254.1516138-1-jonas@kwiboo.se>
References: <20250310001254.1516138-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
Ethernet QoS IP.

Add device tree nodes for the two Ethernet controllers in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Add ethernet-phy@2 for the integrated PHY

I have no board that expose an Ethernet port for the gmac0 and the
integrated PHY. However, the PHY can be identified on addr 0x2 as
0044.1400 and in vendor kernel this relate to the Rockchip RK630 PHY.
A proper PHY driver will be needed to support real use of gmac0.
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 105 +++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 4c0a25cc089c..56ced7c640f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -678,6 +678,111 @@ saradc: adc@ffae0000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@ffbd0000 {
+			compatible = "rockchip,rk3528-gmac", "snps,dwmac-4.20a";
+			reg = <0x0 0xffbd0000 0x0 0x10000>;
+			clocks = <&cru CLK_GMAC0_SRC>, <&cru CLK_GMAC0_RMII_50M>,
+				 <&cru CLK_GMAC0_RX>, <&cru CLK_GMAC0_TX>,
+				 <&cru PCLK_MAC_VO>, <&cru ACLK_MAC_VO>;
+			clock-names = "stmmaceth", "clk_mac_ref",
+				      "mac_clk_rx", "mac_clk_tx",
+				      "pclk_mac", "aclk_mac";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			phy-handle = <&rmii0_phy>;
+			phy-mode = "rmii";
+			resets = <&cru SRST_A_MAC_VO>;
+			reset-names = "stmmaceth";
+			rockchip,grf = <&vo_grf>;
+			snps,axi-config = <&gmac0_stmmac_axi_setup>;
+			snps,mixed-burst;
+			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+			snps,tso;
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+
+				rmii0_phy: ethernet-phy@2 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0x2>;
+					clocks = <&cru CLK_MACPHY>;
+					phy-is-integrated;
+					pinctrl-names = "default";
+					pinctrl-0 = <&fephym0_led_link>,
+						    <&fephym0_led_spd>;
+					resets = <&cru SRST_MACPHY>;
+				};
+			};
+
+			gmac0_stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <0 0 0 0 16 8 4>;
+				snps,rd_osr_lmt = <8>;
+				snps,wr_osr_lmt = <4>;
+			};
+
+			gmac0_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac0_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <1>;
+				queue0 {};
+			};
+		};
+
+		gmac1: ethernet@ffbe0000 {
+			compatible = "rockchip,rk3528-gmac", "snps,dwmac-4.20a";
+			reg = <0x0 0xffbe0000 0x0 0x10000>;
+			clocks = <&cru CLK_GMAC1_SRC_VPU>,
+				 <&cru CLK_GMAC1_RMII_VPU>,
+				 <&cru PCLK_MAC_VPU>,
+				 <&cru ACLK_MAC_VPU>;
+			clock-names = "stmmaceth",
+				      "clk_mac_ref",
+				      "pclk_mac",
+				      "aclk_mac";
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			resets = <&cru SRST_A_MAC>;
+			reset-names = "stmmaceth";
+			rockchip,grf = <&vpu_grf>;
+			snps,axi-config = <&gmac1_stmmac_axi_setup>;
+			snps,mixed-burst;
+			snps,mtl-rx-config = <&gmac1_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac1_mtl_tx_setup>;
+			snps,tso;
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+			};
+
+			gmac1_stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <0 0 0 0 16 8 4>;
+				snps,rd_osr_lmt = <8>;
+				snps,wr_osr_lmt = <4>;
+			};
+
+			gmac1_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac1_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <1>;
+				queue0 {};
+			};
+		};
+
 		sdhci: mmc@ffbf0000 {
 			compatible = "rockchip,rk3528-dwcmshc",
 				     "rockchip,rk3588-dwcmshc";
-- 
2.48.1


