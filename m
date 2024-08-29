Return-Path: <linux-kernel+bounces-307281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE1964B41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA0EB2662C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CFE1B5806;
	Thu, 29 Aug 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOcP+z4e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482F1B3F0A;
	Thu, 29 Aug 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948057; cv=none; b=m8/rwfCR/EdAg6oQQlI5NVCL5msiwvYQ52KXVByenRMMnM2lQuA0YLcrl3jzH/HHHiDUlVdEhkDc85eOJeZrv89gYP/iyPwPE3IdZRpRDO8l6Ke2IpI5SsFdFSffsT4snANYyT01O98h8aTuktHUw4HCui1Nfe759Ykl1pQldCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948057; c=relaxed/simple;
	bh=jFFhRqDh6sk6kKrFj9zZjti5kjMNz6/tJuy6caKkumY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+pI6QucuKEXGTYT0Ee9FqGyfsv2shm7a+CU0MlIM829+zJRdtkCBPs+qDxbG5pl+XNxd+n9d6hn+9tkZ0JDL1bYToWsUINTJ/vWQ9fKfpvrXQoO2cg0nmErv85wLKCm6TB6YwvmZGbhkbvVajivGsX37UjUR+JM66eOViP7++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOcP+z4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162C0C4CEC1;
	Thu, 29 Aug 2024 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724948057;
	bh=jFFhRqDh6sk6kKrFj9zZjti5kjMNz6/tJuy6caKkumY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOcP+z4eVAg17U4iCTI63gCh8c01ykOJ19DI1cltBo2qLY5SL3YXQMnfplVUadIDr
	 km9LCH+8mjkzd5O2UMT6OkaMjSIjTsdHPiwaTm7TuMxqlJwRMIGq/Yd4VHBIZtPyJ8
	 e8nk43TXELOPcCEcZ7h6ayOTezXXcPqN9W+O4v4N8oxoPB4QRf2/vK+unjCSBGFhhE
	 5X+0Ku2RNmzZ2ep9/KJdzgPcNOUO8tNUEZUIBh2IaHX6JtM7CdgIqtw3cFrNWlRp8p
	 RhJrkhByU99ffvz/z8WHwtb1K4ENa7/BGeZ44gQhhP7v5X5tAqJPdq9QGmz0vwUgEL
	 INSB3V9qFWEvw==
Date: Thu, 29 Aug 2024 17:14:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Romain Sioen <romain.sioen@microchip.com>
Subject: Re: [PATCH] dt-bindings: ARM: at91: Document Microchip SAMA7D65
 Curiosity
Message-ID: <20240829-oxidize-unnamable-eb08672ae694@spud>
References: <20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2LGDO3hAWblRn3LD"
Content-Disposition: inline
In-Reply-To: <20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com>


--2LGDO3hAWblRn3LD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 03:27:42PM +0530, Dharma Balasubiramani wrote:
> From: Romain Sioen <romain.sioen@microchip.com>
>=20
> Document device tree binding of the Microchip SAMA7D65 Curiosity board.
>=20
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2LGDO3hAWblRn3LD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtCeVAAKCRB4tDGHoIJi
0qpgAP4jdqbWq/SnJzsy8ruNKQ4DAQy/eGG3bhwmcIsu/0sgCgEAsfpNiKVJwhI/
Ne1q1OOLwPx8PbRb5Cpa3ubJvXuBlw8=
=2G6T
-----END PGP SIGNATURE-----

--2LGDO3hAWblRn3LD--

