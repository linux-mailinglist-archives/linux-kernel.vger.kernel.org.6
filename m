Return-Path: <linux-kernel+bounces-396933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691989BD489
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBAF4B20B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E741E7C2A;
	Tue,  5 Nov 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP6DyBP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33813D52E;
	Tue,  5 Nov 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831281; cv=none; b=B6Nhx+BNzVgGgKDRAIuJSlhn+E4DkuRcHvmQn6IY2R3VLbeDFnQ86YjB9uqBtJ/joXf06R0/6LAJWt+72OtTkgjAV3uRwrgs/c5gv3HofuHBCrjcKv15qo9/HyBhHQyDSt0QlAsSX8t3iwmNemJ0MX2AO7U5uX4ymZqF7iq6H+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831281; c=relaxed/simple;
	bh=jAP3GW7r+LYfHeNe78IMVIHvCpq6zsC+fpPsRxm+kUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk3eSFCehRjseSXPcRGX0hS3ZgUTNSoBCQo9o3S0yQMEKKw96HX7d1Z/1dyZPkPUCTrWxtVJZwMIRa7/t13Nj9/eRhwK67yI4GCvzLiT82S9AN9mPgC7/Tkb0w/TuHAc1lquLm1PL27Yo4/CPrauZv9yQpr3SFfXdyLh/+EOpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP6DyBP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0600AC4CECF;
	Tue,  5 Nov 2024 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730831280;
	bh=jAP3GW7r+LYfHeNe78IMVIHvCpq6zsC+fpPsRxm+kUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KP6DyBP6FYQuXObKCAicdrL3sNZf09qhW5mZxQneUWN2Ekru0Qs5FMLysQfPe8m8T
	 AhhzVSllmmE/5ESZuWqzYrB1aPD6ZO7Yj5FGMEQjBJgYYR2t9BF/NUQdQcMDdk8P60
	 QrB+FLOQ/LL3R+Z/OJiJ00QXA++FLM8jhf6jA60JAD6C6Zg8GhF0kA2TfKxH3DOi7b
	 23aWyNctjGRJEqkJx+1Vqa8R3g2Pbdfj+wkxyQPhMwGJtxT6uHTwPvUP77LMKJX3rT
	 CeAcPFs66EaIWxV8IULsfuI/TJgVrVpEvztyZ/npGUpBDBLDSez3PaHFiMb3bm2gDH
	 ie8pSdyXuD5xg==
Date: Tue, 5 Nov 2024 18:27:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: display: panel: Rename
 rg35xx-plus-panel back to WL-355608-A8
Message-ID: <20241105-maybe-chamomile-7505214f737e@spud>
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
 <20241105055239.1577275-2-kikuchan98@gmail.com>
 <20241105141900.GA3110982-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KWrKfl/izLTBZfq2"
Content-Disposition: inline
In-Reply-To: <20241105141900.GA3110982-robh@kernel.org>


--KWrKfl/izLTBZfq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 08:19:00AM -0600, Rob Herring wrote:
> On Tue, Nov 05, 2024 at 02:52:29PM +0900, Hironori KIKUCHI wrote:
> > A panel assembly is changed in the recent revision of Anbernic RG35XX
> > Plus, so the `anbernic,rg35xx-plus-panel` identifier is neither suitable
> > nor unique for the panel anymore.
> >=20
> > Fortunately, the panel can be distinguished by a label printed on the
> > FPC cable, so use the label "WL-355608-A8" as an identifier instead.
> >=20
> > Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> > ---
> >  ...rg35xx-plus-panel.yaml =3D> anbernic,wl-355608-a8.yaml} | 9 +++++--=
--
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >  rename Documentation/devicetree/bindings/display/panel/{anbernic,rg35x=
x-plus-panel.yaml =3D> anbernic,wl-355608-a8.yaml} (83%)
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,r=
g35xx-plus-panel.yaml b/Documentation/devicetree/bindings/display/panel/anb=
ernic,wl-355608-a8.yaml
> > similarity index 83%
> > rename from Documentation/devicetree/bindings/display/panel/anbernic,rg=
35xx-plus-panel.yaml
> > rename to Documentation/devicetree/bindings/display/panel/anbernic,wl-3=
55608-a8.yaml
> > index 1d67492ebd3..5e8afbea690 100644
> > --- a/Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-p=
lus-panel.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/anbernic,wl-35560=
8-a8.yaml
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >  %YAML 1.2
> >  ---
> > -$id: http://devicetree.org/schemas/display/panel/anbernic,rg35xx-plus-=
panel.yaml#
> > +$id: http://devicetree.org/schemas/display/panel/anbernic,wl-355608-a8=
=2Eyaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > =20
> >  title: Anbernic RG35XX series (WL-355608-A8) 3.5" 640x480 24-bit IPS L=
CD panel
> > @@ -16,13 +16,14 @@ allOf:
> >  properties:
> >    compatible:
> >      oneOf:
> > -      - const: anbernic,rg35xx-plus-panel
> > +      - const: anbernic,wl-355608-a8
> >        - items:
> >            - enum:
> >                - anbernic,rg35xx-2024-panel
> >                - anbernic,rg35xx-h-panel
> >                - anbernic,rg35xx-sp-panel
> > -          - const: anbernic,rg35xx-plus-panel
> > +              - anbernic,rg35xx-plus-panel
> > +          - const: anbernic,wl-355608-a8
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -47,7 +48,7 @@ examples:
> >          #size-cells =3D <0>;
> > =20
> >          panel@0 {
> > -            compatible =3D "anbernic,rg35xx-plus-panel";
> > +            compatible =3D "anbernic,wl-355608-a8";
>=20
> This is an ABI break. You can't just change compatibles.
>=20
> The old panel should correspond to the existing compatible. Add a new=20
> compatible for the new panel. The names might not be ideal, but you are=
=20
> stuck with them.
>=20
> There's exceptions if things are new and not yet in use, but you have to=
=20
> explain that in the commit msg.

We already had one faff over renaming this panel a few months ago:
d682eef93ebf ("dt-bindings: display: panel: Rename WL-355608-A8 panel to rg=
35xx-*-panel")
I don't agree with renaming it again.

--KWrKfl/izLTBZfq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZypjqwAKCRB4tDGHoIJi
0kZvAQDGlp5m873rhBYpE0YeWZx2FSdOgrOC4C1DUcYPF4TqsAD9EPDcRf3IgiHj
xIFBQes+LtwbDJ9M0Ycx3wE/F34rqQ8=
=gldU
-----END PGP SIGNATURE-----

--KWrKfl/izLTBZfq2--

