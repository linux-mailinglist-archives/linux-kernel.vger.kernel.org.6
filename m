Return-Path: <linux-kernel+bounces-310276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A32967752
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE65E1F217C0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F75186616;
	Sun,  1 Sep 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="KtH+u+p0"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0A185928;
	Sun,  1 Sep 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206272; cv=none; b=l8kExz68lWgD31JX/uWmullJROzFWkN3f5DsZEkqcA+YKFOI+s1M06uVfDw2FZBE/gwNJOL/oQb1q4tKbadDdnsBDwZWl/CpCirEQ695bVT7TsrEbuM6oCG/dB45FQYnIbDq6VzLvg3vw4iqCwDsNqa+U6actdEeAmNuIEP3lZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206272; c=relaxed/simple;
	bh=ITKZFk/k8SSne4UaKrNRejiQwUED16A4CuC2mW7CXuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIDE/RTNE/gLbyAMlP8d93goNvDndII/k70v/88gfxYZ0ZggN09ZhNztKmgJOFpxKzanZfUTn0W/1nSOadFokWGl6jj+8DH9EXB1LLPtfqiVZocQFL8Aq67/eIus0W/yD0z9MQph+OznBdm31hsqHoipRiX27EX6WLTYtLD6ZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=KtH+u+p0; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D603A1FB21;
	Sun,  1 Sep 2024 17:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206261;
	bh=C7ZOumTw1p40Es14ioXFW4jyqIiwFLtpXfMrrFijnPs=; h=From:To:Subject;
	b=KtH+u+p0NeBh2WQFw1lhOvD0/G5ZQD9etbivqCMe+l2DVt/PNHQFP0OmfEoXJUENk
	 CdXqfVMPaocsWBpAza/YETOM93tXRDKmDKGOmwneHLC/sUnKUqHCcjbaXMwQjqTaE/
	 ox2yBaW2y97nyLgFunR1+L5SQPXb9jQv0bTbAUN90naBrR8+p7p9l4+EDK9+k4WW/K
	 kjagGEhOtUxJ9mQDWbOoMD4UOfLOrO2y5B+Jmj/VHAcPXTrJOzhBUCbq0cGM4Jl5P4
	 AjXJSAESAUEV5B0Ox5EFAxmcA9DFPsyzTsw4gY83/Ju1qkJ0sJ80y5kuQnyeiNE3Il
	 z9dr1kJWXRlYg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 09/10] arm64: dts: colibri-imx8x: Add 50mhz clock for eth
Date: Sun,  1 Sep 2024 17:57:20 +0200
Message-Id: <20240901155721.7912-10-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901155721.7912-1-francesco@dolcini.it>
References: <20240901155721.7912-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philippe Schenker <philippe.schenker@toradex.com>

Change enet0_lpcg to get the clock value needed in Colibri-iMX8X for
100mbps ethernet.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 7a40a827ef75..cf689904c166 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -106,6 +106,21 @@ &cpu_crit0 {
 	type = "critical";
 };
 
+&enet0_lpcg {
+	clocks = <&clk IMX_SC_R_ENET_0 IMX_SC_PM_CLK_PER>,
+		 <&clk IMX_SC_R_ENET_0 IMX_SC_PM_CLK_PER>,
+		 <&conn_axi_clk>,
+		 <&clk IMX_SC_R_ENET_0 IMX_SC_C_DISABLE_50>,
+		 <&conn_ipg_clk>,
+		 <&conn_ipg_clk>;
+	clock-output-names = "enet0_lpcg_timer_clk",
+			     "enet0_lpcg_txc_sampling_clk",
+			     "enet0_lpcg_ahb_clk",
+			     "enet0_lpcg_ref_50mhz_clk",
+			     "enet0_lpcg_ipg_clk",
+			     "enet0_lpcg_ipg_s_clk";
+};
+
 /* TODO flexcan1 - 3 */
 
 /* TODO GPU */
-- 
2.39.2


