Return-Path: <linux-kernel+bounces-297946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5C95BF82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E380B1F24704
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C21D0DC3;
	Thu, 22 Aug 2024 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="heuVggci"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06E1BF3A;
	Thu, 22 Aug 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358478; cv=none; b=lpHJ0reNrPXJUjn+8t01kfF5Fn5wsboYKYtRHwRAivEHiY6Re6mAzAen8dRholEJgJOb//J/Gqtu4vbkIw4VW2mWPlXIs7w8A09l9zFDg6A69GOkdaF4fKPhbFBa0QIFDnD7drPXYrxZBkCXOtNpvdezsaV/KenPCfa5kxZz1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358478; c=relaxed/simple;
	bh=qhAa+DZHF9p9Q3Oqx+GNM4SBsaAPWcXvKFXKK/iHx5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lciomj5sxnHExARrr+p93YfgOb6STHsKAwEXX1ZSE641Srto7RptlLNoPF23vD2n9m+dnXD28kZi54Baz3Z/D5ndUa6RXO4fx36uBIcwQkaIoVtKYkqVs/8dVykfGdgWQR0H3ALe1N5Ob3b9Z6hOeTK9UlgiC/rjvNafrRHSEt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=heuVggci; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724358473; x=1724617673;
	bh=qhrVJME/TVc+nkhTY4ymDiaKtXm+h6wS453WZyaCymE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=heuVggci3Rul3WCQ+DVP4Nzw99r4Z+fb/03GYNoT09ZLxRz05kXmPZjly/qKbN7X+
	 L4B4GImt7GSabKuHvXpq3hxDS5dlNEkK70xtd0YNuKe/2z6Cdms/fflsAh2PW0ktCY
	 pIgTMVviA7HmoIv9RpjIKaQzValq5FjFecAuVfhcAGmi9wLoOq4BaSbZrK9KjfYWcT
	 c5bVB5A5lKvHIqu6dvWLH0UnIBCCOOcEuTmIApArfbnhS0wr9zOLRaKmFwrXvxQyTV
	 /Mwkc6VjmaO5wiveou6RO3mb04mxucYOa0mgq1ITTaYnT2NDKN7AcQY3i7oBgUG+kg
	 WMW+djPR6qhMA==
Date: Thu, 22 Aug 2024 20:27:48 +0000
To: Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com, ojeda@kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: kernel: add support for bits/genmask macros
Message-ID: <15e93515-400b-4cd3-8f35-afcba24fb32b@proton.me>
In-Reply-To: <20240822173518.2717-1-daniel.almeida@collabora.com>
References: <20240822173518.2717-1-daniel.almeida@collabora.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 02ad3e09411026153390232ab1ac88d95ee2977d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.08.24 19:35, Daniel Almeida wrote:
> These macros were converted from their C equivalent.
> ---
>=20
> Hey all, I did not see any patch for this floating in the mailing list.
>=20
> Please let me know your thoughts. This one should be rather trivial.
>=20
>=20
>  rust/kernel/bits.rs | 32 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs  |  1 +
>  2 files changed, 33 insertions(+)
>  create mode 100644 rust/kernel/bits.rs
>=20
> diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
> new file mode 100644
> index 000000000000..8ac142392086
> --- /dev/null
> +++ b/rust/kernel/bits.rs
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Bit manipulation macros.
> +//!
> +//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
> +
> +/// Produces a literal where bit `n` is set.
> +///
> +/// Equivalent to the kernel's BIT macro.

For better markdown rendering, you should use backtics on `BIT`.

> +///
> +#[macro_export]
> +macro_rules! bit {
> +    ($n:expr) =3D> {

Using `expr` here will allow things like `bit!(3 + 8)`. I am not sure if
we want that, is that the same behavior as in C?
If we don't want that, we can use `literal` instead.
I am not suggesting changing it, only if it makes sense.

> +        (1 << $n)
> +    };
> +}
> +
> +/// Create a contiguous bitmask starting at bit position `l` and ending =
at
> +/// position `h`, where h <=3D l.

Ditto here for `h <=3D l`.

> +///
> +/// For example genmask(39, 21) gives us the 64bit vector
> +/// 0x000000ffffe00000.

This can probably be an example (with ``` and `assert!`), because then
we also test the macro already :)

> +///
> +#[macro_export]
> +macro_rules! genmask {
> +    ($h:expr, $l:expr) =3D> {{

Same question about `expr` vs `literal` here.

> +        const _: () =3D {
> +            assert!($h >=3D $l);

Would be nice to mention this in the documentation.

---
Cheers,
Benno

> +        };
> +        ((!0u64 - (1u64 << $l) + 1) & (!0u64 >> (64 - 1 - $h)))
> +    }};
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 274bdc1b0a82..3aaa1c410d2c 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -27,6 +27,7 @@
>  extern crate self as kernel;
>=20
>  pub mod alloc;
> +pub mod bits;
>  #[cfg(CONFIG_BLOCK)]
>  pub mod block;
>  mod build_assert;
> --
> 2.45.2
>=20
>=20


