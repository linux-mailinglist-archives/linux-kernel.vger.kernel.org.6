Return-Path: <linux-kernel+bounces-302330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD095FCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963F6285449
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26E19D08C;
	Mon, 26 Aug 2024 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="h4367pYa"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83E19D07E;
	Mon, 26 Aug 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710743; cv=none; b=VOqFxg8ucZKYXMEhfpfBDeD/ITv2MNjO+/ygual1cDqRizuyfwOn+GEeJzds2ccjOvLQhTcvMd9erZWV/AZW1fYtsnwF3Vh/qT/JEFOVhi/uTf+uRarkw755hH5FM7vPVpr54AGRbCEFCYrgPIokQQRje7bzA4xb0eSEAgesqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710743; c=relaxed/simple;
	bh=oiR1Fld9b770SKJdNvZawoU6zRfAeEpH73HRGqhu4Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRvdsl2K8wBdQ192OapCGEacdDv6FYn7gvlTnL7Mr7H/yEPv+r2m3+VMPqR4LBc7UnFrjOz51ijku7lnzEM3wXU2jbsCHVgwnW4PuZtwU+BJejtEp/TgqK6LLaYL7EDFtES/+g+r6Sbp47AAWsrn0fX/8Sa88+d+TRKbZNbp+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=h4367pYa; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7432A20AB8;
	Tue, 27 Aug 2024 00:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724710740;
	bh=OLHcXUX5ld590VkhJksYhwouQQmCELfT4laFDokDThE=; h=From:To:Subject;
	b=h4367pYaDAO4MkkzKCXNmtiUU/ikzMSrhoUNea31fJiU4zwVYDWI5K0i2q4HNzsn/
	 /SX4ptYYPt6NsVO1k799X8Cz+1zf7krTsRp+c3Oc+7edzU/0WIfucuym0SnuRrhZ96
	 FPSiKTstBipJm55EJYvyLsyHmtF0+mWHak5547qjFM7E2BBH6cMj2bQOWoB84NZ0Wm
	 uU+XUB8snzY3JJDDNqtVXLSig2oIrLpIR2zNqUVuBDhq01bA7DFTS6Gxc+xKSB3PbP
	 6B2/rTFdm3nNYoZy9ygPvQyLC/14JQ6LQ08uLPTGtrDLgTB+uUV9AhXRwx1waGwNsz
	 Ctjb+1THiqFGw==
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
Subject: [PATCH v1 5/5] arm64: dts: imx8-apalis: Add usb4 host support
Date: Tue, 27 Aug 2024 00:18:55 +0200
Message-Id: <20240826221855.16061-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826221541.15669-1-francesco@dolcini.it>
References: <20240826221541.15669-1-francesco@dolcini.it>
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
index 0f334c268a99..0523bd0e8cd2 100644
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


