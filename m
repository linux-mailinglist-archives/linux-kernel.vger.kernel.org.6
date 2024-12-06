Return-Path: <linux-kernel+bounces-435235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843709E74D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F090288551
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF0207E1A;
	Fri,  6 Dec 2024 15:46:37 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2280BFF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499996; cv=none; b=cYkTKAS/4233REQnjaYjzWS066tDvLzfAuF2tfe/NRvyqbRNo92iOvLypA10mCoBEZo3HqtOc2COYPi8B+7DQ1UqDcHk5k+veh5wmncVNOmmuu+O7Q0MhWYCrge2oRG1bhWhvBEZ48oEXUmrH/7goghYWysZhdhoEF3XCENI5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499996; c=relaxed/simple;
	bh=V5nz6mxM1/xGmw+dO9lXo+ac2rwTfl618bkLJW6vL2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JnIIqEJQuz7J9es2Bm5RZNxR9MXGNuQoPDVUie505jvKKMK0zvC2OK9iYi3AdZVu7M7Mk3DRwWvLQ4+9+1j5c649+hKNHUgs5RVzXdwdxjl0oVl/d7fGlIgOBg+ZexwUtcOmjjT5BqUs62K0UW330yLf8u2Sg1YL8Sevuon3Rps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y4bG85qNJztSm;
	Fri,  6 Dec 2024 16:46:24 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y4bG81dM8z6Rx;
	Fri,  6 Dec 2024 16:46:24 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 06 Dec 2024 16:46:17 +0100
Subject: [PATCH] arm64: dts: rockchip: minimal support for Pre-ICT tester
 adapter for RK3588 Jaguar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pre-ict-jaguar-v1-1-7f660bd4b70c@cherry.de>
X-B4-Tracking: v=1; b=H4sIAEgcU2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwMz3YIioFByiW5WYnppYpFukqVBWmJaaqpFUoqFElATUDotswJsYHR
 sbS0AYe0Q72AAAAA=
X-Change-ID: 20241206-pre-ict-jaguar-b90fafee8bd8
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

The Pre-ICT tester adapter connects to RK3588 Jaguar SBC through its
proprietary Mezzanine connector.

It exposes a PCIe Gen2 1x M.2 connector and two proprietary camera
connectors. Support for the latter will come once the rest of the camera
stack is supported.

Additionally, the adapter loops some GPIOs together as well as route
some GPIOs to power rails.

