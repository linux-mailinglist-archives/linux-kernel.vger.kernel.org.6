Return-Path: <linux-kernel+bounces-225679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931539133A0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85D71C2122A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9A157460;
	Sat, 22 Jun 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o14xjEdE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABED156C68;
	Sat, 22 Jun 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719057611; cv=none; b=o2GplrioOmFQktt3QQj3fclk8neViUDxyooW2ujqsUNzrdxB0ytjIS173LVtCqyBdrga0ync3bcTif5eVubWiswPm0Scui23gRZtlA/k3EFWCbKpzVQoUBTLcfL2udLfe7ypdwTaqUoKM1m3MJFUdHekJvPjfwm0xAKZ3RYbTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719057611; c=relaxed/simple;
	bh=JWp4XCMBV/yJu3FwXjF6Ms5cXcMWqBCQeLRvCkyCHPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg1fNtupXls9zcmcPOyqFFZlMwG5ynE4gkf1eL9gP1BbpK0cAUBbqD8HWwisz3/xVcCsSGdI8NflDVgO1ZA46pTAPuU2dPFmtQdAezOy7POdA8B+sGkd831W5cdpVEKMUYfZtlKg44GKUYLVCCIUJH5IMOOEy0HVUT2PwJr5t1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o14xjEdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51289C4AF0A;
	Sat, 22 Jun 2024 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719057610;
	bh=JWp4XCMBV/yJu3FwXjF6Ms5cXcMWqBCQeLRvCkyCHPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o14xjEdEW4X+0CXlTqA9VSZQHx/gL3dXZFi7zYXMazRrtxnc5BBkz1mXX/Um67Flg
	 FwcXI6Ffzvln4SXzh18bpfmdUpzNt0lTeqN75QOmS0Q4BZiKpPhcfj8bO/BaMseeC3
	 FHJWXApb/p2f179hi0eHEE0nhjBRezpKnpAfxqjB040ahhcsbr3EceGQNzjK0sljR6
	 aH9psajefaRae2w3iMEfK67Xrgz4jUrqCiMcD8i6kIXOBnxjgdsGCnZLoImVMwFSt8
	 N7wNQZY+a1jEDtaDf46Easaypdkw3Bad4UC7Jz5Y5Wbk+xminUq2+y/cwBBKEZEPsV
	 vQ4By6NOPV+1Q==
From: Roger Quadros <rogerq@kernel.org>
Date: Sat, 22 Jun 2024 14:59:57 +0300
Subject: [PATCH 2/2] arm64: dts: ti: am62-lp-sk: Add overlay for NAND
 expansion card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-am62lp-sk-nand-v1-2-caee496eaf42@kernel.org>
References: <20240622-am62lp-sk-nand-v1-0-caee496eaf42@kernel.org>
In-Reply-To: <20240622-am62lp-sk-nand-v1-0-caee496eaf42@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, praneeth@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5667; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=JWp4XCMBV/yJu3FwXjF6Ms5cXcMWqBCQeLRvCkyCHPY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmdrzB2Gb6CdM6xYVngR8jD0ePOYt4LAtWiRAlT
 mYqqZvP40iJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZna8wQAKCRDSWmvTvnYw
 k8M7D/0V9FYfsnfV/971bhLpHoB9SMOqIxx/u5PlqkOIsDn3wur00+tGFB3BNJ0zvTmeEgpsXa0
 iOuRQhCPNeKJjHMSAS+nOnqdVfD6IXDWp/6N86NijymyAX0YIDHYuLiysImCReoX6pe8WLt9w+4
 Z90azT5Vms+JBk7SAWXDwsafHqQOs6kj1PVdlc2pzVGiQKjr8FKSet8G47ABcFkH18SdOVctQxP
 WzuTTuEix4KllAd0WGCej733NG9xR7ywHmcTrXttpEIIowxjzFL2gwer9skapHa/S//54yl8W+G
 wgmI1Hn8qE4CqSBUeYsb6fIuoKcUj1bEqgdn7AGytGEvkIGnkap91Mqb011fPU0oPVlqJ8FTVpt
 1lO0t/G96KLBcJZdnn7SQmaqV2FarujuV08sA5L3SK1W/6fttczxASCPuZktsyc+Qr09+0zjpA5
 UmkCSQokDuC6w7e7e0dBp/I/K9dkgpimh7Pw4yI+l1p8GccFcX1f1wAxDLYb2vWT8Q0qNoqG1MK
 b8mFfur7Yg0FGFpfJauUjlH/ws17mOvuCBnEOy7DxblcCoUQPUM9zhPYv7kaU1BkwSfMl0/oTk9
 /ACnaEVnt4jwuU3Wso8P+H4Gtm1254eY/R9mn2xOKE39FuY5oh0RjKZzL7F+5EnC3ybt8EA0Alc
 tknuVXC9JU50uiw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

The NAND expansion card (PROC143E1) connects over the User/MCU/PRU
Expansion port on the am62-lp-sk EVM.

The following pins are shared between McASP1 and GPMC-NAND so
both cannot work simultaneously.

