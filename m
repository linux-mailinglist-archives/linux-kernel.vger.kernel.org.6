Return-Path: <linux-kernel+bounces-395580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3100B9BC00E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC0A28262E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6051FCC7E;
	Mon,  4 Nov 2024 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="h6RRpL7b"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948051FCC6A;
	Mon,  4 Nov 2024 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755731; cv=pass; b=Oy2+KaZ5U4ZLRSW+xjHj9RqSzR0rLZqksdCqzjgzsdUDBrtjz0rSGclyq4wRoLDc1r8orThJrJTLQzWUQziwWoHzy72QGhLUIlnlYoC2+3gRxCTEBIxxd6c3Yy/96lNRlLEI5d53zYT3B/4Wr5tX76WOtKpQ3fkK1HSMFG0R7fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755731; c=relaxed/simple;
	bh=AhjkIj5bOe5Z9BbV+pnLjnFvediMGJeBmE75d1qtNp4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BXhYUtC8tWuR8kJlPQDK+paazQvKhPDJTUxZeaFug78PoIwtK3+TeKlKzEe6KY0h/H/pUvyhFGdEAP+tbFJHpAve+ksQldjLVEtlGVi9CF+j9h1CDaRqYGIqo2ltPumndIsoe9lzMXjkeXZr8KOrcjdVESlhuz6yne1l3iGojj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=h6RRpL7b; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730755711; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X1P5aI3qo/ofKBFwLbK9682/Dyjg7Bac6DDPLpFvn2IFvpwlnZ6t/WXNkFtrLF+pO/2F+8BB6pBfknaGRBU2T7PlZxVYKEUcoqGOdTdCg/Y7q9uMlqaY1pWjK+DhD5RDVH7rzcK1hwSJJAs+DOqTs7xY0JbshWT7BFc4f5K0Eyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730755711; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eAvJg9xyJ+pxb8KEBYCcx9LnR75ZkgWT87Qu2nZeBNY=; 
	b=JvkfJu89VkBLVvOF9LTZPW/VJHbN0k8rzL8R3B/A2Afa6NiRuQlfJ06ro4sEXfMYtdQ/akfImNM6PuxstqG/dtQ6p9wIKfhZ17UltFlpAhUKpicxtxu8nvC3eL2xhMBcxYHVUmd8rjejSTKN8aqe17q33uvlxWkQ3SZ0T0KSg5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730755711;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=eAvJg9xyJ+pxb8KEBYCcx9LnR75ZkgWT87Qu2nZeBNY=;
	b=h6RRpL7bVVTVxxu9PONAQEyOce3yaLNibzL6ScwOxHkJL1iFC+Bbr2ZPtqdgAVB+
	wA78HeFnDoheTHidkr/b7Gfk/LLiv1jV/qsuwYGU/Z1WdxiVpXyLI9fOSM6Yf92Umw3
	HoZgHeXP7mxx0nC7o1pFEU5DpglYoiXdYlGh+jBU=
Received: by mx.zohomail.com with SMTPS id 173075570961164.43306330710777;
	Mon, 4 Nov 2024 13:28:29 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] rust: platform: add Io support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLghv3cBGO0HEH-5GXiDZZWyKSJYxQu8s0fi8D=eneS-OXw@mail.gmail.com>
Date: Mon, 4 Nov 2024 18:28:14 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <935A78FF-0851-4A72-BCCB-C33E3F4BF61C@collabora.com>
References: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
 <CAH5fLgjdDm3nNvR8g-a6Z8UsSnEDygLJ8i3u63aCrpG5ambQ3A@mail.gmail.com>
 <BC47085B-4160-4D9B-89F4-06EDE706CD5A@collabora.com>
 <CAH5fLghv3cBGO0HEH-5GXiDZZWyKSJYxQu8s0fi8D=eneS-OXw@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Alice!

