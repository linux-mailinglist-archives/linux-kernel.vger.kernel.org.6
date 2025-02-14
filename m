Return-Path: <linux-kernel+bounces-514690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70281A35A51
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA4616C13C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07112256C67;
	Fri, 14 Feb 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="AmukW2CB"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF002505C2;
	Fri, 14 Feb 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525211; cv=none; b=QeOqKD3anB9ppGapCDFJULDlY4deLUYsQ/scMn6V2PpuzbtQF5AeezUkYJUcJNG5Ifv3ppkZIzPxHpHs/eKYTYOSK8jMXxMZrAMVmKwRrwDSsyPAY6A52OQDezs5fGJ6wcSZMTk0WtOzOjzZt5f4a9P22NI9CtEiKunzPAgCl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525211; c=relaxed/simple;
	bh=mZEb4O/8MxgRPHsOLUCLNOkrcRFguNnDZADJYJu30Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HcK5nF0ZPM5trE/62sgLRb/ebg8dprwuqFqqjZCDQ2beBLR0nR9yxKCsShV8GH0+d27EVWtgJ5ED24nh5VNoU2h5tQAQjQXVx2eFHcZ1IRix4RIkpkmeguLrpc4RpjAErBwYrv3fDK9zuPgSuEJJJfuKcrH4MoX5PJ0f1wHRhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=AmukW2CB; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8BA3320065;
	Fri, 14 Feb 2025 10:26:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739525200;
	bh=G+g0OfrAh01X9LwRyhzYOGvgNaAers3h/+McghiIB40=; h=From:To:Subject;
	b=AmukW2CBRrfj8omVeMRErQo3AsjpN00p0iN162Kslp9UgCnOyfrZToWCNE4Q7CS/q
	 kCqd32ORmH8GRQIl3JZL2tJglARTb6ZFQlfdVIIyLIphSBchRg73JhWO7hNoovOzQO
	 5YvOk0dlOeqj3iieFS5HPycsJsq0bLg7MgmGn9EimnaRQ2JUYHFHlYOi2uQ5OTjP0Y
	 4r1AfwBzfRxhwHArtp7rYgibENZ3OlO2IQMlQLwjh7KvOGGWo7dL1VUIAQUUIqNCcG
	 veBVzRxfM0iM/HPHsBsbSG69atBVe3vGOeprVMdPsuSP/XyzkV7jepGkYaOTYvJapN
	 UDgOCe51FjM0w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.li@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: freescale: imx8mm-verdin: Remove LVDS panel and backlight
Date: Fri, 14 Feb 2025 10:26:34 +0100
Message-Id: <20250214092634.12414-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Remove LVDS panel and backlight nodes from the Verdin iMX8M Mini SoM
dtsi file, those two hardware components are not part of the SoM,
therefore they should not be present in this file.

This is solving a dtb checker warning about panel-lvds compatible.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index c528594ac442..7251ad3a0017 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -18,20 +18,6 @@ aliases {
 		rtc1 = &snvs_rtc;
 	};
 
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		brightness-levels = <0 45 63 88 119 158 203 255>;
-		default-brightness-level = <4>;
-		/* Verdin I2S_2_D_OUT (DSI_1_BKL_EN/DSI_1_BKL_EN_LVDS, SODIMM 46) */
-		enable-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2s_2_d_out_dsi_1_bkl_en>;
-		power-supply = <&reg_3p3v>;
-		/* Verdin PWM_3_DSI/PWM_3_DSI_LVDS (SODIMM 19) */
-		pwms = <&pwm1 0 6666667 PWM_POLARITY_INVERTED>;
-		status = "disabled";
-	};
-
 	/* Fixed clock dedicated to SPI CAN controller */
 	clk40m: oscillator {
 		compatible = "fixed-clock";
@@ -66,13 +52,6 @@ hdmi_connector: hdmi-connector {
 		status = "disabled";
 	};
 
-	panel_lvds: panel-lvds {
-		compatible = "panel-lvds";
-		backlight = <&backlight>;
-		data-mapping = "vesa-24";
-		status = "disabled";
-	};
-
 	/* Carrier Board Supplies */
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
-- 
2.39.5


