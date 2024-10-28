Return-Path: <linux-kernel+bounces-384969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F5E9B30D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C63E282311
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64471DB37B;
	Mon, 28 Oct 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX3H+UTI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24651DB943;
	Mon, 28 Oct 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119465; cv=none; b=H1YVt/ArCPn9qDKRJCaObo55Pn/cuf1Tq24oYnbm0muC8+5yvbEnEFHySIG0fKenqz2Du8NloiQb2YTldtHTYD2We4WIjsMkTzNtjcUlOKQXzR8XMZUNTQZ5beloK9snxk6YMnCgz/e61VTz9CNEA9sNARfGNktekXv2Fk/9pn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119465; c=relaxed/simple;
	bh=VwZ9IZR5Q9q9+rWO0vR3QoA58P01r5/+aKkI8SPCRew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiskUlxj6XLE5IHVkGXOx0dKr+yhclht/FRKedMXbxhjb6WkptOwjGl8FkpS4P5MQAWtiXawYk7oyyN8E/XziISa4aNfbie+vNjQHbmzlgLmb8OU2COAPC2MC73CUixQ22dQmWOckbdi/vsDnzLHIH+KnJCRALEpVSx3uZtLR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX3H+UTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0499BC4CEC3;
	Mon, 28 Oct 2024 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730119465;
	bh=VwZ9IZR5Q9q9+rWO0vR3QoA58P01r5/+aKkI8SPCRew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hX3H+UTI4CMLAlJQ6Fl/WsKtmQAMFAwJSc+vw0kdpqR1FAInYngxKsXoKNP3VaH+7
	 xfPrCqsBpxgE4rL4jhiGPFpSJQlaZVqGAB2/TwweBRP4ziNS0oPX5k1KcrFXoefdGA
	 N6XhVgoClIdu/yU4p6jhp3mc9CQUiKhQUIskclwL9hDRutqPFRmIP/jPrZQkhpd+zl
	 Yy9jL++D/Mx5GildJIvf4fCbOJ3hXY6bdp82/HRgnC7rUQDPLRa2UaewSl8PpPXF8s
	 Bvp/3SaCO0clcwwvvVrKdGC+4BVGr/rusLN/yFSYXE/QbztqXpe4tdlgjX4OrB34/v
	 l/JkTJxcNLfVg==
Message-ID: <0b3ea279-bdbd-4608-94d8-5f53fdd12024@kernel.org>
Date: Mon, 28 Oct 2024 13:44:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: imx8mp: add aristainetos3 board
 support
To: hs@denx.de, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20241028082332.21672-1-hs@denx.de>
 <20241028082332.21672-3-hs@denx.de>
 <f4150aa3-4c0e-45fa-9c9c-879ac04c4364@kernel.org>
 <bf2c81e1-4e97-cfa2-326f-0a6125b2cff9@denx.de>
 <fd4fffb3-44d3-4efb-8c74-4d94e1f26298@kernel.org>
 <1c21a636-5778-03c0-85b0-a4b3710b8f3d@denx.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <1c21a636-5778-03c0-85b0-a4b3710b8f3d@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2024 12:21, Heiko Schocher wrote:
