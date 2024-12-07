Return-Path: <linux-kernel+bounces-436189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488D9E824B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04884281C26
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BFD19049B;
	Sat,  7 Dec 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h1J9Wef4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56361146A60;
	Sat,  7 Dec 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733607183; cv=none; b=r2WT71D4CiC6SBLxnPyh2X3mEFzpovHfNEuon1ciR/WeP7KkvsY8p0VYu5T2fRG98PmPT2F0vknukQMm2VpQFeFd8ENLcugS9EkrSUjyycqByUVZNW4pkZv9R1+n5FkjxQMAlwsyzWmghn4ge3tJ+imjs2P33CzXivLdhyEJOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733607183; c=relaxed/simple;
	bh=DuquKXFrrFxNB+/27gdv/HCQ8M7uGVTRTKsJMPlOXKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQ/nL5PWlIWg2x53kxkzUektjDTOKJR3aNRuLCg1dzr1yOxKK/j76EWdxJQRZhMZDmIVA5MaakUvnNzsAn0lyTucSPrrqFk8k1ZPY3Lj4IUK31MJA9yXziLdo+ImuT4AJxIlaI1voy7b+gnZ5N4VbwXl7fIOBpHTO9c6XTXMitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h1J9Wef4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733607173;
	bh=DuquKXFrrFxNB+/27gdv/HCQ8M7uGVTRTKsJMPlOXKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h1J9Wef4KeKI4JXzeuvLmnYTV77d0z+0e53Y7dExy+ffZBBtoZ+ZWccb8AhIo4Tii
	 /J197bavNgzrDkOI20AXfASZnQlasP92u3PtCqnRcl7Hyps77Xvqh2vlw1v0TuzQ5X
	 ppU5eSnwsdlCgTVFPGi+q+obBOIiEikQQigUblX3soAZ4GEB7ektNn+z2atE1723rr
	 H93k3dglMbnFiFcYeVb2Kw7KusCPdyOweoirhTqiyhiWsriyil2ScA/r5XbxV7D7MV
	 8UPMCVrUZ6eTwEfvBcdkYpVsNtdxPIyJSeX6X4e5mk5AXLiZk0cpIb9aGfH5LcUNZs
	 M5uXnb5ZqnfCQ==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C53117E3803;
	Sat,  7 Dec 2024 22:32:53 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 07 Dec 2024 23:32:25 +0200
Subject: [PATCH 2/4] arm64: dts: rockchip: Add PHY node for HDMI1 TX port
 on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-rk3588-hdmi1-v1-2-ca3a99b46a40@collabora.com>
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

In preparation to enable the second HDMI output port found on RK3588
SoC, add the related PHY node.  This requires a GRF, hence add the
dependent node as well.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 0ce0934ec6b793af45585f67d5312434d80357de..68fa9806164776cef8732bb776e958003779ba28 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -67,6 +67,11 @@ u2phy1_otg: otg-port {
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
@@ -395,6 +400,22 @@ sata-port@0 {
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
2.47.0


