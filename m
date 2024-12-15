Return-Path: <linux-kernel+bounces-446316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC79F228C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 09:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C340164EB1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8BB49627;
	Sun, 15 Dec 2024 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="usvhsaru"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2418E1A;
	Sun, 15 Dec 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734249627; cv=none; b=ftXOoZMV2uiw31Kbx1v8PDPh+F68uYdu9OXC/nVZvVL9L5+MZxs9mCZ4BQiYAmwnp1DG1RkPAdAleklD1qhRUkySdnRXgKzP6Ry82oP0h8FTzSi3f9+Age1r49+2o0pIAzcLbRT/PPHXbQYIb31oxqMVMTJ+61/IBvZ8ZPdIxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734249627; c=relaxed/simple;
	bh=djYC58sVz93yHsKs88HbFV3AZuwifi4tTdhTqtfjjP8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=biOseMDK9KyC3prChd4XYbZABgKgBoukHY1z+MazbQ1diWW60fa4qi5A/fZ14Ays4Tp55XrB7h/V6pe+EY6+XHCs1eDm9n6TqjiNhgL/3b4KSXE2beRNoM3aqSz66HFD7rw65bBAn0A9Q1Z7OuZDaQk7WPFzV2xXcplxkbg/Fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=usvhsaru; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1734249623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0R8EIh7YecGagzC0jU7hcfHeDbHCAnsmyLpcoGh/spE=;
	b=usvhsaruCnQOl5a6bXeyrJjTSK6+nYbPULuzwwZlQlaISsImaAw/6i/Q3INNxxLQPYO5c6
	aOe+jNjeWmfR+AVEX7I1V3kRQi7Henw72ms3HlLy0l8dvOaMpSNlyRZtW+36jPyxHQRVdo
	oIo1C/lJa1ldyX5C/JMlRhRHkwh/U+IonlHMoDUUyryjgFxOz5L6b04vqJI0Nmu+UdoLz0
	iyhGYz4HyQ5kTWZ/f1s1lHz4qR6hP6i/GpJ+BQz/bZ077ZB625is1CEv5fefaBpnCUHAif
	rh7eQApz3Y74iw09XQi8nWqSXo+8xmIzJO0XDtzTb9veeOjH8YLHzSFYdDn7ow==
Date: Sun, 15 Dec 2024 09:00:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, Roman Beranek
 <me@crly.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: allwinner: a64: explicitly assign clock
 parent for TCON0
In-Reply-To: <20241215053639.738890-3-anarsoul@gmail.com>
References: <20241215053639.738890-1-anarsoul@gmail.com>
 <20241215053639.738890-3-anarsoul@gmail.com>
Message-ID: <bab2e7c53385da06a44b449077c7241a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Vasily,

On 2024-12-15 06:34, Vasily Khoruzhick wrote:
> TCON0 seems to need a different clock parent depending on output type.
> For RGB it has to be PLL-VIDEO0-2X, while for DSI it has to be PLL-MIPI
> 
> Video output doesn't work if incorrect clock is assigned.
> 
> On my Pinebook I manually configured PLL-VIDEO0-2X and PLL-MIPI to the 
> same
> rate, and while video output works fine with PLL-VIDEO0-2X, it doesn't
> work at all (as in no picture) with PLL-MIPI.
> 
> Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in 
> TCON0 mux")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Thanks for fixing this issue!  I've been banging my head for a while
about how to fix it without introducing new DT properties, and I hope
that the maintainers will like your approach.

I'd suggest that the patch description is improved further a bit, by
incorporating some parts of the good description of the issue that's
already in the cover letter.  With that addressed, please feel free
to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts  | 2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 379c2c8466f5..86d44349e095 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -390,6 +390,8 @@ &sound {
>  &tcon0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&lcd_rgb666_pins>;
> +	assigned-clocks = <&ccu CLK_TCON0>;
> +	assigned-clock-parents = <&ccu CLK_PLL_VIDEO0_2X>;
> 
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> index b407e1dd08a7..ec055510af8b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -369,6 +369,8 @@ &sound {
>  &tcon0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&lcd_rgb666_pins>;
> +	assigned-clocks = <&ccu CLK_TCON0>;
> +	assigned-clock-parents = <&ccu CLK_PLL_VIDEO0_2X>;
> 
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index a5c3920e0f04..0fecf0abb204 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -445,6 +445,8 @@ tcon0: lcd-controller@1c0c000 {
>  			clock-names = "ahb", "tcon-ch0";
>  			clock-output-names = "tcon-data-clock";
>  			#clock-cells = <0>;
> +			assigned-clocks = <&ccu CLK_TCON0>;
> +			assigned-clock-parents = <&ccu CLK_PLL_MIPI>;
>  			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
>  			reset-names = "lcd", "lvds";

