Return-Path: <linux-kernel+bounces-575494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC9DA70347
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2111188716D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA200259C97;
	Tue, 25 Mar 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ENGJ+IzY"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC29208AD;
	Tue, 25 Mar 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911685; cv=pass; b=lVhA5TkYi85LeELMI7WZrMd188Ah1etb2dMc3En+mXIDbOd5vexLJp88Z2s52TPfCzofFT0BglNbDBYtPQ2lUFNkdwc4zEIbOFBko117se1ffMgIB5Umm5mvEgZEzkpEeexuk/jR2fVKtKR9/nX8hybzL/1rG79myHzRtuH/pC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911685; c=relaxed/simple;
	bh=+yPgbq8PJ4VlPYRGbamSTIRXpblzNbpZIay/fJTTm5I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QMynOLkr6zx2koOdqnx38wNomllTtDuW6oDAWJkevvObn0YtQlPjVPMWusQFlyAC/NXu7HZznhC9ry+6d0YfD3qOyr3aTbPHA0dDSZGanYVU6naQJul4n0Vv2WoP3QC8sca966Bze21NeVOcKG8dA+ANNTmkRxTEwvShRRFllyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ENGJ+IzY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742911534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mfy/NLz6wtDNIHxjcWrFHpoI1hSiSb1LE5wq3SdYWpfXGkwBDGL1Vr2mVbk5Q8A+EDKkIMudKetTmBMZ1IpgzATQcw1SJ3C+YJndFZJ6qg+rKr4CgGORsJE8qxsXFUI/FQQgX9BIbZiYr5XLCm/FM/h3CmYl+A1WhtNsw7pJZe0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742911534; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=66ru/BCUrl3ikGnmgfKgGg2NIvsWKX5AYiBRkpu1Vgw=; 
	b=i745S3b8dT4Ou3bU41RP5gki0BvxJoI9JLIgMojvXw2xjkMWcg1RsXci69awKJ7AowRPJLD669uD/XKZk+bdE0lYM1DWCT6k1UwLDN2MWamA8sLpUHABvRYUYQvcMGkLnGoy5a9LJ/n9EpbE9Yy0CUw+4oYfwzkSXSxstUBiFWk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742911533;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=66ru/BCUrl3ikGnmgfKgGg2NIvsWKX5AYiBRkpu1Vgw=;
	b=ENGJ+IzYu9vz5R33cX7LJfq4nCAaI7TGqVzQQhSq4tzTQ4TiTp5+kJXiqel7cILW
	yH8Rj0cgpNy6HUGSs0n51FYC8/KXLg3RJSyvkc3KFCSP52VmgPfiBJR6qM+1QtGjjqG
	qJLueDxb6l70iysd3ZHD66KyS8OsLRfs7nvhEelQ=
Received: by mx.zohomail.com with SMTPS id 1742911532141346.48228251988894;
	Tue, 25 Mar 2025 07:05:32 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 08/11] scripts: generate_rust_analyzer.py: define host
 crates
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-8-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 11:05:13 -0300
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
Message-Id: <B6E056CC-610F-451E-969B-ADA141BA2EC5@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-8-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Define host crates used by the `macros` crate separately from target
> crates, now that we can uniquely identify crates with the same name.
>=20
> This avoids rust-analyzer thinking the host `core` crate has our =
target
> configs applied to it.
>=20
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: =
https://lore.kernel.org/all/CANiq72mw83RmLYeFFoJW6mUUygoyiA_f1ievSC2pmBESs=
Qew+w@mail.gmail.com/
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index de1193117161..bd6e321a6aa5 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -143,10 +143,12 @@ def generate_crates(
>     # NB: sysroot crates reexport items from one another so setting up =
our transitive dependencies
>     # here is important for ensuring that rust-analyzer can resolve =
symbols. The sources of truth
>     # for this dependency graph are `(sysroot_src / crate / =
"Cargo.toml" for crate in crates)`.
> +    host_core =3D append_sysroot_crate("core", [])
> +    host_alloc =3D append_sysroot_crate("alloc", [host_core])
> +    host_std =3D append_sysroot_crate("std", [host_alloc, host_core])
> +    host_proc_macro =3D append_sysroot_crate("proc_macro", =
[host_core, host_std])
> +
>     core =3D append_sysroot_crate("core", [], =
cfg=3Dcrates_cfgs.get("core", []))
> -    alloc =3D append_sysroot_crate("alloc", [core])
> -    std =3D append_sysroot_crate("std", [alloc, core])
> -    proc_macro =3D append_sysroot_crate("proc_macro", [core, std])
>=20
>     compiler_builtins =3D append_crate(
>         "compiler_builtins",
> @@ -157,7 +159,7 @@ def generate_crates(
>     macros =3D append_proc_macro_crate(
>         "macros",
>         srctree / "rust" / "macros" / "lib.rs",
> -        [std, proc_macro],
> +        [host_std, host_proc_macro],
>     )
>=20
>     build_error =3D append_crate(
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>



