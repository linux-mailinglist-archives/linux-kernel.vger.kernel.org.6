Return-Path: <linux-kernel+bounces-576998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA80A71724
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1A41746ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A5F1E5B73;
	Wed, 26 Mar 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzr5k3Cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBF1C701C;
	Wed, 26 Mar 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994723; cv=none; b=UMqOi9aY2znKcZCJ8dCS/JGU8a/lSqCRIa6EXeipKoMgXJus+xhEahaLSFMJ8kubD+Z2dgUyItyd7sfCPvXbvMbME/JtZyKMXMgsP+BFdo32FSB+PrsFEBMy14FfP6lTCQY5v0vt5eVTC/JN7fR3vm/VSo81MGtNKaaKx1M0YIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994723; c=relaxed/simple;
	bh=xHZogpAlfVgjvBtrplSMrJoXKmiEydbukh1as+FD2O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVW/uIlCEu7Yssh/zc1jwHZZeyfSX/HwkvHTREF+VcZo5ELp0g0OKcFtu2ffcMqAT+sQQTlzyuVFuRL8ZYD6SriaFgofobOJD/JieJwlti7Cv9W+syheoDx+j9abuMRZYiRtyvxNmX+5MKpzgMOIQ98MRCS11SvgGIIOIHYR5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzr5k3Cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0C5C4CEE8;
	Wed, 26 Mar 2025 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742994722;
	bh=xHZogpAlfVgjvBtrplSMrJoXKmiEydbukh1as+FD2O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bzr5k3Cvlla2zMdEiiP86+F+aOlVP4en8Gqiz4gMNr64PaXRE4ab8T8ye3va1iE2G
	 lYkrDncOI1/ApyvnvY8nfPa23vB9eXVx04Wdr4cC4O9g/NnS+N8m7GSWXWITa4nzmP
	 XVRsRb7vyWkd/xGbzieWlb8ufbuJhGvvRY6lSX2CmX5+rSLrUaJMpsUvl7Dq9Kw1sf
	 xQx3K4ryHHUBt6gFX7HGCsjL5yGYukCc9t+71xZgCodnnmuAS70QkQYKGO2NApuFw5
	 KMvKS5uoU4+7ElBO/qGt2JmbeLoLyEdqlVs8eNZRhaD7p16i83t4gVhcnpGIOILZwx
	 C7BL9P8WJZx+g==
Date: Wed, 26 Mar 2025 13:11:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/14] regulator: bd96801: Support ROHM BD96805 PMIC
Message-ID: <e2f720b9-018a-45af-9fce-1241fa3c0fb4@sirena.org.uk>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
 <bf33c911e77254420f5481b98fde29041e8f7823.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="niBskJ8PwBoezgCJ"
Content-Disposition: inline
In-Reply-To: <bf33c911e77254420f5481b98fde29041e8f7823.1742802856.git.mazziesaccount@gmail.com>
X-Cookie: To err is humor.


--niBskJ8PwBoezgCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2025 at 10:56:50AM +0200, Matti Vaittinen wrote:
> The ROHM BD96805 is from the software perspective almost identical to
> the ROHM BD96801. The main difference is different voltage tuning
> ranges.

Reviewed-by: Mark Brown <broonie@kernel.org>

--niBskJ8PwBoezgCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfj/R0ACgkQJNaLcl1U
h9DALwf+OGA6Eoy2jOF/SjEhoVfjSwKoG+6Vu3+cmCwA1yU7YXlPLFLGjCr60p+Y
Z0q1p8HxycwiTCalJEXf1kVGMd0xf35MUo98FSEOVKeH8L/4IkooiAWIcaovfUpx
i5ZtuzzqUOXFlxS3ILcvfZDu2/HqoW/doTht0ZBcf/Y1wthrpZL0vA0zCUbFF17B
aIsOUzo31uTo72kEqaxzVm3GDJ5Qth7qT6PUWwsVvXE25dWRSjL1+/qEL0hYFq3G
LITYNnrPcaOpjD4r7xvq2eRpkhSNuzMJvAHPNKpmTQJxE8wZ4XHXgvYTpaglR5wN
4jNYMHl7Sq4KYddG0sN+8EYSkRq+aw==
=GuJU
-----END PGP SIGNATURE-----

--niBskJ8PwBoezgCJ--

