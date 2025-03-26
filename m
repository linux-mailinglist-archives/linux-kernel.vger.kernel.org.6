Return-Path: <linux-kernel+bounces-577479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341BA71D97
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D462E1641DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332423FC40;
	Wed, 26 Mar 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN67gYPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828917E4;
	Wed, 26 Mar 2025 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011170; cv=none; b=tZDmQ8pgoK8IIHMm+NVYesGG0XLEjYJmKy/JgbJkAy+DRMFYZ4OLDrZnDC0umZFPjDhX/oEfXJBe0G9+scsU6WqfT/gZEtFCF74bJwq+nYRifUpwkZuJzvYNJCTviyg3Z3WOfwV31F8J+zjYZyiVm+VrtafL8/Ruo1Ikja2aJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011170; c=relaxed/simple;
	bh=P0vHxQGr5VJNvnmH4Uwj5XDcpfO/fPYsBLTgEK8dtJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT9lZBTnvdoEHwstbnmSUWyNl09U55JAT/pB7UPecNM8Zqws7n3Ip0W5z88TF3D8emp5c19g/+R9DkhTeUXhpIMGj401JVXuaqEtJ8F0ZcF5FpR74ASVGRAbil6J6Tfv4vIU5rDK2hVhgO3zzZOfg7vII7neNFeZqhqV01cfb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN67gYPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC61BC4CEE2;
	Wed, 26 Mar 2025 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011169;
	bh=P0vHxQGr5VJNvnmH4Uwj5XDcpfO/fPYsBLTgEK8dtJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dN67gYPIPURsZBpBuT50xkVoxbLQAVcvMBuLJbtnBo/y+n/V15uuR1oOLXJXopzUi
	 PAtWv616YHKIkemXZWnzT/EyoktzMVI3+279o3GkLbrV4Dh5B/pCN2c7m8h9MBCeX1
	 Vd8qZ76djDx/E869sTAAgtTE34TzDnDRM3CtseA5x8CEYBXlNHgWXvAKbGXIsAA/gu
	 Xa0Fqd15d9jg+hYsG1qBXuQTVQ0sMFFf4P11j49RIPhSdO1tDsxztAwiwoVUgrGKzk
	 pOECFZNuEZ0zDCypa8ddo0OgVNvctaXSGCBiY6BFqfGmPlJTitYba34j3mvl91Ix4V
	 00Mngs9rJ+gEA==
Date: Wed, 26 Mar 2025 17:46:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Michal Simek <michal.simek@amd.com>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250326-bulge-outdated-9787da68e2d3@spud>
References: <20250326140930.2587775-1-lukma@denx.de>
 <20250326-unluckily-consuming-948176031b08@spud>
 <20250326184240.77e2bdc9@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yl3CyDHqrp4WjMsc"
Content-Disposition: inline
In-Reply-To: <20250326184240.77e2bdc9@wsk>


--Yl3CyDHqrp4WjMsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 06:42:40PM +0100, Lukasz Majewski wrote:
> Hi Conor,
>=20
> > On Wed, Mar 26, 2025 at 03:09:30PM +0100, Lukasz Majewski wrote:
> > > The measurement device on Liebherr's (LWE) boards is used to monitor
> > > the overall state of the device. It does have SPI interface to
> > > communicate with Linux host via spidev driver. Document the SPI DT
> > > binding as trivial SPI device.
> > >=20
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > --- =20
> >=20
> > You should not do a resend with no explanation as to why.
> > Additionally, I would like to know why my review on the original
> > patch was ignored:
> > https://lore.kernel.org/all/20250225-despair-rural-dc10216005f4@spud/#t
> >=20
>=20
> I've made a mistake, as I've used the lwe prefix, which is the
> different branch office for Liebherr.
>=20
> As we discussed last time - it would be better to use the already
> present 'lwn' vendor prefix as several other boards from this company
> use it (display5, bk4, xea, btt3).
>=20
> And this was apparent, after I've resent the patches. My mistake.
>=20
> Regarding the comment - on xea, btt the binding would be used, as those
> two boards (based on imx287) are using it.
>=20
> Hence, single "trivial device" would be OK.
>=20
> The v2 of this patch has the proper 'lwn,btt' binding.

I'm sorry, I don't understand how this excuses using the same binding
for different devices.

>=20
> > Cheers,
> > Conor.
> >=20
> > >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml
> > > b/Documentation/devicetree/bindings/trivial-devices.yaml index
> > > fadbd3c041c8..5d736a9792c2 100644 ---
> > > a/Documentation/devicetree/bindings/trivial-devices.yaml +++
> > > b/Documentation/devicetree/bindings/trivial-devices.yaml @@ -161,6
> > > +161,8 @@ properties:
> > >            - jedec,spd5118
> > >              # Linear Technology LTC2488
> > >            - lineartechnology,ltc2488
> > > +            # Liebherr on-board measurement SPI device
> > > +          - lwe,btt
> > >              # 5 Bit Programmable, Pulse-Width Modulator
> > >            - maxim,ds1050
> > >              # 10 kOhm digital potentiometer with I2C interface
> > > --=20
> > > 2.39.5
> > >  =20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de



--Yl3CyDHqrp4WjMsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+Q9XQAKCRB4tDGHoIJi
0h2EAQCtHAspmSeIMv0bfc17rjv+/wePOahWdhJzt2xkacVzjgD+JgQw9YzOzQpn
ni6zbB+nRvC/h+K+UsNkvkNhg5sKUg0=
=iOsA
-----END PGP SIGNATURE-----

--Yl3CyDHqrp4WjMsc--

