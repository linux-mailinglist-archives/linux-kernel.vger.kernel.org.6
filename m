Return-Path: <linux-kernel+bounces-242500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE19288F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310F0B21B72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A614A614;
	Fri,  5 Jul 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dwGuPUm4"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF01E867;
	Fri,  5 Jul 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183752; cv=none; b=CNXgl1DSp8Qlt4+3lAGXDaUrRVe4I1dzx9AxTGkqO9wJvUUbhAOApgLc19AewDRVEx5TzU6pnqY+mfGP96J2o8r/VWhUES5CcVNBqByq+3CwvtaUdKJN7gezmZ6FUY+3+6JwCjwRpjInSjyuR71Sd+9GuPMZoEJERb4APlLVDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183752; c=relaxed/simple;
	bh=qybHMV6/hotv69ME/0bjhhgboDNAAZuCHCPr7AEuB7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZgMHuqQPy8qogUxEiFpTNh/U9V8Wdj7XZUngl5k0HUA6CZ3XSr/D2s7fJ/nP/e20Qt/sSovwzbS/MhMLxyXLtS4dxz+QIT9QklzB3oRWRBrNvkBtm/v6nwb7RWjHICb/UvG67YiA9qlJxMCoCMsxyzy1TItxI6uUhZ8WRwl4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dwGuPUm4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86273C0002;
	Fri,  5 Jul 2024 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720183748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ha/Wdd6MoL2X2Qj6dEPcgVpRVmzg3q+g+eWP9tYymEg=;
	b=dwGuPUm4JUUZk9LssPoSy49ZqLS4DGE3eYqKTsVt3PeYpLv3mhn6Uug+riu8MZYv19LTX+
	KR00n1Rzy+rMRCmU6K/u16QsyLcQ1oSaajJKncR11tugGEw3rvXWMdi5GLRbX0JwVcArxs
	8C3ta/AQjHQqQJZ9DE4ObsQwcgUQA9TRHUnal8ie0yAF85Xt8ChtCpVk25fwQyTFYZgBAU
	O09kW/iAmbF0h9ZRvexZO75PHEF0raKg0J3bf2Nl5qkScXG5jbT1kqydxC1lBlCGy9JSRp
	lD3H2yeKCLnj10+I5l1oaR+vqpI0sC8rnK1zNHPwuwqfCE8QENmnGOlnPoVGyg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: armada-3720: align GPIO keys node name
 with bindings
In-Reply-To: <20240701150340.560243-1-krzysztof.kozlowski@linaro.org>
References: <20240701150340.560243-1-krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 14:49:08 +0200
Message-ID: <87a5iwj96j.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Bindings expect the GPIO key node names to follow certain pattern, see
> dtbs_check warnings:
>
>   armada-3720-gl-mv1000.dtb: keys: 'reset' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)...
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> index 63fbc8352161..07c14bf04b83 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> @@ -41,7 +41,7 @@ vcc_sd_reg1: regulator {
>  	keys {
>  		compatible = "gpio-keys";
>  
> -		reset {
> +		button-reset {
>  			label = "reset";
>  			linux,code = <KEY_RESTART>;
>  			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
> -- 
> 2.43.0

