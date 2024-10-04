Return-Path: <linux-kernel+bounces-350755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE299091A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166751C220E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF661C7619;
	Fri,  4 Oct 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjIny+n6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1001E377D;
	Fri,  4 Oct 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059077; cv=none; b=P8FB7Sf0so+IfOY3OABkyHfXgmkjY3j95cIe5nsLrUojlkPxJmow8I2tB7p+8TOGSPu86/7MZ2ERuQcLvAIe/ornDSK0vdOeOar7dOpjIaWNWfspjzQUhFjSmi8ux/J3CGhz4AxoLPFSV898I6Lnwd4//+e2BN7sR8+hS78maDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059077; c=relaxed/simple;
	bh=xt76oEmoy7/Q/3wsw70SvNl00pHmcycaqeG2jfHADkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z++AU/HBi0t9ovgxp/cu6nIR7Ec8PThHgF0vAZGiWFEnytox5TI5pQ7CotfZ4iUm/ooT1ResZ1bbo5X/AWP2zTPwUFLGvEUl/6HmSWR/wD0Mu65GLE6WHhissRiOOa6zkBCogFJy9tlqSHpprGTt8Fa1WYohQFqsJo90mOj5AwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjIny+n6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA09C4CEC6;
	Fri,  4 Oct 2024 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728059077;
	bh=xt76oEmoy7/Q/3wsw70SvNl00pHmcycaqeG2jfHADkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjIny+n6VSXqoNaG4T2WydHqjX+d/Ft0LTYYw0juwfImfQId+VnhoZSsWuS4bv3Er
	 iM6JJ85U5JcYvSjSFzHlyg+LEn3JWwi3Ar7+oV3+bA3JXWM6EQjDqGY8eMHFAFofMw
	 btYuKYP4h5eEqb0eabBscDo2Fs6IUBL1cQWXCP/fcmwyXd5egPcPRbhfDFy4ttKM9r
	 Ah4uPr/uEGNssWsGOG58cCjDBl7GW7qN69lEDh7hrxMBtndA5y4x2ARgk9pO/2Kqf2
	 YyUVIrtL7xG1epIB1If3oeWnyLhXXwlW3SkmPOFGXMf0dpIE23QtgCt0Xnkmq3KiH/
	 Uhp88SvxgVCkw==
Date: Fri, 4 Oct 2024 17:24:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: drop usage of Toradex SOMs
 compatible alone
Message-ID: <20241004-vaporizer-undusted-acd417d1fbb9@spud>
References: <20241004160842.110079-1-francesco@dolcini.it>
 <20241004-enforcer-absently-e3a056284991@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fVFGOrID9M9ijjQu"
Content-Disposition: inline
In-Reply-To: <20241004-enforcer-absently-e3a056284991@spud>


--fVFGOrID9M9ijjQu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 05:24:11PM +0100, Conor Dooley wrote:
> On Fri, Oct 04, 2024 at 06:08:42PM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >=20
> > The Toradex SOMs cannot be used alone without a carrier board, so drop
> > the usage of its compatible alone.
>=20
> FYI, alot of what you're removing here appears in the $som.dtsi files.
> I don't think that matters at all, since the dtsi files need to be
> included somewhere - but figured I'd point it out in case the platform
> maintainer for fsl cares.

Oh, I forgot,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> >=20
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documenta=
tion/devicetree/bindings/arm/fsl.yaml
> > index b39a7e031177..5f0e8e1cd6fb 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -296,7 +296,6 @@ properties:
> >                - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico=
-Pi
> >                - technologic,imx6q-ts4900
> >                - technologic,imx6q-ts7970
> > -              - toradex,apalis_imx6q      # Apalis iMX6 Modules
>=20
> This one is in arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
>=20
> >                - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
> >                - uniwest,imx6q-evi         # Uniwest Evi
> >                - variscite,dt6customboard
> > @@ -488,7 +487,6 @@ properties:
> >                - technexion,imx6dl-pico-pi      # TechNexion i.MX6DL Pi=
co-Pi
> >                - technologic,imx6dl-ts4900
> >                - technologic,imx6dl-ts7970
> > -              - toradex,colibri_imx6dl      # Colibri iMX6 Modules
>=20
> This one appears in arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
>=20
> >                - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
> >                - vdl,lanmcu                # Van der Laan LANMCU board
> >                - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite =
Board
> > @@ -718,9 +716,6 @@ properties:
> >                - joz,jozacp                # JOZ Access Point
> >                - kontron,sl-imx6ull        # Kontron SL i.MX6ULL SoM
> >                - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluat=
ion Board
> > -              - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
> > -              - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eM=
MC) Module
> > -              - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi /=
 BT Modules
