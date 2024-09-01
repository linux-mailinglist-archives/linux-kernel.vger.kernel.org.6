Return-Path: <linux-kernel+bounces-310277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC93967753
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2138B1F2185F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05F186E43;
	Sun,  1 Sep 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YY/Gg36F"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6318452C;
	Sun,  1 Sep 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206273; cv=none; b=LVKua1sfRRsGGfbgTJ4NY9Lzzp4mKawq3tAzKL3r6a+GOmbm8jx8NOcfIt3eVa+kohX0yrm2snM5iLtopLodSfYGCkhhhpkaapqsRFn9iD9TrZbVmR1/BVqr4KGiXmT21B8qWdbkPxnRjBiiv8oYdNxordqvVph1KZ6HkAFnt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206273; c=relaxed/simple;
	bh=ra1NgtWeJrM2OftmWOzbGNiFAMmkW3WbOXknkwlJGdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoIF4fwa9whO0KWo3N/FNwKctnSzPsZTnBKyey+F8jaMVft/vCpM0V6ys8Z6GgTphczeZF4UEGmTDxIXliUES1U2dvIpFn0wcd51N7cw3+QGHH+NUS95sVXSuE1XaR6HJe3enOzmIGuteKa+lYgG9zpNmu+o6oYiVTao5mCI2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YY/Gg36F; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 4AA5B1FB20;
	Sun,  1 Sep 2024 17:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206260;
	bh=T42bUGqwk0p0W8pIULO87aKB2+HshwN8ZFTvo+g8NME=; h=From:To:Subject;
	b=YY/Gg36FfRdwA9fQZzCOEZqeuBUjKoE8OgOmMWVMHf1HrOhSUoV/BsVo24DkUi1HX
	 DgiSn4PoeA+BQIdV0hCmFmTLCiHWm4u314UVh+GwkJpkHlJwZgceB1aIeY8MBpl1Z5
	 gl5WYVj9VjDuqIlrwH0aBgeccEh6+Y9egIPejKkmizJagdtsnXPshgXcsP7ZUhX3Xy
	 bpXLyi+w7gS3ib5mJQDnKWiFlE+R/Jlzr7yzmd7Z8FqZAZPVEzN5Thw7jN4emPX3jo
	 lriIUsw3nmIkxOG/uW5MTib3vZQv5iz9kGGmmRVSQhsJqBjoeUhjWc/ZXUm4yEMdNv
	 7xnEG8Xbb2cgw==
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
Subject: [PATCH v2 08/10] arm64: dts: colibri-imx8x: Add adma_pwm
Date: Sun,  1 Sep 2024 17:57:19 +0200
Message-Id: <20240901155721.7912-9-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901155721.7912-1-francesco@dolcini.it>
References: <20240901155721.7912-1-francesco@dolcini.it>
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
v2: no changes
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
index cc1a0a26fcec..7a40a827ef75 100644
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


