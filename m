Return-Path: <linux-kernel+bounces-332366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF697B8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260A21F2166C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3E16E89B;
	Wed, 18 Sep 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIdJRJWZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C83D8E;
	Wed, 18 Sep 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646502; cv=none; b=X2hZQ8Weu7Zjtk3bzlBLDxmIQmH2YTs0y8RytPkN5dWNzjxqTRmhNyCBUJ6zKlRXbRYbtxEbuxpL57JspzAD0rjuJne1o3GxgLNv/L0r/1a6hKrxtXoJW6K5HgZeNgo5OjujkyhLqDLQyv+M7oGhUU7ivCXxOCNKWNu3oJi3TyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646502; c=relaxed/simple;
	bh=d/mNhRT2jbPpZjm3XFtiSJ/CpRq/tuV7or+IN8D2Kc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbKKQlXM6XmH+IgfS03/NbiAidthxVwH8BLN2pMfptCM72+9rgB//eZLKjdjnOJx2EiYBZ2hv8WhYQwhiByodAc99JPJ0d8XuhKp/X9lB8ipP7wCs6+SlJVHXAVnYQ5Mg8QrlrcesTJPqNhHd0cBjNQCUw3/MnaDbsx/SVYSGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIdJRJWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA670C4CEC3;
	Wed, 18 Sep 2024 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726646501;
	bh=d/mNhRT2jbPpZjm3XFtiSJ/CpRq/tuV7or+IN8D2Kc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIdJRJWZIEe70hqBRVKP35K+nKGGEDiDalTfZlNCCJpmmTuE3p2sapOgATZqNDHA9
	 0z0SsozHzbAlenbZZabAQKjwpPDvoZW8xH2B1yRZtkNUIVXYYdjssmMgZYlWYqfXti
	 NwzV75IGdrY9YHGABj7fgg/iIbfQUp6nqrfjdh7ArZt2BID5Ye4LQvTcWCwW4E1Fid
	 xXzG+GJWX9rpV6AlXoShB9/mAIrteZKKrBHOSkfPMXuE9fB22hKiEzKnv6PKbVtiEz
	 nUH0rC2+MIKMGqRpyN5LjzxNMTA5ew+lFE5pMxFz2ZEwvv5ifWDgPS0Wz/I02koETb
	 4rJy0itsPLRQg==
Date: Wed, 18 Sep 2024 09:01:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: zelong dong <zelong.dong@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	kelvin.zhang@amlogic.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible for Amlogic
 A4/A5 Reset Controller
Message-ID: <20240918-delirious-skiing-224172be96d4@squawk>
References: <20240918074211.8067-1-zelong.dong@amlogic.com>
 <20240918074211.8067-2-zelong.dong@amlogic.com>
 <a5d9b775dd860d8f2bbf174300a2e3161b654035.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1OdrIj4eisHBYHwH"
Content-Disposition: inline
In-Reply-To: <a5d9b775dd860d8f2bbf174300a2e3161b654035.camel@pengutronix.de>


--1OdrIj4eisHBYHwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 09:51:28AM +0200, Philipp Zabel wrote:
> On Mi, 2024-09-18 at 15:42 +0800, zelong dong wrote:
> > From: Zelong Dong <zelong.dong@amlogic.com>
> >=20
> > Add new compatible for Amlogic A4/A5 Reset Controller
> >=20
> > Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/reset/amlogic,meson-reset.yaml   | 23 ++++++++++++-------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-rese=
t.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> > index 695ef38a7bb3..0ad81fe7b629 100644
> > --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> > +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> > @@ -12,14 +12,21 @@ maintainers:
> > =20
> >  properties:
> >    compatible:
> > -    enum:
> > -      - amlogic,meson8b-reset # Reset Controller on Meson8b and compat=
ible SoCs
> > -      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compat=
ible SoCs
> > -      - amlogic,meson-axg-reset # Reset Controller on AXG and compatib=
le SoCs
> > -      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible=
 SoCs
> > -      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible=
 SoCs
> > -      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
> > -      - amlogic,t7-reset
> > +    oneOf:
> > +      - items:
>=20
> I'm not well versed in preferred dt-bindings style, but this items
> looks superfluous to me. It only contains a single enum.

Oh, ye. Good spot.

--1OdrIj4eisHBYHwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuqI5QAKCRB4tDGHoIJi
0oRfAQC14rdH8axKMoQQHMpS4dcHTaZa/tZa3EPK4RdqiD+vzQEAgz5WGX3k9kGY
EV3ERmLmeSSRCW0DYza8jgbDPMC5tgQ=
=IxkZ
-----END PGP SIGNATURE-----

--1OdrIj4eisHBYHwH--

