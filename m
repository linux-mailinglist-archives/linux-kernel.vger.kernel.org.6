Return-Path: <linux-kernel+bounces-385289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873059B3514
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D83282A18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8751DE4C5;
	Mon, 28 Oct 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aexAM7vc"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39612F585;
	Mon, 28 Oct 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129953; cv=pass; b=EIUlzxCWoJrhgUS63PXAv/Tfh7Wd2pZFse50lOUT531M/aA/yBtQSUB/IBrJSoSbbT06o81n8hbo2SPWZHzkFJpamrqRm0EkxFsotZwlUMHP5OWk9FB4D4ZIP1GRdxCSibF7hdVx5CV0NIsoPVlGgt8SfqeR2D5rK2ZpPiQ5R6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129953; c=relaxed/simple;
	bh=0bcqQqglJVUMU+heQ73+rEwUTrzV9tFB9SivV6cQ2lM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Rf1SEV2ZjgunC89Z9mxq1AlCJrOmYuh+Yi6XHgGyfFTqFWNtm31Gy92JgHrBzRUsW6zxDCEmcjgFSt1mqXWkgDMeMhyeqFVjU54/X8+bNx1lScIhVpnn4MKyoIeXrpxvPDgxr+nUqrVJBGvvRhLG88R/FhDFNiTUytjBTRv5N/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aexAM7vc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730129941; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J4y3ZDcEAs0i/zF0ABDZ241J9J+Kjlprkn7IoaMsfS2ff5eE0diN+5zhkmwwSatj3soaYFJp//7wZUlZcRvjipJTf3tM4Q1iECoDqAlRHriNII/55ojNWmlMngrABt4IzXHAJStOcwqgMqIKy8EAsLEA+OQc/5HvLwo9gGGEq3I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730129941; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WN2d6PMago0xonk1IbyOYNDjM2/1VGz96OtyU/lNLG0=; 
	b=CMQgb6dkkp4hp49GjoDf2Q22ssln7rgAX7qGdmkldrQ06c06JLFUU77MDWRR5lkxvMdX53YC8EXE2eweghzccqxlDipChH0RCOUTpnYdHhwKcz9R6aDJf+batfcnwXNuzPc653ArvQeoaoK/KdH0arbDbqaEFzU4QWDcIO/7MjA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730129941;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=WN2d6PMago0xonk1IbyOYNDjM2/1VGz96OtyU/lNLG0=;
	b=aexAM7vckI3cvYhJZdUE976phMe+aCy80YLHIe2OrUi4AbUf7w2SdhkpZehcGfit
	F1Kio3FNaD0IlM4l4tfK6uajFvMwv6ksrIQ3GpPGZCFdKPnlODVsCVLDvs4CtZNaqHR
	OrwFFK6mVw/GCKnLrbDovdsePVPd9ADx+UmukvAQ=
Received: by mx.zohomail.com with SMTPS id 1730129940763523.7744098008807;
	Mon, 28 Oct 2024 08:39:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH 2/2] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20241023113309.1724992-3-abdiel.janulgue@gmail.com>
Date: Mon, 28 Oct 2024 12:38:45 -0300
Cc: rust-for-linux@vger.kernel.org,
 a.hindborg@kernel.org,
 linux-kernel@vger.kernel.org,
 dakr@redhat.com,
 airlied@redhat.com,
 miguel.ojeda.sandonis@gmail.com,
 wedsonaf@gmail.com,
 Andreas Hindborg <a.hindborg@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CF29D3D-C930-4274-9BAC-365C0F32DF56@collabora.com>
References: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
 <20241023113309.1724992-3-abdiel.janulgue@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-ZohoMailClient: External

Hi Abdiel,

> On 23 Oct 2024, at 08:32, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
> Add a simple dma coherent allocator rust abstraction which was based =
on
> Andreas Hindborg's dma abstractions from the rnvme driver.
>=20
> This version:
> - Does not introduce the unused dma pool functionality for now.
> - Represents the internal CPU buffer as a slice instead of using raw
>  pointer reads and writes.

This patch is not a v2, so was anybody against using a raw pointer at =
some time?

