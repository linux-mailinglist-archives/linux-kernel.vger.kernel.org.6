Return-Path: <linux-kernel+bounces-278333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6A94AED5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADAD282390
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5013DB8D;
	Wed,  7 Aug 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tXv2DMGv"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CC13CFA6;
	Wed,  7 Aug 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051474; cv=none; b=KxjtyADXyeMC/TSWHZWHbeu787RKu9nSpKKn9kE05B9GWLyT5dGUiE30tCNhDISEPoWaiJZy5Ys8RbwhyRHc1vVZWfWhihBhCTS4W3CdgOChnkjrUgHAF/bb2OHA53SVZc9eN6Jfk2EPvwl43ZjZwDKQqR+Qs7iUyc+0WitJuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051474; c=relaxed/simple;
	bh=uCmJDU0oWY7dl58Vt+6+S46sNchFjOQMetRwXaSnxOI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=c6F42tQmPF+YtJLDvZYt/YPnJ249+Gfflef/7hJ+d2xVjV5sJ2cmwbV5lZ6RcpV1ZIBqlfqdqLOC5WMVsLQ5wBwDnBhY6/umBlGqHvK3zkUhXBXSvoKOio1JFY433MNGzGT6bkLq9+ptZqMBnvnmpQUmMt6Icpo3iJwS20vDxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tXv2DMGv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723051467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7AsICvb8jzWyYjh82OBEPCykHI3UCx9QM0GMfljvRI=;
	b=tXv2DMGvES825b2rtkMZ/s/4HtH9DrdIz2cxxB4Rf4XzSO/sBpWrk3F6b9Sw2Fi4hsV416
	MX2J6xtIdvz/reBdnGechtP/vib/HzzW8fXNdECHJHzrspsvr+mRwJ8pw73lhzxY+ZNN61
	nJ4p/sH9CHdXbF0C9mE9K4tVgO/VYBR9EvKX+W6xumeAZrfAbrFyajJ6TE5l/FUMiX08Pd
	VdCSgO+ncyfRSiiUkm68YCrXi86iNxdhge6LtP3QxgdosA1lI6g+9RUTRgPFag+QzuewdZ
	t6YhqPibMeo2YaGHtd8q4DyIl9luqnjgt4AJdypEV21iaiTdZlBUQmhg5AIE2w==
Date: Wed, 07 Aug 2024 19:24:27 +0200
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
Message-ID: <a10e70e2d67b9d63f2296b36b4cb3719@manjaro.org>
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

I forgot to mention that providing a Tested-by tag is redundant when
there's already a Signed-off-by tag, because the latter already implies
the former.

> Link:
> https://github.com/armbian/linux-rockchip/blob/9fbe23c9da24f236c6009f42d3f02c1ffb84c169/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> [1]
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

