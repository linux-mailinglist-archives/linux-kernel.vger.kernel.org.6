Return-Path: <linux-kernel+bounces-575450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE919A7028E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6EC3BE5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A815257AC2;
	Tue, 25 Mar 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Y2Ro0Yxe"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9942571C9;
	Tue, 25 Mar 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909892; cv=pass; b=f9shABJtB+8uM9/8qS5E3eq5ftvrwKALOsHD9JEsGDhkEmQqDP08R6uKmkSBG6RT6K2cDmiIKEnKovtyHKTqJ2VmjisPW7vFtjy0/NQMTbfZVQVahQ4N3E2SVD2TYswRu4vyam3nK2DsZdCfvi0C7UofnbBakO9vGkWjAq7GSyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909892; c=relaxed/simple;
	bh=WHcrUAwythiuL14j6/8zThAO1Ukni9kBCox+F1bi/0Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LNWFiPDs8rTX07iF1WNRjvH+rKWSLt4gDhJnAmD4rmCspaIc6up/0SEkQTDmEb2veK7t/yF+vv/+pWYxLdyMXNg2nwpyePl9VTPP5aCttF7V7SjIZCs2N9GILq38XIknd8MDtZFDW3sPsU8NU287i0Ra7aeMS9sYbHzRMlYIPyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Y2Ro0Yxe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742909864; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CqC32ceUxcaVJyXKS1/tED/Z5ylNhla0oi8hTid3x+m+L+gCE1Sv/stG44dUf7xoeUikR7FKxbtUhGbuwFJTyi2907HB/CtS5EXUXJ16pZcHfv85JBbQ9zYViN9wMEC3ErpdxtI+sBvwrlUX39tIVdVYZf6nmkV6X8HRzU6Pwf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742909864; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LtaRAzNNQfB1j6gBjd5GJZBwJaO3dNPIKcWdt8B8zvA=; 
	b=g5t3KHoA+uoQr1Q2VYvnJ1r8IVXnGPm5U57vZWZ7gswdkn/SAm8fUx4RchwfRLDQs3mVaMmcizXep0ihqe5P5ZqqA92pTFyzMPaerh9VVCF27LhdalKkA26/b/9gW0jzPiBGJh2foYc9DH0nvGupAyU/NSMRTaif+e/5GuoeffM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742909864;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=LtaRAzNNQfB1j6gBjd5GJZBwJaO3dNPIKcWdt8B8zvA=;
	b=Y2Ro0YxejqXdNZ2Y9Yw8uTsh1yuPIV2emRTdCRwtsHkYArw6aJG60UH2BVzwmS4X
	T+82vAfyY762LrOjmGrIPbllDj+Q8VchMKoDTRrqGwYk+pQw6zoVTM6S+MJnZMQNXDY
	TxmSi1G42s4xH/NqXNUWyttW3N2hcUDGaaP/amyI=
Received: by mx.zohomail.com with SMTPS id 1742909861756625.8332014980086;
	Tue, 25 Mar 2025 06:37:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 05/11] scripts: generate_rust_analyzer.py: add type
 hints
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-5-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 10:37:25 -0300
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
Message-Id: <FB3D0F03-B162-4AD5-B288-4E307421276B@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-5-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Tamir,

> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Python type hints allow static analysis tools like mypy to detect type
> errors during development, improving the developer experience.
>=20
> Python type hints have been present in the kernel since 2019 at the
> latest; see commit 6ebf5866f2e8 ("kunit: tool: add Python wrappers for
> running KUnit tests").
>=20
> Run `mypy --strict scripts/generate_rust_analyzer.py --python-version
> 3.8` to verify. Note that `mypy` no longer supports python < 3.8.
>=20
> This removes `"is_proc_macro": false` from `rust-project.json` in
> exchange for stricter types. This field is interpreted as false if
> absent[1] so this doesn't change the behavior of rust-analyzer.

Can this be a separate patch? Not sure how this is related to Python =
type
hints, but it makes the current patch harder to review.

>=20
> Link: =
https://github.com/rust-lang/rust-analyzer/blob/8d01570b5e812a49daa1f08404=
269f6ea5dd73a1/crates/project-model/src/project_json.rs#L372-L373 [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 172 =
+++++++++++++++++++++++++-------------
> 1 file changed, 112 insertions(+), 60 deletions(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index 03f55cce673c..0772ea309f94 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -10,8 +10,10 @@ import os
> import pathlib
> import subprocess
> import sys
> +from typing import Dict, Iterable, List, Literal, Optional, TypedDict
>=20
> -def args_crates_cfgs(cfgs):
> +
> +def args_crates_cfgs(cfgs: Iterable[str]) -> Dict[str, List[str]]:
>     crates_cfgs =3D {}
>     for cfg in cfgs:
>         crate, vals =3D cfg.split("=3D", 1)
> @@ -19,7 +21,45 @@ def args_crates_cfgs(cfgs):
>=20
>     return crates_cfgs
>=20
> -def generate_crates(srctree, objtree, sysroot_src, external_src, =
cfgs):
> +
> +class Dependency(TypedDict):
> +    crate: int
> +    name: str
> +
> +
> +class Source(TypedDict):
> +    include_dirs: List[str]
> +    exclude_dirs: List[str]
> +
> +
> +class Crate(TypedDict):
> +    display_name: str
> +    root_module: str
> +    is_workspace_member: bool
> +    deps: List[Dependency]
> +    cfg: List[str]
> +    edition: Literal["2021"]
> +    env: Dict[str, str]
> +
> +
> +# `NotRequired` fields on `Crate` would be better but `NotRequired` =
was added in 3.11.
> +class ProcMacroCrate(Crate):
> +    is_proc_macro: Literal[True]
> +    proc_macro_dylib_path: Optional[str]  # `pathlib.Path` is not =
JSON serializable.
> +
> +
> +# `NotRequired` fields on `Crate` would be better but `NotRequired` =
was added in 3.11.
> +class CrateWithGenerated(Crate):
> +    source: Optional[Source]
> +
> +
> +def generate_crates(
> +    srctree: pathlib.Path,
> +    objtree: pathlib.Path,
> +    sysroot_src: pathlib.Path,
> +    external_src: pathlib.Path,
> +    cfgs: List[str],
> +) -> List[Crate]:
>     # Generate the configuration list.
>     cfg =3D []
>     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
> @@ -31,67 +71,75 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
>     # Now fill the crates list -- dependencies need to come first.
>     #
>     # Avoid O(n^2) iterations by keeping a map of indexes.
> -    crates =3D []
> -    crates_indexes =3D {}
> +    crates: List[Crate] =3D []
> +    crates_indexes: Dict[str, int] =3D {}
>     crates_cfgs =3D args_crates_cfgs(cfgs)
>=20
>     def build_crate(
> -        display_name,
> -        root_module,
> -        deps,
> -        cfg=3D[],
> -        is_workspace_member=3DTrue,
> -        is_proc_macro=3DFalse,
> -    ):
> -        crate =3D {
> +        display_name: str,
> +        root_module: pathlib.Path,
> +        deps: List[str],
> +        cfg: List[str] =3D [],
> +        is_workspace_member: bool =3D True,
> +    ) -> Crate:
> +        return {
>             "display_name": display_name,
>             "root_module": str(root_module),
>             "is_workspace_member": is_workspace_member,
> -            "is_proc_macro": is_proc_macro,
>             "deps": [{"crate": crates_indexes[dep], "name": dep} for =
dep in deps],
>             "cfg": cfg,
>             "edition": "2021",
>             "env": {
>                 "RUST_MODFILE": "This is only for rust-analyzer"
> -            }
> +            },
>         }
> -        if is_proc_macro:
> -            proc_macro_dylib_name =3D subprocess.check_output(
> -                [os.environ["RUSTC"], "--print", "file-names", =
"--crate-name", display_name, "--crate-type", "proc-macro", "-"],
> -                stdin=3Dsubprocess.DEVNULL,
> -            ).decode('utf-8').strip()
> -            crate["proc_macro_dylib_path"] =3D =
f"{objtree}/rust/{proc_macro_dylib_name}"
> -        return crate
> -
> -    def register_crate(crate):
> +
> +    def register_crate(crate: Crate) -> None:
>         crates_indexes[crate["display_name"]] =3D len(crates)
>         crates.append(crate)
>=20
>     def append_crate(
> -        display_name,
> -        root_module,
> -        deps,
> -        cfg=3D[],
> -        is_workspace_member=3DTrue,
> -        is_proc_macro=3DFalse,
> -    ):
> +        display_name: str,
> +        root_module: pathlib.Path,
> +        deps: List[str],
> +        cfg: List[str] =3D [],
> +        is_workspace_member: bool =3D True,
> +    ) -> None:
>         register_crate(
> -            build_crate(
> -                display_name, root_module, deps, cfg, =
is_workspace_member, is_proc_macro
> -            )
> +            build_crate(display_name, root_module, deps, cfg, =
is_workspace_member)
>         )
>=20
> +    def append_proc_macro_crate(
> +        display_name: str,
> +        root_module: pathlib.Path,
> +        deps: List[str],
> +        cfg: List[str] =3D [],
> +    ) -> None:
> +        crate =3D build_crate(display_name, root_module, deps, cfg)
> +        proc_macro_dylib_name =3D subprocess.check_output(
> +            [os.environ["RUSTC"], "--print", "file-names", =
"--crate-name", display_name, "--crate-type", "proc-macro", "-"],
> +            stdin=3Dsubprocess.DEVNULL,
> +        ).decode('utf-8').strip()
> +        proc_macro_crate: ProcMacroCrate =3D {
> +            **crate,
> +            "is_proc_macro": True,
> +            "proc_macro_dylib_path": =
f"{objtree}/rust/{proc_macro_dylib_name}",
> +        }
> +        register_crate(proc_macro_crate)
> +

