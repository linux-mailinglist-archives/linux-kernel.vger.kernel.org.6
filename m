Return-Path: <linux-kernel+bounces-542394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E874A4C900
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4391A7A6733
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023FA216E39;
	Mon,  3 Mar 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k91CO6+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A53212B14;
	Mon,  3 Mar 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021112; cv=none; b=kYj9lrQtE6TAmzbfDSJm6pf4SVD9q/g+9VKY0ENS6Jeyr6Pii69lMrWb3gQlYZy+7Ypb4jF7W7i1pTfR64Iulk6q/GXKBGnJ7/2vhceiEYhMn3uPBhspnSreR2m9zDmZ417UM1pCnPArQGV3XOUnzsILhNKUfXvABMeB8mir/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021112; c=relaxed/simple;
	bh=vtkoHJ3gFGrir8hCO0gq2+nOrDMda467qqK7Y/SOhuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBIuZ5V8SWoTKo3NkueSN8mGgTd4/rkclUD6VUmzTPpvoNORqlrhiUGA1az6CTkiwK4lN1juVBdAyx9Cjo6ge0f6FPKg+NFWEh3kuFTHiuvVBagc5NyyeQIf3WhrXMIEqKpqGPvwsCbUsqnL+kBNf3hCiz8o+1vglJAgezfycqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k91CO6+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EE3C4CED6;
	Mon,  3 Mar 2025 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741021111;
	bh=vtkoHJ3gFGrir8hCO0gq2+nOrDMda467qqK7Y/SOhuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k91CO6+Pqty8oVF+U32HsX9iLmlu7s8wcKO1z8ACLrxTAYAPPC7c2asxfXVcIa0od
	 1dJwiAa7iJW/kjG9WN88+F9nm2DbU3V3+kOqfcxkdKyALTWHpE/YURL2u6/Wgd6aVj
	 ocOf9vo85msUco7AwjOEHhdBKVgZrAhqLmoBqe7vLlgZ8kFIWGKibLAdhoKNx3F8bS
	 ciVvGy+fuHKltu3uuuawm7L6CAlInsAj3f5yOba0VPUINb3mm0n7X4RK2ZYGSRTVWV
	 9A5KARmQMqVGXjfBmSd9EWzZOqEQoVXxeAXS5T7WmZzRxrXC6zzz/61rdIAoLD2ynW
	 sYAlcjAxL+vLQ==
Date: Mon, 3 Mar 2025 16:58:26 +0000
From: Conor Dooley <conor@kernel.org>
To: "Vankar, Chintan" <c-vankar@ti.com>
Cc: Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>,
	tglx@linutronix.de, gregkh@linuxfoundation.org, vigneshr@ti.com,
	nm@ti.com, s-vadapalli@ti.com, danishanwar@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
Message-ID: <20250303-mummify-mutation-67595b7ceba5@spud>
References: <20250227202206.2551305-1-c-vankar@ti.com>
 <20250227202206.2551305-2-c-vankar@ti.com>
 <f3e69904-92f0-4de8-bfef-a315a6554a1c@ti.com>
 <20250228-recipient-unlinked-271fe63d7335@spud>
 <acde31c5-fe23-4c7b-a823-61ea0958504b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F7cMXlJo73Y+j5qV"
Content-Disposition: inline
In-Reply-To: <acde31c5-fe23-4c7b-a823-61ea0958504b@ti.com>


--F7cMXlJo73Y+j5qV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2025 at 03:08:40AM +0530, Vankar, Chintan wrote:
> Hello Conor, Andrew,
>=20
> On 3/1/2025 12:22 AM, Conor Dooley wrote:
> > On Thu, Feb 27, 2025 at 03:26:31PM -0600, Andrew Davis wrote:
> > > On 2/27/25 2:22 PM, Chintan Vankar wrote:
> > > > DT-binding of reg-mux is defined in such a way that one need to pro=
vide
> > > > register offset and mask in a "mux-reg-masks" property and correspo=
nding
> > > > register value in "idle-states" property. This constraint forces to=
 define
