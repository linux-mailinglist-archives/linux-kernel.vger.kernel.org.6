Return-Path: <linux-kernel+bounces-337331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D19848C4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514CC280EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3771AB6C5;
	Tue, 24 Sep 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMcU/FrB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E031AAE02;
	Tue, 24 Sep 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727192052; cv=none; b=mKfG412bgmn+ZglTOOgmqCA2Fuj0wA31vMij5hOPWjKZdaBFJpaLfL8t8IRDVRPfybb+q8594tdg4mcCSjZX1tf/7dIzZO0QoZPeaXE/c3mALIvRSzzviyiLAujbfOu0L25rect5oRd5DyO9WDhhgVT6Kr6SX1KMw8GFvULL/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727192052; c=relaxed/simple;
	bh=ENZIpA/dnsrYR6JQ5F3ofDRBWeY0UiXAfd+UrgTyU10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF+dgcAtFJAJNAU4eKWi3lSePlGbjQ7VTu0RaRYO8zUY0iCmPfRVTnRLmFaY+NpT1R5gWiUs/lnMg+Ftp0g2TrXKquWM1veuCdw3TJpbBwN3GN9dKfj0sAsVihN0BkswkbRKM+H8vO3LOduxhhvV/8DttwwMNHLsr79p1Ic7U2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMcU/FrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB52C4CEC4;
	Tue, 24 Sep 2024 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727192051;
	bh=ENZIpA/dnsrYR6JQ5F3ofDRBWeY0UiXAfd+UrgTyU10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMcU/FrBSOD8rLPU/9iVFeSev3stMlKwSRs2/SQJ3ymY4d78nOXK1/RXd+dnnohN6
	 na2ktd/qPhtzSCgU0hCOKYonwmkao/DZuL3/kccvUVLUd13g7C1KFbYOYAJvjZ4mMK
	 WsvikXjpZn1JDnNsxGZXkKNzng5Bay1o1v8BAE5tvE1PYB+HUUrLyajFWhpt2hJ37m
	 XRTBA1t5msGgVZAaTbEucj9gYR82nmgpTFIMlzqRUrEBHNJqHlAFlvGnhLK7jpp6Zx
	 uFTnNULSjM1fVuAWyNYF8r1L6fs8AuhDSJEe9qhd6GpMTH257LDCut+cWw7Jy3D1GL
	 shDdBl5BKIUwA==
Date: Tue, 24 Sep 2024 16:34:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: arm: freescale: Add verdin imx8mp
 ivy board
Message-ID: <20240924-posh-viper-3c929dc63f08@spud>
References: <20240924114053.127737-1-francesco@dolcini.it>
 <20240924114053.127737-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xphZM8ukWYw8uIX1"
Content-Disposition: inline
In-Reply-To: <20240924114053.127737-2-francesco@dolcini.it>


--xphZM8ukWYw8uIX1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 01:40:51PM +0200, Francesco Dolcini wrote:
> From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
>=20
> Add Toradex Verdin Ivy carrier board support.
>=20
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
>=20
> Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--xphZM8ukWYw8uIX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLb7wAKCRB4tDGHoIJi
0hm1AQDw4tXY0MWavUrtxUAi07M6OwuB44WcNkrKsg/nRFVujAEAjrfAaJ5asckJ
oPqi1qksEVh1k3Ib7DTjwvlfgmo6OQE=
=1+77
-----END PGP SIGNATURE-----

--xphZM8ukWYw8uIX1--

