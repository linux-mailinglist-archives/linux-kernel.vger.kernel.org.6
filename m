Return-Path: <linux-kernel+bounces-575476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83559A7030E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4460C188B262
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3202571D1;
	Tue, 25 Mar 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DBvbLNZG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686AB2566FA;
	Tue, 25 Mar 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910918; cv=pass; b=Hfc/m/3+Sy2o9RzCXxrhZYeOHTcc9TS7xzRJWJ0kGsDO58F2OXFZdijwyDM8fx+DEe5gIdaKtwDDHjtUMphvFx0KZRcv/JZK0AY9r9tYp9mLVywUiWmnfat4JpyAtXRg1wNiIQji0M91rh4oa72CD6o6D1gJ6ziqlU48XqA1Fk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910918; c=relaxed/simple;
	bh=i+sVinHyZgUMFUgbgzwqjR6R3h8KBa5y6Gh/Fm+Zgh8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=vE3QKnDa6G82eC9SvR4CfD/zg7/VgC2dju81/+wRSWAs+kI4tfSziQizxMUO2afFhYPl13vHUaPM98YZsrxIAdWJmnIgQzMlbz0XtzFoLJhWkICoJOUXvxYmEllJOzbwBrFl0b5CIwXOjXjOp3bRBg6Nijvc8KclVQRb8LC1DvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DBvbLNZG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742910892; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BJt/YyzQWB3z+6muMHyakXea1D0T/0jBm7vnEn1wNvwDoAXCKVrQVMz62aHqvMEFvZnyPcF6UUwmG8ka9xp4suL+MmRwW6b2uqmrHPdQL2hLfR/tBKHrTyBplJ7Q36C4SznexW3HDh+hLDjhGs1q/2wX54bzOAK9FUVA8T81rP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742910892; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eJT61RAHvSsZ1+Zhc5U3fSiApHbPl+/Bb0UyFMw79nU=; 
	b=GqNldygQ/Cg0iEnREcXUI5Ir94DYwXFeItqSAUtquSOegetwClaWicGzTJDKhe9U8hfltD4fZcuZxbcFWn/sKrvj/KlgS1dIv8bzIo1zLkYr6K5H91vRt5jrqLcUVFVZfDhmTK4X70apwGG2GnZCbpi/62uIKruNMurix3l2SYo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742910892;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=eJT61RAHvSsZ1+Zhc5U3fSiApHbPl+/Bb0UyFMw79nU=;
	b=DBvbLNZGWneEo4ND5NkwJc/le9nq+1xIOFhvuYu7TLyZERSAW0wF6WbC6ye13L2V
	U9kMT+5ecJ6Z/Nd4MPjdqOktlDmX/ebsi6zHVwiks5OEQyMeGIbJWURUFgAIptoV+if
	rWku2RSbO8/utAbw1r6AhyMD23KiS7DFKrT8HJok=
Received: by mx.zohomail.com with SMTPS id 174291089101074.08195557486181;
	Tue, 25 Mar 2025 06:54:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v2] rust: add new macro for common bitmap operations
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250325-feat-add-bitmask-macro-v2-1-d3beabdad90f@gmail.com>
Date: Tue, 25 Mar 2025 10:54:35 -0300
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
 rust-for-linux@vger.kernel.org,
 felipe_life@live.com,
 linux-kernel@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A86CF7A-C504-4870-A9DE-C44C1751F4E4@collabora.com>
References: <20250325-feat-add-bitmask-macro-v2-1-d3beabdad90f@gmail.com>
To: Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Filipe, just a few comments for now:

> On 25 Mar 2025, at 10:10, Filipe Xavier <felipeaggger@gmail.com> =
wrote:
>=20
> We have seen a proliferation of mod_whatever::foo::Flags
> being defined with essentially the same implementation
> for BitAnd, BitOr, contains and etc.
>=20
> This macro aims to bring a solution for this,
> allowing to generate these methods for user-defined structs.
> With some use cases in KMS and VideoCodecs.

There is no one working on Rust support for video codecs as of today, =
please say
=E2=80=9Cupcoming GPU drivers=E2=80=9D instead.

>=20
> Small use sample:
> `
> const READ: Permission =3D Permission(1 << 0);
> const WRITE: Permission =3D Permission(1 << 1);
>=20
> impl_flags!(Permissions, Permission, u32);
>=20
> let read_write =3D Permissions::from(READ) | WRITE;
> let read_only =3D read_write & READ;
> `
>=20

Not really sure we need this in the commit message as we already have
the examples section, which doubles as a kunit test.

At best, this will become stale and a source of errors.

