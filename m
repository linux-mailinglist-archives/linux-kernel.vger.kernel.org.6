Return-Path: <linux-kernel+bounces-372762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A929A4CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 12:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CBC1C21802
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E21DE4EE;
	Sat, 19 Oct 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m3gfqr5a"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9E1DFE2A;
	Sat, 19 Oct 2024 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729332770; cv=none; b=c1FetjjmEd1YCJqBXmfGxcZ0r6oNkNPfmguLSC5/feSy/EsP9c6Ao/WG4ZA4RD04V/X8w9LgNjyUSE5FHsbxMX4et5K8bwYSdMsj0bXt4Oj3yIioBeMqxH0IOI5oodpG29OIj3BuQhRzOeg3N8nSyIncsSjwF14tUcSpnzhug4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729332770; c=relaxed/simple;
	bh=bQ/pqBqAd3mTtFhL5mhMd/smH96L9EiLiAGK0FH/78Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUTAhMVrdv+tE0olCLeFFAf6Yvsqba0NMTLJMCvjpqOmoWhLTI5E+hTB8NoTnLBNGrZIR+mEAdUhsHcvKa/ym1DTsnfvF+69B/qiQI3SRizpAnkrLZYMucNpuEifQRlci0xCLLbp43Gd3MBVjCaAehAAfC30Wfmg0nA9MIeR7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m3gfqr5a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729332766;
	bh=bQ/pqBqAd3mTtFhL5mhMd/smH96L9EiLiAGK0FH/78Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m3gfqr5aVc1ZmI9H+PXzf+sgN6wm+BiKPkTXnPDZ+Jj7t70ZRxa31xnEuI+CFUDI1
	 ZpqbdUgvZ/F0C0Ygwf1+QRKK6Vshw9m2j2di3eFjP4lJKeoU2w3YsBReEY4gCV6pyK
	 /OPRrTgqXHyx60ZuG/PSE+Yg1pZed56LP8zfYwEea8Mpc6RERxqh0TOukrcj9Zz+AC
	 oVpMHsM8gPuE1fp/x1yQ6hpzyncUUy/yWhimS5xwF5ZmQ/Ee6WDsOVXqGGerbGhV6/
	 kcoX0c8VyHfVusmOJpHBW3Yn5OPLkkVlXr2JLS/zlAuKie3Xm5gnrZ2/UrWVjNrEJQ
	 Od/QtfgjM15sA==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D7DA17E14FB;
	Sat, 19 Oct 2024 12:12:46 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 19 Oct 2024 13:12:14 +0300
Subject: [PATCH v2 5/5] arm64: dts: rockchip: Enable HDMI0 on rock-5a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-rk3588-hdmi0-dt-v2-5-466cd80e8ff9@collabora.com>
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
In-Reply-To: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add the necessary DT changes to enable HDMI0 on Radxa ROCK 5A.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 87fce8d9a964cd53d179ce214ae1c0ff505a2dce..2b141af5e709b0bc2193dbfb2327e6bc1fdaa502 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -5,6 +5,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588s.dtsi"
 
 / {
@@ -35,6 +36,17 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	hdmi0-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi0_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -296,6 +308,31 @@ &gmac1_rgmii_clk
 	status = "okay";
 };
 
+&hdmi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmim0_tx0_cec
+		     &hdmim1_tx0_hpd
+		     &hdmim0_tx0_scl
+		     &hdmim0_tx0_sda>;
+	status = "okay";
+};
+
+&hdmi0_in {
+	hdmi0_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi0>;
+	};
+};
+
+&hdmi0_out {
+	hdmi0_out_con: endpoint {
+		remote-endpoint = <&hdmi0_con_in>;
+	};
+};
+
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
 &mdio1 {
 	rgmii_phy1: ethernet-phy@1 {
 		/* RTL8211F */
@@ -788,3 +825,18 @@ &usb_host1_ohci {
 &usb_host2_xhci {
 	status = "okay";
 };
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};

-- 
2.47.0


