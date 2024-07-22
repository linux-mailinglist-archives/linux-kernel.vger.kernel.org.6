Return-Path: <linux-kernel+bounces-259120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 364ED939186
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE0FB2157D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADB916DEBB;
	Mon, 22 Jul 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S9FWagLh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E021428F1;
	Mon, 22 Jul 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661252; cv=none; b=uK6Zp6j8itUwSKRmMUM39uB0gaOb8GwClYd6EgNLcSoDhqEBGYCYO4pqcO0NedM4gnWksNAB3RP0t1rrrsjNpfheftrP8MbY6e3mSuGFitSHrGHVV7LlBDp+NsoOctuX17pzFuG66l2zxMGGPW/+y9F5DSceoKmWp9ag11K9JCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661252; c=relaxed/simple;
	bh=nBplABP7eOfFn5jv0FYWlCypm74Gue3s6LT4wXx/6ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5yKAWm26iOXcUB7tBHugH23dgP1gTIlRHCiQtKdj2k1jkryVbdOxFIopPh5QSmwqASV3jy5/svF+iePwgPwrun2PgYR2/af0C67hmswH/pgO1d5ZeuOOZID+rU71jiY9MucN6IsMpdsJPfSXY8Tn2cj/5Dlo3VfCy68snqiwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S9FWagLh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721661248;
	bh=nBplABP7eOfFn5jv0FYWlCypm74Gue3s6LT4wXx/6ik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S9FWagLhiDAxT9N8sm2LrgsV3ZNAMV0yT/44qgAfDzT1a4BARQNDFAApfWjRvpB+R
	 1SQbNAAMKYRdA2Vi9ItSS9sHZnjZqgpi+UWQEP+vxYakdG8YxS18ohqDmxIlSSWz/R
	 jniWJsw54o5bYB/v8zOvfB3+g8SGDHevjKO1TrEwk3LsAjO3o5GE9wvMdPuf1Je5Vg
	 +JtJ3LNl5w1mVOcJFTcvfVe0J1VOLx8LlBndZgsEYdY/K4ul4N1IO2mT+vrrBTVraI
	 DJm1Y0AdbExB9nxU3DJy/w4sZNEg8rdZdUqqiwex04PS2PO2jcOxAZIpcLlUJGhGkD
	 +Qi1voRcO52Fg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D5B09378001E;
	Mon, 22 Jul 2024 15:14:07 +0000 (UTC)
Message-ID: <89f6381b-8572-4d58-a8a9-0a3596efc627@collabora.com>
Date: Mon, 22 Jul 2024 17:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: mediatek: mt7988: add labels for different
 nodes
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240709081614.19993-1-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240709081614.19993-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/07/24 10:16, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Current devicetree-nodes missing a label which allows to add aproperties
> or phandles to them, so add them.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Fixes: 660c230bf302 ("arm64: dts: mediatek: mt7988: add I2C controllers")
> Fixes: 09ff2216a035 ("arm64: dts: mediatek: mt7988: add PWM controller")
> Fixes: 09346afaba0a ("arm64: dts: mediatek: mt7988: add XHCI controllers")
> Fixes: b616b403cbff ("arm64: dts: mediatek: mt7988: add clock controllers")
> Fixes: 6c1d134a103f ("arm64: dts: mediatek: Add initial MT7988A and BPI-R4")

You're just only adding node labels, what does this actually fix?!?

Besides, I could tell you to remove the Fixes tags, but then, there's still nothing
using those node labels - so there's nothing justifying this addition, at all.

