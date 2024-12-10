Return-Path: <linux-kernel+bounces-440490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E7B9EBF02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEED41887E22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22295216E0B;
	Tue, 10 Dec 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kjQ57PZ4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD1F1AAA2F;
	Tue, 10 Dec 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872037; cv=none; b=bvxkZdW0RgwxqACey4x6ERSgnOk0bfufqHvTbbYrhFjR4SZLsBnJgzL3qn1VjGoJ4vwf5IBDgeJW7N0HG0gPStMtX7C2oYvHQYfG4OT7l3tkQq+4WI3deRP8G7uPhihhYHy3hjfNVMcIeTBZ39Du3MFHDBR9lJsuIRR/0hGAhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872037; c=relaxed/simple;
	bh=Nafq+FLCBEcpE333sXMCjOF7hSfZUxcTRNgOL/SHq2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsLCEhTFj8t+sY6GwotpgHoORnJioc1lNFBepX9/s2/Pz6FLAELWAwQ3bAvlOfOIvKGOBL6mC6ICnj0NDzNqfKaYh9vW/GgY/Jggq+MIcWdVWwe4X1Sx+yWudWeOhT9BR4PF3z0pRuMwnvtP2eI/uu34tHgO7rKjdUjFK3j7fUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kjQ57PZ4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733872034;
	bh=Nafq+FLCBEcpE333sXMCjOF7hSfZUxcTRNgOL/SHq2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kjQ57PZ4XNQ3xx4SYyTjQKtBu8hLrTRgqBgkIPXTOF+XiSf9qX/ktWfitaJXxEpxc
	 gdK4OP/CWmC0A7Kmwh2IBM2E/iwHWagb9OsKYIRt/Yc5Wxe6y9PZTXAofXGbeR+9qH
	 NT+MARhCS7gSR2L4I4tu9pu8YchlmZxJPyhEpzMSYQKOFDO0jeHlpOR8eTLa3crb3T
	 CXnPXw+V/gFMatppJOd783nwGNo9Ie7IMqNkOqYrsj1joy1JVfYJZXvnKbnuCdm/3g
	 M6xTo8O0Q9cDrlXfd1HhO4e4np86vdTJwbnyk6SgjCASO7ziKITshwP0MATHjPCstW
	 KfLK0ZMmcsEvw==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D789D17E09C3;
	Wed, 11 Dec 2024 00:07:13 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 11 Dec 2024 01:06:16 +0200
Subject: [PATCH v2 3/4] arm64: dts: rockchip: Add HDMI1 node on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-rk3588-hdmi1-v2-3-02cdca22ff68@collabora.com>
References: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
In-Reply-To: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alexandre ARNOUD <aarnoud@me.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
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


