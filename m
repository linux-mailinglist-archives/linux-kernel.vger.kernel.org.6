Return-Path: <linux-kernel+bounces-257516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C52937B20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00495B22249
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDF0146586;
	Fri, 19 Jul 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RhmkLl0g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69D1B86D9;
	Fri, 19 Jul 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407011; cv=none; b=Lixji7Izk7R4I/IF8Ksb2qG/KErygxu3Oh69r77Vq6tnOS4SwK8aIfZT3TrDt0WCqfeHYT/I8KfYDYibk8PNy2jNQa8RAbL21IHDz8g7mV3fnh6h5EON+Kvn8Xc5lA04K3J08vUzM3oJjPEfFdPNF+VIvp1yBHz57szlbgV1k8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407011; c=relaxed/simple;
	bh=ViAOgDbqOJgSD3XNJ+MZa5I9UegRL4khnice5Z8aE88=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YyxnRVFh+J6hwHr6oKLlAewNnqtrqptYtII/3fsdh70QLOYuC+9LScYrdIRTmBhUyrVMjAII4OFGEk7MOsXHILf+GbZyzL61KWuPGFaWneDvDXNHlJ2pycsV4Q8ALk3VVQjFvYLA6edUn1QWdOW4MOAAgnacXIfFUpPSsrgv1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RhmkLl0g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721407008;
	bh=ViAOgDbqOJgSD3XNJ+MZa5I9UegRL4khnice5Z8aE88=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=RhmkLl0gSTVCFVG/G6swUlsffFRzMEybo8Pt86DkA3AUXxOXZ9HbMaZhdoAfdkx7m
	 QaqtUa2Vy1zG0FLvMEOUxDuRdDR85zktW2H0rg396oMo7qplcR8mNrEJXXVqutb1wp
	 Qe2en0tAyzlQLgmZPsn+X3TECFQBG85SuwNac1mSEYT/XqOmHCUIm1CWWVh5Dyui6A
	 K0w7M4/uCnelD/RF1LATyByZsaKjJs5XNeR1GtJ/WdDVWdbXgllmNkYn8gIRSul/x0
	 PtBiBFPfzzZscbc+Gn3t3/PhN1MudEXnHEna3GFEmKM1OlxKc1RaP9GmVfhH+bRkJi
	 7IvetuZWDIKug==
Received: from smtpclient.apple (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2B76637813D3;
	Fri, 19 Jul 2024 16:36:43 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH 2/5] doc: rust: safety standard: add examples
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240717221133.459589-3-benno.lossin@proton.me>
Date: Fri, 19 Jul 2024 13:36:31 -0300
Cc: Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0E3D539-2D29-4BB4-9CB7-98672F590A57@collabora.com>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-3-benno.lossin@proton.me>
To: Benno Lossin <benno.lossin@proton.me>
X-Mailer: Apple Mail (2.3774.600.62)

Sorry, ended up replying to this using my personal email.

Sending it again.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

Hi Benno,

> On 17 Jul 2024, at 19:12, Benno Lossin <benno.lossin@proton.me> wrote:
>=20
> Add examples of good and bad safety documentation.
>=20
> There aren't many examples at the moment, as I hope to add more during
> discussions, since coming up with examples on my own is very =
difficult.
>=20
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> .../rust/safety-standard/examples.rst         | 70 +++++++++++++++++++
> Documentation/rust/safety-standard/index.rst  | 23 ++++--
> 2 files changed, 86 insertions(+), 7 deletions(-)
> create mode 100644 Documentation/rust/safety-standard/examples.rst
>=20
> diff --git a/Documentation/rust/safety-standard/examples.rst =
b/Documentation/rust/safety-standard/examples.rst
> new file mode 100644
> index 000000000000..d66ef3f8954a
> --- /dev/null
> +++ b/Documentation/rust/safety-standard/examples.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. highlight:: rust
> +
> +Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Unsound APIs
> +------------
> +
> +Simple Unsound Function
> +***********************
> +::
> +
> +    struct Data {
> +        a: usize,
> +    }
> +
> +    fn access_a(data: *mut Data) -> usize {
> +        unsafe { (*data).a }
> +    }
> +
> +One would normally call this function as follows, which does not =
trigger UB::
> +
> +    fn main() {
> +        let mut d =3D Data { a: 42 };
> +        println!("{}", access_a(&mut d));
> +    }
> +
> +However, a caller could also call it like this, which triggers UB =
using only safe code::
> +
> +    fn main() {
> +        println!("{}", access_a(core::ptr::null_mut()));
> +    }
> +
> +And this would result in a dereference of a null pointer.
> +
> +
> +Sound ``unsafe`` Code
> +---------------------
> +
> +The Importance of the API Boundary
> +**********************************
> +
> +Is the following API sound?::
> +
> +    fn foo(r: &mut u32) {
> +        let ptr: *mut u32 =3D r;
> +        let val;
> +        unsafe {
> +            val =3D *ptr;
> +            *ptr =3D 0;
> +        }
> +    }
> +
> +It better be sound, but one could argue that it is unsound, since one =
could replace the ptr
> +initialization by ``ptr =3D core::ptr::null_mut()``::
> +
> +    fn foo(r: &mut u32) {
> +        let ptr: *mut u32 =3D core::ptr::null_mut();
> +        let val;
> +        unsafe {
> +            val =3D *ptr;
> +            *ptr =3D 0;
> +        }
> +    }
> +
> +But this modification is not allowed, since it goes beyond the API =
boundary of ``foo``. This way
> +any ``unsafe`` code that relies on surrounding safe code could be =
shown to be unsound. Instead one
> +should only consider safe code using the API, in this case, there is =
no way to make the code
> +incorrect, since a reference is always valid to dereference during =
its lifetime.

I find this paragraph a bit confusing. Maybe this can be clarified a bit =
further?


=E2=80=94 Daniel=

