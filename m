Return-Path: <linux-kernel+bounces-424551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0979DB5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BB7160E40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC78D13B7BC;
	Thu, 28 Nov 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLmuCLCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2115383C;
	Thu, 28 Nov 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789764; cv=none; b=fQGaZU9HByhSAid1tY/Ho6qtwy3Rv53hFqgHpAzXxn6bGm7iRWfEze0e0qeB5vjD//Hg0zY5eY2ZKIMrHM9zazQtVZ8iJ2mzlu3XlJR+bp09uQU0ockjT0pd+PWnDrXDJ+EpzXy45BvncIVeLYmAkTldgCoIXSw7qFYUSlWo2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789764; c=relaxed/simple;
	bh=UN9E/IslKJJ6kXg07JlJB5mwNZgSYgjjqJXv+tdg8to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAZPUR4dCzkw/JtKueI8fqDPgLojFlKut2gq8ij9FrLgdaWHMbhmNg/MTDSH99E9l4h127OS9xxjaRNdRtLCEBktAH/1gsoLTs6OHEN9ByfmYQy9RLLSZGhvGshU/hwvdlEMUFSzTpfo5fnXwGzaRJrimlnGwoe0FoyJa9evNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLmuCLCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C5CC4CECE;
	Thu, 28 Nov 2024 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732789763;
	bh=UN9E/IslKJJ6kXg07JlJB5mwNZgSYgjjqJXv+tdg8to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLmuCLCjnYq+kiQoVtx+OI6vriP/NyPLzBqvfhzYve/l4WNpbc1wYdDQssVor5zdt
	 p5KtJ1sm9eTKXSYshjV2SkAmRd2LCrMJwq890kcxask80KqdRBvGJ7ABwVAP42ztkp
	 kh0u1amEpZ7e+XlAmgQYbDL3QhpVrbm7sHWPw7dJAaVUEZc6Og232TsDsyV5Y2BBsJ
	 T7lrV9F+V1tHkasuVo5nhpjqYgLc7V4P3enqP+dX4UXJwbqeb5uQZhUZ/Xmn7l8aWx
	 1XsM9pjx8udc9EV2jBiSUdvch42d6NKcruq7zzYhGoMRw04jX4HlIjkWokSNcZTWQ8
	 fB+i97A77k18w==
Date: Thu, 28 Nov 2024 11:29:20 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: Rob Herring <robh@kernel.org>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, marex@denx.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: drm/bridge: ti-sn65dsi83: Add optional
 property ti,lvds-vcom
Message-ID: <20241128-mottled-nostalgic-oriole-be31ce@houat>
References: <20241127103031.1007893-1-andrej.picej@norik.com>
 <20241127103031.1007893-2-andrej.picej@norik.com>
 <20241127151630.GA3515396-robh@kernel.org>
 <3b5768e5-dcb6-436d-837c-418676e13b2e@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="tvgn3pzm6x2sclac"
Content-Disposition: inline
In-Reply-To: <3b5768e5-dcb6-436d-837c-418676e13b2e@norik.com>


--tvgn3pzm6x2sclac
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] dt-bindings: drm/bridge: ti-sn65dsi83: Add optional
 property ti,lvds-vcom
MIME-Version: 1.0

On Thu, Nov 28, 2024 at 09:46:33AM +0100, Andrej Picej wrote:
> On 27. 11. 24 16:16, Rob Herring wrote:
> > On Wed, Nov 27, 2024 at 11:30:29AM +0100, Andrej Picej wrote:
> > > From: Janine Hagemann <j.hagemann@phytec.de>
> > >=20
> > > Add an optional property to change LVDS output voltage. This depends =
on
> > > the connected display specifications. With this property we directly =
set
> > > the LVDS_VCOM (0x19) register.
> > > Better register property mapping would be quite tricky. Please check
> > > bridge's datasheet for details on how register values set the LVDS
> > > data lines and LVDS clock output voltage.
> > >=20
> > > Signed-off-by: Janine Hagemann <j.hagemann@phytec.de>
> > > Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> > > ---
> > >   .../bindings/display/bridge/ti,sn65dsi83.yaml      | 14 +++++++++++=
++-
> > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65=
dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.=
yaml
> > > index 48a97bb3e2e0..5b2c0c281824 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.y=
aml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.y=
aml
> > > @@ -58,6 +58,12 @@ properties:
> > >                     - const: 2
> > >                     - const: 3
> > >                     - const: 4
> > > +              ti,lvds-vcom:
> > > +                $ref: /schemas/types.yaml#/definitions/uint32
> > > +                description: LVDS output voltage configuration. This=
 defines
> > > +                  LVDS_VCOM (0x19) register value. Check bridge's da=
tasheet for
> > > +                  details on how register values set the LVDS data l=
ines and
> > > +                  LVDS clock output voltage.
> >=20
> > Constraints? 0 - 2^32 are all valid values?
>=20
> Not really, only first 6 bits, which also means that this can be uint8 th=
en.
> Will fix with other issues.

Also, generally speaking directly using register values is really
frowned upon, even more so when they match a value expressed in a
standard unit.

Maxime

--tvgn3pzm6x2sclac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0hF9wAKCRAnX84Zoj2+
dhSoAX9Uu3UcKpopfFbkrgWp56OEJeL/hrbtsgKELqjxdDABI0ujjZDWXpMg1rM8
FxDYFLkBgMOgSjdgLtFASjWYBF1ZOJauobTk1LyMFCHiK30f0SS5gjfI+r7wL/pr
FqWXHi0wAw==
=sZjc
-----END PGP SIGNATURE-----

--tvgn3pzm6x2sclac--

