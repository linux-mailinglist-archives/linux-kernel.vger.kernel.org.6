Return-Path: <linux-kernel+bounces-439698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC989EB2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DBE165AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C322087;
	Tue, 10 Dec 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="i7TT7o4m"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654961AA1D9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839726; cv=none; b=D+8alGWnMeYaCKjrt+fHB+3ou4vyGpLh0UmfBDeah8VypO8bmV2rN0cUq85AS3AkHyhtUqLe4YP97TsGyXhk/7ahKQsZUWb6foqSSZ6i3JEtxOKx9C0rV/qQrWkY+khCtz8q0/ls4qUBYNdO9EWvS5rXWn9lgxYFurLVBhPEUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839726; c=relaxed/simple;
	bh=rpq4rB1qFLGN/pPkWko88+qcmLf7FTumkCrJs3ShpBs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=miTk1YYyLGLsz8wC9kipBsOpMU6qBCO94w/Q1fhDmFqQjeU+goPvss7anxfCqIi/VUtONlyPoaOsXBQQzZhsUUTHdc845mVVGm0c+2HkpdbMBbHzntpcaWfIPw6ON6XZ462/78RyMv4vMuhbFeB3bWCNGMn8MMRyHUywAWfVsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=i7TT7o4m; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1733839721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+lr9Xj8fasPSLICMtvgJpje7wSb8uDowE1UhnFV4lk=;
	b=i7TT7o4mPAPdG7vU6a/kLsvJUfv7u5Ia+z4a/tIAc7XkC2g9FKzSWyiwE5Wdp7yAWWpJ9C
	xJOYKvJzZSyKUE/7akX3awuNlhZSOt26uORS2E82RRA/KJf8Lv0MwMzM/UpcYb1srG0AUu
	9p3ubdqlEmmnBeH6ehTpnobyxRW9jzVw+OX2jt+kc0BDJyhMPzGux6HZNt9NHjFQsAku6A
	O8k2LDTbSFS9HnW+H1WNT6rFVDJPdagI6NAOpxryFERH+3iD90F89TtgdS7oGJbJdTKSJH
	usN8MLZVd/hFVQs/r9zToDJ6rNE7CbjrZXOeTSgQ2wgMSefQWk4mI+K3+wZEYA==
Content-Type: multipart/signed;
 boundary=71c82bf461fdb53d31fda9f19110d3c968b0d155862851919717d99cc7ad;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 10 Dec 2024 15:08:29 +0100
Message-Id: <D682VQLD81Y8.1K8OD4ECAOSW3@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Peter Geis" <pgwipeout@gmail.com>
Cc: "Heiko Stuebner" <heiko@sntech.de>, "Conor Dooley"
 <conor+dt@kernel.org>, "Dragan Simic" <dsimic@manjaro.org>, "Johan Jonker"
 <jbx6244@gmail.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Levin Du"
 <djw@t-chip.com.cn>, "Rob Herring" <robh@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: correct rk3328-roc regulator
 map
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-6-pgwipeout@gmail.com>
 <D67ZJ6MOM5TH.2WBYCCU20DDJO@cknow.org>
 <CAMdYzYorTNiAybGhPu0u_YPj2J7qxCO72KBU1ozTde+2zK9Hxg@mail.gmail.com>
