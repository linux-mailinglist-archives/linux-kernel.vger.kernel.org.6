Return-Path: <linux-kernel+bounces-437494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9959E940B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1875282D84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6622758B;
	Mon,  9 Dec 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SvBsaXHY"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60398224893;
	Mon,  9 Dec 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747432; cv=none; b=VUKKbLPtgJVnZfzFIo/xU5ys1jpxyjVIUe1FxuWsSA7OnPOVE/MHfwBJmRt7dJ7HJ55btVP6oHVGFa0jRz4VrdnJm5fWqb6wG/8AbG2JUDxaHPaY1t0QyUMX+VCXXZxXHPDk0G4xfmjIYnPvxEhwgJQxVIvHV9KGYNdHyKtVd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747432; c=relaxed/simple;
	bh=WGtXrteSR8eBDyLPJADvur8ssd4XhEL6DvJZhVbIxgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL+aGf2/dMfuq2JIwg9chGiCPXkugKN9Taa8VaLn81hY5Rk0ocK4m98HlW9z+w9HaTnN6BdmtTvnsOGIgK9sF9nptgZm+Wrdrijx735I1i3QFFvy7WAsVyLYdCf+aocQHd4Yv/zilRkYBLSrzCHqhWDUSa3uhuCyC84JKwka9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SvBsaXHY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=nwbBr
	VKk+dAN+u4ZRk+RUtW0AAay6ePMRzsXnGzmP1w=; b=SvBsaXHYLYaAzuOjMUmxH
	jSgmWuRgIob488bmHIn0DiLCAC7Z7FFlvemmsnrQQC9UvVwbEL9VhMCgqoxprtCZ
	nKG7nre3rl57twrtVHzTQtt86+TTpOdlhAbHw14oRFPsAA6bIY+OdEDshkvz2Y/B
	nFYNaX5JDuDfLm2F2zzsZU=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3Woe44lZnubZICA--.5849S4;
	Mon, 09 Dec 2024 20:29:51 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH] arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi GenBook
Date: Mon,  9 Dec 2024 20:29:12 +0800
Message-ID: <20241209122943.2781431-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209122943.2781431-1-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3Woe44lZnubZICA--.5849S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1ftryDGF17Ar4rGFyrCrg_yoW8Zr1kp3
	ZrZrZ5GFn7urW3JwsxAryxJF15twsYkFW3GryfZFy7Kr47ZF9Yywn7Wrn2vFyDAFWxZ3yf
	CF1kJF1j9F1jvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_R6whUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqR+wXmdW3c3VqgAAsG

Enable hdmi display output on Cool Pi GenBook.

Signed-off-by: Andy Yan <andyshrk@163.com>
Link: https://lore.kernel.org/r/20241028123503.384866-4-andyshrk@163.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
index 6418286efe40d..9ec2374c6cdfa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588-coolpi-cm5.dtsi"
 
 / {
@@ -35,6 +36,17 @@ charger: dc-charger {
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
 	leds: leds {
 		compatible = "gpio-leds";
 
@@ -136,6 +148,28 @@ vcc5v0_usb_host0: vcc5v0_usb30_host: vcc5v0-usb-host-regulator {
 	};
 };
 
+/* HDMI CEC is not used */
+&hdmi0 {
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
 &i2c4 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -347,3 +381,18 @@ &usb_host1_xhci {
 	dr_mode = "host";
 	status = "okay";
 };
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
2.34.1


