Return-Path: <linux-kernel+bounces-544458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30363A4E16F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE0118951B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EC9279339;
	Tue,  4 Mar 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6PE3cfW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47D276D3F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098938; cv=none; b=Q8aYgV+d/PQfI07J3W5jOASY42hOfYs8qqEwg8lUh448hGXRXkQ8Mc+3mV0h3U6FyAMnsW3rzGBtHgyOUe0yoblhP4//iNITVIiKK+swujwSmheWDs+lLp/8h24hwlFqHQhVjtCOu+zf0cWuknvNortGEC1yBxMeYZO9785oQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098938; c=relaxed/simple;
	bh=dCpBQhn2NwIxqsS12UTL55cRO4v4MyWfjiNFli0eHzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwOSds09JB++C3h2S2CANX8drbiGuenW5x6Lv+zS2TnpAHY8UB4Wt21BHFDynbDzaLHB3BFfX024Nshp7rSusIQDkinG8ND2ld5QTizf82mpuUnh9qLKsorVg6fmKxesJM6H4kkKRqTMuxgPJNz8I5l6sVQhlimevsKALXN5OBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6PE3cfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE2EC4CEF1;
	Tue,  4 Mar 2025 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098938;
	bh=dCpBQhn2NwIxqsS12UTL55cRO4v4MyWfjiNFli0eHzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6PE3cfWbPwNwlwjPIU/QVjtNiNn3m97Fy/heyxJF/8WgGSNhwTyv26W7F47rnc2f
	 tOksoljZ46Lpo5e2NyUsvMDQiiTII3I8Mf1Nvg5naErSH+IHACsWfalHbz1JtY3riu
	 /XUmljcwfSnkX6nr6ZRgH0SR1ZGkrekSXR87jdgPuTT7KQXhe43XD0jJKZDONFhYza
	 4mxEmcqfA6T7n7YlkR1BgGkwAAHaRneVKnHplkqqA8JBlwK7tklM+YjHHu0gn+XYFn
	 A2hqpK1Rl/tQFKvaLz0oBCqCpfcxYy/NrSpr15XGrImI6dhXq7DD2H4DAOcnnU7CJv
	 yBb/mq6770f3A==
Date: Tue, 4 Mar 2025 14:35:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Zxyan Zhu <zxyan20@163.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: debugfs: Fix name collision without atomic
 operations
Message-ID: <fdd5c1c2-41f2-4d74-a5e0-444c1d2a0a81@sirena.org.uk>
References: <20250304142452.3521828-1-zxyan20@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SU+JFWVTCzcFVpbL"
Content-Disposition: inline
In-Reply-To: <20250304142452.3521828-1-zxyan20@163.com>
X-Cookie: Do not disturb.


--SU+JFWVTCzcFVpbL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 10:24:52PM +0800, Zxyan Zhu wrote:

> Changes since v1:
> - Replaced atomic_read + atomic_inc with atomic_inc_return.
> - Added atomic_dec in the error path to maintain index consistency.
> - Updated the commit message to clarify the fix.
>=20
> Signed-off-by: Zxyan Zhu <zxyan20@163.com>
> ---

As covered in submitting-patches.rst the inter-version changelog should
be after the ---.

> -		map->debugfs_name =3D kasprintf(GFP_KERNEL, "dummy%d",
> -						dummy_index);
> -		if (!map->debugfs_name)
> +		index =3D atomic_inc_return(&dummy_index);
> +		map->debugfs_name =3D kasprintf(GFP_KERNEL, "dummy%d", index);
> +		if (!map->debugfs_name) {
> +			atomic_dec(&dummy_index);

Adding the decrement seems racy, we could increment again between
getting index and kasprintf() failing so might not get back to the
starting point.  It'd be a little messy to skip a number but it doesn't
really matter, and if we're under that much memory pressure probably
nobody's even going to look, so I don't see any reason to decrement.

--SU+JFWVTCzcFVpbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfHD7UACgkQJNaLcl1U
h9CpMAf9Eqp7ZhbUPj+Sg1pmDuYzogdiKg0/hFqyk4PzeeaTNi4SvSZLbXp56emc
q7EgVqe1fLYt6veWNRGcelA3bXHkZQuvPJy0ZvQUnMri09gnERvXftjvduueUsu1
7cWx9zFvyb4bo6L4q97S1i58tn+bTQGJlB1pSyhJ7sTGXveEaRzHRp9mm4yYZgIE
3K9WnFGTckiZacQWVCi1udTbDP72e8JRUkfIUupBc2V0sDPydynfWsobvi3Q1Ror
GGPp6aPbIUjXX+Lv9W+C+bbhdqcQAvLyxaZpjELxKt8NzL+PJ5fCxEAsXkDGeAMN
Nje1zx7nIeHPgda79owpyLSRcaaS4w==
=jzWQ
-----END PGP SIGNATURE-----

--SU+JFWVTCzcFVpbL--

