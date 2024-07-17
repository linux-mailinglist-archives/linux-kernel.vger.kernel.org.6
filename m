Return-Path: <linux-kernel+bounces-255054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCB8933B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3F4B225BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168AC17E8FE;
	Wed, 17 Jul 2024 10:18:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17114A61B;
	Wed, 17 Jul 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211508; cv=none; b=HS47QLg86CBaUe1VtPUdYi6ApdxAXWIrqPjOOud0Rkwh14X5eY1N+UsOJOBzt8/aV0uQA3PPHfSTXmfW7fg/nL6csYvotpqKiSIl6JMR9V5n0sGkjFQCDyKNsCccww/dD4+DKuWxywGFk7BKo/EnNKDJS3DSU3o6TnszU7RRpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211508; c=relaxed/simple;
	bh=UXQ+/dLLvHe5K0edkzLL8yMcOsAqy8P4gh1aXFyY9PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBABHUQmIJYBRrAS7RLVilhUSTc/iQltR63JtKgz894d7BJD2yUZAQPzhJuHTgOLMbqDEjTrXxpUpS1U/z9vJEgoZ++vYkpZkmJ2Oyz6Qhj0WryHOrx4mPAMm72p8dUEC1CNPJYWG9AdhnmZrSxTZhc1HICEyd7GOVed/YKj7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sU1je-0006py-5K; Wed, 17 Jul 2024 12:18:10 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
 Otavio Salvador <otavio@ossystems.com.br>
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 imx@lists.linux.dev, loongarch@lists.linux.dev
Subject:
 Re: [PATCH v1 2/4] ARM: dts: rockchip: remove unlikly-to-exist DAC from
 elgin-r1
Date: Wed, 17 Jul 2024 12:18:08 +0200
Message-ID: <3870188.FjKLVJYuhi@diego>
In-Reply-To: <20240717-parrot-malt-83cc04bf6b36@spud>
References:
 <20240717-anvil-ashy-544e80a1317c@spud>
 <20240717-parrot-malt-83cc04bf6b36@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

adding Otavio,

Am Mittwoch, 17. Juli 2024, 11:37:54 CEST schrieb Conor Dooley:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Rohm dh2228fv (really the bh2228fv, the compatible in the kernel has
> a typo) does not support frequencies above 10 MHz, nor per the
> datasheet appear to use either CPOL or CPHA. I suspect that this
> devicetree is abusing the compatible in order to bind the spidev driver
> in Linux. Pretending to have devices on a board for this purpose is not
> acceptable, so remove it.

Reasoning is sound, so I'll pick this up after the merge window.


> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I could not find any documentation for this board online, and it does
> not blatantly say that the device is a "spidev" like other [ab]users, so
> it is possible there's actually a DAC here - but I doubt it is a
> bh2228fv given the other incompatibilities.

Otavio, as the original submitter of the Elgin R1 [0], do you happen
to know what type of device this is? Especially as there really do not
seem to be any schematics around for that board.


Heiko



[0] https://patchwork.kernel.org/project/linux-rockchip/patch/20190104014023.17973-4-otavio@ossystems.com.br/

> ---
>  arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> index 2d9994379eb2..9df1cef406c5 100644
> --- a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> +++ b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> @@ -167,14 +167,6 @@ &spi {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
>  	status = "okay";
> -
> -	dh2228fv: dac@0 {
> -		compatible = "rohm,dh2228fv";
> -		reg = <0>;
> -		spi-max-frequency = <24000000>;
> -		spi-cpha;
> -		spi-cpol;
> -	};
>  };
>  
>  &u2phy {
> 





