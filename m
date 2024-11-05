Return-Path: <linux-kernel+bounces-397159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D59E9BD781
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F121F23950
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B73216434;
	Tue,  5 Nov 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io0q0Zf9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F36216424;
	Tue,  5 Nov 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841533; cv=none; b=jcKNvaFwKTFEdPqXkwCDscI8lUC2wfym1kVVQA4V3EwSN1kwmQ7NlCD6UBkcKYQTYYKEpsqXYb/VsOmbu3lOnxKWEJeP7zw1IdhVuNmVMlfbzQF8eG3CqYSkSXUheXN93CeLjQ++otr2DAsJVmc1NfQaI0TcnLJEdPc6jMlSgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841533; c=relaxed/simple;
	bh=En2hPkHBBMmKe1JVp358wJIe+shZ/brfNZXSPnqrzrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6JGFL9fQqY598byjnuNJ1QxB0xU9m2W16msrL8rQZbQoCeL816GWjKVkYkYeQp6gr9bVGUJIMI2iEkcx5Z9b28/6BBWjD9xHx3oUJePy6Nb88yBkTDkPUc/tBan3pDPMe8WmAKxf/ulCQIHMd7/V4rinZMfprJ8Uh7kSAB7cjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io0q0Zf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A533C4CED4;
	Tue,  5 Nov 2024 21:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730841533;
	bh=En2hPkHBBMmKe1JVp358wJIe+shZ/brfNZXSPnqrzrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=io0q0Zf9yriBWQH2ety7yUT2nRhznVr1gFCNneaLd1fcJcH5xZ3t20ozKaiiQBuA0
	 FBuSyXC+nbBnwVE0G4Rb1OvjDpt0x/iCW3KPklj4YnSo1oVNBZ/8jehpbm2LG8XeED
	 ha8F5n2wy9gtDp3GagtwChoBIPmSJrq1Exb2N0zhDbKW4ToKqcD2Ox0gCYjViZjmYa
	 AASSkXsl6TQbQRLtKm3hCD+RdeDkLiFCSCL1unEt04jvEaNOBc5aIRLYHdA/DYy9Oe
	 /7RETzsYXlCjJfTsUr407H+nq0Mti4gIsagDP7MYFAdAvQwLoyAcBtEQLOFFMW4orl
	 9k8NT0y8q3ENA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 05 Nov 2024 15:18:40 -0600
Subject: [PATCH RESEND v2 2/2] arm64: dts: lg131x: Update spi clock
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-dts-spi-fixes-v2-2-623501e5d1ca@kernel.org>
References: <20241105-dts-spi-fixes-v2-0-623501e5d1ca@kernel.org>
In-Reply-To: <20241105-dts-spi-fixes-v2-0-623501e5d1ca@kernel.org>
To: soc@kernel.org, Kuldeep Singh <singh.kuldeep87k@gmail.com>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chanho Min <chanho.min@lge.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

From: Kuldeep Singh <singh.kuldeep87k@gmail.com>

PL022 binding require two clocks to be defined but LG1312 and LG1313
platforms don't comply with bindings and define only one clock.

Update spi clocks and clocks-names property by adding appropriate clock
reference to make it compliant with bindings.

CC: Chanho Min <chanho.min@lge.com>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Arnd, Please apply directly.
---
 arch/arm64/boot/dts/lg/lg1312.dtsi | 8 ++++----
 arch/arm64/boot/dts/lg/lg1313.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index b864ffa74ea8..bb0bcc6875dc 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -173,15 +173,15 @@ spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe800000 0x1000>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		spi1: spi@fe900000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe900000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		dmac0: dma-controller@c1128000 {
 			compatible = "arm,pl330", "arm,primecell";
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index 996fb39bb50c..c07d670bc465 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -173,15 +173,15 @@ spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe800000 0x1000>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		spi1: spi@fe900000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe900000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		dmac0: dma-controller@c1128000 {
 			compatible = "arm,pl330", "arm,primecell";

-- 
2.45.2


