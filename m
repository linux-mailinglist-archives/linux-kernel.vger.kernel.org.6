Return-Path: <linux-kernel+bounces-432040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB39E44F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F0B85E72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7399C1C3BFF;
	Wed,  4 Dec 2024 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TLNFfKkO"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BA1A8F6E;
	Wed,  4 Dec 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339347; cv=pass; b=jZXBax4OhDll4a8CcqvrXYhckQ7PacU8X+De71j9lhzKKlkZap3N0jAeb3P739tVp0ot4Ug506Ho3xJncKicTdMnampEnH6sUBJgVPIdNXH0zNYygxP08UNH59VZfzTGalEKo2+CtUSvAULWjd8ILJ8vyhMo0WMbRNXTkUhYzzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339347; c=relaxed/simple;
	bh=8yMQMBPDNh7miLRJnVQ+GZCLHZmaTJO7LvPRqau3VA8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ia8OymeyaBCN4gCMj6VnaFPnwrD/c/RxRIzARdNfaVvo6XIUJYW1/bNAGCtfLgA/k9qTwUqngdoZsm0cpKKD/hjBhy3KB8rtoDtOAHz355eMkzNShX7WtuLd8YV1gOmF7ndeVxwZhXD0NeC0LTg0bp2tDRa5onDsxaaB4q0FGZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TLNFfKkO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733339316; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QsSWQZI/TvaddnoXx/MYb/9Lh/wmef6H30BcfUk1BaAuiMf3EKczYuJEMNBKcdObZH7EaopEkKtJl4uv/JDFqk5+gzcQrcMqD4SXrA32tpHHnEoPPfq93dpcc6FOZfNNIxFCeo0P/BCpSfY4H/VFlDMOU4Wl6xhhJ4A2OUGev6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733339316; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O+vCOyKaol/q4vjTgIGLLkHXjDioz2gyMQBKcVMwTn0=; 
	b=IFv0tnYmovacfX0cjSwxNbI1oJFGSxw30nR7pXnDWDsVf3L6pGaFU6Fj5tR29sSNPB4cuwUbkUj2GsKMN7VkLmMLtd/7l73S3VexF/r6sjF6cr9EfgJ5l98iVOyBsQwS/hGm/v3ihcZPHj0awMoSjG/2dRiznUdJBvKd47LioXE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733339316;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=O+vCOyKaol/q4vjTgIGLLkHXjDioz2gyMQBKcVMwTn0=;
	b=TLNFfKkO6XnS08DURZN9tgTLEAwOtGt9iyVshW+8QYt6m1o7g8hNrPsD6fWL3M2f
	d+h8KcW05RxuxXHNvoK1b56vJKNKUss7SAxj+D7Qd5xwt0hvK0HJlngTOv5zPQlMysj
	ycCoo9eCZoo3ZeqI+o+V7hvHXbN0ZjevZq9kByPA=
Received: by mx.zohomail.com with SMTPS id 173333931476854.75299437249271;
	Wed, 4 Dec 2024 11:08:34 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v5 2/2] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20241203170752.1834271-3-abdiel.janulgue@gmail.com>
Date: Wed, 4 Dec 2024 16:08:18 -0300
Cc: rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Wedson Almeida Filho <wedsonaf@google.com>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFCEFEB8-3FB1-44E2-A31E-93863E11BF87@collabora.com>
References: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
 <20241203170752.1834271-3-abdiel.janulgue@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Abdiel,

