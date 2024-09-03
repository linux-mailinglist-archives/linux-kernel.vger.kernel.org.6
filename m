Return-Path: <linux-kernel+bounces-312584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12A969872
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2B31C2356F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA31B9840;
	Tue,  3 Sep 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ZBcNMMMM"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61831A2656;
	Tue,  3 Sep 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354775; cv=none; b=ULeO/WJRMKPkzqz/tu2T3h47IjB+Wqg23HFrsZykohHM/Tqc95ZvIVTAGtuR3ajfzWCW+eMfYiWWaSMpfW+rMJD0tAx3v2XFz/mk/pDlXVtORihSGzRmaMaCvKbkzU2ThF3nvgnoYFJLN2zLN6FWmaIUJS3nDIgpKccc+wyeMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354775; c=relaxed/simple;
	bh=6JBBplIDsA2HJb4B4/pBx6RbbKhR6nm1mI9apDqN9t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldXbPwY74vCPEbjXxGNXOdIq3Fs7hs4zp0rf9fxFxuHWKdv75ENntnFvPkJQjnihZOBbzlAmViWEIIxlKJGLsoL+QmToFdpvqDiwg9mbw3W/xmgAAd/D/GcPVBMm46r3AGsKmThWJpXBb3KQADod1bYy6MX/VVxwFIesKHXtRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ZBcNMMMM; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 48AFA22A41;
	Tue,  3 Sep 2024 11:12:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725354765;
	bh=x/Dc4MQ75tXldUcMe+uDn+5jK81jvSQu/e9iblTqqOE=; h=From:To:Subject;
	b=ZBcNMMMM9DGx4CkLJvKDOx0/Y1GgTN5K396FH3a2ngka2xMWw+3hGhprC4pYK/63W
	 JiRizBBGNxwss2JtOuyKLOm97bDGMpg6obM5Is1e3sRk5A3p9x5jQrdNoRe9z+s+0V
	 m36EA/oXW/amkqbPyg7noF+3hFEwpWABcTv/8c/yYl9nIstqdhAZk4kJkr3mEifM5d
	 rhtgyP5PFdA03W0H/CIFmrepy+R1AfyJE0GsVT7YudgGBOM5YQ1K9CY6ZHZHcFGwLy
	 dXXzEOz2sl5F2X0IllfgvOO8g2Bt+hTlSwOOeXRqGgUwWF0U5FtbFrkD87VI1lCqCa
	 9Vku0Seo6NhNQ==
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
Subject: [PATCH v2 5/5] arm64: dts: imx8-apalis: Add usb4 host support
Date: Tue,  3 Sep 2024 11:12:31 +0200
Message-Id: <20240903091231.20035-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903091231.20035-1-francesco@dolcini.it>
References: <20240903091231.20035-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add USB4 HOST to Apalis-iMX8QM SOM and its carrier boards.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi |  5 ++++-
 .../boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi  |  5 ++++-
 .../boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi  |  5 ++++-
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 13 ++++++++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
index 5f24356ad4e2..dc127298715b 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
@@ -135,4 +135,7 @@ &usbotg1 {
 	status = "okay";
 };
 
-/* TODO: Apalis USBH4 SuperSpeed */
+/* Apalis USBH4 SuperSpeed */
+&usbotg3_cdns3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
index 4ec2227750f4..d4a1ad528f65 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
@@ -222,7 +222,10 @@ &usbotg1 {
 	status = "okay";
 };
 
-/* TODO: Apalis USBH4 SuperSpeed */
+/* Apalis USBH4 SuperSpeed */
+&usbotg3_cdns3 {
+	status = "okay";
+};
 
 /* Apalis MMC1 */
 &usdhc2 {
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
index 606d9328ac99..5e132c83e1b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -271,7 +271,10 @@ &usbotg1 {
 	status = "okay";
 };
 
-/* TODO: Apalis USBH4 SuperSpeed */
+/* Apalis USBH4 SuperSpeed */
+&usbotg3_cdns3 {
+	status = "okay";
+};
 
 /* Apalis MMC1 */
 &usdhc2 {
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 91fd631b7ebd..a3fc945aea16 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -807,7 +807,18 @@ &spdif0 {
 
 /* TODO: Apalis USBH2, Apalis USBH3 and on-module Wi-Fi via on-module HSIC Hub */
 
-/* TODO: Apalis USBH4 */
+/* Apalis USBH4 */
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "host";
+};
 
 /* Apalis USBO1 */
 &usbphy1 {
-- 
2.39.2


