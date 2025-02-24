Return-Path: <linux-kernel+bounces-529484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B01A426EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B3C444A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF012561D6;
	Mon, 24 Feb 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caGtuwmh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5F2561C2;
	Mon, 24 Feb 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411734; cv=none; b=HQq/zTxl9HZjAmMOO6BMT+XHMryldZxTyYeWM+WHIAw0XfsrgdbV5e6As9/vDu8im+nPhRKPAaE2wZwxSFfbd82DLLb0J+bga6/fxfumyKhIBW/NQ6+HakjuPJyubbsMJBWCZMQAJ7iagJAeGiyx99iDl4WkMQc+zW3PbwKLwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411734; c=relaxed/simple;
	bh=bNIcr4Fz4MgFSDcxSksqWLxES7aDz2dSI+VqqsfI3g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq8ZQtJqexHs3zcu3SgJpF68FVBrlwI1GdBscsEWL1eZ3WUAp5lio91NoxBRLNY5lwvMhNdGc5j/7BOvlwgZXHyBfQFKlTBu4NBNxNnTykC3DS+goBbMpSbQFlhCWrNfslB03n9JfGDdlpaD24hwVMWjj3g1EZTcc+w9ao+oQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caGtuwmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD1DC4CED6;
	Mon, 24 Feb 2025 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740411734;
	bh=bNIcr4Fz4MgFSDcxSksqWLxES7aDz2dSI+VqqsfI3g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caGtuwmhiH5TEjWTo4MeM6H6LSDoh30IAwE77NZXJTXKNDOv3XaCRHTzcsTcbkqKE
	 xuCMeVUjGEBeNSlEBHNupLGj8l8QycXnc0+rPcHeWhErVhgHG+ABiupHYNuV6WLATo
	 bQ2YkI8Jm9zQ9EyNI4IcOFOe2rPQY/NEh3uOZCdH1/O/XfXyFOzB+XPhBhqZhbJSP+
	 Eb9Z6b73rS+o2FCu19FScc3WLmhvWqRpLdfbH3Gclmu2Imm6h6kthUdoRBPKRasDA3
	 imbnucL9qPZWMdXkFV5J/CdqUmgFmzmMvK8Yn5h4AYnj5II39nqJLvRmYfygPSy+oi
	 tLceB0o9wdXKw==
Date: Mon, 24 Feb 2025 15:42:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	kernel@collabora.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm-graph: set fill colour of turned on nodes
Message-ID: <3d15fd23-3756-4a17-a447-b5ccb2c564df@sirena.org.uk>
References: <20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com>
 <20250224163311.0611da3f@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="doMF8Qx3qZEMyGkm"
Content-Disposition: inline
In-Reply-To: <20250224163311.0611da3f@booty>
X-Cookie: Phone call for chucky-pooh.


--doMF8Qx3qZEMyGkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 04:33:11PM +0100, Luca Ceresoli wrote:
> Hello Nicolas,
>=20
> +Cc: Mark Brown
>=20
> On Fri, 21 Feb 2025 21:39:32 +0100
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
>=20
> > Some tools like KGraphViewer interpret the "ON" nodes not having an
> > explicitly set fill colour as them being entirely black, which obscures
> > the text on them and looks funny. In fact, I thought they were off for
> > the longest time. Comparing to the output of the `dot` tool, I assume
> > they are supposed to be white.

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--doMF8Qx3qZEMyGkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8k1AACgkQJNaLcl1U
h9BwlAgAhHv+PFXM5e0zQ9dTmKEVwx63AYqZQO/rfIr4Kz3gzekJI5dDY+AT+inb
pPp1JwXFhEKlunLXD5VNMPJGs2c4gH8YI6wvyKazNNw7kMewPxSRvYq6Y62FuPxd
F6h89riZfV7IIO5vcLz5nrO7tY/MftZilRFnKmSFvTLbpjMAG3vFNCgaDwU8igkw
6UsCT55+7xLCZXSnjIHJPm9a98ALujJ7iU0WbqA0FekIRqkgRM6HdGFGxiKthe62
jBTkmmn1QRb2qsVTUWY517ATl49KQOpWaZ9Hj2m08qVjIhnUhpVH8CDzJkEZ9THv
8bRvaEP8LNA1DIQrXt4Z16dZKP3jxg==
=eUne
-----END PGP SIGNATURE-----

--doMF8Qx3qZEMyGkm--

