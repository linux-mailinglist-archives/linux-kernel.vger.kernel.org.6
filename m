Return-Path: <linux-kernel+bounces-180017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA4E8C68E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FDE282280
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624315572A;
	Wed, 15 May 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7D7ndLe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2613F44E;
	Wed, 15 May 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783797; cv=none; b=dJ9eKRziaVG+0DQU+kTE+jBCpErpx5cC94Op4r4khEJHzHfuZKe+y2UTerPNN6JFRjAjxX1LFyw4Xg0EB9kDvXEEm9s+Ot2FqDm3GpNojWCkgVS/4mmEZEEhqbdpyroPvO7ANrD6T8VGGhffM/tCsut5Sy5Cx+UV4uEIwhlr8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783797; c=relaxed/simple;
	bh=BK3Q1Eaz2vKy7Ifb0gMrmzfC3vR/99oauzNR4ISwhNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADq8a6bzT1/4ZEmD4X9pk19sVbKsN52WM8CiTffKYQ6tm1mNo78wZrl/cGpKFFv8RPdBqjNJw3LUGHGmnaQCF8xJkYwEFPXQYaTnrVl7WqEsw6R7qGCWNKHVONzihqh3qDqeW2clSedEd3hoFLr+t1FWw5sjQLrbip8ssYanjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7D7ndLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCA0C116B1;
	Wed, 15 May 2024 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715783797;
	bh=BK3Q1Eaz2vKy7Ifb0gMrmzfC3vR/99oauzNR4ISwhNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7D7ndLe/1tMGWg+zXC6mnAqwqDcUYM0rcjLNDQzfAYwZgpcO2SvG/G6rOcGTLJNV
	 hGxoDb8GYIpJY65l6aQGhvrGYoxCxyUle6Z/cotew2VxB7Q91EmK2GoQOrTNXDGeeb
	 HYib5mmxOXV+Ze9RvzY81b4pw7MDBKWsvfDaiaZU9vPoIocYL3t8Tz1IMk6C27wX6B
	 t8nM6WxV7ov0P4kMxe+D3tLW5usOjynfkmllzzUWr2VyH9y2cVhSFRMaPNYfWeKDJy
	 DiWkSKGATxJ0Zm3UKvMWMISSCpTJRQrkSRvH/u8hOBlC8wJhrkVBdo9X8YwmFTCTID
	 HjTywjrdAACYA==
Date: Wed, 15 May 2024 15:36:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments
 to function 'riscv_ipi_set_virq_range'
Message-ID: <20240515-zen-calculate-289cfb90cd65@spud>
References: <CA+G9fYtDtgb8zNGfDQPS2u_n_45rDiDgJR6ud3uuxkJBR0rUzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VaxeQxGCx5+jYQuq"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtDtgb8zNGfDQPS2u_n_45rDiDgJR6ud3uuxkJBR0rUzA@mail.gmail.com>


--VaxeQxGCx5+jYQuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Palmer,
This is the issue I point out to you on the call earlier:

On Wed, May 15, 2024 at 04:18:58PM +0200, Naresh Kamboju wrote:
> The riscv builds failed on Linux next-20240515 tag due to following build
> warnings / errors with gcc-13 and clang toolchain.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> Build Log:
> -----
> drivers/irqchip/irq-riscv-imsic-early.c: In function 'imsic_ipi_domain_in=
it':
> drivers/irqchip/irq-riscv-imsic-early.c:52:9: error: too many
> arguments to function 'riscv_ipi_set_virq_range'
>    52 |         riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/smp.h:119,
>                  from include/linux/lockdep.h:14,
>                  from include/linux/spinlock.h:63,
>                  from include/linux/sched.h:2142,
>                  from include/linux/ratelimit.h:6,
>                  from include/linux/dev_printk.h:16,
>                  from include/linux/device.h:15,
>                  from include/linux/node.h:18,
>                  from include/linux/cpu.h:17,
>                  from drivers/irqchip/irq-riscv-imsic-early.c:8:
> arch/riscv/include/asm/smp.h:52:6: note: declared here
>    52 | void riscv_ipi_set_virq_range(int virq, int nr);
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
> metadata:
>   git_describe: next-20240515
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
>   git_short_log: 82d92a9a1b9e ("Add linux-next specific files for 2024051=
5")
>=20
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202405=
15/testrun/23894295/suite/build/test/gcc-13-lkftconfig/details/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2gUiKdxX7qM27ri=
tMJT5pRyZhyi/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202405=
15/testrun/23894295/suite/build/test/gcc-13-lkftconfig/history/
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20

--VaxeQxGCx5+jYQuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTIcQAKCRB4tDGHoIJi
0lfWAQDi33YIiyOgOhOs7pvyAObFXef0e9hfqNt1slgzGSvACwD/ZgicDRP+uuJa
J02ZHXAmHtcBVUat4F+6J8iGuN38gQw=
=zifD
-----END PGP SIGNATURE-----

--VaxeQxGCx5+jYQuq--

