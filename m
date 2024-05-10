Return-Path: <linux-kernel+bounces-175980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D918C2838
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFAD1F216CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4933171E72;
	Fri, 10 May 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpGT41MT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E296171675;
	Fri, 10 May 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356347; cv=none; b=tIVJIqXMJ04LjAk34hxN+IVREggTU9HtATg59TPnnABGXgYX7y7EyxwsvXzE7HIC3Gfe+4guvADqj6YFJ+6jQTogKSqvolfEyjhuL/PYvp30ExvmnzngmVhe6Umz1gTan+Kk75rNCKfMRJ68QhiN9DkMEwYOxCEV0Ihv327ev98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356347; c=relaxed/simple;
	bh=h5nTT0Du2UCghXIKEWt0yFqx/MaUNSrO06p/4aGpyvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLjkx356W5Js9VcpuvVwWLT92yz3g1YDNUsZr7TuDnclb5Aytug/Ahd8nyQ7PC5kuUrA1AsFNXusE7Ho6Pi4N1RDc2GW1zeOmscoRk4cyoQQ97+m0O3nQBRzvmICh7Pz662GO9dJSbosDevQ35CBM3vw79vg8JnKGK9Vjw7CO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpGT41MT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0A1C32781;
	Fri, 10 May 2024 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715356347;
	bh=h5nTT0Du2UCghXIKEWt0yFqx/MaUNSrO06p/4aGpyvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpGT41MTOaFu1jCl8Uwvjdbh7Qn5oQcrzA5iFcUPMJ79nJcka2C6bP6oax3zjb/FP
	 yUxMdrhS620X8kneqIwlE5uIoc48ULno1WIuo72+dre55FfN+be/Gj4Y0Wcbpsblnz
	 Bb8a4ZjijACzy+sJ1iJZ+/VF0EJVb3U7+b8UrEbkp6VJhM2wEfyVAJzah+RrvSzg7B
	 ePyM8KzPDyvlmXd9zfBlRpurUE1oM8dC8sIUh4QqYR4lTbAQF407kWs3m3OpH5zAab
	 ovaRCs0gstD861+gqxwTbl/R/gfXuf2inGSiBee3JL/4OjnLKb6fL9G52CAoCuBLPG
	 +bMbd3oyrzLjA==
Date: Fri, 10 May 2024 16:52:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org, kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, frank.li@nxp.com,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <20240510-daisy-overkill-99c4bee476c0@spud>
References: <1715234181-672-1-git-send-email-hongxing.zhu@nxp.com>
 <1715234181-672-3-git-send-email-hongxing.zhu@nxp.com>
 <20240510153849.GA308062-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wr3y6L4YTPWbkVH7"
Content-Disposition: inline
In-Reply-To: <20240510153849.GA308062-robh@kernel.org>


--Wr3y6L4YTPWbkVH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:38:49AM -0500, Rob Herring wrote:
> On Thu, May 09, 2024 at 01:56:20PM +0800, Richard Zhu wrote:
> > +  fsl,refclk-pad-mode:
> > +    description:
> > +      Specifies the mode of the refclk pad used. INPUT(PHY refclock is
> > +      provided externally via the refclk pad) or OUTPUT(PHY refclock is
> > +      derived from SoC internal source and provided on the refclk pad).
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ "input", "output" ]
>=20
> default?
>=20
> Really, this could just be a boolean for the non-default mode.

There's actually a third option, or at least there was in v1, unused.
The description in v1 was:

      It can be UNUSED(PHY
      refclock is derived from SoC internal source), INPUT(PHY refclock
      is provided externally via the refclk pad) or OUTPUT(PHY refclock
      is derived from SoC internal source and provided on the refclk pad).

I suggested that there should be 3 strings and not having the property
would mean unused. But all mention of unused seems to have vanished :/

--Wr3y6L4YTPWbkVH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj5CowAKCRB4tDGHoIJi
0jCbAP4o1fystkUik1QzniCgEWNmiXcfwOndTsN+6kqytNqrpQD+Lxdi0pmPgkTY
MDMSv9vyFHydgHukhatYEY2utuVzXAo=
=mJ4j
-----END PGP SIGNATURE-----

--Wr3y6L4YTPWbkVH7--

