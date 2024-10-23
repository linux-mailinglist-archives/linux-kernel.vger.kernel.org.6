Return-Path: <linux-kernel+bounces-377921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1FB9AC890
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C2A1F21930
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0C1AA78B;
	Wed, 23 Oct 2024 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aC+24G6j"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5F19E804;
	Wed, 23 Oct 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681632; cv=none; b=UWgCUCx0s7agl9ty2W3xu2Lh754zX0Zy7RlivMpAMz5/3KAMyZBFnmDPQvlXvLXl5whdu9UJrBZsTtLFMfNTMwlPqlqgAl8QPR/ni70Q3i3v3FEpYb8RfVHvokuUrK4FkjqV6yE5aIYPe1GRJnYrqb5VbSElko2Pn4826iIpHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681632; c=relaxed/simple;
	bh=jJv8pUshfT4apsQOdjQNUHnCdLbsPstTncS3AsjLstA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChBRP1C6nu3zbcPsHgwBOnpUMPeK17srTlqgGREsyLVjERZ4KUN+uqayBvCK8p4FeyZ1x8iK57xXE6pyS/93O3GzElXITXY0ObUkr8TUSXJP3BDxBHfz/VlTjkC4b7oM8slKAdGHMWT6rm8B5ci7TZZOMx8GvTqlTXhaxIJHfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aC+24G6j; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729681628;
	bh=jJv8pUshfT4apsQOdjQNUHnCdLbsPstTncS3AsjLstA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aC+24G6ja6hENxZJQEW2Cvmejdh47ef2CmrATu9x95xSygdVjmmvb15RkcJKtXGse
	 4xr7G/UEPiPb+7ycQckrd3P7NKRsze7KUWYZvWLmebtBl4I9teM7aK6ctzG8J5auR/
	 7a/sbVvyuqdlaXVSsx1C6cctkk3Ff+ixka1gfAF9PHZ4HaQCxQ2MqV/i2yTc8J608b
	 gPMt01CJ+XnQlBmc5u0Du2Ku+c7NnyePYj2WIyluXODjcrGWPIOkf+nsGxYnxhuTvA
	 RH4HO7u8qALsxeVuu+4jg90gZWv72fe2Yoj7VsJmDU/K7TDtxwDiDdAYS533ZZBa6T
	 CLTG6HFgwNgbA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE4ED17E1543;
	Wed, 23 Oct 2024 13:07:07 +0200 (CEST)
Message-ID: <0cc68449-a11d-466c-b89d-067b1c2fd7e0@collabora.com>
Date: Wed, 23 Oct 2024 13:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for MUX IT5205
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
 Fabien Parent <fparent@baylibre.com>, Simon Sun <simon.sun@yunjingtech.com>
References: <20241023080912.15349-1-macpaul.lin@mediatek.com>
 <20241023080912.15349-2-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241023080912.15349-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/10/24 10:09, Macpaul Lin ha scritto:
> Add ITE IT5205FN (TYPEC MUX) under I2C2 bus and configure its properties;
> also add references to it5205fn from MT6360 TYPE-C connector for TYPEC
> configuration.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   .../dts/mediatek/mt8395-genio-1200-evk.dts    | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> Changes for v2:
>   - This is a new patch in the v2 patch.
> 
> Changes for v3:
>   - No change.
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> index 83d520226302..4c11c100e7b6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> @@ -229,6 +229,21 @@ &i2c2 {
>   	pinctrl-0 = <&i2c2_pins>;
>   	pinctrl-names = "default";
>   	status = "okay";
> +
> +	it5205fn: typec-mux@48 {

You don't need the it5205fn phandle, please drop.

> +		compatible = "ite,it5205";
> +		reg = <0x48>;
> +		vcc-supply = <&mt6359_vibr_ldo_reg>;
> +		mode-switch;
> +		orientation-switch;

compatible
reg
mode-switch
orientation-switch
vcc-supply

Please reorder.

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +		status = "okay";
> +
> +		port {
> +			it5205_sbu_ep: endpoint {
> +				remote-endpoint = <&mt6360_ssusb_sbu_ep>;
> +			};
> +		};
> +	};
>   };
>   
>   &i2c6 {
> @@ -369,6 +384,13 @@ mt6360_ssusb_ep: endpoint {
>   							remote-endpoint = <&ssusb_ep>;
>   						};
>   					};
> +
> +					port@2 {
> +						reg = <2>;
> +						mt6360_ssusb_sbu_ep: endpoint {
> +							remote-endpoint = <&it5205_sbu_ep>;
> +						};
> +					};
>   				};
>   			};
>   		};



