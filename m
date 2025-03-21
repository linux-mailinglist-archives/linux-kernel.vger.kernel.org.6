Return-Path: <linux-kernel+bounces-570637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F80DA6B2E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDD2189D674
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930481E260A;
	Fri, 21 Mar 2025 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzHSf57q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F71A7264;
	Fri, 21 Mar 2025 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523838; cv=none; b=P75AQe3RHakQj42cGA8Wk1d5PnwUVCafQ1MWWawu2aTICv8+adjXopqkkUZbOiL5v4M62X3WfNPMcCzkGQuFwCAvgWh8yfjGAbSDITXXBn5y/v2Za+H4PIowXmB9i8nP9Du5itSLoCyqOJveq8ew0L2G9Nv6g7tH5fzLaUSG3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523838; c=relaxed/simple;
	bh=8+YFngRA+RL4itCdSnDqokhyCF25uPzsqjoBvzUhdHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZnCdaCTdpUFzAFT+rUKjvo3JyozLXxa0QRaMTj4DaI0HNo9N9d6RNwApG/Y0wsZb7N1W7pIuTBLFhHFOJXhgTjV+9QSn6tbuoi+S9WxDXoWQAtihZt7fVsa0VU+u3UzmIQEtVdPsvIUdfZxt9Dts8fNCc8E9y6ME4dwZIh4BINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzHSf57q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BE08C4CEDD;
	Fri, 21 Mar 2025 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742523837;
	bh=8+YFngRA+RL4itCdSnDqokhyCF25uPzsqjoBvzUhdHI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=PzHSf57qgUf0FB7TATdmiJPPa16kAxxbeQBubmAv6ILpPwJ122YZbqrk1X3sZm0P9
	 uYTzERiVqmRIg4+ruKUo/315IOkh83+bjOW9WxlSh8ShgcGv86JYxt/sCiGZzffVgB
	 D86c3m9ZcKJB1PvS91lDdps3G6VYd4TauQqJJs+4w4tF014A79xqGuc57R8YiyFjlW
	 KY/y0CcrhSUgQDzfcxOXOy0b0nNEh5tyOXMBrAsGfGr0UGsHrC1D57jChsaAvbGssF
	 kgtxtyGK8941NGmLaxtZ9awMirQ319DxPHgkR9fkgldMd3dfcsPfxVb+VRDzUU8oHR
	 IZ1ETZ1yHTacg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA7C28B30;
	Fri, 21 Mar 2025 02:23:57 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 21 Mar 2025 10:23:55 +0800
Subject: [PATCH] arm64: dts: amlogic: a4: fix dtb compilation warning
 issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-fix-a4-pinctrl-node-v1-1-5719f9f09932@amlogic.com>
X-B4-Tracking: v=1; b=H4sIALrN3GcC/x2MSQqAMAwAvyI5G6hacfmKeOgSNSBRWhGh+HeLx
 4GZSRApMEUYiwSBbo58SIaqLMBtRlZC9pmhVnWrmqrDhR80Gk8Wd4Ud5fCEgzV28VqT6lvI5Rk
 oa/91mt/3A56PuNllAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742523835; l=4994;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=IChqhCiVUHKV/Al5PYyBFG4RW3XtS/W3OF9ZWLm5x5E=;
 b=m1lud64/wUROGiLfKAlu7eDbYTf4Y/RBj9k8nVltMlE3s359FZ3sUFC3hN+43NIu5AYW0uFlA
 lrPSd5xEnI7BMBENznF5Jnx4nBvPjA9G6DiGs92ZaYgeF6zaOd2etNW
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

When use command 'make ARCH=arm64 dtbs_check W=1' to compile dtb,
a warning message appears.
"Warning (simple_bus_reg): /soc/bus@fe000000/pinctrl:
missing or empty reg/ranges property"

Add the unit address to the pinctrl node to fix it.

