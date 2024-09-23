Return-Path: <linux-kernel+bounces-335942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA7997ED02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7C6281F84
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AFD197554;
	Mon, 23 Sep 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fae5vt/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676B19CD1B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101177; cv=none; b=CeRtKH7Oc0805Lxu0RmOTx9SqrqSS2lFp+lnuvNTasPWWZ8u8bknx8OG0at4yxyLq6v4+NTImImiSNuMHUvJ9Axo6/GV28ayH00RMwNHxZWLVL3orh+FDKG+L/LcTAFDM+UvhO32gqsSETnqS/+Hr7OarmbYsrOYAEO135lxqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101177; c=relaxed/simple;
	bh=SFgrI4olngEkBpWsmcuVB37o8iX9U8HhunyWS7uFIBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE2NQKYFTzDRiAxH1K6DLYlwo6Ax06h5k4PmfpVfVrcpO1s9nLquqOQajhQwUj8IcvEmYbMAFFxLx1cByoWlC9Fa2OcDMJM8/+eCpxhSTJJFhj9Aqcl374FS1FyuKJlifBSortiPAbDJESEdVQ8uWBJcFKa8y5p12E2kAKpmdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fae5vt/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC33C4CEC4;
	Mon, 23 Sep 2024 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727101177;
	bh=SFgrI4olngEkBpWsmcuVB37o8iX9U8HhunyWS7uFIBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fae5vt/ksJ2GXeCd49ZAgLuCXPu1fjht6SxVpgM6Qm6qRx5kA2QXZtLGKhtwZFWzs
	 COAQSzgiSTPQmbDtpnkppPaNeNWNkBargXPMUBlBYD+6+SQA2fQFr9rJFi2iBpF1zr
	 T0hgSwkO2plXuEYAgWj/U0B7SORQA5byHGIbm8yQmr/y2r3N/M+JDa/xhPSQp2mJjH
	 c8+6XNo/JVulerroVQ3ihTXvhGecvnkK5DjN+X/zVkhXZGfLhGipISdPF118KDbWVs
	 gai+4L5I/vLiR85zaEqJIdnEaDjEkZ60pLo+CGjyY7Dh9e78SjjnLxZrjDZ8Vgg1Bh
	 Mby5oBwG7CJgQ==
Date: Mon, 23 Sep 2024 16:19:32 +0200
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: do not ignore provided init_data
Message-ID: <ZvF49CZhRc2rrPQ0@finisterre.sirena.org.uk>
References: <20240920-regulator-ignored-data-v1-1-7ea4abfe1b0a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5bDXW9jFwRojPsBD"
Content-Disposition: inline
In-Reply-To: <20240920-regulator-ignored-data-v1-1-7ea4abfe1b0a@baylibre.com>
X-Cookie: Editing is a rewording activity.


--5bDXW9jFwRojPsBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2024 at 07:21:12PM +0200, Jerome Brunet wrote:

> Note that it is probably not problem at the moment since no one complained
> about ignored data.

I'm fine with tweaking the functionality here but since I don't think
we're using this at all we should probably warn about systems with both
forms of constraints specified since they probably need some
consideration needed and people might not be doing this intentionally.

That probably means checking if regulator_of_get_init_node() can find
something and warning if that's the case.

--5bDXW9jFwRojPsBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbxePMACgkQJNaLcl1U
h9DDwgf+MgFeHhmXWj1l8ZBsWeEGvaVY/rlWtw6RoUzGcv+COycfmxa40CQO5BUD
Zr5TWIMZlioOSG2wmA+BocZ1Yft2Kj/rGD8mNbiAf3OfOM/RZ/Varme0MP5GhzuU
6jlsI4sh9yihBSgZPeXixNs2GrtORlSynaANtNfT/0Dgte74hen8NOI4JiKLhqA3
mg0ykv6J3grcSQSnIaEKB2v3bZt5pDufnP1RD0zIbYUsR3w3YuqAdjRyBo9new/C
Hm/9U4RJbMHRuozQMv8Psl+aVHR2rRAon/2H6b83SZlswoJLovKaVzXh+w/QqSIb
DUtfIp+slH+73UVxoP0DsyDzEGxv/g==
=meRP
-----END PGP SIGNATURE-----

--5bDXW9jFwRojPsBD--

