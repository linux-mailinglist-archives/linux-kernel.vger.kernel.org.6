Return-Path: <linux-kernel+bounces-383022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 659699B164B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188011F2277B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A81CEABB;
	Sat, 26 Oct 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YkmEuXK/"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BF18562F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729930810; cv=none; b=YVi4Y89uQ9EqUNZwnXt9EpFc59Xzcy9SAlmilFRZjgupD53gY7fIxdVR8V/wqwzKCoyIqRattJMljIRIoSPgSS/Q6JYUkEzA/6atfr05ag8GWMY3u3bmkKg/fsjMt4MOxyvqSvS8BsRWbZV8b8b+K/RY2MB94Ho3Nv70T44Rxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729930810; c=relaxed/simple;
	bh=dBx4SRP9clfS/XD+QGnFZXjYGcqTUMXEXFiT/jMcpbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9Wmx1GAuIASzIPlgg7v2Vb5SiOE5vM/RYZQaa24Hawz3+qjp0Mt+0rFCjVwoeic+de5xCll3cRXwzfJpcz7J9coQqWeO3v10cJlJdHfEbX52GxiUgo6OblJbnPiNzp5p4U7zjFFpf/XXLh51vtop8we4qr22AyQY0RX99bFADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YkmEuXK/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=XjxDe
	o6zOYxngA2g8fuyB76jH3rCT3r+Uwoyt6rnH+w=; b=YkmEuXK/CKkH+XsNFygVi
	UoGVVYuNqbIiwmwRf4/NnsoRn15Ai6wZB2YWE4jqeILLZKo+0yeWQTCWQW9nP5Sx
	L/dgmAFr/iVAtpdqroil8dhQCvrRld7HcqlyUsGxbh7L6YTdBcnMUwXbDE7cifts
	EhuzkBWRrb6N5ijB/omY20=
Received: from ProDesk.. (unknown [103.29.142.67])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v9wkphxnW2U0Dg--.30094S5;
	Sat, 26 Oct 2024 16:19:54 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi GenBook
Date: Sat, 26 Oct 2024 16:19:28 +0800
Message-ID: <20241026081942.348459-4-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3v9wkphxnW2U0Dg--.30094S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFW3Kw15Cr4Uuw1DWFy5XFb_yoW8Ar45p3
	Z7CrZ5GFZ7WrW3JwsxAFyxAFs8trsY9FWfGryfZFy7KrsIqFn5twn7Grn2vFyDAFWxZw4f
	CFykJFyj9r1qvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UUcTdUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMx2EXmccoZRKMAAAsA

Enable hdmi display output on Cool Pi GenBook.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
index 6418286efe40..8958056105b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588-coolpi-cm5.dtsi"
 
 / {
@@ -35,6 +36,18 @@ charger: dc-charger {
 		gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
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
+
 	leds: leds {
 		compatible = "gpio-leds";
 
@@ -347,3 +360,41 @@ &usb_host1_xhci {
 	dr_mode = "host";
 	status = "okay";
 };
+
+/* HDMI CEC is not used */
+&hdmi0 {
+	enable-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+	pinctrl-0 = <&hdmim0_tx0_hpd &hdmim0_tx0_scl &hdmim0_tx0_sda>;
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


