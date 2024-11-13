Return-Path: <linux-kernel+bounces-407732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58919C71E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C9A281942
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B122339;
	Wed, 13 Nov 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyeYqeSG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CD259C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506477; cv=none; b=B1opitHERBzNyFnlOUuPLcF6oM/TPchdtoRj32xGD/88j5bgL9BbNz0Am+GCIJ+epxCivjT7ozxkhO5/dlmU5elygSn8vMYQu9ozOSNjymMtPSg9CrhlQVvdD2GhddoHzqaSHMUa9TGaCayadEnJx5I+5z+DACiS5cinltNlnR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506477; c=relaxed/simple;
	bh=Z1D8XCIvqnLwZAAo01nfwUI8vsB1UIqN5Pb3de3OSjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF46ca+L11YPxVFF2xsYVUuLCyO8wJly0m7a38duuOHddCwQm6t1XBFUH5ERnzlH2P3iMZkxUwnC3aE7xsDaagWxTd9M5D3Yefpv0zhkLtLH9eN/riZV4ZL5E/nOgJaeVCf6DSm4pObyP5hsPGhhnd/LmPOZM7pkE+LWFe9bg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyeYqeSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5883AC4CECD;
	Wed, 13 Nov 2024 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731506476;
	bh=Z1D8XCIvqnLwZAAo01nfwUI8vsB1UIqN5Pb3de3OSjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyeYqeSGo/6YT01PwMwOTVp/sPgW5nE/f8AjA0JU4Ejw5Cpr3L/O7jpnMCtGWt410
	 AfE2Ujbk+yIxnhsNazp35KK1V4dE/CACgZdhjII7Gh9psGVDo/pGwgU1pUKc59+RIW
	 jRdGsaIMKXwVeTeon3BNERnV77Du2n3getXSGeOmD49bZtyCPpLaGNazIc1lDfU0Kv
	 6bDfnviDWXTnlAqXlcm/XrvLOmjJxlpPvJAsHgAmLEw26IPgIC1+fElAcMaYQZrv1q
	 kBp+rQiibHMniN0/2e3RQEaXDPLNGIGUQ0myO/L+vFiQl0OUjN6A7atwjr3YZg46rS
	 5WkH/r1G6Baqg==
Date: Wed, 13 Nov 2024 14:01:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: regmap I3C support
Message-ID: <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NTUw8CqGx+rHsfrn"
Content-Disposition: inline
In-Reply-To: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
X-Cookie: Editing is a rewording activity.


--NTUw8CqGx+rHsfrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2024 at 11:07:40AM -0800, Guenter Roeck wrote:

> For simpler I2C / I3C devices, there is module_i3c_i2c_driver() which is
> supposed to register both the I2C and the I3C drivers and handle the situation
> where I3C is not enabled.

> That works fine unless the driver uses regmap, but I3C and with it REGMAP_I3C
> is not enabled. There is no dummy function for devm_regmap_init_i3c(), so
> a probe function for an I2C/I3C driver utilizing regmap can not be built
> unless REGMAP_I3C and with it I3C is enabled. Ultimately that means that
> I2C/I3C drivers using regmap can not use module_i3c_i2c_driver() to register
> the driver.

> Am I missing something ? Otherwise, would it be possible to consider
> a dummy devm_regmap_init_i3c() function if REGMAP_I3C=n ?

Don't these drivers end up with the same miserable problems with
dependencies on variations of things being configured built in and
modules anyway that mean we build separate SPI and I2C bus wrappers for
the same case with devices that do both I2C and SPI?

--NTUw8CqGx+rHsfrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc0sSgACgkQJNaLcl1U
h9ClYgf/VE66WV2rga07/KfqQtduqasjWxnyes+RJoOlYObXzDko2HuBVIXdzvSM
4V5Wt8nv4sOB2S8f8Tr0fsWFUvbkDjdd/MOUFO/fbSz3EYvvIy6OT6yA8ntW9mGL
zOtWpyD2uTbA2Zqu8Y1NXAUz4Dxwikfw8aAMIGPdeN9OgDb1KMGn9Gzzqo8yiTpI
0miOKcTdYAANxXpQh9KaubVyBRuVhLV3STk1QtBGp31L1OSNXTlsWbcm73RPDNA4
H3GqpgIMsUt4sEnE67uZwhlgwXqK8T6t9hqOQjwoi9TrHMjezDKGdglkSFDHkAMi
UcbfhEPZkAV4dx98fCADUPqZJqQUPg==
=6w2P
-----END PGP SIGNATURE-----

--NTUw8CqGx+rHsfrn--

