Return-Path: <linux-kernel+bounces-219957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58CC90DACE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E888F1C23443
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C7145B37;
	Tue, 18 Jun 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZfnil2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C6142652;
	Tue, 18 Jun 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731994; cv=none; b=NGl2BH2fxu0qcJBQUFrChPg2Z7nszLY6Vw9TC3VK0NnS7wjrWThRMGu4teHVlvLuZlHdeR35t1SF9oT+jyqU0WVTQBKcavi6FmBQy878DdopxMTmqydDpe+HpIy4UlHF/XAHG1ot8dTYM4U974R2CQKJ0UHlGGe385X7X0iip3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731994; c=relaxed/simple;
	bh=0L4i/n2ZFqvXgwQg75SvA4/YJIziwcBjduldDYgP+ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R175IHowcX6qbPEVPuS4+q+qbpSFrJpvBeER4RF/w7OsXAsppYsWB5LL3SJ/wTrDxGx+nIIcqbap2RvgBVvUYRN7u86rsf9hz9hlBJnk09kLeMw8MCX9NhU1Dfv1XrdjN4ST8jfQ+SLOaS+JYlOr9m6RTOYorHeF8EERBlIRsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZfnil2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D180BC4AF1A;
	Tue, 18 Jun 2024 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718731993;
	bh=0L4i/n2ZFqvXgwQg75SvA4/YJIziwcBjduldDYgP+ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZfnil2TODyVZYemiqFKCutqAZ6bo1JAfMc36JJsHpkE82EjNymny2MSTsnVA45Xd
	 G9Prv2ey4gf40XfFBU2Yx6FfnMNdTgCPN+5yQCGUjoNsqZ0ZNwMuCpFvMTHFWdElQJ
	 gNYPbzYn1Fnf1STgwqD4KfOyv/6OLD/osoP1RqOaCZ3QzBhHGmufyGG2iFdKZ0xeLp
	 mT6nllFM71EuI4XBHzU5eKVqVHabFH89QO6scFxNbU4bA1nMkDBnvAmr28iwLE/jp5
	 KpmI3OX8MnWu3azWS5p7RP0f+JU1ZRKHZT9/fyiOruzab5EFzr6Z5AEWRSZUoyUf2P
	 YO+piZ2Af6tEA==
Date: Tue, 18 Jun 2024 18:33:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: ti: fix TISCI protocol URL link
Message-ID: <20240618-crinkly-bolt-a34e138e081a@spud>
References: <20240618150933.1824185-1-richard.genoud@bootlin.com>
 <20240618150933.1824185-2-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QOXbQuT0eKpAgS+c"
Content-Disposition: inline
In-Reply-To: <20240618150933.1824185-2-richard.genoud@bootlin.com>


--QOXbQuT0eKpAgS+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 05:09:32PM +0200, Richard Genoud wrote:
> The http://processors.wiki.ti.com EOL in january 2021
>=20
> Fix the old URL with the new one.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--QOXbQuT0eKpAgS+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHE1QAKCRB4tDGHoIJi
0sslAQCvfE3ZoDokWWpfnehbX3tm+2z2nGuT4v7ZkkOsTn1aWgD7BrA1gVywDP10
CvnE9ykGhRQDdTk16dqbOaFdmi9/Bwc=
=m3jU
-----END PGP SIGNATURE-----

--QOXbQuT0eKpAgS+c--