> > > > these values in such a way that "mux-reg-masks" and "idle-states" m=
ust be
> > > > in sync with each other. This implementation would be more complex =
if
> > > > specific register or set of registers need to be configured which h=
as
> > > > large memory space. Introduce a new property "mux-reg-masks-state" =
which
> > > > allow to specify offset, mask and value as a tuple in a single prop=
erty.
> > > >=20
> > > > Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> > > > ---
> > > >    .../devicetree/bindings/mux/reg-mux.yaml      | 29 +++++++++++++=
++++--
> > > >    1 file changed, 27 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/D=
ocumentation/devicetree/bindings/mux/reg-mux.yaml
> > > > index dc4be092fc2f..a73c5efcf860 100644
> > > > --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > > > +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > > > @@ -32,11 +32,36 @@ properties:
> > > >            - description: pre-shifted bitfield mask
> > > >        description: Each entry pair describes a single mux control.
> > > > -  idle-states: true
> > > > +  idle-states:
> > > > +    description: Each entry describes mux register state.
> > > > +
> > > > +  mux-reg-masks-state:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > +    items:
> > > > +      items:
> > > > +        - description: register offset
> > > > +        - description: pre-shifted bitfield mask
> > > > +        - description: register value to be set
> > > > +    description: This property is an extension of mux-reg-masks wh=
ich
> > > > +                 allows specifying register offset, mask and regis=
ter
> > > > +                 value to be set in a single property.
> > > > +
> > > > +allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - reg-mux
> > > > +              - mmio-mux
> > >=20
> > > These are the only two possible compatibles, is this "if" check neede=
d?
> >=20
> > Aye.
> >=20
> > > > +    then:
> > > > +      properties:
> > > > +        mux-reg-masks: true
> > > > +        mux-reg-masks-state: true
> > >=20
> > > You need one, but cannot have both, right? There should be some
> > > way to describe that.
> > >=20
> > > Also an example added below would be good.
> >=20
> >  From the example schema:
> > # if/then schema can be used to handle conditions on a property affecti=
ng
> > # another property. A typical case is a specific 'compatible' value cha=
nges the
> > # constraints on other properties.
> > #
> > # For multiple 'if' schema, group them under an 'allOf'.
> > #
> > # If the conditionals become too unweldy, then it may be better to just=
 split
> > # the binding into separate schema documents.
> > allOf:
> >    - if:
> >        properties:
> >          compatible:
> >            contains:
> >              const: vendor,soc2-ip
> >      then:
> >        required:
> >          - foo-supply
> >      else:
> >        # If otherwise the property is not allowed:
> >        properties:
> >          foo-supply: false
> >=20
> > What's missing from here is making one of the properties required,
> > so
> > oneOf:
> >    - required:
> >        - masks
> >    - required:
> >        - masks-state
> >=20
> > >=20
> > > Andrew
>=20
> Thanks for reviewing this patch.
>=20
> For the use-case we have following three rules to be followed:
> 1. "mux-reg-masks" and "mux-reg-masks-state" should be mutually
>    exclusive.
> 2. "mux-reg-masks-state" and "idle-states" should also be mutually
>    exclusive.
> 3. If "mux-reg-masks" is present then "idle-states" might or might not
>    be there.
>=20
> For the above conditions I have tried to write a binding as:
>=20
> allOf:
>   - not:
>       required: [mux-reg-masks, mux-reg-masks-state]
>=20
>   - if:
>       required: [mux-reg-masks-state]
>     then:
>       not:
>         required: [idle-states]

Why'd you pick two different syntax here?
The normal syntax for mutual exclusion is:
if:
  required:
    - foo
then:
  properties:
    foobar: false


>=20

>   - if:
>       required: [mux-reg-masks]
>     then:
>       properties:
>         idle-states:
>           description: It can be present with mux-reg-masks, but not
> required

This one here is the default, I don't think it needs an if/else.


--F7cMXlJo73Y+j5qV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8XfsgAKCRB4tDGHoIJi
0o2LAQCMq4HpZu9jiaoJxc850JX+/MKfFHGz/sa7MSTRB+4e1gEA8Gz6xK4LVwXO
zTxykzZs4br3042xroq9jAGVObGABQA=
=bvpH
-----END PGP SIGNATURE-----

--F7cMXlJo73Y+j5qV--

