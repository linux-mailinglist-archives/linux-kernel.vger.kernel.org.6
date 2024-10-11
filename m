Return-Path: <linux-kernel+bounces-360721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D3999EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC042867D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27E20A5FA;
	Fri, 11 Oct 2024 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="i6lRSdIH"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113519DF6A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633631; cv=none; b=hkDO/VKIQPtv3qEFBgZrdg9o1jZNj4Uj3jkMf3SX5SG4SnF21Mwi4DNsMH7mOgxQXG2ownytprT6cpYm0camKm5Xl0GjxB759KlSAFIF4vINK79fsi1J4YW+IKu0OChkk6dsbzmbru/JxjZnRaqt4HdDxoIpVQMWYxLJy5X716o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633631; c=relaxed/simple;
	bh=2lV20s1fnFmNmxcSMXI0tq9f04FISvBJ6zNOT1wjozg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hKfBTDgOa94hZikKitb6D099/wSZB/6VcPNArwBb31ijhWY37dJz3/yrF36hwvtOJ2aJT4R+CGS2Er2u29UYNSZkHBfK5cBzfpaw0+dGB53RB9lriebgSVrJxxpmpaDFceNWbW1kXoKtpJFXET3ANZQ/EDn0GCgp6qmw8Qh44zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=i6lRSdIH; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728633626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x/Bc0fVN2f3md10XL6wu8hXYesW1d3yvz5HBdGjRGWU=;
	b=i6lRSdIHKlDIozT5vJH6ojotYpMTC6d3mCOslrqAb+qJJO4WqSssdRGaKppmi9JQM9I/EP
	/x1SjQtuFpS3nogCJymK6pBEmbkl2hETUtTH2j25L7oz//PgHPJTAmTGSXWC+CxjNGQUPP
	+K5fTMDtG01s+agUnabRGPaR3XgA1OeZoNyW7LRKXXbSuzuXn2jxcx0yI/dL8szRdb+6ph
	HA4S6MK4kCBGxMxHJOS1k+ApRCDCo+7yX7cr2cEzqSNmm4sDeYGYXm26ZZsX7kOOVn/BS1
	iaxGwCI9+7IXbA7O/U3jviK/M15TGWRjtvr71Lmvo/CeaEL8phpH4tL533THvw==
Content-Type: multipart/signed;
 boundary=af1154c69e001df7fb7f323f84794bbd4d176e15b89faa8d2c6e93554628;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 11 Oct 2024 10:00:17 +0200
Message-Id: <D4STH4Z8LTHN.2X4BJJVACFSIS@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>
Cc: <heiko@sntech.de>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>, "Diederik
 de Haas" <didi.debian@cknow.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add dtsi file for RK3399S SoC
 variant
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org>
In-Reply-To: <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--af1154c69e001df7fb7f323f84794bbd4d176e15b89faa8d2c6e93554628
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Oct 11, 2024 at 9:40 AM CEST, Dragan Simic wrote:
> Following the hierarchical representation of the SoC data that's been alr=
eady
> established in the commit 296602b8e5f7 ("arm64: dts: rockchip: Move RK339=
9
> OPPs to dtsi files for SoC variants"), add new SoC dtsi file for the Rock=
chip
> RK3399S SoC, which is yet another variant of the Rockchip RK3399 SoC.
> ...
> The RK3399S variant is used in the Pine64 PinePhone Pro only, [1] whose b=
oard
> dts file included the necessary adjustments to the CPU DVFS OPPs.  This c=
ommit
> effectively moves those adjustments into the separate RK3399S SoC dtsi fi=
le,
> following the above-mentioned "encapsulation" approach.
> ...
> ---
> ...
>  .../dts/rockchip/rk3399-pinephone-pro.dts     |  23 +---
>  arch/arm64/boot/dts/rockchip/rk3399-s.dtsi    | 123 ++++++++++++++++++
>  2 files changed, 124 insertions(+), 22 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch=
/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 1a44582a49fb..eee6cfb6de01 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -13,7 +13,7 @@
>  #include <dt-bindings/input/gpio-keys.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/leds/common.h>
> -#include "rk3399.dtsi"
> +#include "rk3399-s.dtsi"
> =20
>  / {
>  	model =3D "Pine64 PinePhone Pro";
> @@ -456,27 +456,6 @@ mpu6500@68 {
>  	};
>  };
> =20
> -&cluster0_opp {
> -	opp04 {
> -		status =3D "disabled";
> -	};
> -
> -	opp05 {
> -		status =3D "disabled";
> -	};
> -};
> -
> -&cluster1_opp {
> -	opp06 {
> -		opp-hz =3D /bits/ 64 <1500000000>;
> -		opp-microvolt =3D <1100000 1100000 1150000>;
> -	};
> -
> -	opp07 {
> -		status =3D "disabled";
> -	};
> -};
> -
>  &io_domains {
>  	bt656-supply =3D <&vcc1v8_dvp>;
>  	audio-supply =3D <&vcca1v8_codec>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi b/arch/arm64/boot=
/dts/rockchip/rk3399-s.dtsi
> new file mode 100644
> index 000000000000..e54f451af9f3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
> + */
> +
> +#include "rk3399-base.dtsi"
> +
> +/ {
> +	cluster0_opp: opp-table-0 {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-microvolt =3D <825000 825000 1250000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +		opp01 {
> +			opp-hz =3D /bits/ 64 <600000000>;
> +			opp-microvolt =3D <825000 825000 1250000>;
> +		};
> +		opp02 {
> +			opp-hz =3D /bits/ 64 <816000000>;
> +			opp-microvolt =3D <850000 850000 1250000>;
> +		};

Is there a reason why there isn't a line separator between the various
opp nodes? Normally there is one between nodes.
Note that in rk3588-opp.dtsi there are no separator lines between the
opp nodes, while they do exist between other nodes.
And in rk356x.dtsi the opp nodes do have a separator line.

Cheers,
  Diederik

--af1154c69e001df7fb7f323f84794bbd4d176e15b89faa8d2c6e93554628
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZwjbEwAKCRDXblvOeH7b
bn4ZAP9SAfzaXLnoMbuoF3dTehc8Jr9FMBa7745ZKmbW5eoeFwD+NA0wkfjetNtB
JuZcgcqxGj3DzG5bgYci1MaFeWc+2A8=
=kuwT
-----END PGP SIGNATURE-----

--af1154c69e001df7fb7f323f84794bbd4d176e15b89faa8d2c6e93554628--

