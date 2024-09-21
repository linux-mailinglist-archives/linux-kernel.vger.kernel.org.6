Return-Path: <linux-kernel+bounces-334974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11C97DF1F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D481C20A31
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A2153BE8;
	Sat, 21 Sep 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bXZon0CE"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6618C0C;
	Sat, 21 Sep 2024 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726954969; cv=none; b=QtT/F0yUvq7dScEJnJRhWjEpa2cfzJyNr/h4FDpJhU+6AKi0WqWzfNJ75y+SZEqx9r+CZdGZjoxLy94C6mdFCcJ8lh5CdJMb/x1bjgl6UNfNAxzQtLq1HHsM23mMD5+8z0OzvYtAF9wW7s66wbqYDeRf3wOjnOajzADMS/1euAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726954969; c=relaxed/simple;
	bh=3453U1dwI9YwljGOwhoJjEpBMw95sjMLum9O2euVRKk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AM11ssxWijDRqhYgxIOBeMB6a0DYFZv7ZVdi3ftsUKACVy5gPt1YZPBWvSoG9cTEqKUd5ba9qud9X8eCxGb9CVEhGYs1/l5uDsVnhZ1/4pmVW1vboG+pHYBENFW15D00QDL+lXGK3KvMHU0AALoU9lsUuqaDZT+i8iD5+4yzv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bXZon0CE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1726954964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+uMN5w6qYS2BUoqj10TXa1/0/97pCNoqt/rmAX2GPAo=;
	b=bXZon0CEaBK6v6rzxU5YRfCFhLhOOwREJFeHmkWn7lduwYxSWtn2lAFcrOmfCS3bciGYbk
	pMd/4I3Lg8oP50TVKstEVU6tGTLBsQ1BXAa/PPCDYmbdE1HcYM5stO3A8OOUT/IpTV/rl/
	clHx+rU1bt++AGbwb+x8LlHIFv+4/eouASANroc9R7gjhYfWyeB28axdPItPbb4Rk4QKti
	9HG8G1/zvxLl7OESAeDw1IpLhnqUm3n500p1iauva2FmVvp92mDuuSACR/GoFXJ6p0jvXe
	1VgK1qWwW8zUeWeyToAGgM5OqTAS9JKYY4xNjH2KnWeWtt1SJSvu3Y8s846HjQ==
Date: Sat, 21 Sep 2024 23:42:43 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Florian Klink <flokli@flokli.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Kever Yang
 <kever.yang@rock-chips.com>, =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?=
 <tszucs@protonmail.ch>, FUKAUMI Naoki <naoki@radxa.com>, Muhammed Efe Cetin
 <efectn@protonmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable automatic fan control on
 Orange Pi 5+
In-Reply-To: <20240921183810.225322-1-flokli@flokli.de>
References: <20240921183810.225322-1-flokli@flokli.de>
Message-ID: <d90eae7de77a77f023d995c4cc5d6c42@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Florian,

Thanks for the patch.  Please, see a comment below.

On 2024-09-21 20:38, Florian Klink wrote:
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
> index e74871491ef5..8569e862b6ee 100644
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
> +		map1 {
> +			trip = <&package_fan0>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> +		};
> +
> +		map2 {
> +			trip = <&package_fan1>;
> +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> +		};

These two cooling maps should be named map0 and map1 instead, i.e.
their numbering shoud start from zero, because there are no package
cooling maps in the parent dtsi file(s).

Having them named map1 and map2 in rk3588-rock-5b.dts was a small
mistake that slipped by somehow, and I've already submitted a small
patch [1] that fixes that mistake.

[1] 
https://lore.kernel.org/linux-rockchip/335ecd5841ab55f333e17bb391d0e1264fac257b.1726954592.git.dsimic@manjaro.org/T/#u

> +	};
> +};
> +
>  /* phy1 - M.KEY socket */
>  &pcie2x1l0 {
>  	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;

