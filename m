Return-Path: <linux-kernel+bounces-436190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D91F9E824C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450601641CA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB4191F8E;
	Sat,  7 Dec 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Iv3tVR5z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279D14F9CC;
	Sat,  7 Dec 2024 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733607183; cv=none; b=fEpZmYFPG2cERdBfGFVMbZj8cqyMUbaB68xIw6/T6MsvFJfxaUa74OF/hyQ7nsaeE/lzSjeEyFo0nWK9ZNIqy4xIgCyPYFVMWiMhVcTqgkkujFrFJeqfR45EDy8VmEaQwSkeSbmG6YzLBC157Vt88lamAxd2u0KoaJbb84YEuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733607183; c=relaxed/simple;
	bh=Nafq+FLCBEcpE333sXMCjOF7hSfZUxcTRNgOL/SHq2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2Qg2bFmf/J6T9/APjhQ7Nl2kaHBoGEpfBEooGYTkRMG0qHPMPR9Ir7EzeOqaKPRN/IZVuIrvBGIHKVVj2ez33Ar3VvHJz3DwVTs4jOqa6AdeDYQylkruI8Va2u8ZDARurL8EElThi9bvzvD2xezoQfgo9ygwKvUtpHW2L4QbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Iv3tVR5z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733607174;
	bh=Nafq+FLCBEcpE333sXMCjOF7hSfZUxcTRNgOL/SHq2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Iv3tVR5zqj3C2rt7DFnT5VLAgUs1luwwH7JYXAMlTm99x3Q7biM6CxpUbHq3QWDmY
	 +9R9zEFQuYe5e39hwcQMYpHgYZ1zBzWcJZuBnCVAEQgOvBMsER4rGNCz/DzmeWiV4X
	 0xi7xXisSyTu3oCv0TWf345jVN+N8m95aY1yOmZfhbW0c0+eHESEu/6I1vXOr4Xa8D
	 vT+j1tHc1v0KB6GLrwGPV7nBPQf+aohHdXY3AcLiTn6dCHkxDtNRjP8BRgn4PeELrJ
	 +Ikbpe/MwYrEZG9xbwp0B0JWnFZ/AeGgz8AV1dKeRx2f5i/MlNpxQPiSvk3t5uumyV
	 S4AC0gwKsLm4Q==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EE97F17E3805;
	Sat,  7 Dec 2024 22:32:53 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 07 Dec 2024 23:32:26 +0200
Subject: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 node on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-rk3588-hdmi1-v1-3-ca3a99b46a40@collabora.com>
References: <20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com>
In-Reply-To: <20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Add support for the second HDMI TX port found on RK3588 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 68fa9806164776cef8732bb776e958003779ba28..528319908247e90b33f9dbde0516f8bca849676f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -140,6 +140,47 @@ i2s10_8ch: i2s@fde00000 {
 		status = "disabled";
 	};
 
+	hdmi1: hdmi@fdea0000 {
+		compatible = "rockchip,rk3588-dw-hdmi-qp";
+		reg = <0x0 0xfdea0000 0x0 0x20000>;
+		clocks = <&cru PCLK_HDMITX1>,
+			 <&cru CLK_HDMITX1_EARC>,
+			 <&cru CLK_HDMITX1_REF>,
+			 <&cru MCLK_I2S6_8CH_TX>,
+			 <&cru CLK_HDMIHDP1>,
+			 <&cru HCLK_VO1>;
+		clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "avp", "cec", "earc", "main", "hpd";
+		phys = <&hdptxphy1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmim2_tx1_cec &hdmim0_tx1_hpd
+			     &hdmim1_tx1_scl &hdmim1_tx1_sda>;
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_HDMITX1_REF>, <&cru SRST_HDMIHDP1>;
+		reset-names = "ref", "hdp";
+		rockchip,grf = <&sys_grf>;
+		rockchip,vo-grf = <&vo1_grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi1_in: port@0 {
+				reg = <0>;
+			};
+
+			hdmi1_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	pcie3x4: pcie@fe150000 {
 		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
 		#address-cells = <3>;

-- 
2.47.0


