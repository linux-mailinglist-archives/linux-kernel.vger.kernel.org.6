Return-Path: <linux-kernel+bounces-340219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EE7987017
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4101F27722
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FF11AB6E4;
	Thu, 26 Sep 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PUWd1cqe"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B374146596;
	Thu, 26 Sep 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342855; cv=none; b=Z53uCqFCkCTZ1E0r87Fhj6UXsv/5/ev8rGpTEZ7c68c/zJ/6Tj7CKP+iFnmccGr/qYCSq2l7ddksaraBHTYhEaI3IX7Ov696dr4VZKvWkgriTpG0SjCm1Uewzp63RFKneGp+IURn/4lE0XKtq7AajXdQW7wlFj/6pxm15nv6Nd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342855; c=relaxed/simple;
	bh=WszBCde+EyMT4WBEAxT2xIQ69xHlvKCrC89Es5BKJOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhi2fyQNuDOqSYm9vOO2VD/3IFJaLAqQZhRfrBWtcZ24CeOMMNbeRQRjQ79mJp+faZb/pR6O6KQo0MvIa4ngFZYarBpHtmI1LoisNBuR4WpiEXO/vEpBGS1JFduukKn1zcson8qNSAi2oU5U1mPhQ87qpUj1uxUZycivhMtFhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PUWd1cqe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727342851;
	bh=WszBCde+EyMT4WBEAxT2xIQ69xHlvKCrC89Es5BKJOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PUWd1cqesMv/VLO1Bg+GaG4NUi08+6S/4GRiWxRBlFTqF3na0Vml5mu4v0NL/p2o7
	 Dp0eOYFUN7+Y7p1S/30vgv8WI8XaxtsVk+AJMSV6wfPQa+aeufzfr/E+EJJOiz37wb
	 h3wtN0+vob2qHBMrx87IEtPnoXleQom91jT1mDL1VWHG/kCq3Q2nQhLu5fBGvZXfPu
	 4A9gfEnGeQj8xt4pLhHqKG7Xus/2/vuds9JtvNN0ttAAwQNJ6FFFBiGte0FD6hRduW
	 RHT7OMVxuoJBktRCciyuJz9U6W0oF5HMTJRwB5OGSCf4iLR4hdDRPqVpGm38aqGyYy
	 dUB3LOdERVeNQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AD1EC17E1063;
	Thu, 26 Sep 2024 11:27:30 +0200 (CEST)
Message-ID: <bbf023c7-f08b-4f9d-8770-08e63074fb4c@collabora.com>
Date: Thu, 26 Sep 2024 11:27:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediate: Introduce MT8186
 Chinchou/Chinchou360 Chromebooks
To: =?UTF-8?Q?Albert_Jakie=C5=82a?= <jakiela@google.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 wenst@chromium.org, rafal@milecki.pl, hsinyi@chromium.org,
 nfraprado@collabora.com, macpaul.lin@mediatek.com, sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240925080353.2362879-1-jakiela@google.com>
 <20240925080353.2362879-2-jakiela@google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925080353.2362879-2-jakiela@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/09/24 10:03, Albert Jakieła ha scritto:
