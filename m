Return-Path: <linux-kernel+bounces-372979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED69A5036
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8A11F25DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D2C18E758;
	Sat, 19 Oct 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="AQsNfew+"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558918990E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729361365; cv=none; b=YEnvuHJCRBGpWhAVa1RrmKa+OHtY9/bzI41apxFvgi+yeBlEsMpVFO2F9eevK+3h10WPetHFN9XHglTVcz+dY3q76EfKk1QT3BReZh4qpHmivHVQJ9BToRuCWuvk/nvzTDuLKGb9pINRlCgujZXHPA5RS4Ygy755Zx31CCVxBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729361365; c=relaxed/simple;
	bh=EWobNxr/fu8G78jXjGTzejsIyUdAaSkwE4u8iTfF/nc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f7GXQ16AQ6AIPJnGf9h4SjIiqZDBbuHVartYdgAaIuu/Bscl1RRjd5vq/d/lF0iQwtMb8ZURDzV77A+nPSf2QcM7nlEeMr6cKcxiJ9z0ikOFfdx6hP9hYyTvZJOrvQEYIrU9DFdhgfndbN++g9tyATJ3KyK208ToibvhkCM1kKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=AQsNfew+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729361355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f3RtjINZGSgrKRy2wNDqwWrIHrIIPJ53FJ8P+x6DkhI=;
	b=AQsNfew+K6F+CLgKgr50utpQXBypfTUxchrOeI73zMAcWok/7hgMhCo6fub0UnDP6iuk5d
	ZutrSF4lZ5udnjXawQlruQMscn5kBPnMmo1oBfOpCu+wW68/QujudwXWre10YG4AD1vj8j
	Cz5ZOjRz+xwUEhUCEYXsnPJme9hUa3DABRy4c7ypl0BcmJAzWRPT7n3udouF89ohdHBCVC
	i4/6mGEHDVrbMtmh/v6HKjrwxqyfkT3jfGi8R99cBpi+eAxk9HRv0kFBqsBeqoITrqq1ya
	3OjTbRJemUVysfTQbgYf1LvJ8i1Af0xMBNNQFjB2gxCVywk8mf1pyN/Ye/Y5nA==
Content-Type: multipart/signed;
 boundary=eb9158f3fd3022c747c09e202d1d0a175e416ede785f1ca7d155a4b18fff;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 19 Oct 2024 20:09:02 +0200
Message-Id: <D4ZZFL98AMFI.1TDPL2DJPSQ3D@cknow.org>
Cc: <heiko@sntech.de>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Prepare RK356x SoC dtsi files
 for per-variant OPPs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <cc2aed3116a57dd50e2bb15ab41b12784adfafe3.1728752527.git.dsimic@manjaro.org> <D4U30AUOH6UR.1QPH47KN5EWE4@cknow.org>
In-Reply-To: <D4U30AUOH6UR.1QPH47KN5EWE4@cknow.org>
X-Migadu-Flow: FLOW_OUT

--eb9158f3fd3022c747c09e202d1d0a175e416ede785f1ca7d155a4b18fff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dragan,

On Sat Oct 12, 2024 at 9:41 PM CEST, Diederik de Haas wrote:
> On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
> > =20
> > -&pipegrf {
> > -	compatible =3D "rockchip,rk3566-pipe-grf", "syscon";
>
> This seems unrelated?
>
> > +&cpu0 {
> > +	operating-points-v2 =3D <&cpu0_opp_table>;
> >  };
> > =20
> > -&power {
> > -	power-domain@RK3568_PD_PIPE {
> > -		reg =3D <RK3568_PD_PIPE>;
> > -		clocks =3D <&cru PCLK_PIPE>;
> > -		pm_qos =3D <&qos_pcie2x1>,
> > -			 <&qos_sata1>,
> > -			 <&qos_sata2>,
> > -			 <&qos_usb3_0>,
> > -			 <&qos_usb3_1>;
> > -		#power-domain-cells =3D <0>;
> > -	};
>
> This seems unrelated to me and possibly a functional change?
> If this was intended, then a description in the commit message would be
> nice why this is appropriate and possibly moved to a separate patch?
>
> > +&cpu1 {
> > +	operating-points-v2 =3D <&cpu0_opp_table>;
> > +};
> > +
> > +&cpu2 {
> > +	operating-points-v2 =3D <&cpu0_opp_table>;
> >  };
> > =20
> > -&usb_host0_xhci {
> > -	phys =3D <&usb2phy0_otg>;
> > -	phy-names =3D "usb2-phy";
> > -	extcon =3D <&usb2phy0>;
> > -	maximum-speed =3D "high-speed";
>
> This also looks unrelated and a functional change?
>
> > +&cpu3 {
> > +	operating-points-v2 =3D <&cpu0_opp_table>;
> >  };
> > =20
> > -&vop {
> > -	compatible =3D "rockchip,rk3566-vop";
>
> This also looks unrelated?

It turns out I was wrong.
The elements I thought were removed, aren't removed.

Sorry for the noise.

Diederik

--eb9158f3fd3022c747c09e202d1d0a175e416ede785f1ca7d155a4b18fff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZxP1wwAKCRDXblvOeH7b
bnomAQCauVO5HYPsaXNdYa5Tz50X1ZlJC7CDUvnlwWrQif3qFQEApyYcsmXRi4Xv
ePPHwirwTWwZXt6w4Rr5ksGu3kE2Rg4=
=NC6L
-----END PGP SIGNATURE-----

--eb9158f3fd3022c747c09e202d1d0a175e416ede785f1ca7d155a4b18fff--

