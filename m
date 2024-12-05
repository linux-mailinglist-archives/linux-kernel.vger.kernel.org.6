Return-Path: <linux-kernel+bounces-433229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2709E555F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289E6166B17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F9218597;
	Thu,  5 Dec 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CG/svNwH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E1218823;
	Thu,  5 Dec 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401603; cv=none; b=Oo/wpY8+jzmxcsfdeqFBKMGPDZ1HCih47l4FufXZSF1LNqunEmSTYJkcOTQGd0O/SB3lwq69zk0I9SONnpqMZdBKrIV17UaoMW6nNBrcIFP030Cp0Q5uLPXAwY/EBwMOZVL8qSIxJQt4iT/5rKexDNpurP+dCBbircNrb9rqQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401603; c=relaxed/simple;
	bh=9c8Iav8aUNsHauiM1yyCeZeaUEqfzZZUSJNr9VK+H8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNAq/ysbjaKGQotH8w2d5b97n25b0ZhdAfZnQDEZDTfpxpFWVTgKaRP/q3k1Lf3/w1F9Ol2ITd2tnjOLZuF36WM1YpUUbN47Ir5DTjyMYAFFBK6A352zp81hw+E/zSMEKPY5gJZ4qaeH+WprhIMjNifR7MrfT7cAAvkvV+f+tvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CG/svNwH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733401599;
	bh=9c8Iav8aUNsHauiM1yyCeZeaUEqfzZZUSJNr9VK+H8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CG/svNwH8wKMZSECj0iDL44zQ9ywjg3SwpciUSnm3FrLTCK2Dg2azBak8u47LGZqa
	 wY3wGDg6vH1dyYLkdJCH+dRUJmZmIFgubfgGoWsypJb1NsR0eCM1WIFb6Vf6+LZFpU
	 3iadb1F9akZu2fI2PMhe50qwOCrgErodAJ4JWeVRaU3nEgNWKznNAhAtFWq7FQqffl
	 U0lEGhW9kQpSGgmcln1dZ3kNDhNv2iBjXvHdDiA0dA+dMZFcTma4xB9w2pEQyviOXU
	 gR+r5b6Z0K/GYbz4myLvTOv6fZZj8WtH6qanJtCk02vJ87tdlQeHIKo3OSAxIG51w2
	 AOI0W0cRXWuvg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1521417E35D8;
	Thu,  5 Dec 2024 13:26:39 +0100 (CET)
Message-ID: <6792791b-035c-4b50-809a-c561bfe21c1d@collabora.com>
Date: Thu, 5 Dec 2024 13:26:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: mt8516: add keypad node
To: Val Packett <val@packett.cool>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241204190524.21862-1-val@packett.cool>
 <20241204190524.21862-6-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241204190524.21862-6-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/12/24 20:05, Val Packett ha scritto:
> Add a keypad matrix node for the MT8516/MT8167 SoC.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index e30623ebac0e..3beb9f74ec79 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -220,6 +220,16 @@ timer: timer@10008000 {
>   			clock-names = "clk13m", "bus";
>   		};
>   
> +		keypad: keypad@10002000 {
> +			compatible = "mediatek,mt6779-keypad";

Noupe, you have to add your SoC to the compatible list... both here and in the
binding for mediatek.mt6779-keypad.yaml

compatible = "mediatek,mt8516-keypad", "mediatek,mt6779-keypad"

for the binding, it's just a simple addition to an enum, nothing else.

Cheers,
Angelo

> +			reg = <0 0x10002000 0 0x1000>;
> +			wakeup-source;
> +			interrupts = <GIC_SPI 149 IRQ_TYPE_EDGE_FALLING>;
> +			clocks = <&clk26m>;
> +			clock-names = "kpd";
> +			status = "disabled";
> +		};
> +
>   		syscfg_pctl: syscfg-pctl@10005000 {
>   			compatible = "syscon";
>   			reg = <0 0x10005000 0 0x1000>;




