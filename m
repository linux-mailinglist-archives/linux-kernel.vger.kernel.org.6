Return-Path: <linux-kernel+bounces-420976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB49D8503
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB11D1633A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CAA199EB7;
	Mon, 25 Nov 2024 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GCRAvJGp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27013774D;
	Mon, 25 Nov 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536261; cv=none; b=aZyvGLcDLG8moDWBJ57arP2RKM8p+0XqomTvWEx7+2tLPEkwkxKDZLHgVGMyZdmjETOMCwxQNkQBygFg3TAlrLgYGrjRA4U7ekh0dx8yl1PGHXnGJ9GKsNX6CDdWfR1fmpS94bW1rRBJeYaU5dvuW1wj5qlJczFHG2AO9jukKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536261; c=relaxed/simple;
	bh=efeNB/rKqi3tpa04/LtQ2JCpX8cpJMScuUTG9pnf4Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENwYjXXcj+tuVUjJi1Oh7w4FGFjvbCp+RHK+nwWjQNHdpZl9QLnekphrtHhjJwhDYO7gfxIQAj114lldXR26q4RKD+8++V+wmJlzCeuWdWA96ipnQqSeGEjEiuvEP3QPcgUMXiqk/k2CR6wiWDtglaOWVFTnzldB+gOvu09fO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GCRAvJGp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732536256;
	bh=efeNB/rKqi3tpa04/LtQ2JCpX8cpJMScuUTG9pnf4Z8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GCRAvJGpPGX26CoTYnsb2eoDBqZi5XJcZfpbBt7jCBQgV5rCx8NJgGxqWL1x8CoD+
	 9Gf2I8UIZ8vin/e+DlEWH6A1D4j3HWv3SpatgZ2zoBgNT4cGdFBfZXSqSXQZc8PIzA
	 WOv/LE56HrsqMqpvhDtLP+GewLrfTWmoSlQdYxvmU2wPGxuZOMq8a52k/xor0zL4Lh
	 zYyHKNEaFYb+WjBSGEfgRm4oTcwo2Ca5waMI/i/MoQ8lzRfmi2WJ774dW76W/BWTdK
	 bs1T27300oMLKYnRFz7gCbL79f/P93Zy2EoliEY0QjPYi98n1cMGWT/qMdqB+E8ZSR
	 JuERgB62fFkfQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F48017E3624;
	Mon, 25 Nov 2024 13:04:16 +0100 (CET)
Message-ID: <1986c5d3-c897-4218-8a60-02ec69c28ae9@collabora.com>
Date: Mon, 25 Nov 2024 13:04:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8186: Add Starmie device
To: Wojciech Macek <wmacek@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Rafal Milecki <rafal@milecki.pl>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241125082130.2390310-1-wmacek@chromium.org>
 <20241125082130.2390310-3-wmacek@chromium.org>
 <c82a4fbf-824e-4196-99a1-84fd4e836951@collabora.com>
 <CAJrw_jnER6ozh+TiD=nw-DJWf78DKFy-PEVezv-H4ArTrXHS9A@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAJrw_jnER6ozh+TiD=nw-DJWf78DKFy-PEVezv-H4ArTrXHS9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/11/24 11:15, Wojciech Macek ha scritto:
> Sure, I will work on it. Thanks.
> 
>>> +
>>> +             compatible = "ilitek,ili9882t";
> 
>> I can't find this compatible anywhere in any kernel driver. That won't
> work.
> 
> Actually, the compat is defined in ./drivers/hid/i2c-hid/i2c-hid-of-elan.c
> 

Oh, I typo'ed the compatible while grepping. Sorry, you're right about that.

Cheers,
Angelo

