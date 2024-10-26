Return-Path: <linux-kernel+bounces-383025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5C9B164E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB2A1F228D9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692501D0E23;
	Sat, 26 Oct 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lkCWm1gJ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D941C6F47
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729930811; cv=none; b=jY2Q3nJSZMef1U3ogR88IvKRjMx1Lg8EW7qx5c6GMTFCKVgg7+KV+x2Saml+AyzdLNZbt9GTIFAJtH7eee3+Q7NduNADUPH4PYq/4N7w7OYffbje8i+Vp5BxZnetSPQdRS52sEbSxS1weGt2A0MBnyUlpw1nFwFO8D04Ys8Wyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729930811; c=relaxed/simple;
	bh=4t/oXSMBrctWDNJczJM/urThoYT0PYG/lTjjcmivTHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxuqJLnSrCGPFsUXUN8GgqgiHGePK5e0m1lSfjYTeGtbhTeVvaDdgPIVxVsgOMPcE5xl+XlEcofoSvR9jUPNjdAU9+iDwwXCyOD/EzRouxdgbpRSanRlVkO8hDJFgyNEcHcs+76s6J0EO/Jb9BSaVsU0DB04dFdW55D1Ee+G4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lkCWm1gJ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=50erL
	DHaCcD3189jmEiSuXIG5d+DYHBnUbc/wg7QSIQ=; b=lkCWm1gJaG9Vp1z/1Q5v2
	gdHxxlQ+kjBp79vpNhrG+rOP2oB2PVol7pSXVATs/I9JYZIuUarKjKplo6lWBCZ6
	KliH8hkHC7j+akeJczvVxrERzeKrl6lf0HxwDR6VgGy+trdqNN2lvFHX9GFuRkqy
	Sqx3sV/FxkFXsA43u6V4Ck=
Received: from ProDesk.. (unknown [103.29.142.67])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v9wkphxnW2U0Dg--.30094S3;
	Sat, 26 Oct 2024 16:19:53 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 1/3] arm64: dts: rockchip: Enable HDMI0 for rk3588 Cool Pi CM5 EVB
Date: Sat, 26 Oct 2024 16:19:26 +0800
Message-ID: <20241026081942.348459-2-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241026081942.348459-1-andyshrk@163.com>
References: <20241026081942.348459-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v9wkphxnW2U0Dg--.30094S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3ur13Xry3tw18Cw1kuFg_yoW8Ar4fp3
	ZxurZ5WFZ3Way2yw4ayFn7tFnYyrs5urWfG343ZFyxtr4agFnYyw1UWwn2vFyDAFZrZayx
	CF1kJF1j9r1qqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_Q6pfUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxuEXmccoZRKCAABs-

As the hdmi-qp controller recently get merged, we can enable the
HDMI0 display on this board now.

Signed-off-by: Andy Yan <andyshrk@163.com>

---

 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
index a4946cdc3bb3..2d7feb88aeeb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588-coolpi-cm5.dtsi"
 
 / {
@@ -22,6 +23,17 @@ backlight: backlight {
 		pwms = <&pwm2 0 25000 0>;
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
+	};
+
 	leds: leds {
 		compatible = "gpio-leds";
 
@@ -214,3 +226,40 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&hdmi0 {
+	enable-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+	pinctrl-0 = <&hdmim0_tx0_cec &hdmim0_tx0_hpd &hdmim0_tx0_scl &hdmim0_tx0_sda>;
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
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
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
2.43.0


