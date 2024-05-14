Return-Path: <linux-kernel+bounces-179039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D00408C5ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBD41F21DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3B1802D8;
	Tue, 14 May 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtDmOqPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1F1802B2;
	Tue, 14 May 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709980; cv=none; b=L5O3je55jWBSgeulV6TDsyIUb76IQXTPSW4S0vu3NE+EwZQfCgujjt9jQ7XmjzYu04w1jUTQHq1ygNt2dllWFzkGQ/JealepHUSJjmr5S5MpBZLqYIBT3mLk1I81Py4W6QeApxLnFeOz3fVfJiY4U8NfUjfUVu9YCykM81WYSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709980; c=relaxed/simple;
	bh=1D7baXBKgZDMtYJArXbSDEg75oiAzjU9n1AllDE1/jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0bgO8ife5YQX45vyPbC7wHlJmh4Ht3wfRjFzFP5Ft7VZ+ODwdDYskE/g3rwyRlFV0TUFpsNnsZEVRmYdG9EXjRjmSb6Fa4msEX/pCPDOr68hIxrNQBcsAwVY7cdiVkMvuc0S4mj7ySdAOqOIFOeW+2r7eQhS7Ot8YVPnCvCL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtDmOqPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A9C2BD10;
	Tue, 14 May 2024 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715709980;
	bh=1D7baXBKgZDMtYJArXbSDEg75oiAzjU9n1AllDE1/jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtDmOqPd0y5D56goykEk4q+29o4G52cyn17EUlae8b9AAKGV/nQugPcFxLxjdajys
	 uSXbTVMi7rbcYOeRNcm4gcgwFkce/xHJRVOqOjMBbBD90CyI7QXzOs/VuyGbIjMgWI
	 qgYOthRVzQHQUpg+21SGMtO3IBIWsbFFXfVePq+Sa/nx2Y8TEoYU/CSqDXgN/1mWzL
	 It3E0eMmYN3ByX6MzxqjzBYPvqeq2M0REk019lGl4VeAoBBbldeervtdSe2tnUq/cp
	 x2uepyY1P2EpET69f2+Yf9cZCAXEg5479aYZM7dO9zS3GJPot2JSOWd+9QEVS0HcwR
	 JzT1N25quhF4g==
Date: Tue, 14 May 2024 19:06:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller
 sub-node
Message-ID: <20240514-campus-sibling-21cdf4c78366@spud>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/fS/DhJwdDL+x8Fz"
Content-Disposition: inline
In-Reply-To: <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>


--/fS/DhJwdDL+x8Fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> The Audio Block Control contains clock distribution and gating
> controls, as well as reset handling to several of the AUDIOMIX
> peripherals. Especially the reset controls for Enhanced Audio
> Return Channel (EARC) PHY and Controller.
>=20
> So Audio Block Control is a Multi-Function Devices.
>=20
> Add reset-controller sub node which is a reset provider for EARC.
> Add compatible string "syscon", "simple-mfd" which make Audio
> Block Control device support reset-controller sub-node.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/clock/imx8mp-audiomix.yaml         | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml=
 b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> index 0a6dc1a6e122..a403ace4d11f 100644
> --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> @@ -15,7 +15,10 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: fsl,imx8mp-audio-blk-ctrl
> +    items:
> +      - const: fsl,imx8mp-audio-blk-ctrl
> +      - const: syscon
> +      - const: simple-mfd
> =20
>    reg:
>      maxItems: 1
> @@ -44,6 +47,11 @@ properties:
>        ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx=
8mp-clock.h
>        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
> =20
> +  reset-controller:
> +    type: object
> +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> +    description: The child reset devices of AudioMIX Block Control.

Why not just set #reset-cells =3D <1> in the existing node? IIRC it was
already suggested to you to do that and use auxdev to set up the reset
driver.

Cheers,
Conor.

> +
>  required:
>    - compatible
>    - reg
> @@ -60,7 +68,7 @@ examples:
>      #include <dt-bindings/clock/imx8mp-clock.h>
> =20
>      clock-controller@30e20000 {
> -        compatible =3D "fsl,imx8mp-audio-blk-ctrl";
> +        compatible =3D "fsl,imx8mp-audio-blk-ctrl", "syscon", "simple-mf=
d";
>          reg =3D <0x30e20000 0x10000>;
>          #clock-cells =3D <1>;
>          clocks =3D <&clk IMX8MP_CLK_AUDIO_ROOT>,
> @@ -74,6 +82,11 @@ examples:
>                        "sai1", "sai2", "sai3",
>                        "sai5", "sai6", "sai7";
>          power-domains =3D <&pgc_audio>;
> +
> +        reset-controller {
> +            compatible =3D "fsl,imx8mp-audiomix-reset";
> +            #reset-cells =3D <1>;
> +        };
>      };
> =20
>  ...
> --=20
> 2.34.1
>=20

--/fS/DhJwdDL+x8Fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkOoFgAKCRB4tDGHoIJi
0mnkAQCfYx3ESpxuBfcV+o4yFqeGhopQBeQemIeoiZ7FFQmbeQEAt8BwyiI9fAVf
T8+mnW1Tx66ZdvmZsib64ALlolQyUQ8=
=XWvb
-----END PGP SIGNATURE-----

--/fS/DhJwdDL+x8Fz--

