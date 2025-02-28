Return-Path: <linux-kernel+bounces-538780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E6A49CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639727A9D25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72528271269;
	Fri, 28 Feb 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="eOkmF1kk"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522425DAE6;
	Fri, 28 Feb 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755643; cv=none; b=eGm81FIa0oqgbzp9s2DFp9E/4xW4xvPqNgRoIZKycItIaNUP+GpddDOl0ZytYBU8pKh/C6yEXZMrckzTPQ49gG1Fm6vWRCiiaIX2o3BM+h2yHpc7V0tlfBTxpan/3+hs48yuCyGCp6Y52aNXxJTkvknAyfcdk0Jn1UrV7nXV9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755643; c=relaxed/simple;
	bh=THAU4SqU00VBQrLedoqh6B099VJDm7+Mw0C6+SdVwRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMGtiyJPdOfyRJuCfsfWfBBFrX/eRGlhqDdscL/K/XDDsOW3tpcGumA6EZJ+yiEHj16HSiiOMtLeWGXhIcwvh9gXZNAKEtUgH0I4Y0KPNFb5WfEDwH865KcMFoQ3yaG+jSc1roOhxH1F2bmt6lPl00VsEeOBgpdnRa806ZRFcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=eOkmF1kk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0E3CE1FA0A;
	Fri, 28 Feb 2025 16:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740755640;
	bh=HxbU9/lVcZnDhkufqcOR854Ftnj0pgTJtJXi6NbhlOU=; h=From:To:Subject;
	b=eOkmF1kk+qZGNGFlMXU4IOBbgmp+X9kFgWq+WPzoqFedKkrAvZjXcCQkRplZ6ipto
	 xipdRs1PpJVsRGw81zpvx7hhPVl2qFM50QW2iZOwPzb1MEIZ/POHY52+jUBV/+zAOg
	 ++HUHbeEhdUrTCn5vmDLVgLu8kgz4ph6uiX1PZfQe2SkjgZ0njtHdkVDZv+5bVnaFg
	 o+9UnuTqrlcV0/U72jdWC+D9cIiygk5IsNclaEaTAzgYocDLD0IGE3Jo1kOUARoE16
	 5OBgu5fFKD1fdiY0Wt4/fivAsF5YZIV4C1mMB8y2FNVtjuEhaI2Tw/saVT52h01RXb
	 SSceBwPDhjSCw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Agner <stefan@agner.ch>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] arm64: dts: imx8qm-apalis: Remove compatible from SoM dtsi
Date: Fri, 28 Feb 2025 16:13:51 +0100
Message-Id: <20250228151352.91768-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228151352.91768-1-francesco@dolcini.it>
References: <20250228151352.91768-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The SoM cannot be used standalone, this compatible is invalid and it is
always overwritten when this .dtsi file is included, remove it
therefore.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: new patch
---
 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi | 2 --
 arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi
index 81ba8b2831ac..b1c3f331c4ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi
@@ -9,8 +9,6 @@
 
 / {
 	model = "Toradex Apalis iMX8QM V1.1";
-	compatible = "toradex,apalis-imx8-v1.1",
-		     "fsl,imx8qm";
 };
 
 /* TODO: Cooling Maps */
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi
index 4d6427fbe875..c18f57039f6e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi
@@ -7,8 +7,6 @@
 
 / {
 	model = "Toradex Apalis iMX8QM";
-	compatible = "toradex,apalis-imx8",
-		     "fsl,imx8qm";
 };
 
 &ethphy0 {
-- 
2.39.5


