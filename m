Return-Path: <linux-kernel+bounces-404703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F19C4701
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2679B28A98A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1DF1B4F13;
	Mon, 11 Nov 2024 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqzaXjvB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B813A250;
	Mon, 11 Nov 2024 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357522; cv=none; b=IO6WHQSWCnT2pz3hO9itwqaUf1m4evvLn3jPHlbKDEEZFKYv6beWFdzKhZUJ5fJRcSt9zZexdVUZOFNtZLO6Kgv9V9x0m3u5VyaUVAdeCtUrLOjIr7obDYLcyZsILcr97prIbkTF1OmhqRz64VkrVMP4lLnOlO+lZdExgTbk7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357522; c=relaxed/simple;
	bh=152E4AMyrFyVth6NJr4o1obdZxNFdCxTvLupPgHqcR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvjnB1oV/SflyzlHbhF9OuVFQYvrwvKuVEvenbLjj5XrZ3bqnASd40PJ3uSxbpkU9SvZQ7F8fcvHbBclb7xsI+c16faTbhy2UkteSWZIV6+/oEmrXZ9HQJZokFuVagqIgK01VFXOm27NQRKPCGBuCNb+bK4JtMkVOXr9U+OZq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqzaXjvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128AFC4CECF;
	Mon, 11 Nov 2024 20:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357522;
	bh=152E4AMyrFyVth6NJr4o1obdZxNFdCxTvLupPgHqcR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqzaXjvB+eygq7637ZG7G/eJ5DM9U1D/pEckw3OihBILO29k9uU9UKAExc6gUejDR
	 NJRBYI445rRLUb6+SifOvLM3JKo4XiK6GcF6W7ueCowXgkGbvn0CPV/ekjADy238BN
	 W6tuP1tdsLspbn5ebmUEBoAOvg253VHyT8CbzcUZnte5wvuKjc/im1hHhCBJL7yTC9
	 goRxy6NBkKIOikKE5/j4uO3wN6Gu7wqW2jp2TdOejvH9Vn6MXrshK9g9LsEX7+sTgX
	 DFmWoRu5n9xsopGs+4zkGjKmOesHtKiCFl7aWZJeG3BMq3wg9/PIJXDvyToaxTHHbN
	 l06hr/n1QyR2Q==
Date: Mon, 11 Nov 2024 20:38:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 08/14] dt-bindings: usb: sunxi-musb: add Allwinner A523
 compatible string
Message-ID: <20241111-harvest-excusably-5e53d1fd362d@spud>
References: <20241111013033.22793-1-andre.przywara@arm.com>
 <20241111013033.22793-9-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pIS1unl9HesvjYym"
Content-Disposition: inline
In-Reply-To: <20241111013033.22793-9-andre.przywara@arm.com>


--pIS1unl9HesvjYym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 01:30:27AM +0000, Andre Przywara wrote:
> The Allwinner A523/T527 SoCs have a MUSB controller fully compatible to
> the D1 (and ultimately the A33), with five endpoints.
>=20
> Add the new name to the list of compatible strings.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--pIS1unl9HesvjYym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJrTQAKCRB4tDGHoIJi
0sMOAP950SFaA8lr6xbPJAxQ1ITCDG/C0OzjBW9aD/2hFBhNHQEAnY4Gt9XMpOdC
iHYyvhfePxdmMQPg4fhAUFLOEusEBQk=
=KMGT
-----END PGP SIGNATURE-----

--pIS1unl9HesvjYym--

