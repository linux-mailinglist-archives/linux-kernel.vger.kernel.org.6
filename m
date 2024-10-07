Return-Path: <linux-kernel+bounces-353520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B00992EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685521C2341D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A021D61B6;
	Mon,  7 Oct 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="dvdygJV4"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F21D5CE7
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310968; cv=none; b=D7lmo9ECGAJwlTJH0UMqjky2WnNndMqvKy23Tfjw+4zm2+cR9Y0cw1Xa+nTaeV7RTHGsduxp6LvYVybfNT8BZJe65nGwPBm+MTkCyMqQcrJWr/rXdTmG8+0NBvRk+YpN1esr7elPo067B6ao3fZesSs5aijpsDFCSiq7lAPeIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310968; c=relaxed/simple;
	bh=ZepIFIYOT5MYbLRNei1KddhAuU1eTVAmQSB/Udp0DSk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gPYIS6EHQ+w0VwrZf01ALxgmYnvWSeQ5TD5nyrOCpkQk5qHGlpZkBCH+d+528AURcwQQBQzMCJOLag+JurqqKIspxVdw5xpnYJyFCP7Cx7oaAeV5RhFTQGF0KSooAYR1kxUCBl/bni/4CXNK0Kci9c+bW/ybiV38svocTs1YHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=dvdygJV4; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728310963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APN3Rf1CHc5QKBHwClsLIHA5EOjpyOHZWT2nCBIU7ZI=;
	b=dvdygJV4R8u3j7v2JrQ3vQApLXeDKapTyGuAv+buKi9WSph4x6JkFTQ1nJo9N6+oRwCI4n
	ait7Y4J96tHR8j63wl8+kx5TcN9OzQnL0i+Uv67Vyb2X2+6mx2VDn/o1ges9nilHiA7F/o
	i9OF0nQCHF8aBy+QH3Bnsjhxcy3Bw6kDOFsFvOciVFwAXWmIitilXsn7+pZwK+ObsgtcMp
	A5Pqs/LRVcZucKCWffwPssZ6Q8pIZRk48I1CbiYpP2gaFz7TNvzS0350KS+qLHpQywmyhf
	R0ZEZS2uJUzFqV1yr+omsLgfKvo5UoOTfx1gQGW4xEIZ+nxSxWRGtKW5SKJB0w==
Content-Type: multipart/signed;
 boundary=51cba31023c492486e1820f7b7082cd7fad1f9f03d93a5c097c580e3c009;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 07 Oct 2024 16:22:32 +0200
Message-Id: <D4PN3MEAFIFU.1BAJ732GCUCTR@cknow.org>
Cc: "Dragan Simic" <dsimic@manjaro.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Fix wakeup prop names on brcm
 BT nodes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
References: <20241007105657.6203-2-didi.debian@cknow.org>
 <20241007105657.6203-5-didi.debian@cknow.org> <6096052.lOV4Wx5bFT@diego>
In-Reply-To: <6096052.lOV4Wx5bFT@diego>
X-Migadu-Flow: FLOW_OUT

--51cba31023c492486e1820f7b7082cd7fad1f9f03d93a5c097c580e3c009
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Oct 7, 2024 at 4:06 PM CEST, Heiko St=C3=BCbner wrote:
> Am Montag, 7. Oktober 2024, 12:28:18 CEST schrieb Diederik de Haas:
> > The "brcm,bluetooth.yaml" binding has 'device-wakeup-gpios' and
> > 'host-wakeup-gpios' property names.
> > Fix the ones where '*-wake-gpios' was used.
> >=20
> > Note that the "realtek,bluetooth.yaml" binding does use the
> > '*-wake-gpios' property names.
> >=20
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
>
> parts of the commit conflict with a previous one from me ;-) [0]
>
>
> [0] https://lore.kernel.org/linux-arm-kernel/20240930210112.1993625-7-hei=
ko@sntech.de/T/#m59bdb72d6c22f85fe79716761fedaea2a2e1c73e

Haha, I actually did base my changes on one of your patch submissions
("rk3328 cru dt-binding conversion"), but that's the 'wrong' one ;-)

Will drop the rk3566-box-demo.dts one in v2.

Cheers,
  Diederik

> > ---
> >  arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts  | 4 ++--
> >  arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/ar=
m64/boot/dts/rockchip/rk3566-box-demo.dts
> > index 0c18406e4c59..16fd98698db3 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
> > @@ -450,8 +450,8 @@ bluetooth {
> >  		compatible =3D "brcm,bcm43438-bt";
> >  		clocks =3D <&pmucru CLK_RTC_32K>;
> >  		clock-names =3D "ext_clock";
> > -		device-wake-gpios =3D <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> > -		host-wake-gpios =3D <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
> > +		device-wakeup-gpios =3D <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> > +		host-wakeup-gpios =3D <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
> >  		shutdown-gpios =3D <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
> >  		pinctrl-names =3D "default";
> >  		pinctrl-0 =3D <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/a=
rm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> > index de4c082dce07..7381bb751852 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> > @@ -684,8 +684,8 @@ bluetooth {
> >  		compatible =3D "brcm,bcm43438-bt";
> >  		clocks =3D <&rk817 1>;
> >  		clock-names =3D "lpo";
> > -		device-wake-gpios =3D <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
> > -		host-wake-gpios =3D <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> > +		device-wakeup-gpios =3D <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
> > +		host-wakeup-gpios =3D <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> >  		reset-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
> >  		pinctrl-0 =3D <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
> >  		pinctrl-names =3D "default";
> >=20


--51cba31023c492486e1820f7b7082cd7fad1f9f03d93a5c097c580e3c009
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZwPurAAKCRDXblvOeH7b
bixPAQCfSDhz9tB5IlL/XoL37u8HLNi6YjiJx+tRTf4u0PzktwD/W+7lNx2K9Jr2
LYR4hUu5xwelo4J1/sYXCF9EbsR8JQY=
=Nmgp
-----END PGP SIGNATURE-----

--51cba31023c492486e1820f7b7082cd7fad1f9f03d93a5c097c580e3c009--

