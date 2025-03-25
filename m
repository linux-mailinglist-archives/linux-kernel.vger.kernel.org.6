Return-Path: <linux-kernel+bounces-575388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11BA701C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C709B174485
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8225BADA;
	Tue, 25 Mar 2025 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MYmsZL+U"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0C1A08CA;
	Tue, 25 Mar 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908179; cv=pass; b=JXuJ9lr/yXHtTpMz0HV7Doj8tRVXwig9PkFpRnIfF4YOYm382KC5UzwDToInVjh9kBFlkujpHI+rZoGNwJSANasQVa/vhgpdEm1OR7SpjvnHYtXUTlzrGeY8HNbKpSLA+vBjefqtgSCDygBsCB9GtCFwz5BVew7tVWNBlwnL+iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908179; c=relaxed/simple;
	bh=qC4l4nPLUTUaBmleI7UPp73e252CkmVXUnVVOP0EV64=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ckxM8sQPDt0vbs0N4UAAgmx/HxP7HUDES6xRtJBHUFfHTY6Z8TKza0RA8GgERlJYbM5lCZuJ6uOyZW6GbK5UUIBD2amaay+gBgm+VSMFGzp7MRmnwPqQHJ6r5nB0hfMEkhJnGtlqA6ZakyTCAt992IRd9sIhlO1hakjL/mQwBK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=MYmsZL+U; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742908142; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DEE7M+6DmoZWacTR1YwipsLkVotmNDPAMQcKWj5XQDYddHmrb5najhjuIG8+ptuKP8s7yJczhZqmCda6aX+FViygjdkVKuXYuwLqnuigiyY7JYco8SKK28zNknP8WOjczlmiHC8y3V46fIYHNTeZ3p6kwrvK4Pb4ZVQ4DvIABZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742908142; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=loSLMFB/IK10Jq3RhR5KxRAIMn6HEZPEdIlCTq/6jts=; 
	b=SNCVvKQucVOW962iVCqqEqzoY9iX7BJ3NH2/c90Rhlt17G65X77EdLVUS7tOR062kPVgC823GV0a5UQjS4il6szbTASU6kahzkiuRxHYbGK6foQNLmEEIQ5pN5mah9Jk5wLiw/Lf5ooY5isjfjWQM81dRHk6SYy2SRYIHCzxDQk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742908142;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=loSLMFB/IK10Jq3RhR5KxRAIMn6HEZPEdIlCTq/6jts=;
	b=MYmsZL+UzosObPezDG7LFquTZ3PEdzao3JSj9QXecy4V9s7axf9ewD0xQk/PPsGC
	ADqJRQyApSzzJNpJVfFJ9CwjF5tVxhAr7yYMn97GpS6YIaFhxYjYsbk0e8rRNdev+fl
	RNgejQK7KBVuX3/SKYQDCfKoENk62joBMZFT+dhA=
Received: by mx.zohomail.com with SMTPS id 1742908138934887.6151181162378;
	Tue, 25 Mar 2025 06:08:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 01/11] scripts: generate_rust_analyzer.py: add missing
 whitespace
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-1-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 10:08:42 -0300
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
Message-Id: <E0ED9858-7ABC-4461-BDB8-38D59AD3AF8B@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-1-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Add a space before the `/` operator for consistency with surrounding
> code and code formatting tools. Add a second newline between top-level
> items in accordance with PEP 8[1]:
>=20
>> Surround top-level function and class definitions with two blank
> lines.
>=20
> This change was made by a code formatting tool.
>=20
> Link: https://peps.python.org/pep-0008/ [1]
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index a0e5a0aef444..fc1788764b31 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -118,7 +118,7 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
>     ):
>         append_crate(
>             display_name,
> -            srctree / "rust"/ display_name / "lib.rs",
> +            srctree / "rust" / display_name / "lib.rs",
>             deps,
>             cfg=3Dcfg,
>         )
> @@ -193,5 +193,6 @@ def main():
>=20
>     json.dump(rust_project, sys.stdout, sort_keys=3DTrue, indent=3D4)
>=20
> +
> if __name__ =3D=3D "__main__":
>     main()
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>



