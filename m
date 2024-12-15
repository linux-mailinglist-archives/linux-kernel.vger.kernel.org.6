Return-Path: <linux-kernel+bounces-446315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B679F2286
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 08:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E3418866E1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB047F53;
	Sun, 15 Dec 2024 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="X6AZtEw3"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B83D96A;
	Sun, 15 Dec 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734249341; cv=none; b=B0UA3SMQhHUNY8FC85jqxNWVSUKOPizF8UmfjYsQY8/5xJuWe6qPnXH5rE76obP3IqRw0c0iJguhuHOB8BrkIq82lB6g5L8qwbXKArFaCaYfUvKfFEcAtuxT6dGGMFd8h4eBnlSl7fbwmh1q5P2F3e5Kvn5vqOogAWxojdosGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734249341; c=relaxed/simple;
	bh=+Lc1c+7W7amo74yObj3Gd5VmrD41PluEpZ3Nf3nThco=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tJS4ztmh0a5mH3+fsvNt5GgFBeeE+dRWLIQF1ipav5rPaM6jTh5vFok/SVHK6n0nqQ5qeAIe7HKQNwc4lsFcAihpqQdUS6yK9JlY8tTZro26DPeRTvJc8q+SRxyGiBwWTQtidJ/wEf5Jkrld20tzA8TzPwdJbTDjCFoC47JAovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=X6AZtEw3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1734249330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRkqo2vCIPvvfZ0H7gNeIfyEHMp6dUwFO/jiGLyMtk4=;
	b=X6AZtEw3uOUVXCqCpY7rs27S3+N+fxh8zEMtymDE8HRrcBhG53znRlgQ585GWGJSIa7Xoi
	Svayph6Hw6SkLBQVcMg47Rq5NvI3HJL10ZTyFGT3DimEuOoxkp8Mksnr2dPu2PBEhRbJRy
	b+66vVyLT0MQ6coKyGc9eYMPezf89OryOrg4uTTvo+qlG22EBzqFe67sN8XssHuIW/avr2
	xsBn2maD46Z3WxXmaAxE7osGkEk+pYUr0okIBsNKRN2BUR4RwUs0eQf+FNfdy9slpWWmMS
	x1F5J6JfeOq+Yol/5ruSe+3i13ICfcr96Rc6NHWnVqGBB7b8OlLpEDtSTalKMg==
Date: Sun, 15 Dec 2024 08:55:27 +0100
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
Subject: Re: [PATCH 1/3] dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and
 PLL_MIPI
In-Reply-To: <20241215053639.738890-2-anarsoul@gmail.com>
References: <20241215053639.738890-1-anarsoul@gmail.com>
 <20241215053639.738890-2-anarsoul@gmail.com>
Message-ID: <1f400eec0f0583335ad8b40fcbf1b5d4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Vasily,

On 2024-12-15 06:34, Vasily Khoruzhick wrote:
> These will be used to explicitly select TCON0 clock parent in dts
> 
> Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in 
> TCON0 mux")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Looking good to me, as a preparatory patch.  Please feel free
to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
>  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
> b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
> index a8c11c0b4e06..dfba88a5ad0f 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
> @@ -21,7 +21,6 @@
> 
>  /* PLL_VIDEO0 exported for HDMI PHY */
> 
> -#define CLK_PLL_VIDEO0_2X		8
>  #define CLK_PLL_VE			9
>  #define CLK_PLL_DDR0			10
> 
> @@ -32,7 +31,6 @@
>  #define CLK_PLL_PERIPH1_2X		14
>  #define CLK_PLL_VIDEO1			15
>  #define CLK_PLL_GPU			16
> -#define CLK_PLL_MIPI			17
>  #define CLK_PLL_HSIC			18
>  #define CLK_PLL_DE			19
>  #define CLK_PLL_DDR1			20
> diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h
> b/include/dt-bindings/clock/sun50i-a64-ccu.h
> index 175892189e9d..4f220ea7a23c 100644
> --- a/include/dt-bindings/clock/sun50i-a64-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
> @@ -44,7 +44,9 @@
>  #define _DT_BINDINGS_CLK_SUN50I_A64_H_
> 
>  #define CLK_PLL_VIDEO0		7
> +#define CLK_PLL_VIDEO0_2X	8
>  #define CLK_PLL_PERIPH0		11
> +#define CLK_PLL_MIPI		17
> 
>  #define CLK_CPUX		21
>  #define CLK_BUS_MIPI_DSI	28

