Return-Path: <linux-kernel+bounces-375164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEDE9A91C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094171F231EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4301E22FA;
	Mon, 21 Oct 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZRtS9R+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796491C8FD6;
	Mon, 21 Oct 2024 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545119; cv=none; b=sv0xmN2VXLtJnlS7SdL7VDJMexsxq8pVFI4v1KfvkvWGHIA94Bzx9OK0EoKRwvZNBJsDsFuDj74vYo7/xPDvdwUaAt6vh+1qd1c335ujvQg+mBL5mzOk3MjiiFPhjCEZ00440mQNEueixlfW8vVWU8NoLlGGedalA2UOe3GDokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545119; c=relaxed/simple;
	bh=PMQIm5ic//W4ZUrOlc9TwP4zzlIWpo2DNhQs18XRtDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTzhj8wT/XcOX3msYJlOBDB4CX9E6Rsx7pPsgZHyCTfu7ZjRHanDQ4R+EL5f8TC9SjK7eq3dXhuAzy0EYxouLIhU8grwUNb5Ik9ZZMb//UUoRmQSZTBU51cSxMT1ywrWVnfasPDGs7Zk/A7k6uBa4e+WlifRBPZwjAlIpBkP5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZRtS9R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66524C4CEC3;
	Mon, 21 Oct 2024 21:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729545118;
	bh=PMQIm5ic//W4ZUrOlc9TwP4zzlIWpo2DNhQs18XRtDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZRtS9R+ludXUQr8/Zg/47dNSxlpeii1/YHWDD9OBp4xgTghPtSwZr7/KYd2tLWcF
	 aa2D0MLUceWZrr3r0LAvNw4+1MVeprmLwtB29cklxvYxumm+ipL1Axf2hXSbItbHgm
	 ciqyGEjHv34anKptFmv5bjPY9tZYqS4Lvp+l+TBnVb5ix8w///1IlR0K0t3xIfWcHM
	 LH/EumJE5zCZhJx/ezEq37LBZRlhtmIzGtPxWBlm5+VfLIRy/KrVGV/t9PnctEn3mD
	 Azcnkj3JIinCiYcZh4/HvVbGjXgpVub6IQv9+CUG9OdTi7okmIjY5/DYcYtLoqU0i/
	 LuprNSbsc8y0Q==
Date: Mon, 21 Oct 2024 22:11:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] dt-bindings: soc: bcm: Convert to Dt schema
Message-ID: <20241021-handset-frolic-a910c4cb1669@spud>
References: <20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com>
 <20241021-exposable-seventh-baed2b1442b6@spud>
 <pyizqjpxjgd6zdrhh65fklmyrxgxmlu2wmv7tzpdhdkwh7ifn6@efvaxhpekxtb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VpBKaFiwjRspgXeg"
Content-Disposition: inline
In-Reply-To: <pyizqjpxjgd6zdrhh65fklmyrxgxmlu2wmv7tzpdhdkwh7ifn6@efvaxhpekxtb>


--VpBKaFiwjRspgXeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 06:13:17PM +0000, Karan Sanghavi wrote:
> On Mon, Oct 21, 2024 at 12:39:28PM +0100, Conor Dooley wrote:
> > On Sat, Oct 19, 2024 at 07:51:18PM +0000, Karan Sanghavi wrote:
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/power/raspberrypi-power.h>
> >=20
> > What do you use from this header?
> >
> Example for power node
> power: power {
>         compatible =3D "raspberrypi,bcm2835-power";
>         firmware =3D <&firmware>;
>         #power-domain-cells =3D <1>;
>    };
>=20
> Example for using the power domain
>=20
> &usb {
>         power-domains =3D <&power RPI_POWER_DOMAIN_USB>;
>    };
>=20
> We need the header for referring the power domain defines in the sub
> nodes.
>=20
> I didn't understood exactly how should I include the usb example thus
> omitted it but if required can you please let me know how to add them.

There's usually no consumers in a provider binding example, and you have
not included one, so the header isn't needed.

--VpBKaFiwjRspgXeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxbDmgAKCRB4tDGHoIJi
0vKGAP0VdfzTFXfbF3Xen/3fPcRaG2PatahrcoBFxliQispYnAEA7WXpT0vMR1xX
Rnas3Xb/zcVB9q5tHofl1UV7Cs48kAc=
=zotD
-----END PGP SIGNATURE-----

--VpBKaFiwjRspgXeg--