Pin name	McASP1 function		GPMC function
========	===============		=============
J17		MCASP1_AXR0		GPMC0_WEN
P21		MCASP1_AFSX		GPMC0_WAIT0
K17		MCASP1_ACLKX		GPMC0_BE0N_CLE
K20		MCASP1_AXR2		GPMC0_ADVN_ALE

The factory default sets the pins for McASP1 use. (i.e.
Resistor Array RA1 installed, RA4 not installed).

For NAND use, RA1 has to be removed and RA4 must be
installed.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile                |   1 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso | 116 +++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       |   4 +
 3 files changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 1e6fcd1ff7ba..7fcbf14ae439 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -25,6 +25,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-1-4-ghz-opp.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtbo
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso b/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
new file mode 100644
index 000000000000..173ac60723b6
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "k3-pinctrl.h"
+
+&mcasp1 {
+	status = "disabled";
+};
+
+&main_pmx0 {
+	gpmc0_pins_default: gpmc0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x003c, PIN_INPUT, 0) /* (K19) GPMC0_AD0 */
+			AM62X_IOPAD(0x0040, PIN_INPUT, 0) /* (L19) GPMC0_AD1 */
+			AM62X_IOPAD(0x0044, PIN_INPUT, 0) /* (L20) GPMC0_AD2 */
+			AM62X_IOPAD(0x0048, PIN_INPUT, 0) /* (L21) GPMC0_AD3 */
+			AM62X_IOPAD(0x004c, PIN_INPUT, 0) /* (M21) GPMC0_AD4 */
+			AM62X_IOPAD(0x0050, PIN_INPUT, 0) /* (L17) GPMC0_AD5 */
+			AM62X_IOPAD(0x0054, PIN_INPUT, 0) /* (L18) GPMC0_AD6 */
+			AM62X_IOPAD(0x0058, PIN_INPUT, 0) /* (M20) GPMC0_AD7 */
+			AM62X_IOPAD(0x0098, PIN_INPUT, 0) /* (P21) GPMC0_WAIT0 */
+			AM62X_IOPAD(0x00a8, PIN_OUTPUT, 0) /* (J18) GPMC0_CSn0 */
+			AM62X_IOPAD(0x0084, PIN_OUTPUT, 0) /* (K20) GPMC0_ADVn_ALE */
+			AM62X_IOPAD(0x0088, PIN_OUTPUT, 0) /* (K21) GPMC0_OEn_REn */
+			AM62X_IOPAD(0x008c, PIN_OUTPUT, 0) /* (J17) GPMC0_WEn */
+			AM62X_IOPAD(0x0090, PIN_OUTPUT, 0) /* (K17) GPMC0_BE0n_CLE */
+			AM62X_IOPAD(0x00a0, PIN_OUTPUT, 0) /* (J20) GPMC0_WPn */
+		>;
+	};
+};
+
+&elm0 {
+	status = "okay";
+};
+
+&gpmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpmc0_pins_default>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	nand@0,0 {
+		compatible = "ti,am64-nand";
+		reg = <0 0 64>;		/* device IO registers */
+		interrupt-parent = <&gpmc0>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc0 0 GPIO_ACTIVE_HIGH>;	/* gpmc_wait0 */
+		ti,nand-xfer-type = "prefetch-polled";
+		ti,nand-ecc-opt = "bch8";	/* BCH8: Bootrom limitation */
+		ti,elm-id = <&elm0>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <40>;
+		gpmc,cs-wr-off-ns = <40>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <25>;
+		gpmc,adv-wr-off-ns = <25>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <20>;
+		gpmc,oe-on-ns = <3>;
+		gpmc,oe-off-ns = <30>;
+		gpmc,access-ns = <30>;
+		gpmc,rd-cycle-ns = <40>;
+		gpmc,wr-cycle-ns = <40>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "NAND.tiboot3";
+				reg = <0x00000000 0x00200000>;	/* 2M */
+			};
+			partition@200000 {
+				label = "NAND.tispl";
+				reg = <0x00200000 0x00200000>;	/* 2M */
+			};
+			partition@400000 {
+				label = "NAND.tiboot3.backup";	/* 2M */
+				reg = <0x00400000 0x00200000>;	/* BootROM looks at 4M */
+			};
+			partition@600000 {
+				label = "NAND.u-boot";
+				reg = <0x00600000 0x00400000>;	/* 4M */
+			};
+			partition@a00000 {
+				label = "NAND.u-boot-env";
+				reg = <0x00a00000 0x00040000>;	/* 256K */
+			};
+			partition@a40000 {
+				label = "NAND.u-boot-env.backup";
+				reg = <0x00a40000 0x00040000>;	/* 256K */
+			};
+			partition@a80000 {
+				label = "NAND.file-system";
+				reg = <0x00a80000 0x3f580000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 9a17bd3e59c9..8e9fc00a6b3c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -228,3 +228,7 @@ ldo4_reg: ldo4 {
 &tlv320aic3106 {
 	DVDD-supply = <&buck2_reg>;
 };
+
+&gpmc0 {
+	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
+};

-- 
2.34.1