> Link: =
https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/=
We.20really.20need.20a.20common.20.60Flags.60.20type
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Suggested-by: Lyude Paul <lyude@redhat.com>
> ---
> Changes in v2:
> - rename: change macro and file name to impl_flags.
> - negation sign: change char for negation to `!`.=20
> - transpose docs: add support to transpose user provided docs.
> - visibility: add support to use user defined visibility.
> - operations: add new operations for flag,=20
> to support use between bit and bitmap, eg: flag & flags.
> - code style: small fixes to remove warnings.
> - Link to v1: =
https://lore.kernel.org/r/20250304-feat-add-bitmask-macro-v1-1-1c2d2bcb476=
b@gmail.com
> ---
> rust/kernel/impl_flags.rs | 214 =
++++++++++++++++++++++++++++++++++++++++++++++
> rust/kernel/lib.rs        |   1 +
> rust/kernel/prelude.rs    |   1 +
> 3 files changed, 216 insertions(+)
>=20
> diff --git a/rust/kernel/impl_flags.rs b/rust/kernel/impl_flags.rs
> new file mode 100644
> index =
0000000000000000000000000000000000000000..e7cf00e14bdcd2acea47b8c158a984ac=
0206568b
> --- /dev/null
> +++ b/rust/kernel/impl_flags.rs
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! impl_flags utilities for working with flags.
> +
> +/// Declares a impl_flags type with its corresponding flag type.
> +///
> +/// This macro generates:
> +/// - Implementations of common bitmask operations ([`BitOr`], =
[`BitAnd`], etc.).
> +/// - Utility methods such as `.contains()` to check flags.
> +///
> +/// # Examples
> +///
> +/// Defining and using impl_flags:
> +///
> +/// ```
> +/// impl_flags!(
> +///     /// Represents multiple permissions.
> +///     pub Permissions,
> +///     /// Represents a single permission.
> +///     pub Permission,
> +///     u32
> +/// );
> +///
> +/// // Define some individual permissions.
> +/// const READ: Permission =3D Permission(1 << 0);
> +/// const WRITE: Permission =3D Permission(1 << 1);
> +/// const EXECUTE: Permission =3D Permission(1 << 2);
> +///
> +/// // Combine multiple permissions using operation OR (`|`).
> +/// let read_write =3D Permissions::from(READ) | WRITE;

We need to move away from this syntax. Can you please update the =
example? :)

