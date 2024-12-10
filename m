Return-Path: <linux-kernel+bounces-439405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533269EAEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2BA166A68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7C223310;
	Tue, 10 Dec 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="AEgkMytK"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53F2080EA;
	Tue, 10 Dec 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828096; cv=none; b=SJlLp/rHtQC/6tsIbdj2d/ijqOOyPXlClU35imfqMkZCtlKX5BLiuPPjiJhnP0xUT1QhYfe2L4c569Htorz+ApHeN5wA3NKWB5QuzNtnM4+rfA5NGwXWBFbFMW5wn5bGsriwPha5GKuxUGk5vq3HXfNkHjPxga4/7aoVWZfuUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828096; c=relaxed/simple;
	bh=aeW6lS0j+MVSxXa9hD08YYwybeT5nWNZJKNckK7APLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qe5OxvE/uJtvK5k1QsSGxhRb28kfMGV0sCQ2mrDaDIQvx1Vo0KgNCFLpw6xBEbHDvHPIpHq1IqsUG/BoXkoasVdwuwNbAlMitGC5+AQ/U7SkE2p7S0hBGEJVdBMatkz55VJuu27LEkNJKYsqnZz1XRdkbgpeK/SDuMLZTGtV1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=AEgkMytK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I/ecQv4FKuCtZE1AnEV/ijXpIAnWHT6qeI4gnhaOi3s=; b=AEgkMytKAjtQ4a1u/MLo8pPK9r
	lU+a/eCQz7xpnrtDWYQyayPmWoYDo1jY7H1LXJWbT+J4TInvHdQpMhnXnBCV5UUegjvDHswnupRVb
	3qSvaVJsf7KZtNGiD/0RJ5oQbmC3hFcswx4DNN0KplCbrLNt9sNzvozb2frb6hbl1a5TRpCK9w4rY
	0tMfIFPQo9bPUoWbDNlVV9r/l+uLkIE+duuQzU4Vr7sfLPyCkgpcSF1vKpy89NceO/xSh+RNPihof
	iDdpism0coDEv0NrmMTaULx4L1dyPWqbFzSNFydHtLkRCU8nzx5RAeEqEJyUT17xVPYzLs1Ot8xrK
	i7w7euVA==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tKxt2-0004QH-Ie; Tue, 10 Dec 2024 11:54:40 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Peter Geis <pgwipeout@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Levin Du <djw@t-chip.com.cn>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH 5/6] arm64: dts: rockchip: correct rk3328-roc regulator map
Date: Tue, 10 Dec 2024 11:54:39 +0100
Message-ID: <14451790.lVVuGzaMjS@diego>
In-Reply-To: <20241210013010.81257-6-pgwipeout@gmail.com>
References:
 <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-6-pgwipeout@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. Dezember 2024, 02:30:09 CET schrieb Peter Geis:
> The rk3328-roc-cc input power is sourced from a micro-usb port, while
> the rk3328-roc-pc input power is sourced from a usb-c port. Both inputs
> are 5vdc only. Remove the 12v input from the device tree.

full stop. Please don't do "While we are at it" commits.

> While we are at it, add missing voltages and supply to vcc_phy, missing
> voltages to vcc_host1_5v, and standardize the order of regulator
> properties among the fixed regulators.

This second part wants to be its own commit :-) .

Thanks
Heiko

> Fixes: 2171f4fdac06 ("arm64: dts: rockchip: add roc-rk3328-cc board")
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 23 +++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> index f782c8220dd3..6984387ff8b3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> @@ -24,22 +24,23 @@ gmac_clkin: external-gmac-clock {
>  		#clock-cells = <0>;
>  	};
>  
> -	dc_12v: regulator-dc-12v {
> +	/* fed from passive usb input connector */
> +	dc_5v: regulator-dc-5v {
>  		compatible = "regulator-fixed";
> -		regulator-name = "dc_12v";
> +		regulator-name = "dc_5v";
>  		regulator-always-on;
>  		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
>  	};
>  
>  	vcc_sd: regulator-sdmmc {
>  		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sd";
>  		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sdmmc0m1_pin>;
>  		regulator-boot-on;
> -		regulator-name = "vcc_sd";
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		vin-supply = <&vcc_io>;
> @@ -50,22 +51,25 @@ vcc_sdio: regulator-sdmmcio {
>  		states = <1800000 0x1>, <3300000 0x0>;
>  		regulator-name = "vcc_sdio";
>  		regulator-type = "voltage";
> +		regulator-always-on;
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <3300000>;
> -		regulator-always-on;
>  		vin-supply = <&vcc_sys>;
>  	};
>  
>  	vcc_host1_5v: vcc_otg_5v: regulator-vcc-host1-5v {
>  		compatible = "regulator-fixed";
> +		regulator-name = "vcc_host1_5v";
>  		enable-active-high;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&usb20_host_drv>;
> -		regulator-name = "vcc_host1_5v";
>  		regulator-always-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
>  		vin-supply = <&vcc_sys>;
>  	};
>  
> +	/* sourced from usb input through 3A fuse */
>  	vcc_sys: regulator-vcc-sys {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc_sys";
> @@ -73,7 +77,7 @@ vcc_sys: regulator-vcc-sys {
>  		regulator-boot-on;
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc_12v>;
> +		vin-supply = <&dc_5v>;
>  	};
>  
>  	vcc_phy: regulator-vcc-phy {
> @@ -81,6 +85,9 @@ vcc_phy: regulator-vcc-phy {
>  		regulator-name = "vcc_phy";
>  		regulator-always-on;
>  		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_io>;
>  	};
>  
>  	leds {
> 