I guess that you want to use those (bar the cpu[0-3] labels, which you're adding
because... uhh.. why?) from some board DT... so please just do that: send a commit
adding your board DT and adding the required node label(s) here as a consequence.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 32 +++++++++++------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index aa728331e876..9ced005b1595 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -14,28 +14,28 @@ cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> -		cpu@0 {
> +		cpu0: cpu@0 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x0>;
>   			device_type = "cpu";
>   			enable-method = "psci";
>   		};
>   
> -		cpu@1 {
> +		cpu1: cpu@1 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x1>;
>   			device_type = "cpu";
>   			enable-method = "psci";
>   		};
>   
> -		cpu@2 {
> +		cpu2: cpu@2 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x2>;
>   			device_type = "cpu";
>   			enable-method = "psci";
>   		};
>   
> -		cpu@3 {
> +		cpu3: cpu@3 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x3>;
>   			device_type = "cpu";
> @@ -43,7 +43,7 @@ cpu@3 {
>   		};
>   	};
>   
> -	oscillator-40m {
> +	system_clk: oscillator-40m {
>   		compatible = "fixed-clock";
>   		clock-frequency = <40000000>;
>   		#clock-cells = <0>;
> @@ -86,7 +86,7 @@ infracfg: clock-controller@10001000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		clock-controller@1001b000 {
> +		topckgen: clock-controller@1001b000 {
>   			compatible = "mediatek,mt7988-topckgen", "syscon";
>   			reg = <0 0x1001b000 0 0x1000>;
>   			#clock-cells = <1>;
> @@ -99,13 +99,13 @@ watchdog: watchdog@1001c000 {
>   			#reset-cells = <1>;
>   		};
>   
> -		clock-controller@1001e000 {
> +		apmixedsys: clock-controller@1001e000 {
>   			compatible = "mediatek,mt7988-apmixedsys";
>   			reg = <0 0x1001e000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> -		pwm@10048000 {
> +		pwm: pwm@10048000 {
>   			compatible = "mediatek,mt7988-pwm";
>   			reg = <0 0x10048000 0 0x1000>;
>   			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
> @@ -124,7 +124,7 @@ pwm@10048000 {
>   			status = "disabled";
>   		};
>   
> -		i2c@11003000 {
> +		i2c0: i2c@11003000 {
>   			compatible = "mediatek,mt7981-i2c";
>   			reg = <0 0x11003000 0 0x1000>,
>   			      <0 0x10217080 0 0x80>;
> @@ -137,7 +137,7 @@ i2c@11003000 {
>   			status = "disabled";
>   		};
>   
> -		i2c@11004000 {
> +		i2c1: i2c@11004000 {
>   			compatible = "mediatek,mt7981-i2c";
>   			reg = <0 0x11004000 0 0x1000>,
>   			      <0 0x10217100 0 0x80>;
> @@ -150,7 +150,7 @@ i2c@11004000 {
>   			status = "disabled";
>   		};
>   
> -		i2c@11005000 {
> +		i2c2: i2c@11005000 {
>   			compatible = "mediatek,mt7981-i2c";
>   			reg = <0 0x11005000 0 0x1000>,
>   			      <0 0x10217180 0 0x80>;
> @@ -163,7 +163,7 @@ i2c@11005000 {
>   			status = "disabled";
>   		};
>   
> -		usb@11190000 {
> +		ssusb0: usb@11190000 {
>   			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
>   			reg = <0 0x11190000 0 0x2e00>,
>   			      <0 0x11193e00 0 0x0100>;
> @@ -177,7 +177,7 @@ usb@11190000 {
>   			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
>   		};
>   
> -		usb@11200000 {
> +		ssusb1: usb@11200000 {
>   			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
>   			reg = <0 0x11200000 0 0x2e00>,
>   			      <0 0x11203e00 0 0x0100>;
> @@ -191,21 +191,21 @@ usb@11200000 {
>   			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
>   		};
>   
> -		clock-controller@11f40000 {
> +		xfi_pll: clock-controller@11f40000 {
>   			compatible = "mediatek,mt7988-xfi-pll";
>   			reg = <0 0x11f40000 0 0x1000>;
>   			resets = <&watchdog 16>;
>   			#clock-cells = <1>;
>   		};
>   
> -		clock-controller@15000000 {
> +		ethsys: clock-controller@15000000 {
>   			compatible = "mediatek,mt7988-ethsys", "syscon";
>   			reg = <0 0x15000000 0 0x1000>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
>   		};
>   
> -		clock-controller@15031000 {
> +		ethwarp: clock-controller@15031000 {
>   			compatible = "mediatek,mt7988-ethwarp";
>   			reg = <0 0x15031000 0 0x1000>;
>   			#clock-cells = <1>;