> >                - uni-t,uti260b             # UNI-T UTi260B Thermal Came=
ra
> >            - const: fsl,imx6ull
> > =20
> > @@ -879,8 +874,6 @@ properties:
> >                - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico=
-Hobbit
> >                - technexion,imx7d-pico-nymph   # TechNexion i.MX7D Pico=
-Nymph
> >                - technexion,imx7d-pico-pi      # TechNexion i.MX7D Pico=
-Pi
> > -              - toradex,colibri-imx7d         # Colibri iMX7D Module
> > -              - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMM=
C) Module
> >                - zii,imx7d-rmu2            # ZII RMU2 Board
> >                - zii,imx7d-rpu2            # ZII RPU2 Board
> >            - const: fsl,imx7d
> > @@ -950,9 +943,6 @@ properties:
> >                - innocomm,wb15-evk         # i.MX8MM Innocomm EVK board=
 with WB15 SoM
> >                - kontron,imx8mm-sl         # i.MX8MM Kontron SL (N801X)=
 SOM
> >                - kontron,imx8mm-osm-s      # i.MX8MM Kontron OSM-S (N80=
2X) SOM
> > -              - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
> > -              - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini Mod=
ules without Wi-Fi / BT
> > -              - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi =
/ BT Modules
> >                - prt,prt8mm                # i.MX8MM Protonic PRT8MM Bo=
ard
> >            - const: fsl,imx8mm
> > =20
> > @@ -1085,9 +1075,6 @@ properties:
> >                - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate cont=
rol without panel
> >                - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate contr=
ol with 7=E2=80=9D panel
> >                - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP cl=
imate control with 10.1" panel
> > -              - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
> > -              - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Mod=
ules without Wi-Fi / BT
> > -              - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi =
/ BT Modules
> >            - const: fsl,imx8mp
> > =20
> >        - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus =
Modules
> > @@ -1223,8 +1210,6 @@ properties:
> >          items:
> >            - enum:
> >                - fsl,imx8qm-mek           # i.MX8QM MEK Board
> > -              - toradex,apalis-imx8      # Apalis iMX8 Modules
> > -              - toradex,apalis-imx8-v1.1 # Apalis iMX8 V1.1 Modules
>=20
> These two appear in arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi and
> the v1.1 equivalent.
>=20
> >            - const: fsl,imx8qm
> > =20
> >        - description: i.MX8QM Boards with Toradex Apalis iMX8 Modules
> > @@ -1384,7 +1369,6 @@ properties:
> >                - fsl,vf610-twr             # VF610 Tower Board
> >                - lwn,bk4                   # Liebherr BK4 controller
> >                - phytec,vf610-cosmic       # PHYTEC Cosmic/Cosmic+ Board
> > -              - toradex,vf610-colibri_vf61 # Colibri VF61 Modules
>=20
> And this one is in arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi.
>=20
> >            - const: fsl,vf610
> > =20
> >        - description: Toradex Colibri VF61 Module on Colibri Evaluation=
 Board
> > --=20
> > 2.39.5
> >=20



--fVFGOrID9M9ijjQu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwAWwQAKCRB4tDGHoIJi
0qzdAQC49Yyaf+ZpfmV3FEVFRpqQbhZzibHCzst5cwVPoc2VowEAkXxAsJNxbhcX
+yyuOo4BpUM2U1/d6tQjcyTe/NdLkwg=
=OvST
-----END PGP SIGNATURE-----

--fVFGOrID9M9ijjQu--

