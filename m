Return-Path: <linux-kernel+bounces-404212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE39C40DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87BD281F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D71A0714;
	Mon, 11 Nov 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oil0JbPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340D19F40B;
	Mon, 11 Nov 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335210; cv=none; b=p6lUuOfsqFZVOwvJiCmmQiJPoabkDcJpGKaoMZmi+uKNcSSEkdE7hSgmDAjmarAqfQ1qkBzzSqeDz4fZj4JDsxRniTWasULWNx3eY5C1njrnRa3B6zgG2V2+Lf2AqY/AcE0q7i3TOmjTEjGcudGrCCptfuCAjEqXYb5874nZOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335210; c=relaxed/simple;
	bh=XBDNahJlnARGUEaZz8m0NMv2JrYepQ1ZvgaixL0oOII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6U3QIrqDXoxcYtI0ijyIpAjugT1GCOul68PfVdhVdth5RJ3aQ8fqIljP3ZP6vOtxV+3PFAPVzKbt8viHEOh6axPqAHPeSvjUMrq3yAHD+h+6a6zVhUhRfr2UQwX0f65DQYP5Exy5ZsvZ4bxWIB60uPHLu8l2ybZbS93yLZFI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oil0JbPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A9DC4CECF;
	Mon, 11 Nov 2024 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731335210;
	bh=XBDNahJlnARGUEaZz8m0NMv2JrYepQ1ZvgaixL0oOII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oil0JbPCpsqxd+Dd1hvtjCgMpQ5r02SEhHcHPV+4OHrFOXfjhuv0O/tXNi8DQbX/Y
	 heKkvTF6ky84ClfT2q1wHUae+UOY6xb+5EXXXg2r39YHBu+/62xCEmYD//a3Ns/kMb
	 euEQVFM1rYHbo99SdytuZ82kPhsDU0+UNQGY2sH3gf51PL7mVH5okF2pg53L3HY2/Z
	 nCk/CqlDUmqE8Zujx/UhxVQYGzt2kT5xnfkyC247uPIo42lPsTncS4mhMk5azcCAat
	 J11Lc8Y6kwvzEZlDHmjoCsQ/VwarQor3MkNU8rNYxTTHwJaZRIxD/PBlk6gI6ti9qY
	 t4wucqJ3XAyfQ==
Date: Mon, 11 Nov 2024 14:26:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: acp: Fix potential null pointer dereference
 of "adata"
Message-ID: <ZzIUJ0sEm-Yw84vJ@finisterre.sirena.org.uk>
References: <20241106055720.208057-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7yqAKv7SDId7dEMx"
Content-Disposition: inline
In-Reply-To: <20241106055720.208057-1-luoyifan@cmss.chinamobile.com>
X-Cookie: The end of labor is to gain leisure.


--7yqAKv7SDId7dEMx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 01:57:20PM +0800, Luo Yifan wrote:
> The condition `!adata` indicates a possible null pointer dereference
> for the "adata" parameter. To address this, the access to "adata"
> members has been moved after the null check to ensure safer handling.

This doesn't apply against current code, please check and resend.

--7yqAKv7SDId7dEMx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcyFCYACgkQJNaLcl1U
h9AO9Qf+PfrT6FlJHVopMlzaFKB4i9OdSTiwNYk0H4ZgQQyfgKngbE9fNDrC8BRi
1cliYEJzCuELaflM72RYfKjFMxYT8ze10u3pbX9p6u3etQtAvJGKk+UgA93MKM1c
FCRiJRWbGqxtBt6tc08vzBgFNNBCgsyDCShKIk/CJzPDSP8pehoXnLjQ5S+kzBL7
m+PiYFUI6CoNoQO8vbnxuvXgvTKerWMneNeyfSIHLWo5p7i6pnKgyaKbsHob/S8Q
xbJ1l0Ck2gcL7gBRI3jPID0qThLLe+SqYARtlc/cP/vc6qXJwmfVwMoqF6XuaXTB
lIMAiJa+qum9OX6XleL52RzfSgiFhQ==
=8pGC
-----END PGP SIGNATURE-----

--7yqAKv7SDId7dEMx--