> +///
> +/// assert!(read_write.contains(READ));
> +/// assert!(read_write.contains(WRITE));
> +/// assert!(!read_write.contains(EXECUTE));
> +///
> +/// // Removing a permission with operation AND (`&`).
> +/// let read_only =3D read_write & READ;
> +/// assert!(read_only.contains(READ));
> +/// assert!(!read_only.contains(WRITE));
> +///
> +/// // Toggling permissions with XOR (`^`).
> +/// let toggled =3D read_only ^ Permissions::from(READ);
> +/// assert!(!toggled.contains(READ));
> +///
> +/// // Inverting permissions with negation (`!`).
> +/// let negated =3D !read_only;
> +/// assert!(negated.contains(WRITE));
> +/// ```
> +#[macro_export]
> +macro_rules! impl_flags {
> +    (
> +        $(#[$outer_flags:meta])* $vis_flags:vis $flags:ident,
> +        $(#[$outer_flag:meta])* $vis_flag:vis $flag:ident,
> +        $ty:ty
> +    ) =3D> {
> +        $(#[$outer_flags])*
> +        #[repr(transparent)]
> +        #[derive(Copy, Clone, Default, PartialEq, Eq)]
> +        $vis_flags struct $flags($ty);
> +
> +        $(#[$outer_flag])*
> +        #[derive(Copy, Clone, PartialEq, Eq)]
> +        $vis_flag struct $flag($ty);
> +
> +        impl From<$flag> for $flags {
> +            #[inline]
> +            fn from(value: $flag) -> Self {
> +                Self(value.0)
> +            }
> +        }
> +
> +        impl From<$flags> for $ty {
> +            #[inline]
> +            fn from(value: $flags) -> Self {
> +                value.0
> +            }
> +        }
> +
> +        impl core::ops::BitOr for $flags {
> +            type Output =3D Self;
> +
> +            #[inline]
> +            fn bitor(self, rhs: Self) -> Self::Output {
> +                Self(self.0 | rhs.0)
> +            }
> +        }
> +
> +        impl core::ops::BitOrAssign for $flags {
> +            #[inline]
> +            fn bitor_assign(&mut self, rhs: Self) {
> +                *self =3D *self | rhs;
> +            }
> +        }
> +
> +        impl core::ops::BitAnd for $flags {
> +            type Output =3D Self;
> +
> +            #[inline]
> +            fn bitand(self, rhs: Self) -> Self::Output {
> +                Self(self.0 & rhs.0)
> +            }
> +        }
> +
> +        impl core::ops::BitAndAssign for $flags {
> +            #[inline]
> +            fn bitand_assign(&mut self, rhs: Self) {
> +                *self =3D *self & rhs;
> +            }
> +        }
> +
> +        impl core::ops::BitOr<$flag> for $flags {
> +            type Output =3D Self;
> +
> +            #[inline]
> +            fn bitor(self, rhs: $flag) -> Self::Output {
> +                self | Self::from(rhs)
> +            }
> +        }
> +
> +        impl core::ops::BitOrAssign<$flag> for $flags {
> +            #[inline]
> +            fn bitor_assign(&mut self, rhs: $flag) {
> +                *self =3D *self | rhs;
> +            }
> +        }
> +
> +        impl core::ops::BitAnd<$flag> for $flags {
> +            type Output =3D Self;
> +
> +            #[inline]
> +            fn bitand(self, rhs: $flag) -> Self::Output {
> +                self & Self::from(rhs)
> +            }
> +        }
> +
> +        impl core::ops::BitAndAssign<$flag> for $flags {
> +            #[inline]
> +            fn bitand_assign(&mut self, rhs: $flag) {
> +                *self =3D *self & rhs;
> +            }
> +        }
> +
> +        impl core::ops::BitXor for $flags {
> +            type Output =3D Self;
> +
> +            #[inline]
> +            fn bitxor(self, rhs: Self) -> Self::Output {
> +                Self(self.0 ^ rhs.0)
> +            }
> +        }
> +
> +        impl core::ops::BitXorAssign for $flags {
> +            #[inline]
> +            fn bitxor_assign(&mut self, rhs: Self) {
> +                *self =3D *self ^ rhs;
> +            }
> +        }
> +
> +        impl core::ops::Not for $flags {
> +            type Output =3D Self;
> +
> +            #[inline]
> +            fn not(self) -> Self::Output {
> +                Self(!self.0)
> +            }
> +        }
> +
> +        impl core::ops::BitOr for $flag {
> +            type Output =3D $flags;
> +            #[inline]
> +            fn bitor(self, rhs: Self) -> Self::Output {
> +                $flags(self.0 | rhs.0)
> +            }
> +        }

I see that you=E2=80=99ve already taken care of writing the code to make =
it work, so it=E2=80=99s just the
example that needs to be updated.

> +
> +        impl core::ops::BitAnd for $flag {
> +            type Output =3D $flags;
> +            #[inline]
> +            fn bitand(self, rhs: Self) -> Self::Output {
> +                $flags(self.0 & rhs.0)
> +            }
> +        }
> +
> +        impl core::ops::BitXor for $flag {
> +            type Output =3D $flags;
> +            #[inline]
> +            fn bitxor(self, rhs: Self) -> Self::Output {
> +                $flags(self.0 ^ rhs.0)
> +            }
> +        }
> +
> +        impl core::ops::Not for $flag {
> +            type Output =3D $flags;
> +            #[inline]
> +            fn not(self) -> Self::Output {
> +                $flags(!self.0)
> +            }
> +        }
> +
> +        impl $flags {
> +            /// Returns an empty instance of `type` where no flags =
are set.
> +            #[inline]
> +            pub const fn empty() -> Self {
> +                Self(0)
> +            }
> +
> +            /// Checks if a specific flag is set.
> +            #[inline]
> +            pub fn contains(self, flag: $flag) -> bool {
> +                (self.0 & flag.0) =3D=3D flag.0
> +            }
> +        }
> +    };
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index =
496ed32b0911a9fdbce5d26738b9cf7ef910b269..7653485a456ae5aa51becbf04153ea54=
a7067d9e 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -49,6 +49,7 @@
> #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> pub mod firmware;
> pub mod fs;
> +pub mod impl_flags;
> pub mod init;
> pub mod io;
> pub mod ioctl;
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index =
dde2e0649790ca24e6c347b29465ea0a1c3e503b..0f691dd2df71d821265fae01555ba50e=
6a76f372 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -25,6 +25,7 @@
> #[doc(no_inline)]
> pub use super::dbg;
> pub use super::fmt;
> +pub use super::impl_flags;
> pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, =
dev_info, dev_notice, dev_warn};
> pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, =
pr_info, pr_notice, pr_warn};
>=20
>=20
> ---
> base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
> change-id: 20250304-feat-add-bitmask-macro-6424b1c317e2
>=20
> Best regards,
> --=20
> Filipe Xavier <felipeaggger@gmail.com>
>=20

Give me a couple of days and I=E2=80=99ll test this.

=E2=80=94 Daniel


