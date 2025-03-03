Return-Path: <linux-kernel+bounces-541588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E96A4BEF0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BC73BD122
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7FE1FC7C3;
	Mon,  3 Mar 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HQcsNYUp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE11FBCB2;
	Mon,  3 Mar 2025 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001554; cv=none; b=EMdcAQZSLkL0ifsjTTUPqTk50jc2cU9JNd6WqiGA56sNcDKvyNKFrA8KjAXHLmfIk/V1betUigKC7hBnuQCVIuRpFa+92flKwW18h9mkS8M/sT89q+iR/oKBNJ5wObvnV/YFp6KtJahVIUxlmoDm9rVP4f4eEWOKkMeTWvP/lgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001554; c=relaxed/simple;
	bh=A1dmoEW25l3ZJd4LiRioYAuKRWE98O7QHIl4r9uDJ1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZaea8H6ojDMeeIaqWOUS431JLNRpZgZZ/XT7seI3BF2hvxRoqOXhNURrW8qjj+JUXIaqGr1UyAggq1OpDxE1CGBVzckMXqvb79ESvN6Yzh+15bIEoVBHgaWB32lbmAeDYWonAFKUZZ/scIKWMdwWozGjXRHyFsBCsIqCw7AbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HQcsNYUp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741001550;
	bh=A1dmoEW25l3ZJd4LiRioYAuKRWE98O7QHIl4r9uDJ1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HQcsNYUppNKgXqrJbXZmI8caBOH/CvXKfBkBRkoeSGjs3hCmBwwrCvJKHmTjD8Ltz
	 cOJOAdlO08oMAZxFvd5g1dgTWiHu6zIymywJ9i5Dmf9GReBYMoWgtNpcI+o/tBXrnM
	 6hbmgr7i+hI56tix5dsElSTaS3ZOdB1J9OTcDq135T58BnMRDRdKlSovz0j6nDDTsG
	 yeXh3roUTLRdlSR/eH5D77oUDhUTY4nIHfkm4wpYRL7fZtnAUMqC7vBDorRYyV3Q8L
	 wOC7oLSKjVsltBEryM9ukfhnsjAQo+Nex8rnbp7u1xiKTw6pLBJvx3DkT5O45tJfKH
	 wH4N+4ARMvJMA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D566D17E0607;
	Mon,  3 Mar 2025 12:32:29 +0100 (CET)
Message-ID: <fc0a9471-da47-4f4f-a471-1b20f344ad22@collabora.com>
Date: Mon, 3 Mar 2025 12:32:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI
 DSI port
To: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250226-radxa-panel-overlay-v1-0-9e8938dfbead@collabora.com>
 <20250226-radxa-panel-overlay-v1-1-9e8938dfbead@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250226-radxa-panel-overlay-v1-1-9e8938dfbead@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/25 15:35, Julien Massot ha scritto:
> This board can use a MIPI-DSI panel on the DSI0 connector: in
> preparation for adding an overlay for the Radxa Display 8HD,
> add a pipeline connecting VDOSYS0 components to DSI0.
> 
> Also add the backlight, and some pin definitions available
> through the DSI0 port.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
>   .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts     | 60 ++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> index 7184dc99296c7f5d749c7e6d378722677970b3b7..65c77e43d1cd4913b6741e25130febd746ff753c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> @@ -48,6 +48,17 @@ memory@40000000 {
>   		reg = <0 0x40000000 0x1 0x0>;
>   	};
>   
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <0 1023>;
> +		default-brightness-level = <576>;
> +		enable-gpios = <&pio 107 GPIO_ACTIVE_HIGH>;
> +		num-interpolated-steps = <1023>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&dsi0_backlight_pins>;
> +		pwms = <&disp_pwm0 0 500000>;

This should be disabled, unless there is a display connected to the DSI connector.

If there's no display, there's no point in enabling any backlight, as that pin
may be reused somehow (with hardware hacks, maybe, yes, but still configuring
the PWM IP and the pin as PWM while unused is at least a waste of energy).

> +	};
> +
>   	wifi_vreg: regulator-wifi-3v3-en {
>   		compatible = "regulator-fixed";
>   		regulator-name = "wifi_3v3_en";
> @@ -499,9 +510,20 @@ &mt6359_vsram_others_ldo_reg {
>   	regulator-max-microvolt = <750000>;
>   };
>   
> +&ovl0_in {
> +	remote-endpoint = <&vdosys0_ep_main>;
> +};
> +

This goes to the overlay that enables the DSI display.

> @@ -912,6 +960,18 @@ &ssusb2 {
>   	status = "okay";
>   };
>   
> +&vdosys0 {
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vdosys0_ep_main: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&ovl0_in>;
> +		};
> +	};
> +};

If you enable this path, in the event that the DSI display overlay is not added,
the mediatek-drm driver will fail probing: even if a second path is enabled and
that will succeed regardless of the first one failing, I don't see a reason why
whoever doesn't have a DSI display attached should see a miserable failure in the
kernel log :-)

Besides, mediatek-drm failing will also slow down boot for no reason.... etc etc.

Please move the display path setup to the DSI display overlay.

Thanks,
Angelo

> +
>   &xhci0 {
>   	vbus-supply = <&otg_vbus_regulator>;
>   	status = "okay";
> 


