Return-Path: <linux-kernel+bounces-258284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A829385BA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3A61F21129
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7B167DB7;
	Sun, 21 Jul 2024 17:46:02 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97B4400
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583962; cv=none; b=iaxY048g2t8YQ8nAdiRqlaH0tqP/UXvwOhSaxXE8XH6oeynJJK/WzaZAtzr+hNAeIgt9NBsOyVPRxpWeCcAETOIyzP3QzOZuSdNvlT6zl6CiXnXv3oMJnR81VMOhVo9u7q2IqXmjjiMrHmbX93MZRhm/My32lRfkZLtlJNjTZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583962; c=relaxed/simple;
	bh=nJwhegpakRxE222rNDMnzfv6ri3SoKP3xsQWgGFy+uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQpE1D8OpdrvD+11lfyRLOsgrVbTjvJgmDBhTUrtiNAoOADORlAc2W4yRtUZbfYmBLV8uT9ZMEADHbkA8oAOAbJjJD8GybW6RLBxqCPfHvxLE0MgigDWIhnMS4RjHimJWyCr+xnyHj+bjAOsZfDEUJH/6JlVmn7n5ExNUS4VRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVadB-0007IK-S6; Sun, 21 Jul 2024 19:45:57 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: ukleinek@debian.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 12/14] arm64: dts: rockchip: add missing pmic information on
 Qnap-TS433
Date: Sun, 21 Jul 2024 19:45:57 +0200
Message-ID: <1843564.b8e9qBsS6s@diego>
In-Reply-To: <20240721173723.919961-13-heiko@sntech.de>
References:
 <20240721173723.919961-1-heiko@sntech.de>
 <20240721173723.919961-13-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Sonntag, 21. Juli 2024, 19:37:21 CEST schrieb Heiko Stuebner:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> index a576d45ccc3e0..779e1b8a35ca5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> @@ -101,6 +101,16 @@ vcc3v3_pcie: regulator-vcc3v3-pcie {
>  		vin-supply = <&dc_12v>;
>  	};
>  
> +	vcc3v3_sys: vcc3v3-sys {

should be
	vcc3v3_sys: regulator-vcc3v3-sys {


> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +




