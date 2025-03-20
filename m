Return-Path: <linux-kernel+bounces-569433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D182EA6A2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74A93BE4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC06224234;
	Thu, 20 Mar 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMu0q4Kj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722852222C8;
	Thu, 20 Mar 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463759; cv=none; b=BkymkELhk/PG32MkD5D1KLTq31IsHdK5v+826WxuwrJf9WuwUTr9FhSyi5BBfdRtkHv6g+LdSz07mlRcJp8RpCD85r/LdKKQO1w0/4BF2DZv87DIQItMA3tMrU41op5qnnx8Og/9LfZyVqVgfgJwpeTHdaiMZRllGYDywGm353U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463759; c=relaxed/simple;
	bh=uHsvGO19AHMIRVzlCEkDM6qB8mYIPfAdfm6lSZdF2s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojacklMgtkq1vvTFvHaVqH33N5tQ3RJCp6Z7G8PJeqQXmdHj34rNBT/G+wIh9jkOweSUWh7p/a125QNczpUH0TUJNyqgKIMwYTWRPP5AA2xj5Kfvx/G55BTXPpH29uZdwNPEE2H1be0A2DYioPukxqipXaLA83f0Jh5hAmolVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMu0q4Kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09078C4CEEC;
	Thu, 20 Mar 2025 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742463759;
	bh=uHsvGO19AHMIRVzlCEkDM6qB8mYIPfAdfm6lSZdF2s4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jMu0q4KjMfE1n4+cU1vSZ1zObn8i/ZlfQX9zrjUaKfIBe60o3IXDOgP8NKZP5QjkJ
	 7QypGB5RfRRFEZry37lp/CSqJZ93sd1B6w6SAVBTe7fbJJutIIf9Yx2PTAkuYopPtJ
	 RmmCrOCQn4snkLbIyAG43VVz4E/NdePuejxsvu/YvW7Rm5kk4PpOQOJpOmxyoqJnpr
	 oVfYWOgTzwmusYXfjQQGM3j3DZUGAlyIitgjf4hs7YeLZcCaNMPcW8j8Rfz0WL+y0m
	 6DplaekW2mG8pjfHDA5iJf9mm7gun8DR/jaS2/InEsOu9B/aMJTWP7kAY2FdiNUY8Y
	 5F5YLrCRZ5JZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034AFC28B30;
	Thu, 20 Mar 2025 09:42:39 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Thu, 20 Mar 2025 17:42:10 +0800
Subject: [PATCH v5 3/3] arm64: dts: amlogic: Add A5 Reset Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-a4-a5-reset-v5-3-296f83bf733d@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742463756; l=3982;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=JXUL4gu4EApzIkUMmX2K4k010zPgasAAFt6IuBT4mak=;
 b=InVtCs+ltwnwgTQL64Pk6vhlxiCdQmNpQl+Mq4tvW3ASrSNCr9BM6w46GSQcD09G4xUJik7Cg
 QduQlQwmygxAnKDcbQuCVHn4bDuIpuexumyc3Vht+QNVeqZj/K3D5GV
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Zelong Dong <zelong.dong@amlogic.com>

Add the device node and related header file for Amlogic
A5 reset controller.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Link: https://lore.kernel.org/r/20240918074211.8067-4-zelong.dong@amlogic.com
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h | 95 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi    |  8 +++
 2 files changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h b/arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h
new file mode 100644
index 0000000000000000000000000000000000000000..cdf0f515962097c606e4c53badb19df7d21606ec
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __DTS_AMLOGIC_A5_RESET_H
+#define __DTS_AMLOGIC_A5_RESET_H
+
+/* RESET0 */
+/*						0-3 */
+#define RESET_USB				4
+/*						5-7 */
+#define RESET_USBPHY20				8
+/*						9 */
+#define RESET_USB2DRD				10
+/*						11-31 */
+
+/* RESET1 */
+#define RESET_AUDIO				32
+#define RESET_AUDIO_VAD				33
+/*                                              34 */
+#define RESET_DDR_APB				35
+#define RESET_DDR				36
+/*						37-40 */
+#define RESET_DSPA_DEBUG			41
+/*                                              42 */
+#define RESET_DSPA				43
+/*						44-46 */
+#define RESET_NNA				47
+#define RESET_ETHERNET				48
+/*						49-63 */
+
+/* RESET2 */
+#define RESET_ABUS_ARB				64
+#define RESET_IRCTRL				65
+/*						66 */
+#define RESET_TS_PLL				67
+/*						68-72 */
+#define RESET_SPICC_0				73
+#define RESET_SPICC_1				74
+#define RESET_RSA				75
+
+/*						76-79 */
+#define RESET_MSR_CLK				80
+#define RESET_SPIFC				81
+#define RESET_SAR_ADC				82
+/*						83-90 */
+#define RESET_WATCHDOG				91
+/*						92-95 */
+
+/* RESET3 */
+/*						96-127 */
+
+/* RESET4 */
+#define RESET_RTC				128
+/*						129-131 */
+#define RESET_PWM_AB				132
+#define RESET_PWM_CD				133
+#define RESET_PWM_EF				134
+#define RESET_PWM_GH				135
+/*						104-105 */
+#define RESET_UART_A				138
+#define RESET_UART_B				139
+#define RESET_UART_C				140
+#define RESET_UART_D				141
+#define RESET_UART_E				142
+/*						143*/
+#define RESET_I2C_S_A				144
+#define RESET_I2C_M_A				145
+#define RESET_I2C_M_B				146
+#define RESET_I2C_M_C				147
+#define RESET_I2C_M_D				148
+/*						149-151 */
+#define RESET_SDEMMC_A				152
+/*						153 */
+#define RESET_SDEMMC_C				154
+/*						155-159*/
+
+/* RESET5 */
+/*						160-175 */
+#define RESET_BRG_AO_NIC_SYS			176
+#define RESET_BRG_AO_NIC_DSPA			177
+#define RESET_BRG_AO_NIC_MAIN			178
+#define RESET_BRG_AO_NIC_AUDIO			179
+/*						180-183 */
+#define RESET_BRG_AO_NIC_ALL			184
+#define RESET_BRG_NIC_NNA			185
+#define RESET_BRG_NIC_SDIO			186
+#define RESET_BRG_NIC_EMMC			187
+#define RESET_BRG_NIC_DSU			188
+#define RESET_BRG_NIC_SYSCLK			189
+#define RESET_BRG_NIC_MAIN			190
+#define RESET_BRG_NIC_ALL			191
+
+#endif
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index 32ed1776891bc7d1befd01a76c76048631606f5a..b1da8cbaa25a1844312a23bc39eb876df3c60df5 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "amlogic-a4-common.dtsi"
+#include "amlogic-a5-reset.h"
 #include <dt-bindings/power/amlogic,a5-pwrc.h>
 / {
 	cpus {
@@ -50,6 +51,13 @@ pwrc: power-controller {
 };
 
 &apb {
+	reset: reset-controller@2000 {
+		compatible = "amlogic,a5-reset",
+			     "amlogic,meson-s4-reset";
+		reg = <0x0 0x2000 0x0 0x98>;
+		#reset-cells = <1>;
+	};
+
 	gpio_intc: interrupt-controller@4080 {
 		compatible = "amlogic,a5-gpio-intc",
 			     "amlogic,meson-gpio-intc";

-- 
2.37.1



