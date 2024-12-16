Return-Path: <linux-kernel+bounces-446770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B96339F28EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0B8188482C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871AE1C5480;
	Mon, 16 Dec 2024 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="F4cxOSLM"
Received: from mail-m83156.xmail.ntesmail.com (mail-m83156.xmail.ntesmail.com [156.224.83.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9B156641;
	Mon, 16 Dec 2024 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734320915; cv=none; b=uIrFEdRtk1iDr2hiUiBKysRcpTVNcLIe588D6s01HJBMGk+5SYO4thmaR6jw4RAWWB5auBRgjwpOSOp1B3qFpYklC7zrGEERc70UUR9iceXnUdCDBuNtYf4ZUz66FAnkpLgM88/JRzJ34ubHxzed7fkGqhXCmikQgMRwdOJmOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734320915; c=relaxed/simple;
	bh=PM4yTMtaMUck0TYTcwal4HQsa5jjZWJfFFvIZ5YlQIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLftSp6A8NY9WSW48KY2k3+wmbT1hcyH3e8en6WfhaEo49n4bzvn3u5H4YSqSs4yK7wtr4hYYtrwMDCGLzkMdZlwp2Q2DZ/Cn3QLQCjlNoanbNjglnNUUf+9l8bkZrbhl5Gsd4mIm8Xu9rK5oTFlkotAXV0i58ofuCIvrBKHn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=F4cxOSLM; arc=none smtp.client-ip=156.224.83.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5cf79933;
	Mon, 16 Dec 2024 11:13:05 +0800 (GMT+08:00)
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
Subject: [PATCH v2 09/11] arm64: dts: rockchip: Add eDP0 node for RK3588
Date: Mon, 16 Dec 2024 11:12:23 +0800
Message-Id: <20241216031225.3746-10-damon.ding@rock-chips.com>
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
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksZHVZNGklLHR0dSkJOTRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93cd7483d503a3kunm5cf79933
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogg6Nzo6MzIQCCFRMk8ZQhU*
	ETFPCxdVSlVKTEhPSEpDTENMS0NNVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSENONwY+
DKIM-Signature:a=rsa-sha256;
	b=F4cxOSLMwhE7w8kn8LwmhxNedBlJDMzDzW77KlN7bRWoGWd8KrkNep/TBVLmB8K3Um83oqRHk7O1LNJGpqBOOQM8efoTxgWw9CzvgTaxekt6s7qKJeITwInd04KEPafROuvqaPaD4ARwDbCoW4hafFPyikd/kQbcC5qNTuLX2Aw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=YkGooVOVJx6yYNNnxIeU/aJeQgP9uUa6dfCqmnhn2Y0=;
	h=date:mime-version:subject:message-id:from;

Add support for the eDP0 output on RK3588 SoC.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 7e125897b0cd..240b0103c957 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1411,6 +1411,35 @@ hdmi0_out: port@1 {
 		};
 	};
 
+	edp0: edp@fdec0000 {
+		compatible = "rockchip,rk3588-edp";
+		reg = <0x0 0xfdec0000 0x0 0x1000>;
+		clocks = <&cru CLK_EDP0_24M>, <&cru PCLK_EDP0>, <&cru CLK_EDP0_200M>;
+		clock-names = "dp", "pclk", "spdif";
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>;
+		phys = <&hdptxphy0>;
+		phy-names = "dp";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_EDP0_24M>, <&cru SRST_P_EDP0>;
+		reset-names = "dp", "apb";
+		rockchip,grf = <&vo1_grf>;
+		#sound-dai-cells = <1>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp0_in: port@0 {
+				reg = <0>;
+			};
+
+			edp0_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	qos_gpu_m0: qos@fdf35000 {
 		compatible = "rockchip,rk3588-qos", "syscon";
 		reg = <0x0 0xfdf35000 0x0 0x20>;
-- 
2.34.1


