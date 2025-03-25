Return-Path: <linux-kernel+bounces-575483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBCA70322
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C8716E826
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C1258CEF;
	Tue, 25 Mar 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="blMlEPYe"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA05257AF3;
	Tue, 25 Mar 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911021; cv=pass; b=oMxZI6qCgVb9ozexfDyzduAzjH+ykHm++WiLwLdr8fBQ/zPbWnRWCdxCg9UVx4QmQE7C8DwQqh0SLlw97BiQouIG0tyK84QqrZkyJdk5lhJmdjdzj2L1EEx6cm9zgGITt7DFFwBUBEOsGFNycLuZR3Cac9GMqFUwi5nNrCNHXsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911021; c=relaxed/simple;
	bh=PXmbI4Ysww4x3hZl3JOeQw3JZ5ni3tMzFhHspd5E3n4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nyLqyQVauhCUPIk7H6xP7ZThHMM/ifXgBrkS9SxvaZ0c4E6Q97AHBJylkperhaCx/ZdboxqgL+vwjw5WabUkfc4WopQruZTuKL7tturSY48m0IUgLTjuJhDP4H731lDX7YbWw2g8jINX0NiZZPuRgzOd7I04ZY9Xx3nVVB1Uk+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=blMlEPYe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742910993; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c6Et2H4HiI04DFJKT0SpWRg5auDzjAgoShuhcHlcf3R6j0IBHntfVnb/tN/o904jFVd/jYUkO4YuHTIyKWiaGy8j3bSIYo1TU+4yj2MNVDEfGEfWFEo9aPsnjPg1h5+XoAX03Q2mXecnkzByQi5SfNmYPeHdnpuDusdkYMsZHMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742910993; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OELQCuc5LfRr+FGbtU0FfFiS0xA0xBZSkdLY+QAiyUs=; 
	b=ksvroG3X2bqhS029w294zaUO80rr3d7pcA9avVOyD7FQ0q9BH4BxMWr6feyvhVSBX2gXEv2tz2nWoO6D4pjx4eWwhAiWcw2rDbmXxxvBeB6CCj/qqovQ60qANpoVJUMFfT5B33d6Yno4HiZt5lfszulh9D20o7sdIXp06EO6HHA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742910993;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=OELQCuc5LfRr+FGbtU0FfFiS0xA0xBZSkdLY+QAiyUs=;
	b=blMlEPYeO01FCBcHQmmN0HpTkMmrDgj3wZbkcrVhvMIoocx78z4P6e4SW71rNMnE
	N3uhwQIUMTB1HaMrS0jmV1YH4f2xf3G5Q7D+SbLbS9IV0z1OQtN88XDLbQn/AdJiwb2
	01FQqTsQlAfxT5fcWd9ZLbn4rcG5r24+qWTgsobs=
Received: by mx.zohomail.com with SMTPS id 1742910992311454.9893269642041;
	Tue, 25 Mar 2025 06:56:32 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 06/11] scripts: generate_rust_analyzer.py: use
 str(pathlib.Path)
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-6-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 10:56:16 -0300
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
Message-Id: <32FF4399-D3BB-4F41-A103-CC41290CDA3A@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-6-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Use the `/` operator on `pathlib.Path` rather than directly crafting a
> string. This is consistent with all other path manipulation in this
> script.
>=20
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index 0772ea309f94..1ee079c6d916 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -123,7 +123,7 @@ def generate_crates(
>         proc_macro_crate: ProcMacroCrate =3D {
>             **crate,
>             "is_proc_macro": True,
> -            "proc_macro_dylib_path": =
f"{objtree}/rust/{proc_macro_dylib_name}",
> +            "proc_macro_dylib_path": str(objtree / "rust" / =
proc_macro_dylib_name),
>         }
>         register_crate(proc_macro_crate)
>=20
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

