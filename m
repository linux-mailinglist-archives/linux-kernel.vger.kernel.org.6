Return-Path: <linux-kernel+bounces-195646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88B8D4FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E86283834
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0121A02;
	Thu, 30 May 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="MRB2dxsU"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136F21345
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085861; cv=none; b=YfHmTLgwGtzg8TJVh16FMveB++2Je4rNFKSVaEcZN/DnnMwRDa0y9HDGbwvjsx0iv+X/Ooag61ajHD8ReC7CwfkekwpbVrMjIAeiauw1t3C89WVrnS71dg34BYxiTm0LL0Rc9/+Af/sLutuHVkZrH7Tqa5vsFB5LEF59dw1z3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085861; c=relaxed/simple;
	bh=puGpVZOnVut9xgpkq2SDv7F7R0DYc9nfwmObP4idcdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UehLh5Le+Tv516pgtJ1xo9UsrKm1NGupN91TUbiVy+zxjECSW88Q74vi8LB2f1oWnk8+xzuQz9fgjbkiCDaYeu8Y+GNEzteYgenIo9pndOWOn0oCmCAShB3k2yLRO1VIv8pf1GoKmWE5agOA4gwbjwmMTaMlqMVQCIeaAAtiLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=MRB2dxsU; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I+VnTm4AmfXXiuL7ZilP6BXPkFwuXclGizPn9CLK9c8=; b=MRB2dxsU14DJGHKq9tcDTr5kA7
	l7s0HzxwtBEM/uDTJATPKIAjW+pKPZkWYJswy1Zcre8u6C4gEHoauTxTga9zfkjmxQdVmUogGc0Ya
	ith839c3iIiyj7t4ZelQ68LQPT4QzLpWCoIYhRveLTCZAcc6SN9GvZge/PxKk7eBPP1o7OWp7K2uG
	sFwedRbSWbh1BlK6/toEJvTcSe3e4pO74djIhMvn0MXxXYZmO/bgRrChWMaGXeBn0aoBm6woXW8r6
	cZ9AKLQw1tYA0iykq4jIkbs6jzUlwNGvhPsiSUAw/FPG+CRPUnAxy8CtcmDBFIrTBJM5bMfiZuOe5
	HHMe4gWg==;
Received: from [2001:9e8:9df:3501:d236:c226:c7b1:7d83] (port=59208 helo=bergen.fritz.box)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1sCiT3-00AmQo-EL;
	Thu, 30 May 2024 18:17:29 +0200
Date: Thu, 30 May 2024 18:17:24 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] kbuild: Fix 'import module' error
Message-ID: <ZlimlGhgULcpCQlO@bergen.fritz.box>
References: <20240529154621.21354-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DrFMLf5VWQ4FI3T/"
Content-Disposition: inline
In-Reply-To: <20240529154621.21354-1-ahuang12@lenovo.com>
X-Operating-System: Debian GNU/Linux 12.5
Jabber-ID: nicolas@jabber.no


--DrFMLf5VWQ4FI3T/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 29 May 2024 23:46:21 GMT, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
>=20
> Commit b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src)
> for source directory") only changes 'symlinks'. However, 'cmd_symlink'
> is not changed accordingly. This leads to the following error:
>=20
> Traceback (most recent call last):
>   File "/your_kernel_obj/linux/vmlinux-gdb.py",
>  line 29, in <module>
>     import linux.utils
> ModuleNotFoundError: No module named 'linux.utils'
>=20
> Fix the issue by using $(src) instead of $(srctree)/$(src).
>=20
> Fixes: b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src) for=
 source directory")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  scripts/gdb/linux/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
> index d77ad9079d0f..fcd32fcf3ae0 100644
> --- a/scripts/gdb/linux/Makefile
> +++ b/scripts/gdb/linux/Makefile
> @@ -5,7 +5,7 @@ ifdef building_out_of_srctree
>  symlinks :=3D $(patsubst $(src)/%,%,$(wildcard $(src)/*.py))
> =20
>  quiet_cmd_symlink =3D SYMLINK $@
> -      cmd_symlink =3D ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/=
$(src)/%,$@) $@
> +      cmd_symlink =3D ln -fsn $(patsubst $(obj)/%,$(abspath $(src))/%,$@=
) $@
> =20
>  always-y +=3D $(symlinks)
>  $(addprefix $(obj)/, $(symlinks)): FORCE
> --=20
> 2.25.1

Hi Adrian,

this is already fixed in kbuild/for-next.  Unfortunately the patch is=20
not available at lore.kernel.org (did not not pass any usual mailing=20
list?), but you can find the pre-applied patch in [1].

Kind regards,
Nicolas

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild=
=2Egit/commit/?h=3Dfor-next&id=3D659bbf7e1b08267b8e1dd900b316edcb6f6d9e2e

--DrFMLf5VWQ4FI3T/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmZYpo8ACgkQB1IKcBYm
EmlAAg/9GS6DEQmsHsHymikvcG8dlQZWOpOVucbl6wVol/jWyoxkvR29i2U9FH1X
Exb/yUbnzaUjeWFHo4wW6BJQ8N8MrPydh4C3JOcF910Gt+yXeHIWpfzhnHKs9RHx
u+f7XQ0tVTFjtGWl+qozWGtAgph+7Jl50ApJamNkXkezQDvsx4V0PHUXottQLYts
Tx3hcDOOkcku5k0yNcQ2qwTauBgsvOwbfSLNW92Dj2Z8wvrNzOwLImD/5quDMoMW
i50NSIa18mwKWTVUUt09AQWKdUAEewzsyXdRIzgD9FylStGQZFHDOrYBqbXD8lIk
HAGsujlnlc5ayZq1YphclMH4X/KgnE0405glanS41Gl2UWdvH8xo0DIp/8EFKzgi
AU7vPzwKF+m5oeUcY2OCeTwCE05AJJOCDkuHz74SPph40f5atXEMGQUkN8LcsqCv
pTgTI+jdojgrh2PCl1a1jKZXR1OPn/wVpajMYQAYibX2bQPijMz2HhcnePohc6D7
5D0bd/dE4XYXyHWxdRpC/ncR9TMFhFADdXWdT2messLYFYP/BDFO4AYJlY4qzxiv
0jGfVwHu2o9B7RydH4JdoXpnkEfqARfGnNC5Wogx7E426ZcIRVvtrl3tB0C48iDv
hx5tv0eavrMvWz0CI/8Jk0Zxtcme8ARjG5wDEqfLCrM98cXoK6s=
=jWpY
-----END PGP SIGNATURE-----

--DrFMLf5VWQ4FI3T/--

