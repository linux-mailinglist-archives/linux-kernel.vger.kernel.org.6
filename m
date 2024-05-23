Return-Path: <linux-kernel+bounces-187663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5AD8CD617
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6051F21F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78327482;
	Thu, 23 May 2024 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig2sXpis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314B63D0;
	Thu, 23 May 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475670; cv=none; b=uncziVeF9HRAsOJ+SPa0iI+lR3g76zPqKAbuey7Gvmrjdy3sccpBQFaysym8bIpYMWqVCLMlIyaSBYDUMKKg9Ps8T0zzTd+1xLz3mf1E5yUzTv6gbbYrD+W0UIeniy2FXQeXk/Cys6Cv2fMpUjbmGP8v+TVOqiL5pkaRbVtmhA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475670; c=relaxed/simple;
	bh=VETQLzlRvJ/atP7lNfjD3xkU+FekoieBP/u4SqPwNv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gdqvf/tsfv2bFqZIhwVORRwYxho7w8JFQwda3LAzEQ8moHD2z2Vouoxe0zLila69ZnXVr3wIXAV+Hg3jdxx6zPLULak8238ULfU1sL/0DsVznGqpvnLs2435txHQVFG4wUGT6mRWFSADsgLpw2351Z7RIN6AYbCQIPT2cfobUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig2sXpis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5386C2BD10;
	Thu, 23 May 2024 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716475669;
	bh=VETQLzlRvJ/atP7lNfjD3xkU+FekoieBP/u4SqPwNv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ig2sXpissfaNNs5NshOSEl68IinJC3y64FR3DuTloH2UAHva/7q3QW2LZDgk0oYmG
	 y1C5CZobEM7VacAiKf1qrngIp/xPaXEohxsmlQPO0WjzncblpNb3qJ6odwsJNs4Fhu
	 MnFtNdleE4jxl8m0SoAh3mtOf2Q3hZJ4Ph+KtgQyHF8o8kAaPD2K3mjj1u6vjL9xQK
	 y4rPh+sg+p2wYLRwbo8sx8oPbCkUuVcVBTciMTqpXatEQ87nhtzj9EDeujiAV7ZpRd
	 sLDvVD08EYxqXVGmlcBpFarApQhO4BqVCp6aLHfwpTMjzaqx38sBDrcqtCui9AMl1n
	 V0pcZQwQdmCVg==
Date: Thu, 23 May 2024 15:47:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
Message-ID: <20240523-vividly-sequester-d85ac7bccbbd@spud>
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mHB66SfMY12XnJ+/"
Content-Disposition: inline
In-Reply-To: <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org>


--mHB66SfMY12XnJ+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlowski wrote:
> On 22/05/2024 23:50, Tim Harvey wrote:
> > The GW7905 was renamed to GW7500 before production release.
> >=20
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documenta=
tion/devicetree/bindings/arm/fsl.yaml
> > index 0027201e19f8..d8bc295079e3 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -920,8 +920,8 @@ properties:
> >                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
> >                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> >                - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
> > +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks Board
>=20
> That's not even equivalent. You 7500 !=3D 75xx.
>=20

> >                - gateworks,imx8mm-gw7904
> > -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Board
>=20
> Compatibles do not change. It's just a string. Fixed string.

I think there's justification here for removing it, per the commit
message, the rename happened before the device was available to
customers.
Additionally, I think we can give people that upstream things before they're
publicly available a bit of slack, otherwise we're just discouraging
people from upstreaming early.

--mHB66SfMY12XnJ+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk9XEAAKCRB4tDGHoIJi
0pJIAQCdg1Tf5q/06rcKoEqgcWnLs/48jFh1hSVrAM3QZADuMQEA05roU61bH/VP
OkVQflknoA0fQLl2xRmXY0EunCIYEw0=
=v3l4
-----END PGP SIGNATURE-----

--mHB66SfMY12XnJ+/--

