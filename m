Return-Path: <linux-kernel+bounces-569430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E373BA6A2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE6D3BEC34
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453D224235;
	Thu, 20 Mar 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY9lf+wM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221E1F0984;
	Thu, 20 Mar 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463759; cv=none; b=VDtHpvaiNWsigx0w034YHJ4Ycu5wm3Y8x60lcynF2t1Xa7hQZnBBgDhzNOINj30PNh6E9AwaOVxNKk8xu2m7oCgG5wPgxkfRNTKfAi+yxZ8JNnhuqAeHlm2L7BsFyOGKCpUzAsyUucGJrWaJCdU0UKzpjIarukzCooiUUe28l5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463759; c=relaxed/simple;
	bh=KVMP+KP4loWBPX8Ab8zvnYv5rM2SYyJlpChJv4S7Ph0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhGAKrP+gKjR/8G7B2JVl+GT4itwefcIZEcnRRSNZRU0GG7He8AvOHcrWVm9QoKt/e7rEXECdu5yy5c83JUV6jzBSKyF72Jmy3730LAi3iLjW9nnt9UsNjYhv0zOMazw0vlwv5pYQDl7kXwyXI8wzKTqUt8BQ076i8+UW83gbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY9lf+wM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 010A4C4CEE8;
	Thu, 20 Mar 2025 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742463759;
	bh=KVMP+KP4loWBPX8Ab8zvnYv5rM2SYyJlpChJv4S7Ph0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mY9lf+wMvcsugdnmpe51JPmX72Ymdx/hbUUcqy9N3N5YOJW3e4yxkhTQrcfq+0cax
	 NA5wThSwoE//jtXmRB7YAg2xdcvVER/9DntwxC9MD7Wb0t3thWQf54JEL6ndFbUG7P
	 F3b/hbZioyDBvgqOKJ6d4VLO8rmEspZVV2EHnGZcrg8cJg3aTiDP6LT/aAOsLC/j0A
	 O6H8xNn3GF/bO5o++OEykpX6Kv05ULPH39rWHPtcKcH+k6pPx+FyCOea+unDernvdj
	 VOlOqXJwitW8X1dfwlMsSj8EMU655I2vMqbedPPrXIKtfqRhg70yyKJJw6rYftSMn7
	 pbS8NeBIBM8Ug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B5C36004;
	Thu, 20 Mar 2025 09:42:38 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Thu, 20 Mar 2025 17:42:09 +0800
Subject: [PATCH v5 2/3] arm64: dts: amlogic: Add A4 Reset Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-a4-a5-reset-v5-2-296f83bf733d@amlogic.com>
References: <20250320-a4-a5-reset-v5-0-296f83bf733d@amlogic.com>
In-Reply-To: <20250320-a4-a5-reset-v5-0-296f83bf733d@amlogic.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zelong Dong <zelong.dong@amlogic.com>, 
 Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742463756; l=3871;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=zH5X8psdvMQvBp31WZm+TBpjs/7nrtzcnxMyMa/Bno8=;
 b=wjbX/xleJxuYs/ldvJ677IkJc8tgumu1s+lZ8LBMmgQsS1ztYmBTZTgMRJKk6GVZXGHq95oQ0
 A3rh1k9l1HRB1YigJav6oXwePrLqhA180bLSSAE0i69cAMzaqEtoREF
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Zelong Dong <zelong.dong@amlogic.com>

Add the device node and related header file for Amlogic
A4 reset controller.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Link: https://lore.kernel.org/r/20240918074211.8067-3-zelong.dong@amlogic.com
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h | 93 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi    |  8 +++
 2 files changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h b/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
new file mode 100644
index 0000000000000000000000000000000000000000..f6a4c90bab3cf7cfaa3c98c522bed5e455b73bd3
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __DTS_AMLOGIC_A4_RESET_H
+#define __DTS_AMLOGIC_A4_RESET_H
+
+/* RESET0 */
+/*						0-3 */
+#define RESET_USB				4
+/*						5-6*/
+#define RESET_U2PHY22				7
+#define RESET_USBPHY20				8
+#define RESET_U2PHY21				9
+#define RESET_USB2DRD				10
+#define RESET_U2H				11
+#define RESET_LED_CTRL				12
+/*						13-31 */
+
+/* RESET1 */
+#define RESET_AUDIO				32
+#define RESET_AUDIO_VAD				33
+/*						34*/
+#define RESET_DDR_APB				35
+#define RESET_DDR				36
+#define RESET_VOUT_VENC				37
+#define RESET_VOUT				38
+/*						39-47 */
+#define RESET_ETHERNET				48
+/*						49-63 */
+
+/* RESET2 */
+#define RESET_DEVICE_MMC_ARB			64
+#define RESET_IRCTRL				65
+/*						66*/
+#define RESET_TS_PLL				67
+/*						68-72*/
+#define RESET_SPICC_0				73
+#define RESET_SPICC_1				74
+/*						75-79*/
+#define RESET_MSR_CLK				80
+/*						81*/
+#define RESET_SAR_ADC				82
+/*						83-87*/
+#define RESET_ACODEC				88
+/*						89-90*/
+#define RESET_WATCHDOG				91
+/*						92-95*/
+
+/* RESET3 */
+/*						96-127 */
+
+/* RESET4 */
+/*						128-131 */
+#define RESET_PWM_AB				132
+#define RESET_PWM_CD				133
+#define RESET_PWM_EF				134
+#define RESET_PWM_GH				135
+/*						136-137*/
+#define RESET_UART_A				138
+#define RESET_UART_B				139
+/*						140*/
+#define RESET_UART_D				141
+#define RESET_UART_E				142
+/*						143-144*/
+#define RESET_I2C_M_A				145
+#define RESET_I2C_M_B				146
+#define RESET_I2C_M_C				147
+#define RESET_I2C_M_D				148
+/*						149-151*/
+#define RESET_SDEMMC_A				152
+/*						153*/
+#define RESET_SDEMMC_C				154
+/*						155-159*/
+
+/* RESET5 */
+/*						160-175*/
+#define RESET_BRG_AO_NIC_SYS			176
+/*						177*/
+#define RESET_BRG_AO_NIC_MAIN			178
+#define RESET_BRG_AO_NIC_AUDIO			179
+/*						180-183*/
+#define RESET_BRG_AO_NIC_ALL			184
+/*						185*/
+#define RESET_BRG_NIC_SDIO			186
+#define RESET_BRG_NIC_EMMC			187
+#define RESET_BRG_NIC_DSU			188
+#define RESET_BRG_NIC_CLK81			189
+#define RESET_BRG_NIC_MAIN			190
+#define RESET_BRG_NIC_ALL			191
+
+#endif
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index fa80fa365f13c4a93f5577f78bf2b3369cb91cb8..6537153b3026af1bf9d1df0a196619b716553cde 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "amlogic-a4-common.dtsi"
+#include "amlogic-a4-reset.h"
 #include <dt-bindings/power/amlogic,a4-pwrc.h>
 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
 / {
@@ -51,6 +52,13 @@ pwrc: power-controller {
 };
 
 &apb {
+	reset: reset-controller@2000 {
+		compatible = "amlogic,a4-reset",
+			     "amlogic,meson-s4-reset";
+		reg = <0x0 0x2000 0x0 0x98>;
+		#reset-cells = <1>;
+	};
+
 	gpio_intc: interrupt-controller@4080 {
 		compatible = "amlogic,a4-gpio-intc",
 			     "amlogic,meson-gpio-intc";

-- 
2.37.1



