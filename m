Return-Path: <linux-kernel+bounces-354784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45AA99428C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F54D292E24
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673417C213;
	Tue,  8 Oct 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WNeXvQd0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E683526E;
	Tue,  8 Oct 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375606; cv=none; b=psLlaYLMcMpjHwJJkpYkQ93GxkYZ547rzMj5tWPOlRJYyxCmCF+sByWuPBgJ00S4ckP2dfnhtdREdW/gflWXsYIEcfqed626xN0VdXBj7ZgAYREzZ3LqriHGKVsAeFa4AnrEDyHOkTQYfpDm7iQySiu0j3hGDPP0abZFCb6oBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375606; c=relaxed/simple;
	bh=AXDgMvzZ0dhqYbcpZaAvhYubI+mG2BUoce+x40w8cA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmOHGa6rrpqXP7DS5GGU+NdvyTVmwM7zidxWjFvhK43eInNJMz80Pz+y82PpYhzjBYCpe4QOPzBS68GKo4CbMiVdgORRI3pkKt8zbxzemyCReNiW6vjPOTzXCSYKtTjcg7seS4Zmn9MwFTgeyTxg33LcgjwHaEDLJaDto+HrbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WNeXvQd0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728375602;
	bh=AXDgMvzZ0dhqYbcpZaAvhYubI+mG2BUoce+x40w8cA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WNeXvQd0/GHwGY+dCvr43z3TkLSoNn64dcMCuwjn7EaL2jPo+yemEZvC+C3hO/MnR
	 /TBWYbP8FqwPxOxh64K4YgtUQREAy/hmTa4XUYBCyd8gU8fOtiS9AazLCCtbMImLcQ
	 CMSXduRu6/5tMjh3ZV2PR4XroZH4UKsXb2pjW6UHYgBF9orY4ceu385ikEQZElnQWM
	 6xm48BYT3nkBGKnzk76s8G/1/Ud/i44eMFBtQlB7pEMTQPPIOPND3gz3c/JVtAMSi3
	 v3404XTNSAjf+GQc8N+Fk3HNgZ5t8sc5T/ff4ekmvf8EmVB362xiR4ZQ2S6xRyKwp6
	 5FUKJyRmKsOTQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F377A17E10A4;
	Tue,  8 Oct 2024 10:20:01 +0200 (CEST)
Message-ID: <8cdce399-1f42-4558-9cdb-c36b96205212@collabora.com>
Date: Tue, 8 Oct 2024 10:20:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: add
 keys and USB HUB
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241007090244.1731-1-macpaul.lin@mediatek.com>
 <20241007090244.1731-2-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241007090244.1731-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/10/24 11:02, Macpaul Lin ha scritto:
> 1. Add i2c, mmc to aliases.
> 4. Add PMIC_KEY setting.
> 5. Add USB HUB TUSB8020 to xhci1.
> 6. Re-order spi2 node.

Please either add the aliases in a different commit, or add that to the title.

arm64: dts: mediatek: mt8390-genio-700-evk: Add aliases, keys and USB HUB

Additionally, I'd really like to see a "conversation-like" description instead
of a kind-of-checkbox list.

Something like..

"
Add aliases for the I2C and MMC/SD controllers to keep the numbering consistent and
describe the TUSB8020 hub present on the USB XHCI1 controller instance to enable
resetting it with its specific reset GPIO.

While at it, also move the spi2 node to keep nodes alphabetically ordered.
"

> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   .../dts/mediatek/mt8390-genio-700-evk.dts     | 57 +++++++++++++++----
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> Changes for v2:
>   - Fix order of spi2.
>   - Update pinctrl in i2c4 and rt1715.
>   - Drop IT5205 and RT1715 nodes since the DTS are not completed yet.
>   - Add #address-cells and #size-cells to xhci1 for supporting USB hubs.
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> index 96b272567cb1..3e77f59f2c74 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> @@ -23,6 +23,15 @@ / {
>   		     "mediatek,mt8188";
>   
>   	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
>   		serial0 = &uart0;
>   	};
>   
> @@ -249,7 +258,6 @@ &i2c3 {
>   &i2c4 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c4_pins>;
> -	pinctrl-1 = <&rt1715_int_pins>;

What is this extra change?
Please describe it in the commit description.

>   	clock-frequency = <1000000>;
>   	status = "okay";
>   };
> @@ -867,6 +875,17 @@ pins-wifi-enable {
>   &pmic {
>   	interrupt-parent = <&pio>;
>   	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
> +
> +	mt6359keys: keys {

Is there any reason why we can't just put this node in mt6359.dtsi?

Cheers,
Angelo

> +		compatible = "mediatek,mt6359-keys";
> +		mediatek,long-press-mode = <1>;
> +		power-off-time-sec = <0>;
> +
> +		power-key {
> +			linux,keycodes = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +	};
>   };
>   
>   &scp {
> @@ -874,6 +893,15 @@ &scp {
>   	status = "okay";
>   };
>   
> +&spi2 {
> +	pinctrl-0 = <&spi2_pins>;
> +	pinctrl-names = "default";
> +	mediatek,pad-select = <0>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
>   &uart0 {
>   	pinctrl-0 = <&uart0_pins>;
>   	pinctrl-names = "default";
> @@ -892,15 +920,6 @@ &uart2 {
>   	status = "okay";
>   };
>   
> -&spi2 {
> -	pinctrl-0 = <&spi2_pins>;
> -	pinctrl-names = "default";
> -	mediatek,pad-select = <0>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -};
> -
>   &u3phy0 {
>   	status = "okay";
>   };
> @@ -921,6 +940,24 @@ &xhci0 {
>   &xhci1 {
>   	status = "okay";
>   	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	hub_2_0: hub@1 {
> +		compatible = "usb451,8025";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
> +		vdd-supply = <&usb_hub_fixed_3v3>;
> +	};
> +
> +	hub_3_0: hub@2 {
> +		compatible = "usb451,8027";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
> +		vdd-supply = <&usb_hub_fixed_3v3>;
> +	};
>   };
>   
>   &xhci2 {


