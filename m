Return-Path: <linux-kernel+bounces-549323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7BA55107
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E807A4DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F569219A8A;
	Thu,  6 Mar 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyQKJlX5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEC23C8C7;
	Thu,  6 Mar 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278454; cv=none; b=PtCfkSN8xNHPzoZ/1yef4xRImIIj7zYIgeYYaj3dq9Yf0r/aWjPkP31xGCmUroMCKB4DaQUL586Qq0Rq5LejLoeLnWRKnINsvVZ7D2o2SPvA2puIhuyCKCQ/7TJHLbXjdmTB3uhuAqLQMNuY7OHvSg3IKfSAd1q1ehTpqfuZVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278454; c=relaxed/simple;
	bh=jthW/fL1Zasqiw/0qv4ietdcvP4mUzmlvnMjEK6S/c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2k3hBwhv2aphOV9uhECjx5Jlqi/AqKlkpCdlG6MBBkzUkfMt4pu78ywdOWBUOjx2nhKMiob4VzaPyZQBnB9WAlidXJOdurenSbGDw58GiTRo3OMjXgRmllY8wdRbC6QnNaSXHi48lHNSflS1aJGVMpQSbHAPF/AnoiQNAnoVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyQKJlX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8012EC4CEE9;
	Thu,  6 Mar 2025 16:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741278453;
	bh=jthW/fL1Zasqiw/0qv4ietdcvP4mUzmlvnMjEK6S/c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyQKJlX5QTnZ9LVFjuBHhFWvLxUQ/SOjbUgz6ld452D3UEM5bil3vqclpHWBrXa1V
	 qPT0Cl9KG/A2CD3WXvk/nrB+4KzdGdJvIT1qUmAICiY1Kc+UawzAnBTjuPP6o62Xj9
	 kMcZIaMYKqVO3CmcdA8WjpcZLff95jpB9wWNdydA0zxJ0oQWCHw/HUblZiP5hEbO8/
	 je+KFdxtcXX4KH+i0LI4HDCYnY7ZBYDqa6VzN9KRiVEzeAHoKLDHMuHAAJyWRsD0gB
	 nYacfdM8dQAFkLc4D0SIWi3yMTz7SBy3nStVCKD/u1GN2DIYUCptAliXLt1zt/it7c
	 bG/GQB+5s/0/Q==
Date: Thu, 6 Mar 2025 16:27:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	"open list:MAILBOX API" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: mailbox: fsl,mu: Add i.MX94 compatible
Message-ID: <20250306-immature-ether-d92fb5b8f18a@spud>
References: <20250306155225.99807-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FX1q63A62l42URpo"
Content-Disposition: inline
In-Reply-To: <20250306155225.99807-1-Frank.Li@nxp.com>


--FX1q63A62l42URpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 10:52:24AM -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-mu" for the i.MX94 chip, which is backwa=
rd
> compatible with i.MX95. Set it to fall back to "fsl,imx95-mu".
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Docu=
mentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index 00631afcd51d8..581425aacdccf 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> @@ -54,6 +54,10 @@ properties:
>                - fsl,imx8qm-mu
>                - fsl,imx8qxp-mu
>            - const: fsl,imx6sx-mu
> +      - items:
> +          - enum:
> +              - fsl,imx94-mu
> +          - const: fsl,imx95-mu
> =20
>    reg:
>      maxItems: 1
> @@ -142,7 +146,8 @@ allOf:
>        not:
>          properties:
>            compatible:
> -            const: fsl,imx95-mu
> +            contains:
> +              const: fsl,imx95-mu
>      then:
>        patternProperties:
>          "^sram@[a-f0-9]+": false
> --=20
> 2.34.1
>=20

--FX1q63A62l42URpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8nM8QAKCRB4tDGHoIJi
0puLAQDaMSbzKyckc83ABSYO3V7PLYkBLV70po+etx2BbBLI+QD/Ux+vA7N69rjQ
cOR9TOdmWil9KRROSc7oGB1n6PkOsgo=
=U1NF
-----END PGP SIGNATURE-----

--FX1q63A62l42URpo--