This adapter is used for manufacturing RK3588 Jaguar to be able to test
the Mezzanine connector is properly soldered.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
GPIO3A3, GPIO3A4, GPIO3B2 and GPIO3D2 to GPIO3D5 are all routed to power
rails and can only be used as input and their bias are important to be
able to properly detect soldering issues.
---
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../dts/rockchip/rk3588-jaguar-pre-ict-tester.dtso | 171 +++++++++++++++++++++
 2 files changed, 172 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 86cc418a2255cdc22f1d503e9519d2d9572d4e9d..60074d21d92b4800bdc555648a9360e13d19febc 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -139,6 +139,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6b-io.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-friendlyelec-cm3588-nas.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-jaguar.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-jaguar-pre-ict-tester.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6-lts.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-ok3588-c.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar-pre-ict-tester.dtso b/arch/arm64/boot/dts/rockchip/rk3588-jaguar-pre-ict-tester.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..9d44dfe2f30d793accb994a230c58038f0c3daad
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar-pre-ict-tester.dtso
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2024 Cherry Embedded Solutions GmbH
+ *
+ * Device Tree Overlay for the Pre-ICT tester adapter for the Mezzanine
+ * connector on RK3588 Jaguar.
+ *
+ * This adapter has a PCIe Gen2 x1 M.2 M-Key connector and two proprietary
+ * camera connectors (each their own I2C bus, clock, reset and PWM lines as well
+ * as 2-lane CSI).
+ *
+ * This adapter routes some GPIOs to power rails and loops together some other
+ * GPIOs.
+ *
+ * This adapter is used during manufacturing for validating proper soldering of
+ * the mezzanine connector.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+&{/} {
+	pre_ict_tester_vcc_1v2: regulator-pre-ict-tester-vcc-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "pre_ict_tester_vcc_1v2";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	pre_ict_tester_vcc_2v8: regulator-pre-ict-tester-vcc-2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "pre_ict_tester_vcc_2v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+};
+
+&combphy0_ps {
+	status = "okay";
+};
+
+&gpio3 {
+	pinctrl-0 = <&pre_ict_pwr2gpio>;
+	pinctrl-names = "default";
+};
+
+&pcie2x1l2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2x1l2_perstn_m0>;
+	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>; /* PCIE20X1_2_PERSTN_M0 */
+	vpcie3v3-supply = <&vcc_3v3_s3>;
+	status = "okay";
+};
+
+&pinctrl {
+	pcie2x1l2 {
+		pcie2x1l2_perstn_m0: pcie2x1l2-perstn-m0 {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pre-ict-tester {
+		pre_ict_pwr2gpio: pre-ict-pwr2gpio-pins {
+			rockchip,pins =
+			/*
+			 * GPIO3_A3 requires two power rails to be properly
+			 * routed to the mezzanine connector to report a proper
+			 * value: VCC_1V8_S0_1 and VCC_IN_2. It may report an
+			 * incorrect value if VCC_1V8_S0_1 isn't properly routed,
+			 * but GPIO3_C6 would catch this HW soldering issue.
+			 * If VCC_IN_2 is properly routed, GPIO3_A3 should be
+			 * LOW. The signal shall not read HIGH in the event
+			 * GPIO3_A3 isn't properly routed due to soldering
+			 * issue. Therefore, let's enforce a pull-up (which is
+			 * the SoC default for this pin).
+			 */
+				<3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
+			/*
+			 * GPIO3_A4 is directly routed to VCC_1V8_S0_2 power
+			 * rail. It should be HIGH if all is properly soldered.
+			 * To guarantee that, a pull-down is enforced (which is
+			 * the SoC default for this pin) so that LOW is read if
+			 * the loop doesn't exist on HW (soldering issue on
+			 * either signals).
+			 */
+				<3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>,
+			/*
+			 * GPIO3_B2 requires two power rails to be properly
+			 * routed to the mezzanine connector to report a proper
+			 * value: VCC_1V8_S0_1 and VCC_IN_1. It may report an
+			 * incorrect value if VCC_1V8_S0_1 isn't properly routed,
+			 * but GPIO3_C6 would catch this HW soldering issue.
+			 * If VCC_IN_1 is properly routed, GPIO3_B2 should be
+			 * LOW. This is an issue if GPIO3_B2 isn't properly
+			 * routed due to soldering issue, because GPIO3_B2
+			 * default bias is pull-down therefore being LOW. So
+			 * the worst case scenario and the pass scenario expect
+			 * the same value. Make GPIO3_B2 a pull-up so that a
+			 * soldering issue on GPIO3_B2 reports HIGH but proper
+			 * soldering reports LOW.
+			 */
+				<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
+			/*
+			 * GPIO3_C6 is directly routed to VCC_1V8_S0_1 power
+			 * rail. It should be HIGH if all is properly soldered.
+			 * This is an issue if GPIO3_C6 or VCC_1V8_S0_1 isn't
+			 * properly routed due to soldering issue, because
+			 * GPIO3_C6 default bias is pull-up therefore being HIGH
+			 * in all cases:
+			 *  - GPIO3_C6 is floating (so HIGH) if GPIO3_C6 is not
+			 *    routed properly,
+			 *  - GPIO3_C6 is floating (so HIGH) if VCC_1V8_S0_1 is
+			 *    not routed properly,
+			 *  - GPIO3_C6 is HIGH if everything is proper,
+			 * Make GPIO3_C6 a pull-down so that a soldering issue
+			 * on GPIO3_C6 or VCC_1V8_S0_1 reports LOW but proper
+			 * soldering reports HIGH.
+			 */
+				<3 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>,
+			/*
+			 * GPIO3_D2 is routed to VCC_5V0_1 power rail through a
+			 * voltage divider on the adapter.
+			 * It should be HIGH if all is properly soldered.
+			 * To guarantee that, a pull-down is enforced (which is
+			 * the SoC default for this pin) so that LOW is read if
+			 * the loop doesn't exist on HW (soldering issue on
+			 * either signals).
+			 */
+				<3 RK_PD2 RK_FUNC_GPIO &pcfg_pull_down>,
+			/*
+			 * GPIO3_D3 is routed to VCC_5V0_2 power rail through a
+			 * voltage divider on the adapter.
+			 * It should be HIGH if all is properly soldered.
+			 * To guarantee that, a pull-down is enforced (which is
+			 * the SoC default for this pin) so that LOW is read if
+			 * the loop doesn't exist on HW (soldering issue on
+			 * either signals).
+			 */
+				<3 RK_PD3 RK_FUNC_GPIO &pcfg_pull_down>,
+			/*
+			 * GPIO3_D4 is routed to VCC_3V3_S3_1 power rail through
+			 * a voltage divider on the adapter.
+			 * It should be HIGH if all is properly soldered.
+			 * To guarantee that, a pull-down is enforced (which is
+			 * the SoC default for this pin) so that LOW is read if
+			 * the loop doesn't exist on HW (soldering issue on
+			 * either signals).
+			 */
+				<3 RK_PD4 RK_FUNC_GPIO &pcfg_pull_down>,
+			/*
+			 * GPIO3_D5 is routed to VCC_3V3_S3_2 power rail through
+			 * a voltage divider on the adapter.
+			 * It should be HIGH if all is properly soldered.
+			 * To guarantee that, a pull-down is enforced (which is
+			 * the SoC default for this pin) so that LOW is read if
+			 * the loop doesn't exist on HW (soldering issue on
+			 * either signals).
+			 */
+				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};

---
base-commit: b8f52214c61a5b99a54168145378e91b40d10c90
change-id: 20241206-pre-ict-jaguar-b90fafee8bd8

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


