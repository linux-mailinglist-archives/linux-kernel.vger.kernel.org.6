Return-Path: <linux-kernel+bounces-245674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9423E92B5DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498B21F21B46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC9157464;
	Tue,  9 Jul 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co2T6EgR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AC156967;
	Tue,  9 Jul 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522233; cv=none; b=WTnJbjPGo1rHjR9KtNkPrWX+oMLFAxsdZxZco4D5o1zsbQ8v4HDY95a+3+sfuYjwotViMzxfiHtz2R5nPRrE9k/GJp6HoLXA82KEBkwVRwalKvTf6xkf3i0EMEEvHjHwdaYrxg+hG1YGLnpRhj67mYDyN0fflOeLmVDWsoP1EUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522233; c=relaxed/simple;
	bh=KBCyi08P5VEAGDKywTuRsjtLZ1Wk3bq99HxLuAgdfUY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAEw/p7ELznhvHRSofGZy35/DUJkZJ98nOanaMtPt3juNx32Zdl2DxR56DjCwSs9SW4SgJoZF90AFnbBg+TlNOlr2Pzo0oZBUaJegFhMlA4nDfEGZjWh03OM87rYU6uo4VRoOPYdK5zHiKweo8es92yNhulOYiTcMKWSyGCZfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co2T6EgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D89C3277B;
	Tue,  9 Jul 2024 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720522233;
	bh=KBCyi08P5VEAGDKywTuRsjtLZ1Wk3bq99HxLuAgdfUY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=co2T6EgRbtzNMZmROrCnN8zRKlLCswW/EgBWaTCQyNLGXkkia/rNwVeQEC55vffLs
	 eK0zV+xsdEVDtPGFaL5UAvfwVwywjLFlpNqugipv67RspcbPk4jtDNrFpHF8dU9csK
	 WFGVfenJ5OMuZKW19VAQbujJL9npjr0xKThIqSLbcAd5vGURH04Rn8JTg08hnct4Uu
	 solI+0T4YD7Ln0H2adcmF+7rqRrXNHQ5WOgkK/DcV8OKx2IRwPIxySjI6HWAVmWJPf
	 +WghI3v70BYesstEWrFHUmj8nSpaLqSJk3QSgGHtGXj7RpGVIX6F1GRdmwgOUFmb04
	 a1mWO3rCNWXCQ==
Date: Tue, 9 Jul 2024 11:50:29 +0100
From: Conor Dooley <conor@kernel.org>
To: claudiu beznea <claudiu.beznea@tuxon.dev>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mihai Sain <mihai.sain@microchip.com>
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
Message-ID: <20240709-education-unfreeze-a719c6927d73@spud>
References: <20240528153109.439407-1-ada@thorsis.com>
 <20240705-defection-septum-dd9202836b23@thorsis.com>
 <30fc0b41-49b9-41b8-82ef-c27d202492e6@tuxon.dev>
 <20240709-specked-paging-b821f10a657b@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wK73nfjr5zodA4AQ"
Content-Disposition: inline
In-Reply-To: <20240709-specked-paging-b821f10a657b@thorsis.com>


--wK73nfjr5zodA4AQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 12:41:02PM +0200, Alexander Dahl wrote:
> Am Mon, Jul 08, 2024 at 07:23:47PM +0300 schrieb claudiu beznea:
> > On 05.07.2024 09:19, Alexander Dahl wrote:
> > > Am Tue, May 28, 2024 at 05:31:09PM +0200 schrieb Alexander Dahl:
> > > It's been a while.  Is something wrong with the patch?  Or with the
> > > commit message?
> >=20
> > Please CC your patches to proper people (e.g., use
> > ./script/get_maintainer.pl). I see no Microchip AT91 maintainers in the
> > initial to/cc list of your patch.
>=20
> You can be sure I did.  This is the list I got on my patch and you see
> I CCed everone listed as a _maintainer_ from that output:
>=20
>     % ./scripts/get_maintainer.pl outgoing/arm-dts-microchip/0001-ARM-dts=
-microchip-sam9x60-Move-i2c-address-size-to-d.patch=20
>     Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED=
 DEVICE TREE BINDINGS)
>     Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AN=
D FLATTENED DEVICE TREE BINDINGS)
>     Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLAT=
TENED DEVICE TREE BINDINGS)
>     Nicolas Ferre <nicolas.ferre@microchip.com> (supporter:ARM/Microchip =
(AT91) SoC support)
>     Alexandre Belloni <alexandre.belloni@bootlin.com> (supporter:ARM/Micr=
ochip (AT91) SoC support)
>     Claudiu Beznea <claudiu.beznea@tuxon.dev> (supporter:ARM/Microchip (A=
T91) SoC support,commit_signer:1/2=3D50%,authored:1/2=3D50%,added_lines:32/=
45=3D71%,removed_lines:32/45=3D71%)
>=20
> Not sure why Nicolas, Alexandre, and you are listed as "supporter"
> only?  I think you should have been in the CC list in the first place,
> sorry about that.

You say only, but actually "supporter" is a stronger wording than
"maintainer" as it means that the people are actually paid to look after
the platform:
	S: *Status*, one of the following:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.
	   Odd Fixes:	It has a maintainer but they don't have time to do
			much other than throw the odd patch in. See below..
	   Orphan:	No current maintainer [but maybe you could take the
			role as you write your new code].
	   Obsolete:	Old code. Something tagged obsolete generally means
			it has been replaced by a better system and you
			should be using that.

As an aside, it might be a bit inaccurate here though, because Claudiu
is not paid to look after AT91 and Alexandre might not be either.

> Besides, I just noticed arch/arm/boot/dts/microchip/sam9x60.dtsi is
> not covered by specific matches in MAINTAINERS file, just through a
> generic fallback for all dts.  Lines in question are these, sam9 is
> not matched:
>=20
>     F:  arch/arm/boot/dts/microchip/at91*
>     F:  arch/arm/boot/dts/microchip/sama*

I think this is a hangover from when all arm dts files used to be in
arch/arm/boot/dts/, so the patter was needed to only match stuff the
lads cared about. Now that arm is like other architectures and has
subdirectories for vendors I think these could be simplified:
diff --git a/MAINTAINERS b/MAINTAINERS
index 691f98fe8ed3..1d2b201563e7 100644
	--- a/MAINTAINERS
	+++ b/MAINTAINERS
	@@ -2534,8 +2534,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated f=
or non-subscribers)
	 S:	Supported
	 W:	http://www.linux4sam.org
	 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
	-F:	arch/arm/boot/dts/microchip/at91*
	-F:	arch/arm/boot/dts/microchip/sama*
	+F:	arch/arm/boot/dts/microchip/
	 F:	arch/arm/include/debug/at91.S
	 F:	arch/arm/mach-at91/
	 F:	drivers/memory/atmel*


>=20
> Okay for the next time I will also CC supporters, but I found the
> output of get_maintainer.pl some kind of confusing here.

Cheers,
Conor.

--wK73nfjr5zodA4AQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo0V9QAKCRB4tDGHoIJi
0s4oAQDhdnuqeY0WEpTQlCh28Z70EQ1nspON5dYgjSQv7njFswD6AlLsu/K8jUPU
M+S4K/mpy0UdwyU5EYETMOmtz7sUOgQ=
=a1xN
-----END PGP SIGNATURE-----

--wK73nfjr5zodA4AQ--

