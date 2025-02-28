Return-Path: <linux-kernel+bounces-538779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 416F1A49CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272F31896529
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1607D270EBD;
	Fri, 28 Feb 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bEJ31olJ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCF1EF37B;
	Fri, 28 Feb 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755643; cv=none; b=VUtU9+I6ugo6sQztSnfLPC5y2OPeXATApYmEQe3jE5Q+ZsIs14O9RbPMQNjoOCOU76u8rhjyU7VvE64KC8asGw6bADVpeSq6vVSwentjBHCZQmC+OkGbSWiCv6khdt+baucXL+SA/9BoNLTrhUGBuk4U+86xWTBRm6y5tqWmX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755643; c=relaxed/simple;
	bh=U3dRrAdPcD5ykuZwBZVulA4GGiqZba4MIDWQMtMWSIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkAxWg96hYVx3SWhmun5Em2fHNi5SBhSm1ehya/Zir/hwy50TZGn/eYSP2nu4iEC+JzeIat8ATH4WT5899KHcPocsk+KLo6IzeSzoggWcSli3i6wsi3/HeJcULzbTn+r5JoIB0IOfUilsJ6aKhu0cf26dVq1G4cG4Z/s4PGsv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bEJ31olJ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6C9221F9D8;
	Fri, 28 Feb 2025 16:13:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740755639;
	bh=Hba3OPddqmnGuDnES7XnqkDAeIm8Aq9AiYitH82aoGY=; h=From:To:Subject;
	b=bEJ31olJuMURWHkviCt3MCT+NaBg2GBhN+P0kQLpFhkLzKmYUl+G2XcdKdLLvYrv4
	 K/2cuaZNo/EWQ7zkde/wW7UI0g78yucskujp0lCrXSHYuNMFQUuEvSl8lxzNi/2/0A
	 KkWAaAdDux/p6pV9EI8juHId4Iled9ceox3HOJL1D1IaorWyQPEX26pxJycpFqTbBZ
	 uAQhdWb9d3vUYGOFwE5LT4nyhoXao/GcqlOcZ6hUDVkavfP3CCebfiBlSEn6pkN/YQ
	 r88gUhxkfIuh+clbdgEQmSo2mkqd5EMeqVe0YVV8mPrH2orgDo6EeyE0zaVgzDWDo7
	 eia7dNDQhyQlQ==
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
Subject: [PATCH v2 2/4] ARM: dts: imx6qdl-apalis/colibri: Remove compatible from SoM dtsi
Date: Fri, 28 Feb 2025 16:13:50 +0100
Message-Id: <20250228151352.91768-3-francesco@dolcini.it>
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
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi  | 1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index dffab5aa8b9c..e42a553bdd3b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -10,7 +10,6 @@
 
 / {
 	model = "Toradex Apalis iMX6Q/D Module";
-	compatible = "toradex,apalis_imx6q", "fsl,imx6q";
 
 	aliases {
 		mmc0 = &usdhc3; /* eMMC */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index 9f33419c260b..fc61d5866b09 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -10,7 +10,6 @@
 
 / {
 	model = "Toradex Colibri iMX6DL/S Module";
-	compatible = "toradex,colibri_imx6dl", "fsl,imx6dl";
 
 	aliases {
 		mmc0 = &usdhc3; /* eMMC */
-- 
2.39.5


