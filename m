Return-Path: <linux-kernel+bounces-575840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3B7A707D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1715A1886400
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13725F999;
	Tue, 25 Mar 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgjUb+Qy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037002E339B;
	Tue, 25 Mar 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922888; cv=none; b=cxCJqahr0GYfNi3u4KO/CD2JsBp8lKlWMG7rfE6VdvJCxjHVdjBaMqNgftGHyfLcbidLUu0zIhUzSUXa1ZlJo+OrvlCoSJGagBVbKjSil8sOHqLWPj7A4BSr15qPzOQhS12tZ/uTfmbaCI4z33r70QOMyEpq0fnGsVxUCluckRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922888; c=relaxed/simple;
	bh=ijgyDEwMxfU8RhoSiM083JV3wsc9bFDWhCPR2Ky1aKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpDz3RsMviZIsTfme9GCNQuQWWpIroJR9TgJN1s1pFZMCiTzf29HnQihwx2EsA03VurQY+EdB6KYFyC1tOyO5WQdrF+6bxW5n4jZ7EZBRL878av6MJWUVv2qJF6JBmKVg7dl9SAn/hmnZf1qrhoJryPhx4pCZbUJJRi2kemN4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgjUb+Qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D92C4CEE4;
	Tue, 25 Mar 2025 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742922887;
	bh=ijgyDEwMxfU8RhoSiM083JV3wsc9bFDWhCPR2Ky1aKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgjUb+QyxN1/l8wdusIvMY6/5jGB+S0lkgcJ0fULQe+9vM85087AcH62QkeLzyItp
	 vrOiVZ1HRhVRBylYjDxZjdnfwKmnSwgXrO1z+VMv1ZdJjeVjMbdg4Cz4tUaCk/JzFM
	 5X0yNpoNin4AJoBf6S6W2u9rN3UWy55oxYLLEsQf6mSgbgqhXkImTNp/8iuTEEhz0/
	 RlWT3jH5GRMBIfpCrXyKRg0ryFqo1PUZ+SgfaaxiNqX+QG/OO1DY38huqyeK6clvza
	 i9CKuH3Fbq+JxY6hOC141LDTiPeXmZAOrzTP6+MkuQJ9QNkSmFDrQILLvoqou9D6Jm
	 SiKs+R9VjAc1w==
Date: Tue, 25 Mar 2025 17:14:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] dt-bindings: mfd: bd96802: Add ROHM BD96806
Message-ID: <20250325-resent-presuming-39ad42e2ceef@spud>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
 <99ffe94d642b6c73cd5199103e65419c93214533.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P4JHdL5AJMMqX7bn"
Content-Disposition: inline
In-Reply-To: <99ffe94d642b6c73cd5199103e65419c93214533.1742802856.git.mazziesaccount@gmail.com>


--P4JHdL5AJMMqX7bn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 10:55:21AM +0200, Matti Vaittinen wrote:
> The ROHM BD96806 is very similar to the BD96802. The differences visible
> to the drivers is different tune voltage ranges.
>=20
> Add compatible for the ROHM BD96805 PMIC.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
> Revision history:
>  v1 =3D> :
>   - No changes
> ---
>  .../bindings/mfd/rohm,bd96802-pmic.yaml       | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml=
 b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
> index d5d9e69dc0c2..c6e6be4015b2 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
> @@ -4,23 +4,23 @@
>  $id: http://devicetree.org/schemas/mfd/rohm,bd96802-pmic.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: ROHM BD96802 Scalable Power Management Integrated Circuit
> +title: ROHM BD96802 / BD96806Scalable Power Management Integrated Circuit
                                ^ Missing space here :)

> =20
>  maintainers:
>    - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> =20
>  description: |
> -  BD96802Qxx-C is an automotive grade configurable Power Management
> -  Integrated Circuit supporting Functional Safety features for applicati=
on
> +  BD96802Qxx-C and BD96806 are automotive grade configurable Power Manag=
ement
> +  Integrated Circuits supporting Functional Safety features for applicat=
ion
>    processors, SoCs and FPGAs
> =20
>  properties:
>    compatible:
> -    const: rohm,bd96802
> +    enum:
> +      - rohm,bd96802
> +      - rohm,bd96806
> =20
>    reg:
> -    description:
> -      I2C slave address.

I'd just drop this from the original.

>      maxItems: 1
> =20
>    interrupts:
> @@ -29,7 +29,8 @@ properties:
>        for fatal IRQs which will cause the PMIC to shut down power output=
s.
>        In many systems this will shut down the SoC contolling the PMIC and
>        connecting/handling the errb can be omitted. However, there are ca=
ses
> -      where the SoC is not powered by the PMIC. In that case it may be
> +      where the SoC is not powered by the PMIC or has a short time backup
> +      energy to handle shutdown of critical hardware. In that case it ma=
y be
>        useful to connect the errb and handle errb events.
>      minItems: 1
>      maxItems: 2
> @@ -69,7 +70,7 @@ examples:
>              interrupt-names =3D "intb", "errb";
> =20
>              regulators {
> -                buck1: BUCK1 {
> +                buck1 {

Here too?

>                      regulator-name =3D "buck1";
>                      regulator-ramp-delay =3D <1250>;
>                      /* 0.5V min INITIAL - 150 mV tune */
> @@ -84,7 +85,7 @@ examples:
>                      regulator-temp-protection-kelvin =3D <1>;
>                      regulator-temp-warn-kelvin =3D <0>;
>                  };
> -                buck2: BUCK2 {

and here?

> +                buck2 {
>                      regulator-name =3D "buck2";
>                      regulator-min-microvolt =3D <350000>;
>                      regulator-max-microvolt =3D <3450000>;
> --=20
> 2.49.0
>=20



--P4JHdL5AJMMqX7bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+LkgwAKCRB4tDGHoIJi
0tvOAQCCtP77GM6oCnLZ3/mADX1SzaGiK5rmCbR+sWUFVC05RgD/WytAb12sgbdX
PDvAIfPog1DUFf4Wvnix1Pqqe171nQg=
=8iSv
-----END PGP SIGNATURE-----

--P4JHdL5AJMMqX7bn--

