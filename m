Return-Path: <linux-kernel+bounces-575489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE25A7032E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD98174CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495F208AD;
	Tue, 25 Mar 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bkZfd5zt"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC92571A8;
	Tue, 25 Mar 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911334; cv=pass; b=kU9riNlits3syDVm60Ig88atqkXS8bqcoL7bhPT6/da+LALrjfqlV/FAqxlXB1oKaH6oqu3TaSWKQXd/BPoKO225zU+LznZPYGyED9jAu1/6CnNkLCWuDJLb0HSvXFUJVgmsbaCHN33/kkuksKM7oHYvLiRbiK4kLz8vNH3ZbVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911334; c=relaxed/simple;
	bh=9O4uqy1naeX8bzCKhM3eYUxsi/i9W+iJkdCDH/bQvuU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Zm5vOUk8Oo1gTuoqqz27MAsbbDqJw4Zna5GcfDQd3VhF1VyrJaGYWIiMbkqejF/9FGeYcLIXpdJjD30Ou0PE5dRHHAmQy2T7X55I9ugsIvGtlgYz+f99yqSrHBVezx0r5GWTCmTDOX76+jluSraE/0Acvqtf3wgQJ+vAn6s4ZU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bkZfd5zt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742911286; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IRFGJzjYDFnAAqMFvFQXDY8O7v26YZe/QK8HqXR9ORiOiv2YgAz1mJJ4ajtrEBJCh5a/Uk8eSPqm0He/o2K7oM95yqejiC1+B/ZyspZHLCnitzp9ZWIExZSljyaiF74vAzohkEADIWeFdzg9Kr6C6NNtJJN/7pFhiM8zcQV7UKI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742911286; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1t9m9SPFoJmycN3sPfqfbtevGGXJbztvUbH5/PjzUdA=; 
	b=LDDlxX34uPCjC07wd3SRlNKcVDDpfJ53NkXgC8lWaCiNQhVWUK+ZrweoH/SozivoeKczpWTY3VH0cypvoZbz8L7YZ3uen90eL8oOgSl99/3abMbH93oKMgkseFwdY6ExNG+M2aw299ICZMtRdog43vvWYt9Mjz5Qqc8vd9yzBh0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742911286;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=1t9m9SPFoJmycN3sPfqfbtevGGXJbztvUbH5/PjzUdA=;
	b=bkZfd5ztrycIJwn3iCqyPvV3aPEtVo9hbS1XSrcTibUMeGlj8Jyt94mEWpm+Aph2
	P2yjbBwz6r5ybASsV7ACkNOX/VxpHYtPWyc54FKS5PMJO3U8YUc0rdbh2E1i3iPCqdC
	DL0oqKikMkuKssxCv4hA+7FLHHF1AfaaiYcvCHsc=
