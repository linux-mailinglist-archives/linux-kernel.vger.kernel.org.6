Return-Path: <linux-kernel+bounces-189328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5008CEE73
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A599B1C20C29
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733FE23763;
	Sat, 25 May 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0xqV3dQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401AB644;
	Sat, 25 May 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716632372; cv=none; b=OJJZGvkKa0i/aKIiFknja6YOxQlbFXCGPPOlXyEAW7w0rfpMwAy+RkCPe3Q1tm0NI+V+SEaqLn7hMfnyICUbCrRK6Iv23GOWuO3bbqxaPUAhU9yGWuMqUXESi8HheTotyTxFYT61b39H2gO/l19glPfFn5d5NyfiS9RBct9rDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716632372; c=relaxed/simple;
	bh=GEtQE9d8Yn1WvXllKSgrZAhXcyiUxoBo9ZbhfRtOF2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGyk/hIROlscc06AgiHjj3FQSB82VEQDbbnjUOo5VNXMXcvZuYq1MY8Q/8vkjJF+h8dsn0LKKA0r/1ownbsteDRfqqKoqbz9geopAweCf+REdlClDpxNkVoVUZWzOOGwhNDSBgDkSVNkZLl/H6MOFFoycBa0JI9XAxTEwe9GaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0xqV3dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5271C2BD11;
	Sat, 25 May 2024 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716632371;
	bh=GEtQE9d8Yn1WvXllKSgrZAhXcyiUxoBo9ZbhfRtOF2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0xqV3dQMCnGMnVF1dKyC6o567uZNkhV9rPMRa1BsN4v9VsV41MeN1V5nM6HoxE6N
	 VCc9V+Aa1Wa8Wt16A2rY3Qqrc7LQAkiOwo6cxY+WLyKaQ7CD2ZZLu6RDE9CQr/RKqh
	 0yGV2AY+BLzQy6oq7enrmiAxA+UmuPmsKhd2JhOopkY0g21ecgPTqyAY/4dTJDSFpQ
	 G4HnjAiFlSE2/dwI9ANZ5pHp+Gb6BhOfmN37ES8miFvF6ML22/t4jGpsUjQ8Uu4GPz
	 +IoaUYawKJ5FZhDfCHzdI9frEtMP6DyQfpC5zp9rScPEB3ynza7CHbxbQ89pkBD+HM
	 JIFB9BdsM5oTw==
Date: Sat, 25 May 2024 11:19:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Henry Bell <dmoo_dv@protonmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: add Star64 board devicetree
Message-ID: <20240525-dumpster-bootlace-10123081a6f2@spud>
References: <IPHlm5mOKUzYfwGy0auyufx-oPkSrtQjUjiQLbtvspD69UPX9O98iB8P2mqM8ahNaerz0yUa009f4XABRniq7aj2PUp83hbRVVhhKmqT0Ss=@protonmail.com>
 <1b55aad1-1442-41a5-acc6-16baab90c021@web.de>
 <caCBlFpvjmhO9G1A1_2qHImmuoGai2NoPYonB5RCVftq4zIrSxlP8Msh9z_FX9GwQXzfSrB40dRxy1zfxZesOJENeebWQsERa03sDvArzec=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zBnxnZGrJKN+COkR"
Content-Disposition: inline
In-Reply-To: <caCBlFpvjmhO9G1A1_2qHImmuoGai2NoPYonB5RCVftq4zIrSxlP8Msh9z_FX9GwQXzfSrB40dRxy1zfxZesOJENeebWQsERa03sDvArzec=@protonmail.com>


--zBnxnZGrJKN+COkR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 10:12:01AM +0000, Henry Bell wrote:
> On Saturday, May 25th, 2024 at 9:37 AM, Markus Elfring <Markus.Elfring@we=
b.de> wrote:
>=20
> > =E2=80=A6
> >=20
> > > The board features:
> >=20
> > =E2=80=A6
> >=20
> > Would you like to add an imperative wording for an improved change desc=
ription?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.9#n94
> >=20
> > Regards,
> > Markus
>=20
> I'm happy to change it, but was going off the format used in Conor's  Mil=
kv Mars commit
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?i=
d=3D04a228aadb84d894721b13197649ca741f3018bc

Don't worry about Markus, most maintainers (myself included) ignore his
comments on patches. The commit message here is fine.

Thanks,
Conor.

--zBnxnZGrJKN+COkR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlG7LgAKCRB4tDGHoIJi
0g1DAP0cerJgoJ1QbePZ3OIiXM8U1sbG7LwZOTp2PBWIHtGoqwD/Y2XdrtdG2baF
6xx9pkdHbSMu4P+OVp3QvNjcguSVaAU=
=DDPZ
-----END PGP SIGNATURE-----

--zBnxnZGrJKN+COkR--

