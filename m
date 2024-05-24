Return-Path: <linux-kernel+bounces-189031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51A8CEA11
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9D71F24E79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6540875;
	Fri, 24 May 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSUslT03"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C783EA64;
	Fri, 24 May 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576929; cv=none; b=jLnu2/iBjTvgkk+cd88AKvwgAMwOwB6S1tll0crOLlynhMn6qQTskI/Y2oSAjBOB2XnF0I6LMZmP729ltp3fJO//U0jNkrJ99HQ9LUdql45puYqTCZKuWyNIcUarBpuxRi/jxbZkVhxbFUw+O2Op4njLTYvCi3qUdfXejJOhhUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576929; c=relaxed/simple;
	bh=V55crGx9DJS5MiBJVv/+LEY0ZPYPpfjGvUfBJMEw2h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr9H9XYLYIg82NzIOixIwc4N2z2EvoCu26DXUmoB/o82rEbvP/bk1J2avQ5j8tQE5rwzwtbPtsLpaRrxtIjHaHN7V0v6UWHjK9Nd0/IlEg6+9Mjjl7btAVpt3YSgX5wml3kEY6i6/h8/C5pwkV3kbU4VXZdT4bXmRUn5zKnvCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSUslT03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE30C2BBFC;
	Fri, 24 May 2024 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716576928;
	bh=V55crGx9DJS5MiBJVv/+LEY0ZPYPpfjGvUfBJMEw2h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSUslT03br2Zde0/wO+jMVdw6sK7NAOIuEh4K1LUO6Loi6/dV7aaBHppO7dblbAUw
	 BWx6lqAoWYfImY9bA9iA/FFycLRyYvWxZ63byq1VLzEupR7NBOteKJlPJ6uF1KDOzN
	 sfa8AcqlKS+amQnLqTc6jkaWxq724BT2jmvdMFqfgOfXLgBEY4E1gvLRGBFbd+T3ce
	 VFW+QkpBxVJ/vgOBRv+ieMzaUC46u18LNf5Vad3/SLXcRG3JWunFqjrskBY3xfUZ8p
	 7dqeFkE5i5zke9aMHvAMqto/yNU3n6F06wRQYtoWw8FooJaXhKAWDfKCohezy0Qwus
	 ijwmLFwU0fuUw==
Date: Fri, 24 May 2024 19:55:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Pascal Paillet <p.paillet@foss.st.com>, Marek Vasut <marex@denx.de>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
Message-ID: <20240524-reorder-tattoo-13af5d569e3f@spud>
References: <20240523180435.583257-1-patrick.delaunay@foss.st.com>
 <20240523200353.v4.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C5nojw+CH6iHfaud"
Content-Disposition: inline
In-Reply-To: <20240523200353.v4.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>


--C5nojw+CH6iHfaud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 08:04:33PM +0200, Patrick Delaunay wrote:
> Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.
>=20
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--C5nojw+CH6iHfaud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDimwAKCRB4tDGHoIJi
0qMMAQCifoMtFkXnySZ7EmWtDmoZFR86d/CLsf2nWTYn2dAs5wEAmlR2PAW4Z2ic
GAGmr55uU4Ay8/FGlfegcoU/KbXmKQg=
=HKMv
-----END PGP SIGNATURE-----

--C5nojw+CH6iHfaud--

