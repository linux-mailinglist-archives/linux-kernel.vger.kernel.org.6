Return-Path: <linux-kernel+bounces-353552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEE992F65
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406881C22CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5B1D2F4B;
	Mon,  7 Oct 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ykDfl/CQ"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A81D619F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311293; cv=none; b=Aq0CJWa3Mmsq8c4DK5Re1/O/yLF2jlSQdWANaFDXDMzdZdYTA2CRH6WJZOeModTIq6r73x1m+E3vBRyWGMidieGTtX5tKuAfuW/H6I6bAtes6w8r/K9Nq7X/3v5TSizebMhDQc71yKPdFWqrEhfkJ07s9QPkHv78rkDPle/SLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311293; c=relaxed/simple;
	bh=n5hZzCJwspYA3Tn8kasI3971g8e/sruaIzeSn0j5T8I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V7o8VivDJp5oHwTNWFcdcHRRMpSzWzsi0KTC+kGNyYBSccwazlwZ4lt5cGvSGeiyeAtmtLtiw0/MbBzM94VAe+34CzXM/tUMjIIiNaum/Q62W4MG+Yu8W2ymubfl55LsSwjIHerccYPvKnBabd2yh1sHdU0W0VDJHraGCYfkIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ykDfl/CQ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728311289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsGKgHfqizmTBsBA0G5SHeGmEvGU4wB4XCYFeRqbgFY=;
	b=ykDfl/CQW53CP31cPAE9ksORAybUo4OcmpLeR9I7FI9spMbeuSysr6uH0mgHBwgHQ8O2pF
	F6FHbgo9plUDm+TitrB+HjHBSmbnPqhAhWDc1Xzm9JowJan28UvP79BrkPOBfEfRS9iDh+
	PA6Grv+cTywDmeBw83xmRj3lVxKshpYbDWBK74BucPrUPjYaG1Q7p3cdTOsuNLdCrjsfN0
	K9u9SJ2DFQBFMBHeSLdTDyG1ZawIB14amW5HbniqfZCKkVqJCMF7EiPWV/kXcfgUGRolW0
	aJArIvdrZKZaAuQETC4pWnI3pPjaLxrITLnqS7kAFMslytqEc3dSz5we6NPdzQ==
Content-Type: multipart/signed;
 boundary=8fee40a3652e3dfc8b43c5412c165b14d35256cdef3a53e3f0d083829ec2;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 07 Oct 2024 16:28:07 +0200
Message-Id: <D4PN7WCK7XHH.1BMR5J23UJH58@cknow.org>
Cc: "Dragan Simic" <dsimic@manjaro.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Fix reset-gpios prop on brcm
 BT nodes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
References: <20241007105657.6203-2-didi.debian@cknow.org>
 <20241007105657.6203-6-didi.debian@cknow.org> <12534438.O9o76ZdvQC@diego>
In-Reply-To: <12534438.O9o76ZdvQC@diego>
X-Migadu-Flow: FLOW_OUT

--8fee40a3652e3dfc8b43c5412c165b14d35256cdef3a53e3f0d083829ec2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hello :)

On Mon Oct 7, 2024 at 4:04 PM CEST, Heiko St=C3=BCbner wrote:
> Am Montag, 7. Oktober 2024, 12:28:19 CEST schrieb Diederik de Haas:
> > Except for some compatibles, the "brcm,bluetooth.yaml" binding doesn't
> > allow the 'reset-gpios' property, so replace the invalid ones with the
> > 'shutdown-gpios' property.
>
> this probably needs more explanation in the commit message, because
> by name I'd expect reset and shutdown being different functionalities.
>
> But for these cases, things should be good, simply because when looking
> at the bt_enable_h pinctrl, that pin really provides the shutdown
> functionality.

I guess I forgot to add the reference to page 12 of the
AzureWave-CM256SM datasheet (v1.9):

Pin 34 'BT_REG_ON': =20
Used by PMU to power up or power down the internal
regulators used by the Bluetooth section. Also, when
deasserted, this pin holds the Bluetooth section in reset. This
pin has an internal 200k ohm pull down resistor that is
enabled by default. It can be disabled through programming.

So my research was more extensive then I actually put in the commit
message ... will fix that in v2.

Cheers,
  Diederik

> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 2 +-
> >  arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/a=
rm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> > index 7381bb751852..100a2774bbb5 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> > @@ -686,9 +686,9 @@ bluetooth {
> >  		clock-names =3D "lpo";
> >  		device-wakeup-gpios =3D <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
> >  		host-wakeup-gpios =3D <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> > -		reset-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
> >  		pinctrl-0 =3D <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
> >  		pinctrl-names =3D "default";
> > +		shutdown-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
> >  		vbat-supply =3D <&vcc_wl>;
> >  		vddio-supply =3D <&vcca_1v8_pmu>;
> >  	};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi b/arch/=
arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> > index d09e6542e236..3e0cbfff96d8 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> > @@ -402,9 +402,9 @@ bluetooth {
> >  		clock-names =3D "lpo";
> >  		device-wakeup-gpios =3D <&gpio2 RK_PB2 GPIO_ACTIVE_HIGH>;
> >  		host-wakeup-gpios =3D <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
> > -		reset-gpios =3D <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
> >  		pinctrl-names =3D "default";
> >  		pinctrl-0 =3D <&bt_host_wake_h &bt_reg_on_h &bt_wake_host_h>;
> > +		shutdown-gpios =3D <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
> >  		vbat-supply =3D <&vcc_3v3>;
> >  		vddio-supply =3D <&vcc_1v8>;
> >  	};
> >=20


--8fee40a3652e3dfc8b43c5412c165b14d35256cdef3a53e3f0d083829ec2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZwPv+QAKCRDXblvOeH7b
bjpAAPoDRG8CqEprwWSNF9T4Nmif/RnR5L2vAeBIJR/7Ev1U8AD9FU2ONvofOvPX
qfDTpG14ILZTJRxkOMSPpttdMIjmMQ4=
=90So
-----END PGP SIGNATURE-----

--8fee40a3652e3dfc8b43c5412c165b14d35256cdef3a53e3f0d083829ec2--

