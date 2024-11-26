Return-Path: <linux-kernel+bounces-422675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423E9D9CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E360F1654B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906811DD87C;
	Tue, 26 Nov 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="V2WCb+Ql"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AB1DCB2B;
	Tue, 26 Nov 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642928; cv=pass; b=CE9vwapWIaepCPKa4Iw89nOtHUnRpQnDzKL1kNWhdL9TKpr5OKoa//4s8KZvW1ucFKI6/hVjrH5QtJ0qSkW8GBTb+jxkU/CAqz0eVkKPE//BJiKpdmLEG+iZcol9sc3DohjpQtbWLQy/TS0Q+ir3twA1a0czKzb6fbO8yGZjxAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642928; c=relaxed/simple;
	bh=VcRpWYVBqsvODLd2j0NmxlNTKDK1paBpiVl6Wb3+EDQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mq86NXgUFshz8Nu3OtwCnvsbTACowtM0Sn4RApDf51nseL6U8JvIzk0Sn9yvMXNU6a9WaYkNxdHyStJdmPGOzxMNY7ZeWHN6i2hZv9lYBTnbhUbI5tPwcqXd5eEt5W1rjsgswliKRcJ3htEdt869ehuGOTi1VDjUGBXdbbVodLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=V2WCb+Ql; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732642873; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mU8ObQ/OAasMBkzcFvPwQKo4sBO2cC9gkN/zJB906dZtgy4L6dh0j5lIrqsuYhqu6u1KB75AxOkYsb8KNZXALxyyfSiEd6hoEAm6FD8F4M+UwGfl2+zeTyqTtGMjmhY+tjhVKUZ9npGu/rrLqm92JZwKXKMYi2TKiKFh8AVXIuU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732642873; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AAZ0ziV0Ps+SEYxmzXSmejq4AyrtN53riw5JdtP05F0=; 
	b=ECae4fssoCytQMK457kvWbYJzVj3z1p/Wm+3kaAe9EPdTNwCoOiGSHM6BkJDNPKrpVP+kvXv5ZLEkjUBqG4T+HZk62lo2U+yvYD9PH283IR84iju4BzDXm8UXfL2GKcObuUK5g/o7r+izamzrDFnRSLyyCGJoLdryYfObcQ7QI0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732642873;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=AAZ0ziV0Ps+SEYxmzXSmejq4AyrtN53riw5JdtP05F0=;
	b=V2WCb+QlhgmujqFmfJJ01mbCKOmqJTsbtM8Oq44IrsxKyXukcU7ee1jt1hO4TM4S
	57CCwcpTu8xcheP8z5GYjUhXjwmZsJXeUXlv5w45y6Y0pQfDSESL47PIo6JdnKLYM2/
	P6O1yMUds34rgkKQCbxoLoZTFN4b20B0tmITeiUY=
Received: by mx.zohomail.com with SMTPS id 1732642870668244.09361775176467;
	Tue, 26 Nov 2024 09:41:10 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 01/35] WIP: rust/drm: Add fourcc bindings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-2-lyude@redhat.com>
Date: Tue, 26 Nov 2024 14:40:54 -0300
Cc: dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Asahi Lina <lina@asahilina.net>,
 Danilo Krummrich <dakr@kernel.org>,
 mcanal@igalia.com,
 airlied@redhat.com,
 zhiw@nvidia.com,
 cjia@nvidia.com,
 jhubbard@nvidia.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@redhat.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A7B3FCB-0A97-4818-9AE4-A1911EA55B90@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-2-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude, sorry for the late review!

> On 30 Sep 2024, at 20:09, Lyude Paul <lyude@redhat.com> wrote:
>=20
> This adds some very basic rust bindings for fourcc. We only have a =
single
> format code added for the moment, but this is enough to get a driver
> registered.
>=20
> TODO:
> * Write up something to automatically generate constants from the =
fourcc
>  headers

I assume this is blocked on [0], right?

>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/bindings/bindings_helper.h |   1 +
> rust/kernel/drm/fourcc.rs       | 127 ++++++++++++++++++++++++++++++++
> rust/kernel/drm/mod.rs          |   1 +
> 3 files changed, 129 insertions(+)
> create mode 100644 rust/kernel/drm/fourcc.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index b2e05f8c2ee7d..04898f70ef1b8 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
> #include <drm/drm_device.h>
> #include <drm/drm_drv.h>
> #include <drm/drm_file.h>
> +#include <drm/drm_fourcc.h>
> #include <drm/drm_gem.h>
> #include <drm/drm_gem_shmem_helper.h>
> #include <drm/drm_ioctl.h>
> diff --git a/rust/kernel/drm/fourcc.rs b/rust/kernel/drm/fourcc.rs
> new file mode 100644
> index 0000000000000..b80eba99aa7e4
> --- /dev/null
> +++ b/rust/kernel/drm/fourcc.rs
> @@ -0,0 +1,127 @@
> +use bindings;
> +use core::{ops::*, slice, ptr};
> +
> +const fn fourcc_code(a: u8, b: u8, c: u8, d: u8) -> u32 {
> +    (a as u32) | (b as u32) << 8 | (c as u32) << 16 | (d as u32) << =
24
> +}
> +
> +// TODO: Figure out a more automated way of importing this
> +pub const XRGB888: u32 =3D fourcc_code(b'X', b'R', b'2', b'4');
> +
> +#[derive(Copy, Clone)]
> +#[repr(C)]
> +pub struct FormatList<const COUNT: usize> {
> +    list: [u32; COUNT],
> +    _sentinel: u32,
> +}
> +
> +impl<const COUNT: usize> FormatList<COUNT> {
> +    /// Create a new [`FormatList`]
> +    pub const fn new(list: [u32; COUNT]) -> Self {
> +        Self {
> +            list,
> +            _sentinel: 0
> +        }
> +    }
> +
> +    /// Returns the number of entries in the list, including the =
sentinel.
> +    ///
> +    /// This is generally only useful for passing [`FormatList`] to C =
bindings.
> +    pub const fn raw_len(&self) -> usize {
> +        COUNT + 1
> +    }
> +}
> +
> +impl<const COUNT: usize> Deref for FormatList<COUNT> {
> +    type Target =3D [u32; COUNT];
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.list
> +    }
> +}
> +
> +impl<const COUNT: usize> DerefMut for FormatList<COUNT> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        &mut self.list
> +    }
> +}
> +
> +#[derive(Copy, Clone)]
> +#[repr(C)]
> +pub struct ModifierList<const COUNT: usize> {
> +    list: [u64; COUNT],
> +    _sentinel: u64
> +}
> +
> +impl<const COUNT: usize> ModifierList<COUNT> {
> +    /// Create a new [`ModifierList`]
> +    pub const fn new(list: [u64; COUNT]) -> Self {
> +        Self {
> +            list,
> +            _sentinel: 0
> +        }
> +    }
> +}
> +
> +impl<const COUNT: usize> Deref for ModifierList<COUNT> {
> +    type Target =3D [u64; COUNT];
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.list
> +    }
> +}
> +
> +impl<const COUNT: usize> DerefMut for ModifierList<COUNT> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        &mut self.list
> +    }
> +}
> +
> +#[repr(transparent)]
> +#[derive(Copy, Clone)]
> +pub struct FormatInfo {
> +    inner: bindings::drm_format_info,
> +}
> +
> +impl FormatInfo {
> +    // SAFETY: `ptr` must point to a valid instance of a =
`bindings::drm_format_info`
> +    pub(super) unsafe fn from_raw<'a>(ptr: *const =
bindings::drm_format_info) -> &'a Self {

I think FormatInfoRef would be more appropriate, since you seem to be =
creating a reference type (IIUC)
for a type that can also be owned.

This would be more in line with the GEM [1] patch, for example.

In other words, using `Ref` here will allow for both an owned =
`FormatInfo` and a `FormatInfoRef<=E2=80=98_>`.

