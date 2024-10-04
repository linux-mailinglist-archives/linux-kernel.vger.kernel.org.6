Return-Path: <linux-kernel+bounces-350753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14BB99092F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F82B28B43
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0021C82E7;
	Fri,  4 Oct 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKvzX1Xo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2F1C305B;
	Fri,  4 Oct 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059055; cv=none; b=qYm3LHfzhMVzpzDof+2Shl6SyvLmtu5e3fZS6PhB45AvIm8hzPPOSszoUoASxoVQPtuaF7rhK3MTfcQhNbAQdVceJYOFzqdMoIDwTxB2dHNE9RN0EgYGPoDmS0KMHqNKdkSNhyyN275yYeeRFc7MxbCYH0+FAiOQNXKjGHqsUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059055; c=relaxed/simple;
	bh=hVvLps8cKyzFGZExjbnrb234A3fMUPEOtwAa17AqzdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9qgQ+ciAnuydrsw3QygyV9/g/ey07Tkpmfvfex7THbc6RAmXGmc+LgIAeZiTKNFml/2ZZ4xMu5qsJFjEC8ovRuTshd4P5YVToiCFGUAitj/0TyjysxiNV/960JBoZL70wLfgOcz7QQAAzcAocxcqDE/YM6vvZnwQS4PBwrw+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKvzX1Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800DCC4CEC6;
	Fri,  4 Oct 2024 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728059055;
	bh=hVvLps8cKyzFGZExjbnrb234A3fMUPEOtwAa17AqzdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKvzX1Xo2EggaHvvT46eUWVsEr55f6J5csr/HrC68ln02BXwhOzBbnJ3uRAgUP88N
	 c4mUrJaCwVTLI1LD8W3fFuqDBDW8hEdHi8ch8vfFo+8O7Vkz57SBvS50/CwwhK2bEw
	 ZonTI1mn82qfXC4GXh6Pja4xdaXSr92qqxOymx6yseY0Bx66XJVbplTiBXmCSMshaV
	 PfEWwvC9oDCSN4HZ8yK3BZLUqVZDoWz1ZiO/aplXKLVfCWIPRedhx8Eqq9lAiDWLZs
	 4f3UfL+EzhzRnM0wr1iqPDBlx4r4MeYvkni6a4gBvX6pWQvt9J8YtW2Mf/NkzVP1gt
	 AHFixd3s7FWsA==
Date: Fri, 4 Oct 2024 17:24:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: drop usage of Toradex SOMs
 compatible alone
Message-ID: <20241004-enforcer-absently-e3a056284991@spud>
References: <20241004160842.110079-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="beB6SG7Y976RyMgX"
Content-Disposition: inline
In-Reply-To: <20241004160842.110079-1-francesco@dolcini.it>


--beB6SG7Y976RyMgX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 06:08:42PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> The Toradex SOMs cannot be used alone without a carrier board, so drop
> the usage of its compatible alone.

FYI, alot of what you're removing here appears in the $som.dtsi files.
I don't think that matters at all, since the dtsi files need to be
included somewhere - but figured I'd point it out in case the platform
maintainer for fsl cares.

>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 16 ----------------
>  1 file changed, 16 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index b39a7e031177..5f0e8e1cd6fb 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -296,7 +296,6 @@ properties:
>                - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi
>                - technologic,imx6q-ts4900
>                - technologic,imx6q-ts7970
> -              - toradex,apalis_imx6q      # Apalis iMX6 Modules

This one is in arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi

>                - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
>                - uniwest,imx6q-evi         # Uniwest Evi
>                - variscite,dt6customboard
> @@ -488,7 +487,6 @@ properties:
>                - technexion,imx6dl-pico-pi      # TechNexion i.MX6DL Pico=
-Pi
>                - technologic,imx6dl-ts4900
>                - technologic,imx6dl-ts7970
> -              - toradex,colibri_imx6dl      # Colibri iMX6 Modules

This one appears in arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi

>                - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
>                - vdl,lanmcu                # Van der Laan LANMCU board
>                - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Bo=
ard
> @@ -718,9 +716,6 @@ properties:
>                - joz,jozacp                # JOZ Access Point
>                - kontron,sl-imx6ull        # Kontron SL i.MX6ULL SoM
>                - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluatio=
n Board
> -              - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
> -              - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC=
) Module
> -              - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / B=
T Modules
>                - uni-t,uti260b             # UNI-T UTi260B Thermal Camera
>            - const: fsl,imx6ull
> =20
> @@ -879,8 +874,6 @@ properties:
>                - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-H=
obbit
>                - technexion,imx7d-pico-nymph   # TechNexion i.MX7D Pico-N=
ymph
>                - technexion,imx7d-pico-pi      # TechNexion i.MX7D Pico-Pi
> -              - toradex,colibri-imx7d         # Colibri iMX7D Module
> -              - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMMC)=
 Module
>                - zii,imx7d-rmu2            # ZII RMU2 Board
>                - zii,imx7d-rpu2            # ZII RPU2 Board
>            - const: fsl,imx7d
> @@ -950,9 +943,6 @@ properties:
>                - innocomm,wb15-evk         # i.MX8MM Innocomm EVK board w=
ith WB15 SoM
>                - kontron,imx8mm-sl         # i.MX8MM Kontron SL (N801X) S=
OM
>                - kontron,imx8mm-osm-s      # i.MX8MM Kontron OSM-S (N802X=
) SOM
> -              - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
> -              - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini Modul=
es without Wi-Fi / BT
> -              - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi / =
BT Modules
>                - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
>            - const: fsl,imx8mm
> =20
> @@ -1085,9 +1075,6 @@ properties:
>                - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate contro=
l without panel
>                - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control=
 with 7=E2=80=9D panel
>                - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP clim=
ate control with 10.1" panel
> -              - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
> -              - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modul=
es without Wi-Fi / BT
> -              - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / =
BT Modules
>            - const: fsl,imx8mp
> =20
>        - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Mo=
dules
> @@ -1223,8 +1210,6 @@ properties:
>          items:
>            - enum:
>                - fsl,imx8qm-mek           # i.MX8QM MEK Board
> -              - toradex,apalis-imx8      # Apalis iMX8 Modules
> -              - toradex,apalis-imx8-v1.1 # Apalis iMX8 V1.1 Modules

These two appear in arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi and
the v1.1 equivalent.

>            - const: fsl,imx8qm
> =20
>        - description: i.MX8QM Boards with Toradex Apalis iMX8 Modules
> @@ -1384,7 +1369,6 @@ properties:
>                - fsl,vf610-twr             # VF610 Tower Board
>                - lwn,bk4                   # Liebherr BK4 controller
>                - phytec,vf610-cosmic       # PHYTEC Cosmic/Cosmic+ Board
> -              - toradex,vf610-colibri_vf61 # Colibri VF61 Modules

And this one is in arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi.

>            - const: fsl,vf610
> =20
>        - description: Toradex Colibri VF61 Module on Colibri Evaluation B=
oard
> --=20
> 2.39.5
>=20

--beB6SG7Y976RyMgX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwAWqwAKCRB4tDGHoIJi
0kxuAQC5OOkPjVSRKD0SauqoX7AQDn6WPrBkuhYmLoJ+Ge4bVgEAjklWkyA34mBv
/jVW0SLGeZIAeBzJL0F6+bAa3mR7wAg=
=Qolo
-----END PGP SIGNATURE-----

--beB6SG7Y976RyMgX--

