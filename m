Return-Path: <linux-kernel+bounces-217861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6390B549
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3864A1C21D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCFF823B8;
	Mon, 17 Jun 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrbvDZL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1153A9;
	Mon, 17 Jun 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638502; cv=none; b=b1SbdtZ9F/lNJW85apyjRVS4xGFSiEnI5YRBCzrPKsI8yRono3WE7GrFNo183vx1MYhWKz7odU5T8DzbSeSzb4+178bry+r2MZW4oI+YHbvkJF8hU/yA2FAB8bVpYw3Fb/PCnD751RbKqaFbVUy2J79DxZBrF2RevTpglxf4bI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638502; c=relaxed/simple;
	bh=grR1s7RKpWZF13XxMA4FtYCxgLp3SDkiH+HdqW2aTRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCyvRZIcFZeIsz5uX0AbGJtQ3pzxzIlqdZ8lK/fiTO2HLWTWbWaLJBiPhsnhETGG0xuWy8+TWehRM0N41QPHii091OLOFbBM2s/WpM1+38QHa8FrtF0JcRWJCl7Cmo2TdskMq8mE9lL8CIkX6lVkTbllyPEiFP1GHnYddkgJCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrbvDZL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82637C2BD10;
	Mon, 17 Jun 2024 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718638502;
	bh=grR1s7RKpWZF13XxMA4FtYCxgLp3SDkiH+HdqW2aTRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrbvDZL1FByS8PJzARaNP/hjLo6drwAbQ4xt9kDqTK1T6+TnR04c72ORjW2kBzTPh
	 lYewQVbK+gmlx9uUnd9tk9qnkAemR3cHgnPTQKOKaorwG/wsDrOfe8d9fp4bJLGr5Z
	 UZXC4K8kKTNgvNHheXAa8ub+WBUZtR+DVWdDN7/DYSmtWnmXxsbXfUxhdSO+vatlhV
	 ZIINXQY819csOavUVe1nyQTS2AfYJlslQKjrVJdB2fmDigbH8mD7yTusjt5yPoF7Wb
	 0X2Di82fPHWRn1fDVK0yOFwk0X9FIHpr52CgYdGvwWE4IRCMEbr8jbXF99wscqrdc0
	 wKCMR8rHUqp1w==
Date: Mon, 17 Jun 2024 16:34:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Explain lack of child dependency in
 simple-mfd
Message-ID: <20240617-paternity-subdivide-a0613f609a3d@spud>
References: <20240616080659.8777-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gsj6t7Q5c2e6Vkqz"
Content-Disposition: inline
In-Reply-To: <20240616080659.8777-1-krzysztof.kozlowski@linaro.org>


--gsj6t7Q5c2e6Vkqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 10:06:59AM +0200, Krzysztof Kozlowski wrote:
> Common mistake of usage of 'simple-mfd' compatible is a dependency of
> children on resources acquired and managed by the parent, e.g. clocks.
> Extend the simple-mfd documentation to cover this case.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--gsj6t7Q5c2e6Vkqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBXogAKCRB4tDGHoIJi
0tbOAQDXJwLF1nqecw8UoRRNUVWYrYdaiKCPro3pn9ArMNWKkQEA2Ng8VHqlAK+2
0sIPvf2BnMO5vyAlwORx4SRSFYOTfgw=
=RQg7
-----END PGP SIGNATURE-----

--gsj6t7Q5c2e6Vkqz--

