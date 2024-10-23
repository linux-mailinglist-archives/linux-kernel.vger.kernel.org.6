Return-Path: <linux-kernel+bounces-377922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E99AC894
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5002830A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67031AAE08;
	Wed, 23 Oct 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d/ifaD7m"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD301531F9;
	Wed, 23 Oct 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681633; cv=none; b=ZoS+01LyuD4o7411ICSpRI/44QUiIjvSJQZjfx82cqPxfXjBIhEca2gWhNI1aT/TFvaY6KDqRqkcJWCo8sXpsNCLstcmivt8xxpXgsaHSjys8R4hPJPl+IvzD4hA3KMXEx0QKXVJSD/cmXpqoEk+bcLADKH9lmUPY4zxWjHXUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681633; c=relaxed/simple;
	bh=8e9uBwaZxAnoAdX6FU+kL2IHiXRh0zZ7Wcs7TopuVBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws4SgWvCza9DHn6nP9ldhbpDU3hkzAoCrPWJV0i2RCJ11KihrsCkthKJhLp7WDJMXRQbLYODi1fqCceZtijJItIGTXvFJVzb8Dm6ZQZtUmkC3rxydhW4b0MthPYxUHGaNzJSI+L9WYEJKmftb/yQ+6RG7TkZGjEaip//6fjlb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d/ifaD7m; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729681629;
	bh=8e9uBwaZxAnoAdX6FU+kL2IHiXRh0zZ7Wcs7TopuVBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d/ifaD7mUx7X3IC0sUiN+TzLsGOnIissTUtkkov9oiM6M80qbQb8Wdw8uNu3VN3ya
	 KSaLoOPBAbdkn80Dl1v7+TffChDjMZx6lY5eaxKp901LQSgDikS1pYR3sy1fJXFQWH
	 Kdw4xCBaTDj0BQQpc3VKsfi/taKkGbi6NACPAR2qSFP5Bdpgv+0D1YK8jNUl8p+Dj0
	 GgT9RVuEeQv0eTz3bfIICC1eAJTL9qOKKVgvcdpcZ7/6Q2jm38yinigR0f2/mVj41E
	 +Lh3v5zBBfy3oq9/wLBTQ0OlmfWeY+NEHlWI+HQe/RUP77qCjKPkVTicwrWG78AOL1
	 5G2OsIYIKQNcQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B624217E1576;
	Wed, 23 Oct 2024 13:07:08 +0200 (CEST)
Message-ID: <c4b5e78e-5337-464c-9dca-9d4e5353cc46@collabora.com>
Date: Wed, 23 Oct 2024 13:07:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-usb@vger.kernel.org, Chris-qj chen <chris-qj.chen@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>,
 Yow-Shin Liou <yow-shin.liou@mediatek.com>,
 Simon Sun <simon.sun@yunjingtech.com>
References: <20241023080912.15349-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241023080912.15349-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/10/24 10:09, Macpaul Lin ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
> configuration for TCPC Port, USB-C connector, and related settings.
> 
> Configure dual role switch capability, set up PD (Power Delivery) profiles,
> and establish endpoints for SSUSB (SuperSpeed USB).
> 
> Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
> to "otg" for OTG (On-The-Go) mode operation.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Yow-Shin Liou <yow-shin.liou@mediatek.com>
> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   .../dts/mediatek/mt8395-genio-1200-evk.dts    | 54 +++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> Changes for v2:
>   - Drop the no need '1/2' DT Schema update patch in the 1st version.
>   - Fix intent for 'ports' node, it should under the 'connector' node.
>   - Correct the index for 'port@0' and 'port@1' node.
> 
> Changes for v3:
>   - Correct the order between new added nodes.
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> index 5f16fb820580..83d520226302 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> @@ -335,6 +335,43 @@ mt6360_ldo7: ldo7 {
>   				regulator-always-on;
>   			};
>   		};
> +
> +		tcpc {
> +			compatible = "mediatek,mt6360-tcpc";
> +			interrupts-extended = <&pio 17 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names = "PD_IRQB";
> +
> +			connector {
> +				compatible = "usb-c-connector";
> +				label = "USB-C";
> +				data-role = "dual";

op-sink-microwatt goes here

> +				power-role = "dual";
> +				try-power-role = "sink";
> +				source-pdos = <PDO_FIXED(5000, 1000, \
> +					       PDO_FIXED_DUAL_ROLE | \
> +					       PDO_FIXED_DATA_SWAP)>;

Please fix the indentation (and also you don't need the escaping)

				source-pdos = <PDO_FIXED(5000, 1000,
							 PDO_FIXED_DUAL_ROLE |
							 PDO_FIXED_DATA_SWAP)>;

> +				sink-pdos = <PDO_FIXED(5000, 2000, \
> +					     PDO_FIXED_DUAL_ROLE | \
> +					     PDO_FIXED_DATA_SWAP)>;
> +				op-sink-microwatt = <10000000>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;

Just to make sure that this is ok: are you sure that this port supports
SuperSpeed (physical connector too) and that it's not limited to HighSpeed?

I have seen Rob's comment stating that ssusb_ep goes to port@1, but I think
that his comment came after reading "ss" in "ssusb": while the controller
does surely support SS, if the port does not, this should still go to port@0.

P.S.: I didn't check the schematics - just please make sure it's correct, and
       that this actually works.

> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mt6360_ssusb_ep: endpoint {
> +							remote-endpoint = <&ssusb_ep>;
> +						};
> +					};
> +				};
> +			};
> +		};
>   	};
>   };
>   
> @@ -770,6 +807,13 @@ pins-reset {
>   		};
>   	};
>   
> +	u3_p0_vbus: u3-p0-vbus-default-pins {
> +		pins-cmd-dat {

That's not a command nor data pin.

pins-vbus {

> +			pinmux = <PINMUX_GPIO63__FUNC_VBUSVALID>;
> +			input-enable;
> +		};
> +	};
> +
>   	uart0_pins: uart0-pins {
>   		pins {
>   			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
> @@ -900,8 +944,18 @@ &ufsphy {
>   };
>   
>   &ssusb0 {
> +	dr_mode = "otg";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&u3_p0_vbus>;

Is this port usb host by default? If it is:

	role-switch-default-mode = "host";

Cheers,
Angelo

> +	usb-role-switch;
>   	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	status = "okay";
> +
> +	port {
> +		ssusb_ep: endpoint {
> +			remote-endpoint = <&mt6360_ssusb_ep>;
> +		};
> +	};
>   };
>   
>   &ssusb2 {