Fixes: ce78f679e08c ("arm64: dts: amlogic: a4: add pinctrl node")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 102 +++++++++++++++-------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index fa80fa365f13..582e0043024b 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -51,87 +51,52 @@ pwrc: power-controller {
 };
 
 &apb {
-	gpio_intc: interrupt-controller@4080 {
-		compatible = "amlogic,a4-gpio-intc",
-			     "amlogic,meson-gpio-intc";
-		reg = <0x0 0x4080 0x0 0x20>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		amlogic,channel-interrupts =
-			<10 11 12 13 14 15 16 17 18 19 20 21>;
-	};
-
-	gpio_ao_intc: interrupt-controller@8e72c {
-		compatible = "amlogic,a4-gpio-ao-intc",
-			     "amlogic,meson-gpio-intc";
-		reg = <0x0 0x8e72c 0x0 0x0c>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		amlogic,channel-interrupts = <140 141>;
-	};
-
-	periphs_pinctrl: pinctrl {
+	periphs_pinctrl: pinctrl@4000 {
 		compatible = "amlogic,pinctrl-a4";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x0 0x0 0x0 0x4000 0x0 0x280>;
 
-		gpiox: gpio@4100 {
-			reg = <0 0x4100 0 0x40>, <0 0x400c 0 0xc>;
+		gpiox: gpio@100 {
+			reg = <0 0x100 0 0x40>, <0 0xc 0 0xc>;
 			reg-names = "gpio", "mux";
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_X<<8) 18>;
 		};
 
-		gpiot: gpio@4140 {
-			reg = <0 0x4140 0 0x40>, <0 0x402c 0 0xc>;
+		gpiot: gpio@140 {
+			reg = <0 0x140 0 0x40>, <0 0x2c 0 0xc>;
 			reg-names = "gpio", "mux";
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_T<<8) 23>;
 		};
 
-		gpiod: gpio@4180 {
-			reg = <0 0x4180 0 0x40>, <0 0x4040 0 0x8>;
+		gpiod: gpio@180 {
+			reg = <0 0x180 0 0x40>, <0 0x40 0 0x8>;
 			reg-names = "gpio", "mux";
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_D<<8) 16>;
 		};
 
-		gpioe: gpio@41c0 {
-			reg = <0 0x41c0 0 0x40>, <0 0x4048 0 0x4>;
+		gpioe: gpio@1c0 {
+			reg = <0 0x1c0 0 0x40>, <0 0x48 0 0x4>;
 			reg-names = "gpio", "mux";
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_E<<8) 2>;
 		};
 
-		gpiob: gpio@4240 {
-			reg = <0 0x4240 0 0x40>, <0 0x4000 0 0x8>;
+		gpiob: gpio@240 {
+			reg = <0 0x240 0 0x40>, <0 0 0 0x8>;
 			reg-names = "gpio", "mux";
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_B<<8) 14>;
 		};
 
-		gpioao: gpio@8e704 {
-			reg = <0 0x8e704 0 0x16>, <0 0x8e700 0 0x4>;
-			reg-names = "gpio", "mux";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_AO<<8) 7>;
-		};
-
-		test_n: gpio@8e744 {
-			reg = <0 0x8e744 0 0x20>;
-			reg-names = "gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_TEST_N<<8) 1>;
-		};
-
 		func-uart-a {
 			uart_a_default: group-uart-a-pins1 {
 				pinmux = <AML_PINMUX(AMLOGIC_GPIO_X, 11, 1)>,
@@ -186,4 +151,47 @@ uart_e_default: group-uart-e-pins {
 			};
 		};
 	};
+
+	gpio_intc: interrupt-controller@4080 {
+		compatible = "amlogic,a4-gpio-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x4080 0x0 0x20>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts =
+			<10 11 12 13 14 15 16 17 18 19 20 21>;
+	};
+
+	ao_pinctrl: pinctrl@8e700 {
+		compatible = "amlogic,pinctrl-a4";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x8e700 0x0 0x80>;
+
+		gpioao: gpio@4 {
+			reg = <0 0x4 0 0x16>, <0 0 0 0x4>;
+			reg-names = "gpio", "mux";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_AO<<8) 7>;
+		};
+
+		test_n: gpio@44 {
+			reg = <0 0x44 0 0x20>;
+			reg-names = "gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_TEST_N<<8) 1>;
+		};
+	};
+
+	gpio_ao_intc: interrupt-controller@8e72c {
+		compatible = "amlogic,a4-gpio-ao-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x8e72c 0x0 0x0c>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts = <140 141>;
+	};
+
 };

---
base-commit: 73a143e436311183186ab4b365a84c662f2c9651
change-id: 20250317-fix-a4-pinctrl-node-9babfd44e085

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



