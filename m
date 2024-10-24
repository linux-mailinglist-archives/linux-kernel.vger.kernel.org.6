Return-Path: <linux-kernel+bounces-380224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B175F9AEA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B0828226A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61D01E765B;
	Thu, 24 Oct 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAjy6GCk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298919DFB4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783865; cv=none; b=hkRrBFaYVj8TgWlMM/6v1kpz3JsIn5F+aXp6aLaHsooAxa1PoVFJND+MmDHr146hRpmDciVGGj5706cBbCKByyEDIHIVe1yHiD2NXQ60lB7Jvqi1NyqxVBNUhiduIVMWhUP7IpVEIwif7AuAoYINqys+QPdatk8vDVS32Vz9YiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783865; c=relaxed/simple;
	bh=K7zEZgEZbViwzMMRQ0QXl3jFAoDQTtP+TsdXxL72sZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c23bbEcfnnXqHUp054gQCkxGVf8kMhbIKs36qkJEtC3KLSkk3PpcUn8SJGzr5an7zXDUDtDsSW8BK0UNth8XXAioASa+h02GPPgLN+glsP/AuzxU90rFUHuCIh/5aW1v3az0DRUd75Xs3hqB2Xv5S/bnxarpsuOcGhbEw052Axs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAjy6GCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E0BC4CEC7;
	Thu, 24 Oct 2024 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783864;
	bh=K7zEZgEZbViwzMMRQ0QXl3jFAoDQTtP+TsdXxL72sZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAjy6GCkFa++uK9gJOQ+t891g6XUimozmrKCz7H3uJArFIKFObdpZ6WocZIFukDlT
	 gVUcwttxb6SqDtTy9EGh8VMFmuTvSoPY0GkFnRr8WBTVg4s/BeGv0z6R/uCtdBMv4Q
	 ws7XxSyNHoip+3hOMCwUKT0rs3+bit34vF1vGx778t/C/3kFZ0B3EvayFqoNJwkRHk
	 Cy+4y28wLdaLJPxLhQlAY4NE+Xnm81Lif+924QYymQVly+X7ZBJv9FKNqA76WSEqlM
	 KL2i8I/1kMY0H9GRMN4qazaUAGlxJI2mjvPyaJuiGH5DJy44W9ifY+J1XzuuYfr/Um
	 ky27ue2/usQnw==
Date: Thu, 24 Oct 2024 16:31:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Yangyu Chen <cyy@cyyself.name>,
	Jisheng Zhang <jszhang@kernel.org>,
	Jesse Taube <mr.bossman075@gmail.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Meng Zhang <kevin.z.m@hotmail.com>, soc@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: setup support for SpacemiT SoC tree
Message-ID: <20241024-penpal-skillet-c44a389e0d4d@spud>
References: <20241023-00-k1-maintainer-v1-1-c06b791cc2ee@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jdBzSMd637lxed/"
Content-Disposition: inline
In-Reply-To: <20241023-00-k1-maintainer-v1-1-c06b791cc2ee@gentoo.org>


--9jdBzSMd637lxed/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:18:19PM +0800, Yixun Lan wrote:
> Add myself as maintainer of SpacemiT's SoC tree, which
> suggested by Conor [1].
>=20
> Link: https://lore.kernel.org/all/20241018234615-GYA2124001@gentoo/ [1]
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> This will setup proper maintainer info about Spacemit's kernel tree,
> which should help to take soc and device tree patches, and send the
> pull request up to Arnd's soc tree.
>=20
> I asked Kevin to host the kernel tree under SpacemiT's account
> on github, which should help people to get access more easily,
> and promote the tree a little bit.

What do you mean by "get access more easily"?

In case it is not clear, noone other than those listed in the
maintainers entry should be pushing content to the fixes/next
branches and all patches must go through the mailing lists and review
process. I'm sure you're well aware of this, but I've never interacted
with spacemit and don't know if they are.

Make sure you add the fixes/next branches to linux-next when you have
the branches established.

> I could take this patch through this spacemit's soc tree if no objection,
> of cource, after got ACK.

Yes, do it along with the base series, when that goes in.

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9659a5a7fb3347d649855992a559e3526d18443..4087023593f7a0b2d5c5827df=
682230c329f82a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19791,6 +19791,7 @@ F:	arch/riscv/boot/dts/
>  X:	arch/riscv/boot/dts/allwinner/
>  X:	arch/riscv/boot/dts/renesas/
>  X:	arch/riscv/boot/dts/sophgo/
> +X:	arch/riscv/boot/dts/spacemit/
>  X:	arch/riscv/boot/dts/thead/

Huh, this is not meant to look like that. Looks like the patch went
missing. I'll have to rectify that. You can drop this hunk. I'm going
to invert it:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Driscv-soc-fixes

> =20
>  RISC-V PMU DRIVERS
> @@ -21578,6 +21579,14 @@ W:	https://linuxtv.org
>  Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  F:	drivers/media/dvb-frontends/sp2*
> =20
> +SPACEMIT SoC Support
> +M:	Yixun Lan <dlan@gentoo.org>

I'd like to see someone else here, but if noone is volunteering
themselves, we can hardly force them!

> +S:	Maintained
> +T:	git https://github.com/spacemit-com/linux
> +F:	arch/riscv/boot/dts/spacemit/
> +N:	spacemit
> +K:	spacemit
> +
>  SPANISH DOCUMENTATION
>  M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>  R:	Avadhut Naik <avadhut.naik@amd.com>
>=20
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241023-00-k1-maintainer-46eb3f31e6f2
>=20
> Best regards,
> --=20
> Yixun Lan <dlan@gentoo.org>
>=20

--9jdBzSMd637lxed/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxpoNAAKCRB4tDGHoIJi
0nd2AQClGkpei3Vuj3VpSnLrsS0fgviW2IJC3iM7EV2zPOp8oAD9EN4xl1JjRxGX
4gNDHVMG2ZH1kHcfs2M0mAqMMO+DtA4=
=4Zk+
-----END PGP SIGNATURE-----

--9jdBzSMd637lxed/--