> Hello Krzysztof,
> 
> On 28.10.24 11:49, Krzysztof Kozlowski wrote:
>> On 28/10/2024 11:41, Heiko Schocher wrote:
>>> Hello Krzysztof,
>>>
>>> On 28.10.24 11:24, Krzysztof Kozlowski wrote:
>>>> On 28/10/2024 09:23, Heiko Schocher wrote:
>>>>> Add support for the i.MX8MP based aristainetos3 boards from ABB.
>>>>>
>>>>> The board uses a ABB specific SoM from ADLink, based on NXP
>>>>> i.MX8MP SoC. The SoM is used on 3 different carrier boards,
>>>>> with small differences, which are all catched up in
>>>>> devicetree overlays. The kernel image, the basic dtb
>>>>> and all dtbos are collected in a fitimage. As bootloader
>>>>> is used U-Boot which detects in his SPL stage the carrier
>>>>> board by probing some i2c devices. When the correct
>>>>> carrier is probed, the SPL applies all needed dtbos to
>>>>> the dtb with which U-Boot gets loaded. Same principle
>>>>> later before linux image boot, U-Boot applies the dtbos
>>>>> needed for the carrier board before booting Linux.
>>>>>
>>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>>> ---
>>>>> checkpatch dropped the following warnings:
>>>>> arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi:248: warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented -- check ./Documentation/devicetree/bindings/
>>>>>
>>>>> ignored, as this compatible string is usedin other dts too, for example in
>>>>>
>>>>> arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>>>>>
>>>>>    arch/arm64/boot/dts/freescale/Makefile        |    5 +
>>>>>    .../imx8mp-aristainetos3-adpismarc.dtsi       |   64 +
>>>>>    .../imx8mp-aristainetos3-adpismarc.dtso       |   14 +
>>>>>    .../imx8mp-aristainetos3-helios-lvds.dtsi     |   89 ++
>>>>>    .../imx8mp-aristainetos3-helios-lvds.dtso     |   13 +
>>>>>    .../imx8mp-aristainetos3-helios.dtsi          |  103 ++
>>>>>    .../imx8mp-aristainetos3-helios.dtso          |   13 +
>>>>>    .../imx8mp-aristainetos3-proton2s.dtsi        |  176 +++
>>>>>    .../imx8mp-aristainetos3-proton2s.dtso        |   13 +
>>>>>    .../imx8mp-aristainetos3a-som-v1.dts          |   18 +
>>>>>    .../imx8mp-aristainetos3a-som-v1.dtsi         | 1210 +++++++++++++++++
>>>>>    11 files changed, 1718 insertions(+)
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtso
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtsi
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtso
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>>>>> index 9d3df8b218a2..7c3586509b8b 100644
>>>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>>>> @@ -163,6 +163,11 @@ imx8mn-tqma8mqnl-mba8mx-usbotg-dtbs += imx8mn-tqma8mqnl-mba8mx.dtb imx8mn-tqma8m
>>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-lvds-tm070jvhg33.dtb
>>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-usbotg.dtb
>>>>>    
>>>>> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3a-som-v1.dtb \
>>>>> +			  imx8mp-aristainetos3-adpismarc.dtbo \
>>>>> +			  imx8mp-aristainetos3-proton2s.dtbo \
>>>>> +			  imx8mp-aristainetos3-helios.dtbo \
>>>>> +			  imx8mp-aristainetos3-helios-lvds.dtbo
>>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
>>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
>>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
>>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..cc0cddaa33ea
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>>>>> @@ -0,0 +1,64 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>> +/*
>>>>> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
>>>>> + */
>>>>> +
>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>>> +
>>>>> +&ecspi1 {
>>>>> +	spidev0: spi@0 {
>>>>> +		reg = <0>;
>>>>> +		compatible = "rohm,dh2228fv";
>>>>
>>>> Hm? I have some doubts, what device is here?
>>>
>>> $ grep -lr dh2228fv drivers/
>>> drivers/spi/spidev.c
>>>
>>> Customer uses an userspace implementation...
>>
>> That's not the question. I asked what device is here.
> 
> I do not know, as on carrier boards there are only connectors,
> to which a spi device can be attached. So may I need to use here
> a more generic entry?

So this description is just not true. You have here nothing connected
and this cannot be in the DTS.

> 
>>>
>>>>
>>>>> +		spi-max-frequency = <500000>;
>>>>> +	};
>>>>> +};
>>>>> +
>>>>> +&ecspi2 {
>>>>> +	spidev1: spi@0 {
>>>>> +		reg = <0>;
>>>>> +		compatible = "rohm,dh2228fv";
>>>>> +		spi-max-frequency = <500000>;
>>>>> +	};
>>>>> +};
>>>>> +
>>>>> +&i2c2 {
>>>>> +	/* SX1509(2) U1001@IPi SMARC Plus */
>>>>> +	gpio8: i2c2_gpioext0@3e {
>>>>
>>>> Uh, no, please never send us downstream code.
>>>>
>>>> Please follow DTS coding style in all upstream submissions.
>>>
>>> driver is in here:
>>>
>>> $ grep -lr probe-reset drivers/pinctrl/
>>> drivers/pinctrl/pinctrl-sx150x.c
>>
>> This so not related... Your driver does not matter. You send us poor
>> quality downstream code.
> 
> The driver is upstream... see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/pinctrl-sx150x.c
> 
> or may I misunderstood you here too?
> 
> Poor is my dts, checks are running and I fix them.

My comment was that I see this as you sent DTS code which is taken
straight from some downstream code.

>>>> And why this is DTSO, I have no clue...
>>
>> Why is this a DTSO, not a DTS?
> 
> Hmm... the idea is, that the bootloader applies the dtbo on runtime,
> when it has detected the carrier board it runs on, I tried to explain
> in cover letter.

Then there is some mess here. First, SoM cannot be DTS, because it
cannot be booted. Second, specific board/carrier is the DTS. Third,
overlays bring some subset of features, not new board.

Best regards,
Krzysztof


