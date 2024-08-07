Return-Path: <linux-kernel+bounces-278270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A40494AE23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B866B263BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70B13BACE;
	Wed,  7 Aug 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rNX7w5Ld"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799613B286;
	Wed,  7 Aug 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047989; cv=none; b=oyJ7FljAeVTixfS6EifSXfq/OwyG2GVEegrOlKmyxO71eeDi1Y3+d82xPoObFepeX3+HNx1LB5CwIX4djLSy4CiI4XqJuke2w4TNCubxA7Hh20TyD0rJEtAKNSyUzXQYAwQBNgg5P+vicgnAULgPHjzaUTrCmJ4zAPQTfY2yfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047989; c=relaxed/simple;
	bh=dc7k+wM+tIvKHomP6LszNjSqcE9JMYWNDT6NpNNX+yc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qz6MBQD+R2TVY8wgbcNxhyl3a/1Hmzn/LczEpfY/gCLs8gqpeGU4PgUfdL8RaWtS8A23kD3b+KFj1j/wyMdolhNioS2VZOkqN2y6ZbP3B/FXM1Gaf50wDCrOKVLLBdxXgAxUrX41ijdfkgNTBkrBE8pw7gLmnXvgV8RNu/HDv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rNX7w5Ld; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723047977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXOkuk2X7XhAdN4/iJulCbZX6oDA273A62lKA1iIz4U=;
	b=rNX7w5LdyQPZYZY2Ij9Nf5MxbaxBCKvwfGbKg/y6B8KW+6SdJ4C1CkCAv+zHELJqCuYoua
	2MkHA+K1lu4Pij0s1iJfqJu6EUm5LUmyDznjQ7bPIRwfTqWf+y8hYNRHazlJkeFZtKEZjV
	8VMfP82n1KpXrlvVm07RAOWeO7u/aROgXbi5miXRYpjtjw+Dn2fToK8bs9IuYtvdzYSW3K
	fsqx9sSN3MoCWYcIhvcwcH0nBVxGiuaSevOiEPq/12+xEsAYypHbY6RqIwD5gKtuokzdqa
	Dam1QSZ6yCGMjZEwX5YaToxAVHgdVZE4qQO0FG+UQlx4abPaII2nLuXxSdsS+g==
Date: Wed, 07 Aug 2024 18:26:15 +0200
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
Subject: Re: [PATCH] arm64: dts: rockchip: add rfkill node for M.2 E wifi on
 orangepi-5-plus
In-Reply-To: <20240807162001.1737829-1-flokli@flokli.de>
References: <20240807162001.1737829-1-flokli@flokli.de>
Message-ID: <b897efe95b80f631d0e0fba70d08d7db@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Florian,

On 2024-08-07 18:20, Florian Klink wrote:
> This follows the same logic as 82d40b141a4c7ab66, which did the same
> for rock-5b.

Please use the standard format for referencing commits, i.e. 
82d40b141a4c
("arm64: dts: rockchip: add rfkill node for M.2 Key E WiFi on rock-5b").

> The GPIO pin connecting the WiFi enable signal inside the M.2 Key E 
> slot
> is the same as there.
> 
> This can be validated in
> arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtsi from Armbian
> rk-5.10-rkr4 kernel, which contains a `wifi_disable` node with that 
> same
> GPIO pin.

This might be used as a reference, but please provide a permanent link
to the actual source code in the referenced downstream repository.

> Signed-off-by: Florian Klink <flokli@flokli.de>
> Tested-by: Florian Klink <flokli@flokli.de>
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

