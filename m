Return-Path: <linux-kernel+bounces-261219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF1893B44A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7D81C22AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A5315CD4E;
	Wed, 24 Jul 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc5f9Aeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A018040;
	Wed, 24 Jul 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836229; cv=none; b=HuoaT8T0HEIbB8EzUj3qhpBNE1D3G3Kdwlt4k9u/+RTw7xp8hO907EysvC5yhnnjAA+5IWb95I3SPyum5EMiyn4yvRpLzWOsDKnaso4DPvns08WoiNSlUGGVreXxs0SgtZ2cn1UBxA3KLIgPlsKUctkIpmCz+lnN/nOfoP3ZsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836229; c=relaxed/simple;
	bh=g3UkQhtxOEYhTAqwiAPfIujEwIw2cQvsv3mHFtPrLo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdQYzES+IxEgaFuMm/jXdAbqE0BjRUPeEDLTQKLw2iePSlWR/hrWWWZipAtsjmPmIhCyZuZapN9JgQ296fKnxF3vtSSBkaTxsBqjqx7FVFel7C33uvlcLa29m9XuWZ8aQDcmBn8WSVQufubFz3rATYDCxxUnu5S3mwoqTBINefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc5f9Aeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B798C32781;
	Wed, 24 Jul 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721836228;
	bh=g3UkQhtxOEYhTAqwiAPfIujEwIw2cQvsv3mHFtPrLo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kc5f9Aeqmk4Faoy9bk+QNC2XADrEY8DNUUzEMPIPtmAslLpaozZXqAlqLp01nXFmq
	 3ZhyyGaOyZfsw8U9gQ+osirLzgIiL0KqTuLi8gsX6UBJfh/rpyGqlrF4hRS3pR5l2h
	 sKZSTUirFli8nZfhmCjl/GXY8yyHUtGnQe9+47vNKFNa+MvRjRPRBhBXkdp/upSmn+
	 6PzyrQPAIP/PfvpTwP/3F8PmmbKmyvmXo6qiaX9a+SMxQHouJFCqEkGUm7MO56W7fh
	 aPPxdQlUzEzZMywENFtfmzltRizEXKszp3fIktWyPDIHKyzeuTixncZVMqndKSs78Y
	 xdnVnIwBzIv9A==
Date: Wed, 24 Jul 2024 16:50:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/2] dt-bindings: soc: renesas: renesas-soc: Add pattern
 for GP-EVK
Message-ID: <20240724-visitor-chamber-2213a19ef345@spud>
References: <20240724094707.569596-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240724094707.569596-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rqRisfgSFY38S1bG"
Content-Disposition: inline
In-Reply-To: <20240724094707.569596-3-prabhakar.mahadev-lad.rj@bp.renesas.com>


--rqRisfgSFY38S1bG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:47:07AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add a pattern for the Renesas RZ/V2H GP-EVK board.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--rqRisfgSFY38S1bG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqEiwAAKCRB4tDGHoIJi
0mPvAP96yeYEPFviHQBJeWtmYroGVt73mMzDzIKkMSVA4q8hRAEAu0jPNColzXVr
iBvqkvRR/RZpJH+Xxg7zvT0wn3/XIgs=
=I8QK
-----END PGP SIGNATURE-----

--rqRisfgSFY38S1bG--

