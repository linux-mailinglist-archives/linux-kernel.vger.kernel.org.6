Return-Path: <linux-kernel+bounces-305334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A97962D16
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A751C23B26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D91A38D6;
	Wed, 28 Aug 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8MaFBnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AD18B476;
	Wed, 28 Aug 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860716; cv=none; b=ABFZ0ehDkKExwSfrgCLU4Lfa1AgvHCIhU9CSGLwL41ypthHn1HclpQW0U2Szh/XSTjfoM8u2X6znTJ9EZcWfx1eaW7D08cTjGwgtofH+HqjRyakqcgynL/2b/iyEUeo/tuyMJ1E2Ru4dqUXbqNG0iPcphZOvtG89gopNT5t59U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860716; c=relaxed/simple;
	bh=XdjC91Lt3XJxHvLh+y47Pss4OsMPf+tF9sMWhe03EIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQJukIbp0aFCZuEHIWoCTTolx8+OXIJ4J4mLiQ3n1v0v1a1okH/hZZv5TCksqhA/K9DCCUXGgi8N7jbhUX16kWEA26zgYAAHirQ3sI+j1pQU+HvuCavoUjbE/JOIxbOttAGDMMs21riX6kGi9kNt8qhyJe9/kwYD+oMgb0dIdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8MaFBnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4779C4CEC1;
	Wed, 28 Aug 2024 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724860716;
	bh=XdjC91Lt3XJxHvLh+y47Pss4OsMPf+tF9sMWhe03EIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8MaFBnbfsyTJ/nlzKyRysQ40Mfk/I3h4NFS5xldhOupNh2iGTLkiTO6XnIW84CKV
	 f7yjL+cmvQoquZQKc/dm+8jLZP6p0V+nyTJzT3N3T2yPnA0EGspa+hIX60oVV26JoS
	 bJIreCWDph8NwfjcQXBI3/0kcTLnA65pCC3yu/zLfnjf/eRqVoGJ4kPfrkavtR96d8
	 lVMwn3jvjeBaMWcQOBFCe4kmGqnh85F9xF1lcxeZ+pleYsdmFqM5MYri23NF6ZOxnM
	 /qaFP8k4C/nG9wLlJPtFuBY2KyiS3Bi42WcVvXx5430ZPLblMig7O1ntJhi4Y05xDH
	 TYHORAxGNuL/g==
Date: Wed, 28 Aug 2024 16:58:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: Convert mxs-saif.txt to
 fsl,saif.yaml (imx28 saif)
Message-ID: <20240828-debrief-handpick-a4a81b6d8c13@spud>
References: <20240828091139.2621158-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="brnKUZxUC0HIoVWI"
Content-Disposition: inline
In-Reply-To: <20240828091139.2621158-1-lukma@denx.de>


--brnKUZxUC0HIoVWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:11:39AM +0200, Lukasz Majewski wrote:
> The 'fsl,imx28-saif' compatible has already the mxs-saif.txt description.
> This patch converts (and removes it) this file to fsl,saif.yaml (to follow
> current fsl convention).
>=20
> Changes for the mxs-saif.txt:
> - Adds 'clocks' and '#sound-dai-cells' properties
> - Provide device description
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>=20
> ---
> Changes for v2:
> - Remove mxs-saif.txt
> - Add description with information about extensions required for this
>   device's current DTS description
> ---
>  .../devicetree/bindings/sound/fsl,saif.yaml   | 78 +++++++++++++++++++
>  .../devicetree/bindings/sound/mxs-saif.txt    | 41 ----------
>  2 files changed, 78 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,saif.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/mxs-saif.txt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,saif.yaml b/Docu=
mentation/devicetree/bindings/sound/fsl,saif.yaml
> new file mode 100644
> index 000000000000..cc78a95e0391
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,saif.yaml

Filename matching the compatible please.

> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,saif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale MXS Serial Audio Interface (SAIF)
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +description:
> +  The SAIF is based on I2S module that is used to communicate with audio=
 codecs,
> +  but only with half-duplex manner (i.e. it can either transmit or recei=
ve PCM
> +  audio).
> +
> +properties:
> +  compatible:
> +    const: fsl,imx28-saif
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx-tx
> +
> +  clocks:
> +    maxItems: 1
> +
> +  fsl,saif-master:
> +    description: Indicate that saif is a slave and its phandle points to=
 master
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#sound-dai-cells"
> +  - interrupts
> +  - dmas
> +  - dma-names
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    saif0: saif@80042000 {

The label here isn't needed, as you've got no references to it that use
them, because the leading - before examples make them independent and
thus the &saif0 in the second one is just a made up phandle when the
example is compiled by the test infrastructure (like the &clks is).
Either drop the - | from the second one, or drop the first example
entirely.


> +        compatible =3D "fsl,imx28-saif";
> +        reg =3D <0x80042000 2000>;
> +        #sound-dai-cells =3D <0>;
> +        interrupts =3D <59>;
> +        dmas =3D <&dma_apbx 4>;
> +        dma-names =3D "rx-tx";
> +        clocks =3D <&clks 53>;
> +    };
> +  - |
> +    saif1: saif@80046000 {

While you're at it, this saif1 label isn't used.

Thanks,
Conor.

> +        compatible =3D "fsl,imx28-saif";
> +        reg =3D <0x80046000 2000>;
> +        #sound-dai-cells =3D <0>;
> +        interrupts =3D <58>;
> +        dmas =3D <&dma_apbx 5>;
> +        dma-names =3D "rx-tx";
> +        clocks =3D <&clks 53>;
> +        fsl,saif-master =3D <&saif0>;
> +    };

--brnKUZxUC0HIoVWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs9JJwAKCRB4tDGHoIJi
0rQkAQCWugiMG8a6AGkq0NbZ0r1r/tA/63laf8eibEF+x/O1ngD/QeFJqkg5yWVK
czTl+C9CuW4nPUFiLyw3+ZxBfAOdBAM=
=qM/5
-----END PGP SIGNATURE-----

--brnKUZxUC0HIoVWI--

