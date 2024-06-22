Return-Path: <linux-kernel+bounces-225678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C97291339E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A651C21239
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A86815667D;
	Sat, 22 Jun 2024 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzZ44wqm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B234156256;
	Sat, 22 Jun 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719057608; cv=none; b=M6SLYFaf72QfaSLIKnMbaVaRSKLZnHBVq3gfq4PDduGnfTjGYl9M/hbt1dUi3az/PE+U0IRJBFiyyDLnoIi0RiiREEkYZm2MRbz95HryH2EOfINOPoi2va5TWLYKSXMc0WJO4M5yEzaOJWLKO4E6jCNBlxugt6yOWCUcClstkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719057608; c=relaxed/simple;
	bh=3jCP5+p8OwHDT1URzOdF6Rh2+Q/dzLWxjcH3FZfJk/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSiEdy1FO/r24uN19JV2YAdvRX/7xyQ350elG/TefmYCpr5B/8qUUvhiOD87KaljlQ8hPZ+9IGm35wNd++G4QwI8/tlRV/C/h3PwNSrusXPLXvAm5hqa7NkTgQafkztV2tVrO120g5zFys4RKcaeQXZBpTX0Wlicn5KOsSseKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzZ44wqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E771C4AF0B;
	Sat, 22 Jun 2024 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719057607;
	bh=3jCP5+p8OwHDT1URzOdF6Rh2+Q/dzLWxjcH3FZfJk/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AzZ44wqmqZ6FtIsaJIe1ciYgoNJ7kweTPzAYVKA1h0T4sj6L8mUGD+skVyLgScDMp
	 5Qogs06SXarXYwZ2WUCvgcPip/C7oj5jBZdGvQ8JWwGrgCGM+71mVnaMclqR295CHo
	 KP0im4RlVn3DWH0Jwh2TcxL7mDLMGIEppIOMNU8qTLv25PN2Lw/F4jjkp5VgLi7K4G
	 gA4V+R80CHdj+MTfYbxGQqs73HtAVTKi/kPyfaTNuDIPSMvKRojOGL0zvHyBgSrU32
	 /eWBGG+4CqFBc7i46OsQljj4Ga30NbgLot0c2FztOJHnY3y/W0dwPXs6dh22/xzvg+
	 ouIC4WdQSw2BA==
From: Roger Quadros <rogerq@kernel.org>
Date: Sat, 22 Jun 2024 14:59:56 +0300
Subject: [PATCH 1/2] arm: dts: ti: k3-am62: Add GPMC and ELM nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-am62lp-sk-nand-v1-1-caee496eaf42@kernel.org>
References: <20240622-am62lp-sk-nand-v1-0-caee496eaf42@kernel.org>
In-Reply-To: <20240622-am62lp-sk-nand-v1-0-caee496eaf42@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, praneeth@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>, Nitin Yadav <n-yadav@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=72YKhbTrhp1pdJ1S/lRwjx3eVCrZjWsyQ90EVdJ9urg=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmdrzBNvwd6RiwbPi9MyUEdGJQnlOSZq2mXU4OC
 C2iN/myUE+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZna8wQAKCRDSWmvTvnYw
 k5eeEACKhjsqVkgVY0mX+AabrezvrWNnim06t5qu9EQz1NeFv7M8QcOOK0SxtWPApizRSnSH3ti
 OnOXMTmDPHeNs6Ffn6mtsr3SkREvNAV+ELFZpgNm2iEouNBdh4/MZhTvrckM9zeuEhM6WNp8kCL
 rPZkRcRrTZmQs8scdllSR93bac0GS6JrVHTyi//nkf2UKpQwXVC21Nz83PsQ8PJGLvWBkTvsRcc
 Y+PGm1CqZxUUulRGXtWKkDcjLL0tVBoRH95XRDwcGTGWkmciIbKDMSAgGgnAQAEQa07DaM4TVfF
 DGnuDSMLqquA4WQEt1gR2KTA1dlUz4Y0kAFJ5iGMx72r5kN623vwj21QNe8ijBx9oVnqtvJ/k/P
 g7Pi29cT/Z2qq9u3TkXebf/BACZCpIE9NZBt0poh4iqsl9ZRXEBqGJY69ePEsusypeFAVGNFhQn
 kmTm1oaLqngu3D1/nCL/AbO2ZZTR6C7/NzgRtjJ8SImPEndmHKCnmuY7QnHECagNqAG9jVd8AnB
 4SokS066ip/jy9GsO7H8rD8Sfl8QcisH9oW5F7hfkWB2XaZSkSsP3znbR5pD4270lChO7M7hhhl
 osn/5uofo+E8g/hb291n4VYY6/hzojnrh1Xr/nZmy+SXpr2Mpc+J3fN3C1hYjdo4g7qguSIYX+J
 BtxMCfNzGijRxqA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

From: Nitin Yadav <n-yadav@ti.com>

Add GPMC and ELM device tree nodes for AM62 SoC family.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 29 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 00776a9987c1..e7e7cdc24e3d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -1053,4 +1053,33 @@ dphy0: phy@30110000 {
 		status = "disabled";
 	};
 
+	gpmc0: memory-controller@3b000000 {
+		compatible = "ti,am64-gpmc";
+		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 80 0>;
+		clock-names = "fck";
+		reg = <0x00 0x03b000000 0x00 0x400>,
+		      <0x00 0x050000000 0x00 0x8000000>;
+		reg-names = "cfg", "data";
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		gpmc,num-cs = <3>;
+		gpmc,num-waitpins = <2>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		status = "disabled";
+	};
+
+	elm0: ecc@25010000 {
+		compatible = "ti,am64-elm";
+		reg = <0x00 0x25010000 0x00 0x2000>;
+		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 54 0>;
+		clock-names = "fck";
+		status = "disabled";
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index f0781f2bea29..bfb55ca11323 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -68,11 +68,13 @@ cbass_main: bus@f0000 {
 			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
 			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
 			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
+			 <0x00 0x3b000000 0x00 0x3b000000 0x00 0x00000400>, /* GPMC0_CFG */
 			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */
 			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
 			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
 			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
 			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x08000000>, /* GPMC0 DATA */
 			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
 			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */

-- 
2.34.1


