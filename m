Return-Path: <linux-kernel+bounces-435023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 281859E6E92
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62D718837D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD6204084;
	Fri,  6 Dec 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haeYVWbX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88619196DA2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489331; cv=none; b=hmg8BhN7b+UbsHxqITZzOTKiz4v7gXlX7DYOEcV9R4ymyQLEKbjJjykTtUkWFtKgx/8FyKyiezMiZslJn1n4JJMyon+7noBLuwEvxpGcTwocAlkPPLdr59K3jpetrSN2wiHGEyrmQkOWvykN4jcZAOPmTD1YUagbWeSBI6Nd2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489331; c=relaxed/simple;
	bh=3PEDAKBNd52jNupMMQmRGZXPifRpTvfZeEJs+8cFY94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZZZcB8h0rLhFN/8/V2XHen05QH0xh0JcaGSo1sBIF+IxsNFLkbwbBHCh5rRYHXd/m00YiaUqrvWYD6vGal3lKCuYzj/oRJ2xeIKFg0Pa+KE/VlgouDsRLvgC/qSxKAo/VbvuMMHWl51MWiSPAGF+RvgCt69YW/zPNKeNf7ZCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haeYVWbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165D2C4CED1;
	Fri,  6 Dec 2024 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489331;
	bh=3PEDAKBNd52jNupMMQmRGZXPifRpTvfZeEJs+8cFY94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haeYVWbXdC61XM8PHfVZILDPWDZAV3gXDAkJmNCCeJm2ET4Tibd/SqyZYblOVmvoI
	 YpbZfMQZcW1Jy56H1NHENTSkyvCyTA8TYlCT+UVIsaW+uUAzneRgHUCqscWmnHsbBU
	 94xynpqfdfVqj+F99EmK/RVeCYyLK68GhuBFA7YUBV87aT3yyTpWJ4c/r8NureQXDl
	 gSyOkVq99FvBmdbOeU41gTGlWH4j8oI3RcQLDEnPOKGKp6wEHqavwOAQ9yP03Qc/8x
	 2qQSSeFQo3z2htGesZsZy1zH7YDZeq8ywLsrg9zr93Nqo9TjWp+JOgJJs3gRBIvM2j
	 LTTHfWBpL4C2Q==
Date: Fri, 6 Dec 2024 12:48:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	"open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
Message-ID: <2ec677db-2db8-4a74-af76-d8ff1f4b2173@sirena.org.uk>
References: <20241206123751.981977-1-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WroFJT4ISxxr4uVO"
Content-Disposition: inline
In-Reply-To: <20241206123751.981977-1-simons.philippe@gmail.com>
X-Cookie: Sales tax applies.


--WroFJT4ISxxr4uVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2024 at 01:37:51PM +0100, Philippe Simons wrote:
> AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
> which is 10mV in our case.

>  static const struct regulator_desc axp717_regulators[] = {
> +	AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
> +			AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),

This doesn't seem to match with the above - ramp_delay is in units of
uV/us?

--WroFJT4ISxxr4uVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdS8q4ACgkQJNaLcl1U
h9BnOwf+JWI9gsmD74Fikzxu9PxwnCkwj0+yzsAHBXOePD9RPq7f6EuFsvhOSHJD
u7yk4NVQLo9aHVR4rXkGiRQTGMl3iks/nF74i9c6BjTgSFw5M45pexCm4IHF+lVG
o0cPwGR0sy4ZBKD8vLM9jRD6G6kEc6EOv8EyqQOT7ajglBoiXxOUdp+pG6H3Ya2u
g0iFlQ3cRHSWtQoDG/lPTKBE7AVOTaYRKNpBKjvPmBJts9a+TnhWc5BtZNGcMoUN
GAkJLDQGJ+yrArRAcZyfqIv2faiaN5Sir5F1CrR01HIaEwJHKJObsS1I8aNT7iHw
xKwHVLf5GOPEhPGNXjQ3S2O2drmWqw==
=24Q9
-----END PGP SIGNATURE-----

--WroFJT4ISxxr4uVO--

