Return-Path: <linux-kernel+bounces-259896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D3939F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212761C2202B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD4E14EC40;
	Tue, 23 Jul 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Bjft/Xh+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jzRwxecS"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4B14A0AE;
	Tue, 23 Jul 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732525; cv=none; b=HJIsGJJ/3miR4/OU+/cz5JxFtaKW7Q0Uva9P+LQu7QO4oXzYlsRm/p4aphvhSwOksmvb60KIKe/hrqNg8UlkJgCZWCEQIBSHEL3ylXbRiZQR2fA1eC/3DHh32dz2vrAK5iV9yE69foScnvyuR7P+fJdlUx7WYOkClAQgOV65gzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732525; c=relaxed/simple;
	bh=4tNi646ZnGWQWhHkZKMdb8W2R2nlTsC+jvBRyDnSsno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JG6f+giTv01h+c6oyNpNpkcdNlZPMkEdlsv1S6l3h4DsGIvxWT9AL6Ncyh60K/mCOmDj/thIUYb4pHqRC+JA2uhmCtMVN4fa9Mk6AU1tYriPRDVELepT6AhcxWdRaTLPOJaUTsXhSOMegEJF6bQI2E2gvOJ4GiSLER3LFYl2NHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Bjft/Xh+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=jzRwxecS reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721732521; x=1753268521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nhT72udXBVJSVN8T6HDpzXoKuiv7mterFLwXgGAx04A=;
  b=Bjft/Xh+CYKtKFZxfGM2tdun8NdH8WKf1iUxGQjyfKtY1BpEoaBiPx6y
   T0IdVCjYojNNXQQwh0jXBIs2lnc59MHg/EcB+NpZaR5gmH16mjENIdY0S
   9AvOYFv4p+5vMkUx+IocTJMiBWSB1iMaZjR4MahIom7yuF/vvrVlE/4ly
   tfnd2HQkFmFyGBBUHn0y62iw2Fbls32GYVuO4gv+5n9KbfDr17aiSF8cp
   PwcWHhTk0RJ3PT8MsLjzZo6wh9GTqOmEABCLWKipX+I+xl/60LBc61eoL
   SyCrWcAPdTc7txyrtHA0PRDQBZ7MavtO4luIp0E5Ys4NmXDDcMyziSGdx
   A==;
X-CSE-ConnectionGUID: KtMHRtnkSFaOQmbB5DPW2A==
X-CSE-MsgGUID: qiiMoHtNTxy7/f70otF4nA==
X-IronPort-AV: E=Sophos;i="6.09,230,1716242400"; 
   d="scan'208";a="38035062"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Jul 2024 13:01:51 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81D6E163353;
	Tue, 23 Jul 2024 13:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721732510; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=nhT72udXBVJSVN8T6HDpzXoKuiv7mterFLwXgGAx04A=;
	b=jzRwxecSDYEJzc/MvrF/ZOZUhTqaxFyY5KfxAR7qK6rqk6BZDhAfQFHr4dANvF8PZTjSqr
	EvQXH1e8IPFgJtVU6fjz2YMwvjyy6SrqifOs/eKNAr8VSkEBDGG+2Qh+tv62/kVrNCusOA
	dDesio11taawWV6SuOjfGzFmagPu+KRGPD6LLRhhupWj9nDIdUKN9t17aakjQZMaGCvWSD
	I9uqDVNp1tezIuyY83yuIcuRPC/xL29lBA5RnSjsqXIRFrx0Xa99OANymbtLCqcqaf+Y1b
	WSGbxorHp9InPb/RsnrXzpRJ/joqy1cQzHsr8YuLhnVPMR2btvV+mpWx4CIG9w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: imx8mm-tqma8mqml-mba8mx: Increase frequency for i2c busses
Date: Tue, 23 Jul 2024 13:01:46 +0200
Message-Id: <20240723110146.3133155-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

100kHz is only needed for the USB Hub TUSB8041. But as this device is not
connected by default, the speed can be increased.
The other busses don't have any 100kHz only devices attached.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi | 1 -
 arch/arm64/boot/dts/freescale/mba8mx.dtsi           | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
index ca0205b9019e6..8f58c84e14c8e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
@@ -83,7 +83,6 @@ &gpu_3d {
 };
 
 &i2c1 {
-	clock-frequency = <100000>;
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 815241526a0d3..520702a465a40 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -237,7 +237,6 @@ expander1: gpio@24 {
 };
 
 &i2c2 {
-	clock-frequency = <100000>;
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
@@ -258,6 +257,11 @@ sensor1: temperator-sensor@1f {
 		reg = <0x1f>;
 	};
 
+	/*
+	 * TUSB8041 is at 0x41, but not connected by default
+	 * Note: TUSB8041 only supports 100 kHz!
+	 */
+
 	eeprom3: eeprom@57 {
 		compatible = "nxp,se97b", "atmel,24c02";
 		reg = <0x57>;
@@ -274,7 +278,6 @@ pcieclk: clk@68 {
 };
 
 &i2c3 {
-	clock-frequency = <100000>;
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	pinctrl-1 = <&pinctrl_i2c3_gpio>;
-- 
2.34.1