> The MT8186 Chinchou/Chinchou360, also known as the Asus Chromebook
> CZ12/CZ11 Flip, is a clamshell or convertible device with touchscreen,
> stylus and extra buttons.
> 
> Signed-off-by: Albert Jakieła <jakiela@google.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |   3 +
>   .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
>   .../mediatek/mt8186-corsola-chinchou-sku1.dts |  34 ++
>   .../mt8186-corsola-chinchou-sku16.dts         |  28 ++
>   .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 445 ++++++++++++++++++
>   5 files changed, 528 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 8fd7b2bb7a15..0db7770e8907 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -55,6 +55,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku0.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku1.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku16.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
> new file mode 100644
> index 000000000000..29dd92318da1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-chinchou.dtsi"
> +
> +/ {
> +	model = "Google chinchou sku0 board";
> +	compatible = "google,chinchou-sku0", "google,chinchou-sku2",
> +			"google,chinchou-sku4", "google,chinchou-sku5",
> +			"google,chinchou", "mediatek,mt8186";
> +};
> +
> +&gpio_keys {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
> new file mode 100644
> index 000000000000..8ba31f81d9ad
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-chinchou.dtsi"
> +
> +/ {
> +	model = "Google chinchou sku1/sku17 board";
> +	compatible = "google,chinchou-sku1", "google,chinchou-sku17",
> +			"google,chinchou-sku3", "google,chinchou-sku6",
> +			"google,chinchou-sku7", "google,chinchou-sku20",
> +			"google,chinchou-sku22", "google,chinchou-sku23",
> +			"mediatek,mt8186";
> +};
> +
> +&i2c1 {
> +	i2c-scl-internal-delay-ns = <10000>;
> +
> +	touchscreen: touchscreen@41 {
> +		compatible = "ilitek,ili2901";
> +		reg = <0x41>;
> +		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_pins>;
> +		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
> +		vccio-supply = <&pp1800_tchscr_report_disable>;
> +	};
> +};
> +
> +&gpio_keys {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
> new file mode 100644
> index 000000000000..d3378d7ad096
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-chinchou.dtsi"
> +
> +/ {
> +	model = "Google chinchou sku16/sku2147483647 board";
> +	compatible = "google,chinchou-sku16", "google,chinchou-sku18",
> +			"google,chinchou-sku19", "google,chinchou-sku21",
> +			"google,chinchou-sku2147483647", "mediatek,mt8186";
> +};
> +
> +&i2c1 {
> +	i2c-scl-internal-delay-ns = <10000>;
> +
> +	touchscreen: touchscreen@41 {
> +		compatible = "ilitek,ili2901";
> +		reg = <0x41>;
> +		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_pins>;
> +		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
> +		vccio-supply = <&pp1800_tchscr_report_disable>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> new file mode 100644
> index 000000000000..c77cc43f8442
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi

..snip..

> +
> +&mmc1_pins_default {
> +	pins-clk {
> +		drive-strength = <MTK_DRIVE_8mA>;

Please stop using the meaningless MTK_DRIVE_(x)mA macro.

drive-strength = <8>; is enough :-)

Cheers,
Angelo

> +	};
> +
> +	pins-cmd-dat {
> +		drive-strength = <MTK_DRIVE_8mA>;
> +	};
> +};
> +
> +&mmc1_pins_uhs {
> +	pins-clk {
> +		drive-strength = <MTK_DRIVE_8mA>;
> +	};
> +
> +	pins-cmd-dat {
> +		drive-strength = <MTK_DRIVE_8mA>;
> +	};
> +};
> +
> +&sound {
> +	status = "okay";
> +
> +	compatible = "mediatek,mt8186-mt6366-rt5650-sound";

You don't need to change this compatible, as the only thing that changes in the
actual driver are the dapm_routes. I implemented support for that nice dai-link
(standard, kind of) graph so that we stop getting a thousand compatibles for no
reason other than routing :-)

This should work with (99.9% confident it will, but please test):

	model = "mt8186_rt5650";
	status = "okay";

> +	mediatek,adsp = <&adsp>;

This property is already set in the node that you're inheriting from
mt8186-corsola.dtsi, please drop.

> +
> +	audio-routing =
> +		"Headphone", "HPOL",
> +		"Headphone", "HPOR",
> +		"HDMI1", "TX";
> +
> +	hs-playback-dai-link {
> +		codec {
> +			sound-dai = <&rt5650>;
> +		};
> +	};
> +
> +	hs-capture-dai-link {
> +		codec {
> +			sound-dai = <&rt5650>;
> +		};
> +	};
> +
> +	spk-share-dai-link {
> +	};

Empty nodes are meaningless (and you're inheriting this dai link from
mt8186-corsola.dtsi as well). Drop.

> +
> +	spk-hdmi-playback-dai-link {
> +		codec {
> +			sound-dai = <&it6505dptx>;
> +		};
> +	};
> +};
> +
> +&wifi_enable_pin {
> +	pins-wifi-enable {
> +		pinmux = <PINMUX_GPIO51__FUNC_GPIO51>;
> +	};
> +};
> +
> +&wifi_pwrseq {
> +	reset-gpios = <&pio 51 GPIO_ACTIVE_LOW>;
> +};
> +

..snip..

> +
> +&pen_insert {
> +	wakeup-event-action = <EV_ACT_ANY>;

Why is this set to EV_ACT_ANY on Chinchou but not on the other Corsola devices?
Is there any specific reason?

Cheers,
Angelo


