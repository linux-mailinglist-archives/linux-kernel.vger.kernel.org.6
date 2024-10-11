Return-Path: <linux-kernel+bounces-360754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1C4999F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16F0285AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFA207A0C;
	Fri, 11 Oct 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="FxhyWGGj"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0F209F3B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635653; cv=none; b=imyjHPWO2pRe15YN1NfubotxrF1ZXU4PxuPf8pzxJJCUKD1umdScbEoRF5OCpDJYu4YT0ujpT/Tue+YxIoqFDg3cshGrRQIdX099nVRtZigXqeJCu/MOqe5SzrDSKIQh4cTopaoAnGNJaaUyGBsjrqFKSocMuQ5J+XwsoRwpg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635653; c=relaxed/simple;
	bh=OSwf9IZuujhLOwQqQHghAm2D235QIwK1sWlHLxUTF4U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r88WOrY70AgFrtYdtsYl7wS7VpggNicplUIaAFwW/TEi8vD1kdKSE433Jo1DKED660qgEyiiccj0AnYFA3ayFec3YamZx2in/yuJtdnIQIOyO6LOVbbVXM965POPK6hVdTApz96J+fPyvDijf5v9r2KX+XgnS5noyjK8K00cD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=FxhyWGGj; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728635647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPg15Y0RP+O9S/V9OEOgK1OqOrwGsfvcPsISzD4p6E8=;
	b=FxhyWGGjp5JY+vM91T/2yr6NuAnXEteHRXJdFgJGorqnoaO79L6Ce591gR8yj1dJg/U9Ot
	ztLsT/NhDIIhHiZwHPJpmA/OHKq4LwXfvdDl2JH8KQ4p0zTUQMqBWiQ1UffVJctfW9Xz+q
	sSXwY7Fhr8HpTAxUKDAlKq4Jn9QhXlokawy3Txpbw3S/0Mu1tuW8tszT4AfVzNelQL+2vY
	W+XZRerIW02tBXZow14YxXBFRcYTpaiImiL1YHpG7sRXIDfEJCNL2QwskaCpJhcU4CVfuh
	0sDicuGD2UiOSFtA5lJEeAcgl87grLfHMyXMKEoprWkpKpDlN2agSggzzW4/og==
Content-Type: multipart/signed;
 boundary=8137794f5a62e3778c97b3857ef924c4846dffef6a1602a5ab2839f55273;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 11 Oct 2024 10:33:56 +0200
Message-Id: <D4SU6WHZCN34.2XL5W4D2T188G@cknow.org>
Cc: <linux-rockchip@lists.infradead.org>, <heiko@sntech.de>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add dtsi file for RK3399S SoC
 variant
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>
References: <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org> <D4STH4Z8LTHN.2X4BJJVACFSIS@cknow.org> <20da65423e77e13511cc7c7bb39e0246@manjaro.org>
In-Reply-To: <20da65423e77e13511cc7c7bb39e0246@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--8137794f5a62e3778c97b3857ef924c4846dffef6a1602a5ab2839f55273
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dragan,

