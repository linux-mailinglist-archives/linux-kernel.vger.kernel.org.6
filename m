Return-Path: <linux-kernel+bounces-539223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472A4A4A233
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1713B581D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2C277032;
	Fri, 28 Feb 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgbdUUOQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC4277005;
	Fri, 28 Feb 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768773; cv=none; b=PAmsdSoafuHJm11ISeBkctnuUViiUJDVVrXmwOFqdbde8TYoOfLZnqj+XqT/54KDdXf+GGcmnwUx8hkf8B6HtpnGBRj5AdgrGLM0h/KZkDJ073jlgDHvkcF0ZjoGv+AJkKLgrtatjl+Ga8wY2dM77DW91oNxj5hLhpn/14D1XhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768773; c=relaxed/simple;
	bh=1e7rKwxHEfCCdW5vmqqYvzSiNhXj+nUn4vo5Y4eW1jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea3/lBPeOzrNYtQ81jWLtrPO5TkdGqOBksdyv5pD+BxaniRGkDEP5p/glOEgbGePClpJdfVouN9HMkzNoqjjWau/w6F0f254d4q6VZc0lKIWmv6nq8ZRHgiKh4D5f+2f3VkiOsN0QR4U28KMCRy1S+Kh6qSpyZDG9ADKJgru1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgbdUUOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DC0C4CED6;
	Fri, 28 Feb 2025 18:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740768773;
	bh=1e7rKwxHEfCCdW5vmqqYvzSiNhXj+nUn4vo5Y4eW1jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgbdUUOQOR0XB3V8zEBRw5MkyszFHVuMOdZnpMnONc1S6HMa5mLO+h3Aadp2C6Qq6
	 cb/5ftP+HABS+4jnHNsgJXQtVM5s6LjUDoNCghJRWnWDr6dwvm1gTq+Gch+YZePnoe
	 v9DznOaB4fW1ALLiirMXH9hh5I9b9fMaFoNCDzaeVhjk1BX5bftZutSVCpgO4OwY/E
	 vDh6KIKFBeWXdu7n19+ZgtWB7fviIadX4uZTxT4jnJqf1r9ShNdEfkF5xEsKAvW0Kg
	 SWl4CY+XWX5ztwUdL2yMveQZHFhYKMoZzOpZDgQYZ1VL0CdUNc3VDDIOFDrgNcIgcl
	 2YGliZOsmrmuA==
Date: Fri, 28 Feb 2025 18:52:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>,
	tglx@linutronix.de, gregkh@linuxfoundation.org, vigneshr@ti.com,
	nm@ti.com, s-vadapalli@ti.com, danishanwar@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
Message-ID: <20250228-recipient-unlinked-271fe63d7335@spud>
References: <20250227202206.2551305-1-c-vankar@ti.com>
 <20250227202206.2551305-2-c-vankar@ti.com>
 <f3e69904-92f0-4de8-bfef-a315a6554a1c@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OR8jQbuzxXN9cJUq"
Content-Disposition: inline
In-Reply-To: <f3e69904-92f0-4de8-bfef-a315a6554a1c@ti.com>


--OR8jQbuzxXN9cJUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 03:26:31PM -0600, Andrew Davis wrote:
> On 2/27/25 2:22 PM, Chintan Vankar wrote:
> > DT-binding of reg-mux is defined in such a way that one need to provide
> > register offset and mask in a "mux-reg-masks" property and corresponding
> > register value in "idle-states" property. This constraint forces to def=
ine
> > these values in such a way that "mux-reg-masks" and "idle-states" must =
be
> > in sync with each other. This implementation would be more complex if
> > specific register or set of registers need to be configured which has
> > large memory space. Introduce a new property "mux-reg-masks-state" which
> > allow to specify offset, mask and value as a tuple in a single property.
> >=20
> > Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> > ---
> >   .../devicetree/bindings/mux/reg-mux.yaml      | 29 +++++++++++++++++--
> >   1 file changed, 27 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Docum=
entation/devicetree/bindings/mux/reg-mux.yaml
> > index dc4be092fc2f..a73c5efcf860 100644
> > --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > @@ -32,11 +32,36 @@ properties:
> >           - description: pre-shifted bitfield mask
> >       description: Each entry pair describes a single mux control.
> > -  idle-states: true
> > +  idle-states:
> > +    description: Each entry describes mux register state.
> > +
> > +  mux-reg-masks-state:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    items:
> > +      items:
> > +        - description: register offset
> > +        - description: pre-shifted bitfield mask
> > +        - description: register value to be set
> > +    description: This property is an extension of mux-reg-masks which
> > +                 allows specifying register offset, mask and register
> > +                 value to be set in a single property.
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - reg-mux
> > +              - mmio-mux
>=20
> These are the only two possible compatibles, is this "if" check needed?

Aye.

> > +    then:
> > +      properties:
> > +        mux-reg-masks: true
> > +        mux-reg-masks-state: true
>=20
> You need one, but cannot have both, right? There should be some
> way to describe that.
>=20
> Also an example added below would be good.

=46rom the example schema:
# if/then schema can be used to handle conditions on a property affecting
# another property. A typical case is a specific 'compatible' value changes=
 the
# constraints on other properties.
#
# For multiple 'if' schema, group them under an 'allOf'.
#
# If the conditionals become too unweldy, then it may be better to just spl=
it
# the binding into separate schema documents.
allOf:
  - if:
      properties:
        compatible:
          contains:
            const: vendor,soc2-ip
    then:
      required:
        - foo-supply
    else:
      # If otherwise the property is not allowed:
      properties:
        foo-supply: false

What's missing from here is making one of the properties required,
so
oneOf:
  - required:
      - masks
  - required:
      - masks-state

>=20
> Andrew
>=20
> > +      maxItems: 1
> >   required:
> >     - compatible
> > -  - mux-reg-masks
> >     - '#mux-control-cells'
> >   additionalProperties: false

--OR8jQbuzxXN9cJUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8IGAAAKCRB4tDGHoIJi
0lF2AQDJiqWL1JjSAVC98Iawvw9CrPF//CU1S1l/JyAuagAOAwEAzqzmxvU0skcQ
VwzCqv0aGXmriL+nnznpS577bIz6Hwg=
=vD1d
-----END PGP SIGNATURE-----

--OR8jQbuzxXN9cJUq--

