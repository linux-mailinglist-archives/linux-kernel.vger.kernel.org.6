Return-Path: <linux-kernel+bounces-575497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E435FA7033F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB6416A17D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7025A2B3;
	Tue, 25 Mar 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="cKRRuCbk"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C91DD9D3;
	Tue, 25 Mar 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911788; cv=pass; b=sn7dgpO4ksV2pwPNoKeqHj1AuimkuEm4LWYrskMU5Y6cnPTAbXjFhzD78Fi7HOTw3mJrKjMEhknCFxYMVVAgI/b/qSLnQOjd0ejdiDbn2gDHqnsFKAUc9x/cKuZxnr2Rq5vmdDFXxgb1oH/OBmaW0XMbeVOxfmFxW6VPPlcPm7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911788; c=relaxed/simple;
	bh=Ch6+qUgGynR/70jdVo3jg+Clw0dnQHwqKoYj5m7skgY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fBQWBFOiabjkGHsj9+DM2QGfKPe3MDpD7O/6IUXqPQV673MymCtLSvtIJi5IdR9rxKNT1Xypj0jIQgaD+vqQ2ADABqfDD0KdJ82TexaexOJT8vsEsfn0nTzFtzPKE+06cGHviam3cimFScA22jF2PDKSNUvgbiNK54Js+CmIWNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=cKRRuCbk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742911745; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l0RIF5Z2CTTHhQ0EA1qs2Oflg5cB7509sExFx/Dt2+tRIYOCSgFc72v1gdp4KmvZcpGfD+c5gF/wPjamqJgFCFo7+PYFWAsCjH5GbYAoAZbT3NzoMHR9QQj2zthjZAPfYKF3HArhZDAyYYvyq2ov0JGmXKpqTKw2NjbEe9b27ss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742911745; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IhGvb/tLAJnIoiWvG3hYv5l20MW1d5v5bmCOcmdtFrM=; 
	b=LetY3gTN+PW3cAJKgoGJ/o/5V1wjREkVaFB2GJ2mT2twEHkiwiOrV4LMyC5u7EFxQkisPy+wNqzEWD1b9/L6i+9/M078NddiNCYwpnw10d2nbmi/czx9nuViryClfWvKrJVD1UDaZ8GFxbcnKg7Nn5nvimDE6j5XvClcuqpFuNw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742911745;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=IhGvb/tLAJnIoiWvG3hYv5l20MW1d5v5bmCOcmdtFrM=;
	b=cKRRuCbkeGnyTCP+5lMZJv/Yv16APiNwxCZHS6tryzHzsOjM+t25XJQN9oOyRmph
	/IST+uC/HcSWTK9xUt0Ee9csF+mLQeN+69WziQMA2NdT+ced5+7rA0YEOMD5rnOkYJG
	ciLMfgCZ1v7ZSg884IDtFNcWBrcuYiNjscx/+X1o=
Received: by mx.zohomail.com with SMTPS id 1742911743160345.8065019059693;
	Tue, 25 Mar 2025 07:09:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 10/11] scripts: generate_rust_analyzer.py: define
 scripts
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-10-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 11:08:46 -0300
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
Message-Id: <101DAAC6-5EA6-4CA4-B593-4B928877057D@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-10-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Generate rust-project.json entries for scripts written in Rust. This =
is
> possible now that we have a definition for `std` built for the host.
>=20
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index ccb15aa66929..957b413fe0b6 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -209,6 +209,19 @@ def generate_crates(
>     uapi =3D append_crate_with_generated("uapi", [core])
>     kernel =3D append_crate_with_generated("kernel", [core, macros, =
build_error, bindings, pin_init, uapi])
>=20
> +    scripts =3D srctree / "scripts"
> +    with open(scripts / "Makefile") as f:
> +        makefile =3D f.read()
> +    for path in scripts.glob("*.rs"):
> +        name =3D path.name.replace(".rs", "")
> +        if f"{name}-rust" not in makefile:
> +            continue
> +        _script =3D append_crate(
> +            name,
> +            path,
> +            [host_std],
> +        )
> +
>     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
>         try:
>             with open(build_file) as f:
>=20
> --=20
> 2.48.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

