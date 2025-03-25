Return-Path: <linux-kernel+bounces-575842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA4A707D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E067A5053
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E225C716;
	Tue, 25 Mar 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7BnD04C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343692E339B;
	Tue, 25 Mar 2025 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922944; cv=none; b=BZFqQar/76tSKlbKTRSPCF3r7CXuIi5jXXVp3w57Km8KrXR0aBymRR3ugQuJMJcnx3jg+VoXRxvJayCjOvhCe/2HSwDPVoM//vTqMdtMWN1bnOXUHVtF5djBr6rHqwR9T0m+9Q7piKliAefi599+jWIcmg18zosife3kqox3c/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922944; c=relaxed/simple;
	bh=ZRWOy4XKqIlbIIye6lrErv1Tid8Lr6d1KEU6m2K46r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAxnTfVDAzMI7iEw+LVhjAgSqFudxHW0lZFUzYqCr9yysd8dVhe/IRggsG4hVqaZyeUJJwfkzOmLcjWA+fh4UXe0X7cVSnIKW4gcvMQ25n9VImTQoM/ese67WN/RoGRTkUFQzz2zhKrFdxd1yoiRT1KBWd4JgG3WX4xwWT2Aesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7BnD04C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A060DC4CEE4;
	Tue, 25 Mar 2025 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742922941;
	bh=ZRWOy4XKqIlbIIye6lrErv1Tid8Lr6d1KEU6m2K46r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7BnD04ChQumJZpC/lD3Zc/twU04E52ExANturrWT/LIddf7Aa40He5VCFknrPc98
	 ux66wL+lDck5Rz7xCXbVqYeyrfaCF/bJIT5oMl7LMNIOHuAGwLeGvHq28+k5DV4jAy
	 zhdTcjIYHvdFHmFA87EK7k6GP3rQwcczb+Jtg7+tjeYR29AKSR2SUwJBwdrvBp/CfN
	 xnIiMDjgWY0052VaWLbJm3o1g2+i7Y3v1XI7nj0xjek5NjGJ24xrYM2x64ShbqjDkL
	 bzCYfYgRWAa/4TSL+8wHhtkgQSLG5BFXvi8Z5Vx+iicjvOcd3JvOptwu2EK3/DizHl
	 7ONNI4VpOUQRw==
Date: Tue, 25 Mar 2025 17:15:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] dt-bindings: mfd: bd96801: Add ROHM BD96805
Message-ID: <20250325-stout-unsnap-40ce8f297269@spud>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
 <e220ff02f9f1727734999a9a0f7acbb5334522c0.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OapTcqKP835L4IiH"
Content-Disposition: inline
In-Reply-To: <e220ff02f9f1727734999a9a0f7acbb5334522c0.1742802856.git.mazziesaccount@gmail.com>


--OapTcqKP835L4IiH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 10:55:07AM +0200, Matti Vaittinen wrote:
> The ROHM BD96805 is very similar to the BD96801. The differences visible
> to the drivers is different tune voltage ranges.
>=20
> Add compatible for the ROHM BD96805 PMIC.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> ---
> Revision history:
>  v1 =3D> :
>   - No changes
> ---
>  .../devicetree/bindings/mfd/rohm,bd96801-pmic.yaml     | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml=
 b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
> index efee3de0d9ad..0e06570483ae 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
> @@ -4,19 +4,21 @@
>  $id: http://devicetree.org/schemas/mfd/rohm,bd96801-pmic.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: ROHM BD96801 Scalable Power Management Integrated Circuit
> +title: ROHM BD96801/BD96805 Scalable Power Management Integrated Circuit
> =20
>  maintainers:
>    - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> =20
>  description:
> -  BD96801 is an automotive grade single-chip power management IC.
> -  It integrates 4 buck converters and 3 LDOs with safety features like
> +  BD96801 and BD96805 are automotive grade, single-chip power management=
 ICs.
> +  They both integrate 4 buck converters and 3 LDOs with safety features =
like
>    over-/under voltage and over current detection and a watchdog.
> =20
>  properties:
>    compatible:
> -    const: rohm,bd96801
> +    enum:
> +      - rohm,bd96801
> +      - rohm,bd96805
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.49.0
>=20



--OapTcqKP835L4IiH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+LkuQAKCRB4tDGHoIJi
0hM8AP0ZeLn1d87pDJXL46TIwMAvuv4uhj1m3coJbVl/jgx0cgD+N/ddFHm+nqN2
/xq3fW3xLMt126tw5p4GGpsAbjV8PQk=
=Ly20
-----END PGP SIGNATURE-----

--OapTcqKP835L4IiH--

