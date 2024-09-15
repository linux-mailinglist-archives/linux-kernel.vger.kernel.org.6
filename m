Return-Path: <linux-kernel+bounces-329883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92172979716
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912BFB21A45
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93161C6885;
	Sun, 15 Sep 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bg2KKK0V"
Received: from mail-8160.188.com (mail-8160.188.com [60.191.81.60])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2631C6F5C;
	Sun, 15 Sep 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.81.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410281; cv=none; b=P+M+XVr/WhLlOFAkCmdCZGdJ1OKfhbMdLFVeq5Kp0FPtlqHYmkcPLNVtasvCk5Dpsra8T+sxvU+4uKQSLwDMGwXqYTrxihxenaJDXMD0AUi0aOsu/ycp17sMe6COvi/we+p00oxXO1aK9BMP6mX0mDYJrJ4n09U1krlQFAVALHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410281; c=relaxed/simple;
	bh=PIs+FnicSuumV2TTmCvN6AzY+VoHsb5xX8QxpfiwkXY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UZCdMcjWxlA4/XTvktjHpUt8877vRwQSfJw8vAAtslP0jcvPTqdFZiADl+LxBkyAf32Ahl04+yUcJtiLOkGEW4Kt/6lRYCKA6c1GH04RlXTCn9b9ae7wYeRhtMGHn50ix/25SlfJYb+E4su3J3b9O3/8zlWbJCs+yyEvdEQZKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bg2KKK0V; arc=none smtp.client-ip=60.191.81.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=VmvseBodIPHwPD2IY1KUDWoyNyfnQqV7tVtR4Merht0=;
	b=bg2KKK0Vy7znRnL4Ag6f9GnrUzZsutmZPlHM9fjR9O7yBfL1SVFyelE4hQ3fYZ
	HpuyvKTn2AdGsKnkIXOTT5wX1Yu2D/cgbumyHkmPd7shxr9rungxiNnAecja/iL3
	wZRatEcB1VzC4ikgn7UrWK9yeBXImde8fpmht2IbrNNy0=
Received: from localhost (unknown [27.18.168.209])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wCnvJnF7eZmD1SdEA--.24094S2;
	Sun, 15 Sep 2024 22:23:02 +0800 (CST)
Date: Sun, 15 Sep 2024 22:23:01 +0800
From: Ze Huang <18771902331@163.com>
To: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, conor@kernel.org
Cc: cyy@cyyself.name, jesse@rivosinc.com, jszhang@kernel.org,
	inochiama@outlook.com, uwu@icenowy.me, zhangmeng.kevin@spacemit.com,
	kevin.z.m@hotmail.com, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	dlan@gentoo.org, 18771902331@163.com
Subject: [PATCH 3/3] riscv: dts: canaan: Add k230's pinctrl node
Message-ID: <ZubtxUMTRbHg_N6n@jean.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wCnvJnF7eZmD1SdEA--.24094S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw15Ww1DXr4Dtr4fKF1UAwb_yoW3Zw15pF
	WS9rn3K34j9rWrK3y0qr1jgF1UWF4q9r1rK3srKry7tw10gFs5K3s5Cr1YqFn8ur1Yk34j
	g3ykZw4Ivrs7AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi2jg-UUUUU=
X-CM-SenderInfo: zpryllqrzqjjitr6il2tof0z/1tbiNwlbomXAnRCmlgAAsf

Add pinctrl device, containing default config for uart, pwm, iis, iic and
mmc.

Signed-off-by: Ze Huang <18771902331@163.com>
---
 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi | 318 +++++++++++++++++++
 arch/riscv/boot/dts/canaan/k230-pinctrl.h    |  18 ++
 arch/riscv/boot/dts/canaan/k230.dtsi         |   2 +
 3 files changed, 338 insertions(+)
 create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
 create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.h

