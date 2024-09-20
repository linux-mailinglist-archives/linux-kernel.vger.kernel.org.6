Return-Path: <linux-kernel+bounces-333986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478B197D109
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4AB1C219DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88C37171;
	Fri, 20 Sep 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="rkgEL6zp"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78352CA2;
	Fri, 20 Sep 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726812084; cv=none; b=LIYzJBgPFp8YICG4wx6WKUCbO6hhYLbd/oJU25ZR9fgnehFXevgg6q8KfxH1Cl/R623LorRvOCXkuiTdiTdaeeHMHPFXEJdyQ2HfVutPbuqWG58Fr1ErARt1fXWf2WKPz5gjJ4rhuggt7MwyU/vQlZpyx8O+vLigBXb8oNsH7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726812084; c=relaxed/simple;
	bh=NqrVnwRk2LC6xCvU0FBpyM3JmYvxjjf/JEwXNN+RGnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig0zwnAeP1DJPtOZFoJqPPr+pEtDuCzcYyEfHqUurwd8DuerNiqxCKGfw9pEWTNulD5GjhuNUDOxi7iMVfusuObgBIPd9Gpk16YfuduxALXA45+vYRRtPsJfJaaAEiLsUwP2O8UF3qgitwj8OJjylxbTozJWdVdx/RDAPwCuIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=rkgEL6zp; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BD4B14835DA;
	Fri, 20 Sep 2024 08:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726812077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OuyX7E8GGDXrKC0gVl8fpd9vbnAU6SI1vyySpQJuPOk=;
	b=rkgEL6zpndmBQ0yN3aeFYODrxtZh6JVtEGP3wC+gcxc4jZ5GTpx0EwTqTNF2ab17a4o8vi
	3rLRGBvf6vB2NCfEzVqr9MLW7Uk3isNZ1Xwtu3dTd9wr/bOQoUJnDLopnczBSYWGXe7/cG
	w+bkvs+XOdLW42buh1LJWqaa45LAGkjRYVQbObycalOf9g5e3ZDNMUG0sgTbP60o8P9TMV
	Xid10WZHfTBf1+qKIUwaiBRY5vLokwZf5n9WrcJmbrwyrHKIlqJa45FoID8lGXD0SUB8x3
	telG7HxWG6tLIFPJuWqfGODRu5xL7HZiczyOUCxGGh0OH0hmqIX6FrETt+VheQ==
Date: Fri, 20 Sep 2024 08:01:11 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] ARM: dts: microchip: sam9x75_curiosity: add
 sam9x75 curiosity board
Message-ID: <20240920-scored-fried-e2dbb86bf1ba@thorsis.com>
Mail-Followup-To: Varshini Rajendran <varshini.rajendran@microchip.com>,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
 <20240903064438.49975-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903064438.49975-1-varshini.rajendran@microchip.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Am Tue, Sep 03, 2024 at 12:14:38PM +0530 schrieb Varshini Rajendran:
