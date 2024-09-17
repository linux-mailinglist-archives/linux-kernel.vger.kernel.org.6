Return-Path: <linux-kernel+bounces-331377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD597AC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2583284E64
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04191531C2;
	Tue, 17 Sep 2024 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Wvaelxph"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD761FCE;
	Tue, 17 Sep 2024 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558048; cv=none; b=cog8/TJX4SYakcJXMK3rkNRLnVkL71WPm4q0cIsVMRtNC3JQnADMD9dp7m9rF5m7+NhssHgXmpKCevLPuiY0rF9Tfjdcavxes3H7w9MqqHSuKNBcvOYdI0b3UtBIAzhZuXE+61+zZtoS1C/m18ecRQPDCzk5SPn56HjPosNqw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558048; c=relaxed/simple;
	bh=oD+t+jNGTRkU19nK4oGnBU8RsqVKQ3nAjA6hIRxuNKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DX9+I/XgM8wC9lreKeWCYHpXfX6Aiwb43amUcy7c8ARkrTkCSOP86zfsAs2qL6DceFYjGRDf/QRPt4phwnhHx3IeFO3zgvIOj34hGbqsYdI9TXxsj/02lyaxkpHXFyIbAjqNQKp+E8Obe2c60/I59O3IqM6EUm1FvTel8pIsGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Wvaelxph; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F0231486936;
	Tue, 17 Sep 2024 09:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726558038; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PaGslVzUvMf4ZLkj7aVsDIG+nfFcVU182X0uhMNizEo=;
	b=WvaelxphwqXWfYnVXD3dNak0XkmAOOGPDzr6ZupxM5KTwtj3YyAj5Y0wjisvuhAy1jVOMh
	nKMcSuUZXQvUFwh0N9uc5wZUu9d7OaRrsc6TSDRc73sCcKekFcVIlU5CwQ8yA2QzKW30JX
	l4X/64cegbUAUi4a8P+OPv5V+4aFsH4TDolTdcYCzSZGM/4R2pphBBWwK8eJp7eCb30tsC
	Pwac0VeSF5PBpKgKJGqTKBRcIeTHBEJeUXDHCMhyaawe2iLRaj4TbZcdmua6fQ6Cn5uCQA
	zA3KZVFHFBPKuFUfkfJsR5Nb8euAo4vocFxGxeP4RieF5m3svuTm7iNc9IhDSw==
From: Alexander Dahl <ada@thorsis.com>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] ARM: dts: microchip: Unify rng node names
Date: Tue, 17 Sep 2024 09:27:10 +0200
Message-Id: <20240917072710.125435-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240917072710.125435-1-ada@thorsis.com>
References: <20240917072710.125435-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Using a generic name common over different platforms and matching the
recent atmel rng binding now.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
Suggested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/microchip/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/microchip/sam9x60.dtsi     | 2 +-
 arch/arm/boot/dts/microchip/sama5d2.dtsi     | 2 +-
 arch/arm/boot/dts/microchip/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/microchip/sama5d4.dtsi     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
index 02bd5a1833e8..072576dd6f7b 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
@@ -753,7 +753,7 @@ macb0: ethernet@fffbc000 {
 				status = "disabled";
 			};
 
-			trng: trng@fffcc000 {
+			trng: rng@fffcc000 {
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xfffcc000 0x100>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 291540e5d81e..b1a4b68e4b0c 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -478,7 +478,7 @@ sha: crypto@f002c000 {
 				clock-names = "sha_clk";
 			};
 
-			trng: trng@f0030000 {
+			trng: rng@f0030000 {
 				compatible = "microchip,sam9x60-trng";
 				reg = <0xf0030000 0x100>;
 				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
index 2fefe3efa769..3f99451aef83 100644
--- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
@@ -1019,7 +1019,7 @@ AT91_XDMAC_DT_PER_IF(1) |
 				};
 			};
 
-			trng: trng@fc01c000 {
+			trng: rng@fc01c000 {
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xfc01c000 0x100>;
 				interrupts = <47 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/microchip/sama5d3.dtsi b/arch/arm/boot/dts/microchip/sama5d3.dtsi
index 8335e0c8066f..4816e87c9777 100644
--- a/arch/arm/boot/dts/microchip/sama5d3.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d3.dtsi
@@ -419,7 +419,7 @@ tdes: crypto@f803c000 {
 				clock-names = "tdes_clk";
 			};
 
-			trng: trng@f8040000 {
+			trng: rng@f8040000 {
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xf8040000 0x100>;
 				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/microchip/sama5d4.dtsi b/arch/arm/boot/dts/microchip/sama5d4.dtsi
index 20b8a9b123e1..a577b6ee1747 100644
--- a/arch/arm/boot/dts/microchip/sama5d4.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d4.dtsi
@@ -658,7 +658,7 @@ macb1: ethernet@fc028000 {
 				status = "disabled";
 			};
 
-			trng: trng@fc030000 {
+			trng: rng@fc030000 {
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xfc030000 0x100>;
 				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.39.5


