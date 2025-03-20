Return-Path: <linux-kernel+bounces-569120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC26A69EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854581896880
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C691EB1B2;
	Thu, 20 Mar 2025 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="T7hkPuyh"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793A1EB9F9;
	Thu, 20 Mar 2025 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441254; cv=pass; b=FMYsliuTWy5jgiOOsAQWsKGbErKserTSvgH2wHRtB0INF9Z2Y4M23zUKlK34tFjrsBUwBWC02GzCeejOTqulPYvHqYyyGG/ery0JHAU/Bp+8uBEmwf2D4ysrGMFqEMWImeTDpV8hu/jpiYJgy+sR1LU0Wummk/QpUMHh+Rtn50U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441254; c=relaxed/simple;
	bh=IudflqImdm+ZwbpvNjpoNoGi2CoQwHJjQFVz8r3/Sj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myFIrJapjIs2Sw5NKj57Sb/XvgPOVVK5gsoCvaEoO++FA9M410qJzoOcChQvWHK7dYwzcfuAHRDfBkJ+Zeh70cc6P1cN5D5CtJx7Fa7JVMVnBqvV9g05Z17fRLD20cD2qtZdkF/eupaxysvUxpZfP0R9xQV3pSiV4cRI2pBGEtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=T7hkPuyh; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1742441208; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M91RKGSr9GXPeJUclI97wDiY6yuewKNBZJ/uQcEt3B0fjCpYT7eQe68tVQ62r3cVgFecF21+BVLY3Kck0U8OxhbQ+2nUBrawqrYFf+PDO3RFLC5+pGIbRAuwjyUwCeTTSSQSkTnzWm/i+ZbCfH7FzBByJc6MA6MgSPougyovLzk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742441208; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EPlebBCWRgSBAYpdwC7xAZIbyevkA4TQGmd5kkCqttQ=; 
	b=lRSRF0hZo71iCETweHM3XeI6qDZFQux317+c0IvYaOJ6NBLvH7u86bbz7aasmWGDB7bJSYdHJkziwDbuvSjlAh9o9XOkDX+OV9igot+srQBrA40U+xNLYR9b5S8x3RkrIvHyjc3cJnTF+HA/DLSNnBPLoNfaF6ah2jBkem65sK4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742441208;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=EPlebBCWRgSBAYpdwC7xAZIbyevkA4TQGmd5kkCqttQ=;
	b=T7hkPuyhJzgvyBBmI2oBTHhWxzKiwaZT0hYPLlrG+Haac5wc7QRs7Db8a8lZ74Wk
	0Ueh8MHyaIz1RHnlU+hHoJLdMdsIpY/c2iPOMQZd+ErRe4iNExeSxO+r/fv1MeKR4vY
	Cf9qOZjbyKW+4hEb3RUzTLtEX9MKftoyQAs/PZ7k=
Received: by mx.zohomail.com with SMTPS id 1742441205785629.6303235866446;
	Wed, 19 Mar 2025 20:26:45 -0700 (PDT)
From: Xukai Wang <kingxukai@zohomail.com>
Date: Thu, 20 Mar 2025 11:25:37 +0800
Subject: [PATCH RESEND v5 3/3] riscv: dts: canaan: Add clock definition for
 K230
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-k230-clk-v5-3-0e9d089c5488@zohomail.com>
References: <20250320-b4-k230-clk-v5-0-0e9d089c5488@zohomail.com>
In-Reply-To: <20250320-b4-k230-clk-v5-0-0e9d089c5488@zohomail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>
X-Mailer: b4 0.14.2
Feedback-ID: rr0801122750c07efbc0a0d500ba86f7f700009de018deec3b634dd7bbbbc91f3130829b1bda353269100654:zu08011227a8c7ad2a9b20f474ba12b64a00003f8a2c278a596cfb77449d647b6335dee01f06aa7350edb7cb:rf0801122c1a6d4852bdbff4e658c1f51d00003571b754f5174b768c1ac33936a8c1ed0c6331da4e991fd4a7d03d7d25ed:ZohoMail
X-ZohoMailClient: External

This patch describes the clock controller integrated in K230 SoC
and replace dummy clocks with the real ones for UARTs.

Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
---
 arch/riscv/boot/dts/canaan/k230.dtsi | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
index 95c1a3d8fb1192e30113d96d3e96329545bc6ae7..e688633acbbf2cee36354220c557252111f56ff5 100644
--- a/arch/riscv/boot/dts/canaan/k230.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
  */
 
+#include <dt-bindings/clock/canaan,k230-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 /dts-v1/;
@@ -58,10 +59,10 @@ l2_cache: l2-cache {
 		};
 	};
 
-	apb_clk: apb-clk-clock {
+	osc24m: clock-24m {
 		compatible = "fixed-clock";
-		clock-frequency = <50000000>;
-		clock-output-names = "apb_clk";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24m";
 		#clock-cells = <0>;
 	};
 
@@ -89,10 +90,18 @@ clint: timer@f04000000 {
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
 
+		sysclk: clock-controller@91102000 {
+			compatible = "canaan,k230-clk";
+			reg = <0x0 0x91102000 0x0 0x1000>,
+			      <0x0 0x91100000 0x0 0x1000>;
+			clocks = <&osc24m>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial@91400000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91400000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART0>;
 			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -102,7 +111,7 @@ uart0: serial@91400000 {
 		uart1: serial@91401000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91401000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART1>;
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -112,7 +121,7 @@ uart1: serial@91401000 {
 		uart2: serial@91402000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91402000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART2>;
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -122,7 +131,7 @@ uart2: serial@91402000 {
 		uart3: serial@91403000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91403000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART3>;
 			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -132,7 +141,7 @@ uart3: serial@91403000 {
 		uart4: serial@91404000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91404000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART4>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;

-- 
2.34.1


