Return-Path: <linux-kernel+bounces-529240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D612A4222C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD3B176A82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1D25D54B;
	Mon, 24 Feb 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro0ihmqi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6092254863;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405066; cv=none; b=nv4qK0TyIrj5glxuuTpRKKm4++t8b12tbz8/DDRDI1HaBSfxImvk5M3PYP8/5deiK3JPOX72yU9/CdXlTS72xFlxmDhIfgheGZ1KffsP11Yk7CGMADf83ywOyEAlvmO7dStrenn010BqDNe6edmd2B0YNgUix2t0MBkNE9AFVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405066; c=relaxed/simple;
	bh=FJ54yO04PKk7jacqo+ONYP3+FlHuQ9rLC64gl6G9Bxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLX3VOlyWJ6Ks4h7nyT1Suw5R9ZI50Bah9v4BbTSwDfbVfUX+j8WFUyvoq6JPzq6Tvg/gbYTOCUqu8EnN10j9ZE+Kh4tL3gvtEpoSL48ZYdRVzRby3zMabt8mWDyxKVoN2t5+r6EokzgKE87XmYWtfC7txoB+NlK66x36k/ggfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro0ihmqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 320E5C4AF62;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405065;
	bh=FJ54yO04PKk7jacqo+ONYP3+FlHuQ9rLC64gl6G9Bxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ro0ihmqi+4apnSzbXn8tkuIVC7wo9uBi/D2ZQpOl0vVlM39cbj1s9sntlWes+lrQz
	 nsHPQoo+08M7Lc9JD1dW2YO3XnNFrvD967VzZRSjTfN+zRzWQ9pGFu7imj6hDU8r2n
	 KyBjoJjXlL3e+ABFnZY1KZdV4T16rqDz+FXcpEIxclDBb2rJSzolYx13PcwnSQ0fSZ
	 AHnwYpcC1zmnE81SYBkzeG0qovniJuQVNcoKkm9rDQ9anSDmYjzyBFAAV+B5dTYlC/
	 j6wbwNlFO3Ns/HevkME0DSkh4+uaDGtqv2w3T4+QeFaZd4VWk6qs51BhsbTLonCLbR
	 eEcTedc1b35tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE6CC021BB;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:51:04 +0100
Subject: [PATCH 14/14] arm64: dts: freescale: Add the BOE av123z7m-n17
 variant of the Moduline Display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-14-5ccbbf613543@gocontroll.com>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
In-Reply-To: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=3566;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=oTP9B5+eckemcAq7BoHH8WLYSzQY53IU8NlYcoi8TI4=;
 b=aQ+VE0ltCkVpecPynixQhO2jlXkv5MbH2Ub/umJWYy2F2l+LhIXFrAg+miCS5eqAogchWhS3+
 7JLJf8Xl76wCUt081BHlCJk6B9CStdy7l91pUD5HAkmbSCe6tqa6zBQ
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add the BOE av123z7m-n17 variant of the Moduline Display, this variant
comes with a 12.3" 1920x720 display.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

---
Currently the backlight driver is not available, this will be upstreamed
in a future patch series. It is a Maxim max25014atg.
---
 ...tx8p-ml81-moduline-display-106-av123z7m-n17.dts | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dts b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dts
new file mode 100644
index 0000000000000000000000000000000000000000..129c69598f38566460efb271628c1d1e10eb2a85
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dts
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2025 GOcontroll B.V.
+ * Author: Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-tx8p-ml81-moduline-display-106.dtsi"
+
+/ {
+	model = "GOcontroll Moduline Display with BOE av123z7m-n17 display";
+
+	panel {
+		compatible = "boe,av123z7m-n17";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel>;
+		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+		power-supply = <&reg_3v3_per>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dual-lvds-odd-pixels;
+
+				panel_in0: endpoint {
+					remote-endpoint = <&lvds1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dual-lvds-even-pixels;
+
+				panel_in1: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+		};
+	};
+};
+
+&i2c4 {
+	bridge@2d { /* sn65dsi85 */
+		compatible = "ti,sn65dsi84";
+		reg = <0x2d>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lvds_bridge>;
+		enable-gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;
+		vcc-supply = <&reg_1v8_per>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				dsi_lvds_bridge_in: endpoint {
+					remote-endpoint = <&mipi_dsi_out>;
+					data-lanes = <1 2 3 4>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lvds0_out: endpoint {
+					remote-endpoint = <&panel_in1>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+
+				lvds1_out: endpoint {
+					remote-endpoint = <&panel_in0>;
+				};
+			};
+		};
+	};
+
+	/* max25014 @ 0x6f */
+};
+
+&lcdif1 {
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,esc-clock-frequency = <12000000>;
+	/*
+	 * burst has to be at least 2x dsi clock that the sn65dsi85 expects
+	 * display pixelclock * bpp / lanes / 2 = dsi clock
+	 * 88.000.000 * 24 / 4 / 2 = 264.000.000
+	 * range gets rounded up to 265.000.000 - 270.000.000
+	 * 267.500.000 * 2 = 535.000.000
+	 */
+	samsung,burst-clock-frequency = <535000000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			mipi_dsi_out: endpoint {
+				remote-endpoint = < &dsi_lvds_bridge_in>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_lvds_bridge: lvdsbridgegrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD2__GPIO4_IO14 /* COM pin 113 */
+			MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07 /* COM pin 157 */
+			MX8MP_DSE_X1
+			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09 /* COM pin 159 */
+			MX8MP_DSE_X1
+		>;
+	};
+};

-- 
2.48.1



