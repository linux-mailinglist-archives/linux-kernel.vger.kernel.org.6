Return-Path: <linux-kernel+bounces-546963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9CA50143
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BD37A513F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57124A04D;
	Wed,  5 Mar 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIaBJR9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788EC13959D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183398; cv=none; b=s+qzkXZ840X03cOyDmrHHD8BYdJucGOhdYMwUZj+cHlMmGIYRVhHueFZn3qcbYzVI0RA/c6mI8c3EdHZoYggX675Kx0IJS7HzVBJYiNihaTqkI8KBHCjtAJlwHuOKDUSPqXB3TsfugoKNbgVQ70NR20QtG7x4tQB37KAC70oY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183398; c=relaxed/simple;
	bh=ou4krt2YXmvwVwJOOeRKHjtZKWdib6rB39M58Zjq1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0Efy+z0FOzGdUJMjWZXNODqsHbxO+U5nlhMfzG5xKJ5CmN2aFt75fAFp0qvfrdFGFwyIGJEzlxkQs75Sd1U1wWEXirHlhq3ayxEZH0zLaRhRjWtupmkhJLdC4eRrkTbWWSyIBoyRAJKARWi++sAoJyhbyeusnPt+vx7d81DtlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIaBJR9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563F4C4CED1;
	Wed,  5 Mar 2025 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741183397;
	bh=ou4krt2YXmvwVwJOOeRKHjtZKWdib6rB39M58Zjq1DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIaBJR9QFCbDiYvKqNX61/ciXp5k8l7t8c4YWpRDVAXTttBdmHKdlCHq0xNSK28tT
	 e+MFwUtx0TjdZ6+osocgkEirwgcfN76HLNoYlY9bjthQGQm8ESdc2/PKblikXHjikI
	 8Wwgi6qOsVTAHmEL21e+hAUxb0elBnCjM543W70D3nQ7T6zgtKk+0h7RH9lur8FxX9
	 Jv8Isv7+wESHGTpRkVIOoMHe+a7FpthNLXtCcJq+exos/clesR6j3db4wuJ/aShQGM
	 xrDOPmjxWutUWksoBZxzFTQMhuA8ooxvKemFgxiuXuxnAMiXOS52++23Dgjv3DPvfk
	 xPN3zMjzPyZpQ==
Date: Wed, 5 Mar 2025 14:03:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Zxyan Zhu <zxyan20@163.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: debugfs: Fix name collision without atomic
 operations
Message-ID: <82872f70-f31e-4956-86e9-42c80771fbc5@sirena.org.uk>
References: <20250305132718.40247-1-zxyan20@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6+hMYJ3FJbukV6tc"
Content-Disposition: inline
In-Reply-To: <20250305132718.40247-1-zxyan20@163.com>
X-Cookie: Everybody gets free BORSCHT!


--6+hMYJ3FJbukV6tc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 09:27:18PM +0800, Zxyan Zhu wrote:
> The `dummy_index` global variable caused debugfs file name conflicts
> during re-entry, leading to creation failures. Use atomic operations
> to ensure safe and unique debugfs `dummy%d` naming.
>=20
> Signed-off-by: Zxyan Zhu <zxyan20@163.com>
>=20
> Changes since v2:
> - Remove atomic_dec operation if kasprintf() fails

This should go after the --- as covered in submitting-patches.rst.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

> At 2025-03-05 00:23:02, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Tue, Mar 04, 2025 at 10:24:52PM +0800, Zxyan Zhu wrote:
> >>  	if (!strcmp(name, "dummy")) {

Please don't mix stuff like this into patch postings, the tooling can't
cope with stripping it out automatically.

> Thanks for the feedback! I think using atomic_t is a better fit here
> than idr because:
> 1. It's lighter and simpler for our basic indexing needs.
> 2. No extra resource management is needed. If we use idr, we'd have to
>  handle resource cleanup and add locks for debugfs_init/debugfs_exit
>  concurrency.
> 3. As Mark mentioned, id continuity isn't a hard requirement, so we
>  can even skip the atomic_dec on kasprintf failure.

I don't think we care about cost for allocating new regmaps, if that's a
hot path we've probably got bigger problems.

> If you still think idr has clear advantages here, I'm happy to adjust
> the code, but it'd be great to understand the specific benefits in
> this context.

It's the standard idiom for this application.

--6+hMYJ3FJbukV6tc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfIWZ8ACgkQJNaLcl1U
h9ApbAf/aQx2eVP7rD+addtXwkLmSmXHgKfy1qXLapKiFMOfAUk7zyhJB40r/sca
4jfI2MJECKb+nm9t1RrS+HsZFq7SykxQGieTlhL/7sU7KUJd3qGuWnR0Ex5yz8KZ
YRb8BguQWcZsEz4yY8Bpuvp2sxh/KPSAoYbQQufnPpbZmJDNn0UvyBX7vntN8jRf
KIudzSPBuZ+VjsHzjlxXY6+h83z4DYOjY89//OwqzxiuDS1dEDwscpycI3147yCy
M931BKMtf78VCm2R7JnBbLMJXrK15e0bp4oqF4QyYbR8pirn6CpzLBOj2bpkTILO
BTwiC+3LboQ4pRAb8Q6hu8b7tWY+aQ==
=cEEh
-----END PGP SIGNATURE-----

--6+hMYJ3FJbukV6tc--

