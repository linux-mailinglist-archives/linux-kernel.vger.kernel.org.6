Return-Path: <linux-kernel+bounces-573801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA0CA6DC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F0F3ADA22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4225F7BD;
	Mon, 24 Mar 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hGbYObwC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206FC1AAA1D;
	Mon, 24 Mar 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825369; cv=none; b=EAw/i3Xro/yK9EAx+K6npv2PV1j16YODpWgLXB/bgROasz/J3OR339WA4b+hfhjfZS1iJkoJdWTxuzTgoDt8oQVwk6g8SYb6D56iEqO7OqfPslVAthszo2khO/6j7OvfTqgb5qNz05xuR9Up0LL+mTCKNta0vnfp+rHHDs2r8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825369; c=relaxed/simple;
	bh=zEZSfIN6Fl3MEvV/0zekr5/YFxEumJScw7YduuaZH0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7NW9JWyp9t0B8p983jyzsFyg2NtxGibgI+suJitGqjVEZLxCa0fMtE3nZ/jQbmVcOLP4vgnb+uSq9TRH84gEcjyFkOv0d9XLFIi/TZN/BqLuuttTtPpuYgd3sy6P28Mf5r9fntDAsLvdX/lXgsSaIdk0b1f3XK1VwCKCocvFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hGbYObwC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742825365;
	bh=zEZSfIN6Fl3MEvV/0zekr5/YFxEumJScw7YduuaZH0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hGbYObwCSzoMoUuei5KO2c0n1ogWFHwWv6dnJYjUJzp/5l+wPKvHZ2G4z8mlpLgQS
	 gUfa8uFaVqfwsgcb/DCgmYTCWHMDSCFcsbIoAtycwxOvyRJbtwg6omYK4fjg2dtEWq
	 mg2drmy/m3aCanjQGo4c4lTRec86x6pf5sQJLrH3PnnwNVErpkCCk/9MVW84K9AID5
	 W+cNucu8TyZzZv/Suzy1L4icNc+1YxwsNBf1UrfpMmPNnwABHYz3h60UYJ1EYPmtDH
	 au+C3CMjPvV9tI785lT6f3JWQDE4eOk9FMZ7MXQTpRy6tYDyaa+Q0cZwrVsYGVF2zu
	 4L/0gkykc2IYg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AC28F17E088D;
	Mon, 24 Mar 2025 15:09:24 +0100 (CET)
Message-ID: <ecd8a46e-0f87-498e-8a12-fdeae6f5791d@collabora.com>
Date: Mon, 24 Mar 2025 15:09:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] arm64: dts: mediatek: add mmc2 support for
 mt8365-evk
To: Alexandre Mergnat <amergnat@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 macpaul.Lin@mediatek.com
Cc: vsatoes@baylibre.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250109-mmc2-support-v2-1-5f660c809610@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250109-mmc2-support-v2-1-5f660c809610@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/03/25 14:54, Alexandre Mergnat ha scritto:
> Adds support for the MMC2 interface on the MT8365 EVK board.
> It introduces a fixed regulator for the MMC2 VDD33 supply and configures
> the MMC2 node with a 4-bit bus width, high-speed capabilities, UHS
> modes, and appropriate power supplies. Enabled SDIO IRQ, wakeup source,
> and kept power during suspend (to save firmware module) for wireless
> chip functionality.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
> Changes in v2:
> - Apply alphabetical order to pinctrl property items.
> - Improve commit message
> - Link to v1: https://lore.kernel.org/r/20250109-mmc2-support-v1-1-9b9d1b1ae35d@baylibre.com
> ---
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 103 +++++++++++++++++++++++++---
>   1 file changed, 94 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> index 7d90112a7e274..a87f1b3ed6500 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -53,6 +53,15 @@ memory@40000000 {
>   		reg = <0 0x40000000 0 0xc0000000>;
>   	};
>   
> +	mmc2_vdd33: mmc2_vdd33-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "mmc2_vdd33";

mmc2-vdd33 please

> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pio 121 0>;
> +		enable-active-high;
> +	};
> +
>   	usb_otg_vbus: regulator-0 {
>   		compatible = "regulator-fixed";
>   		regulator-name = "otg_vbus";
> @@ -197,6 +206,28 @@ &mmc1 {
>   	status = "okay";
>   };
>   
> +&mmc2 {
> +	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL>;
> +	assigned-clocks = <&topckgen CLK_TOP_MSDC50_2_SEL>;
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	hs400-ds-delay = <0x12012>;
> +	keep-power-in-suspend;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	pinctrl-0 = <&mmc2_default_pins>;
> +	pinctrl-1 = <&mmc2_uhs_pins>;
> +	pinctrl-names = "default", "state_uhs";
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	vmmc-supply = <&mmc2_vdd33>;
> +	vqmmc-supply = <&mt6357_vcn18_reg>;
> +	wakeup-source;
> +	status = "okay";
> +};
> +
>   &mt6357_pmic {
>   	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
>   	interrupt-controller;
> @@ -324,8 +355,8 @@ cmd-dat-pins {
>   				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
>   				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
>   				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
> -			input-enable;
>   			bias-pull-up;
> +			input-enable;

This is a cleanup and goes to a different commit

>   		};
>   
>   		rst-pins {
> @@ -337,8 +368,8 @@ rst-pins {
>   	mmc0_uhs_pins: mmc0-uhs-pins {
>   		clk-pins {
>   			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
> -			drive-strength = <MTK_DRIVE_10mA>;
>   			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +			drive-strength = <MTK_DRIVE_10mA>;

While at it, in a cleanup commit, if you could also remove those MTK_DRIVE_xxx and
use just the number that'd be great.

>   		};
>   
>   		cmd-dat-pins {
> @@ -351,21 +382,21 @@ cmd-dat-pins {
>   				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
>   				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
>   				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
> -			input-enable;
> -			drive-strength = <MTK_DRIVE_10mA>;
>   			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			drive-strength = <MTK_DRIVE_10mA>;
> +			input-enable;
>   		};
>   
>   		ds-pins {
>   			pinmux = <MT8365_PIN_104_MSDC0_DSL__FUNC_MSDC0_DSL>;
> -			drive-strength = <MTK_DRIVE_10mA>;
>   			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +			drive-strength = <MTK_DRIVE_10mA>;
>   		};
>   
>   		rst-pins {
>   			pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
> -			drive-strength = <MTK_DRIVE_10mA>;
>   			bias-pull-up;
> +			drive-strength = <MTK_DRIVE_10mA>;
>   		};
>   	};
>   
> @@ -386,16 +417,16 @@ cmd-dat-pins {
>   				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
>   				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
>   				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
> -			input-enable;
>   			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			input-enable;
>   		};
>   	};
>   
>   	mmc1_uhs_pins: mmc1-uhs-pins {
>   		clk-pins {
>   			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
> -			drive-strength = <8>;
>   			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +			drive-strength = <8>;
>   		};
>   
>   		cmd-dat-pins {
> @@ -404,9 +435,63 @@ cmd-dat-pins {
>   				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
>   				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
>   				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
> -			input-enable;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>   			drive-strength = <6>;
> +			input-enable;
> +		};
> +	};
> +
> +	mmc2_default_pins: mmc2-default-pins {
> +		clk-pins {
> +			pinmux = <MT8365_PIN_81_MSDC2_CLK__FUNC_MSDC2_CLK>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +			drive-strength = <4>;
> +		};
> +
> +		cmd-dat-pins {
> +			pinmux = <MT8365_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
> +				 <MT8365_PIN_83_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
> +				 <MT8365_PIN_84_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
> +				 <MT8365_PIN_85_MSDC2_DAT3__FUNC_MSDC2_DAT3>,
> +				 <MT8365_PIN_80_MSDC2_CMD__FUNC_MSDC2_CMD>;
>   			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			drive-strength = <4>;
> +			input-enable;
> +		};
> +
> +		sys-en-pins {
> +			pinmux = <MT8365_PIN_120_DMIC1_CLK__FUNC_GPIO120>;

My schematics say that the DMIC1_CLK pin is PERST_N, DMIC_DAT0 is PWR_EN: what's
the intention here?!

In any case, this is not a mmc2 pin, but something else :-)

Cheers,
Angelo