> On 3 Dec 2024, at 14:07, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>=20
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
> rust/bindings/bindings_helper.h |   1 +
> rust/kernel/dma.rs              | 136 ++++++++++++++++++++++++++++++++
> rust/kernel/lib.rs              |   1 +
> 3 files changed, 138 insertions(+)
> create mode 100644 rust/kernel/dma.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 5c4dfe22f41a..49bf713b9bb6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
> #include <linux/blk_types.h>
> #include <linux/blkdev.h>
> #include <linux/cred.h>
> +#include <linux/dma-mapping.h>
> #include <linux/errname.h>
> #include <linux/ethtool.h>
> #include <linux/file.h>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> new file mode 100644
> index 000000000000..9279be235fcf
> --- /dev/null
> +++ b/rust/kernel/dma.rs
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct memory access (DMA).
> +//!
> +//! C header: =
[`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
> +
> +use crate::{
> +    bindings,
> +    build_assert,
> +    device::Device,
> +    error::code::*,
> +    error::Result,
> +    types::ARef,
> +    transmute::{AsBytes, FromBytes},
> +};
> +
> +/// An abstraction of the `dma_alloc_coherent` API.
> +///
> +/// This is an abstraction around the `dma_alloc_coherent` API which =
is used to allocate and map
> +/// large consistent DMA regions.
> +///
> +/// A [`CoherentAllocation`] instance contains a pointer to the =
allocated region (in the
> +/// processor's virtual address space) and the device address which =
can be given to the device
> +/// as the DMA address base of the region. The region is released =
once [`CoherentAllocation`]
> +/// is dropped.
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of [`CoherentAllocation`], the =
cpu address is a valid pointer
> +/// to an allocated region of consistent memory and we hold a =
reference to the device.
> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: *mut T,
> +}
> +
> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
> +    /// Allocates a region of `size_of::<T> * count` of consistent =
memory.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::device::Device;
> +    /// use kernel::dma::CoherentAllocation;
> +    ///
> +    /// # fn test(dev: &Device) -> Result {
> +    /// let c: CoherentAllocation<u64> =3D =
CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL)?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn alloc_coherent(
> +        dev: &Device,
> +        count: usize,
> +        flags: kernel::alloc::Flags,
> +    ) -> Result<CoherentAllocation<T>> {
> +        build_assert!(core::mem::size_of::<T>() > 0,
> +                      "It doesn't make sense for the allocated type =
to be a ZST");
> +
> +        let size =3D =
count.checked_mul(core::mem::size_of::<T>()).ok_or(EOVERFLOW)?;
> +        let mut dma_handle =3D 0;
> +        // SAFETY: device pointer is guaranteed as valid by invariant =
on `Device`.
> +        // We ensure that we catch the failure on this function and =
throw an ENOMEM
> +        let ret =3D unsafe {
> +            bindings::dma_alloc_attrs(
> +                dev.as_raw(),
> +                size,
> +                &mut dma_handle, flags.as_raw(),
> +                0,
> +            )
> +        };
> +        if ret.is_null() {
> +            return Err(ENOMEM)
> +        }
> +        // INVARIANT: We just successfully allocated a coherent =
region which is accessible for
> +        // `count` elements, hence the cpu address is valid. We also =
hold a refcounted reference
> +        // to the device.
> +        Ok(Self {
> +            dev: dev.into(),
> +            dma_handle,
> +            count,
> +            cpu_addr: ret as *mut T,
> +        })
> +    }
> +
> +    /// Returns the base address to the allocated region and the dma =
handle. The caller takes
> +    /// ownership of the returned resources.
> +    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
> +        let ret =3D (self.cpu_addr as _, self.dma_handle);
> +        core::mem::forget(self);
> +        ret
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's =
virtual address space.
> +    pub fn start_ptr(&self) -> *const T {
> +        self.cpu_addr as _
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's =
virtual address space as
> +    /// a mutable pointer.
> +    pub fn start_ptr_mut(&mut self) -> *mut T {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns a DMA handle which may given to the device as the DMA =
address base of
> +    /// the region.
> +    pub fn dma_handle(&self) -> bindings::dma_addr_t {
> +        self.dma_handle
> +    }
> +
> +    /// Returns the CPU-addressable region as a slice.
> +    pub fn cpu_buf<'a>(&self) -> &'a [T]

Why this =E2=80=98a here? Lifetime elision rules should tie the lifetime =
of the returned slice
to the lifetime of &self automatically

> +    {
> +        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
> +        // is valid for reads for `self.count * size_of::<T>` bytes.
> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, =
self.count) }
> +    }
> +
> +    /// Performs the same functionality as `cpu_buf`, except that a =
mutable slice is returned.
> +    pub fn cpu_buf_mut<'a>(&mut self) -> &'a mut [T]

Same here

> +    {
> +        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
> +        // is valid for reads for `self.count * size_of::<T>` bytes.
> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, =
self.count) }
> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> +    fn drop(&mut self) {
> +        let size =3D self.count * core::mem::size_of::<T>();
> +        // SAFETY: the device, cpu address, and the dma handle is =
valid due to the
> +        // type invariants on `CoherentAllocation`.
> +        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
> +                                          self.cpu_addr as _,
> +                                          self.dma_handle, 0) }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e1065a7551a3..6e90ebf5a130 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -35,6 +35,7 @@
> mod build_assert;
> pub mod cred;
> pub mod device;
> +pub mod dma;
> pub mod error;
> #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> pub mod firmware;
> --=20
> 2.43.0
>=20
>=20


By the way, I tested this using a slightly modified version of the =
sample Rust platform driver
from Danilo=E2=80=99s v3 submission. It=E2=80=99s working as intended :)

With the change above, you can add:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>

=E2=80=94 Daniel


