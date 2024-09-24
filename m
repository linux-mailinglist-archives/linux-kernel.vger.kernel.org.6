Return-Path: <linux-kernel+bounces-337080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C095984502
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AEC1F24B18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D047D1A706B;
	Tue, 24 Sep 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="C+0R/Rcd"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6219B3DD;
	Tue, 24 Sep 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178062; cv=none; b=t9lrGSdsgx4pWLqFkrAafUR8y/IAaGM7Pqd5hPFX9iZA6GPggaDo6nOw1yAX51qHcoD0Tyn9kYD2jMF+5L9LvT1kFQUO+dUUIBc9JhhpMm2FI3v/HxSfl98+79HikcaPAWaouzHXBExQKnJbN2weFBsfHDjXhrBqn8zqthYNzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178062; c=relaxed/simple;
	bh=xIrP9KTp/tTBA4UAZUSLdwvUr9Weoz2sW9UrXOmTEaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwFEONeYUbZUXbCbZ6kfCa1gdiW0neUcTuvcOfTitXIQDrggWOuOUhsz3t35RLKALXJuZIN5cy2bGr7suaP5eM+vMXPw2/ajptb3AWtLHAjcdp0ur+G9lBKauDQHeoyY25pvWeVm4+QGc00FteSsEgaQUUaIZO0bMNDdd0NG07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=C+0R/Rcd; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7AC7A1FA9A;
	Tue, 24 Sep 2024 13:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727178059;
	bh=CTYJLKQj5+4WSe5KzEb0nne31FHRsw+we6LP7/uQrgI=; h=From:To:Subject;
	b=C+0R/RcdqxOnhnMoCUqI2gbAVolLnfjnCxEFtYAp0nU6sMXarlFQEDxxDWXT3qoBq
	 55xMmdtQp3xPCXb7Vs+AaRdKPShoFI79xs3mz6FnECIsfzZChg93atfUv/HlW2ux1q
	 ISl5BhvRclJL4T5CHgBFMF1fJsZLPvzubDbScpr5rAv3zkLbV8nEEJSUk7gOziO0wq
	 rGY6I4pbdljjm1jjgAfND0h8OXMSMSsKeJBfMcRhUo1wfSWo1HqKvMqrknBNQpeup/
	 sChMRoh3pRn4NWidAcVfgD6kBaz0yP+MJp0TWJY0bTAAgiPDGJqnB9u3BqhOAMJ4+S
	 /cSITVr2uv2IQ==
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
Subject: [PATCH v1 2/3] arm64: dts: freescale: imx8mp-verdin: add labels to som nodes
Date: Tue, 24 Sep 2024 13:40:52 +0200
Message-Id: <20240924114053.127737-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924114053.127737-1-francesco@dolcini.it>
References: <20240924114053.127737-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add labels to ti-ads1015 and fec ethernet mdio node to make it easier to
reference them from other nodes.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index a19ad5ee7f79..e9518b7c7aa8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -320,7 +320,7 @@ &fec {
 	pinctrl-0 = <&pinctrl_fec>;
 	pinctrl-1 = <&pinctrl_fec_sleep>;
 
-	mdio {
+	verdin_eth2_mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -591,11 +591,12 @@ hwmon_temp_module: sensor@48 {
 		vs-supply = <&reg_vdd_1v8>;
 	};
 
-	adc@49 {
+	verdin_som_adc: adc@49 {
 		compatible = "ti,ads1015";
 		reg = <0x49>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#io-channel-cells = <1>;
 
 		/* Verdin I2C_1 (ADC_4 - ADC_3) */
 		channel@0 {
-- 
2.39.5


