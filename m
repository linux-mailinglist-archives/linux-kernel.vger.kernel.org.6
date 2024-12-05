Return-Path: <linux-kernel+bounces-432966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3A9E5272
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A4C166CCB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207F1D63EE;
	Thu,  5 Dec 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="V7FxV3IW"
Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com [45.254.49.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9811D5AD4;
	Thu,  5 Dec 2024 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394999; cv=none; b=i8dbVpLz+665g8D+2FANplulRopKmQxx+ie+PLzg7ZX93sPF0m4+VJva5CyMFiVNpuLBFbDe5gwGMtucVp06CtFQQHEYWYyf95WW0d6xFnJ3ypW/td10RKggzxNLIAkyw7938vdksc7kLgfN0crn440Tk2rl33G2Coo1mGWwPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394999; c=relaxed/simple;
	bh=z5hAP38ixfML7I/C8knFXpHmeYKXng4WvDOGNEW6tKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXP3mBXyqd1Q3xbpbwZ7XDg7yC0S/sx58wDfSfFB5dnKqbEmLso4/RPEQJ3PrWdjfyEA3iW76eDkVUwv4a2L6nd+GwozxhR1Z/H3O09bxrBLkLy4UqGyHBjGzy5lx/m1n/IHymsL1G+sc7KFPm+oN675G+KsjLuM7kQ4MgURVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=V7FxV3IW; arc=none smtp.client-ip=45.254.49.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cf7c967;
	Thu, 5 Dec 2024 18:36:29 +0800 (GMT+08:00)
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
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dts: arm64: rockchip: Add rk3576 naneng combphy nodes
Date: Thu,  5 Dec 2024 18:36:19 +0800
Message-Id: <20241205103623.878181-3-kever.yang@rock-chips.com>
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
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkMeH1ZOQkpMSRhIQxhCGkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a939664827203afkunm4cf7c967
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogg6HAw5LjIfQg0RHy5JCxkd
	Hx5PCzdVSlVKTEhISEJPQkJLQk1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0pLNwY+
DKIM-Signature:a=rsa-sha256;
	b=V7FxV3IWdqlMRwcrHv/JZXj4IxrNmMzuj8ZcM4AszMNfJgsMw2Opm2AqMxrkCI0yA3gXdga2/A53QjBUXQ8LicrvTNrkEM9I7iqrcpTy9Buz12pbzVQZ/6VbFDl4OTDXbMLbUzcbcH8fa9oJvHJF7rgxmNbY1vvzKMNbQVYbtDI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=67jtnZdAqgZmsIdKecCH4vXI2Gu7dBBbAbO28nvPUW0=;
	h=date:mime-version:subject:message-id:from;

rk3576 has two naneng combo phy,
- combophy0 is used for one of pcie and sata;
- combophy is used for one of pcie, sata and usb3;

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 436232ffe4d1..8938ec7c3bb4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1587,6 +1587,42 @@ uart11: serial@2afd0000 {
 			status = "disabled";
 		};
 
+		combphy0_ps: phy@2b050000 {
+			compatible = "rockchip,rk3576-naneng-combphy";
+			reg = <0x0 0x2b050000 0x0 0x100>;
+			#phy-cells = <1>;
+			clocks = <&cru CLK_REF_PCIE0_PHY>,
+				 <&cru PCLK_PCIE2_COMBOPHY0>,
+				 <&cru PCLK_PCIE0>;
+			clock-names = "refclk", "apbclk", "pipe_clk";
+			assigned-clocks = <&cru CLK_REF_PCIE0_PHY>;
+			assigned-clock-rates = <100000000>;
+			resets = <&cru SRST_P_PCIE2_COMBOPHY0>,
+				 <&cru SRST_PCIE0_PIPE_PHY>;
+			reset-names = "combphy-apb", "combphy";
+			rockchip,pipe-grf = <&php_grf>;
+			rockchip,pipe-phy-grf = <&pipe_phy0_grf>;
+			status = "disabled";
+		};
+
+		combphy1_psu: phy@2b060000 {
+			compatible = "rockchip,rk3576-naneng-combphy";
+			reg = <0x0 0x2b060000 0x0 0x100>;
+			#phy-cells = <1>;
+			clocks = <&cru CLK_REF_PCIE1_PHY>,
+				 <&cru PCLK_PCIE2_COMBOPHY1>,
+				 <&cru PCLK_PCIE1>;
+			clock-names = "refclk", "apbclk", "pipe_clk";
+			assigned-clocks = <&cru CLK_REF_PCIE1_PHY>;
+			assigned-clock-rates = <100000000>;
+			resets = <&cru SRST_P_PCIE2_COMBOPHY1>,
+				 <&cru SRST_PCIE1_PIPE_PHY>;
+			reset-names = "combphy-apb", "combphy";
+			rockchip,pipe-grf = <&php_grf>;
+			rockchip,pipe-phy-grf = <&pipe_phy1_grf>;
+			status = "disabled";
+		};
+
 		sram: sram@3ff88000 {
 			compatible = "mmio-sram";
 			reg = <0x0 0x3ff88000 0x0 0x78000>;
-- 
2.25.1


