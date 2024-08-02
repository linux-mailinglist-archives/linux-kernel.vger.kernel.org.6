Return-Path: <linux-kernel+bounces-272099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8422945708
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F14F1F24304
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C7749647;
	Fri,  2 Aug 2024 04:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MXnyLsMc"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892F208D7;
	Fri,  2 Aug 2024 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572769; cv=none; b=lJ/n82ZB1To6X2xXTGrw/+Tfwhu/gfFnK00xgv5cA4GiPUbS9NzNY5INmLn8PIOGhcisTX0C4IBY0BuLDEbWLDCBj0ZdKwfFP1yoRYaGDsLRu102QdarFGYubL2jemTpsWgKVi2bifsQSqE3uMCfeCnNb/4/G3fK3UNvgQmvxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572769; c=relaxed/simple;
	bh=eQ3xjuA+JEu88iJIEIK6Xze5nI27b1Th7iuc+VKQ+V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+sDIdLxyX6AHYGOdWg0G4Bu8jROmpE2CLRsLphE3ptiXEqBYQUjWEko3wfdAxI/zD/B+56tLc6spEu2AHcdco7IX8puQ1VeW/5eP92J/9676a45JgYbDKy3E6mn9MfdQGPRp3rIC/FHRaBAn5r7+lEvtKbXdXG4u56trh+6zwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MXnyLsMc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722572765;
	bh=+Qq/WSoK+u2AglB77aeXcCPltkt+02ev2aFN48iHui0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MXnyLsMcLNgRuLeoYxizDxsxIcojn3n8Aym+9LTMJ9fzbxEWVRpR3cVKWtYNMqaXb
	 D6YEDeQ8KQCcwaIIF/QtiD2uqaHKo7j992KDS/PZVzUv1DLjIYRKoLmgdrW+AXcumF
	 NH8t1hTzBuq4aNLXHsAX7DGSe4fHikNFujirfrpTBEaufXRid9gDpd4zURQ2eUpdDm
	 J251oi0em97JIf9Sl2XGccNaYD+uCVxxQh+DaXqSsKG4xmWyfBGhioeCuC7nwKcBZx
	 EIrvPDcSQqb+KZzMMFsKeiNaKreGhD8P29slySlgk1H2Gs4pAXPn6hLQR9TgCgcdxb
	 hf75uljHDaSrw==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 041DC66E0A;
	Fri,  2 Aug 2024 12:26:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:21 +0930
Subject: [PATCH 4/7] ARM: dts: aspeed: Remove undocumented XDMA nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-bmc-dts-cleanups-v1-4-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1

There's no binding defined for the device, so remove it from the
devicetrees until someone has the motivation to write one.

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: /ahb/apb@1e6e0000/xdma@1e6e7000: failed to match any schema with compatible: ['aspeed,ast2500-xdma']
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts     |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts      |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi                 | 11 -----------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                 | 13 -------------
 7 files changed, 49 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
index 6fdda42575df..7364adc6b80d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
@@ -570,11 +570,6 @@ &wdt2 {
 	status = "okay";
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 &kcs2 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca8 0xcac>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 214b2e6a4c6d..513077a1f4be 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2486,11 +2486,6 @@ &wdt2 {
 	status = "okay";
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 &kcs2 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca8 0xcac>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index 5cb0094e21e0..0776b72c2199 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1722,11 +1722,6 @@ &wdt2 {
 	status = "okay";
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 &kcs2 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca8 0xcac>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index 213023bc5aec..b31eb8e58c6b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -870,11 +870,6 @@ &pinctrl {
 		    <&pinctrl_lsirq_default>;
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 &kcs2 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca8 0xcac>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
index a20a532fc280..7820bc829dff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
@@ -696,9 +696,4 @@ &video {
 	memory-region = <&video_engine_memory>;
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 #include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 100380417f99..57a699a7c149 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -281,17 +281,6 @@ gfx: display@1e6e6000 {
 				interrupts = <0x19>;
 			};
 
-			xdma: xdma@1e6e7000 {
-				compatible = "aspeed,ast2500-xdma";
-				reg = <0x1e6e7000 0x100>;
-				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
-				resets = <&syscon ASPEED_RESET_XDMA>;
-				interrupts-extended = <&vic 6>, <&scu_ic ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
-				aspeed,pcie-device = "bmc";
-				aspeed,scu = <&syscon>;
-				status = "disabled";
-			};
-
 			adc: adc@1e6e9000 {
 				compatible = "aspeed,ast2500-adc";
 				reg = <0x1e6e9000 0xb0>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 0c00882f111a..6505eebf91af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -398,19 +398,6 @@ gfx: display@1e6e6000 {
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			xdma: xdma@1e6e7000 {
-				compatible = "aspeed,ast2600-xdma";
-				reg = <0x1e6e7000 0x100>;
-				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
-				resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
-				reset-names = "device", "root-complex";
-				interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-						      <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
-				aspeed,pcie-device = "bmc";
-				aspeed,scu = <&syscon>;
-				status = "disabled";
-			};
-
 			adc0: adc@1e6e9000 {
 				compatible = "aspeed,ast2600-adc0";
 				reg = <0x1e6e9000 0x100>;

-- 
2.39.2


