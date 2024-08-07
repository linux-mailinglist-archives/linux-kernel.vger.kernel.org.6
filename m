Return-Path: <linux-kernel+bounces-278323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8EA94AEBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A198BB25020
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8318084DF1;
	Wed,  7 Aug 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NIgkrNN4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3D13C66F;
	Wed,  7 Aug 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050908; cv=none; b=rTzSOnglYbnqeVB4B+ImZINIbyFo2/r7uxUSli2w88Q7lIK57iJIijvG6EqD9V5bZIkEFf6Q4q+WZS4EcagnEm2EZbfYMso2iuYkAnRqjiviU9fKTsOVlWQpCg5pF0gJ0/r9MqfJI4kEsRkuLyPFpsv02ULv+ByW2AfLPO1XrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050908; c=relaxed/simple;
	bh=evzsRSnoI8B+Q7K+wb+LQqpvXZVFZMep+7vOWo6xsVE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Zk5f1uwzG+hfBPCEv8BRhu8us5emSeVYVQsTqn8g+vVTLJI5u4tB2J2cPw+dak698aBkegHu3G/G7IzynAWBKkimHOgIlzcunlG0OOYtaB9xV3pvT8a6Dj9v2VdixqxS3yoSfd9W+D1+oIVNHrkSqCm4OL+kL62xnCz0V5CsDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NIgkrNN4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723050904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XcVj2Oh+3ROUG9TB7T4vDLi0jPcIksfZHJmSThpdHM=;
	b=NIgkrNN48AxkAKnu9xZaO6uIC4wgeCmmdsCBiQen6ESjgJByDZU3wHHgpwsPY2LhURoTyu
	BPUFrrGTXQ3m6MXFC8G07a5L8Y+NnGho8zdpQFJRZiV/L9KMH9OQ9unSBGPGqIIcqorbvN
	NaYppQJjOayyIbJmdGb6gXSvL03eNHoE9bCRZRuIwzV0zjx2R0Yfc0coW+reO4Bqm1rLj8
	Qo3JWHR3T4Icpb82yDC/lkx4/zCFoLfj33KH4dujc983Fr9CWAj0Lo1sHKMphpcU2Ldq+r
	HgAYFtfFc9S5BLNJZofBxw1pmjRVtiZxGmaa2Opl5r0BJrYJ9YuGMiGly0EWSQ==
Date: Wed, 07 Aug 2024 19:15:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Florian Klink <flokli@flokli.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Kever Yang
 <kever.yang@rock-chips.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?=
 <tszucs@protonmail.ch>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi
 on orangepi-5-plus
In-Reply-To: <20240807170030.1747381-1-flokli@flokli.de>
References: <20240807162001.1737829-1-flokli@flokli.de>
 <20240807170030.1747381-1-flokli@flokli.de>
Message-ID: <c1cd51655f783d9ec2f6f068590c2a35@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-07 19:00, Florian Klink wrote:
> This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip: add
> rfkill node for M.2 Key E WiFi on rock-5b").
> 
> On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
> enable signal inside the M.2 Key E slot.
> 
> The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4 kernel
> rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
> node referencing RK_PC4 on &gpio0.
> 
> Signed-off-by: Florian Klink <flokli@flokli.de>
> Tested-by: Florian Klink <flokli@flokli.de>
> Link:
> https://github.com/armbian/linux-rockchip/blob/9fbe23c9da24f236c6009f42d3f02c1ffb84c169/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> [1]

Unfortunately, this isn't how the "Link: ..." tag is to be used, or how
a reference is to be provided.  Please see the patch submission linked
below for a correct example of providing links as references.

https://lore.kernel.org/linux-rockchip/4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org/T/#u

> ---
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index e74871491ef5..c3a6812cc93a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -105,6 +105,13 @@ led {
>  		};
>  	};
> 
> +	rfkill {
> +		compatible = "rfkill-gpio";
> +		label = "rfkill-pcie-wlan";
> +		radio-type = "wlan";
> +		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
> +	};
> +
>  	sound {
>  		compatible = "simple-audio-card";
>  		pinctrl-names = "default";

