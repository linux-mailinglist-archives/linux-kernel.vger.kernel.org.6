Return-Path: <linux-kernel+bounces-384938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8A9B3061
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BC72825C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D1D1DB92C;
	Mon, 28 Oct 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j0C/LCqQ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2A11D934B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118928; cv=none; b=hiyJ1f1ruRg1hqp9RewSpCflJPmfJK1Rr2pqBWZqPw9UU4rm4TI3/X+/7W/uHM/ef3kPi98tWZpmiyEaieZT/94BsnKajLLMEcfb2BztFWl6G50Ta8Qv7LqKVPD0d6NZ785IrapHgAE80wJh6Qo1qJ7OKSRj95SyvLW3sP26j00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118928; c=relaxed/simple;
	bh=G/XWiPL1tzKOA91NpkVzK6G0p+V96OLXdFuYCzGo71s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgttD2xYbpIw014AjkbpjsDU9kDTn5IdQ0O+fqvo8CxpQZMP/XaBh2RGQt7MOWp49Lg7g0pleoSN5zpryWjtHfvFyqf3dT1JP4oapSNJb3uYPTLCgB1tD9GPI2FGBRCfp9TS9hwa8IYrjaBGD0dkStDcJNqNf97pfytvWPhASQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j0C/LCqQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=344J5
	ku+Gt/dhWff1sAIGZQvuDp5Q5kk2nVCCnwU/2c=; b=j0C/LCqQw9VuUP7JlFZLV
	f7t5n7SqTmIbLkRGzGVmDFgqtRa/8lpjWQ5JzOuHVmPYWg+5PE2b2kyTtE7o33N2
	0GxjSNIrkbxBoOCuhnLeWGyh3N35LWD3rcGnLYqYe8fH2sM22PI6/Mbp6wz3KB/g
	km/StyM/8AuBxMMjGO9Nbg=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3f+b5hB9nytgkBw--.9113S5;
	Mon, 28 Oct 2024 20:35:09 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi GenBook
Date: Mon, 28 Oct 2024 20:34:58 +0800
Message-ID: <20241028123503.384866-4-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3f+b5hB9nytgkBw--.9113S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy8GF45uw4rArykur18Grg_yoW8Ar4xp3
	ZrCrZ5WFZ7WrW7JwsxAryxJFs8twsYkFWxGryfZFy7tF4aqFn5twn7Grn2vFyDAFWxZ3yf
	CFykJF1j9r1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRE_M-UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gSGXmcfgjoqQQAAsl

Enable hdmi display output on Cool Pi GenBook.

Signed-off-by: Andy Yan <andyshrk@163.com>

---

Changes in v2:
- Remove enable-gpios as it is unevaluated

 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
index 6418286efe40..da7a19f1fe58 100644
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
 
@@ -347,3 +360,40 @@ &usb_host1_xhci {
 	dr_mode = "host";
 	status = "okay";
 };
+
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


