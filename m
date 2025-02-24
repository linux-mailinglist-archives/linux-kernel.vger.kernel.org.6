Return-Path: <linux-kernel+bounces-528376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24933A4170D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B385189689B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBFD241681;
	Mon, 24 Feb 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="B8AqRAw6"
Received: from mail-m49196.qiye.163.com (mail-m49196.qiye.163.com [45.254.49.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE824166A;
	Mon, 24 Feb 2025 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384879; cv=none; b=bDABiVS+vuCaU3/aiXNzCN5g/1NXxoWTH5cprVqYGQIMnMSVQtNu82ZW784GARmFBuB4y7WPKWizlrlirOVnM2+mbh1dRrok+gQ1bKGsW0xJ/2zbKPXgkabi+/g5LXNQ9EViW9PHeBQaeUpWEkrGwHVWuwSp5OwZmMT4pHu7grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384879; c=relaxed/simple;
	bh=/4vnuHch4JzhMaxSGJUEzUawNjsPjjvp9NN2340b29o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GF0o36PEEpGFshUqectoG3JjdTD63NbUwLvt0Oo1rPDnYDt0Cmq7L/NsCXxp8QlaaPDTS8ZjjgmSfHhSQoduiBQ5WPRWdw3CZ6VUf/MRyuPecZwQnRSgsFwlvqSE6D9C9vyUZXCyMDVyrr0l8WMOUhr0yHf264eL+MN4Yyzrz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=B8AqRAw6; arc=none smtp.client-ip=45.254.49.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfd28862;
	Mon, 24 Feb 2025 16:14:26 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v7 15/15] arm64: dts: rockchip: Enable eDP0 display on RK3588S EVB1 board
Date: Mon, 24 Feb 2025 16:13:25 +0800
Message-Id: <20250224081325.96724-16-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224081325.96724-1-damon.ding@rock-chips.com>
References: <20250224081325.96724-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxPTlYYHxlNS0NKThpLSRhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a953705924d03a3kunmbfd28862
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006Agw6KDIUMxMRTTMBEQ0X
	CB9PCRBVSlVKTE9LSENPQ01DQ0tPVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISE9MNwY+
DKIM-Signature:a=rsa-sha256;
	b=B8AqRAw6Tbymyr1sz474bXDJxxKsZIun4JYntG1Btss0YszgMlqF+06zz73RdUa0B7s4zI71p0b155OIJlcSShh88bdXD+gPKfm24AhrwfdflUnjOLB4tiu/jeEa0JwMRBtmOPpbi0R0Ee2J8Wl3qGYtFf5bZkqtmhLLrSe9KVY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=5h/y9NEgz/o71+GHUNhAGQ4SKKQ0RE+55I5pH4r07Uk=;
	h=date:mime-version:subject:message-id:from;

Add the necessary DT changes to enable eDP0 on RK3588S EVB1 board:
- Set pinctrl of pwm12 for backlight
- Enable edp0/hdptxphy0/vp2
- Assign the parent of DCLK_VOP2_SRC to PLL_V0PLL
- Add aux-bus/panel nodes

For RK3588, the PLL_V0PLL is specifically designed for the VOP2. This
means the clock rate of PLL_V0PLL can be adjusted according to the dclk
rate of relevant VP. It is typically assigned as the dclk source of a
specific VP when the clock of relevant display mode is unusual, such as
the eDP panel 'lg,lp079qx1-sp0v' paired with RK3588S EVB1, which has a
clock rate of 202.02MHz.

Additionally, the 'force-hpd' is set for edp0 because the HPD pin on the
panel side is not connected to the eDP HPD pin on the SoC side according
to the RK3588S EVB1 hardware design.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Remove brightness-levels and default-brightness-level properties in
  backlight node.
- Add the detail DT changes to commit message.

Changes in v3:
- Use aux-bus instead of platform bus for edp-panel.

Changes in v4:
- Add comments related to the use of panel compatible "lg,lp079qx1-sp0v"
  in the commit message.

Changes in v5:
- Use "edp-panel" instead of "lg,lp079qx1-sp0v"
- Remove unnecessary comments in commit message
- Assign the parent of DCLK_VOP2_SRC to PLL_V0PLL

Changes in v6:
- Add PLL_V0PLL related descriptions in commit message

Changes in v7:
- Describe why to set the 'force-hpd' for edp0
- Add no-hpd for the panel node
---
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
index bc4077575beb..de52a6600b7b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include <dt-bindings/usb/pd.h>
 #include "rk3588s.dtsi"
 
@@ -238,6 +239,42 @@ &combphy2_psu {
 	status = "okay";
 };
 
+&edp0 {
+	force-hpd;
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			backlight = <&backlight>;
+			power-supply = <&vcc3v3_lcd_edp>;
+			no-hpd;
+
+			port {
+				panel_in_edp: endpoint {
+					remote-endpoint = <&edp_out_panel>;
+				};
+			};
+		};
+	};
+};
+
+&edp0_in {
+	edp0_in_vp2: endpoint {
+		remote-endpoint = <&vp2_out_edp0>;
+	};
+};
+
+&edp0_out {
+	edp_out_panel: endpoint {
+		remote-endpoint = <&panel_in_edp>;
+	};
+};
+
+&hdptxphy0 {
+	status = "okay";
+};
+
 &i2c3 {
 	status = "okay";
 
@@ -399,6 +436,7 @@ usbc0_int: usbc0-int {
 };
 
 &pwm12 {
+	pinctrl-0 = <&pwm12m1_pins>;
 	status = "okay";
 };
 
@@ -1168,3 +1206,20 @@ usbdp_phy0_dp_altmode_mux: endpoint@1 {
 		};
 	};
 };
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP2_SRC>;
+	assigned-clock-parents = <&cru PLL_V0PLL>;
+	status = "okay";
+};
+
+&vp2 {
+	vp2_out_edp0: endpoint@ROCKCHIP_VOP2_EP_EDP0 {
+		reg = <ROCKCHIP_VOP2_EP_EDP0>;
+		remote-endpoint = <&edp0_in_vp2>;
+	};
+};
-- 
2.34.1