diff --git a/arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi b/arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
new file mode 100644
index 000000000000..7537d3286e5a
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Ze Huang <18771902331@163.com>
+ */
+#include "k230-pinctrl.h"
+
+/ {
+	soc {
+		pinctrl: pinctrl@91105000 {
+			compatible = "canaan,k230-pinctrl";
+			reg = <0x0 0x91105000 0x0 0x100>;
+
+			jtag_pins: jtag-pins {
+				jtag-tck-cfg {
+					pinmux = <K230_PINMUX(2, 1)>;
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					bias-pull-down;
+					input-schmitt-enable;
+				};
+
+				jtag-tdi-cfg {
+					pinmux = <K230_PINMUX(3, 1)>;
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					bias-disable;
+				};
+
+				jtag-tdo-cfg {
+					pinmux = <K230_PINMUX(4, 1)>;
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					output-enable;
+					bias-disable;
+				};
+
+				jtag-tms-cfg {
+					pinmux = <K230_PINMUX(5, 1)>;
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					bias-pull-up;
+				};
+			};
+
+			uart2_pins: uart2-pins {
+				uart2-pins-cfg {
+					pinmux = <K230_PINMUX(5, 3)>, /* uart2 txd */
+						 <K230_PINMUX(6, 3)>; /* uart2 rxd */
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					output-enable;
+					bias-disable;
+				};
+			};
+
+			pwm2_pins: pwm2-pins {
+				pwm2-pin-cfg {
+					pinmux = <K230_PINMUX(7, 1)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					output-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+			};
+
+			pwm3_pins: pwm3-pins {
+				pwm3-pin-cfg {
+					pinmux = <K230_PINMUX(8, 1)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					output-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+			};
+
+			pwm4_pins: pwm4-pins {
+				pwm4-pin-cfg {
+					pinmux = <K230_PINMUX(9, 1)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					output-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+			};
+
+			iis_pins: iis-pins {
+				iis-clk-cfg {
+					pinmux = <K230_PINMUX(32, 2)>;
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					output-enable;
+					bias-disable;
+				};
+
+				iis-ws-cfg {
+					pinmux = <K230_PINMUX(33, 2)>;
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					output-enable;
+					bias-disable;
+				};
+
+				iis-din0-cfg {
+					pinmux = <K230_PINMUX(34, 2)>;
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					bias-disable;
+				};
+
+				iis-dout0-cfg {
+					pinmux = <K230_PINMUX(35, 2)>;
+					slew-rate = <0>;
+					drive-strength = <4>;
+					power-source = <K230_MSC_1V8>;
+					output-enable;
+					bias-disable;
+				};
+			};
+
+			uart4_pins: uart4-pins {
+				uart4-txd-cfg {
+					pinmux = <K230_PINMUX(36, 4)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					output-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+
+				uart4-rxd-cfg {
+					pinmux = <K230_PINMUX(37, 4)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+			};
+
+			uart0_pins: uart0-pins {
+				uart0-txd-cfg {
+					pinmux = <K230_PINMUX(38, 1)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					output-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+
+				uart0-rxd-cfg {
+					pinmux = <K230_PINMUX(39, 1)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+			};
+
+			iic1_pins: iic1-pins {
+				iic1-pins-cfg {
+					pinmux = <K230_PINMUX(40, 2)>, /* iic1 scl */
+						 <K230_PINMUX(41, 2)>; /* iic1 sda */
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					output-enable;
+					bias-pull-up;
+					input-schmitt-enable;
+				};
+			};
+
+			iic3_pins: iic3-pins {
+				iic3-pins-cfg {
+					pinmux = <K230_PINMUX(44, 2)>, /* iic3 scl */
+						 <K230_PINMUX(45, 2)>; /* iic3 sda */
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					output-enable;
+					bias-pull-up;
+					input-schmitt-enable;
+				};
+			};
+
+			iic4_pins: iic4-pins {
+				iic4-pins-cfg {
+					pinmux = <K230_PINMUX(46, 3)>, /* iic4 scl */
+						 <K230_PINMUX(47, 3)>; /* iic4 sda */
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					output-enable;
+					bias-pull-up;
+					input-schmitt-enable;
+				};
+			};
+
+			iic0_pins: iic0-pins {
+				iic0-pins-cfg {
+					pinmux = <K230_PINMUX(48, 3)>, /* iic0 scl */
+						 <K230_PINMUX(49, 3)>; /* iic0 sda */
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_1V8>;
+					input-enable;
+					output-enable;
+					bias-pull-up;
+					input-schmitt-enable;
+				};
+			};
+
+			uart3_pins: uart3-pins {
+				uart3-txd-cfg {
+					pinmux = <K230_PINMUX(50, 1)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_3V3>;
+					output-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+
+				uart3-rxd-cfg {
+					pinmux = <K230_PINMUX(51, 1)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_3V3>;
+					input-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+			};
+
+			key_pins: key-pins {
+				key-pins-cfg {
+					pinmux = <K230_PINMUX(52, 0)>, /* key0 */
+						 <K230_PINMUX(53, 0)>; /* key1 */
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_3V3>;
+					input-enable;
+					output-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+			};
+
+			mmc1_pins: mmc1-pins {
+				mmc1-cmd-cfg {
+					pinmux = <K230_PINMUX(54, 2)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_3V3>;
+					input-enable;
+					output-enable;
+					bias-pull-up;
+					input-schmitt-enable;
+				};
+
+				mmc1-clk-cfg {
+					pinmux = <K230_PINMUX(55, 2)>;
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_3V3>;
+					output-enable;
+					bias-disable;
+					input-schmitt-enable;
+				};
+
+				mmc1-data-cfg {
+					pinmux = <K230_PINMUX(56, 2)>, /* mmc1 data0 */
+						 <K230_PINMUX(57, 2)>, /* mmc1 data1 */
+						 <K230_PINMUX(58, 2)>, /* mmc1 data2 */
+						 <K230_PINMUX(59, 2)>; /* mmc1 data3 */
+					slew-rate = <0>;
+					drive-strength = <7>;
+					power-source = <K230_MSC_3V3>;
+					input-enable;
+					output-enable;
+					bias-pull-up;
+					input-schmitt-enable;
+				};
+			};
+		};
+	};
+};
+
diff --git a/arch/riscv/boot/dts/canaan/k230-pinctrl.h b/arch/riscv/boot/dts/canaan/k230-pinctrl.h
new file mode 100644
index 000000000000..9a34d75afd9f
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230-pinctrl.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/*
+ * Copyright (C) 2024 Canaan Bright Sight Co. Ltd
+ * Copyright (C) 2024 Ze Huang <18771902331@163.com>
+ */
+
+#ifndef _DT_BINDINGS_K230_PINCTRL_H
+#define _DT_BINDINGS_K230_PINCTRL_H
+
+#define K230_MSC_3V3 0
+#define K230_MSC_1V8 1
+
+#define BANK_VOLTAGE_DEFAULT       K230_MSC_1V8
+#define BANK_VOLTAGE_IO50_IO61     K230_MSC_3V3
+
+#define K230_PINMUX(pin, mode) (((pin) << 8) | (mode))
+
+#endif /* _DT_BINDINGS_K230_PINCTRL_H */
diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
index 95c1a3d8fb11..a9354e538642 100644
--- a/arch/riscv/boot/dts/canaan/k230.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -140,3 +140,5 @@ uart4: serial@91404000 {
 		};
 	};
 };
+
+#include "k230-pinctrl.dtsi"
-- 
2.46.1


