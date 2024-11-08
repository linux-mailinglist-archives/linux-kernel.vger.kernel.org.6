Return-Path: <linux-kernel+bounces-402052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B379C22BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B754C285F99
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A2199FA0;
	Fri,  8 Nov 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="S7/LwjT6"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF3192D89
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086087; cv=none; b=OdGbGIUE3zmIAEy0A9CRXGaikblNSQYDnXHxnYTkT9KBzYO8kYe63yWPewewlsb9c+3OZUckV7WoDipsBqrFISYsL0beefFKBWqpXEp+UnBrVbZH10HAOLcQ0I+pB4HX7b+F1wDlexYDJea6MHoKrPzSILJqnHp/70dGaMBOWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086087; c=relaxed/simple;
	bh=qXxdk8lZHAHh5/hGF7BktM8jAG0FFBHhC47+v/TURxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0Ksy+BqqteJoBT7e7PzO1IDlBxaZUDMdW01YwvX7xQs1+w4KUU6yjiP9d7vuhVxxuONJtj7aoZCe9OqGz8RHdBsKb3FAcYSkzP0V8rAb+sSscC1bxeLS92ww1KF/tgGttYGMyf5kF1sv0yZWvfJTIivUTtLOwYFy/J3bE3aajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=S7/LwjT6; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1731086073;
 bh=TS2gLOjQjFV6cYijRKcDLkRYjhtlEXXGFVSSgqynX+0=;
 b=S7/LwjT6RrrOoOPpoX8j7fT6pvrM9FJPPNvCA46Lx5Ehz12dE2LjDgV2BADueA/ceVI7dEYIl
 H5rZu5ruJncXOvjzBY1sP+RuLSlJgRDKmJQHfovbO07j4q8dMQbROtWnoAgvsuuiqRFrpHEl5Bi
 aCklkowmL7CVLxmSQgDMSUjvCdqpQmU8Sv+U6NPMXs/X1bya8SaH6kmCo6e8quSQyL4r4l0cUs5
 5tfWn51szFGA45bcodTA/5Xo79QZLS3ib1X0LGnLRyF5d5G9mdbxp/eE+VhXf8gWzwNVxluy0aG
 uUNhdS8Kz6WXq3+IVLnF/E4PYdNVC26yG2Rq5WpB0N9w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Enable HDMI0 on FriendlyElec CM3588 NAS
Date: Fri,  8 Nov 2024 17:14:19 +0000
Message-ID: <20241108171423.835496-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672e46f71f83b87ca0e8e60e

Add the necessary DT changes to enable HDMI0 on FriendlyElec CM3588 NAS.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Tested and working with video=1920x1080@60 cmdline on a CM3588 NAS
---
 .../rk3588-friendlyelec-cm3588-nas.dts        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
index 411007cb8118..b3a04ca370bb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include <dt-bindings/usb/pd.h>
 #include "rk3588-friendlyelec-cm3588.dtsi"
 
@@ -89,6 +90,17 @@ button-user {
 		};
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
 	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_LOW>;
@@ -307,6 +319,26 @@ &gpio4 {
 		"", "", "", "";
 };
 
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
+		remote-endpoint = <&hdmi0_con_in>;
+	};
+};
+
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
 /* Connected to MIPI-DSI0 */
 &i2c5 {
 	pinctrl-names = "default";
@@ -776,3 +808,18 @@ usbdp_phy0_dp_altmode_mux: endpoint@1 {
 &usbdp_phy1 {
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
2.46.2


