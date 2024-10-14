Return-Path: <linux-kernel+bounces-364603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081D999D6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C78B21E61
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872231CACD0;
	Mon, 14 Oct 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="EcVcI5vU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394044683;
	Mon, 14 Oct 2024 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931802; cv=pass; b=Y7Pl08wUBaBKCPmJ0Pg/37eCopVNMDZCNo9UpYhhiXFnMfx3fdLZuzPW2cuAgwVHwFc38iD5GH3G+WmzrwB7qVyoSLb57mzNlGWcdpe/A5JWYOI4bSllwa4wjzhd+Bzh4lA/E6TBy7SFJyGo4E7IUjQHGBSpXbrJhgRicie67Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931802; c=relaxed/simple;
	bh=g1+pL0UxEpEW5E8SaznMiUCKiHugLlMllDFdnSuoxH0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Pxg/PFt2It47hJy8lm18PWNP26HQ5mxGgixJuS3X9AZNWwn+DwmWphxTjR/wwIV/tMevFJq0MpF8fbIBOclJCGTx2iw8Bt58v7pAh0xfEWMGyHlNfweO9uhdKbaUKiaPVi0P7KgvKhrvUbFieTEk7YCPgS+k6uz5iljmHfQbwlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=EcVcI5vU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728931755; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DYESuGYeg8puK8oMR2cjcxiRKQBpyyjcPD9g5Q5eZj7dwKAYBEbQDdxROy04LBJw6NhcYVPMPLNSHf3dwHPjWhFvu91zaUTjfX6kQs2tBVNnAXmcB5FcQ/lxQlHq6QSPHrVRQ4vJwUHg34KUMiKZYoLaDToxt+cDZEIR41qAjyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728931755; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JjuTfG9pTSaOz9k2Eg+nDwIwmOylBHSqVWst+2ot0+8=; 
	b=UhEHXSQFPGO379FBmmzcbWO68rmLkLE2ao4mOG7e1H4hzZQJVTjPj+BCBmJQmwKTEFuM7W26s2P3051EnMT27LFac0A/wXr0q2TkjG2sBMyQ4Fmi3+Z3RwEDl8Q6RTnHtL+WoMOVnkdvvVSgwwnCLXL17Yy+/WCe9w2hPfA1ZWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728931755;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=JjuTfG9pTSaOz9k2Eg+nDwIwmOylBHSqVWst+2ot0+8=;
	b=EcVcI5vUUp7posXfBXG29ES282eDKUVKls8j8Eqm4ZPTUvY29pE6IPrs284KYLGb
	EsXNi1QMsoTFbIJVrYGI+LEisvpw/jFpTMLdO0Em4g0XMI/fYCFQ9C7Gi+U1T1mba38
	80rbSSKHagwuw9gcPGa2H7CJlTPf3wOAbnke5/4A=
Received: by mx.zohomail.com with SMTPS id 1728931753828957.5452468694128;
	Mon, 14 Oct 2024 11:49:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] rust: shrinker: add shrinker abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20241014-shrinker-v2-1-04719efd2342@google.com>
Date: Mon, 14 Oct 2024 15:48:56 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8826267-710B-4BC4-ADB1-BA029F6F89C5@collabora.com>
References: <20241014-shrinker-v2-1-04719efd2342@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-ZohoMailClient: External

Hi Alice,

