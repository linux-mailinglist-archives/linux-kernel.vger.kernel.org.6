Return-Path: <linux-kernel+bounces-384935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B403E9B305E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E695A1C2139E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802691DA0ED;
	Mon, 28 Oct 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dZPxq51+"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31D18E03A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118925; cv=none; b=Gvwjpu+ZjlvzIW3O0EEiAmdsszwfQR9RL5E6bKCJZeGOWb/FEn+Y4WzpdUOiuyEofVc9VQB27iAZ/qC5MClNZl6PuUehJjj/hchddBftYivTeBo5xieM5nqJNIMxVMrLXwaiggdjRYPHRJvaf4VJVrv9lIs1KiW/H2JI8d4JT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118925; c=relaxed/simple;
	bh=EcyrQPDgthkfdEcc10o2egX30s4Dev+MVbzErqEZlwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+eLcRahyN16KZ51VAWVpULSFwGM3vI2pBw7jyMPZH5u7yM6WTdk/40TdU0LN4NsDchCqTCgQlhje4OaXMVNNIteaNgiQykKcZO8NhXE0SC2pwUiJ7bletjCfjSSiOUc5D5R3RICBW6w9dqkMB5MnnmOoRORYfLX0XqI4eP1Jc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dZPxq51+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=sGXAv
	ZN6OzVPvAHYYKDVulgxFxNefKXk3I0OnEojRD0=; b=dZPxq51+r33wrg9bHdss3
	PnWA0Q7hx5WgDht40418kF2nMK7IV4uYviEUm1l+5KMScDVcjTKwpCTy1OVSVpe8
	VAOaL6LL8ZXws0y3/NwLDC0Wuh/0Vn2a49Wvm0n63ADC6CieKQOawmKp/hQqHEvm
	JlGgice12QzMkznHnQO0cs=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3f+b5hB9nytgkBw--.9113S4;
	Mon, 28 Oct 2024 20:35:09 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 2/3] arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi 4B
Date: Mon, 28 Oct 2024 20:34:57 +0800
Message-ID: <20241028123503.384866-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028123503.384866-1-andyshrk@163.com>
References: <20241028123503.384866-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+b5hB9nytgkBw--.9113S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyrGFWfAw4xCFW7tr1fJFb_yoW8Ww43p3
	ZrurZ5GrZ3urW7XwsxAF1xJrsYyws5CayxGw13ZFy3tr42gas5tw1xGrnYvFyDAFWxZ3y3
	Cr1kJFyq9r4UXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziNVy3UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRGGXmcffS5+9gAAsD

Enable the micro HDMI on Cool Pi 4B.

Signed-off-by: Andy Yan <andyshrk@163.com>

---

Changes in v2:
- Remove enable-gpios as it is unevaluated
- Remove pinctrl setting as it use the default

 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 074c316a9a69..27a89a110085 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588s.dtsi"
 
 / {
@@ -38,6 +39,17 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "d";
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
 		pinctrl-names = "default";
@@ -815,3 +827,38 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&hdmi0 {
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