> On 29 Oct 2024, at 10:46, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Mon, Oct 28, 2024 at 7:23=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> Hi Alice,
>>=20
>>> On 28 Oct 2024, at 12:37, Alice Ryhl <aliceryhl@google.com> wrote:
>>>=20
>>> On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
>>> <daniel.almeida@collabora.com> wrote:
>>>>=20
>>>> The IoMem is backed by ioremap_resource()
>>>>=20
>>>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>>>> ---
>>>> The PCI/Platform abstractions are in-flight and can be found at:
>>>>=20
>>>> https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
>>>> ---
>>>> rust/bindings/bindings_helper.h |  1 +
>>>> rust/helpers/io.c               | 11 ++++++
>>>> rust/kernel/platform.rs         | 88 =
+++++++++++++++++++++++++++++++++++++++++
>>>> 3 files changed, 100 insertions(+)
>>>>=20
>>>> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
>>>> index =
217c776615b9593a2fa921dee130c357dbd96761..90b2d29e7b99f33ceb313b4cc7f8232f=
ef5eed17 100644
>>>> --- a/rust/bindings/bindings_helper.h
>>>> +++ b/rust/bindings/bindings_helper.h
>>>> @@ -13,6 +13,7 @@
>>>> #include <linux/errname.h>
>>>> #include <linux/ethtool.h>
>>>> #include <linux/firmware.h>
>>>> +#include <linux/ioport.h>
>>>> #include <linux/jiffies.h>
>>>> #include <linux/mdio.h>
>>>> #include <linux/of_device.h>
>>>> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
>>>> index =
f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..f708c09c4c87634c56af29ef22ebaa2b=
f51d82a9 100644
>>>> --- a/rust/helpers/io.c
>>>> +++ b/rust/helpers/io.c
>>>> @@ -1,6 +1,7 @@
>>>> // SPDX-License-Identifier: GPL-2.0
>>>>=20
>>>> #include <linux/io.h>
>>>> +#include <linux/ioport.h>
>>>>=20
>>>> u8 rust_helper_readb(const volatile void __iomem *addr)
>>>> {
>>>> @@ -89,3 +90,13 @@ void rust_helper_writeq_relaxed(u64 value, =
volatile void __iomem *addr)
>>>>       writeq_relaxed(value, addr);
>>>> }
>>>> #endif
>>>> +
>>>> +resource_size_t rust_helper_resource_size(struct resource *res)
>>>> +{
>>>> +       return resource_size(res);
>>>> +}
>>>> +
>>>> +void __iomem *rust_helper_ioremap(resource_size_t addr, unsigned =
long size)
>>>> +{
>>>> +       return ioremap(addr, size);
>>>> +}
>>>> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
>>>> index =
addf5356f44f3cf233503aed97f1aa0d32f4f062..d152432c80a4499ead30ddaebe8d87a9=
679bfa97 100644
>>>> --- a/rust/kernel/platform.rs
>>>> +++ b/rust/kernel/platform.rs
>>>> @@ -4,11 +4,15 @@
>>>> //!
>>>> //! C header: =
[`include/linux/platform_device.h`](srctree/include/linux/platform_device.=
h)
>>>>=20
>>>> +use core::ops::Deref;
>>>> +
>>>> use crate::{
>>>>    bindings, container_of, device,
>>>>    device_id::RawDeviceId,
>>>> +    devres::Devres,
>>>>    driver,
>>>>    error::{to_result, Result},
>>>> +    io::Io,
>>>>    of,
>>>>    prelude::*,
>>>>    str::CStr,
>>>> @@ -208,6 +212,49 @@ fn as_raw(&self) -> *mut =
bindings::platform_device {
>>>>        // embedded in `struct platform_device`.
>>>>        unsafe { container_of!(self.0.as_raw(), =
bindings::platform_device, dev) }.cast_mut()
>>>>    }
>>>> +
>>>> +    /// Maps a platform resource through ioremap() where the size =
is known at
>>>> +    /// compile time.
>>>> +    pub fn ioremap_resource_sized<const SIZE: usize>(
>>>> +        &self,
>>>> +        resource: u32,
>>>> +    ) -> Result<Devres<IoMem<SIZE>>> {
>>>> +        let res =3D self.resource(resource)?;
>>>> +        let size =3D self.resource_len(resource)? as usize;
>>>=20
>>> You're calling platform_get_resource twice here? Can you be sure =
that
>>> it returns the same pointer each time?
>>=20
>> This comes from the DT. Yes, it will be the same pointer (so long as =
we
>> pass the same index).
>>=20
>> Although, I did not see where it is being called twice?
>=20
> The `resource_len` function calls `resource`, so you call `resource`
> twice. Each call to `resource` results in a call to
> `platform_get_resource`.
>=20
>>>> +        // SAFETY: `res` is guaranteed to be a valid MMIO address =
and the size
>>>> +        // is given by the kernel as per `self.resource_len()`.
>>>> +        let io =3D unsafe { IoMem::new(res as _, size) }?;
>>>=20
>>> Why do we know that `res` is a valid MMIO address? Is it because
>>> platform_get_resource always does so?
>>=20
>> Again, if there=E2=80=99s a problem, the DT itself should be fixed. =
Also the C code would be broken too.
>=20
> Sorry if I was unclear. I just wanted you to elaborate in the safety =
comment :)
>=20
>>>> +        let devres =3D Devres::new(self.as_ref(), io, =
GFP_KERNEL)?;
>>>> +
>>>> +        Ok(devres)
>>>> +    }
>>>> +
>>>> +    /// Maps a platform resource through ioremap().
>>>> +    pub fn ioremap_resource(&self, resource: u32) -> =
Result<Devres<IoMem>> {
>>>> +        self.ioremap_resource_sized::<0>(resource)
>>>> +    }
>>>=20
>>> I guess size zero is special?
>>>=20
>>=20
>> `ioremap_resource_sized` is used when you know the size at compile =
time. Setting SIZE =3D=3D 0
>> means that you get runtime checks on whether your reads and writes =
are within bounds,
>> because you will have to use try_read() and try_write() instead of =
read() and write() or your build
>> will fail.
>>=20
>> This is not related to this patch in particular, but to a preceding =
one that introduces struct Io.
>>=20
>> We merely expose the same API from Io to users here.
>>=20
>> Although I do agree it=E2=80=99s a bit confusing that SIZE 0 is =
special-cased. It took me a while and
>> several read-throughs to understand what was going on.
>>=20
>> Note that it=E2=80=99s common to have to read the size from the DT, =
so deferring to runtime checks
>> seems to be unavoidable in a lot of cases if we want to have a safe =
API.
>>=20
>> Here=E2=80=99s the relevant code from that commit:
>>=20
>> ```
>> +macro_rules! define_write {
>> + ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) =3D> =
{
>> + /// Write IO data from a given offset known at compile time.
>> + ///
>> + /// Bound checks are performed on compile time, hence if the offset =
is not known at compile
>> + /// time, the build will fail.
>> + $(#[$attr])*
>> + #[inline]
>> + pub fn $name(&self, value: $type_name, offset: usize) {
>> +       let addr =3D self.io_addr_assert::<$type_name>(offset);
>> +
>> +       // SAFETY: By the type invariant `addr` is a valid address =
for MMIO operations.
>> +        unsafe { bindings::$name(value, addr as _, ) }
>> + }
>> +
>> + /// Write IO data from a given offset.
>> + ///
>> + /// Bound checks are performed on runtime, it fails if the offset =
(plus the type size) is
>> + /// out of bounds.
>> + $(#[$attr])*
>> + pub fn $try_name(&self, value: $type_name, offset: usize) -> Result =
{
>> +       let addr =3D self.io_addr::<$type_name>(offset)?;
>> +
>> +       // SAFETY: By the type invariant `addr` is a valid address =
for MMIO operations.
>> +       unsafe { bindings::$name(value, addr as _) }
>> +       Ok(())
>> + }
>> ```
>>=20
>> Where,
>>=20
>> ```
>> + #[inline]
>> + fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>> +       if !Self::offset_valid::<U>(offset, self.maxsize()) {
>> +               return Err(EINVAL);
>> + }
>> +
>> + // Probably no need to check, since the safety requirements of =
`Self::new` guarantee that
>> + // this can't overflow.
>> + self.base_addr().checked_add(offset).ok_or(EINVAL)
>> + }
>> + #[inline]
>> + fn io_addr_assert<U>(&self, offset: usize) -> usize {
>> +       build_assert!(Self::offset_valid::<U>(offset, SIZE));
>> +
>> +       self.base_addr() + offset
>> + }
>> ```
>>=20
>> And
>>=20
>> ```
>> + #[inline]
>> + const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>> +       let type_size =3D core::mem::size_of::<U>();
>> +       if let Some(end) =3D offset.checked_add(type_size) {
>> +               end <=3D size && offset % type_size =3D=3D 0
>> +       } else {
>> +               false
>> +       }
>> + }
>> ```
>=20
> Acknowledged.
>=20
>>>> +    /// Returns the resource len for `resource`, if it exists.
>>>> +    pub fn resource_len(&self, resource: u32) -> =
Result<bindings::resource_size_t> {
>>>=20
>>> Should this just return usize? Should we have a type alias for this =
size type?
>>=20
>>=20
>> I guess usize would indeed be a better fit, if we consider the code =
below:
>>=20
>> ```
>> #ifdef CONFIG_PHYS_ADDR_T_64BIT
>> typedef u64 phys_addr_t;
>> #else
>> typedef u32 phys_addr_t;
>> #endif
>>=20
>> typedef phys_addr_t resource_size_t;
>=20
> Hmm. I guess they probably do that because phys_addr_t could differ
> from size_t? Sounds like we may want a typedef called phys_addr_t
> somewhere on the Rust side?


By the way, I wonder if that connects with Gary=E2=80=99s work on =
unifying the bindgen
primitives somehow.


I think that having a #ifdef for `phys_addr_t` is pretty =
self-explanatory, but I have no
idea why this is not simply `size_t`. My understanding is that `size_t` =
and `phys_addr_t`
should be basically interchangeable, in the sense that, for example, a =
32bit machine can
only address up to 0xffffffff, and, by extension, can only have objects =
that are 0xffffffff in size
at maximum.

This behavior is identical to usize, unless I missed something.

Maybe more knowledgeable people than me can chime in here?


>=20
>>>> +        match self.resource(resource) {
>>>> +            // SAFETY: if a struct resource* is returned by the =
kernel, it is valid.
>>>> +            Ok(resource) =3D> Ok(unsafe { =
bindings::resource_size(resource) }),
>>>> +            Err(e) =3D> Err(e),
>>>> +        }
>>>> +    }
>>>> +
>>>> +    fn resource(&self, resource: u32) -> Result<*mut =
bindings::resource> {
>>>> +        // SAFETY: By the type invariants, we know that `self.ptr` =
is non-null and valid.
>>>> +        let resource =3D unsafe {
>>>> +            bindings::platform_get_resource(self.as_raw(), =
bindings::IORESOURCE_MEM, resource)
>>>> +        };
>>>> +        if !resource.is_null() {
>>>> +            Ok(resource)
>>>> +        } else {
>>>> +            Err(EINVAL)
>>>> +        }
>>>> +    }
>>>> }
>>>>=20
>>>> impl AsRef<device::Device> for Device {
>>>> @@ -215,3 +262,44 @@ fn as_ref(&self) -> &device::Device {
>>>>        &self.0
>>>>    }
>>>> }
>>>> +
>>>> +/// A I/O-mapped memory region for platform devices.
>>>> +///
>>>> +/// See also [`kernel::pci::Bar`].
>>>> +pub struct IoMem<const SIZE: usize =3D 0>(Io<SIZE>);
>>>> +
>>>> +impl<const SIZE: usize> IoMem<SIZE> {
>>>> +    /// Creates a new `IoMem` instance.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// The caller must make sure that `paddr` is a valid MMIO =
address.
>>>> +    unsafe fn new(paddr: usize, size: usize) -> Result<Self> {
>>>=20
>>> What happens if `size !=3D SIZE`?
>>=20
>>=20
>> ```
>> +impl<const SIZE: usize> Io<SIZE> {
>> + ///
>> + ///
>> + /// # Safety
>> + ///
>> + /// Callers must ensure that `addr` is the start of a valid I/O =
mapped memory region of size
>> + /// `maxsize`.
>> + pub unsafe fn new(addr: usize, maxsize: usize) -> Result<Self> {
>> +       if maxsize < SIZE {
>> +               return Err(EINVAL);
>> +        }
>> ```
>>=20
>> As we=E2=80=99ve seen in the other code snippets I pasted, it=E2=80=99s=
 SIZE that is used in the try_read and
>> try_write checks.
>=20
> Ok.
>=20
> Alice

=E2=80=94 Daniel


