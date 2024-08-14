Return-Path: <linux-kernel+bounces-286952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B209520C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A27D1C217FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE31BBBEC;
	Wed, 14 Aug 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR10n7Uz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029E1B9B48;
	Wed, 14 Aug 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655541; cv=none; b=tWnTkXJOHWsqC6IIVgdmosZL7WsTjdbTIIbbsojl/0zPz/L3gOceIm2De4NG1iahRCKCQmGxRz7p11cbdw1YlExAmOZmgTGnVAv+Tfd4aCSuibKEStCWpT618p0Z2jRkT1QUkYdhAhnFp3ybaVAwa9y23P69zGdECNpGdBTR7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655541; c=relaxed/simple;
	bh=0SnaGwuuwdhAmGTBrhF6fl3MkbG/FdzPfWPhS4PDvUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq9UuJtPNsTTswOlQNV/ueeukaXO6DcUUfjdRZPp2rxOl2uEmjGvZyUYSOldOGUIe/CUZVtKBsRZhRUrmGCxv7TH07Rd4jkIZB3YyeYT3H25Q7sZUd7uuzw6pwnJJeLVfXw0qq1GSGPHCHy6uMmMuir1yiJ8iljFQLWHU6i9lfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR10n7Uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E98C116B1;
	Wed, 14 Aug 2024 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723655540;
	bh=0SnaGwuuwdhAmGTBrhF6fl3MkbG/FdzPfWPhS4PDvUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BR10n7UzYZ/Y/4KBXz8/jl+rwVIYLXmy4wUc9bDvaw/L/m/t3UxRwT9YodWIm+q+y
	 1gtXAPVK0Y7f5tcX4/zRmNPVxcvH8H2K4f4GPoGTHYYpaZduMIAPANZyOaxzVuk0dX
	 mrdrlfJnXv0vXxpQyQKPK2Yg5W2PS+gEWnbQlWDs6Uumte11vpcGseBvUo+UbWjK8k
	 Px2YNGJIQLGrC2XSMtss171VQekqb+mqMR2uBOcTv5PWoHpKwqN8lNBADyRbib0K+c
	 UnVMC5DgXFHqEIjf485UJRmRY/ozTxHIIC73lPJ+BlzQ5fQ5UKXWe6hshObfEBkj9D
	 /xVzBG8ol81yw==
Date: Wed, 14 Aug 2024 18:12:15 +0100
From: Mark Brown <broonie@kernel.org>
To: jau@free.fr
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sti: add missing probe entry for player and reader
Message-ID: <d761c2e4-5b75-4306-b33b-c71b7c132a05@sirena.org.uk>
References: <d85590f2-88b3-4bc2-b7b8-9f96a5d5bb17@sirena.org.uk>
 <1474761635.17820466.1721651484902.JavaMail.root@zimbra60-e10.priv.proxad.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R/+/yIv+8uVKHw9G"
Content-Disposition: inline
In-Reply-To: <1474761635.17820466.1721651484902.JavaMail.root@zimbra60-e10.priv.proxad.net>
X-Cookie: The second best policy is dishonesty.


--R/+/yIv+8uVKHw9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 02:31:24PM +0200, jau@free.fr wrote:
> Thanks for the review!
>=20
> See updated changlog, if ok for you, I will send a V2

Yes, that's fine.

--R/+/yIv+8uVKHw9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma85W4ACgkQJNaLcl1U
h9BiBQf+LNCJki3pIICvAn44DfIbYhpt5xch7PprJjws3hbz5qlLtHgElYrh0Sc/
A8TjvkmpTO+4AF3WJ7nfqyWBDdjn/g+Keh+jl08EshrcwP9PGexpYAi0xIvAngWV
APLx1czpzGjXj4AAwFVrL509W0BDtAJDWVAw4wFUVh+Sr8oBsJFlyqMfLHnwdXvL
az04rWqTZI/SfFlL7y57Fqr63sgpIvJudIC6L7ahPm1ZbwLKX0TIwEcYCZZWKvrl
/7Ifr+Himsr3DSRvuNm9NtTI1weUaRxXW3HIWS9uosDbmQrbcou9tGoe3l2hIWwg
o8kUoguDJBoM3RyFbKoSHzxDW1DGJw==
=yoSn
-----END PGP SIGNATURE-----

--R/+/yIv+8uVKHw9G--

