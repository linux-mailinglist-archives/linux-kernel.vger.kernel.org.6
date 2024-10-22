Return-Path: <linux-kernel+bounces-376572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2E9AB35D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEE91F242D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391D1BB6BE;
	Tue, 22 Oct 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cJSPzcCW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2640139CEF;
	Tue, 22 Oct 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613121; cv=none; b=HMMAak0KOEG7EWyBhI5Hcuq/yu4TFtlmjaI6qcc7YoDBQeyw//PMlIhxIqbEtDKwS3p1Rb/WZsl5xgWyu2JuMfdZuyjK9ed9Gub04H9HH/M/FOCxQVr/vzw3/tp5Rf88JZFee/2UYt748V/D/UdfTPSVHM3ZaQul6iCiH/L1wyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613121; c=relaxed/simple;
	bh=OynJaLzMucy3vyn4kZXuh4tD4dsnHaoATki7l4g0SmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V0csBPn3mCtkxhH+6RzRBpQ2b7feBCEpWHBLXfYfrJlGTxTVSScNERtEpiEdQQvTddI5a1C8ir/vG1cEi8z/Kks/YZfPZtV/4mgY8aLy+k/I5IoGb206CE8rLmMffXYy9EmaKASg8HOuECVvA7gOl/4/EOeF7NHrrmIaI8cbZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cJSPzcCW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729613117;
	bh=OynJaLzMucy3vyn4kZXuh4tD4dsnHaoATki7l4g0SmM=;
	h=From:Date:Subject:To:Cc:From;
	b=cJSPzcCWjFLx6mkYM+D4SNX8Nk0MW+obST65upmRoc37JhwJb2tiy6WNT8/TfU02O
	 KMwsLCr13ftAJt5XEkynWkHmaB7rNhgFOJZ/VWkEtCV7B5pdT0WP3FZLqPP7HYindA
	 vW0oqi8GHrUowMvqQ52EA5wX0gBiZVtGrD+S6el+jFspQZTD0iezRInZZgu/8NJis3
	 gZF7ToI/9yOs4vpzt8jUUy2c2gG9g3x2vXwGO7IXeiAZqZZteEBS4X9zuF5d+RuSn5
	 yoVrIEzcs1LFJH8FycR+s7lL+K2cONMi3ym+ezH+89t/m/g47KNJHKOKJGbzCD0psE
	 xPUKxupBP6bgg==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0F2717E3677;
	Tue, 22 Oct 2024 18:05:17 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 22 Oct 2024 19:04:42 +0300
Subject: [PATCH v3] arm64: dts: rockchip: Enable HDMI0 on rock-5a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-rk3588-hdmi0-dt-v3-1-3cc981e89afb@collabora.com>
X-B4-Tracking: v=1; b=H4sIABnNF2cC/4XNTQ7CIBCG4as0rMUM9EfoynsYF5QBS2yLgYZom
 t5d2sSNLly+XzLPLCSa4EwkbbGQYJKLzk85ykNBdK+mm6EOcxMOvGLABA33shaC9jg6oDhTplh
 ZI8CpUZbkq0cw1j138XLN3bs4+/DaHyS2rR9L/liJUaAdCsultEZpPGs/DKrzQR21H8nmJf7H4
 NmomkajACOsld/Guq5vYTSqjPYAAAA=
X-Change-ID: 20241018-rk3588-hdmi0-dt-1a135d0076af
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add the necessary DT changes to enable HDMI0 on Radxa ROCK 5A.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Since the initial support for the RK3588 HDMI TX Controller [1] has been
merged as of next-20241018, let's enable the HDMI0 output port for the
following boards: Radxa ROCK 5A & 5B, Rockchip RK3588 EVB1 V10, Xunlong
Orange Pi 5+.

Thanks,
Cristian

[1]: https://lore.kernel.org/all/20241016-b4-rk3588-bridge-upstream-v10-0-87ef92a6d14e@collabora.com/
---
Changes in v3:
- Used the proper (i.e. micro) HDMI connector type for ROCK 5A (Jonas)
- Rebased series onto next-20241022 and dropped patches already merged
  by Heiko
- Link to v2: https://lore.kernel.org/r/20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com

Changes in v2:
- Updated descriptions for rock-5a & rock-5b patches to include Radxa,
  per Naoki's review; also collected his Tested-by on the latter
- Included Naoki's HPD pin related fix in rock-5a patch and dropped the
  UNTESTED prefix from the subject
- Link to v1: https://lore.kernel.org/r/20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 5882027ab64c94066ead9a1c6cc84226968a69c8..3ca23555d90c5fedd95d4e8681c073b6523f5bf8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -5,6 +5,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588s.dtsi"
 
 / {
@@ -35,6 +36,17 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	hdmi0-con {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		port {
+			hdmi0_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -301,6 +313,31 @@ &gmac1_rgmii_clk
 	status = "okay";
 };
 
+&hdmi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmim0_tx0_cec
+		     &hdmim1_tx0_hpd
+		     &hdmim0_tx0_scl
+		     &hdmim0_tx0_sda>;
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
 &mdio1 {
 	rgmii_phy1: ethernet-phy@1 {
 		/* RTL8211F */
@@ -793,3 +830,18 @@ &usb_host1_ohci {
 &usb_host2_xhci {
 	status = "okay";
 };
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};

---
base-commit: 7436324ebd147598f940dde1335b7979dbccc339
change-id: 20241018-rk3588-hdmi0-dt-1a135d0076af


