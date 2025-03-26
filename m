Return-Path: <linux-kernel+bounces-577511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC26BA71E13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24E01895BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD524EF8C;
	Wed, 26 Mar 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhVWxj0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0619E7E2;
	Wed, 26 Mar 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012566; cv=none; b=MWpSmTKPI7qtURM6/CGFf+oRHvy9jDKXufDmupkXlQTB2Hip7+mAwNen8iIhZgt6Xl6ZnL+gMvXECSQYP5WAhJyHYGPJlpQbs39ep2HD2TTYFziEHKAK0dkKyENNcRm1AmzS9LsW5CBKu1sLlzoEHJ9BuJGX1vIHfu4isX8plo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012566; c=relaxed/simple;
	bh=DyZC37BpernRq38cpRSS+1tvE9ZzaMZewkCDnXJtk1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mT9GDEI2d6/hqfosF9I6bh91rq9S6Y77z5/RtFddv5wVJrcA+lk8iZi+GYfSx6D8JExMk5v8Xb/KnDKLtqiRphNQUWyz/U972YJWWXbV44hW9nzeb35W8inTtWkiJg60+JbZNb1FoiEY/Zop+khjhsQ7N60uH3xaTmoz8BGvnwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhVWxj0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94025C4CEE2;
	Wed, 26 Mar 2025 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743012566;
	bh=DyZC37BpernRq38cpRSS+1tvE9ZzaMZewkCDnXJtk1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhVWxj0Ct6jtlBV0eOTmpsqI77Ng4krl5yaHgNeK4YmGVFaREBgWPCF1oZOkxqeV5
	 608tpeqma4zfJjWAgac4mwEGxIjq0WGl3AkjVn8TUIUkmTml5qZkdPk/q6b/JrDhGR
	 CbhXdHRMrcjZ69U9WGeeSxLI6gIMoyiHE+ylFESwIiPOZ798lDptjWN+m7xIpDIduY
	 vnDffboli5NbMLYkBqmEV2sZ4HMddsbhHKFdlfs7xxbZXmKyBFHWPa8WbcmncTlfRj
	 gJRCMY1qfwP1B6Aifwn9h+7kM/FkVDDYgSyTRnccnPuLTL/f/a1Y2lFPxaAIVmkEID
	 4yAnYriMHuYmg==
Date: Wed, 26 Mar 2025 18:09:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] dt-bindings: regulator: Add ROHM BD96802 PMIC
Message-ID: <20250326-candy-endocrine-2e7b2182e53b@spud>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
 <2cb4d103d011f0d4293f6ef9307cef57709263d9.1742802856.git.mazziesaccount@gmail.com>
 <20250325-universe-jigsaw-61da10ad3f77@spud>
 <f8b0553d-d74d-47c5-89f1-6c61ed0951bc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WSc6Zv3nIINNi2x4"
Content-Disposition: inline
In-Reply-To: <f8b0553d-d74d-47c5-89f1-6c61ed0951bc@gmail.com>


--WSc6Zv3nIINNi2x4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 08:15:05AM +0200, Matti Vaittinen wrote:
> Hi Conor,
>=20
> Thanks for taking a look at this :)
>=20
> On 25/03/2025 19:23, Conor Dooley wrote:
> > On Mon, Mar 24, 2025 at 10:54:44AM +0200, Matti Vaittinen wrote:
> > > BD96802Qxx-C is an automotive grade configurable Power Management
> > > Integrated Circuit supporting Functional Safety features for applicat=
ion
> > > processors, SoCs and FPGAs. BD96802 is controlled via I2C, provides t=
wo
> > > interrupt lines and has two controllable buck regulators.
> > >=20
> > > The BD96802 belongs to the family of ROHM Scalable PMICs and is inten=
ded
> > > to be used as a companion PMIC for the BD96801.
> > >=20
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > >=20
> > > ---
> > > Revision history:
> > >   v1 =3D> :
> > >    - No changes
> > > ---
> > >   .../regulator/rohm,bd96802-regulator.yaml     | 44 ++++++++++++++++=
+++
> > >   1 file changed, 44 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/regulator/rohm=
,bd96802-regulator.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96802=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96802-=
regulator.yaml
> > > new file mode 100644
> > > index 000000000000..671eaf1096d3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/regulator/rohm,bd96802-regula=
tor.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/regulator/rohm,bd96802-regulator.=
yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ROHM BD96802 Power Management Integrated Circuit regulators
> > > +
> > > +maintainers:
> > > +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > +
> > > +description:
> > > +  This module is part of the ROHM BD96802 MFD device. For more detai=
ls
> > > +  see Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml.
> > > +
> > > +  The regulator controller is represented as a sub-node of the PMIC =
node
> > > +  on the device tree.
> > > +
> > > +  Regulator nodes should be named to buck1 and buck2.
> >=20
> > Is it really needed to add a new binding for this, rather than including
> > it in the mfd binding,
>=20
> A valid question. I did this because that's what I've used with all the
> other PMIC's regulator bindings. All of these have MFD counterpart:
>=20
> rohm,bd71815-regulator.yaml
> rohm,bd71828-regulator.yaml
> rohm,bd71837-regulator.yaml
> rohm,bd71847-regulator.yaml
> rohm,bd9576-regulator.yaml
> rohm,bd96801-regulator.yaml
>=20
> Basically, none of the MFD bindings I've written for ROHM PMICs contain t=
he
> regulator descriptions.
>=20
> The thing is that users might be used to look for the regulator bindings
> from the regulator folder. I'd like to keep this consistent, especially w=
ith
> the BD96801 because the BD96802 is intended to be used together with it.
> (BD96802 is used as a companion PMIC for the BD96801 to extend it's
> capabilities).
>=20
> > particularly when this isn't actually a binding
> > for the regulator but the pattern section applies to the mfd.
>=20
> Hmmm? I am not sure I understand what you mean here. I know I am really b=
ad
> with the YAML and bindings, but if I read correctly what I've copied - the
> pattern section describes what is inside the 'regulators' node. I think t=
his
> is similar to what we have with the rest of the ROHM PMIC bindings. Should
> they all be somehow modified?

I just think it is weird to be honest, describing the contents of
regulators node, rather than the individual regulators themselves, but
if Rob and Krzysztof, which they seem to be, I will not object.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--WSc6Zv3nIINNi2x4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+RC0gAKCRB4tDGHoIJi
0g11AQDm+Ek8Qkj0AQXpAxogNSnb3nlSLz25Zh4fCd9GlJMSLwD8DXpz6Ac5Sw52
dHLpwGD9t7pM1gXv78/WB+o4KoLxUg0=
=DPO3
-----END PGP SIGNATURE-----

--WSc6Zv3nIINNi2x4--

