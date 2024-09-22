Return-Path: <linux-kernel+bounces-335131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56897E173
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCA21F2131D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DC19309C;
	Sun, 22 Sep 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JQ+pSI5c"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB878C7B;
	Sun, 22 Sep 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727006747; cv=none; b=oGqffJyQ+3XY16uZX1BGw9uA2EujZzgQX8cGRcFE1wCJerxLgHy6tY0JRBcRpV115NiWmBmSZ3Z4Bz0D5hg79bxNWtaNmqiDGkqS+i9aXz0xbqBxO9WCJ5kX0PSYS+iv7TYAashoqg2P5KiFX4us68D+P4Z2j7mgK/wsw6af3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727006747; c=relaxed/simple;
	bh=CZciqyawGbMv0eDvk5Gg6mOPKjS0zavCvoCZ+etSaQI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=u+OKjKoZ3ZpkUj2i8qdFklRyMnhmptI8NGPeno6IsO9ehcKQLDImWBPZo0zSU6QmLaBlnAz+aNl1li8CC6PBgDGE9L8yJ3hBF0E9gPl7XygFR75x/cWM1oMROL3WCd555EgON4VdZJVxk5W0LH/gLiS27YV6fr6RyknVGo45MZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JQ+pSI5c; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727006734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vftmAoVGKOfWv9wJW7In1MzRai88OEJVEYZ604itMTc=;
	b=JQ+pSI5cJpwl7CtYu0gIqZvBu618MV/ToALbH6bApRGXWN3ylgs0BasAlVvGqELSKO+CJn
	UyAmGd/c8VuN88zwmyw82OmCURGQWQKA7DTfZbCJKkK6SUwUlm7qDtkKoSYh/YtKyVH/Jc
	NeCQDAigxG+4ZEoTP3O2piwYgvO63B3PS5EFFoPpsoa3Ih47ZagI6Z+9rKdNpio9SsS7dY
	hl0EwPbcUL1neg2aV9cOZ2b6U5JfJz/Xtlg9Yqb1mqpSq1IpdtbiZlc1JGclD7Eo8ruSb2
	ozycleN6mgy7TrIIHHZ2awmVNH+jb0QC7X+xO6UeUD/v+UMsHBr8j1hhzszxtA==
Date: Sun, 22 Sep 2024 14:05:33 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Florian Klink <flokli@flokli.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, =?UTF-8?Q?Tam?=
 =?UTF-8?Q?=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>, Ondrej Jirman
 <megi@xff.cz>, Muhammed Efe Cetin <efectn@protonmail.com>, FUKAUMI Naoki
 <naoki@radxa.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable automatic fan control on
 Orange Pi 5+
In-Reply-To: <20240922112113.251431-1-flokli@flokli.de>
References: <20240922112113.251431-1-flokli@flokli.de>
Message-ID: <2441efb1ebbfe1f54507a1cc73c52436@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Florian,

Please, see a comment below.

On 2024-09-22 13:21, Florian Klink wrote:
> This links the PWM fan on Orange Pi 5+ as an active cooling device
> managed automatically by the thermal subsystem, with a target SoC
> temperature of 65C and a minimum-spin interval from 55C to 65C to
> ensure airflow when the system gets warm.
> 
> This is pretty much the same as '4a152231b050 ("arm64: dts: rockchip:
> enable automatic fan control on Rock 5B")', except for the Orange Pi
> 5+ board.
> 
> Signed-off-by: Florian Klink <flokli@flokli.de>
> ---
>  .../dts/rockchip/rk3588-orangepi-5-plus.dts   | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index e74871491ef5..d91438752006 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -351,6 +351,36 @@ &i2s2m0_sdi
>  	status = "okay";
>  };
> 
> +&package_thermal {
> +	polling-delay = <1000>;
> +
> +	trips {
> +		package_fan0: package-fan0 {
> +			temperature = <55000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +
> +		package_fan1: package-fan1 {
> +			temperature = <65000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map0 {
> +			trip = <&package_fan0>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> +		};
> +
> +		map1 {
> +			trip = <&package_fan1>;
> +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> +		};

Thanks for renumbering these cooling maps.  It's just that you
missed to label this patch as the v2, i.e. you should have used
"[PATCH v2]" in the patch subject.

Please, resend this patch with the v2 label, and please provide
a change log in the patch notes, i.e. below the "---" line.

Here's an example of an earlier v2 patch submission [1] that you
may find helpful.

In the v2 submission, please feel free to also include my

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

[1] 
https://lore.kernel.org/linux-rockchip/bdb60f1f793166cd65f58ab7aea025347076019c.1719679068.git.dsimic@manjaro.org/T/#u

> +	};
> +};
> +
>  /* phy1 - M.KEY socket */
>  &pcie2x1l0 {
>  	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;

