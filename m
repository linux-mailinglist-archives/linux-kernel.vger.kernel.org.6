Return-Path: <linux-kernel+bounces-256163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A0934A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D424282CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6928004F;
	Thu, 18 Jul 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f4wDkurP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE27B3F3;
	Thu, 18 Jul 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292049; cv=none; b=MXwjfkbn+JhJL4FhvECR7GCaUkFzsH8owZn7+T1UD3O0LjAyTxkmuVQJNDXKjDaI+gSqxY1yAuUlTFX9FKSLhY8Ef4g5406fFB8hriehA5CaWhyoNUULHqy3acuMVoHMPER2zfgjIPGSGX5ACHblhJJ9QIs5oQ2m+jIzk35Yvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292049; c=relaxed/simple;
	bh=lT/XtD2BQbOOrN5oZuYuWTnYIClD+IBdE9y8IJyys4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tks+PecFooGK59OtabkwXKwnHNwNqk48TjjlMtdMCYOQvJzUAeso95qqRi3Ojc1UFDmVAWgRQmTxWg85PzCOfFRvZgxKs9mcq+WKKCvfgULcT+5iLgnu04s1IX9XrQG85tftGARL4dd3YSkNH4Rcx0PTuU5yVbqscWfPwwxWoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f4wDkurP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721292046;
	bh=lT/XtD2BQbOOrN5oZuYuWTnYIClD+IBdE9y8IJyys4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f4wDkurP46/b+sXcVo0RTuzDiQl/rtauWKrxW8FJg4Hj7t8kpOV1YZ5cLKbiVP988
	 Vj8wDvYe4Az+yXYDcl/ADLsHATnfPJgoV4v1ItE6EUoAzLPLOBu+iiZruUiPqfKxVQ
	 nl4qi1xjs2l5A0TiTXShJHWV5dXVLUAa9i6AkRUAF8mu9GpjFX5Ju6CDJ9F/TLbi1a
	 Gk5jYSAwwGnGeZ/IJVUIch6MgrtAZfzAXuYvHAB80le7zJNwJcsvhDc1MUWc5JxiCs
	 vom5s5GKBd7UtxOKqmKMhS+8XjUV7MouyDE+NiADdTo927KtTWDodtwh3Ize4SHu68
	 dgf5Bgki23rLA==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9329F37821CE;
	Thu, 18 Jul 2024 08:40:45 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Date: Thu, 18 Jul 2024 09:40:25 +0100
Subject: [PATCH v3 2/3] arm64: dts: rockchip: add Firefly Core-PX30-JD4 SoM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-rockchip-px30-firefly-v3-2-3835cdd22eae@collabora.com>
References: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
In-Reply-To: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
 Collabora Kernel Mailing List <kernel@collabora.com>, 
 Christopher Obbard <chris.obbard@collabora.com>
X-Mailer: b4 0.13.0

The Firefly Core-PX30-JD4 SoM is a 69.6x49.6mm (260 pin SODIMM connector)
system-on-module from Firefly, featuring the Rockchip PX30.

It provides the following feature set:
 * on-module DDR3 (1GB/2GB)
 * on-module eMMC 5.1 (8GB/16GB/32GB/64GB/128GB)
 * on-module NPU (optional)
 * SD card (on a baseboard) via edge connector
 * 100mbps Ethernet (on a baseboard) via edge connector
 * MIPI-DSI (on a baseboard) via edge connector
 * Audio (on a baseboard) via edge connector
   - 1x SPDIF
   - 1x 8-channel I2S/TDM
   - 1x 2-channel I2S/TDM
   - 1x 8-channel PDM
 * USB (on a baseboard) via edge connector
   - 1x USB 2.0 OTG
   - 1x USB 2.0 host
 * Various GPIO (on a baseboard) via edge connector

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 .../boot/dts/rockchip/px30-firefly-jd4-core.dtsi   | 322 +++++++++++++++++++++
 1 file changed, 322 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core.dtsi b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core.dtsi
new file mode 100644
index 0000000000000..9999df45e6f68
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core.dtsi
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "px30.dtsi"
+
+/ {
+	compatible = "firefly,px30-jd4-core", "rockchip,px30";
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-0 = <&emmc_reset>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_baseboard>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	non-removable;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v0>;
+	vqmmc-supply = <&vccio_flash>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_log>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <0>;
+		clock-output-names = "xin32k";
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+
+		regulators {
+			vdd_log: DCDC_REG1 {
+				regulator-name = "vdd_log";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_3v0: vcc_rmii: DCDC_REG4 {
+				regulator-name = "vcc_3v0";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc3v3_sys: DCDC_REG5 {
+				regulator-name = "vcc3v3_sys";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_1v0: LDO_REG1 {
+				regulator-name = "vcc_1v0";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc_1v8: vccio_flash: vccio_sdio: LDO_REG2 {
+				regulator-name = "vcc_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_1v0: LDO_REG3 {
+				regulator-name = "vdd_1v0";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc3v0_pmu: LDO_REG4 {
+				regulator-name = "vcc3v0_pmu";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_sd: LDO_REG6 {
+				regulator-name = "vcc_sd";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc2v8_dvp: LDO_REG7 {
+				regulator-name = "vcc2v8_dvp";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <2800000>;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG8 {
+				regulator-name = "vcc1v8_dvp";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc1v5_dvp: LDO_REG9 {
+				regulator-name = "vcc1v5_dvp";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1500000>;
+				};
+			};
+
+			vcc3v3_lcd: SWITCH_REG1 {
+				regulator-name = "vcc3v3_lcd";
+				regulator-boot-on;
+			};
+
+			vcc5v0_host: SWITCH_REG2 {
+				regulator-name = "vcc5v0_host";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&io_domains {
+	status = "okay";
+
+	vccio1-supply = <&vccio_sdio>;
+	vccio2-supply = <&vccio_sd>;
+	vccio3-supply = <&vcc_3v0>;
+	vccio4-supply = <&vcc3v0_pmu>;
+	vccio5-supply = <&vcc_3v0>;
+	vccio6-supply = <&vccio_flash>;
+};
+
+&pinctrl {
+	emmc {
+		emmc_reset: emmc-reset {
+			rockchip,pins = <1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic_int {
+			rockchip,pins =
+				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	status = "okay";
+
+	pmuio1-supply = <&vcc3v0_pmu>;
+	pmuio2-supply = <&vcc3v0_pmu>;
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};

-- 
2.45.2


