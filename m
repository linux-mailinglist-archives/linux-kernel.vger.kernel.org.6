Return-Path: <linux-kernel+bounces-259217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD329392BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6631F21EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087DB16EBFC;
	Mon, 22 Jul 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZdnvfcv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA5C2FD;
	Mon, 22 Jul 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667029; cv=none; b=t78jwwV0l1Qd7q2+DbWmoOjUwzegD5e+nkl1t83srI4IiBgjAMGf1oaUfvMaKFRnIGQ2DAr0DMrctPVk1/Ayyl7PRngoBh9Vw1ZXAJsc+aN8j1JxAnYtOzHSjD4SiBriT470W2faUMmHKV3UniPfHAS7LYCDtJ2LlcawPsPuw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667029; c=relaxed/simple;
	bh=66t+9hIP68IAhD6QVB6l6ykYDYgg5yCXHj2vD1KEeC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8pCBFqGWusERRJnTan23hLHuFseM3OxWfMTQ6lTFr+Wc8wKaEeUhKZYV4KUt/3aFSbV/RdkkLan/dg0Pbb7Iyj3XRTArJ4jqCi5Pw3OH7DG790LJmGEBc6dRNMaz5IXl3T3bFllLZIXRGtPRqCZQmaJaQhtKX01Br3P6DIhvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZdnvfcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04DCC116B1;
	Mon, 22 Jul 2024 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721667028;
	bh=66t+9hIP68IAhD6QVB6l6ykYDYgg5yCXHj2vD1KEeC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZdnvfcvywZmjx/4GCW4ffOgZMwSc6LrqwpgC81/5bGJmqrVexcqlmZcNLOVHI+AZ
	 +0AtmEFhW9DvYm8o+uNN0Eca8u2W6QjJmCs25AikaTXpfHKQAe4FaSzV1OCcWrk5OA
	 G+Pwk07KBkUYjU3kWljsFUBr0yPbEcbhbs6f8IJha/2ZiLcw05PH9SefUdrNcU9c5y
	 eYrAsVLFtXu8l8ABy04bZgx3AEibJnu88xyKBEdoE/GVXmczYPPi2TZD5jUJmgHFd0
	 3zsEb0NO4+k9FmU7QRrzU2glc3NP3d5CW2GsRySdmMEjfwKZPtT2/EKfmOijhYTd6Q
	 /WKB9fMquIvlw==
Date: Mon, 22 Jul 2024 17:50:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <20240722-popper-comfort-7538ea70c77b@spud>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iLD5d4oSUIlBzqiU"
Content-Disposition: inline
In-Reply-To: <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>


--iLD5d4oSUIlBzqiU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrote:
> The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> creates an embedded secure enclave within the SoC boundary to enable
> features like:
> - HSM
> - SHE
> - V2X
>=20
> Secure-Enclave(s) communication interface are typically via message
> unit, i.e., based on mailbox linux kernel driver. This driver enables
> communication ensuring well defined message sequence protocol between
> Application Core and enclave's firmware.
>=20
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications, to be able to communicate over single MU.
>=20
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++=
++++++
>  1 file changed, 91 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b=
/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> new file mode 100644
> index 000000000000..7511d0e9cf98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> +
> +maintainers:
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +
> +description: |
> +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> +  enables features like
> +    - Hardware Security Module (HSM),
> +    - Security Hardware Extension (SHE), and
> +    - Vehicular to Anything (V2X)
> +
> +  Communication interface to the secure-enclaves(se) is based on the
> +  messaging unit(s).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8ulp-se
> +      - fsl,imx93-se
> +      - fsl,imx95-se
> +
> +  mboxes:
> +    items:
> +      - description: mailbox phandle to send message to se firmware
> +      - description: mailbox phandle to receive message from se firmware
> +
> +  mbox-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  sram:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - mbox-names
> +
> +allOf:
> +  # memory-region
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-se
> +              - fsl,imx93-se
> +    then:
> +      required:
> +        - memory-region
> +    else:
> +      properties:
> +        memory-region: false
> +
> +  # sram
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-se
> +    then:
> +      required:
> +        - sram
> +
> +    else:
> +      properties:
> +        sram: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    senclave-firmware {

Last revision this was "firmware", but now you've got something that
appears non-generic. Why did you change it? The normal differentiator for
multiple nodes is -[0-9]*, why can't you use that, if you're worried
about multiple nodes?

> +      compatible =3D "fsl,imx95-se";
> +      mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> +      mbox-names =3D "tx", "rx";
> +    };
> +...
>=20
> --=20
> 2.34.1
>=20

--iLD5d4oSUIlBzqiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6NzwAKCRB4tDGHoIJi
0mt9AP9uT5bF8Ef28A5zuCf5EZWLfCY/xWhJNXCln3owDgovygEAqM+oWbWX2nnG
KKHdKE+HM2QM274P7GaHl3aqBtYhBAk=
=B9e0
-----END PGP SIGNATURE-----

--iLD5d4oSUIlBzqiU--

