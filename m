Return-Path: <linux-kernel+bounces-339268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5B19861E9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E728CF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A4E15C122;
	Wed, 25 Sep 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtuuYyWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122526AF5;
	Wed, 25 Sep 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275666; cv=none; b=SeLry5j71YyXLSnWtKHaHeehK1R2mDMJmYwTGmz0t4psVewlFUqKm9Qm0kXav8MJZmPD+4dERE5ze8NiyZ+gJ5WpyLdzPBRtUb8svPnOi0+qFQCvUGLWOg2AQ/WTHz6ONaQMeTd3lkOULaOKc8Nr29zshdHSZdcSfnmqTelLeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275666; c=relaxed/simple;
	bh=wx8YONyUFoGvQ+t2pLQ0u5COnOIGNKXY8cwi+lc2Zpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1wDn1FejJnLLvK26Yd2HWX0KPLUbS+ZPqQYfqsRG8E3sJ1dInLZV9I3zY9VzDpwo+dTTF0evbfZvFGVgA82615u1k8IGzLIoUNE8vlBqtaVuioflf7f1h5n7LOwPFC/F34ctNGggUAG38agmPBxdX4QTr3c+MXamU1Zt25GmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtuuYyWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBD0C4CEC3;
	Wed, 25 Sep 2024 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727275665;
	bh=wx8YONyUFoGvQ+t2pLQ0u5COnOIGNKXY8cwi+lc2Zpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtuuYyWe9+JJVya0RkxlfL4RuzBsZJP3OJCBfm+2SHkU3FCcLuNGiklfW35bglE1J
	 8cl6ghnUjRTXjyZ0y8VUvJwoeyYbYrYq+EYeePRoQQBV2U2pPeM2dsyCVy0fV1Q+Pf
	 xj1Y9wyKs48+hczjLdOfEYQkVYz52z4j1zEvlex+kOHP6f452YT2tCR+n1ovH/bqPZ
	 +oHYf+YBaHXlbt6iA+C5GRN+1RrTonQ+kKFDBfI0DTTfjRXelJUyPmHEwOo6RRBajU
	 WPKmtKD7sZxa66LQ76LMbbPNNLfzE6ozEHrotWmMagLj5aJJlI6Xv977BsheIpZbi4
	 +l3rlznWXQuIQ==
Date: Wed, 25 Sep 2024 15:47:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: Fix typo MIMPLID -> MIMPID
Message-ID: <20240925-ammonia-expenses-e13bb113538c@spud>
References: <20240925142532.31808-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SsDGt9N5z5dUUoB0"
Content-Disposition: inline
In-Reply-To: <20240925142532.31808-1-namcao@linutronix.de>


--SsDGt9N5z5dUUoB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 04:25:32PM +0200, Nam Cao wrote:
> The macro that is really defined is RISCV_HWPROBE_KEY_MIMPID, not
> RISCV_HWPROBE_KEY_MIMPLID (difference is the 'L').

Heh, it is indeed.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Also, the riscv privileged specification names the register "mimpid", not
> "mimplid".
>=20
> Correct these typos.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> ask me how I found out..

Gowan, hit us with it...


>=20
>  Documentation/arch/riscv/hwprobe.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 85b709257918..fb0affa61eb9 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -51,7 +51,7 @@ The following keys are defined:
>  * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid`=
`, as
>    defined by the RISC-V privileged architecture specification.
> =20
> -* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid`=
`, as
> +* :c:macro:`RISCV_HWPROBE_KEY_MIMPID`: Contains the value of ``mimpid``,=
 as
>    defined by the RISC-V privileged architecture specification.
> =20
>  * :c:macro:`RISCV_HWPROBE_KEY_BASE_BEHAVIOR`: A bitmask containing the b=
ase
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--SsDGt9N5z5dUUoB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvQijQAKCRB4tDGHoIJi
0vCHAQC/XuZFxbv10n6zq5HRutrUOVvtWK7lHh7PZezj2Bj7aQD6AgswVFQjsVnR
ztulw03/EAqAWsUyR6omJckf2DYNbQA=
=cFBD
-----END PGP SIGNATURE-----

--SsDGt9N5z5dUUoB0--