Same here. Is this supposed to be related to Python type hints somehow?

>     def append_sysroot_crate(
> -        display_name,
> -        deps,
> -        cfg=3D[],
> -    ):
> -        append_crate(
> -            display_name,
> -            sysroot_src / display_name / "src" / "lib.rs",
> -            deps,
> -            cfg,
> -            is_workspace_member=3DFalse,
> +        display_name: str,
> +        deps: List[str],
> +        cfg: List[str] =3D [],
> +    ) -> None:
> +        register_crate(

Why is register_crate here now? Maybe this change belongs to the =
preceding patch?

> +            build_crate(
> +                display_name,
> +                sysroot_src / display_name / "src" / "lib.rs",
> +                deps,
> +                cfg,
> +                is_workspace_member=3DFalse,
> +            )
>         )
>=20
>     # NB: sysroot crates reexport items from one another so setting up =
our transitive dependencies
> @@ -108,11 +156,10 @@ def generate_crates(srctree, objtree, =
sysroot_src, external_src, cfgs):
>         [],
>     )
>=20
> -    append_crate(
> +    append_proc_macro_crate(
>         "macros",
>         srctree / "rust" / "macros" / "lib.rs",
>         ["std", "proc_macro"],
> -        is_proc_macro=3DTrue,
>     )
>=20
>     append_crate(
> @@ -121,12 +168,11 @@ def generate_crates(srctree, objtree, =
sysroot_src, external_src, cfgs):
>         ["core", "compiler_builtins"],
>     )
>=20
> -    append_crate(
> +    append_proc_macro_crate(
>         "pin_init_internal",
>         srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
>         [],
>         cfg=3D["kernel"],
> -        is_proc_macro=3DTrue,
>     )
>=20
>     append_crate(
> @@ -137,9 +183,9 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
>     )
>=20
>     def append_crate_with_generated(
> -        display_name,
> -        deps,
> -    ):
> +        display_name: str,
> +        deps: List[str],
> +    ) -> None:
>         crate =3D build_crate(
>             display_name,
>             srctree / "rust" / display_name / "lib.rs",
> @@ -147,20 +193,23 @@ def generate_crates(srctree, objtree, =
sysroot_src, external_src, cfgs):
>             cfg=3Dcfg,
>         )
>         crate["env"]["OBJTREE"] =3D str(objtree.resolve(True))
> -        crate["source"] =3D {
> -            "include_dirs": [
> -                str(srctree / "rust" / display_name),
> -                str(objtree / "rust")
> -            ],
> -            "exclude_dirs": [],
> +        crate_with_generated: CrateWithGenerated =3D {
> +            **crate,
> +            "source": {
> +                "include_dirs": [
> +                    str(srctree / "rust" / display_name),
> +                    str(objtree / "rust")
> +                ],
> +                "exclude_dirs": [],
> +            }
>         }
> -        register_crate(crate)
> +        register_crate(crate_with_generated)
>=20
>     append_crate_with_generated("bindings", ["core"])
>     append_crate_with_generated("uapi", ["core"])
>     append_crate_with_generated("kernel", ["core", "macros", =
"build_error", "bindings", "pin_init", "uapi"])
>=20
> -    def is_root_crate(build_file, target):
> +    def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
>         try:
>             return f"{target}.o" in open(build_file).read()
>         except FileNotFoundError:
> @@ -169,7 +218,9 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
>     # Then, the rest outside of `rust/`.
>     #
>     # We explicitly mention the top-level folders we want to cover.
> -    extra_dirs =3D map(lambda dir: srctree / dir, ("samples", =
"drivers"))
> +    extra_dirs: Iterable[pathlib.Path] =3D map(
> +        lambda dir: srctree / dir, ("samples", "drivers")
> +    )
>     if external_src is not None:
>         extra_dirs =3D [external_src]
>     for folder in extra_dirs:
> @@ -192,7 +243,8 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
>=20
>     return crates
>=20
> -def main():
> +

What is this extra blank line for? Automatically generated by a =
formatter?

> +def main() -> None:
>     parser =3D argparse.ArgumentParser()
>     parser.add_argument("--verbose", "-v", action=3D"store_true")
>     parser.add_argument("--cfgs", action=3D"append", default=3D[])
>=20
> --=20
> 2.48.1
>=20
>=20

Other than what I said above, the type hints themselves are fine.

=E2=80=94 Daniel=

