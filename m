Return-Path: <linux-kernel+bounces-302302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E495FC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85940B22B22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587619EED3;
	Mon, 26 Aug 2024 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="eIxFanq4"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA719D8B2;
	Mon, 26 Aug 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709587; cv=none; b=uPLBx6/6UOMD3HCp1cbnvc8T3j1C2Ry0j0+sS+Y1rYVq3egv0pK/Q31Fthi9+IyNwE7lqIeGx/qgFabUNWKUuH/qpCjQnkuiccgd9ePjDq8WGL+FTrlIQ2opn3o9OjhioQhn4X7NJYGVgnd+byqng4UiLZM0v1LUZ6APYLlV7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709587; c=relaxed/simple;
	bh=vLV4h/E4ae8OrlornyDYuD6zcUiwbmLYHn9Mz1BP7QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWdA/k6OKxcbDxfUIjtro2KxM3ZqjcITMqOYuBSYtCrBAA8z9Qw3ibuSjnBbZhKl5naNsaNNPInsCX6CEzp2sEennpWYaRHWEa8QvKlIgcXjMJupOtarnv7I72AfqujhzDAVH3cKeh3CP8+9TqQk+Wez4DFV0+hX6t9BvT7NO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=eIxFanq4; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0FD1525077;
	Mon, 26 Aug 2024 23:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724709581;
	bh=mXowhD81nNtIh4Zuu2na6my9WsdVkq42/DwcPSggglQ=; h=From:To:Subject;
	b=eIxFanq4VlyxaMWdNaDUfxEBQbIVyc3uaSTY0ZJ1KHxKCNC0+Kpbj9UJAH5IO6Yn/
	 PlApeLsAXXNI7UHMWXukWu0mMn5XJKxcVfrGXCdyNnknQQV3f5LR1E8+4zD9Z4ifPQ
	 zWEWE5s7nFfYOi7sEMhQZjxcoAGFZiIwpx8zRiFaelOdoTIwwghY3/Mkqj134TY2jQ
	 TUuHKWMG6JGl3rIsofidfVahzoqUNx8CQ65ZI3ad+89HPhzwwzIOcyb3UeGGEMNG6d
	 4pnnpluy6izfqZ1XLKDDV9u2gMSgAOJbaJnVu/KShXtsZ9nT7kJopM7hAKP4TWEe1G
	 tNECj4AbypU8w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 08/10] arm64: dts: colibri-imx8x: Add adma_pwm
Date: Mon, 26 Aug 2024 23:59:20 +0200
Message-Id: <20240826215922.13225-9-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826215922.13225-1-francesco@dolcini.it>
References: <20240826215922.13225-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add adma_pwm node for Colibri-iMX8X carrier boards.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi   | 5 +++++
 arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi | 5 +++++
 arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi    | 5 +++++
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi         | 6 ++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
index 503aa5a90503..f7bbb2153ae0 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
@@ -8,6 +8,11 @@ &adc0 {
 	status = "okay";
 };
 
+/* Colibri PWM_A */
+&adma_pwm {
+	status = "okay";
+};
+
 &colibri_gpio_keys {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index a2b2a0865666..f75499765d85 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -24,6 +24,11 @@ &adc0 {
 	status = "okay";
 };
 
+/* Colibri PWM_A */
+&adma_pwm {
+	status = "okay";
+};
+
 &colibri_gpio_keys {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
index 6d9d54d4e549..54393a0c5cbf 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
@@ -22,6 +22,11 @@ &adc0 {
 	status = "okay";
 };
 
+/* Colibri PWM_A */
+&adma_pwm {
+	status = "okay";
+};
+
 &colibri_gpio_keys {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 782546a35bf9..9cd4383e9298 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -88,6 +88,12 @@ &adc0 {
 	vref-supply = <&reg_module_vref_1v8>;
 };
 
+/* Colibri PWM_A */
+&adma_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_a>;
+};
+
 &cpu_alert0 {
 	hysteresis = <2000>;
 	temperature = <90000>;
-- 
2.39.2