In-Reply-To: <CAMdYzYorTNiAybGhPu0u_YPj2J7qxCO72KBU1ozTde+2zK9Hxg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--71c82bf461fdb53d31fda9f19110d3c968b0d155862851919717d99cc7ad
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Dec 10, 2024 at 2:04 PM CET, Peter Geis wrote:
> On Tue, Dec 10, 2024 at 6:31=E2=80=AFAM Diederik de Haas <didi.debian@ckn=
ow.org> wrote:
> > On Tue Dec 10, 2024 at 2:30 AM CET, Peter Geis wrote:
> > > voltages to vcc_host1_5v, and standardize the order of regulator
> > > properties among the fixed regulators.
> >
> > Big fan of standardization :-) ...
> >
> > >
> > > Fixes: 2171f4fdac06 ("arm64: dts: rockchip: add roc-rk3328-cc board")
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > ---
> > >
> > >  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 23 +++++++++++++-----=
--
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm6=
4/boot/dts/rockchip/rk3328-roc.dtsi
> > > index f782c8220dd3..6984387ff8b3 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > > @@ -24,22 +24,23 @@ gmac_clkin: external-gmac-clock {
> > >               #clock-cells =3D <0>;
> > >       };
> > >
> > > -     dc_12v: regulator-dc-12v {
> > > +     /* fed from passive usb input connector */
> > > +     dc_5v: regulator-dc-5v {
> > >               compatible =3D "regulator-fixed";
> > > -             regulator-name =3D "dc_12v";
> > > +             regulator-name =3D "dc_5v";
> > >               regulator-always-on;
> > >               regulator-boot-on;
> > > -             regulator-min-microvolt =3D <12000000>;
> > > -             regulator-max-microvolt =3D <12000000>;
> > > +             regulator-min-microvolt =3D <5000000>;
> > > +             regulator-max-microvolt =3D <5000000>;
> > >       };
> > >
> > >       vcc_sd: regulator-sdmmc {
> > >               compatible =3D "regulator-fixed";
> > > +             regulator-name =3D "vcc_sd";
> > >               gpio =3D <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> > >               pinctrl-names =3D "default";
> > >               pinctrl-0 =3D <&sdmmc0m1_pin>;
> > >               regulator-boot-on;
> > > -             regulator-name =3D "vcc_sd";
> > >               regulator-min-microvolt =3D <3300000>;
> > >               regulator-max-microvolt =3D <3300000>;
> > >               vin-supply =3D <&vcc_io>;
> >
> > ... but why not put regulator-name as the first of the regulator
> > properties as is done in the rk3328-rock64.dts ...
> >
> > > @@ -50,22 +51,25 @@ vcc_sdio: regulator-sdmmcio {
> > >               states =3D <1800000 0x1>, <3300000 0x0>;
> > >               regulator-name =3D "vcc_sdio";
> > >               regulator-type =3D "voltage";
> > > +             regulator-always-on;
> > >               regulator-min-microvolt =3D <1800000>;
> > >               regulator-max-microvolt =3D <3300000>;
> > > -             regulator-always-on;
> > >               vin-supply =3D <&vcc_sys>;
> > >       };
> > >
> > >       vcc_host1_5v: vcc_otg_5v: regulator-vcc-host1-5v {
> > >               compatible =3D "regulator-fixed";
> > > +             regulator-name =3D "vcc_host1_5v";
> > >               enable-active-high;
> > >               pinctrl-names =3D "default";
> > >               pinctrl-0 =3D <&usb20_host_drv>;
> > > -             regulator-name =3D "vcc_host1_5v";
> > >               regulator-always-on;
> > > +             regulator-min-microvolt =3D <5000000>;
> > > +             regulator-max-microvolt =3D <5000000>;
> > >               vin-supply =3D <&vcc_sys>;
> > >       };
> >
> > ... and was the case here?
>
> That's fair, thank you. I like the alphabetical approach, I'll go that
> way when I split this out.

FWIW, I'm fine when regulator-name and regulator-type would be put on
the top of the regulator-* properties, also because that's currently
the case for the rk3328-rock64.dts.
And a strict alphabetical order would look weird anyway as then
-max-microvolt should be ordered above -min-microvolt.

Cheers,
  Diederik

--71c82bf461fdb53d31fda9f19110d3c968b0d155862851919717d99cc7ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ1hLYgAKCRDXblvOeH7b
bsqGAP0ausb4UuEsVs1vJjp21RP5uSetGtXSYkjqDm5Iwx0S+QEAhXy7tQEG2SpU
vxYM7GPJ6U1VLvsRMAenXCAd0jGDOwc=
=Xo59
-----END PGP SIGNATURE-----

--71c82bf461fdb53d31fda9f19110d3c968b0d155862851919717d99cc7ad--

