Return-Path: <linux-kernel+bounces-427798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0D99E0A04
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FEAB310BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57B205ADA;
	Mon,  2 Dec 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wzZJ5ig4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B60205AB8;
	Mon,  2 Dec 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151348; cv=none; b=p30BsRJuLRb7exxvNEE3y8dSAgEaE/O64pqgwZ9b/Eg89UD8jRnjY9sKhRTrccjAMiXmG7JiAA/LnrK5kONyhkQCuR1RRqkTcSr+Ys4/wYJ7E4vD2ayuujKaKAbn9T87uNlQXQuDQgBrLfxeMI/myxOYvg1ed89IbyVwmZjDybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151348; c=relaxed/simple;
	bh=v+Wfi/VFVB56v7rGv4wRgnfv9hhwXrZ8c6SdZNvK4So=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EDx912TMb7BsAalRdICxbw0Hl+uXTs+xa5bmY6s2e9+J+nL665I6oBrYSvM6aJa6ik49fdtLYwLBG4uyX+DM+WJ3XgW1ZEQVd21W/nUxGJLvdNPlkl/EUNCkbJDXBz8/pgORPe3A3VqNyuyCAitZt6abtu14rHbNea+5MeW0ezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wzZJ5ig4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733151344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CIAZBFucCTn7nA63nHKJ4UCE5j3QR50Z+lHS5TV934=;
	b=wzZJ5ig4Q//Dign/WpW4UDKBQfoP5dbbGWp1Ll88JFutMca5oJnpx0xFRVYN1k7YNwXu0f
	V6wl2ZbJ6pWWCMX9ndXNr+WqDuAb/HQvC4Bvl/P9lpN4y2b5UntJ6o2bFOyGPOLpW6Ity0
	vSbjLjup8huZtj25VcjgZjenhpGcB48u4a/oiU/HKGw/s1W4dGcTH6EAbYn53NeNOYWlxN
	7Y5PnOYAzPF+VgOW2C/TvmhNyAIqp+YGJXfO7C41IG48RoR3EXgkRzhoD/qC/l67qo9y1/
	2GmbdmPllkkJ42PvqqlE0d/a/CoOOT6CNAUL0qXiruPshX3gWPeV3ULCy58lYw==
Date: Mon, 02 Dec 2024 15:55:44 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, didi.debian@cknow.org,
 marcin.juszkiewicz@linaro.org, pbrobinson@gmail.com
Subject: Re: [PATCH] arm64: dts: rockchip: Describe why is HWRNG disabled in
 RK356x base dtsi
In-Reply-To: <6b272e2f8f916c04b05db50df621659a5a7f29ab.1733149874.git.dsimic@manjaro.org>
References: <6b272e2f8f916c04b05db50df621659a5a7f29ab.1733149874.git.dsimic@manjaro.org>
Message-ID: <2415bfe796ae9190a23d05d4c0d23d4d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-12-02 15:44, Dragan Simic wrote:
> Despite the presence of the hardware random number generator (HWRNG) in 
> the
> different Rockchip RK356x SoC variants, it remains disabled for the 
> RK3566
> SoC because testing showed [1] that it produces unacceptably low 
> quality of
> random data, for some yet unknown reason.  The HWRNG is enabled for the 
> RK3568
> SoC, on which the testing showed good quality of the generated random 
> data.
> 
> To avoid possible confusion in the future, [2] let's have this 
> described
> briefly in the RK356x base SoC dtsi.
> 
> [1] 
> https://lore.kernel.org/linux-rockchip/cover.1720969799.git.daniel@makrotopia.org/T/#u
> [2] 
> https://lore.kernel.org/linux-rockchip/20241201234613.52322-1-pbrobinson@gmail.com/T/#u
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Oh, I forgot to Cc Peter as well while sending this patch, so I did
that now.  Sorry for the noise.

> ---
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> index 62be06f3b863..ab8f42c0a843 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -1032,6 +1032,11 @@ sdhci: mmc@fe310000 {
>  		status = "disabled";
>  	};
> 
> +	/*
> +	 * Testing showed that the HWRNG found in RK3566 produces 
> unacceptably
> +	 * low quality of random data, so the HWRNG isn't enabled for all 
> RK356x
> +	 * SoC variants despite its presence.
> +	 */
>  	rng: rng@fe388000 {
>  		compatible = "rockchip,rk3568-rng";
>  		reg = <0x0 0xfe388000 0x0 0x4000>;

