Return-Path: <linux-kernel+bounces-372477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C679A4908
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B6A1F23BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA0719007E;
	Fri, 18 Oct 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HtDdSJYm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86C18D65C;
	Fri, 18 Oct 2024 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287625; cv=none; b=W/CUeQF2l7UtLedxzCfAW65IjTgZsiLrbiCiLNejLMvtY/z727mkjiWEv6kQOV8UljbL4e6FJQegeENPdgSeCC5w9L7N3TJdM6tEd0mh3qxMAGN4A2xS+dRVtW/5nrWOsbMfq7r6f+kK0K3pqVHmfbySK9KF508ClABvtowEVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287625; c=relaxed/simple;
	bh=shzTkSVeDAoYPdbpkz2nRxG6xjYT1Tvs40xs92JMLzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAb1+JxDIL07j9kbWIodX1lsjEtLPwj8LnvFTChjV86sC98/vjPgbSfBYNwUY2HsNPRRazBAfjaekzTbel4PTPd/ZlYKSbYGsS990lvxNgdBiQDTs5VakrYqjn0pxwoufI6S4LdGpe2krYbc/gRPIQ9OBimpcDKWu0Ivhvlm7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HtDdSJYm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729287620;
	bh=shzTkSVeDAoYPdbpkz2nRxG6xjYT1Tvs40xs92JMLzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HtDdSJYmu9zPXuzH7jfRr8/dPL6a9kKdttYn4Yjm/Dk/9FmkvbIYJOpXMfvgzAQGR
	 DEgpnCTn9VpynTKE1YG7TmC+I4ty/EoX4OK12WdjxsyaHFuyGeNr8/7wJy9WgMyK9g
	 0VD7z/Fjpb06b1zSHV7YXW/vCRgedGpBI07p+AfXlG+APTuWPdugP6nlNCoM3BmJ9u
	 +Cu7msuxhTzFaRCuR+F7XZrkCViaSjDkSB7oo4Wabf41bfeBlAH96iwF+Kq7q1DvmB
	 KnMUKXrSPPoHOXrS42ArtN88CvwC2+DVqhNweLxoL+gts2ScAjF1iPCxs9XynlXpqB
	 F1aJ6h3KW9Hjw==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AFCA917E375C;
	Fri, 18 Oct 2024 23:40:20 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 19 Oct 2024 00:39:49 +0300
Subject: [PATCH 1/5] arm64: dts: rockchip: Add HDMI0 node to rk3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-rk3588-hdmi0-dt-v1-1-bd8f299feacd@collabora.com>
References: <20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com>
In-Reply-To: <20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add support for the HDMI0 output port found on RK3588 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index fc67585b64b7baa33d5a816517f20c4cb940b52d..a337f3fb8377e4a3a200d4d3a3773a237de2bd6e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1370,6 +1370,47 @@ i2s9_8ch: i2s@fddfc000 {
 		status = "disabled";
 	};
 
+	hdmi0: hdmi@fde80000 {
+		compatible = "rockchip,rk3588-dw-hdmi-qp";
+		reg = <0x0 0xfde80000 0x0 0x20000>;
+		clocks = <&cru PCLK_HDMITX0>,
+			 <&cru CLK_HDMITX0_EARC>,
+			 <&cru CLK_HDMITX0_REF>,
+			 <&cru MCLK_I2S5_8CH_TX>,
+			 <&cru CLK_HDMIHDP0>,
+			 <&cru HCLK_VO1>;
+		clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "avp", "cec", "earc", "main", "hpd";
+		phys = <&hdptxphy_hdmi0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmim0_tx0_cec &hdmim0_tx0_hpd
+			     &hdmim0_tx0_scl &hdmim0_tx0_sda>;
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
+		reset-names = "ref", "hdp";
+		rockchip,grf = <&sys_grf>;
+		rockchip,vo-grf = <&vo1_grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi0_in: port@0 {
+				reg = <0>;
+			};
+
+			hdmi0_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	qos_gpu_m0: qos@fdf35000 {
 		compatible = "rockchip,rk3588-qos", "syscon";
 		reg = <0x0 0xfdf35000 0x0 0x20>;

-- 
2.47.0


