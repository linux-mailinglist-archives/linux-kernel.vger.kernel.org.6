Return-Path: <linux-kernel+bounces-551461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F137A56CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F90B16F5A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E721E0AD;
	Fri,  7 Mar 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtSCAqBy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36021D3C8;
	Fri,  7 Mar 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363010; cv=none; b=Unu1ARO33t7y0H44NXRvWWtG4APEqsRwdxKs++zdut8S0gH3n0mUGQ3SdW299qpNXTLxOD0QIHIH+i0Ydk5SB00NSzDQN5vaRhFS/8mutc2X5EbrEMMlZU5R2aHA9mjdSBCKc9R8h86F7jvns6M8/WG/hzzN9JAhdemjNcFbKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363010; c=relaxed/simple;
	bh=snIEFmz9xfWYQzlLczIEsvcAaFsQRt1rMH1p2sngHrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va9XQDI9TXv2YukJCdC25eZ08jXd7VPCPYPHtHLZfVR3lfGSrUqa0WkwzXI2rWo9UyxjP5xOWcomR52CHNff43NTFVCulUBOIvgYq9wrO0HfH1ZqsYqVZ5HYNFOF/XzFIEekajnu/VvigLQSRUFHRr8Ptl/HSTGWEUoPzAiO2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtSCAqBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C70C4CED1;
	Fri,  7 Mar 2025 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363009;
	bh=snIEFmz9xfWYQzlLczIEsvcAaFsQRt1rMH1p2sngHrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtSCAqBydP3J4dcHgQUECWzxCRv7ZnIQnZaF8rpt9JNd+352szrca7CF8RrkLT4Nr
	 yAPig1lCb5BlnWv/GSOzDjwbrYQoGqOp8br/CCf5SPYi2Csbp9CV4og0fhH4nmooU8
	 CWcwQQ0JpxcRHVEN4UOOiMw/8B7E6xX3MW2y2XEK9sknyNcohDDRngYZ4dwBmWwSCZ
	 Rf/tNwAt7QJu18joFvpjLp22JrnEnZdLzRME3Ra353TZYtBnnkLWSNvsUrpjg4pok1
	 uVTGGru9+Zuemi2U7tTpfF/l6njtqH8ptBultU9vQESMCMJy+Z3fKBOrD3BbDF8zFf
	 higc/IBxAFPdw==
Date: Fri, 7 Mar 2025 15:56:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,sai: Add i.MX94 support
Message-ID: <20250307-walmart-frequency-0430bb25a237@spud>
References: <20250306171013.243332-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FFjeYTYwkjimMl9i"
Content-Disposition: inline
In-Reply-To: <20250306171013.243332-1-Frank.Li@nxp.com>


--FFjeYTYwkjimMl9i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 12:10:13PM -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-sai" for the i.MX94 chip, which is
> backward compatible with i.MX95. Set it to fall back to "fsl,imx95-sai".

Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Docum=
entation/devicetree/bindings/sound/fsl,sai.yaml
> index 5c95508ee7075..0d733e5b08a4e 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> @@ -41,6 +41,10 @@ properties:
>                - fsl,imx93-sai
>                - fsl,imx95-sai
>                - fsl,vf610-sai
> +      - items:
> +          - enum:
> +              - fsl,imx94-sai
> +          - const: fsl,imx95-sai
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--FFjeYTYwkjimMl9i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sXPQAKCRB4tDGHoIJi
0mlhAQCDLOBTTlzlOnEh8Iq9kRCyrPzNjrGAM3aHNpcBGsUuAwEA6LMpql3Rjt6a
zrp1FWvr1jsyCMqe9GTDKdMHJIhbhAE=
=6Rpe
-----END PGP SIGNATURE-----

--FFjeYTYwkjimMl9i--

