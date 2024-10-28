Return-Path: <linux-kernel+bounces-384676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3A59B2D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF76428270B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EB21D54DC;
	Mon, 28 Oct 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="t97Yt8tq"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E91D270B;
	Mon, 28 Oct 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112211; cv=none; b=X/mvGQDIJK0Ld52tDQtbF46ri/1tUonXQsFUntxhueOODdlN12BepH45OE/589Vqz8h2YSL5xdH5ThB8jlZpdogPcPh+B3gbW/YJnFNTPFGYIBFcnUe/YFwGR4NIYl5N/rvCllM6XHXbyq4GI6VFklcPltDsuVUBHSJenMGD9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112211; c=relaxed/simple;
	bh=rBB1qNxga2xWH9zst/uYR/JIg6Fz1YN+uEMrWlWCRBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpSP9LId+3vcQT/FILs+5PRW1LdF2wid6lRYTW9g7OacNbAJf3ZpUb/mexrT+9lbYrfBIp22nEQB88vqk40rb6s1su+uHFeiHSZSomlVz8LF0VCMxpJ/XRzN8IAorEdVDyN5LfbnXAu5BOKwHkFOMwcFMu597oatvdm2C+fi8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=t97Yt8tq; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [192.168.1.107] (89-186-114-4.pool.digikabel.hu [89.186.114.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D33CD89072;
	Mon, 28 Oct 2024 11:43:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730112206;
	bh=m23Xw+IpzyeAGqOrRlyv/vUuKRnF8JR+m8z95mzGJ2s=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=t97Yt8tqGqp2+/hAIqhH6dzgmf60ssyji8IDhkHN/p38613XFI+J0BUH6SMoFTGPn
	 fkrIiTuqAXykAGkBibzJUCXg7jqq7ldO7Mb7DzPUbf3f9tRRxwPYxLuXUgTFw4yUba
	 HdjcCKq69tfSaJNSiz4Ufc/+3usdvhB/6HYdS/pM0653CgHQhY/crWubKy30mqHhbf
	 M/hQlUPapaarbpvtPOfI3ekmNUCGqNHj9rHL/T6cFMbsvh4aqcPxJXSXoS4Bt3QYia
	 yGjc59LYW4/OcuM8gpmhzRGLRr49HJ0s3e3euzhW0Z4Uhr2c2X5A9DIcy87tGXej68
	 BOMg0AArbpYLw==
Message-ID: <bf2c81e1-4e97-cfa2-326f-0a6125b2cff9@denx.de>
Date: Mon, 28 Oct 2024 11:41:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/2] arm64: dts: imx8mp: add aristainetos3 board
 support
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20241028082332.21672-1-hs@denx.de>
 <20241028082332.21672-3-hs@denx.de>
 <f4150aa3-4c0e-45fa-9c9c-879ac04c4364@kernel.org>
From: Heiko Schocher <hs@denx.de>
Reply-To: hs@denx.de
In-Reply-To: <f4150aa3-4c0e-45fa-9c9c-879ac04c4364@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Krzysztof,

On 28.10.24 11:24, Krzysztof Kozlowski wrote:
> On 28/10/2024 09:23, Heiko Schocher wrote:
>> Add support for the i.MX8MP based aristainetos3 boards from ABB.
>>
>> The board uses a ABB specific SoM from ADLink, based on NXP
>> i.MX8MP SoC. The SoM is used on 3 different carrier boards,
>> with small differences, which are all catched up in
>> devicetree overlays. The kernel image, the basic dtb
>> and all dtbos are collected in a fitimage. As bootloader
>> is used U-Boot which detects in his SPL stage the carrier
>> board by probing some i2c devices. When the correct
>> carrier is probed, the SPL applies all needed dtbos to
>> the dtb with which U-Boot gets loaded. Same principle
>> later before linux image boot, U-Boot applies the dtbos
>> needed for the carrier board before booting Linux.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> checkpatch dropped the following warnings:
>> arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi:248: warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented -- check ./Documentation/devicetree/bindings/
>>
>> ignored, as this compatible string is usedin other dts too, for example in
>>
>> arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>>
>>   arch/arm64/boot/dts/freescale/Makefile        |    5 +
>>   .../imx8mp-aristainetos3-adpismarc.dtsi       |   64 +
>>   .../imx8mp-aristainetos3-adpismarc.dtso       |   14 +
>>   .../imx8mp-aristainetos3-helios-lvds.dtsi     |   89 ++
>>   .../imx8mp-aristainetos3-helios-lvds.dtso     |   13 +
>>   .../imx8mp-aristainetos3-helios.dtsi          |  103 ++
>>   .../imx8mp-aristainetos3-helios.dtso          |   13 +
>>   .../imx8mp-aristainetos3-proton2s.dtsi        |  176 +++
>>   .../imx8mp-aristainetos3-proton2s.dtso        |   13 +
>>   .../imx8mp-aristainetos3a-som-v1.dts          |   18 +
>>   .../imx8mp-aristainetos3a-som-v1.dtsi         | 1210 +++++++++++++++++
>>   11 files changed, 1718 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtso
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtsi
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtso
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dts
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index 9d3df8b218a2..7c3586509b8b 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -163,6 +163,11 @@ imx8mn-tqma8mqnl-mba8mx-usbotg-dtbs += imx8mn-tqma8mqnl-mba8mx.dtb imx8mn-tqma8m
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-lvds-tm070jvhg33.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-usbotg.dtb
>>   
>> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3a-som-v1.dtb \
>> +			  imx8mp-aristainetos3-adpismarc.dtbo \
>> +			  imx8mp-aristainetos3-proton2s.dtbo \
>> +			  imx8mp-aristainetos3-helios.dtbo \
>> +			  imx8mp-aristainetos3-helios-lvds.dtbo
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>> new file mode 100644
>> index 000000000000..cc0cddaa33ea
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +&ecspi1 {
>> +	spidev0: spi@0 {
>> +		reg = <0>;
>> +		compatible = "rohm,dh2228fv";
> 
> Hm? I have some doubts, what device is here?

$ grep -lr dh2228fv drivers/
drivers/spi/spidev.c

Customer uses an userspace implementation...

> 
>> +		spi-max-frequency = <500000>;
>> +	};
>> +};
>> +
>> +&ecspi2 {
>> +	spidev1: spi@0 {
>> +		reg = <0>;
>> +		compatible = "rohm,dh2228fv";
>> +		spi-max-frequency = <500000>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	/* SX1509(2) U1001@IPi SMARC Plus */
>> +	gpio8: i2c2_gpioext0@3e {
> 
> Uh, no, please never send us downstream code.
> 
> Please follow DTS coding style in all upstream submissions.

driver is in here:

$ grep -lr probe-reset drivers/pinctrl/
drivers/pinctrl/pinctrl-sx150x.c

> Also:
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Sorry for the nodenames...

And yes, I remove the comments.

>> +		/* GPIO Expander 2 Mapping :
>> +		 * - 0: E_GPIO1_0	<=>	IPi SMARC Plus CN101_PIN29: E_GPIO1_0
>> +		 * - 1: E_GPIO1_1	<=>	IPi SMARC Plus CN101_PIN31: E_GPIO1_1
>> +		 * - 2: E_GPIO1_2	<=>	IPi SMARC Plus CN101_PIN32: E_GPIO1_2
>> +		 * - 3: E_GPIO1_3	<=>	IPi SMARC Plus CN101_PIN33: E_GPIO1_3
>> +		 * - 4: E_GPIO1_4	<=>	IPi SMARC Plus CN101_PIN35: E_GPIO1_4
>> +		 * - 5: E_GPIO1_5	<=>	IPi SMARC Plus CN101_PIN36: E_GPIO1_5
>> +		 * - 6: E_GPIO1_6	<=>	IPi SMARC Plus CN101_PIN37: E_GPIO1_6
>> +		 * - 7: E_GPIO1_7	<=>	IPi SMARC Plus CN101_PIN38: E_GPIO1_7
>> +		 * - 8: E_GPIO2_8	<=>	IPi SMARC Plus CN101_PIN40: E_GPIO2_8
>> +		 * - 9: TP1002		<=>	IPi SMARC Plus TP1002 (won't use)
>> +		 * - 10: TP1003		<=>	IPi SMARC Plus TP1003 (won't use)
>> +		 * - 11: TP1004		<=>	IPi SMARC Plus TP1004 (won't use)
>> +		 * - 12: TP1005		<=>	IPi SMARC Plus TP1005 (won't use)
>> +		 * - 13: TP1006		<=>	IPi SMARC Plus TP1006 (won't use)
>> +		 * - 14: TP1007		<=>	IPi SMARC Plus TP1007 (won't use)
>> +		 * - 15: TP1008		<=>	IPi SMARC Plus TP1008 (won't use)
>> +		 * - 16: OSCIO		<=>	IPi SMARC Plus TP1001 (won't use)
>> +		 */
>> +		#gpio-cells = <2>;
>> +		#interrupt-cells = <2>;
>> +		compatible = "semtech,sx1509q";
>> +		reg = <0x3e>;
>> +
>> +		semtech,probe-reset;
>> +		gpio-controller;
>> +		interrupt-controller;
>> +
>> +		interrupt-parent = <&gpio6>;
>> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
>> +	};
>> +
> 
> Drop
> 
>> +};
>> +
>> +&flexcan1 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
>> new file mode 100644
>> index 000000000000..5a9adccbf7cf
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
>> + */
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include "imx8mp-aristainetos3-adpismarc.dtsi"
>> +
>> +&{/} {
>> +	model = "Aristainetos3 ADLink PI SMARC carrier";
>> +	compatible = "abb,aristainetos3-adpismarc", "imx8mp-aristianetos3",
>> +		     "abb,aristianetos3-som", "fsl,imx8mp";
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).

Thanks for the hint! I have to fix my scripts...

> And why this is DTSO, I have no clue...
> 
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
>> new file mode 100644
>> index 000000000000..55aabd6fc1f7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/pwm/pwm.h>
>> +
>> +&{/} {
>> +	panel: panel {
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_lcd0_vdd_en>;
>> +		compatible = "lg,lb070wv8";
>> +		backlight = <&lvds_backlight>;
>> +		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
>> +
>> +		port {
>> +			panel_in: endpoint {
>> +				remote-endpoint = <&ldb_lvds_ch0>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&gpio3 {
>> +	mipi_lvds_select {
> 
> No, read coding style.
> 
> 
>> +		gpio-hog;
>> +		gpios = <23 GPIO_ACTIVE_HIGH>;
>> +		output-low;
>> +		line-name = "mipi_lvds_select";
>> +	};
>> +};
>> +
>> +&hdmi_blk_ctrl {
>> +	status = "disabled";
>> +};
>> +
>> +&hdmi_pvi {
>> +	status = "disabled";
>> +};
>> +
>> +&hdmi_tx {
>> +	status = "disabled";
>> +};
>> +
>> +&hdmi_tx_phy {
>> +	status = "disabled";
>> +};
>> +
>> +&irqsteer_hdmi {
>> +	status = "disabled";
>> +};
>> +
>> +&ldb_lvds_ch0 {
>> +	fsl,data-mapping = "jeida";
>> +	fsl,data-width = <24>;
>> +	remote-endpoint = <&panel_in>;
>> +};
>> +
>> +&lcdif1 {
>> +	status = "disabled";
>> +};
>> +
>> +&lcdif2 {
>> +	status = "okay";
>> +};
>> +
>> +&lcdif3 {
>> +	status = "disabled";
>> +};
>> +
>> +&lvds_backlight {
>> +	status = "okay";
>> +};
>> +
>> +&lvds_bridge {
>> +	status = "okay";
>> +};
>> +
>> +&media_blk_ctrl {
>> +	/*
>> +	 * The internal divider will always divide the output LVDS clock by 7
>> +	 * so our display needs 33246000 Hz, so set VIDEO_PLL1 to
>> +	 * 33246000 * 7 = 232722000 Hz
>> +	 */
>> +	assigned-clock-rates = <500000000>, <200000000>, <0>, <0>, <232722000>;
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
>> new file mode 100644
>> index 000000000000..06d1883b962a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
>> + */
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include "imx8mp-aristainetos3-helios-lvds.dtsi"
>> +
>> +&{/} {
>> +	model = "Aristainetos3 helios LVDS carrier";
>> +	compatible = "abb,aristainetos3-helios-lvds", "abb,aristainetos3-helios", "abb,aristianetos3-som", "fsl,imx8mp";
> 
> Read not only DTS coding style, but also kernel coding style. Lines are
> supposed to be wrapped according to kernel coding style.

Yes, indeed, I have to fix my scripts...

>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
>> new file mode 100644
>> index 000000000000..b4b1cb3b0cb3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
>> @@ -0,0 +1,103 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +&{/} {
>> +	helios_gpio_leds {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
>> +		compatible = "gpio-leds";
>> +
>> +		helios_blue {
> 
> So this was absolutely never tested.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
>> +			label = "helios:blue";
> 
> Use function and color instead.
> 
> I finished review here. Rest of the code does not look good, really. You
> have so many, really so many, trivial issues which tools point out, that
> using humans for such review is just waste of our time.

Sorry for that, will call the tools...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

