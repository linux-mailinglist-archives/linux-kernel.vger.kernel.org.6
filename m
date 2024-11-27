Return-Path: <linux-kernel+bounces-423706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC289DABB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1227C280F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E9200B99;
	Wed, 27 Nov 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEdy+yMw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D962CCC0;
	Wed, 27 Nov 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724643; cv=none; b=iQp1xDT+pU3APkMRuxyzClGtHuKEGxemfR9Rbtz9TJmc/mSLImhPtv4+kx3AxEbebPeCZK1srI9mS+gQ/NpOmrwyn8GsX4efuBKPwt/2+uZQpMhyoXQ27U01tyecNX881aByfzLn/UtfotTxlIh18BYFoLjt8E+xAb24q7fP7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724643; c=relaxed/simple;
	bh=udtlpz3tEcbApivtbF+WFTwB2TmLD0gnoCjWl9TRfMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3y6hKFJF1E9+IH1XwVvhry46+suZCiG0d/mCcrYQ4zWzRhHUD/5o9YkZFbS191cGDM8qorQd7cW4CS71R/ypzAKHkomkQrnUgDNzpv6hAO2LiTYxWgCG00pgjHn4as+hw9DUmc0KjP9LaFq+HUL294nsB6SXVy73H+43uilf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEdy+yMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A38C4CECC;
	Wed, 27 Nov 2024 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724643;
	bh=udtlpz3tEcbApivtbF+WFTwB2TmLD0gnoCjWl9TRfMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iEdy+yMwJNPcRsJ3zI0ESXkzdU3UZahNeW8N6y+xU8hSJhMM9cJQ2SchBQoNyf9LH
	 WopgHitWxqX131k+5F8HTJbHlkQ9Be/Hbs5lIyaeSRVWP7Lp81UKhts6L/Z1MirigU
	 L0PhLJs6YvAdkZ3WI9/6R9R/0QvZ6/AMFxlgJnBXYVyNcpKlEY4IarmOhxj+7pGt2y
	 yLdi+TnJS74VgH/cF1Kok2pjlhAWr4M0MN+ru/T2D1I47apsXjl0FvQGoBrDp2V4dJ
	 b6SbC3kE+VB6+5XeIixYsbMnJItReDz+22UbvrhyYJjhPcHBM1jpNky/+Zo5WrWmB7
	 EbLGbYUOvyzSA==
Date: Wed, 27 Nov 2024 16:23:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: Add Rockchip MIPI C-/D-PHY
 schema
Message-ID: <20241127-impromptu-tiptoeing-6c1b9ed2c93f@spud>
References: <20241126131736.465111-1-heiko@sntech.de>
 <20241126131736.465111-2-heiko@sntech.de>
 <20241126-pastrami-gusty-8b9df32ae00c@spud>
 <2213231.Mh6RI2rZIc@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/LUGouHf4SBUTfca"
Content-Disposition: inline
In-Reply-To: <2213231.Mh6RI2rZIc@diego>


--/LUGouHf4SBUTfca
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 07:38:35PM +0100, Heiko St=FCbner wrote:
> Hey Conor,
>=20
> Am Dienstag, 26. November 2024, 18:44:14 CET schrieb Conor Dooley:
> > On Tue, Nov 26, 2024 at 02:17:34PM +0100, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > >=20
> > > Add dt-binding schema for the MIPI C-/D-PHY found on
> > > Rockchip RK3588 SoCs.
> > >=20
> > > Tested-by: Daniel Semkowicz <dse@thaumatec.com>
> > > Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > > ---
> > >  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 87 +++++++++++++++++=
++
> > >  1 file changed, 87 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk=
3588-mipi-dcphy.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mi=
pi-dcphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-=
dcphy.yaml
> > > new file mode 100644
> > > index 000000000000..c8ff5ba22a86
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcph=
y.yaml
> > > @@ -0,0 +1,87 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.ya=
ml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rockchip MIPI D-/C-PHY with Samsung IP block
> > > +
> > > +maintainers:
> > > +  - Guochun Huang <hero.huang@rock-chips.com>
> > > +  - Heiko Stuebner <heiko@sntech.de>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - rockchip,rk3576-mipi-dcphy
> > > +      - rockchip,rk3588-mipi-dcphy
> >=20
> > How many phys do each of these SoCs have?
>=20
> - rk3588 has two - each with a separate GRF for additional settings [0]
> - rk3576 has one
>=20
>=20
> Heiko
>=20
> [0] https://lore.kernel.org/lkml/D5F5C1RWVHG5.TSHPO29TXYEF@cknow.org/T/
> The register layout in each GRF area is identical, but each DC-PHY gets
> its own separate GRF io-mem block.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/LUGouHf4SBUTfca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0dHnQAKCRB4tDGHoIJi
0sKHAQDyRrsdu04AIYeIKa/yoWGVW61Dgmc8zuF3PJhupjpSvwD/aP5gCI9OX1aZ
S3VqhYXp9SVFwvFVnquSYL7+DHuA3gc=
=nL8k
-----END PGP SIGNATURE-----

--/LUGouHf4SBUTfca--