On Fri Oct 11, 2024 at 10:23 AM CEST, Dragan Simic wrote:
> On 2024-10-11 10:00, Diederik de Haas wrote:
> > On Fri Oct 11, 2024 at 9:40 AM CEST, Dragan Simic wrote:
> >> Following the hierarchical representation of the SoC data that's been=
=20
> >> already
> >> established in the commit 296602b8e5f7 ("arm64: dts: rockchip: Move=20
> >> RK3399
> >> OPPs to dtsi files for SoC variants"), add new SoC dtsi file for the=
=20
> >> Rockchip
> >> RK3399S SoC, which is yet another variant of the Rockchip RK3399 SoC.
> >> ...
> >> The RK3399S variant is used in the Pine64 PinePhone Pro only, [1]=20
> >> whose board
> >> dts file included the necessary adjustments to the CPU DVFS OPPs. =20
> >> This commit
> >> effectively moves those adjustments into the separate RK3399S SoC dtsi=
=20
> >> file,
> >> following the above-mentioned "encapsulation" approach.
> >> ...
> >> ---
> >> ...
> >>  .../dts/rockchip/rk3399-pinephone-pro.dts     |  23 +---
> >>  arch/arm64/boot/dts/rockchip/rk3399-s.dtsi    | 123=20
> >> ++++++++++++++++++
> >>  2 files changed, 124 insertions(+), 22 deletions(-)
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
> >>=20
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts=20
> >> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> >> index 1a44582a49fb..eee6cfb6de01 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> >> @@ -13,7 +13,7 @@
> >>  #include <dt-bindings/input/gpio-keys.h>
> >>  #include <dt-bindings/input/linux-event-codes.h>
> >>  #include <dt-bindings/leds/common.h>
> >> -#include "rk3399.dtsi"
> >> +#include "rk3399-s.dtsi"
> >>=20
> >>  / {
> >>  	model =3D "Pine64 PinePhone Pro";
> >> @@ -456,27 +456,6 @@ mpu6500@68 {
> >>  	};
> >>  };
> >>=20
> >> -&cluster0_opp {
> >> -	opp04 {
> >> -		status =3D "disabled";
> >> -	};
> >> -
> >> -	opp05 {
> >> -		status =3D "disabled";
> >> -	};
> >> -};
> >> -
> >> -&cluster1_opp {
> >> -	opp06 {
> >> -		opp-hz =3D /bits/ 64 <1500000000>;
> >> -		opp-microvolt =3D <1100000 1100000 1150000>;
> >> -	};
> >> -
> >> -	opp07 {
> >> -		status =3D "disabled";
> >> -	};
> >> -};
> >> -
> >>  &io_domains {
> >>  	bt656-supply =3D <&vcc1v8_dvp>;
> >>  	audio-supply =3D <&vcca1v8_codec>;
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi=20
> >> b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
> >> new file mode 100644
> >> index 000000000000..e54f451af9f3
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
> >> @@ -0,0 +1,123 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
> >> + */
> >> +
> >> +#include "rk3399-base.dtsi"
> >> +
> >> +/ {
> >> +	cluster0_opp: opp-table-0 {
> >> +		compatible =3D "operating-points-v2";
> >> +		opp-shared;
> >> +
> >> +		opp00 {
> >> +			opp-hz =3D /bits/ 64 <408000000>;
> >> +			opp-microvolt =3D <825000 825000 1250000>;
> >> +			clock-latency-ns =3D <40000>;
> >> +		};
> >> +		opp01 {
> >> +			opp-hz =3D /bits/ 64 <600000000>;
> >> +			opp-microvolt =3D <825000 825000 1250000>;
> >> +		};
> >> +		opp02 {
> >> +			opp-hz =3D /bits/ 64 <816000000>;
> >> +			opp-microvolt =3D <850000 850000 1250000>;
> >> +		};
> >=20
> > Is there a reason why there isn't a line separator between the various
> > opp nodes? Normally there is one between nodes.
> > Note that in rk3588-opp.dtsi there are no separator lines between the
> > opp nodes, while they do exist between other nodes.
> > And in rk356x.dtsi the opp nodes do have a separator line.
>
> That has also bothered me. :)  I already had a look around in various
> dts(i) files long time ago and there seems to be no preferred layout.

I'm inclined to say the opp ones are the odd ones.

> In this particular case, it's better to have no separator lines because
> that's what we already have lacking in rk3399.dtsi, rk3399-t.dtsi, etc.,
> so running something like "diff rk3399.dtsi rk3399-s.dtsi" makes it easy
> to see what actually differs in the RK3399 SoC variants, without having
> to filter out any whitespace differences.

Besides that inconsistencies always seem to 'trigger' me, I especially
noticed it as this patch changed it from having separator lines to
having no separator lines.

Cheers,
  Diederik

--8137794f5a62e3778c97b3857ef924c4846dffef6a1602a5ab2839f55273
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZwji+AAKCRDXblvOeH7b
bg2RAQCj+fvzp+GUYQJcF7+6OXVPUfnmAxcAwVezTWHtzmsl+gEAy+yylI4pTDx0
maoPJ50F/e8jwPn4UpZsxyjjSJz5ZQI=
=epOB
-----END PGP SIGNATURE-----

--8137794f5a62e3778c97b3857ef924c4846dffef6a1602a5ab2839f55273--

