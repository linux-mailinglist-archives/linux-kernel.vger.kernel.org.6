Return-Path: <linux-kernel+bounces-558400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1BA5E56B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392F13BBA6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545101EDA17;
	Wed, 12 Mar 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vfm0qvrl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6C1C695;
	Wed, 12 Mar 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811501; cv=none; b=lARHKMkxa5ETfQVE4BX8yflr4EcCPy6JkVfxfz1I3gtvbdatEotRlww15W9MrjAk/OItXufRtqXFVLcpnrJLKIMNPMLnurmJyn8F48QoPAKWjoO+9egqSaSO9RXylEeWD26d0gX7fpB1jwVb72wmDMXepK/R06H6Veg9UWD2EVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811501; c=relaxed/simple;
	bh=41vo/KySPmn6lx+PkucgbBzu2sRozu+C1kAa0ZRPpYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1QfEhfcOF/gxBMgz13tQD07tO6Y9d7LhhP5G7ZiS3xkmIdIVr2CkdjIiguGDSkgDXVLT19M5YAUXUJWdIq1j/Whipft/R8lvAS/GFRCmr68DqMbM1oAsoqOuiSM+gldzEUu6dbOS4M2oBvVxTXas9O45RgF7n680wfcnMX7T4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vfm0qvrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4E3C4CEDD;
	Wed, 12 Mar 2025 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811501;
	bh=41vo/KySPmn6lx+PkucgbBzu2sRozu+C1kAa0ZRPpYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vfm0qvrl1PTl6ELOTIl5Vfo5FYI8TJXR2n1OwVzOt3GGHrxVTl2O0D8GpUuiJUUmO
	 o0RVLfNkmAh6VqMNgSm7boxgWK25rDly5F88OxB37LMGFDhmeD2HRcn9OyDUz4nXV0
	 tOUX9fnXz8trjH/SY/SmD6GR0302+2O96e9zYziwxjH0A9BVkMIr8oRZ0tYgTggPNq
	 rmxzl0B96DpJcWdAJ3ulbEgTGiAXKMmzjOpJFh+EDYC1wev6pGLboguTMygQnmntmO
	 W7z3hz3DMuw5hrYfbkUHd16PbSKHFKh3oNUpnsyJ0ykZkSVmYqMNHoKHyPNhasGNc2
	 L+M8lVw71daKg==
Date: Wed, 12 Mar 2025 20:31:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	zelong dong <zelong.dong@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible for Amlogic
 A4/A5 Reset Controller
Message-ID: <20250312-atlas-paver-0f0e888a641b@spud>
References: <20240918074211.8067-1-zelong.dong@amlogic.com>
 <20240918074211.8067-2-zelong.dong@amlogic.com>
 <a5d9b775dd860d8f2bbf174300a2e3161b654035.camel@pengutronix.de>
 <20240918-delirious-skiing-224172be96d4@squawk>
 <84612c6b-621d-47cc-8a2e-41d1fa42f0fe@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ol8p5/GlP6j3ZPQ"
Content-Disposition: inline
In-Reply-To: <84612c6b-621d-47cc-8a2e-41d1fa42f0fe@amlogic.com>


--7ol8p5/GlP6j3ZPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 05:48:26PM +0800, Kelvin Zhang wrote:
>=20
>=20
> On 2024/9/18 16:01, Conor Dooley wrote:
> > On Wed, Sep 18, 2024 at 09:51:28AM +0200, Philipp Zabel wrote:
> > > On Mi, 2024-09-18 at 15:42 +0800, zelong dong wrote:
> > > > From: Zelong Dong<zelong.dong@amlogic.com>
> > > >=20
> > > > Add new compatible for Amlogic A4/A5 Reset Controller
> > > >=20
> > > > Signed-off-by: Zelong Dong<zelong.dong@amlogic.com>
> > > > Acked-by: Conor Dooley<conor.dooley@microchip.com>
> > > > ---
> > > >   .../bindings/reset/amlogic,meson-reset.yaml   | 23 ++++++++++++--=
-----
> > > >   1 file changed, 15 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-=
reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.ya=
ml
> > > > index 695ef38a7bb3..0ad81fe7b629 100644
> > > > --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.y=
aml
> > > > +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.y=
aml
> > > > @@ -12,14 +12,21 @@ maintainers:
> > > >   properties:
> > > >     compatible:
> > > > -    enum:
> > > > -      - amlogic,meson8b-reset # Reset Controller on Meson8b and co=
mpatible SoCs
> > > > -      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and co=
mpatible SoCs
> > > > -      - amlogic,meson-axg-reset # Reset Controller on AXG and comp=
atible SoCs
> > > > -      - amlogic,meson-a1-reset # Reset Controller on A1 and compat=
ible SoCs
> > > > -      - amlogic,meson-s4-reset # Reset Controller on S4 and compat=
ible SoCs
> > > > -      - amlogic,c3-reset # Reset Controller on C3 and compatible S=
oCs
> > > > -      - amlogic,t7-reset
> > > > +    oneOf:
> > > > +      - items:
> > > I'm not well versed in preferred dt-bindings style, but this items
> > > looks superfluous to me. It only contains a single enum.
> > Oh, ye. Good spot.
>=20
> Hello Philipp, Conor,
> Sorry for the late reply.
>=20
> Do you mean to use 'amlogic,meson-s4-reset' for A4 and A5 directly, witho=
ut
> the fallback?

No. We are saying that

+      - items:
+          - enum:
+              - amlogic,meson8b-reset # Reset Controller on Meson8b and co=
mpatible SoCs

is pointless duplication, because your "items" list only has only
entry in it (the enum) and you could just remove the "- items" line
entirely and have the same outcome.

--7ol8p5/GlP6j3ZPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9HvKAAKCRB4tDGHoIJi
0oJpAQCsKqKP6v3C+sdG604jzHLY00nK6OL35eoqXRnTmr5GCAD9HlCWknv/XRWI
47FHk1nMft6eKA4MOUPvOV1L9ByGJgs=
=rvWA
-----END PGP SIGNATURE-----

--7ol8p5/GlP6j3ZPQ--