> 
> Regards,
> Wojtek
> 
> On Mon, Nov 25, 2024 at 10:05 AM AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com> wrote:
> 
>> Il 25/11/24 09:21, Wojciech Macek ha scritto:
>>> Add support for Starmie Chromebooks.
>>>
>>> Signed-off-by: Wojciech Macek <wmacek@chromium.org>
>>> ---
>>> Changelog v2-v1:
>>>    - no change
>>>
>>>    arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>>>    .../mediatek/mt8186-corsola-starmie-sku0.dts  |  29 ++
>>>    .../mediatek/mt8186-corsola-starmie-sku1.dts  |  46 ++
>>>    .../dts/mediatek/mt8186-corsola-starmie.dtsi  | 480 ++++++++++++++++++
>>>    4 files changed, 557 insertions(+)
>>>    create mode 100644
>> arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
>>>    create mode 100644
>> arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
>>>    create mode 100644
>> arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile
>> b/arch/arm64/boot/dts/mediatek/Makefile
>>> index 8fd7b2bb7a159..2ee6266ddf43d 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -59,6 +59,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=
>> mt8186-corsola-magneton-sku393216.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-starmie-sku0.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-starmie-sku1.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
>>> diff --git
>> a/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
>> b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
>>> new file mode 100644
>>> index 0000000000000..ca0b8492bbef5
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
>>> @@ -0,0 +1,29 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright 2023 Google LLC
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "mt8186-corsola-starmie.dtsi"
>>> +
>>> +/ {
>>> +     model = "Google Starmie sku0 board";
>>> +     compatible = "google,starmie-sku0", "google,starmie-sku2",
>>> +                  "google,starmie-sku3", "google,starmie",
>>> +                  "mediatek,mt8186";
>>> +};
>>> +
>>> +&panel {
>>> +     compatible = "starry,ili9882t";
>>> +};
>>> +
>>> +&i2c_tunnel {
>>> +     /delete-node/ sbs-battery@b;
>>> +
>>> +     battery: sbs-battery@f {
>>> +             compatible = "sbs,sbs-battery";
>>> +             reg = <0xf>;
>>> +             sbs,i2c-retry-count = <2>;
>>> +             sbs,poll-retry-count = <1>;
>>> +     };
>>> +};
>>> diff --git
>> a/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
>> b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
>>> new file mode 100644
>>> index 0000000000000..2ba4c083a58c6
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
>>> @@ -0,0 +1,46 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright 2023 Google LLC
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "mt8186-corsola-starmie.dtsi"
>>> +
>>> +/ {
>>> +     model = "Google Starmie sku1 board";
>>> +     compatible = "google,starmie-sku1", "google,starmie-sku4",
>>> +                  "google,starmie", "mediatek,mt8186";
>>> +};
>>> +
>>> +&panel {
>>> +     compatible = "starry,himax83102-j02";
>>> +};
>>> +
>>> +&i2c1 {
>>> +     /delete-node/ touchscreen@41;
>>> +     touchscreen_himax: touchscreen@4f {
>>> +             status = "okay";
>>
>> Okay is the default.
>>
>>> +
>>> +             compatible = "hid-over-i2c";
>>> +             reg = <0x4f>;
>>> +             interrupt-parent = <&pio>;
>>> +             interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&touchscreen_pins>;
>>> +             vdd-supply = <&mt6366_vio18_reg>;
>>> +             panel = <&panel>;
>>> +             post-power-on-delay-ms = <450>;
>>> +             hid-descr-addr = <0x0001>;
>>> +     };
>>> +};
>>> +
>>> +&i2c_tunnel {
>>> +     /delete-node/ sbs-battery@b;
>>
>> Would status = "disabled" not work for sbs-battery@b?
>>
>>> +
>>> +     battery: sbs-battery@f {
>>
>> You're defining sbs-battery@f in every starmie dts, you can move that to
>> the
>> starmie dtsi instead, so that you can avoid all the useless duplication.
>>
>>> +             compatible = "sbs,sbs-battery";
>>> +             reg = <0xf>;
>>> +             sbs,i2c-retry-count = <2>;
>>> +             sbs,poll-retry-count = <1>;
>>> +     };
>>> +};
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi
>> b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi
>>> new file mode 100644
>>> index 0000000000000..28ac65d28143e
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi
>>> @@ -0,0 +1,480 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright 2023 Google LLC
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "mt8186-corsola.dtsi"
>>> +
>>> +/delete-node/ &dsi_out;
>>
>> Instead of hacking in a delete-node, you can just change mt8186.dtsi at
>> this point,
>> or you can use the current dsi_out phandle. I would prefer that you do the
>> latter,
>> as it's going to be more convenient later when I'll have to migrate this
>> platform
>> to the full OF Graph for the display controller.
>>
>>> +/delete-node/ &keyboard_controller;
>>> +
>>> +/ {
>>> +     en_pp6000_mipi_disp_150ma: en-pp6000-mipi-disp-150ma {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "en_pp6000_mipi_disp_150ma";
>>> +             gpio = <&pio 154 GPIO_ACTIVE_HIGH>;
>>> +             enable-active-high;
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&pp6000_mipi_disp_150ma_fixed_pins>;
>>> +     };
>>> +
>>> +     tboard_thermistor1: thermal-sensor1 {
>>> +             compatible = "generic-adc-thermal";
>>> +             #thermal-sensor-cells = <0>;
>>> +             io-channels = <&auxadc 0>;
>>> +             io-channel-names = "sensor-channel";
>>> +             temperature-lookup-table = <    (-5000) 1492
>>> +                                             0 1413
>>> +                                             5000 1324
>>> +                                             10000 1227
>>> +                                             15000 1121
>>> +                                             20000 1017
>>> +                                             25000 900
>>> +                                             30000 797
>>> +                                             35000 698
>>> +                                             40000 606
>>> +                                             45000 522
>>> +                                             50000 449
>>> +                                             55000 383
>>> +                                             60000 327
>>> +                                             65000 278
>>> +                                             70000 236
>>> +                                             75000 201
>>> +                                             80000 171
>>> +                                             85000 145
>>> +                                             90000 163
>>> +                                             95000 124
>>> +                                             100000 91
>>> +                                             105000 78
>>> +                                             110000 67
>>> +                                             115000 58
>>> +                                             120000 50
>>> +                                             125000 44>;
>>> +     };
>>> +
>>> +     tboard_thermistor2: thermal-sensor2 {
>>> +             compatible = "generic-adc-thermal";
>>> +             #thermal-sensor-cells = <0>;
>>> +             io-channels = <&auxadc 1>;
>>> +             io-channel-names = "sensor-channel";
>>> +             temperature-lookup-table = <    (-5000) 1492
>>> +                                             0 1413
>>> +                                             5000 1324
>>> +                                             10000 1227
>>> +                                             15000 1121
>>> +                                             20000 1017
>>> +                                             25000 900
>>> +                                             30000 797
>>> +                                             35000 698
>>> +                                             40000 606
>>> +                                             45000 522
>>> +                                             50000 449
>>> +                                             55000 383
>>> +                                             60000 327
>>> +                                             65000 278
>>> +                                             70000 236
>>> +                                             75000 201
>>> +                                             80000 171
>>> +                                             85000 145
>>> +                                             90000 163
>>> +                                             95000 124
>>> +                                             100000 91
>>> +                                             105000 78
>>> +                                             110000 67
>>> +                                             115000 58
>>> +                                             120000 50
>>> +                                             125000 44>;
>>> +     };
>>> +};
>>> +
>>> +&cros_ec {
>>> +     cbas: cbas {
>>> +             compatible = "google,cros-cbas";
>>> +     };
>>> +
>>> +     keyboard-controller {
>>> +             compatible = "google,cros-ec-keyb-switches";
>>> +     };
>>> +};
>>> +
>>> +&dsi0 {
>>> +     status = "okay";
>>> +     #address-cells = <1>;
>>> +     #size-cells = <0>;
>>> +     panel: panel@0 {
>>> +             /* compatible will be set in board dts */
>>> +             reg = <0>;
>>> +             enable-gpios = <&pio 98 0>;
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&panel_pins_default>;
>>> +             avdd-supply = <&en_pp6000_mipi_disp>;
>>> +             avee-supply = <&en_pp6000_mipi_disp_150ma>;
>>> +             pp1800-supply = <&mt6366_vio18_reg>;
>>> +             backlight = <&backlight_lcd0>;
>>> +             rotation = <270>;
>>> +             port {
>>> +                     panel_in: endpoint {
>>> +                             remote-endpoint = <&dsi_out>;
>>> +                     };
>>> +             };
>>> +     };
>>> +
>>> +     ports {
>>> +             port {
>>> +                     dsi_out: endpoint {
>>> +                             remote-endpoint = <&panel_in>;
>>> +                     };
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&i2c0 {
>>> +     status = "disabled";
>>> +};
>>> +
>>> +&i2c1 {
>>> +     touchscreen: touchscreen@41 {
>>> +             status = "okay";
>>
>> Status is okay by default.
>>
>>> +
>>> +             compatible = "ilitek,ili9882t";
>>
>> I can't find this compatible anywhere in any kernel driver. That won't
>> work.
>>
>>> +             reg = <0x41>;
>>> +             interrupt-parent = <&pio>;
>>> +             interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
>>
>> interrupts-extended please
>>
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&touchscreen_pins>;
>>> +             panel = <&panel>;
>>> +             reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
>>> +             vccio-supply = <&mt6366_vio18_reg>;
>>> +     };
>>> +};
>>> +
>>> +&i2c2 {
>>> +     status = "disabled";
>>> +};
>>> +
>>> +&i2c4 {
>>> +     status = "disabled";
>>> +};
>>> +
>>> +&i2c5 {
>>> +     clock-frequency = <400000>;
>>> +
>>> +};
>>> +
>>> +&mmc1_pins_default {
>>> +     pins-clk {
>>> +             drive-strength = <MTK_DRIVE_8mA>;
>>
>> Please stop using MTK_DRIVE_xxmA definitions. This is just <8>.
>>
>>> +     };
>>> +
>>> +     pins-cmd-dat {
>>> +             drive-strength = <MTK_DRIVE_8mA>;
>>> +     };
>>> +};
>>> +
>>> +&mmc1_pins_uhs {
>>> +     pins-clk {
>>> +             drive-strength = <MTK_DRIVE_8mA>;
>>> +     };
>>> +
>>> +     pins-cmd-dat {
>>> +             drive-strength = <MTK_DRIVE_8mA>;
>>> +     };
>>> +};
>>> +
>>> +&pen_insert {
>>> +     wakeup-event-action = <EV_ACT_ANY>;
>>> +};
>>> +
>>> +&pio {
>>
>> ..snip..
>>
>>> +
>>> +     dpi_pin_default: dpi-pin-default {
>>> +             pins-cmd-dat {
>>> +                     pinmux = <PINMUX_GPIO103__FUNC_GPIO103>,
>>> +                              <PINMUX_GPIO104__FUNC_GPIO104>,
>>> +                              <PINMUX_GPIO105__FUNC_GPIO105>,
>>> +                              <PINMUX_GPIO106__FUNC_GPIO106>,
>>> +                              <PINMUX_GPIO107__FUNC_GPIO107>,
>>> +                              <PINMUX_GPIO108__FUNC_GPIO108>,
>>> +                              <PINMUX_GPIO109__FUNC_GPIO109>,
>>> +                              <PINMUX_GPIO110__FUNC_GPIO110>,
>>> +                              <PINMUX_GPIO111__FUNC_GPIO111>,
>>> +                              <PINMUX_GPIO112__FUNC_GPIO112>,
>>> +                              <PINMUX_GPIO113__FUNC_GPIO113>,
>>> +                              <PINMUX_GPIO114__FUNC_GPIO114>,
>>> +                              <PINMUX_GPIO101__FUNC_GPIO101>,
>>> +                              <PINMUX_GPIO100__FUNC_GPIO100>,
>>> +                              <PINMUX_GPIO102__FUNC_GPIO102>,
>>> +                              <PINMUX_GPIO99__FUNC_GPIO99>;
>>> +                     drive-strength = <MTK_DRIVE_10mA>;
>>
>> Please stop using MTK_DRIVE_xxmA definitions. This is <10>.
>>
>>
>>> +                     output-low;
>>> +             };
>>> +     };
>>> +
>>> +     dpi_pin_func: dpi-pin-func {
>>> +             pins-cmd-dat {
>>> +                     pinmux = <PINMUX_GPIO103__FUNC_DPI_DATA0>,
>>> +                              <PINMUX_GPIO104__FUNC_DPI_DATA1>,
>>> +                              <PINMUX_GPIO105__FUNC_DPI_DATA2>,
>>> +                              <PINMUX_GPIO106__FUNC_DPI_DATA3>,
>>> +                              <PINMUX_GPIO107__FUNC_DPI_DATA4>,
>>> +                              <PINMUX_GPIO108__FUNC_DPI_DATA5>,
>>> +                              <PINMUX_GPIO109__FUNC_DPI_DATA6>,
>>> +                              <PINMUX_GPIO110__FUNC_DPI_DATA7>,
>>> +                              <PINMUX_GPIO111__FUNC_DPI_DATA8>,
>>> +                              <PINMUX_GPIO112__FUNC_DPI_DATA9>,
>>> +                              <PINMUX_GPIO113__FUNC_DPI_DATA10>,
>>> +                              <PINMUX_GPIO114__FUNC_DPI_DATA11>,
>>> +                              <PINMUX_GPIO101__FUNC_DPI_HSYNC>,
>>> +                              <PINMUX_GPIO100__FUNC_DPI_VSYNC>,
>>> +                              <PINMUX_GPIO102__FUNC_DPI_DE>,
>>> +                              <PINMUX_GPIO99__FUNC_DPI_PCLK>;
>>> +                     drive-strength = <MTK_DRIVE_10mA>;
>>> +             };
>>> +     };
>>> +
>>> +     edp_panel_fixed_pins: edp-panel-fixed-pins {
>>> +             pins1 {
>>
>> I don't see where you're using this pin. Please don't add unused pins.
>>
>>> +                     pinmux = <PINMUX_GPIO153__FUNC_GPIO153>;
>>> +                     output-low;
>>> +             };
>>> +     };
>>> +
>>> +     pp6000_mipi_disp_150ma_fixed_pins:
>> pp6000-mipi-disp-150ma-fixed-pins {
>>> +             pins1 {
>>
>> pins-en {
>>
>>> +                     pinmux = <PINMUX_GPIO154__FUNC_GPIO154>;
>>> +                     output-low;
>>> +             };
>>> +     };
>>> +
>>> +     panel_pins_default: panel-pins-default {
>>> +             pins1 {
>>
>> pins-en {
>>
>>> +                     pinmux = <PINMUX_GPIO98__FUNC_GPIO98>;
>>> +                     output-low;
>>> +             };
>>> +     };
>>> +     wifi_pins_pwrseq: wifipwrseq {
>>
>> Like this, that's unused.
>>
>> You do have a wifi_enable_pin in mt8186-corsola.dtsi though, so override
>> it.
>>
>>> +             pins-wifi-enable {
>>> +                     pinmux = <PINMUX_GPIO51__FUNC_GPIO51>;
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&usb_c1 {
>>> +     status = "disabled";
>>> +};
>>> +
>>> +&thermal_zones {
>>> +     tboard1 {
>>> +             polling-delay = <1000>; /* milliseconds */
>>> +             polling-delay-passive = <0>; /* milliseconds */
>>> +             thermal-sensors = <&tboard_thermistor1>;
>>> +     };
>>> +
>>> +     tboard2 {
>>> +             polling-delay = <1000>; /* milliseconds */
>>> +             polling-delay-passive = <0>; /* milliseconds */
>>> +             thermal-sensors = <&tboard_thermistor2>;
>>> +     };
>>> +};
>>> +
>>> +&wifi_pwrseq {
>>> +     reset-gpios = <&pio 51 1>;
>>> +};
>>> +
>>> +en_pp6000_mipi_disp: &pp3300_disp_x {
>>
>> ....but pp6000 is not pp3300, so move the pp3300 to the relevant board dts
>> and define the pp6000 here, or names won't match.
>>
>>> +     regulator-name = "en_pp6000_mipi_disp";
>>> +     gpio = <&pio 153 GPIO_ACTIVE_HIGH>;
>>> +     regulator-enable-ramp-delay = <3000>;
>>> +     /delete-property/ regulator-boot-on;
>>> +};
>>
>> Regards,
>> Angelo
>>
> 




