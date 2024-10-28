Return-Path: <linux-kernel+bounces-384821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3ED9B2ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A55286C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE21D3644;
	Mon, 28 Oct 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="x6lwJa0H"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0BE19258B;
	Mon, 28 Oct 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114611; cv=none; b=kaA82BE4LkJ3XGorxN6VnO7dKaXOsrUKxmAJLR/x/o344B+xX/jGLkif2Nx1XfONJgBAMQnPwDpFGtOdTCYyCWo+lAStEERbaC60PWR/aTC8EmUDo7kAQu4YYpI3DnDPV3OtGIUBKeQk6hNkEwpXaAeofJPlwRZoxnoYb+Ft4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114611; c=relaxed/simple;
	bh=SuyxiTYdCbpA1kfJXBppdzGESsoDHyulqBof6kweIk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXm3aE77jMWDXPe7MFyCbDehI20zCPCjJjs/qQCEZyiELeCFkus7qBS/oB1hQO+XuI1i0NxRJ7U0HNCUvWRBHZs9Xb/1PQO2cpuVqB1+a6JRYfsxBxxRoakP349HH7J5YDqydF6TcbMs+lUDZjHe4oycQPOU4rozfkKd2g2DJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=x6lwJa0H; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [192.168.1.107] (89-186-114-4.pool.digikabel.hu [89.186.114.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3DCE68907B;
	Mon, 28 Oct 2024 12:23:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730114605;
	bh=9WOt/O2aSaelze2ima45p34Z2cNV949LPG7fDV305A4=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=x6lwJa0HNf64WxDoZRE8mWtAZxSY24eLdRYmNHfIr35c8gEmSuqXeQ+2NMy1YMar1
	 wdGZ4WjDvl1PNM9tfNAxR2bvI2u/BOapPb0pDhnjeSUVBjEbN2ev/9bTKrxJv23qQ+
	 1zipO6PpA2HYe5qGCDh6/HLnwrm94h6EPq7pmsaDKmx+B4aHh+JnglnMj6ikWdL0cM
	 y2Vv+AmM9+MUlpc/RxZLCDPU4btLbFWla0bcp7Bh8H+U5rdjfM/Udt8ygVoqgxzGv6
	 p2TKr+sgDMoHsTum0lWYqUBnLhh+XmaXpP7uNu7XyQJ9B0J0VfOFvN7/2E6C4al/8u
	 UdwSldeQRW/hw==
Message-ID: <1c21a636-5778-03c0-85b0-a4b3710b8f3d@denx.de>
Date: Mon, 28 Oct 2024 12:21:01 +0100
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
 <bf2c81e1-4e97-cfa2-326f-0a6125b2cff9@denx.de>
 <fd4fffb3-44d3-4efb-8c74-4d94e1f26298@kernel.org>
From: Heiko Schocher <hs@denx.de>
Reply-To: hs@denx.de
In-Reply-To: <fd4fffb3-44d3-4efb-8c74-4d94e1f26298@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Krzysztof,

On 28.10.24 11:49, Krzysztof Kozlowski wrote:
> On 28/10/2024 11:41, Heiko Schocher wrote:
>> Hello Krzysztof,
>>
>> On 28.10.24 11:24, Krzysztof Kozlowski wrote:
>>> On 28/10/2024 09:23, Heiko Schocher wrote:
>>>> Add support for the i.MX8MP based aristainetos3 boards from ABB.
>>>>
>>>> The board uses a ABB specific SoM from ADLink, based on NXP
>>>> i.MX8MP SoC. The SoM is used on 3 different carrier boards,
>>>> with small differences, which are all catched up in
>>>> devicetree overlays. The kernel image, the basic dtb
>>>> and all dtbos are collected in a fitimage. As bootloader
>>>> is used U-Boot which detects in his SPL stage the carrier
>>>> board by probing some i2c devices. When the correct
>>>> carrier is probed, the SPL applies all needed dtbos to
>>>> the dtb with which U-Boot gets loaded. Same principle
>>>> later before linux image boot, U-Boot applies the dtbos
>>>> needed for the carrier board before booting Linux.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>> ---
>>>> checkpatch dropped the following warnings:
>>>> arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi:248: warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented -- check ./Documentation/devicetree/bindings/
>>>>
>>>> ignored, as this compatible string is usedin other dts too, for example in
>>>>
>>>> arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>>>>
>>>>    arch/arm64/boot/dts/freescale/Makefile        |    5 +
>>>>    .../imx8mp-aristainetos3-adpismarc.dtsi       |   64 +
>>>>    .../imx8mp-aristainetos3-adpismarc.dtso       |   14 +
>>>>    .../imx8mp-aristainetos3-helios-lvds.dtsi     |   89 ++
>>>>    .../imx8mp-aristainetos3-helios-lvds.dtso     |   13 +
>>>>    .../imx8mp-aristainetos3-helios.dtsi          |  103 ++
>>>>    .../imx8mp-aristainetos3-helios.dtso          |   13 +
>>>>    .../imx8mp-aristainetos3-proton2s.dtsi        |  176 +++
>>>>    .../imx8mp-aristainetos3-proton2s.dtso        |   13 +
>>>>    .../imx8mp-aristainetos3a-som-v1.dts          |   18 +
>>>>    .../imx8mp-aristainetos3a-som-v1.dtsi         | 1210 +++++++++++++++++
>>>>    11 files changed, 1718 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtso
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtsi
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtso
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dts
>>>>    create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>>>> index 9d3df8b218a2..7c3586509b8b 100644
>>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>>> @@ -163,6 +163,11 @@ imx8mn-tqma8mqnl-mba8mx-usbotg-dtbs += imx8mn-tqma8mqnl-mba8mx.dtb imx8mn-tqma8m
>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-lvds-tm070jvhg33.dtb
>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-usbotg.dtb
>>>>    
>>>> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3a-som-v1.dtb \
>>>> +			  imx8mp-aristainetos3-adpismarc.dtbo \
>>>> +			  imx8mp-aristainetos3-proton2s.dtbo \
>>>> +			  imx8mp-aristainetos3-helios.dtbo \
>>>> +			  imx8mp-aristainetos3-helios-lvds.dtbo
>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
>>>>    dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>>>> new file mode 100644
>>>> index 000000000000..cc0cddaa33ea
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>>>> @@ -0,0 +1,64 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
>>>> + */
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>> +
>>>> +&ecspi1 {
>>>> +	spidev0: spi@0 {
>>>> +		reg = <0>;
>>>> +		compatible = "rohm,dh2228fv";
>>>
>>> Hm? I have some doubts, what device is here?
>>
>> $ grep -lr dh2228fv drivers/
>> drivers/spi/spidev.c
>>
>> Customer uses an userspace implementation...
> 
> That's not the question. I asked what device is here.

I do not know, as on carrier boards there are only connectors,
to which a spi device can be attached. So may I need to use here
a more generic entry?

>>
>>>
>>>> +		spi-max-frequency = <500000>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&ecspi2 {
>>>> +	spidev1: spi@0 {
>>>> +		reg = <0>;
>>>> +		compatible = "rohm,dh2228fv";
>>>> +		spi-max-frequency = <500000>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&i2c2 {
>>>> +	/* SX1509(2) U1001@IPi SMARC Plus */
>>>> +	gpio8: i2c2_gpioext0@3e {
>>>
>>> Uh, no, please never send us downstream code.
>>>
>>> Please follow DTS coding style in all upstream submissions.
>>
>> driver is in here:
>>
>> $ grep -lr probe-reset drivers/pinctrl/
>> drivers/pinctrl/pinctrl-sx150x.c
> 
> This so not related... Your driver does not matter. You send us poor
> quality downstream code.

The driver is upstream... see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/pinctrl-sx150x.c

or may I misunderstood you here too?

Poor is my dts, checks are running and I fix them.

> ...
> 
>>
>>> And why this is DTSO, I have no clue...
> 
> Why is this a DTSO, not a DTS?

Hmm... the idea is, that the bootloader applies the dtbo on runtime,
when it has detected the carrier board it runs on, I tried to explain
in cover letter.

And again... sorry...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

