Return-Path: <linux-kernel+bounces-258283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF159385B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FC31C2123C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DBF16A938;
	Sun, 21 Jul 2024 17:45:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24701DFE4
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583903; cv=none; b=EVPLkQSxpwZIXrBHKmcvk5VlWmYoGkAPIx6Z7gd0Kcyinmx09PgldvrXt+p7YMI20jM4Oo+dlU756E5otUMJ61YfyxHeHSsOLQ/UwMyxGk3Wzg6Qyx3rQKX6dWxkvPPDvwthMGCQckMWzv8WBKBbzgzfMrkvaRonKs8onW+Pylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583903; c=relaxed/simple;
	bh=aY4oeBvcNS2AEVFMFrQ0Owr/22nvwQkoyxo0aAtecoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pf39XsetS2YpKGODAe9xtI52/U4cOS0YEhEuDA0/jgE7cD7FLczkthvyynWBkMjqDfcLfiwbN67Ltt+Oo4t3iP4zAAuFnoKpNHAq8Ah0zCBkyKBW91QNBp+6r86WLxqYTD3NXE6dWUUPpZig60E2bToskIC8RemEe2Kz8xHREhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVacF-0007HK-FD; Sun, 21 Jul 2024 19:44:59 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: ukleinek@debian.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 11/14] arm64: dts: rockchip: define cpu-supply on the
 Qnap-TS433
Date: Sun, 21 Jul 2024 19:44:58 +0200
Message-ID: <3358212.0oRPG1VZx4@diego>
In-Reply-To: <20240721173723.919961-12-heiko@sntech.de>
References:
 <20240721173723.919961-1-heiko@sntech.de>
 <20240721173723.919961-12-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Sonntag, 21. Juli 2024, 19:37:20 CEST schrieb Heiko Stuebner:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> index c593a9c2313a3..a576d45ccc3e0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> @@ -129,6 +129,16 @@ vcc5v0_otg: regulator-vcc5v0-otg {
>  		vin-supply = <&vcc5v0_usb>;
>  	};
>  
> +	vcc5v0_sys: vcc5v0-sys {

should be
	vcc5v0_sys: regulator-vcc5v0-sys {


> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +




