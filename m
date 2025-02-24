Return-Path: <linux-kernel+bounces-530176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA19A43026
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207903B4570
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB61CD1E4;
	Mon, 24 Feb 2025 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CrhO+RYC"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D32571B2;
	Mon, 24 Feb 2025 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436284; cv=pass; b=Gv8LquopM1efoY8d6t3foqC6PUznEDCMvb+48rIy4P6iwFKp99GytOgPcWVhrxwVZJJigvXowrSKr+sgy/8VPoPj6qWPq+eYLtEr3/tQcPuCLNXSvgkNP9QNqPDP8hxTqUvlkJISE0nbb2A0W1KIMwTSEcjJ/R5WBTXRc18qeFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436284; c=relaxed/simple;
	bh=a5fAI420GJN1Xjuo9ITjBTRKbTIK4KRC/0BBHGo9HpU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ggl+5GXGuXRPRWB5uQ6oci9pYw9nIMp3jfkQ10Yv4WSjcR+HSRRY2oe7A+w2pqA4atsUoyZ9/EUr0H80axEk3MD84ncg0jzEgytzZLWxg9YkhrElIGy5Lf9huU1KEFR1jLybNlB09EBVzlrCCV55Gij3L6NCHCiHhDC1fx1WkKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=CrhO+RYC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740436235; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CXDyY3BNi/PQA0uAaeQBFNC0cAydUzlQxkqL71fmvxdwT9/LMwSezl8yYyR4x4qYhvfQ8labtu4fX2jfn1vMsyIGgmj88aIoT11tqJxmagvJ95IkiddL8ybHEzhXPOGto6R/KVSh2U1AiiwANJ4yQC40leb2Vb+Q/CljcivCRS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740436235; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x4FInNMF1/LmuymqlApBd9P/MxeGBIXcY3I/8dcsndM=; 
	b=ScSOSAt1QbJu67tj/Gc0gxUoidG52QgFpmT7cbg1USj+s//ahIeIAXL82sooMYvjAWFq+8hK4sxjTefMN5+pErIyQQfLtBC6gyYA8chzq8VyGuygoQ5vfkTNB+9ChEgyDfpo3X5ix5gUPvbZ/FQr2U0zOS+LQv8B3Nt0a4ZjQkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740436235;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=x4FInNMF1/LmuymqlApBd9P/MxeGBIXcY3I/8dcsndM=;
	b=CrhO+RYC1/1zedaaM21tLwHYS3C5j4nEPw5A1RlPcC3h5Fb9Nyk/AHuST6SxyMwO
	CWO8Wyfz0bhMcQ42e9SjojbnpVEkHTSiCsyJpKkjaDtiT43qIRrWrIrZANTzfxpXopG
	9TeSX6AMjy4EdHX1qJQkfxhj92k06HhqMf/gC5Yo=
Received: by mx.zohomail.com with SMTPS id 1740436233414227.9037313389059;
	Mon, 24 Feb 2025 14:30:33 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v4 2/4] rust: configfs: introduce rust support for
 configfs
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250224-configfs-v4-2-9af9b5e611f6@kernel.org>
Date: Mon, 24 Feb 2025 19:30:13 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Fiona Behrens <me@kloenk.dev>,
 Charalampos Mitrodimas <charmitro@posteo.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1FA8DA8-A54D-49B1-BE8F-2B0DE14F4899@collabora.com>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
 <20250224-configfs-v4-2-9af9b5e611f6@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Andreas,

> On 24 Feb 2025, at 10:21, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> This patch adds a rust API for configfs, thus allowing rust modules to =
use
> configfs for configuration. The implementation is a shim on top of the =
C
> configfs implementation allowing safe use of the C infrastructure from
> rust.
>=20
> The patch enables the `const_mut_refs` feature on compilers before =
rustc

Where?

> 1.83. The feature was stabilized in rustc 1.83 and is not required to =
be
> explicitly enabled on later versions.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>=20
> ---
>=20
> This patch is a direct dependency for `rnull`, the rust null block =
driver.
> ---
> rust/bindings/bindings_helper.h |   1 +
> rust/helpers/mutex.c            |   5 +
> rust/kernel/configfs.rs         | 938 =
++++++++++++++++++++++++++++++++++++++++
> rust/kernel/lib.rs              |   2 +
> 4 files changed, 946 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 55354e4dec14..d115a770306f 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
> #include <linux/blk-mq.h>
> #include <linux/blk_types.h>
> #include <linux/blkdev.h>
> +#include <linux/configfs.h>
> #include <linux/cred.h>
> #include <linux/errname.h>
> #include <linux/ethtool.h>
> diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
> index 06575553eda5..3e9b910a88e9 100644
> --- a/rust/helpers/mutex.c
> +++ b/rust/helpers/mutex.c
> @@ -17,3 +17,8 @@ void rust_helper_mutex_assert_is_held(struct mutex =
*mutex)
> {
> lockdep_assert_held(mutex);
> }
> +
> +void rust_helper_mutex_destroy(struct mutex *lock)
> +{
> + mutex_destroy(lock);
> +}
> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
> new file mode 100644
> index 000000000000..fd19ddd209b1
> --- /dev/null
> +++ b/rust/kernel/configfs.rs
> @@ -0,0 +1,938 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! `configfs` interface.
> +//!
> +//! `configfs` is an in-memory pseudo file system for configuration =
of kernel
> +//! modules. Please see the [C documentation] for details and =
intended use of
> +//! `configfs`.
> +//!
> +//! This module does not support the following `configfs` features:
> +//!
> +//! - Items. All group children are groups.
> +//! - Symlink support.
> +//! - `disconnect_notify` hook.
> +//! - Default groups.
> +//!
> +//! See the [rust_configfs.rs] sample for a full example use of this =
module.
> +//!
> +//! C header: =
[`include/linux/configfs.h`](srctree/include/linux/configfs.h)
> +//!
> +//! # Example
> +//!
> +//! ```ignore
> +//! use kernel::alloc::flags;
> +//! use kernel::c_str;
> +//! use kernel::configfs_attrs;
> +//! use kernel::configfs;
> +//! use kernel::new_mutex;
> +//! use kernel::page::PAGE_SIZE;
> +//! use kernel::sync::Mutex;
> +//! use kernel::ThisModule;
> +//!
> +//! #[pin_data]
> +//! struct RustConfigfs {
> +//!     #[pin]
> +//!     config: configfs::Subsystem<Configuration>,
> +//! }
> +//!
> +//! impl kernel::InPlaceModule for RustConfigfs {
> +//!     fn init(_module: &'static ThisModule) -> impl PinInit<Self, =
Error> {
> +//!         pr_info!("Rust configfs sample (init)\n");
> +//!
> +//!         let item_type =3D configfs_attrs! {
> +//!             container: configfs::Subsystem<Configuration>,
> +//!             data: Configuration,
> +//!             attributes: [
> +//!                 message: 0,
> +//!                 bar: 1,
> +//!             ],
> +//!         };
> +//!
> +//!         try_pin_init!(Self {
> +//!             config <- configfs::Subsystem::new(
> +//!                 c_str!("rust_configfs"), item_type, =
Configuration::new()
> +//!             ),
> +//!         })
> +//!     }
> +//! }
> +//!
> +//! #[pin_data]
> +//! struct Configuration {
> +//!     message: &'static CStr,
> +//!     #[pin]
> +//!     bar: Mutex<(KBox<[u8; PAGE_SIZE]>, usize)>,
> +//! }
> +//!
> +//! impl Configuration {
> +//!     fn new() -> impl PinInit<Self, Error> {
> +//!         try_pin_init!(Self {
> +//!             message: c_str!("Hello World\n"),
> +//!             bar <- new_mutex!((KBox::new([0; PAGE_SIZE], =
flags::GFP_KERNEL)?, 0)),
> +//!         })
> +//!     }
> +//! }
> +//!
> +//! #[vtable]
> +//! impl configfs::AttributeOperations<0> for Configuration {
> +//!     type Data =3D Configuration;
> +//!
> +//!     fn show(container: &Configuration, page: &mut [u8; =
PAGE_SIZE]) -> Result<usize> {
> +//!         pr_info!("Show message\n");
> +//!         let data =3D container.message;
> +//!         page[0..data.len()].copy_from_slice(data);
> +//!         Ok(data.len())
> +//!     }
> +//! }
> +//!
> +//! #[vtable]
> +//! impl configfs::AttributeOperations<1> for Configuration {
> +//!     type Data =3D Configuration;
> +//!
> +//!     fn show(container: &Configuration, page: &mut [u8; =
PAGE_SIZE]) -> Result<usize> {
> +//!         pr_info!("Show bar\n");
> +//!         let guard =3D container.bar.lock();
> +//!         let data =3D guard.0.as_slice();
> +//!         let len =3D guard.1;
> +//!         page[0..len].copy_from_slice(&data[0..len]);
> +//!         Ok(len)
> +//!     }
> +//!
> +//!     fn store(container: &Configuration, page: &[u8]) -> Result {
> +//!         pr_info!("Store bar\n");
> +//!         let mut guard =3D container.bar.lock();
> +//!         guard.0[0..page.len()].copy_from_slice(page);
> +//!         guard.1 =3D page.len();
> +//!         Ok(())
> +//!     }
> +//! }
> +//! ```
> +//!
> +//! [C documentation]: srctree/Documentation/filesystems/configfs.rst
> +//! [rust_configfs.rs]: srctree/samples/rust/rust_configfs.rs
> +
> +use crate::alloc::flags;
> +use crate::container_of;
> +use crate::page::PAGE_SIZE;
> +use crate::prelude::*;
> +use crate::str::CString;
> +use crate::sync::Arc;
> +use crate::sync::ArcBorrow;
> +use crate::types::ForeignOwnable;
> +use crate::types::Opaque;
> +use core::cell::UnsafeCell;
> +use core::marker::PhantomData;
> +use core::ptr::addr_of;
> +use core::ptr::addr_of_mut;
> +
> +/// A `configfs` subsystem.
> +///
> +/// This is the top level entrypoint for a `configfs` hierarchy. To =
register
> +/// with configfs, embed a field of this type into your kernel module =
struct.
> +#[pin_data(PinnedDrop)]
> +pub struct Subsystem<Data> {
> +    #[pin]
> +    subsystem: Opaque<bindings::configfs_subsystem>,
> +    #[pin]
> +    data: Data,
> +}
> +
> +// SAFETY: We do not provide any operations on `Subsystem`.
> +unsafe impl<Data> Sync for Subsystem<Data> {}
> +
> +// SAFETY: Ownership of `Subsystem` can safely be transferred to =
other threads.
> +unsafe impl<Data> Send for Subsystem<Data> {}
> +
> +impl<Data> Subsystem<Data> {
> +    /// Create an initializer for a [`Subsystem`].
> +    ///
> +    /// The subsystem will appear in configfs as a directory name =
given by
> +    /// `name`. The attributes available in directory are specified =
by
> +    /// `item_type`.
> +    pub fn new(
> +        name: &'static CStr,
> +        item_type: &'static ItemType<Subsystem<Data>, Data>,
> +        data: impl PinInit<Data, Error>,
> +    ) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            subsystem <- kernel::init::zeroed().chain(
> +                |place: &mut Opaque<bindings::configfs_subsystem>| {
> +                    // SAFETY: We initialized the required fields of =
`place.group` above.
> +                    unsafe {
> +                        bindings::config_group_init_type_name(
> +                            &mut (*place.get()).su_group,
> +                            name.as_ptr(),
> +                            item_type.as_ptr(),
> +                        )
> +                    };
> +
> +                    // SAFETY: `place.su_mutex` is valid for use as a =
mutex.
> +                    unsafe {
> +                        bindings::__mutex_init(
> +                            &mut (*place.get()).su_mutex,
> +                            kernel::optional_name!().as_char_ptr(),
> +                            kernel::static_lock_class!().as_ptr(),
> +                        )
> +                    }
> +                    Ok(())
> +                }
> +            ),
> +            data <- data,
> +        })
> +        .pin_chain(|this| {
> +            crate::error::to_result(
> +                // SAFETY: We initialized `this.subsystem` according =
to C API contract above.
> +                unsafe { =
bindings::configfs_register_subsystem(this.subsystem.get()) },
> +            )
> +        })
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<Data> PinnedDrop for Subsystem<Data> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: We registered `self.subsystem` in the initializer =
returned by `Self::new`.
> +        unsafe { =
bindings::configfs_unregister_subsystem(self.subsystem.get()) };
> +        // SAFETY: We initialized the mutex in `Subsystem::new`.
> +        unsafe { =
bindings::mutex_destroy(addr_of_mut!((*self.subsystem.get()).su_mutex)) =
};
> +    }
> +}
> +
> +/// Trait that allows offset calculations for structs that embed a
> +/// `bindings::config_group`.
> +///
> +/// Users of the `configfs` API should not need to implement this =
trait.
> +///
> +/// # Safety
> +///
> +/// - Implementers of this trait must embed a =
`bindings::config_group`.
> +/// - Methods must be implemented according to method documentation.
> +pub unsafe trait HasGroup<Data> {
> +    /// Return the address of the `bindings::config_group` embedded =
in `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `this` must be a valid allocation of at least the size of =
`Self`.
> +    unsafe fn group(this: *const Self) -> *const =
bindings::config_group;
> +
> +    /// Return the address of the `Self` that `group` is embedded in.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `group` must point to the `bindings::config_group` that is =
embedded in
> +    ///   `Self`.
> +    unsafe fn container_of(group: *const bindings::config_group) -> =
*const Self;
> +}
> +
> +// SAFETY: `Subsystem<Data>` embeds a field of type =
`bindings::config_group`
> +// within the `subsystem` field.
> +unsafe impl<Data> HasGroup<Data> for Subsystem<Data> {
> +    unsafe fn group(this: *const Self) -> *const =
bindings::config_group {
> +        // SAFETY: By impl and function safety requirement this =
projection is in bounds.
> +        unsafe { addr_of!((*(*this).subsystem.get()).su_group) }
> +    }
> +
> +    unsafe fn container_of(group: *const bindings::config_group) -> =
*const Self {
> +        // SAFETY: By impl and function safety requirement this =
projection is in bounds.
> +        let c_subsys_ptr =3D unsafe { container_of!(group, =
bindings::configfs_subsystem, su_group) };
> +        let opaque_ptr =3D =
c_subsys_ptr.cast::<Opaque<bindings::configfs_subsystem>>();
> +        // SAFETY: By impl and function safety requirement, =
`opaque_ptr` and the
> +        // pointer it returns, are within the same allocation.
> +        unsafe { container_of!(opaque_ptr, Subsystem<Data>, =
subsystem) }
> +    }
> +}
> +
> +/// A `configfs` group.
> +///
> +/// To add a subgroup to `configfs`, pass this type as `ctype` to
> +/// [`crate::configfs_attrs`] when creating a group in =
[`GroupOperations::make_group`].
> +#[pin_data]
> +pub struct Group<Data> {
> +    #[pin]
> +    group: Opaque<bindings::config_group>,
> +    #[pin]
> +    data: Data,
> +}
> +
> +impl<Data> Group<Data> {
> +    /// Create an initializer for a new group.
> +    ///
> +    /// When instantiated, the group will appear as a directory with =
the name
> +    /// given by `name` and it will contain attributes specified by =
`item_type`.
> +    pub fn new(
> +        name: CString,

Is it me or this can be simply &CStr? `config_item_set_name` either =
copies into an internal
buffer or allocates, so I see no reason to pass an owned type here.

> +        item_type: &'static ItemType<Group<Data>, Data>,
> +        data: impl PinInit<Data, Error>,
> +    ) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            group <- kernel::init::zeroed().chain(|v: &mut =
Opaque<bindings::config_group>| {
> +                let place =3D v.get();
> +                let name =3D name.as_bytes_with_nul().as_ptr();
> +                // SAFETY: It is safe to initialize a group once it =
has been zeroed.
> +                unsafe {
> +                    bindings::config_group_init_type_name(place, =
name.cast(), item_type.as_ptr())
> +                };
> +                Ok(())
> +            }),
> +            data <- data,
> +        })
> +    }
> +}
> +
> +// SAFETY: `Group<Data>` embeds a field of type =
`bindings::config_group`
> +// within the `group` field.
> +unsafe impl<Data> HasGroup<Data> for Group<Data> {
> +    unsafe fn group(this: *const Self) -> *const =
bindings::config_group {
> +        Opaque::raw_get(
> +            // SAFETY: By impl and function safety requirements this =
field
> +            // projection is within bounds of the allocation.
> +            unsafe { addr_of!((*this).group) },
> +        )
> +    }
> +
> +    unsafe fn container_of(group: *const bindings::config_group) -> =
*const Self {
> +        let opaque_ptr =3D =
group.cast::<Opaque<bindings::config_group>>();
> +        // SAFETY: By impl and function safety requirement, =
`opaque_ptr` and
> +        // pointer it returns will be in the same allocation.
> +        unsafe { container_of!(opaque_ptr, Self, group) }
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// `this` must be a valid pointer.
> +///
> +/// If `this` does not represent the root group of a `configfs` =
subsystem,
> +/// `this` must be a pointer to a `bindings::config_group` embedded =
in a
> +/// `Group<Parent>`.
> +///
> +/// Otherwise, `this` must be a pointer to a `bindings::config_group` =
that
> +/// is embedded in a `bindings::configfs_subsystem` that is embedded =
in a
> +/// `Subsystem<Parent>`.
> +unsafe fn get_group_data<'a, Parent>(this: *mut =
bindings::config_group) -> &'a Parent {
> +    // SAFETY: `this` is a valid pointer.
> +    let is_root =3D unsafe { (*this).cg_subsys.is_null() };
> +
> +    if !is_root {
> +        // SAFETY: By C API contact, `this` is a pointer to a
> +        // `bindings::config_group` that we passed as a return value =
in from
> +        // `make_group`. Such a pointer is embedded within a =
`Group<Parent>`.

This phrase is confusing.

> +        unsafe { &(*Group::<Parent>::container_of(this)).data }
> +    } else {
> +        // SAFETY: By C API contract, `this` is a pointer to the
> +        // `bindings::config_group` field within a =
`Subsystem<Parent>`.
> +        unsafe { &(*Subsystem::container_of(this)).data }
> +    }
> +}
> +
> +struct GroupOperationsVTable<Parent, Child>(PhantomData<(Parent, =
Child)>);
> +
> +impl<Parent, Child> GroupOperationsVTable<Parent, Child>
> +where
> +    Parent: GroupOperations<Child =3D Child>,
> +    Child: 'static,
> +{
> +    /// # Safety
> +    ///
> +    /// `this` must be a valid pointer.
> +    ///
> +    /// If `this` does not represent the root group of a `configfs` =
subsystem,
> +    /// `this` must be a pointer to a `bindings::config_group` =
embedded in a
> +    /// `Group<Parent>`.
> +    ///
> +    /// Otherwise, `this` must be a pointer to a =
`bindings::config_group` that
> +    /// is embedded in a `bindings::configfs_subsystem` that is =
embedded in a
> +    /// `Subsystem<Parent>`.
> +    ///
> +    /// `name` must point to a null terminated string.
> +    unsafe extern "C" fn make_group(
> +        this: *mut bindings::config_group,
> +        name: *const kernel::ffi::c_char,
> +    ) -> *mut bindings::config_group {
> +        // SAFETY: By function safety requirements of this function, =
this call
> +        // is safe.
> +        let parent_data =3D unsafe { get_group_data(this) };
> +
> +        let group_init =3D match Parent::make_group(
> +            parent_data,
> +            // SAFETY: By function safety requirements, name points =
to a null
> +            // terminated string.
> +            unsafe { CStr::from_char_ptr(name) },
> +        ) {
> +            Ok(init) =3D> init,
> +            Err(e) =3D> return e.to_ptr(),
> +        };
> +
> +        let child_group =3D <Arc<Group<Child>> as =
InPlaceInit<Group<Child>>>::try_pin_init(
> +            group_init,
> +            flags::GFP_KERNEL,
> +        );
> +
> +        match child_group {
> +            Ok(child_group) =3D> {
> +                let child_group_ptr =3D child_group.into_foreign();
> +                // SAFETY: We allocated the pointee of `child_ptr` =
above as a
> +                // `Group<Child>`.
> +                unsafe { Group::<Child>::group(child_group_ptr) =
}.cast_mut()
> +            }
> +            Err(e) =3D> e.to_ptr(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// If `this` does not represent the root group of a `configfs` =
subsystem,
> +    /// `this` must be a pointer to a `bindings::config_group` =
embedded in a
> +    /// `Group<Parent>`.
> +    ///
> +    /// Otherwise, `this` must be a pointer to a =
`bindings::config_group` that
> +    /// is embedded in a `bindings::configfs_subsystem` that is =
embedded in a
> +    /// `Subsystem<Parent>`.
> +    ///
> +    /// `item` must point to a `bindings::config_item` within a
> +    /// `bindings::config_group` within a `Group<Child>`.
> +    unsafe extern "C" fn drop_item(
> +        this: *mut bindings::config_group,
> +        item: *mut bindings::config_item,
> +    ) {
> +        // SAFETY: By function safety requirements of this function, =
this call
> +        // is safe.
> +        let parent_data =3D unsafe { get_group_data(this) };
> +
> +        // SAFETY: By function safety requirements, `item` is =
embedded in a
> +        // `config_group`.
> +        let c_child_group_ptr =3D
> +            unsafe { kernel::container_of!(item, =
bindings::config_group, cg_item) };

nit: container_of is already in scope

> +        // SAFETY: By function safety requirements, =
`c_child_group_ptr` is
> +        // embedded within a `Group<Child>`.
> +        let r_child_group_ptr =3D unsafe { =
Group::<Child>::container_of(c_child_group_ptr) };
> +
> +        if Parent::HAS_DROP_ITEM {
> +            Parent::drop_item(
> +                parent_data,
> +                // SAFETY: We called `into_foreign` to produce =
`r_child_group_ptr` in
> +                // `make_group`. There are not other borrows of this =
pointer in existence.
> +                unsafe {
> +                    <Arc<Group<Child>> as =
ForeignOwnable>::borrow(r_child_group_ptr.cast_mut())
> +                },
> +            );
> +        }
> +
> +        // SAFETY: By C API contract, we are required to drop a =
refcount on
> +        // `item`.
> +        unsafe { bindings::config_item_put(item) };
> +    }
> +
> +    const VTABLE: bindings::configfs_group_operations =3D =
bindings::configfs_group_operations {
> +        make_item: None,
> +        make_group: Some(Self::make_group),
> +        disconnect_notify: None,
> +        drop_item: Some(Self::drop_item),
> +        is_visible: None,
> +        is_bin_visible: None,
> +    };
> +}
> +
> +struct ItemOperationsVTable<Container, Data>(PhantomData<(Container, =
Data)>);
> +
> +impl<Data> ItemOperationsVTable<Group<Data>, Data>
> +where
> +    Data: 'static,
> +{
> +    /// # Safety
> +    ///
> +    /// `this` must be a pointer to a `bindings::config_group` =
embedded in a
> +    /// `Group<Parent>`.
> +    ///
> +    /// This function will destroy the pointee of `this`. The pointee =
of `this`
> +    /// must not be accessed after the function returns.
> +    unsafe extern "C" fn release(this: *mut bindings::config_item) {
> +        // SAFETY: By function safety requirements, `this` is =
embedded in a
> +        // `config_group`.
> +        let c_group_ptr =3D unsafe { kernel::container_of!(this, =
bindings::config_group, cg_item) };
> +        // SAFETY: By function safety requirements, `c_group_ptr` is
> +        // embedded within a `Group<Data>`.
> +        let r_group_ptr =3D unsafe { =
Group::<Data>::container_of(c_group_ptr) };
> +
> +        // SAFETY: We called `into_foreign` on `r_group_ptr` in
> +        // `make_group`.
> +        let pin_self =3D
> +            unsafe { <Arc<Group<Data>> as =
ForeignOwnable>::from_foreign(r_group_ptr.cast_mut()) };
> +        drop(pin_self);
> +    }
> +
> +    const VTABLE: bindings::configfs_item_operations =3D =
bindings::configfs_item_operations {
> +        release: Some(Self::release),
> +        allow_link: None,
> +        drop_link: None,
> +    };
> +}
> +
> +impl<Data> ItemOperationsVTable<Subsystem<Data>, Data> {
> +    const VTABLE: bindings::configfs_item_operations =3D =
bindings::configfs_item_operations {
> +        release: None,
> +        allow_link: None,
> +        drop_link: None,
> +    };
> +}
> +
> +/// Operations implemented by `configfs` groups that can create =
subgroups.
> +///
> +/// Implement this trait on structs that embed a [`Subsystem`] or a =
[`Group`].
> +#[vtable]
> +pub trait GroupOperations {
> +    /// The child data object type.
> +    ///
> +    /// This group will create subgroups (subdirectories) backed by =
this kind of
> +    /// object.
> +    type Child: 'static;
> +
> +    /// Creates a new subgroup.
> +    ///
> +    /// The kernel will call this method in response to `mkdir(2)` in =
the
> +    /// directory representing `this`.
> +    ///
> +    /// To accept the request to create a group, implementations =
should
> +    /// return an initializer of a `Group<Self::Child>`. To prevent =
creation,
> +    /// return a suitable error.
> +    fn make_group(&self, name: &CStr) -> Result<impl =
PinInit<Group<Self::Child>, Error>>;
> +
> +    /// Prepares the group for removal from configfs.
> +    ///
> +    /// The kernel will call this method before the directory =
representing
> +    /// `_child` is removed from `configfs`.
> +    ///
> +    /// Implementations can use this method to do house keeping =
before
> +    /// `configfs` drops its reference to `Child`.
> +    fn drop_item(&self, _child: ArcBorrow<'_, Group<Self::Child>>) {
> +        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// A `configfs` attribute.
> +///
> +/// An attribute appears as a file in configfs, inside a folder that =
represent
> +/// the group that the attribute belongs to.
> +#[repr(transparent)]
> +pub struct Attribute<const ID: u64, O, Data> {

The first thing I thought here is =E2=80=9Cwhat is O?!"

> +    attribute: Opaque<bindings::configfs_attribute>,
> +    _p: PhantomData<(O, Data)>,
> +}
> +
> +// SAFETY: We do not provide any operations on `Attribute`.
> +unsafe impl<const ID: u64, O, Data> Sync for Attribute<ID, O, Data> =
{}
> +
> +// SAFETY: Ownership of `Attribute` can safely be transferred to =
other threads.
> +unsafe impl<const ID: u64, O, Data> Send for Attribute<ID, O, Data> =
{}
> +
> +impl<const ID: u64, O, Data> Attribute<ID, O, Data>
> +where
> +    O: AttributeOperations<ID, Data =3D Data>,

I recommend renaming =E2=80=9CO" into something that denotes this bound =
better.

It can be terse as appropriate, but simply =E2=80=9CO=E2=80=9D is a bit =
*too terse* .

> +{
> +    /// # Safety
> +    ///
> +    /// `item` must be embedded in a `bindings::config_group`.
> +    ///
> +    /// If `item` does not represent the root group of a `configfs` =
subsystem,
> +    /// the group must be embedded in a `Group<Data>`.
> +    ///
> +    /// Otherwise, the group must be a embedded in a
> +    /// `bindings::configfs_subsystem` that is embedded in a =
`Subsystem<Data>`.
> +    ///
> +    /// `page` must point to a writable buffer of size at least =
[`PAGE_SIZE`].
> +    unsafe extern "C" fn show(
> +        item: *mut bindings::config_item,
> +        page: *mut kernel::ffi::c_char,
> +    ) -> isize {
> +        let c_group: *mut bindings::config_group =3D
> +        // SAFETY: By function safety requirements, `item` is =
embedded in a
> +        // `config_group`.
> +            unsafe { container_of!(item, bindings::config_group, =
cg_item) }.cast_mut();
> +
> +        // SAFETY: The function safety requirements for this function =
satisfy
> +        // the conditions for this call.
> +        let data: &Data =3D unsafe { get_group_data(c_group) };
> +
> +        // SAFETY: By function safety requirements, `page` is =
writable for `PAGE_SIZE`.
> +        let ret =3D O::show(data, unsafe { &mut *(page as *mut [u8; =
PAGE_SIZE]) });
> +
> +        match ret {
> +            Ok(size) =3D> size as isize,
> +            Err(err) =3D> err.to_errno() as isize,
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `item` must be embedded in a `bindings::config_group`.
> +    ///
> +    /// If `item` does not represent the root group of a `configfs` =
subsystem,
> +    /// the group must be embedded in a `Group<Data>`.
> +    ///
> +    /// Otherwise, the group must be a embedded in a
> +    /// `bindings::configfs_subsystem` that is embedded in a =
`Subsystem<Data>`.
> +    ///
> +    /// `page` must point to a readable buffer of size at least =
`size`.
> +    unsafe extern "C" fn store(
> +        item: *mut bindings::config_item,
> +        page: *const kernel::ffi::c_char,
> +        size: usize,
> +    ) -> isize {
> +        let c_group: *mut bindings::config_group =3D
> +        // SAFETY: By function safety requirements, `item` is =
embedded in a
> +        // `config_group`.
> +            unsafe { container_of!(item, bindings::config_group, =
cg_item) }.cast_mut();
> +
> +        // SAFETY: The function safety requirements for this function =
satisfy
> +        // the conditions for this call.
> +        let data: &Data =3D unsafe { get_group_data(c_group) };
> +
> +        let ret =3D O::store(
> +            data,
> +            // SAFETY: By function safety requirements, `page` is =
readable
> +            // for at least `size`.
> +            unsafe { core::slice::from_raw_parts(page.cast(), size) =
},
> +        );
> +
> +        match ret {
> +            Ok(()) =3D> size as isize,
> +            Err(err) =3D> err.to_errno() as isize,
> +        }
> +    }
> +
> +    /// Create a new attribute.
> +    ///
> +    /// The attribute will appear as a file with name given by =
`name`.
> +    pub const fn new(name: &'static CStr) -> Self {
> +        Self {
> +            attribute: Opaque::new(bindings::configfs_attribute {
> +                ca_name: name as *const _ as _,
> +                ca_owner: core::ptr::null_mut(),
> +                ca_mode: 0o660,

Shouldn=E2=80=99t `ca_mode` be somehow taken as an input? Also, can we =
get rid of the literal here?

> +                show: Some(Self::show),
> +                store: if O::HAS_STORE {
> +                    Some(Self::store)
> +                } else {
> +                    None
> +                },
> +            }),
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +/// Operations supported by an attribute.
> +///
> +/// Implement this trait on type and pass that type as generic =
parameter when
> +/// creating an [`Attribute`]. The type carrying the implementation =
serve no
> +/// purpose other than specifying the attribute operations.
> +#[vtable]
> +pub trait AttributeOperations<const ID: u64 =3D 0> {

I assume that this ID parameter is to allow for multiple =
implementations, like we currently do
for the Workqueue? If so, can you mention this in the docs?

> +    /// The type of the object that contains the field that is =
backing the
> +    /// attribute for this operation.
> +    type Data;
> +
> +    /// Renders the value of an attribute.
> +    ///
> +    /// This function is called by the kernel to read the value of an =
attribute.
> +    ///
> +    /// Implementations should write the rendering of the attribute =
to `page`
> +    /// and return the number of bytes written.
> +    fn show(data: &Self::Data, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize>;
> +
> +    /// Stores the value of an attribute.
> +    ///
> +    /// This function is called by the kernel to update the value of =
an attribute.
> +    ///
> +    /// Implementations should parse the value from `page` and update =
internal
> +    /// state to reflect the parsed value.
> +    fn store(_data: &Self::Data, _page: &[u8]) -> Result {
> +        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// A list of attributes.
> +///
> +/// This type is used to construct a new [`ItemType`]. It represents =
a list of
> +/// [`Attribute`] that will appear in the directory representing a =
[`Group`].
> +/// Users should not directly instantiate this type, rather they =
should use the
> +/// [`kernel::configfs_attrs`] macro to declare a static set of =
attributes for a
> +/// group.
> +#[repr(transparent)]
> +pub struct AttributeList<const N: usize, Data>(
> +    UnsafeCell<[*mut kernel::ffi::c_void; N]>,

For the sake of maintainability, can you provide some docs on this type?=20=


For example, what is the c_void here?

> +    PhantomData<Data>,
> +);
> +
> +// SAFETY: Ownership of `AttributeList` can safely be transferred to =
other threads.
> +unsafe impl<const N: usize, Data> Send for AttributeList<N, Data> {}
> +
> +// SAFETY: We do not provide any operations on `AttributeList` that =
need synchronization.
> +unsafe impl<const N: usize, Data> Sync for AttributeList<N, Data> {}
> +
> +impl<const N: usize, Data> AttributeList<N, Data> {
> +    /// # Safety
> +    ///
> +    /// This function can only be called by the `configfs_attrs`
> +    /// macro.

Well, a pub function can be called from anywhere in the crate. Maybe =
`should` would be more
appropriate? I assume you want to tell people to not call this directly. =
Otherwise I=E2=80=99m left wondering
whether there is some magic going on that I=E2=80=99m unaware of to make =
what you said possible.

> +    #[doc(hidden)]
> +    pub const unsafe fn new() -> Self {
> +        Self(UnsafeCell::new([core::ptr::null_mut(); N]), =
PhantomData)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// This function can only be called by the `configfs_attrs`
> +    /// macro.
> +    #[doc(hidden)]
> +    pub const unsafe fn add<
> +        const I: usize,
> +        const ID: u64,
> +        O: AttributeOperations<ID, Data =3D Data>,
> +    >(
> +        &'static self,
> +        attribute: &'static Attribute<ID, O, Data>,
> +    ) {

Can you convert this into a where clause? IMHO it will be much easier to =
read, given how the
function args got formatted here.


> +        // We need a space at the end of our list for a null =
terminator.
> +        if I >=3D N - 1 {
> +            kernel::build_error!("Invalid attribute index");
> +        }
> +
> +        // SAFETY: This function is only called through the =
`configfs_attrs`
> +        // macro. This ensures that we are evaluating the function in =
const
> +        // context when initializing a static. As such, the reference =
created
> +        // below will be exclusive.
> +        unsafe {
> +            (&mut *self.0.get())[I] =3D (attribute as *const =
Attribute<ID, O, Data>)
> +                .cast_mut()
> +                .cast()
> +        };
> +    }
> +}
> +
> +/// A representation of the attributes that will appear in a =
[`Group`] or
> +/// [`Subsystem`].
> +///
> +/// Users should not directly instantiate objects of this type. =
Rather, they
> +/// should use the [`kernel::configfs_attrs`] macro to statically =
declare the
> +/// shape of a [`Group`] or [`Subsystem`].
> +#[pin_data]
> +pub struct ItemType<Container, Data> {
> +    #[pin]
> +    item_type: Opaque<bindings::config_item_type>,
> +    _p: PhantomData<(Container, Data)>,
> +}
> +
> +// SAFETY: We do not provide any operations on `ItemType` that need =
synchronization.
> +unsafe impl<Container, Data> Sync for ItemType<Container, Data> {}
> +
> +// SAFETY: Ownership of `ItemType` can safely be transferred to other =
threads.
> +unsafe impl<Container, Data> Send for ItemType<Container, Data> {}
> +
> +macro_rules! impl_item_type {
> +    ($tpe:ty) =3D> {
> +        impl<Data> ItemType<$tpe, Data> {
> +            #[doc(hidden)]
> +            pub const fn new_with_child_ctor<const N: usize, Child>(
> +                owner: &'static ThisModule,
> +                attributes: &'static AttributeList<N, Data>,
> +            ) -> Self
> +            where
> +                Data: GroupOperations<Child =3D Child>,
> +                Child: 'static,
> +            {
> +                Self {
> +                    item_type: Opaque::new(bindings::config_item_type =
{
> +                        ct_owner: owner.as_ptr(),
> +                        ct_group_ops: (&GroupOperationsVTable::<Data, =
Child>::VTABLE as *const _)
> +                            as *mut _,
> +                        ct_item_ops: (&ItemOperationsVTable::<$tpe, =
Data>::VTABLE as *const _)
> +                            as *mut _,
> +                        ct_attrs: attributes as *const _ as _,
> +                        ct_bin_attrs: core::ptr::null_mut(),
> +                    }),
> +                    _p: PhantomData,
> +                }
> +            }
> +
> +            #[doc(hidden)]
> +            pub const fn new<const N: usize>(
> +                owner: &'static ThisModule,
> +                attributes: &'static AttributeList<N, Data>,
> +            ) -> Self {
> +                Self {
> +                    item_type: Opaque::new(bindings::config_item_type =
{
> +                        ct_owner: owner.as_ptr(),
> +                        ct_group_ops: core::ptr::null_mut(),
> +                        ct_item_ops: (&ItemOperationsVTable::<$tpe, =
Data>::VTABLE as *const _)
> +                            as *mut _,
> +                        ct_attrs: attributes as *const _ as _,
> +                        ct_bin_attrs: core::ptr::null_mut(),
> +                    }),
> +                    _p: PhantomData,
> +                }
> +            }
> +        }
> +    };
> +}
> +
> +impl_item_type!(Subsystem<Data>);
> +impl_item_type!(Group<Data>);
> +
> +impl<Container, Data> ItemType<Container, Data> {
> +    fn as_ptr(&self) -> *const bindings::config_item_type {
> +        self.item_type.get()
> +    }
> +}
> +
> +/// Define a list of configfs attributes statically.
> +#[macro_export]
> +macro_rules! configfs_attrs {
> +    (
> +        container: $container:ty,
> +        data: $data:ty,
> +        attributes: [
> +            $($name:ident: $attr:literal),* $(,)?
> +        ] $(,)?
> +    ) =3D> {
> +        $crate::configfs_attrs!(
> +            count:
> +            @container($container),
> +            @data($data),
> +            @child(),
> +            @no_child(x),
> +            @attrs($($name $attr)*),
> +            @eat($($name $attr,)*),
> +            @assign(),
> +            @cnt(0usize),
> +        )
> +    };
> +    (
> +        container: $container:ty,
> +        data: $data:ty,
> +        child: $child:ty,
> +        attributes: [
> +            $($name:ident: $attr:literal),* $(,)?
> +        ] $(,)?
> +    ) =3D> {
> +        $crate::configfs_attrs!(
> +            count:
> +            @container($container),
> +            @data($data),
> +            @child($child),
> +            @no_child(),
> +            @attrs($($name $attr)*),
> +            @eat($($name $attr,)*),
> +            @assign(),
> +            @cnt(0usize),
> +        )
> +    };
> +    (count:
> +     @container($container:ty),
> +     @data($data:ty),
> +     @child($($child:ty)?),
> +     @no_child($($no_child:ident)?),
> +     @attrs($($aname:ident $aattr:literal)*),
> +     @eat($name:ident $attr:literal, $($rname:ident =
$rattr:literal,)*),
> +     @assign($($assign:block)*),
> +     @cnt($cnt:expr),
> +    ) =3D> {
> +        $crate::configfs_attrs!(
> +            count:
> +            @container($container),
> +            @data($data),
> +            @child($($child)?),
> +            @no_child($($no_child)?),
> +            @attrs($($aname $aattr)*),
> +            @eat($($rname $rattr,)*),
> +            @assign($($assign)* {
> +                const N: usize =3D $cnt;
> +                // The following macro text expands to a call to =
`Attribute::add`.
> +                // SAFETY: We are expanding `configfs_attrs`.
> +                unsafe {
> +                    $crate::macros::paste!(
> +                        [< $data:upper _ATTRS >]
> +                            .add::<N, $attr, _>(&[< $data:upper _ =
$name:upper _ATTR >])
> +                    )
> +                };
> +            }),
> +            @cnt(1usize + $cnt),
> +        )
> +    };
> +    (count:
> +     @container($container:ty),
> +     @data($data:ty),
> +     @child($($child:ty)?),
> +     @no_child($($no_child:ident)?),
> +     @attrs($($aname:ident $aattr:literal)*),
> +     @eat(),
> +     @assign($($assign:block)*),
> +     @cnt($cnt:expr),
> +    ) =3D>
> +    {
> +        $crate::configfs_attrs!(
> +            final:
> +            @container($container),
> +            @data($data),
> +            @child($($child)?),
> +            @no_child($($no_child)?),
> +            @attrs($($aname $aattr)*),
> +            @assign($($assign)*),
> +            @cnt($cnt),
> +        )
> +    };
> +    (final:
> +     @container($container:ty),
> +     @data($data:ty),
> +     @child($($child:ty)?),
> +     @no_child($($no_child:ident)?),
> +     @attrs($($name:ident $attr:literal)*),
> +     @assign($($assign:block)*),
> +     @cnt($cnt:expr),
> +    ) =3D>
> +    {
> +        $crate::macros::paste!{
> +            {
> +                $(
> +                    // SAFETY: We are expanding `configfs_attrs`.
> +                    static [< $data:upper _ $name:upper _ATTR >]:
> +                        $crate::configfs::Attribute<$attr, $data, =
$data> =3D
> +                            unsafe {
> +                                =
$crate::configfs::Attribute::new(c_str!(::core::stringify!($name)))
> +                            };
> +                )*
> +
> +
> +                // We need space for a null terminator.
> +                const N: usize =3D $cnt + 1usize;
> +
> +                // SAFETY: We are expanding `configfs_attrs`.
> +                static [< $data:upper _ATTRS >]:
> +                $crate::configfs::AttributeList<N, $data> =3D
> +                    unsafe { $crate::configfs::AttributeList::new() =
};
> +
> +                $($assign)*
> +
> +                $(
> +                    const [<$no_child:upper>]: bool =3D true;
> +
> +                    static [< $data:upper _TPE >] : =
$crate::configfs::ItemType<$container, $data>  =3D
> +                        $crate::configfs::ItemType::<$container, =
$data>::new::<N>(
> +                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
> +                        );
> +                )?
> +
> +                $(
> +                    static [< $data:upper _TPE >]:
> +                        $crate::configfs::ItemType<$container, $data> =
 =3D
> +                            $crate::configfs::ItemType::<$container, =
$data>::
> +                            new_with_child_ctor::<N, $child>(
> +                                &THIS_MODULE, &[<$ data:upper _ATTRS =
>]
> +                            );
> +                )?
> +
> +                & [< $data:upper _TPE >]
> +            }
> +        }
> +    };
> +
> +}

Andreas, just a suggestion for the sake of maintainability, can you add =
some docs to this macro?

I think you=E2=80=99ll agree that there is a *lot* going on here.

In fact, this patch is a bit complex, so kudos on making it work in a =
very simple way for the callers.

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911..ec84653ab8c7 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,8 @@
> pub mod block;
> #[doc(hidden)]
> pub mod build_assert;
> +#[cfg(CONFIG_CONFIGFS_FS)]
> +pub mod configfs;
> pub mod cred;
> pub mod device;
> pub mod device_id;
>=20
> --=20
> 2.47.0
>=20
>=20

I=E2=80=99ll probably do another pass here later, there=E2=80=99s a lot =
to unpack.

=E2=80=94 Daniel


