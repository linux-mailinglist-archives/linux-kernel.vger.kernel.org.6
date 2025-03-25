Return-Path: <linux-kernel+bounces-575547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD8A70406
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A50F3B5EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745A25B694;
	Tue, 25 Mar 2025 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Q7Qn2w1J"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547525A342;
	Tue, 25 Mar 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913566; cv=pass; b=PcTCA/UsjRU1qAa9+bbRbtjP/nlxYGVXCdZSkqRM8DeDMeuYK6LCtu9b8axsdv51V5CD2jUxQ+w8+BOUQCmqRUeXAoDHRpNnK+AAF/mf5x4a6g66SFH1WPj2HQK1AEoM7A6HU+pndB0X2C7ii84RlyvoMJ4LVPNTOc+A0Nqle1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913566; c=relaxed/simple;
	bh=Gvt8K1sA1CaAsu2eb2QGQYOlpD6tSJd58vP4p0vCBcM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qINw90ceOFlSHDwJqviscJ1oR39SG5IolArankbLrJTF7dr7gJX+HqcoM129u76igYMpp/v575WCZcUQL+ymxWUkdRXs5nNH/uyz2taFWc2VKTHtyjhq4VR5CalVii3f9Rlxi/efaFt+rj7apKNF6oIajY5VR5BUFKyLYeCsy08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Q7Qn2w1J; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742913536; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VUVu38pF+ELp8GK6YdhvjNb30da9YOmDDJeYolZO0WNipKoxltMmo5HeRYRobHll4LCMbsJy6+KHZ6Ut/iJwSTcHC09FcWZtKe/W121VHvsWMsk1Zuwf9Oi/Z5N6BAbxQ3S/g3bgxaspCNr7FfPeDVhdDFD/R9xG4S6jAdK8sE8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742913536; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jQZDBSONaTvaFu9T91EHjA31tT8fr2Z46N42ed/1SWE=; 
	b=YArRVSUZZTzD8qeJuueVTNj+oJgISEaAn8RKep0aAYZDdIYEUA8qfHmOOxwm8LKSueDgeopsSldV12csgi1CwvXiIz73qLPyCGgnNP+OMwm6vbkpQcnJ4pK98Xl0IyvhqJ0r62dwc+kV9bjOVruuNjoge1N+MqP50ya4UMSoV6s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742913536;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=jQZDBSONaTvaFu9T91EHjA31tT8fr2Z46N42ed/1SWE=;
	b=Q7Qn2w1JM5e57wWolQ/0oebm+F7PwyjAchnvl2wXYY5kojAq/8ZcJUmUYJuTcxew
	/9Bxb0bOUzla+YBFln50TijQTU4zWg8yXDC9y50oF9bjvrkm2PnIA/shcdOt7iDkK25
	KH10JYmXBKXFe1ZyY8dkVabM2kMfa9NzU23Hbl08=
Received: by mx.zohomail.com with SMTPS id 17429135343111014.0342799037822;
	Tue, 25 Mar 2025 07:38:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 11/11] scripts: generate_rust_analyzer.py: use
 `cfg_groups`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-11-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 11:38:37 -0300
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
Message-Id: <CFD8E300-A2A3-41C6-A11A-1177F20A56A7@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-11-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Declare common `cfg`s just once to reduce the size of =
rust-analyzer.json
> from 30619 to 2624 lines.
>=20
> Link: =
https://github.com/rust-lang/rust-analyzer/commit/2607c09fddef36da0d6f0a84=
625db5e20a5ebde3
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 35 =
+++++++++++++++++++++++------------
> 1 file changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index 957b413fe0b6..3d89c0198db4 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -37,6 +37,7 @@ class Crate(TypedDict):
>     root_module: str
>     is_workspace_member: bool
>     deps: List[Dependency]
> +    cfg_groups: List[str]
>     cfg: List[str]
>     edition: Literal["2021"]
>     env: Dict[str, str]
> @@ -59,15 +60,8 @@ def generate_crates(
>     sysroot_src: pathlib.Path,
>     external_src: pathlib.Path,
>     cfgs: List[str],
> +    cfg_groups: List[str],
> ) -> List[Crate]:
> -    # Generate the configuration list.
> -    cfg =3D []
> -    with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
> -        for line in fd:
> -            line =3D line.replace("--cfg=3D", "")
> -            line =3D line.replace("\n", "")
> -            cfg.append(line)
> -
>     # Now fill the crates list.
>     crates: List[Crate] =3D []
>     crates_cfgs =3D args_crates_cfgs(cfgs)
> @@ -77,6 +71,7 @@ def generate_crates(
>         root_module: pathlib.Path,
>         deps: List[Dependency],
>         cfg: List[str] =3D [],
> +        cfg_groups: List[str] =3D [],
>         is_workspace_member: bool =3D True,
>     ) -> Crate:
>         return {
> @@ -85,6 +80,7 @@ def generate_crates(
>             "is_workspace_member": is_workspace_member,
>             "deps": deps,
>             "cfg": cfg,
> +            "cfg_groups": cfg_groups,
>             "edition": "2021",
>             "env": {
>                 "RUST_MODFILE": "This is only for rust-analyzer"
> @@ -101,10 +97,13 @@ def generate_crates(
>         root_module: pathlib.Path,
>         deps: List[Dependency],
>         cfg: List[str] =3D [],
> +        cfg_groups: List[str] =3D [],
>         is_workspace_member: bool =3D True,
>     ) -> Dependency:
>         return register_crate(
> -            build_crate(display_name, root_module, deps, cfg, =
is_workspace_member)
> +            build_crate(
> +                display_name, root_module, deps, cfg, cfg_groups, =
is_workspace_member
> +            )
>         )
>=20
>     def append_proc_macro_crate(
> @@ -190,7 +189,7 @@ def generate_crates(
>             display_name,
>             srctree / "rust" / display_name / "lib.rs",
>             deps,
> -            cfg=3Dcfg,
> +            cfg_groups=3Dcfg_groups,
>         )
>         crate["env"]["OBJTREE"] =3D str(objtree.resolve(True))
>         crate_with_generated: CrateWithGenerated =3D {
> @@ -252,7 +251,7 @@ def generate_crates(
>                 name,
>                 path,
>                 [core, kernel],
> -                cfg=3Dcfg,
> +                cfg_groups=3Dcfg_groups,
>             )
>=20
>     return crates
> @@ -277,9 +276,21 @@ def main() -> None:
>     # Making sure that the `sysroot` and `sysroot_src` belong to the =
same toolchain.
>     assert args.sysroot in args.sysroot_src.parents
>=20
> +    # Generate the configuration list.
> +    with open(args.objtree / "include" / "generated" / "rustc_cfg") =
as fd:
> +        cfg_groups =3D {"rustc_cfg": =
[line.lstrip("--cfg=3D").rstrip("\n") for line in fd]}
> +
>     rust_project =3D {
> -        "crates": generate_crates(args.srctree, args.objtree, =
args.sysroot_src, args.exttree, args.cfgs),
> +        "crates": generate_crates(
> +            args.srctree,
> +            args.objtree,
> +            args.sysroot_src,
> +            args.exttree,
> +            args.cfgs,
> +            list(cfg_groups.keys()),
> +        ),
>         "sysroot": str(args.sysroot),
> +        "cfg_groups": cfg_groups,
>     }
>=20
>     json.dump(rust_project, sys.stdout, sort_keys=3DTrue, indent=3D4)
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>