Received: by mx.zohomail.com with SMTPS id 1742911284117910.7174817445112;
	Tue, 25 Mar 2025 07:01:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 07/11] scripts: generate_rust_analyzer.py: identify
 crates explicitly
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-7-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 11:01:08 -0300
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
Message-Id: <A959347E-EC7D-4CF1-A0C4-A4EA4C7E041F@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-7-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Use the return of `append_crate` to declare dependency on that crate.
> This allows multiple crates with the same display_name be defined, =
which
> we'll use to define host crates separately from target crates.
>=20
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 70 =
+++++++++++++++++++--------------------
> 1 file changed, 34 insertions(+), 36 deletions(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index 1ee079c6d916..de1193117161 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -68,17 +68,14 @@ def generate_crates(
>             line =3D line.replace("\n", "")
>             cfg.append(line)
>=20
> -    # Now fill the crates list -- dependencies need to come first.
> -    #
> -    # Avoid O(n^2) iterations by keeping a map of indexes.
> +    # Now fill the crates list.
>     crates: List[Crate] =3D []
> -    crates_indexes: Dict[str, int] =3D {}
>     crates_cfgs =3D args_crates_cfgs(cfgs)
>=20
>     def build_crate(
>         display_name: str,
>         root_module: pathlib.Path,
> -        deps: List[str],
> +        deps: List[Dependency],
>         cfg: List[str] =3D [],
>         is_workspace_member: bool =3D True,
>     ) -> Crate:
> @@ -86,7 +83,7 @@ def generate_crates(
>             "display_name": display_name,
>             "root_module": str(root_module),
>             "is_workspace_member": is_workspace_member,
> -            "deps": [{"crate": crates_indexes[dep], "name": dep} for =
dep in deps],
> +            "deps": deps,
>             "cfg": cfg,
>             "edition": "2021",
>             "env": {
> @@ -94,27 +91,28 @@ def generate_crates(
>             },
>         }
>=20
> -    def register_crate(crate: Crate) -> None:
> -        crates_indexes[crate["display_name"]] =3D len(crates)
> +    def register_crate(crate: Crate) -> Dependency:
> +        index =3D len(crates)
>         crates.append(crate)
> +        return {"crate": index, "name": crate["display_name"]}
>=20
>     def append_crate(
>         display_name: str,
>         root_module: pathlib.Path,
> -        deps: List[str],
> +        deps: List[Dependency],
>         cfg: List[str] =3D [],
>         is_workspace_member: bool =3D True,
> -    ) -> None:
> -        register_crate(
> +    ) -> Dependency:
> +        return register_crate(
>             build_crate(display_name, root_module, deps, cfg, =
is_workspace_member)
>         )
>=20
>     def append_proc_macro_crate(
>         display_name: str,
>         root_module: pathlib.Path,
> -        deps: List[str],
> +        deps: List[Dependency],
>         cfg: List[str] =3D [],
> -    ) -> None:
> +    ) -> Dependency:
>         crate =3D build_crate(display_name, root_module, deps, cfg)
>         proc_macro_dylib_name =3D subprocess.check_output(
>             [os.environ["RUSTC"], "--print", "file-names", =
"--crate-name", display_name, "--crate-type", "proc-macro", "-"],
> @@ -125,14 +123,14 @@ def generate_crates(
>             "is_proc_macro": True,
>             "proc_macro_dylib_path": str(objtree / "rust" / =
proc_macro_dylib_name),
>         }
> -        register_crate(proc_macro_crate)
> +        return register_crate(proc_macro_crate)
>=20
>     def append_sysroot_crate(
>         display_name: str,
> -        deps: List[str],
> +        deps: List[Dependency],
>         cfg: List[str] =3D [],
> -    ) -> None:
> -        register_crate(
> +    ) -> Dependency:
> +        return register_crate(
>             build_crate(
>                 display_name,
>                 sysroot_src / display_name / "src" / "lib.rs",
> @@ -145,47 +143,47 @@ def generate_crates(
>     # NB: sysroot crates reexport items from one another so setting up =
our transitive dependencies
>     # here is important for ensuring that rust-analyzer can resolve =
symbols. The sources of truth
>     # for this dependency graph are `(sysroot_src / crate / =
"Cargo.toml" for crate in crates)`.
> -    append_sysroot_crate("core", [], cfg=3Dcrates_cfgs.get("core", =
[]))
> -    append_sysroot_crate("alloc", ["core"])
> -    append_sysroot_crate("std", ["alloc", "core"])
> -    append_sysroot_crate("proc_macro", ["core", "std"])
> +    core =3D append_sysroot_crate("core", [], =
cfg=3Dcrates_cfgs.get("core", []))
> +    alloc =3D append_sysroot_crate("alloc", [core])
> +    std =3D append_sysroot_crate("std", [alloc, core])
> +    proc_macro =3D append_sysroot_crate("proc_macro", [core, std])
>=20
> -    append_crate(
> +    compiler_builtins =3D append_crate(
>         "compiler_builtins",
>         srctree / "rust" / "compiler_builtins.rs",
>         [],
>     )
>=20
> -    append_proc_macro_crate(
> +    macros =3D append_proc_macro_crate(
>         "macros",
>         srctree / "rust" / "macros" / "lib.rs",
> -        ["std", "proc_macro"],
> +        [std, proc_macro],
>     )
>=20
> -    append_crate(
> +    build_error =3D append_crate(
>         "build_error",
>         srctree / "rust" / "build_error.rs",
> -        ["core", "compiler_builtins"],
> +        [core, compiler_builtins],
>     )
>=20
> -    append_proc_macro_crate(
> +    pin_init_internal =3D append_proc_macro_crate(
>         "pin_init_internal",
>         srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
>         [],
>         cfg=3D["kernel"],
>     )
>=20
> -    append_crate(
> +    pin_init =3D append_crate(
>         "pin_init",
>         srctree / "rust" / "pin-init" / "src" / "lib.rs",
> -        ["core", "pin_init_internal", "macros"],
> +        [core, pin_init_internal, macros],
>         cfg=3D["kernel"],
>     )
>=20
>     def append_crate_with_generated(
>         display_name: str,
> -        deps: List[str],
> -    ) -> None:
> +        deps: List[Dependency],
> +    ) -> Dependency:
>         crate =3D build_crate(
>             display_name,
>             srctree / "rust" / display_name / "lib.rs",
> @@ -203,11 +201,11 @@ def generate_crates(
>                 "exclude_dirs": [],
>             }
>         }
> -        register_crate(crate_with_generated)
> +        return register_crate(crate_with_generated)
>=20
> -    append_crate_with_generated("bindings", ["core"])
> -    append_crate_with_generated("uapi", ["core"])
> -    append_crate_with_generated("kernel", ["core", "macros", =
"build_error", "bindings", "pin_init", "uapi"])
> +    bindings =3D append_crate_with_generated("bindings", [core])
> +    uapi =3D append_crate_with_generated("uapi", [core])
> +    kernel =3D append_crate_with_generated("kernel", [core, macros, =
build_error, bindings, pin_init, uapi])
>=20
>     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
>         try:
> @@ -237,7 +235,7 @@ def generate_crates(
>             append_crate(
>                 name,
>                 path,
> -                ["core", "kernel"],
> +                [core, kernel],
>                 cfg=3Dcfg,
>             )
>=20
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


