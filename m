Return-Path: <linux-kernel+bounces-527700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DABA40E49
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A1C176FDE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF3C205E3E;
	Sun, 23 Feb 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VVmqJyzQ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9261FFC6D;
	Sun, 23 Feb 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310284; cv=none; b=Q7/zRVZ2nSBzeK1Qkb54yAyrMg3xH2zCunjFVDe34AdHZZ8n5tbyW4DtkrbtScEM4yrKbNSmA/aj+5ozuVDZsF6kv9DT7PD/pkbu+u8EAvy2+f/7DYpSDojgKV7JB4Zq7LdcLqv3OU6CgtrJYZ22pgbgqWqyqeYUsH8OHz8hq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310284; c=relaxed/simple;
	bh=snprIamXvsTMrdnSU3SXP4U8J12bV9/w6EC0/NXObe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZWxtfnFVy43lZi8n+knnOM5qHTdhd3uedDwAEPcszAp+mdQ4V5zrmbEoROXZi3PN6YHAxbZNjGjUE8NEqZXbd2LRk/SLOJnF1ngTNBRNbghLsLQ/HYParuRJCXRfwYuVZxwLEJ6Or/+TXiI3oFl08UaI4LHxMvtHL5RsvXvGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VVmqJyzQ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=vmnv2
	MhbHUJhpP+7UCIFUQTwEEWv5QErRDdciQ4T95E=; b=VVmqJyzQ+OBTXAwtKh6dy
	SAB5iOxlJf3AWx1AQCgxIGqVukVC+ytt1gR7heJ6BLZO23TWPB1sUx82TU9Jd8u/
	tmvpMDNYBCpp1oyLxXUWL1UajWdBB4CP27iGMS0P7MyDj5lyxyCn9490+IQyGTs5
	e8nFt643mou9w/XzZoHW3c=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHWqbdBrtnleHpAg--.47651S7;
	Sun, 23 Feb 2025 19:30:48 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	mripard@kernel.org,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 5/6] arm64: dts: rockchip: Add DP1 for rk3588
Date: Sun, 23 Feb 2025 19:30:28 +0800
Message-ID: <20250223113036.74252-6-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223113036.74252-1-andyshrk@163.com>
References: <20250223113036.74252-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBHWqbdBrtnleHpAg--.47651S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWDCry7tFWfJw17JFWxCrg_yoW8Xw1xpw
	nrurZ3Wry8WFy2q39xt3s5Xr95A3Z5Aa9rKr1xGa4UKr1Sqryqkr1a9rn3Ca4UXr4UXwsF
	kF43Jry8KFsFvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXjjkUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBT8Xme7BHQlkgAAsF

From: Andy Yan <andy.yan@rock-chips.com>

The DP1 is compliant with the DisplayPort Specification
Version 1.4, and share the USBDP combo PHY1 with USB 3.1
HOST1 controller.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 .../arm64/boot/dts/rockchip/rk3588-extra.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 4a950907ea6f..427d2a39f79a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -135,6 +135,36 @@ i2s10_8ch: i2s@fde00000 {
 		status = "disabled";
 	};
 
+	dp1: dp@fde60000 {
+		compatible = "rockchip,rk3588-dp";
+		reg = <0x0 0xfde60000 0x0 0x4000>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DP1>, <&cru CLK_AUX16M_1>,
+			 <&cru CLK_DP1>, <&cru MCLK_I2S8_8CH_TX>,
+			 <&cru MCLK_SPDIF5_DP1>;
+		clock-names = "apb", "aux", "hdcp", "i2s", "spdif";
+		assigned-clocks = <&cru CLK_AUX16M_1>;
+		assigned-clock-rates = <16000000>;
+		resets = <&cru SRST_DP1>;
+		phys = <&usbdp_phy1 PHY_TYPE_DP>;
+		power-domains = <&power RK3588_PD_VO0>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dp1_in: port@0 {
+				reg = <0>;
+			};
+
+			dp1_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	pcie3x4: pcie@fe150000 {
 		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
 		#address-cells = <3>;
-- 
2.34.1


