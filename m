Return-Path: <linux-kernel+bounces-575852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57271A7080D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21523AB724
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3025F783;
	Tue, 25 Mar 2025 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBu/ekpS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D52E3387;
	Tue, 25 Mar 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923384; cv=none; b=S9hH6yW5L0vSX88O+7OaN0vLY92akEEGchLdjjFrl1VEftjDeyWr8055zEEn/Ma4iC2QOEmScaekwZ0MMiKsyEIi/wuUbnHWtqYpjmzQr9xCQIvXTh3JeH9NwpGtwiVc7OXWiqT5hqMdNDjYbcOIX2z6OvayTz2PDoZ5NehoXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923384; c=relaxed/simple;
	bh=tdpAAh+GOKYtqIhZ1RtVRehyfxTqXq+fJX7nN8hRojc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb+wi2u6b3L2RYGw41Lagpy/zdCQKyvbasQBGkmhjseo+9OEpv6CAGLhYyIIlXGYBEp8NwXi/tNmcB4qKKty8LaS4mV2PaDfHVmrUp9s/iEmoR+fGmJL9DZmJqiVIkMT/PdxoxItP5x5eaaBXyrIVFYiLt9fW4OEzL/HnTtNUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBu/ekpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61580C4CEE4;
	Tue, 25 Mar 2025 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742923384;
	bh=tdpAAh+GOKYtqIhZ1RtVRehyfxTqXq+fJX7nN8hRojc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBu/ekpSLgvRCL1/Km5faa7bibk0xOJBCUZmQzYgWRR/AZAlCnngp5feZSXORaZx8
	 GRc7p861/6x9PkdvVySUtsZ1f8pbNl4Q+j+6/NM+jKGC/vUHT3Whq1gc6adztpDJX0
	 Aq5O7LolMfuZUuBZl/Ibd1TwmbXGI4PXn7R2iqmyZ3AHlDhRH6C3MQuLObNoQqwblB
	 zxIfflPowB69jZ74bPy117Tda0ez3bkZBcfgxkgOfPTsY09VskXVJo3ZgrVrsBsWn5
	 8bCXV8E5X8iJg8upQcClUJP/WYaQ+rmMpQ6y7fJyli0WVD9a+fJ8a/qWO6LqeUY03P
	 i959wmVvDVQcg==
Date: Tue, 25 Mar 2025 17:23:00 +0000
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
Message-ID: <20250325-universe-jigsaw-61da10ad3f77@spud>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
 <2cb4d103d011f0d4293f6ef9307cef57709263d9.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N6UMaAbFGARVRbGb"
Content-Disposition: inline
In-Reply-To: <2cb4d103d011f0d4293f6ef9307cef57709263d9.1742802856.git.mazziesaccount@gmail.com>


--N6UMaAbFGARVRbGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 10:54:44AM +0200, Matti Vaittinen wrote:
> BD96802Qxx-C is an automotive grade configurable Power Management
> Integrated Circuit supporting Functional Safety features for application
> processors, SoCs and FPGAs. BD96802 is controlled via I2C, provides two
> interrupt lines and has two controllable buck regulators.
>=20
> The BD96802 belongs to the family of ROHM Scalable PMICs and is intended
> to be used as a companion PMIC for the BD96801.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
> Revision history:
>  v1 =3D> :
>   - No changes
> ---
>  .../regulator/rohm,bd96802-regulator.yaml     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd96=
802-regulator.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96802-reg=
ulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96802-regu=
lator.yaml
> new file mode 100644
> index 000000000000..671eaf1096d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd96802-regulator.=
yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/rohm,bd96802-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD96802 Power Management Integrated Circuit regulators
> +
> +maintainers:
> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +
> +description:
> +  This module is part of the ROHM BD96802 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml.
> +
> +  The regulator controller is represented as a sub-node of the PMIC node
> +  on the device tree.
> +
> +  Regulator nodes should be named to buck1 and buck2.

Is it really needed to add a new binding for this, rather than including
it in the mfd binding, particularly when this isn't actually a binding
for the regulator but the pattern section applies to the mfd.

> +
> +patternProperties:
> +  "^buck[1-2]$":
> +    type: object
> +    description:
> +      Properties for single BUCK regulator.
> +    $ref: regulator.yaml#
> +
> +    properties:
> +      rohm,initial-voltage-microvolt:
> +        description:
> +          Initial voltage for regulator. Voltage can be tuned +/-150 mV =
=66rom
> +          this value. NOTE, This can be modified via I2C only when PMIC =
is in
> +          STBY state.
> +        minimum: 500000
> +        maximum: 3300000
> +
> +      rohm,keep-on-stby:
> +        description:
> +          Keep the regulator powered when PMIC transitions to STBY state.
> +        type: boolean
> +
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> --=20
> 2.49.0
>=20



--N6UMaAbFGARVRbGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+LmdAAKCRB4tDGHoIJi
0u3rAQDqPdjt2xmzQXWuOlOyE35zGkdVZPNTqss92jW4buMwSQEA1Ch7Z2stdsZe
bC0NRceECazgAR3MiINbjBXChBucags=
=6Hyy
-----END PGP SIGNATURE-----

--N6UMaAbFGARVRbGb--

