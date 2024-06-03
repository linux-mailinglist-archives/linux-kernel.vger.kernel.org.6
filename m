Return-Path: <linux-kernel+bounces-198722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00E8D7C91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171D81C21F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497A04AED1;
	Mon,  3 Jun 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vDafQGTR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19741481A7;
	Mon,  3 Jun 2024 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400266; cv=none; b=SAwHdeK4/+HjSPrRmfjBOC4R3aqA1ku+2sCqJNEvzR04mtO/thiZGCcPIzVRlGJgDniXt5PIo5ecPGrLjRrpw+GwgqvXDhT5oVdhBJTWm/9fP1A4VPkT3nD45ThLCgD+iGwr766xXK2Ql0/30oXThOGKj5AIN2VccEeinjr3z/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400266; c=relaxed/simple;
	bh=0ZTbWXDKccVB2JD3rAJmUufRXjsYP9Y1lA2ybBWy5hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/ebGKg7Lu5+9aHOWkpl8tEzJMHJ5FW0c3kp+SH7xkvbeDQXsT5O0jTP0dNyKSr0tMaKYPT7FhkbZghs6i6jS/neerzDB13WR1Hxv7LD55Zj5uhZ7gzAqaF+mZfxKjQs7AGtx9nuFgjqiKEnqq3K6DjBQDGH+SoUjETblG3lNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vDafQGTR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717400263;
	bh=0ZTbWXDKccVB2JD3rAJmUufRXjsYP9Y1lA2ybBWy5hc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vDafQGTRrQv6ATZesjM0KMXd1XK648fVSi8sOaUgtu3AKw0HQaMGnVwcu8tzZKtBO
	 POXBI7awfIrAYPMHcLYdyIn0e3ZS0wAz0opSTjp4tvOEqEUKKDDeh99jU74fZiUIBt
	 fnPQWf1NhfFaVuw150JKOcQ8aOKbbBJfh2ualS038jCzm2cL8R7rE6TXGps33Guo2Q
	 l/QRcL9vBGU1+XydKcWlQs6lmfoEH8veficATxuzt9XjZZpWPGYw8e/flMsyilZVKJ
	 qxrTLzdcnixqvibuhLwfokY4C7vGGrU2wx11tZdU0d+jp0A/N56eTWJZ4bJSmoyQF7
	 hvy0qcdSHMSxw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 025D937821DB;
	Mon,  3 Jun 2024 07:37:42 +0000 (UTC)
Message-ID: <703cfd0b-5d16-4888-bcc5-5742ee16fd29@collabora.com>
Date: Mon, 3 Jun 2024 09:37:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt7988: add I2C controllers
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240405125549.11972-1-zajec5@gmail.com>
 <20240405125549.11972-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240405125549.11972-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/04/24 14:55, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 has three on-SoC I2C controllers that are the same hardware
> blocks as already noticed on MT7981 chipsets.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 45 +++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index 27098f724b7a..b4dc81881cc7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -124,6 +124,51 @@ pwm@10048000 {
>   			status = "disabled";
>   		};
>   
> +		i2c@11003000 {
> +			compatible = "mediatek,mt7981-i2c";
> +			reg = <0 0x11003000 0 0x1000>,
> +			      <0 0x10217080 0 0x80>;
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
> +				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			clock-frequency = <100000>;

As commented on 7981, please remove clock-div/frequency from SoC wide DTs.

Cheers,
Angelo



