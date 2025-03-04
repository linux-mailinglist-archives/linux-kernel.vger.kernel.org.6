Return-Path: <linux-kernel+bounces-544325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C43BFA4E012
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54B77ABB14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD217204F7F;
	Tue,  4 Mar 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aGY3ur5o"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F5204594;
	Tue,  4 Mar 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096923; cv=none; b=WKJbDGdo0BmA22K6Dth12ua89IRyTyTOVGi++6f6Vv1uCd5YhGLkURtoKCM1x8OlW3V1Vv4mCB8XLJvEnXUI9cnleQnXaYfk2wthxNlk+VnO3SnAJmhkW2nfxzqhZf0CYr1gIcPRJbhdvzd6zo6+p0oUpn8fXzJMvy4gJiK0J8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096923; c=relaxed/simple;
	bh=yt2BhK78wO3VCoBAp3bBwVbzYRTRZrZYVfmzQyD7dWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uT4LVdXPA7KePWzSxeH+ggW8bw9gmmVtIRwlK9rVzZXe49z2K/D+PtFSCPS+uFOO/YU7eUwnumukimlP3fLxQ2OFKVeeWngmWf23nUPHlfPveJ5ngbuaK84FuZsiEwJezZiLkqFfxc+fnwRuBsFCQTOzVoYE5Q1qcZJOBYi+pwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aGY3ur5o; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741096919;
	bh=yt2BhK78wO3VCoBAp3bBwVbzYRTRZrZYVfmzQyD7dWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aGY3ur5orYmk/WCjTAXkcneoI09H5KxJrlLb+DZrfB/tuMuj2/ACtcNTMXcreakbu
	 i+fLskyhBzDuDN0PlnYMHjOcSFrtDwvd+2lumkiu685apjng+eftIGJnyvPqMJ5Nl8
	 jFJZY5ctoazf2mnpfECL/mPyuAQPIh1gn00z4mxiIwPRU7uv5LcPfWkMFdyKmAZepx
	 5q/t30lC8Z2+yy5BkInhkP1GAqvAg9XkLwR9Vk+MK0/zzKUTeFqJcxcM+2QucRDc4P
	 ocLLrzmB78MMCmdVimSF9FxPWAyj01NGQWhpQGbWAWMHpOqEzpRYlgV4rEAx9mthxf
	 1Yo+HvCh3pimw==
Received: from apertis-1.home (2a01cb0892F2D600C8F85cf092d4Af51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 84C8E17E0F3D;
	Tue,  4 Mar 2025 15:01:58 +0100 (CET)
From: Julien Massot <julien.massot@collabora.com>
Date: Tue, 04 Mar 2025 15:01:56 +0100
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8395-radxa-nio-12l: Add
 Radxa 8 HD panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-radxa-panel-overlay-v2-2-3ee6797d3f86@collabora.com>
References: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
In-Reply-To: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
To: kernel@collabora.com, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, Julien Massot <julien.massot@collabora.com>
X-Mailer: b4 0.14.2

The Radxa 8 HD touchscreen can be used with various Radxa board
and is sold appart from the Radxa NIO 12L development kit.

Add a DTS overlay for this panel.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile              |  2 +
 .../mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso  | 84 ++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index ae1147eca9a915f117487101e2ad4acead97adfe..58484e8300632edbdef24bbda33ccf00db9df937 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -100,9 +100,11 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l-8-hd-panel.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
 
 # Device tree overlays support
 DTC_FLAGS_mt7986a-bananapi-bpi-r3 := -@
 DTC_FLAGS_mt7986a-bananapi-bpi-r3-mini := -@
 DTC_FLAGS_mt7988a-bananapi-bpi-r4 := -@
+DTC_FLAGS_mt8395-radxa-nio-12l := -@
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..0389c9cb8581c0bb50bb38fd35d1190de13feb6e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Radxa Display 8 HD touchscreen module
+ * Copyright (C) 2025 Collabora Ltd.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&backlight {
+	status = "okay";
+};
+
+&disp_pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_default_pins>;
+	status = "okay";
+};
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "radxa,display-8hd-ad002", "jadard,jd9365da-h3";
+		reg = <0>;
+		backlight = <&backlight>;
+		vdd-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
+		vccio-supply = <&mt6360_ldo2>;
+		reset-gpios = <&pio 108 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_default_pins>;
+
+		port {
+			dsi_panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+};
+
+&dsi0_out {
+	remote-endpoint = <&dsi_panel_in>;
+};
+
+&i2c4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		interrupts-extended = <&pio 132 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&pio 132 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 133 GPIO_ACTIVE_HIGH>;
+		VDDIO-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+	};
+};
+
+&mipi_tx0 {
+	status = "okay";
+};
+
+&ovl0_in {
+	remote-endpoint = <&vdosys0_ep_main>;
+};
+
+&vdosys0 {
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdosys0_ep_main: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&ovl0_in>;
+		};
+	};
+};

-- 
2.48.1


