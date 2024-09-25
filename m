Return-Path: <linux-kernel+bounces-338439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84559857FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0A91F216FC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC915B999;
	Wed, 25 Sep 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="K2ZB8PiQ"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131AF13A884;
	Wed, 25 Sep 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727263843; cv=none; b=SMoXn0kqRBkdYm3qF4VRhNqQCVtmxyTSoOxM1LgJkTBxDX7JZ00oNGR3TMQ+yp60DQNcBNX1bLbcUSrlBbtmvTyWH0Z8wdaO7VxS8EDPQH8BahusK5McZfU8lUJNQIw1B0jGFp0aHgJGR/oAlzsl1lQNTfqYm4f0l/20mOCLUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727263843; c=relaxed/simple;
	bh=kH3tIv8Rti5+DuHw8zFtAnwwGg+1JNCj8v1UnbudLJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THAxb9Cu+kOR0ivWJObVY5dVLn8xjMVPqsFicLmpfuVQMn9HmaKeSL4f7QWdGgVxaNPOj/2qYi8Z2qwdP4ytsGo9WwOssEOlsqDuP1ly5oHp9BVtkrDbhkUynDhG7AWKSB/0dbEFQThOzxMNjTcXMkFW++UD2ku22p884xnU3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=K2ZB8PiQ; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727263832;
	bh=hxagW0FnMKA1WsvZNBxUuoXtqQsT77XoKbAVByUrEvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K2ZB8PiQCH0Of/+V6shxnF1wQSHyYoF7T3dCeTs1dCkPe5oGFH9UsRFKj4XdkIjLV
	 MV1Ip/5AON2FxDr5Q8yIN26v8XuSeUU3S+aA725nCw7HPZ9D9enfRpAeZWI3fQlh/u
	 XjlIVrz02VBW2l1EmRk9iFsTw2+ovlipoZkpfg/A=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id DF20CA025E;
	Wed, 25 Sep 2024 13:30:31 +0200 (CEST)
Message-ID: <87980643-44b4-4df9-9eb7-1583b5074bdd@ysoft.com>
Date: Wed, 25 Sep 2024 13:30:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: imx: Add imx8mp-iota2-lumpy board
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Michael Walle <mwalle@kernel.org>,
 devicetree@vger.kernel.org, Alexander Stein
 <alexander.stein@ew.tq-group.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 Hiago De Franco <hiago.franco@toradex.com>,
 Herburger <gregor.herburger@ew.tq-group.com>,
 Petr Benes <petr.benes@ysoft.com>, linux-usb@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Frank Li <Frank.li@nxp.com>
References: <20240924103941.1729061-1-michal.vokac@ysoft.com>
 <20240924103941.1729061-3-michal.vokac@ysoft.com>
 <ZvLXenqG/++AR4We@lizhi-Precision-Tower-5810>
 <20240924173714.qxxkhn6wscze7q5n@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <20240924173714.qxxkhn6wscze7q5n@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 09. 24 19:37, Marco Felsch wrote:
> Hi Frank,
> 
> On 24-09-24, Frank Li wrote:
>> On Tue, Sep 24, 2024 at 12:39:41PM +0200, Michal Vokáč wrote:
>>> The IOTA2 Lumpy board is based on the i.MX8MPlus EVK.
>>>
>>> Basic features are:
>>> - 4GB LPDDR4
>>> - 64GB eMMC
>>> - 2x 1GB Ethernet
>>> - USB 3.0 Type-C dual role port, without power delivery
>>> - USB 3.0 Type-A host port
>>> - RGB LED - PWM driven
>>> - speaker - PWM driven
>>> - RTC with super capacitor backup
>>>
>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>> ---
>>> v4:
>>> - Moved the iomuxc node to the end of the file.
>>> - Moved the bus-width and non-removeable properties below
>>>    the pinctrl-* properties in &usdhc3 node.
>>> - Moved the fsl,ext-reset-output below the pinctrl-* properties
>>>    in &wdog1 node.
>>> v3:
>>> - Dropped pinctrl-names property from &usb_dwc3_1 node.
>>> v2:
>>> - Dropped unused property from pwm4 node.
>>> - Sorted all nodes and properties using dt-format tool from Frank.
>>>
>>>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>>   .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 423 ++++++++++++++++++
>>
>> Suggest use https://github.com/lznuaa/dt-format
>> sort node. any issue, let me know.
> 
> Thanks for the link :) would be nice to have this script to be part of
> the kernel. The script follows the rules in [1] I'm just used to have
> common properties like pinctrl-* in front of the device specific
> properties e.g. "enable-active-high". But this rule is not part of [1]
> so I can't blame the script.
> 
> Regards,
>    Marco
> 
> [1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

Thank you for the review Frank & Marco.
I quickly went through the file again and found another few properties
that could be better ordered according to the kernel documentation [1].

>>>   2 files changed, 424 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>>> index 9d3df8b218a2..aa26a50b7bb4 100644
>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>> @@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
>>> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>>> new file mode 100644
>>> index 000000000000..9eb58e818dc7
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>>> @@ -0,0 +1,423 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright 2023 Y Soft
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "imx8mp.dtsi"
>>> +
>>> +/ {
>>> +	compatible = "ysoft,imx8mp-iota2-lumpy", "fsl,imx8mp";
>>> +	model = "Y Soft i.MX8MPlus IOTA2 Lumpy board";
>>> +
>>> +	beeper {
>>> +		compatible = "pwm-beeper";
>>> +		pwms = <&pwm4 0 500000 0>;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = &uart2;
>>> +	};
>>> +
>>> +	gpio_keys: gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +		pinctrl-0 = <&pinctrl_gpio_keys>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		button-reset {
>>> +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
>>> +			label = "Factory RESET";
>>> +			linux,code = <BTN_0>;
>>> +		};
>>> +	};
>>> +
>>> +	reg_usb_host: regulator-usb-host {
>>> +		compatible = "regulator-fixed";
>>> +		enable-active-high;
>>> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;

The enable-active-high and gpio should go bellow regulator-*.

>>> +		pinctrl-0 = <&pinctrl_usb_host_vbus>;
>>> +		pinctrl-names = "default";
>>> +		regulator-max-microvolt = <5000000>;
>>> +		regulator-min-microvolt = <5000000>;
>>> +		regulator-name = "usb-host";
>>> +	};
>>> +
>>> +	memory@40000000 {
>>> +		reg = <0x0 0x40000000 0 0x80000000>,
>>> +		      <0x1 0x00000000 0 0x80000000>;
>>> +		device_type = "memory";
>>> +	};
>>> +};
>>> +
>>> +&A53_0 {
>>> +	cpu-supply = <&reg_arm>;
>>> +};
>>> +
>>> +&A53_1 {
>>> +	cpu-supply = <&reg_arm>;
>>> +};
>>> +
>>> +&A53_2 {
>>> +	cpu-supply = <&reg_arm>;
>>> +};
>>> +
>>> +&A53_3 {
>>> +	cpu-supply = <&reg_arm>;
>>> +};
>>> +
>>> +&eqos {
>>> +	phy-handle = <&ethphy0>;
>>> +	phy-mode = "rgmii-id";
>>> +	pinctrl-0 = <&pinctrl_eqos>;
>>> +	pinctrl-names = "default";
>>> +	status = "okay";
>>> +
>>> +	mdio {
>>> +		compatible = "snps,dwmac-mdio";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		ethphy0: ethernet-phy@0 {
>>> +			reg = <0>;
>>> +			interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
>>> +			interrupt-parent = <&gpio3>;
>>> +			micrel,led-mode = <0>;

The micrel,* is a vendor specific property. It should go bellow the reset-*.

>>> +			pinctrl-0 = <&pinctrl_ethphy0>;
>>> +			pinctrl-names = "default";
>>> +			reset-assert-us = <1000>;
>>> +			reset-deassert-us = <1000>;
>>> +			reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&fec {
>>> +	fsl,magic-packet;
>>> +	phy-handle = <&ethphy1>;
>>> +	phy-mode = "rgmii-id";
>>> +	pinctrl-0 = <&pinctrl_fec>;
>>> +	pinctrl-names = "default";
>>> +	status = "okay";
>>> +
>>> +	mdio {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		ethphy1: ethernet-phy@0 {
>>> +			reg = <0>;
>>> +			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
>>> +			interrupt-parent = <&gpio3>;
>>> +			micrel,led-mode = <0>;

Same as above, micrel,* should go bellow common properties.
I will send a v5 with these fixed.

Michal

>>> +			pinctrl-0 = <&pinctrl_ethphy1>;
>>> +			pinctrl-names = "default";
>>> +			reset-assert-us = <1000>;
>>> +			reset-deassert-us = <1000>;
>>> +			reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
>>> +		};
>>> +	};
>>> +};
>>> +

