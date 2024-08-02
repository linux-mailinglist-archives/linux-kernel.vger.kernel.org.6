Return-Path: <linux-kernel+bounces-272740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4C94606F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222D3287DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C774B166F37;
	Fri,  2 Aug 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD7MU5yg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146EF15C133
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612212; cv=none; b=leOZvrHbNYhSKPV06iJgTAKjJoZsuD/vd9YGShLtIzLq54ATqXPZ3rk9zTk+M92XMEzV7/h29EQuK7b/omtt8EcMK2Jwb0t4jVpZ+oOMomrd7ejx3+ljVHdqAiJdHWgZf79vrLoEPv26NvnELOylWtfJG9AMjAMS4GPq56oVKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612212; c=relaxed/simple;
	bh=Ck9LEwXJuTKp2hn5gIf5h/hL9jCsANACSnvPZxzbkos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIjzVmoNacW0Tu/0y1BH02YSugew7wJOi706uTUuB5jjU5ru7BiyPlsdUnKY+zDW/1HZvzIcJUz7TRHI1UgH5YCfuRFxa0ZaOMHQWJ/uS0uEr3y3Fzq/yy0P2nzS0l9GiQuEo6Fw7jYYx65m0fQxYmjCC9Ro8IlDJcJcz8puA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD7MU5yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443D0C32782;
	Fri,  2 Aug 2024 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722612211;
	bh=Ck9LEwXJuTKp2hn5gIf5h/hL9jCsANACSnvPZxzbkos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XD7MU5ygwhpiOocynTMKY/af/KzGc4OmemcQ5yRyiEEXQFnk5SoPqs9p+eIOC7XhJ
	 Az3LiSTmhJe80QdO6QsOILdLlP02vHVkrWNK0fw2q9PsDs68KmcEkIfWlO2pu9Zj2N
	 7+SGCAeBeDYtwOOZ1ChPh0lS+K9rN/UaE5D2nuP00zVKIeKFTnoqu8D8gx47+nZhlA
	 cWHijqMq8Yk8fIj+hCoB8JyJQofSsiagJCeu5ANr6j0esikMmUVkda7H533aWwZOzk
	 Xh1MpF3vVBITANuBQ2TQUzc79D0ujx+q4gBeCM6KcKFI1aAnNB2B9d9iyeiKZYnw0T
	 jplV0BCSYyywg==
Date: Fri, 2 Aug 2024 16:23:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Cristian.Birsan@microchip.com
Cc: Andrei.Simion@microchip.com, claudiu.beznea@tuxon.dev,
	Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update DTS path for ARM/Microchip (AT91) SoC
Message-ID: <20240802-trustable-copy-8595abfa5625@spud>
References: <20240731144100.182221-1-andrei.simion@microchip.com>
 <67dae338-31f9-4b5a-b870-769a914464bf@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X/8ipsA4lfjMk04E"
Content-Disposition: inline
In-Reply-To: <67dae338-31f9-4b5a-b870-769a914464bf@microchip.com>


--X/8ipsA4lfjMk04E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 12:11:11PM +0000, Cristian.Birsan@microchip.com wro=
te:
> Hi Andrei,
>=20
> On 31.07.2024 17:41, Andrei Simion wrote:
> > Update the path to the supported DTS files for ARM/Microchip (AT91)
> > SoC to ensure that the output of the get_maintainer.pl script includes
> > the email addresses of the maintainers for all files located in
> > arch/arm/boot/dts/microchip.
> >=20
> > Suggested-by: Conor Dooley <conor@kernel.org>
> > Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
>=20
> This is helpful for SAM9x60 and SAM9x75 boards. On the other hand it=20
> will add other boards too but there is no explicit maintainer for them=20
> so I hope is fine.

Ye, even if it did add other boards I think it would be correct to do,
as having a single tree for the arm32 microchip boards is a good idea.

Cheers,
Conor.

>=20
> Reviewed-by: Cristian Birsan <cristian.birsan@microchip.com>
>=20
> > ---
> > Based on discussion:
> > https://lore.kernel.org/lkml/20240709-education-unfreeze-a719c6927d73@s=
pud/
> > ---
> >   MAINTAINERS | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 36d66b141352..c9f320ba8bc9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2542,8 +2542,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderate=
d for non-subscribers)
> >   S:	Supported
> >   W:	http://www.linux4sam.org
> >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
> > -F:	arch/arm/boot/dts/microchip/at91*
> > -F:	arch/arm/boot/dts/microchip/sama*
> > +F:	arch/arm/boot/dts/microchip/
> >   F:	arch/arm/include/debug/at91.S
> >   F:	arch/arm/mach-at91/
> >   F:	drivers/memory/atmel*
> >=20
> > base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
>=20
> Regards,
> Cristi

--X/8ipsA4lfjMk04E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqz58AAKCRB4tDGHoIJi
0qfvAP4kVwZOzMHXrN129a0Av8wwFwZlwglTXMewYSeLyU2JyAD/azU83ku0XmfE
BH2q/jztu7YWyeT7EUSZ8Jk0KDSocQI=
=Kl0O
-----END PGP SIGNATURE-----

--X/8ipsA4lfjMk04E--

