Return-Path: <linux-kernel+bounces-518748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3FFA39408
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E101F3B650E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E551DC99E;
	Tue, 18 Feb 2025 07:42:56 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390B1D9346;
	Tue, 18 Feb 2025 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864575; cv=none; b=qDQWjH7ivT3IOrIOZ6WsRlqosYdmbhJUTC0ijouLoKOsrdLHqzeX69YyFd288wdH1c24QUwVB+3r4DZd17em5LWHfkIiYyRZ487yf3Imt41mtH4SVFtumiXuN34JCnmmz7BzX2U0F4pvPHuLh2jKz+OXqNIxBdFHhBQjHyQEx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864575; c=relaxed/simple;
	bh=TPGTTLkcub9h6nbI5oMCya7a39ohOYekNqtcJTkkLHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFOGVJJJsniLCtSsOMsbhP0/DlHGhysV3ohAfMxFh7J4RN5chUGVgjYr3/NBa0QqnUk8RIO/2s0dwKmKuFvT88Oj7vHaQXJ6SUylgZRv+dPm1WfViMYW+bkfWFsjdVQjiM2iSPbJqDQQF88UxrzRkLWTNZ7IwJLVuvfKHHcsWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52604 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkIFo-00G0MD-0a;
	Tue, 18 Feb 2025 08:42:51 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v3 12/15] arm64: dts: imx8mm-phyboard-polis: Add overlay for PEB-EVAL-01
Date: Tue, 18 Feb 2025 08:41:53 +0100
Message-Id: <20250218074156.807214-13-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218074156.807214-1-andrej.picej@norik.com>
References: <20250218074156.807214-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Janine Hagemann <j.hagemann@phytec.de>

Add support for the PEB-EVAL-01 expansion board for
phyBOARD-Polis-i.MX8MM.

Signed-off-by: Janine Hagemann <j.hagemann@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
- updated copyright year.
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx8mm-phyboard-polis-peb-eval-01.dtso    | 72 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 69b1ab8cd6f6..7e0fef7ed9de 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -124,8 +124,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phg.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb
 
 imx8mm-phyboard-polis-peb-av-10-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-av-10.dtbo
+imx8mm-phyboard-polis-peb-eval-01-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-eval-01.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-av-10.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-eval-01.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-prt8mm.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso
new file mode 100644
index 000000000000..a28f51ece93b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Janine Hagemann <j.hagemann@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include "imx8mm-pinfunc.h"
+
+&{/} {
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		button-0 {
+			label = "home";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		button-1 {
+			label = "menu";
+			linux,code = <KEY_MENU>;
+			gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	user-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_user_leds>;
+
+		user-led1 {
+			gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		user-led2 {
+			gpios = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		user-led3 {
+			gpios = <&gpio5 28 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_gpio_keys: gpio_keysgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17	0x16
+			MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29	0x16
+		>;
+	};
+
+	pinctrl_user_leds: user_ledsgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15	0x16
+			MX8MM_IOMUXC_UART4_RXD_GPIO5_IO28	0x16
+			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14	0x16
+		>;
+	};
+};
-- 
2.34.1