> - Ensures both 32 and 64-bit DMA addressing works.
> - Make use of Result error-handling instead of Some.
>=20
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
> rust/kernel/dma.rs | 153 +++++++++++++++++++++++++++++++++++++++++++++
> rust/kernel/lib.rs |   1 +
> 2 files changed, 154 insertions(+)
> create mode 100644 rust/kernel/dma.rs
>=20
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> new file mode 100644
> index 000000000000..8390b3a4e8aa
> --- /dev/null
> +++ b/rust/kernel/dma.rs
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct memory access (DMA).
> +//!
> +//! C header: =
[`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
> +
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::code::*,
> +    error::Result,
> +    types::ARef,
> +};
> +
> +/// Abstraction of dma_alloc_coherent
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of CoherentAllocation:
> +/// 1. The cpu address pointer is valid and is accessed with an index =
bounded within count.
> +/// 2. We hold a reference to the device.
> +pub struct CoherentAllocation<T: 'static> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: &'static mut [T],
> +}

Not sure why there=E2=80=99s =E2=80=99static here. The lifetime of =
`cpu_addr` is the lifetime of the object.

This is why keeping a pointer and building the slice as needed is =
actually a better approach, IMHO.
That will correctly express the lifetime we want to enforce, i.e.:

```
pub fn cpu(&=E2=80=99a self) -> &=E2=80=99a mut [T];=20
```

Where =E2=80=98a is automatically filled in, of course.

Also, naming a slice as `cpu_addr` doesn=E2=80=99t sound very good, to =
be honest.

> +
> +impl<T> CoherentAllocation<T> {
> +    /// Allocates a region of `size_of::<T> * count` of consistent =
memory.
> +    ///
> +    /// Returns a CoherentAllocation object which contains a pointer =
to the allocated region
> +    /// (in the processor's virtual address space) and the device =
address which can be
> +    /// given to the device as the DMA address base of the region. =
The region is released once
> +    /// [`CoherentAllocation`] is dropped.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::device::Device;
> +    /// use kernel::dma::CoherentAllocation;
> +    ///
> +    /// # fn dox(dev: &Device) -> Result<()> {
> +    /// let c: CoherentAllocation<u64> =3D =
CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL)?;

Have you considered ZSTs? What happens if someone writes down:

```
let c =3D CoherentAllocation<()> =3D =E2=80=A6
```

This doesn=E2=80=99t really make sense and should be forbidden.


> +    /// # Ok(()) }
> +    /// ```
> +    pub fn alloc_coherent(
> +        dev: &Device,
> +        count: usize,
> +        flags: kernel::alloc::Flags,
> +    ) -> Result<CoherentAllocation<T>> {
> +        let t_size =3D core::mem::size_of::<T>();
> +        let size =3D count.checked_mul(t_size).ok_or(EOVERFLOW)?;
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

I assume that ZSTs will simply return ENOMEM as per above, but that=E2=80=99=
s not quite
right either. The API should prevent this per-design instead of =
returning `Error`.

> +
> +        Ok(Self {
> +            dev: dev.into(),
> +            dma_handle,
> +            count,
> +            // SAFETY: The raw buffer and size is valid from the =
checks we've made above.
> +            cpu_addr: unsafe { core::slice::from_raw_parts_mut(ret as =
_, size) },
> +        })
> +    }
> +
> +    /// Reads a value on a location specified by index.
> +    pub fn read(&self, index: usize) -> Result<T>
> +    where
> +        T: Copy
> +    {
> +        if let Some(val) =3D self.cpu_addr.get(index) {
> +            Ok(*val)
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +
> +    /// Write a value on the memory location specified by index.
> +    pub fn write(&mut self, index: usize, value: &T) -> Result
> +    where
> +        T: Copy,
> +    {
> +        if let Some(elem) =3D self.cpu_addr.get_mut(index) {
> +            *elem =3D *value;
> +            Ok(())
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +
> +    /// Performs a read and then a write of a value on a location =
specified by index.
> +    pub fn read_write(&mut self, index: usize, value: &T) -> =
Result<T>
> +    where
> +        T: Copy,
> +    {
> +        if let Some(elem) =3D self.cpu_addr.get_mut(index) {
> +            let val =3D *elem;
> +            *elem =3D *value;
> +            Ok(val)
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +
> +    /// Returns the base address to the allocated region and the dma =
handle.
> +    /// Caller takes ownership of returned resources.
> +    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
> +        let ret =3D (self.cpu_addr.as_mut_ptr() as _, =
self.dma_handle);
> +        core::mem::forget(self);
> +        ret
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's =
virtual address space.
> +    pub fn start_ptr(&self) -> *const T {
> +        self.cpu_addr.as_ptr() as _
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's =
virtual address space as
> +    /// a mutable pointer.
> +    pub fn start_ptr_mut(&mut self) -> *mut T {
> +        self.cpu_addr.as_mut_ptr() as _
> +    }
> +
> +    /// Returns a DMA handle which may given to the device as the DMA =
address base of
> +    /// the region.
> +    pub fn dma_handle(&self) -> bindings::dma_addr_t {
> +        self.dma_handle
> +    }
> +}
> +
> +impl<T> Drop for CoherentAllocation<T> {
> +    fn drop(&mut self) {
> +        let size =3D self.count * core::mem::size_of::<T>();
> +
> +        // SAFETY: the device, cpu address, and the dma handle is =
valid due to the
> +        // type invariants on `CoherentAllocation`.
> +        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
> +                                          self.cpu_addr.as_mut_ptr() =
as _,
> +                                          self.dma_handle, 0) }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b62451f64f6e..b713c92eb1ef 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -32,6 +32,7 @@
> pub mod block;
> mod build_assert;
> pub mod device;
> +pub mod dma;
> pub mod error;
> #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> pub mod firmware;
> --=20
> 2.43.0
>=20
>=20

Everything else looks good to me!

=E2=80=94 Daniel