I am not sure about the role of lifetime =E2=80=98a here. If you wanted =
to tie the lifetime of &Self to that of the pointer,
this does not do it, specially considering that pointers do not have =
lifetimes associated with them.

> +        // SAFETY: Our data layout is identical
> +        unsafe { &*ptr.cast() }

It=E2=80=99s hard to know what is going on with both the reborrow and =
the cast in the same statement.

I am assuming that cast() is transforming to *Self, and the reborrow to =
&Self.

To be honest, I dislike this approach. My suggestion here is to rework =
it to be similar to, e.g., what
Alice did here for `ShrinkControl` [2].

+/// This struct is used to pass information from page reclaim to the =
shrinkers.
+///
+/// # Invariants
+///
+/// `ptr` has exclusive access to a valid `struct shrink_control`.
+pub struct ShrinkControl<'a> {
+ ptr: NonNull<bindings::shrink_control>,
+ _phantom: PhantomData<&'a bindings::shrink_control>,
+}
+
+impl<'a> ShrinkControl<'a> {
+ /// Create a `ShrinkControl` from a raw pointer.
+ ///
+ /// # Safety
+ ///
+ /// The pointer should point at a valid `shrink_control` for the =
duration of 'a.
+ pub unsafe fn from_raw(ptr: *mut bindings::shrink_control) -> Self {
+ Self {
+ // SAFETY: Caller promises that this pointer is valid.
+ ptr: unsafe { NonNull::new_unchecked(ptr) },
+ _phantom: PhantomData,
+ }
+ }

Notice the use of PhantomData in her patch.

By the way, Alice, I wonder if we can just use Opaque here?

> +    }

> +
> +    /// The number of color planes (1 to 3)
> +    pub const fn num_planes(&self) -> u8 {
> +        self.inner.num_planes
> +    }
> +
> +    /// Does the format embed an alpha component?
> +    pub const fn has_alpha(&self) -> bool {
> +        self.inner.has_alpha
> +    }
> +
> +    /// The total number of components (color planes + alpha channel, =
if there is one)
> +    pub const fn num_components(&self) -> u8 {
> +        self.num_planes() + self.has_alpha() as u8
> +    }
> +
> +    /// Number of bytes per block (per plane), where blocks are =
defined as a rectangle of pixels
> +    /// which are stored next to each other in a byte aligned memory =
region.
> +    pub fn char_per_block(&self) -> &[u8] {
> +        // SAFETY: The union we access here is just for descriptive =
purposes on the C side, both
> +        // members are identical in data layout
> +        unsafe { =
&self.inner.__bindgen_anon_1.char_per_block[..self.num_components() as =
_] }
> +    }
> +}
> +
> +impl AsRef<bindings::drm_format_info> for FormatInfo {
> +    fn as_ref(&self) -> &bindings::drm_format_info {
> +        &self.inner
> +    }
> +}
> +
> +impl From<bindings::drm_format_info> for FormatInfo {
> +    fn from(value: bindings::drm_format_info) -> Self {
> +        Self { inner: value }
> +    }
> +}
> diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> index c44760a1332fa..2c12dbd181997 100644
> --- a/rust/kernel/drm/mod.rs
> +++ b/rust/kernel/drm/mod.rs
> @@ -5,5 +5,6 @@
> pub mod device;
> pub mod drv;
> pub mod file;
> +pub mod fourcc;
> pub mod gem;
> pub mod ioctl;
> --=20
> 2.46.1

=E2=80=94 Daniel

[0]: https://github.com/rust-lang/rust-bindgen/issues/753


[1]: =
https://gitlab.freedesktop.org/drm/nova/-/commit/cfd66f531af29e0616c58b4cd=
4c72770a5ac4081#71321381cbaa87053942373244bffe230e69392a_0_306

[2]: =
https://lore.kernel.org/rust-for-linux/20241014-shrinker-v2-1-04719efd2342=
@google.com/



