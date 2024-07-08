Return-Path: <linux-kernel+bounces-244311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F592A283
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3371F21C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7CE7D3EC;
	Mon,  8 Jul 2024 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwx6nyjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C443C08A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441335; cv=none; b=Zvi85OFzhAwCJwLTag1EAzoRXPC578IqpRsUdeSWWgnIdXM6AGzWAX2uZ1EFK7Rv4slHtdp6ITQazpflJNOJkfqqe0Z+pG8OUonWPHhe+DHWj9vT6/BtGZEd4mFoeBA4ZCackWFuT7wL/VXOuRCtEaYPmJPXjuWLakXgdQ+sU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441335; c=relaxed/simple;
	bh=X4roQGkfbEMgoQwx7NcOhNg9AazWz8+yJwGnXW9aCWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjrGCjJyNycDlrDIorr6exnNZPEuDbMOuohETFvnaat45QS9O8epvE+dGyvs7welP5/6edTD2EfQw8txrW5YIw7L72Xj/9N1k3PFjB4Nk6RHw5EgAJPl2nKkWPe8n4yNTtZ/FBAeGg8QFURvJopdGF+VxRfbbojeGPNmjBlbnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwx6nyjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68728C116B1;
	Mon,  8 Jul 2024 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720441335;
	bh=X4roQGkfbEMgoQwx7NcOhNg9AazWz8+yJwGnXW9aCWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwx6nyjKM9bWLG6JaX3TW8sLv0a4G7zg5FCfhNAlNb72wDjHTGpTeafubKzbH+B1c
	 4OOT+ixMMe+jEH2FXUP2VqAWMva5EBcsO57Y7NfqpPrkfNGltO6dDy0FsE+wnHwT4a
	 faOBE+3UrVW9TRkZN/UZpr4JEFRjdu16jGSgLFhQ51q5DWkMqNpMeovk0A1Gimz0cs
	 G1cPQqmVsSlfJa91Mspl0N6obV7P2DRsxjFDo/lbo6JmtLxqyQ7oQO1TgwktrndpZ/
	 2wgUpVDx8Pb6XzvjmR8IKyuw/GtucCNUd++7M9fSTgswk6feiJvYafO6hPy9y7B1Md
	 C4PkmC6suE9IQ==
Date: Mon, 8 Jul 2024 13:22:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	atishp@atishpatra.org, anup@brainfault.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant macro check
Message-ID: <20240708-wildcard-denim-12de7fae795b@spud>
References: <20240708121224.1148154-1-xiao.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PIFgJoAZoR/7NBLX"
Content-Disposition: inline
In-Reply-To: <20240708121224.1148154-1-xiao.w.wang@intel.com>


--PIFgJoAZoR/7NBLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 08:12:24PM +0800, Xiao Wang wrote:
> The macro CONFIG_RISCV_PMU must have been defined when riscv_pmu.c gets
> compiled, so this patch removes the redundant check.

Did you investigate why this define was added? Why do you think that it
is redundant, rather than checking the incorrect config option?

Cheers,
Conor.

>=20
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  drivers/perf/riscv_pmu.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 0a02e85a8951..7644147d50b4 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -39,7 +39,6 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time_short =3D 0;
>  	userpg->cap_user_rdpmc =3D riscv_perf_user_access(event);
> =20
> -#ifdef CONFIG_RISCV_PMU
>  	/*
>  	 * The counters are 64-bit but the priv spec doesn't mandate all the
>  	 * bits to be implemented: that's why, counter width can vary based on
> @@ -47,7 +46,6 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	 */
>  	if (userpg->cap_user_rdpmc)
>  		userpg->pmc_width =3D to_riscv_pmu(event->pmu)->ctr_get_width(event->h=
w.idx) + 1;
> -#endif
> =20
>  	do {
>  		rd =3D sched_clock_read_begin(&seq);
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--PIFgJoAZoR/7NBLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZovZ8wAKCRB4tDGHoIJi
0tmMAQDnISXypa25FeukbzaHzN5filg8qUtvCfNkk7106XjRuQD/XrET7jAr1U9u
kHGzeO4GrJEQpQt9VyTrG9ZnLZc+uAU=
=scPc
-----END PGP SIGNATURE-----

--PIFgJoAZoR/7NBLX--

