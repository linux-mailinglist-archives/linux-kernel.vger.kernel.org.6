Return-Path: <linux-kernel+bounces-198723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D78D7C93
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930C91C220BE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E325026B;
	Mon,  3 Jun 2024 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kxpcVfit"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0343ADC;
	Mon,  3 Jun 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400268; cv=none; b=fr4t8s+m742g9n0TPff07u1r08ppKEfxh5zh+KwsgCARFni7/Cv5eAfdW196GCFPinjsXPvwKsvLL2mciCm8tZsyTtFCYeXz7E1LlfnA5hbP+8mWyRdDLygTV9GSHcZjUwCMpZAWQFupWyT0fZv/dZS4SV52CI+FcDj4KmNnHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400268; c=relaxed/simple;
	bh=BxNa9VcY68uplMSTvGDz9b9R4IIn+l6Leko6FTfPklU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2DFSr2F35xDjkku5hESoFdINToYENmtWFbRtcwgHMiTzS8vrFGmeQ1umeJvoaTTGuGaHLlQLxguxjm+3WdMF+9z2A5BeysNmlF694ww+0RmENFsd0GKjqErU1Ykh31IPs1epUnH/nASAUqXbu+wTSpZdNZNCAw9Nl0ZEnfZrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kxpcVfit; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717400262;
	bh=BxNa9VcY68uplMSTvGDz9b9R4IIn+l6Leko6FTfPklU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kxpcVfitJ/cywzDLGrF2aMskkW8Eqkc7AzU7Kp10V2xnlm8PXU7whCJ27t4GUul4w
	 zkMQWzjUT0DQsXnIXae52C6Tipvq/+IpVwt84n/duByObcXEu8vQt+pemvneiGO05j
	 Hl5L525G5IWb8hItWqWhen7dRptPmc1ocXToCthTTvlm/4Beg+aPx0pKfDr8j0DWQv
	 JfnkMEWOMDSxelZNqR8U2qSxCiJYOaNFyY3kWfVCSu7ZcHatMJJrFuJhL//xiDPOts
	 C86p9RwVLtgK/XdxG6s2pBrFIWBcd/tPW2QC3eOa8zImjUFdu1E67MycOE+2Hr5gfE
	 li/fItRCsU89w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5021337813CA;
	Mon,  3 Jun 2024 07:37:41 +0000 (UTC)
Message-ID: <c9c54de1-cac3-45ff-8bc4-996c14a1ecb8@collabora.com>
Date: Mon, 3 Jun 2024 09:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt7981: add I2C controller
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240405125505.11837-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240405125505.11837-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/04/24 14:55, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7981 has one on-SoC I2C controller that differs from recent Mediatek
> blocks by having a different SLAVE_ADDR register offset (thus a custom
> binding compatible string).
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index 8a6263cc569c..2d7f91196e64 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> @@ -94,6 +94,23 @@ pwm@10048000 {
>   			#pwm-cells = <2>;
>   		};
>   
> +		i2c@11007000 {
> +			compatible = "mediatek,mt7981-i2c";
> +			reg = <0 0x11007000 0 0x1000>,
> +			      <0 0x10217080 0 0x80>;
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_INFRA_I2C0_CK>,
> +				 <&infracfg CLK_INFRA_AP_DMA_CK>,
> +				 <&infracfg CLK_INFRA_I2C_MCK_CK>,
> +				 <&infracfg CLK_INFRA_I2C_PCK_CK>;
> +			clock-names = "main", "dma", "arb", "pmic";
> +			clock-div = <1>;
> +			clock-frequency = <100000>;

If you need to specify clock-div and clock-frequency, those are board-specific
properties and not soc wide.

Please remove those from there and put them in your board specific DT.

Cheers,
Angelo


