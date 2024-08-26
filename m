Return-Path: <linux-kernel+bounces-300780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB84095E843
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AD81F2119B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B707F80BFF;
	Mon, 26 Aug 2024 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe3FK9Dw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAB320C;
	Mon, 26 Aug 2024 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652410; cv=none; b=Sif1kIhr3EZWzLztd26RsI1A1cVxKHvexITxPKwOOXBAvCTzNj3nGFT4Bgr4cYOP3BHk8eMsY5Bbhi2tYgfhIUsOPuJTTXKQCPED9bmc2SCpSJkmQ6qn0X82bNWS5tjBoen8s/lyJLphGiyv5ppnUEXJGJmMAO2k7KT5rIG+TbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652410; c=relaxed/simple;
	bh=LpMSMZ23zbK5Tr1gH1ZtMPaeNrkg6P2xvFtHobHxsHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFZiEcM4AUOv28pYTPF7Vzi5ca2dl5j2CAxFWjfpOPGJ+uvwoBKpbA/WfH8XyvSs9YOA5P+CZCqU1LWq0Z4QywWQ/3uTTegKGCsnFWN78B240aEOe8noO3NALQwfeIZbVeQGJ+cpTdUoroiv97JoLZqaBAD3ZT5zrXbQIg9WPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe3FK9Dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72F6C4FEB3;
	Mon, 26 Aug 2024 06:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724652410;
	bh=LpMSMZ23zbK5Tr1gH1ZtMPaeNrkg6P2xvFtHobHxsHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fe3FK9DwJAmp8WyeeGfH5iylSaooZDjfWmge5XTkKp3dmVo85VeavzqdnvhXo4kj1
	 YdB1tQ9fHyuRM/Y+JkSwsj+nEblRwVpkYiJYC+j6kuJwzqkYMHVo3NGm+FueJ/cclv
	 wd15WLOJhSvgOtjjaKvdsZ3AvC1oFNDKRMnemk+j0Si26AtV41ytkqiccFTf45n/VI
	 GRSqLbvzkIj4PkeSKGM27IARRGF/5w3GOsqYe+A8xYM6iBurYiKgkBMHNAWRCt1zyl
	 HIcMPgBBfjmnErCKefPGhB3CWS9T074xVWFzRk9YNkyuxThQQkn3W3P2lmIAzPUwzr
	 crQPKdvZMkD0Q==
Date: Mon, 26 Aug 2024 08:06:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for LCKFB Taishan Pi
 RK3566
Message-ID: <wacysftuozwpumrw262tltoxqrldlju7mzj5fnxxcjheycjvzr@wb7mcnbiv6ic>
References: <20240826044530.726458-1-bigfoot@classfun.cn>
 <20240826044530.726458-4-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826044530.726458-4-bigfoot@classfun.cn>

On Mon, Aug 26, 2024 at 12:44:13PM +0800, Junhao Xie wrote:
> Add dts for LCKFB Taishan Pi.
> 
> Working IO:
> * UART
> * RGB LED
> * AP6212 WiFi
> * AP6212 Bluetooth
> * SD Card
> * eMMC
> * HDMI
> * Mali GPU
> * USB Type-C
> * USB Type-A
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3566-lckfb-tspi.dts   | 743 ++++++++++++++++++
>  2 files changed, 744 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts

...

> +	dc_12v: dc-12v {

Use some reasonable prefix or suffix (regulator) for all regulator
nodes. Or even: use name for all fixed regulators which matches current
format recommendation: 'regulator-[0-9]v[0-9]'
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?h=v6.11-rc1#n46

> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	vcc5v0_host: vcc5v0-host-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_host";
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&vcc5v0_sys>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host_en>;
> +	};
> +
> +	vccio_flash: vccio-flash {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vccio_flash";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_1v8>;
> +	};
> +
> +	vccio_wl: vccio-wl {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vccio_wl";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +};
> +
> +&combphy1 {
> +	status = "okay";
> +};
> +
> +&combphy2 {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	avdd-0v9-supply = <&vdda0v9_image>;
> +	avdd-1v8-supply = <&vcca1v8_image>;
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		#clock-cells = <1>;
> +		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> +		clock-names = "mclk";
> +		clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> +
> +		#sound-dai-cells = <0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_logic";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_gpu";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vcc_ddr";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu: DCDC_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_npu";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_image: LDO_REG1 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdda0v9_image";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9: LDO_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdda_0v9";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdda0v9_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_acodec";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_sd";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcca_1v8: LDO_REG7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca_1v8";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pmu: LDO_REG8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca1v8_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcca1v8_image: LDO_REG9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca1v8_image";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: SWITCH_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc_3v3";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sd: SWITCH_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc3v3_sd";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +
> +		codec {
> +			rockchip,mic-in-differential;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	/* Touch Screen */
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4m0_xfer>;
> +	status = "okay";
> +	/* Camera */
> +};
> +
> +&i2s0_8ch {
> +	status = "okay";
> +	/* HDMI */
> +};
> +
> +&i2s1_8ch {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s1m0_sclktx &i2s1m0_lrcktx &i2s1m0_sdi0 &i2s1m0_sdo0>;
> +	rockchip,trcm-sync-tx-only;
> +	status = "okay";
> +	/* PMIC */
> +};
> +
> +&i2s2_2ch {
> +	rockchip,trcm-sync-tx-only;
> +	status = "okay";
> +	/* AP6212 Bluetooth */
> +};
> +
> +&pinctrl {
> +	bt {
> +		bt_enable_h: bt-enable-h {
> +			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_host_wake_l: bt-host-wake-l {
> +			rockchip,pins = <2 RK_PC0 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		bt_wake_l: bt-wake-l {
> +			rockchip,pins = <2 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wifi_host_wake_h: wifi-host-wake-l {
> +			rockchip,pins = <2 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hp-detect {
> +		hp_det: hp-det {
> +			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic_int {
> +			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		soc_slppin_gpio: soc_slppin_gpio {
> +			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_output_low>;
> +		};
> +
> +		soc_slppin_slp: soc_slppin_slp {
> +			rockchip,pins = <0 RK_PA2 1 &pcfg_pull_up>;
> +		};
> +
> +		soc_slppin_rst: soc_slppin_rst {
> +			rockchip,pins = <0 RK_PA2 2 &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb2 {
> +		vcc5v0_host_en: vcc5v0-host-en {
> +			rockchip,pins = <4 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
> +	pmuio2-supply = <&vcc3v3_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio2-supply = <&vccio_flash>;
> +	vccio3-supply = <&vccio_sd>;
> +	vccio4-supply = <&vccio_wl>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_1v8>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&pmugrf {
> +	reboot-mode {
> +		compatible = "syscon-reboot-mode";
> +		offset = <0x200>;
> +		mode-normal = <BOOT_NORMAL>;
> +		mode-loader = <BOOT_BL_DOWNLOAD>;
> +		mode-recovery = <BOOT_RECOVERY>;
> +		mode-bootloader = <BOOT_FASTBOOT>;
> +	};
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca_1v8>;
> +	status = "okay";
> +	/* Channel 0: Recovery Button */
> +	/* Channel 1: Hardware ID */
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe &emmc_rstnout>;
> +	status = "okay";

Keep status the last.

Best regards,
Krzysztof


