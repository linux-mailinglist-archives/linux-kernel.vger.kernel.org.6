Return-Path: <linux-kernel+bounces-315571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F78C96C451
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF3A1F2249B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86971E0B95;
	Wed,  4 Sep 2024 16:44:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD18121F;
	Wed,  4 Sep 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468273; cv=none; b=tUYpDpatMq0Rp4vb0CJq26+JPC579N4K8BlQq3TjVZvOECSzCH3jVZdModZVaCvYvEIFmKgnxH38euese/oZ4s4NAOU9u5N6L5BPykxhLDvM2ngA8fcdTlyJbkj3LS6ognaDxA+8sTvoT+iOmjpMjFHegKjcoZMAd1JHlH/IuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468273; c=relaxed/simple;
	bh=SXx6jO5MZqycXHp1fEztwaku3HUAOD91ZqeErKMDBmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHVPSnZD3aFAAQQ6y9DIrsXdt0Cx7R3c3VjL1DXFPbYEbugmjUY0b7xXekcnqGEMZVU/32qW/pwbg3GLijunrL09B+PffDMhEGFa+g5OXFWwjv936SuU9vKvz0rgXJ/JX9JEQLyoxciF67HRny5+wf6RtI0lLGhsIxwunl4PC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D52A2FEC;
	Wed,  4 Sep 2024 09:44:56 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CADA03F73B;
	Wed,  4 Sep 2024 09:44:28 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:44:26 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Fix NanoPi NEO Plus2 regulators
Message-ID: <20240904174426.48bcb483@donnerap.manchester.arm.com>
In-Reply-To: <20240827-nanopi-neo-plus2-regfix-v2-1-497684ec82c7@gmail.com>
References: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
	<20240827-nanopi-neo-plus2-regfix-v2-1-497684ec82c7@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 23:00:43 +0200
Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> wrote:

Hi,

> Added the main board 5 V supply regulator,
> a 2.5 V supply regulator for GMAC PHY IO and correct vin-supply elements.

thanks for sending this and fixing the DT!

That looks correct when comparing to the schematics:

> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   | 25 ++++++++++++++++=
++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> index b69032c44557..dee4cd82636b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> @@ -45,16 +45,40 @@ reg_gmac_3v3: gmac-3v3 {
>  		startup-delay-us =3D <100000>;
>  		enable-active-high;
>  		gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>;
> +		vin-supply =3D <&reg_vcc3v3>;
> +	};
> +
> +	reg_gmac_2v5: gmac-2v5 {
> +		/* 2V5 supply for GMAC PHY IO */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "gmac-2v5";
> +		regulator-min-microvolt =3D <2500000>;
> +		regulator-max-microvolt =3D <2500000>;
> +		regulator-always-on;
> +		vin-supply =3D <&reg_vcc3v3>;
> +	};
> +
> +	reg_vcc5v: regulator-vcc5v {
> +		/* board 5V supply from micro USB or pin headers */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc-5v";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
>  	};
> =20
>  	reg_vcc3v3: vcc3v3 {
> +		/* board 3V3 supply by SY8089A */
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "vcc3v3";
>  		regulator-min-microvolt =3D <3300000>;
>  		regulator-max-microvolt =3D <3300000>;
> +		regulator-always-on;
> +		vin-supply =3D <&reg_vcc5v>;
>  	};
> =20
>  	vdd_cpux: gpio-regulator {
> +		/* cpu voltage regulator MP2143DJ */
>  		compatible =3D "regulator-gpio";
>  		regulator-name =3D "vdd-cpux";
>  		regulator-type =3D "voltage";
> @@ -66,6 +90,7 @@ vdd_cpux: gpio-regulator {
>  		gpios =3D <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
>  		gpios-states =3D <0x1>;
>  		states =3D <1100000 0>, <1300000 1>;
> +		vin-supply =3D <&reg_vcc5v>;
>  	};
> =20
>  	wifi_pwrseq: pwrseq {
>=20


