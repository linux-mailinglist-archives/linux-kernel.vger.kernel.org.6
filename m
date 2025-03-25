Return-Path: <linux-kernel+bounces-575417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB4A702BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DD3846F62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACC225EFAC;
	Tue, 25 Mar 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HMu4/LNV"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C225DD1F;
	Tue, 25 Mar 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909125; cv=pass; b=e9BHamP5pXECh/ycJJRW1mDZ81AGynSc2Gzj89TJCCz7+M4YdmJb6UcZ3jZiVqqq82ruzOJbqE4FCOC/ApXCmCEoErcPSedtJHjnLo7jiny0QMj1l/bzqlxCPw3WN6teOjizhnP/oyevba9MDUjTY31EhGv7lH5rX/XPP82AxL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909125; c=relaxed/simple;
	bh=W+UTbiw9KsgdHjpdl2qKp7aAQkBRf9Zuq3Mdb3Qt7e4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RgJLmctpV2tIS2VZLnKwB4w0Q94Gl83Efkk3gfZJq+wyF0lmz0ZAnY+IlkLp9fXmFDP7UKAZI7gMy+ZAq5hTM0nSsLlyd1YO6Bi9tqYtnhB7vLxOW/5FKrBY5xKYoFWoCdbPstvp/RNektb+TPGp0syqSxfR7LURXf8GKgEDR9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HMu4/LNV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742909099; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eKy8iHUVaCFrsBZeIriYO3CQ5eqZgSBGW6nXyhN2mbSyvVMDPxrJRdoVAULhPlMsyaYcPLqj2uChhLnO51frR8xxblLCu71i9rLE4KyBaNtVIstzhCmepe/8ij+eVx5b5wyRZ+t20xX0B4mB3quJFsyop1fsOoz1wPpKGHQGENE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742909099; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2UycCl2Syp0F8vxGR2SV/m2IXAWT+b6fuwrAt14/u64=; 
	b=Hpp5ExZBed6Jltd8DuMx/PNIzySW1TE2fC/JzQpO7/71jNGR2gsBoZhNe8Axc7DJlfWDD5ARzwRu/bPLslo7zBUq9ParSJFhmE/FNu6IYzeWccvx+oGShT132y0OeTtcQtKcq2N5iE1jOEQrQwpjmqT89r51+m7xANcsa0PGUv8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742909099;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=2UycCl2Syp0F8vxGR2SV/m2IXAWT+b6fuwrAt14/u64=;
	b=HMu4/LNVl5hyc2K8nTYE7ftT3Q/n79cNx7KfI4bSmtT+bSt8Kw900MIJwFLeDSrX
	EomRWx25GjOovJ1onHmDJ4JZCK7cPrSpWkHpAEnytK0bwWMwk5/FIQ5iwflFk8I/0RU
	rv8ASD4NKFYqMYWRDuyAV0MmTcC6sJ1Pu4dy6PQo=
Received: by mx.zohomail.com with SMTPS id 1742909097312358.84031429399;
	Tue, 25 Mar 2025 06:24:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 04/11] scripts: generate_rust_analyzer.py: extract
 `{build,register}_crate`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-4-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 10:24:41 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Boris-Chengbiao Zhou <bobo1239@web.de>,
 Kees Cook <kees@kernel.org>,
 Fiona Behrens <me@kloenk.dev>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C4E7DCF-5C90-4D8C-8338-00DB24B65BC5@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-4-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Extract helpers from `append_crate` to avoid the need to peek into
> `crates[-1]`. This improves readability.
>=20
> Suggested-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 35 =
++++++++++++++++++++++++++++++-----
> 1 file changed, 30 insertions(+), 5 deletions(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index e997d923268d..03f55cce673c 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -35,7 +35,14 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
>     crates_indexes =3D {}
>     crates_cfgs =3D args_crates_cfgs(cfgs)
>=20
> -    def append_crate(display_name, root_module, deps, cfg=3D[], =
is_workspace_member=3DTrue, is_proc_macro=3DFalse):
> +    def build_crate(
> +        display_name,
> +        root_module,
> +        deps,
> +        cfg=3D[],
> +        is_workspace_member=3DTrue,
> +        is_proc_macro=3DFalse,
> +    ):
>         crate =3D {
>             "display_name": display_name,
>             "root_module": str(root_module),
> @@ -54,9 +61,26 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
>                 stdin=3Dsubprocess.DEVNULL,
>             ).decode('utf-8').strip()
>             crate["proc_macro_dylib_path"] =3D =
f"{objtree}/rust/{proc_macro_dylib_name}"
> -        crates_indexes[display_name] =3D len(crates)
> +        return crate
> +
> +    def register_crate(crate):
> +        crates_indexes[crate["display_name"]] =3D len(crates)
>         crates.append(crate)
>=20
> +    def append_crate(
> +        display_name,
> +        root_module,
> +        deps,
> +        cfg=3D[],
> +        is_workspace_member=3DTrue,
> +        is_proc_macro=3DFalse,
> +    ):
> +        register_crate(
> +            build_crate(
> +                display_name, root_module, deps, cfg, =
is_workspace_member, is_proc_macro
> +            )
> +        )
> +
>     def append_sysroot_crate(
>         display_name,
>         deps,
> @@ -116,20 +140,21 @@ def generate_crates(srctree, objtree, =
sysroot_src, external_src, cfgs):
>         display_name,
>         deps,
>     ):
> -        append_crate(
> +        crate =3D build_crate(
>             display_name,
>             srctree / "rust" / display_name / "lib.rs",
>             deps,
>             cfg=3Dcfg,
>         )
> -        crates[-1]["env"]["OBJTREE"] =3D str(objtree.resolve(True))
> -        crates[-1]["source"] =3D {
> +        crate["env"]["OBJTREE"] =3D str(objtree.resolve(True))
> +        crate["source"] =3D {
>             "include_dirs": [
>                 str(srctree / "rust" / display_name),
>                 str(objtree / "rust")
>             ],
>             "exclude_dirs": [],
>         }
> +        register_crate(crate)
>=20
>     append_crate_with_generated("bindings", ["core"])
>     append_crate_with_generated("uapi", ["core"])
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>