> On 14 Oct 2024, at 13:00, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> Rust Binder holds incoming transactions in a read-only mmap'd region
> where it manually manages the pages. These pages are only in use until
> the incoming transaction is consumed by userspace, but the kernel will
> keep the pages around for future transactions. Rust Binder registers a
> shrinker with the kernel so that it can give back these pages if the
> system comes under memory pressure.
>=20
> Creating a shrinker is done via the ShrinkerBuilder type. Using a
> builder means that some options (seeks, batch) can be optional, while
> other options (name, private data) can be mandatory. Unlike =
seeks/batch,
> the private data is not set using a `set_private_data` method, as this
> makes it mandatory to provide a private data pointer.
>=20
> The user specifies the callbacks in use by implementing the Shrinker
> trait for the type used for the private data. This requires specifying
> three things: implementations for count_objects and scan_objects, and
> the pointer type that the private data will be wrapped in.
>=20
> The return values of count_objects and scan_objects are provided using
> newtypes called CountObjects and ScanObjects respectively. These types
> prevent the user from e.g. returning SHRINK_STOP from count_objects or
> returning SHRINK_EMPTY from scan_objects.
>=20
> The CountObjects newtype treats CountObjects::new(0) as "the count is
> unknown" instead of "the count is zero" for consistency with the way
> that the C code works today.
>=20
> ShrinkControl is not using Opaque because we need mutable access.
>=20
> Support for numa/memcg aware shrinkers is not included here, as they
> cannot usefully be used without having list_lru bindings. Support for
> that will happen as a follow-up.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Dave, I still had a few outstanding questions in the thread on the =
last
> version. Most prominently the question on what to do with the builder
> instead. I didn't change it in this version as I'm not sure which
> alternative you prefer.
> ---
> Changes in v2:
> - Rename to ShrinkerBuilder / ShrinkerRegistration.
> - Rename `alloc` to `new`.
> - Update CountOjects to match the way C does it.
> - Change ScanObjects::MAX to SHRINK_STOP-1.
> - Rename gfp_fs to reclaim_fs_allowed, and add reclaim_io_allowed.
> - Remove max check in set_nr_scanned.
> - Comment that numa/memcg aware shrinkers aren't supported yet.
> - Link to v1: =
https://lore.kernel.org/r/20240912-shrinker-v1-1-18b7f1253553@google.com
> ---
> rust/bindings/bindings_helper.h |   3 +
> rust/kernel/lib.rs              |   1 +
> rust/kernel/shrinker.rs         | 335 =
++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 339 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index ae82e9c941af..fd6d15f5dde1 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -18,6 +18,7 @@
> #include <linux/phy.h>
> #include <linux/refcount.h>
> #include <linux/sched.h>
> +#include <linux/shrinker.h>
> #include <linux/slab.h>
> #include <linux/wait.h>
> #include <linux/workqueue.h>
> @@ -31,4 +32,6 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT =3D =
GFP_KERNEL_ACCOUNT;
> const gfp_t RUST_CONST_HELPER_GFP_NOWAIT =3D GFP_NOWAIT;
> const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZERO;
> const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM =3D ___GFP_HIGHMEM;
> +const gfp_t RUST_CONST_HELPER___GFP_FS =3D ___GFP_FS;
> +const gfp_t RUST_CONST_HELPER___GFP_IO =3D ___GFP_IO;
> const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =3D =
BLK_FEAT_ROTATIONAL;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b5f4b3ce6b48..2e9ca7d413c4 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -45,6 +45,7 @@
> pub mod prelude;
> pub mod print;
> pub mod rbtree;
> +pub mod shrinker;
> pub mod sizes;
> mod static_assert;
> #[doc(hidden)]
> diff --git a/rust/kernel/shrinker.rs b/rust/kernel/shrinker.rs
> new file mode 100644
> index 000000000000..d87ad08e917c
> --- /dev/null
> +++ b/rust/kernel/shrinker.rs
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Shrinker for handling memory pressure.
> +//!
> +//! C header: =
[`include/linux/shrinker.h`](srctree/include/linux/shrinker.h)
> +
> +use crate::{alloc::AllocError, bindings, c_str, str::CStr, =
types::ForeignOwnable};
> +
> +use core::{
> +    ffi::{c_int, c_long, c_ulong, c_void},
> +    marker::PhantomData,
> +    ptr::NonNull,
> +};
> +
> +const SHRINK_STOP: c_ulong =3D bindings::SHRINK_STOP as c_ulong;
> +const SHRINK_EMPTY: c_ulong =3D bindings::SHRINK_EMPTY as c_ulong;
> +
> +/// The default value for the number of seeks needed to recreate an =
object.
> +pub const DEFAULT_SEEKS: u32 =3D bindings::DEFAULT_SEEKS;
> +
> +/// An unregistered shrinker.
> +///
> +/// This type can be used to modify the settings of the shrinker =
before it is registered.
> +///
> +/// # Invariants
> +///
> +/// The `shrinker` pointer references an unregistered shrinker.
> +pub struct ShrinkerBuilder {
> +    shrinker: NonNull<bindings::shrinker>,
> +}
> +
> +// SAFETY: Moving an unregistered shrinker between threads is okay.
> +unsafe impl Send for ShrinkerBuilder {}
> +// SAFETY: An unregistered shrinker is thread safe.
> +unsafe impl Sync for ShrinkerBuilder {}
> +
> +impl ShrinkerBuilder {
> +    /// Create a new shrinker.
> +    pub fn new(name: &CStr) -> Result<Self, AllocError> {
> +        // TODO: Support numa/memcg aware shrinkers once list_lru is =
available.
> +        let flags =3D 0;
> +
> +        // SAFETY: Passing `0` as flags is okay. Using `%s` as the =
format string is okay when we
> +        // pass a nul-terminated string as the string for `%s` to =
print.
> +        let ptr =3D unsafe {
> +            bindings::shrinker_alloc(flags, =
c_str!("%s").as_char_ptr(), name.as_char_ptr())
> +        };
> +
> +        let shrinker =3D NonNull::new(ptr).ok_or(AllocError)?;
> +
> +        // INVARIANT: The allocated shrinker is unregistered.
> +        Ok(Self { shrinker })
> +    }
> +
> +    /// Create a new shrinker using format arguments for the name.
> +    pub fn new_fmt(name: core::fmt::Arguments<'_>) -> Result<Self, =
AllocError> {
> +        // TODO: Support numa/memcg aware shrinkers once list_lru is =
available.
> +        let flags =3D 0;
> +
> +        // SAFETY: Passing `0` as flags is okay. Using `%pA` as the =
format string is okay when we
> +        // pass a `fmt::Arguments` as the value to print.
> +        let ptr =3D unsafe {
> +            bindings::shrinker_alloc(
> +                flags,
> +                c_str!("%pA").as_char_ptr(),
> +                &name as *const _ as *const c_void,
> +            )
> +        };
> +
> +        let shrinker =3D NonNull::new(ptr).ok_or(AllocError)?;
> +
> +        // INVARIANT: The allocated shrinker is unregistered.
> +        Ok(Self { shrinker })
> +    }
> +
> +    /// Set the number of seeks needed to recreate an object.
> +    pub fn set_seeks(&mut self, seeks: u32) {
> +        unsafe { (*self.shrinker.as_ptr()).seeks =3D seeks as c_int =
};
> +    }
> +
> +    /// Set the batch size for reclaiming on this shrinker.
> +    pub fn set_batch(&mut self, batch: usize) {
> +        unsafe { (*self.shrinker.as_ptr()).batch =3D batch as c_long =
};
> +    }
> +
> +    /// Register the shrinker.
> +    ///
> +    /// The provided pointer is used as the private data, and the =
type `T` determines the callbacks
> +    /// that the shrinker will use.
> +    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> =
ShrinkerRegistration<T> {
> +        let shrinker =3D self.shrinker;
> +        let ptr =3D shrinker.as_ptr();
> +
> +        // The destructor of `self` calls `shrinker_free`, so skip =
the destructor.
> +        core::mem::forget(self);
> +
> +        let private_data_ptr =3D <T::Ptr as =
ForeignOwnable>::into_foreign(private_data);
> +

I don=E2=80=99t usually comment on style because there's a great deal of =
personal taste involved.

OTOH, I find this a bit hard to read. Maybe I am not the only one? A =
line-break per SAFETY
would improve legibility IMHO.

> +        // SAFETY: We own the private data, so we can assign to it.
> +        unsafe { (*ptr).private_data =3D private_data_ptr.cast_mut() =
};
> +        // SAFETY: The shrinker is not yet registered, so we can =
update this field.
> +        unsafe { (*ptr).count_objects =3D =
Some(rust_count_objects::<T>) };
> +        // SAFETY: The shrinker is not yet registered, so we can =
update this field.
> +        unsafe { (*ptr).scan_objects =3D Some(rust_scan_objects::<T>) =
};
> +
> +        // SAFETY: The shrinker is unregistered, so it's safe to =
register it.
> +        unsafe { bindings::shrinker_register(ptr) };
> +
> +        ShrinkerRegistration {
> +            shrinker,
> +            _phantom: PhantomData,
> +        }
> +    }
> +}
> +
> +impl Drop for ShrinkerBuilder {
> +    fn drop(&mut self) {
> +        // SAFETY: The shrinker is a valid but unregistered shrinker, =
and we will not use it
> +        // anymore.
> +        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
> +    }
> +}
> +
> +/// A shrinker that is registered with the kernel.
> +///
> +/// # Invariants
> +///
> +/// The `shrinker` pointer refers to a registered shrinker using `T` =
as the private data.
> +pub struct ShrinkerRegistration<T: Shrinker> {
> +    shrinker: NonNull<bindings::shrinker>,
> +    _phantom: PhantomData<T::Ptr>,
> +}
> +
> +// SAFETY: This allows you to deregister the shrinker from a =
different thread, which means that
> +// private data could be dropped from any thread.
> +unsafe impl<T: Shrinker> Send for ShrinkerRegistration<T> where =
T::Ptr: Send {}
> +// SAFETY: The only thing you can do with an immutable reference is =
access the private data, which
> +// is okay to access in parallel as the `Shrinker` trait requires the =
private data to be `Sync`.
> +unsafe impl<T: Shrinker> Sync for ShrinkerRegistration<T> {}
> +
> +impl<T: Shrinker> ShrinkerRegistration<T> {
> +    /// Access the private data in this shrinker.
> +    pub fn private_data(&self) -> <T::Ptr as =
ForeignOwnable>::Borrowed<'_> {
> +        // SAFETY: We own the private data, so we can access it.
> +        let private =3D unsafe { =
(*self.shrinker.as_ptr()).private_data };
> +        // SAFETY: By the type invariants, the private data is `T`. =
This access could happen in
> +        // parallel with a shrinker callback, but that's okay as the =
`Shrinker` trait ensures that
> +        // `T::Ptr` is `Sync`.
> +        unsafe { <T::Ptr as ForeignOwnable>::borrow(private) }
> +    }
> +}
> +
> +impl<T: Shrinker> Drop for ShrinkerRegistration<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: We own the private data, so we can access it.
> +        let private =3D unsafe { =
(*self.shrinker.as_ptr()).private_data };
> +        // SAFETY: We will not access the shrinker after this call.
> +        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
> +        // SAFETY: The above call blocked until the completion of any =
shrinker callbacks, so there
> +        // are no longer any users of the private data.
> +        drop(unsafe { <T::Ptr as =
ForeignOwnable>::from_foreign(private) });
> +    }
> +}
> +
> +/// Callbacks for a shrinker.
> +pub trait Shrinker {
> +    /// The pointer type used to store the private data of the =
shrinker.
> +    ///
> +    /// Needs to be `Sync` because the shrinker callback could access =
this value immutably from
> +    /// several thread in parallel.
> +    type Ptr: ForeignOwnable + Sync;
> +
> +    /// Count the number of freeable items in the cache.
> +    fn count_objects(
> +        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        sc: ShrinkControl<'_>,
> +    ) -> CountObjects;
> +
> +    /// Free some objects in this cache.
> +    fn scan_objects(
> +        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        sc: ShrinkControl<'_>,
> +    ) -> ScanObjects;
> +}
> +
> +/// How many objects are there in the cache?
> +///
> +/// This is used as the return value of [`Shrinker::count_objects`].
> +pub struct CountObjects {
> +    inner: c_ulong,
> +}
> +
> +impl CountObjects {
> +    /// Indicates that the number of objects is zero.
> +    pub const EMPTY: Self =3D Self {
> +        inner: SHRINK_EMPTY,
> +    };
> +
> +    /// The maximum possible number of freeable objects.
> +    pub const MAX: Self =3D Self {
> +        // The shrinker code assumes that it can multiply this value =
by two without overflow.
> +        inner: c_ulong::MAX / 2,
> +    };
> +
> +    /// Creates a new `CountObjects` with the given value.
> +    ///
> +    /// This should be the number of objects that were actually =
freed. Objects that were scanned
> +    /// but not freed should be counted in `nr_scanned` but not here.

This is apparently wrong? The count_objects callback computes how many =
objects *can* be freed.

> +    ///
> +    /// If `count` is zero, then this indicates that the real count =
is unknown. Use
> +    /// `CountObjects::EMPTY` to indicate that the shrinker is empty.
> +    pub fn new(count: usize) -> Self {
> +        if count > Self::MAX.inner as usize {
> +            return Self::MAX;
> +        }

nit: maybe a comment explaining why silently truncating is preferable?
 =20
> +
> +        Self {
> +            inner: count as c_ulong,
> +        }
> +    }
> +}
> +
> +/// How many objects were freed?
> +///
> +/// This is used as the return value of [`Shrinker::scan_objects`].
> +pub struct ScanObjects {
> +    inner: c_ulong,
> +}
> +
> +impl ScanObjects {
> +    /// Indicates that the shrinker should stop trying to free =
objects from this cache due to
> +    /// potential deadlocks.
> +    pub const STOP: Self =3D Self { inner: SHRINK_STOP };
> +
> +    /// The maximum possible number of freeable objects.
> +    pub const MAX: Self =3D Self {
> +        inner: SHRINK_STOP - 1,
> +    };
> +
> +    /// Creates a new `CountObjects` with the given value.
> +    pub fn from_count(count: usize) -> Self {
> +        if count > Self::MAX.inner as usize {
> +            return Self::MAX;
> +        }
> +
> +        Self {
> +            inner: count as c_ulong,
> +        }
> +    }
> +}
> +
> +/// This struct is used to pass information from page reclaim to the =
shrinkers.
> +///
> +/// # Invariants
> +///
> +/// `ptr` has exclusive access to a valid `struct shrink_control`.
> +pub struct ShrinkControl<'a> {
> +    ptr: NonNull<bindings::shrink_control>,
> +    _phantom: PhantomData<&'a bindings::shrink_control>,
> +}
> +
> +impl<'a> ShrinkControl<'a> {
> +    /// Create a `ShrinkControl` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer should point at a valid `shrink_control` for the =
duration of 'a.
> +    pub unsafe fn from_raw(ptr: *mut bindings::shrink_control) -> =
Self {
> +        Self {
> +            // SAFETY: Caller promises that this pointer is valid.
> +            ptr: unsafe { NonNull::new_unchecked(ptr) },
> +            _phantom: PhantomData,
> +        }
> +    }
> +
> +    /// Determines whether it is safe to call into filesystem code.
> +    pub fn reclaim_fs_allowed(&self) -> bool {
> +        // SAFETY: Okay by type invariants.
> +        let mask =3D unsafe { (*self.ptr.as_ptr()).gfp_mask };
> +
> +        (mask & bindings::__GFP_FS) !=3D 0
> +    }
> +
> +    /// Determines whether it is safe to call into IO code.
> +    pub fn reclaim_io_allowed(&self) -> bool {
> +        // SAFETY: Okay by type invariants.
> +        let mask =3D unsafe { (*self.ptr.as_ptr()).gfp_mask };
> +
> +        (mask & bindings::__GFP_IO) !=3D 0
> +    }
> +
> +    /// Returns the number of objects that `scan_objects` should try =
to reclaim.
> +    pub fn nr_to_scan(&self) -> usize {
> +        // SAFETY: Okay by type invariants.
> +        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
> +    }
> +
> +    /// The callback should set this value to the number of objects =
inspected by the shrinker.
> +    pub fn set_nr_scanned(&mut self, val: usize) {
> +        // SAFETY: Okay by type invariants.
> +        unsafe { (*self.ptr.as_ptr()).nr_scanned =3D val as c_ulong =
};
> +    }
> +}
> +
> +unsafe extern "C" fn rust_count_objects<T: Shrinker>(
> +    shrink: *mut bindings::shrinker,
> +    sc: *mut bindings::shrink_control,
> +) -> c_ulong {
> +    // SAFETY: We own the private data, so we can access it.
> +    let private =3D unsafe { (*shrink).private_data };
> +    // SAFETY: This function is only used with shrinkers where `T` is =
the type of the private data.
> +    let private =3D unsafe { <T::Ptr as =
ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller passes a valid `sc` pointer.
> +    let sc =3D unsafe { ShrinkControl::from_raw(sc) };
> +
> +    let ret =3D T::count_objects(private, sc);
> +    ret.inner
> +}
> +
> +unsafe extern "C" fn rust_scan_objects<T: Shrinker>(
> +    shrink: *mut bindings::shrinker,
> +    sc: *mut bindings::shrink_control,
> +) -> c_ulong {
> +    // SAFETY: We own the private data, so we can access it.
> +    let private =3D unsafe { (*shrink).private_data };
> +    // SAFETY: This function is only used with shrinkers where `T` is =
the type of the private data.
> +    let private =3D unsafe { <T::Ptr as =
ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller passes a valid `sc` pointer.
> +    let sc =3D unsafe { ShrinkControl::from_raw(sc) };
> +
> +    let ret =3D T::scan_objects(private, sc);
> +    ret.inner
> +}
>=20
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20240911-shrinker-f8371af00b68
>=20
> Best regards,
> --=20
> Alice Ryhl <aliceryhl@google.com>
>=20
>=20

=E2=80=94 Daniel