> Add device tree file for sam9x75 curiosity board.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v7:
> 
> - Added child nodes to the tcb node.
> - Moved poweroff node to maintain alphabetic order.
> ---
>  arch/arm/boot/dts/microchip/Makefile          |   3 +
>  .../dts/microchip/at91-sam9x75_curiosity.dts  | 324 ++++++++++++++++++
>  2 files changed, 327 insertions(+)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> 
> diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
> index 0c45c8d17468..470fe46433a9 100644
> --- a/arch/arm/boot/dts/microchip/Makefile
> +++ b/arch/arm/boot/dts/microchip/Makefile
> @@ -2,6 +2,7 @@
>  # Enables support for device-tree overlays
>  DTC_FLAGS_at91-sam9x60_curiosity := -@
>  DTC_FLAGS_at91-sam9x60ek := -@
> +DTC_FLAGS_at91-sam9x75_curiosity := -@
>  DTC_FLAGS_at91-sama5d27_som1_ek := -@
>  DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
>  DTC_FLAGS_at91-sama5d29_curiosity := -@
> @@ -60,6 +61,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>  dtb-$(CONFIG_SOC_SAM9X60) += \
>  	at91-sam9x60_curiosity.dtb \
>  	at91-sam9x60ek.dtb
> +dtb-$(CONFIG_SOC_SAM9X7) += \
> +	at91-sam9x75_curiosity.dtb
>  dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-kizbox2-2.dtb \
>  	at91-kizbox3-hs.dtb \
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> new file mode 100644
> index 000000000000..1119f5d60d89
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sam9x75_curiosity.dts - Device Tree file for Microchip SAM9X75 Curiosity board
> + *
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
> + */
> +/dts-v1/;
> +#include "sam9x7.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Microchip SAM9X75 Curiosity";
> +	compatible = "microchip,sam9x75-curiosity", "microchip,sam9x7", "atmel,at91sam9";
> +
> +	aliases {
> +		i2c0 = &i2c6;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> +
> +		button-user {
> +			label = "USER";
> +			gpios = <&pioC 9 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_0>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led_red: led-red {
> +			label = "red";
> +			gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
> +			pinctrl-0 = <&pinctrl_red_led_gpio_default>;
> +		};
> +
> +		led_green: led-green {
> +			label = "green";
> +			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
> +			pinctrl-0 = <&pinctrl_green_led_gpio_default>;
> +		};
> +
> +		led_blue: led-blue {
> +			label = "blue";
> +			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
> +			pinctrl-0 = <&pinctrl_blue_led_gpio_default>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};

This is an RGB LED like on other Microchip Curiosity boards, right?
So three colors in a single package?  What about using the
"leds-group-multicolor" driver instead of adding these as separate
LEDs?

See Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
for reference.  I tried that lately on the SAM9X60 Curiosity out of
curiosity, and it's a nice interface from userspace POV.

Besides: According to
Documentation/devicetree/bindings/leds/common.yaml the group name
should be 'led-controller' instead of 'leds'.

Greets
Alex

> +
> +	memory@20000000 {
> +		reg = <0x20000000 0x10000000>;
> +		device_type = "memory";
> +	};
> +};
> +
> +&classd {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_classd_default>;
> +	atmel,pwm-type = "diff";
> +	atmel,non-overlap-time = <10>;
> +	status = "okay";
> +};
> +
> +&dbgu {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_dbgu_default>;
> +	status = "okay";
> +};
> +
> +&dma0 {
> +	status = "okay";
> +};
> +
> +&flx6 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flx6_default>;
> +	i2c-analog-filter;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns = <35>;
> +	status = "okay";
> +
> +	pmic@5b {
> +		compatible = "microchip,mcp16502";
> +		reg = <0x5b>;
> +
> +		regulators {
> +			vdd_3v3: VDD_IO {
> +				regulator-name = "VDD_IO";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vddioddr: VDD_DDR {
> +				regulator-name = "VDD_DDR";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vddcore: VDD_CORE {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <1150000>;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			dcdc4: VDD_OTHER {
> +				regulator-name = "VDD_OTHER";
> +				regulator-min-microvolt = <1150000>;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-ramp-delay = <3125>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vldo2: LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2s {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2s_default>;
> +	#sound-dai-cells = <0>;
> +	status = "okay";
> +};
> +
> +&main_xtal {
> +	clock-frequency = <24000000>;
> +};
> +
> +&pinctrl {
> +	classd {
> +		pinctrl_classd_default: classd-default {
> +			atmel,pins =
> +				<AT91_PIOA 18 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>,
> +				<AT91_PIOA 19 AT91_PERIPH_C AT91_PINCTRL_PULL_DOWN>;
> +		};
> +	};
> +
> +	dbgu {
> +		pinctrl_dbgu_default: dbgu-default {
> +			atmel,pins = <AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
> +				     <AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	flexcom {
> +		pinctrl_flx6_default: flx6-default {
> +			atmel,pins =
> +				<AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
> +				<AT91_PIOA 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		pinctrl_key_gpio_default: key-gpio-default {
> +			atmel,pins = <AT91_PIOC 9 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	i2s {
> +		pinctrl_i2s_default: i2s-default {
> +			atmel,pins =
> +				<AT91_PIOB 26 AT91_PERIPH_D AT91_PINCTRL_NONE>,		/* I2SCK */
> +				<AT91_PIOB 15 AT91_PERIPH_D AT91_PINCTRL_NONE>,		/* I2SWS */
> +				<AT91_PIOB 16 AT91_PERIPH_D AT91_PINCTRL_NONE>,		/* I2SDIN */
> +				<AT91_PIOB 17 AT91_PERIPH_D AT91_PINCTRL_NONE>,		/* I2SDOUT */
> +				<AT91_PIOB 25 AT91_PERIPH_D AT91_PINCTRL_NONE>;		/* I2SMCK */
> +		};
> +	};
> +
> +	leds {
> +		pinctrl_red_led_gpio_default: red-led-gpio-default {
> +			atmel,pins = <AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +		pinctrl_green_led_gpio_default: green-led-gpio-default {
> +			atmel,pins = <AT91_PIOC 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +		pinctrl_blue_led_gpio_default: blue-led-gpio-default {
> +			atmel,pins = <AT91_PIOC 20 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	sdmmc0 {
> +		pinctrl_sdmmc0_default: sdmmc0-default {
> +			atmel,pins =
> +				<AT91_PIOA 2 AT91_PERIPH_A (AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,				/* PA2 CK  periph A with pullup */
> +				<AT91_PIOA 1 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,	/* PA1 CMD periph A with pullup */
> +				<AT91_PIOA 0 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,	/* PA0 DAT0 periph A */
> +				<AT91_PIOA 3 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,	/* PA3 DAT1 periph A with pullup */
> +				<AT91_PIOA 4 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,	/* PA4 DAT2 periph A with pullup */
> +				<AT91_PIOA 5 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>;	/* PA5 DAT3 periph A with pullup */
> +		};
> +	};
> +}; /* pinctrl */
> +
> +&poweroff {
> +	debounce-delay-us = <976>;
> +	status = "okay";
> +
> +	input@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&rtt {
> +	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sdmmc0_default>;
> +	cd-gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	status = "okay";
> +};
> +
> +&slow_xtal {
> +	clock-frequency = <32768>;
> +};
> +
> +&tcb {
> +	timer0: timer@0 {
> +		compatible = "atmel,tcb-timer";
> +		reg = <0>;
> +	};
> +
> +	timer1: timer@1 {
> +		compatible = "atmel,tcb-timer";
> +		reg = <1>;
> +	};
> +};
> +
> +&trng {
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
> -- 
> 2.25.1
> 
> 

