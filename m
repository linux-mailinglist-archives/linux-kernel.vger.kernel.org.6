Return-Path: <linux-kernel+bounces-385585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA829B3905
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184401C215A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A791DF972;
	Mon, 28 Oct 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Grj1eBAq"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725F155A52;
	Mon, 28 Oct 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139794; cv=pass; b=brSerprcXYBGe7Gzfbr4FzThrn9zOsFv83h7O2DSE98EEwlMZpTytNfnGI+cA3c52Iwypd3i6Vy5MH1A17U9Fw44NlsEfAHT4gFVE5LIZehyF3YPt/OEJIjhwdLTVbq6wXkAEuiS2NrcBCu+cnE7238qsUz+txy+IV7dTmH8prM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139794; c=relaxed/simple;
	bh=V6ic1dwuVSHhvuXu8lp9JmlrWNTJOHuYuSrgdfc+5yU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=N7QQG70li37RE0JLFUkCW5WUABVHhzZQXPAvtZW0DOZTX7LZZdO76N3Mxsa3Qdji/DO+W82WY6Ik0xOyRJG33VzzNTg5GHTWmn/NJSAfIyRbUqJ7ZBKWkrUxTbHcjTv/cOAnBeXWqjM+M/K26AZ1lcBty6qbZcimKRJ//EjlbmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Grj1eBAq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730139769; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XIyGNhcFhy3Gio/Q+UnuoB2MCs/yXi1raPWH7lkUnQBksht/+aYBUHEVpybKtbINTpDdjsPqL66RQaozs5YJQamW4b4ATtI4o4BPTaZx/N7q8TYLOmkbo1s8OuCLo+syQ6BkhQqHMTIEDYX1E61TG77eWmaeLrAN4hXjD6zXRU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730139769; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wWQSN2aNzGza+AH5QanyHPySuj///mflmuCxHlszhBw=; 
	b=RzhGaBE5K12FSSlFE4q4W/+6z1S7jka5Wx854d26ROEEo2gZ4yrs+v0sRZ4tsjLnB9Zb1Jy09EM2OrmKQXJQBQeqNSFjqR1if3ico9BxjsbhVJEaAa7DvFiCUxR9e7VWR/KOVzrNwFGSTMmL0J1EPGTQ6QE+f6mGhwFJkyjp3mg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730139769;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=wWQSN2aNzGza+AH5QanyHPySuj///mflmuCxHlszhBw=;
	b=Grj1eBAqpiHQqTv0liONi66YVnGpioGOP9zDMI+RzlpFFxkgNTUHFd+AbSrQOR6L
	d2JjAJ3n/mOZKbw5CJm8V5dcVOU2twtWaTIONu7MdOuYWJYI5pQD/9n2/J+sd0KFRMx
	DfiJdaPjkY6Xil51KQrmmhu7w/+G0a4cu6Es2xC8=
Received: by mx.zohomail.com with SMTPS id 1730139767901948.4494051228504;
	Mon, 28 Oct 2024 11:22:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] rust: platform: add Io support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjdDm3nNvR8g-a6Z8UsSnEDygLJ8i3u63aCrpG5ambQ3A@mail.gmail.com>
Date: Mon, 28 Oct 2024 15:22:31 -0300
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
Message-Id: <BC47085B-4160-4D9B-89F4-06EDE706CD5A@collabora.com>
References: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
 <CAH5fLgjdDm3nNvR8g-a6Z8UsSnEDygLJ8i3u63aCrpG5ambQ3A@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-ZohoMailClient: External

Hi Alice,

> On 28 Oct 2024, at 12:37, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> The IoMem is backed by ioremap_resource()
>>=20
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> ---
>> The PCI/Platform abstractions are in-flight and can be found at:
>>=20
>> https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
>> ---
>> rust/bindings/bindings_helper.h |  1 +
>> rust/helpers/io.c               | 11 ++++++
>> rust/kernel/platform.rs         | 88 =
+++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 100 insertions(+)
>>=20
>> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
>> index =
217c776615b9593a2fa921dee130c357dbd96761..90b2d29e7b99f33ceb313b4cc7f8232f=
ef5eed17 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -13,6 +13,7 @@
>> #include <linux/errname.h>
>> #include <linux/ethtool.h>
>> #include <linux/firmware.h>
>> +#include <linux/ioport.h>
>> #include <linux/jiffies.h>
>> #include <linux/mdio.h>
>> #include <linux/of_device.h>
>> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
>> index =
f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..f708c09c4c87634c56af29ef22ebaa2b=
f51d82a9 100644
>> --- a/rust/helpers/io.c
>> +++ b/rust/helpers/io.c
>> @@ -1,6 +1,7 @@
>> // SPDX-License-Identifier: GPL-2.0
>>=20
>> #include <linux/io.h>
>> +#include <linux/ioport.h>
>>=20
>> u8 rust_helper_readb(const volatile void __iomem *addr)
>> {
>> @@ -89,3 +90,13 @@ void rust_helper_writeq_relaxed(u64 value, =
volatile void __iomem *addr)
>>        writeq_relaxed(value, addr);
>> }
>> #endif
>> +
>> +resource_size_t rust_helper_resource_size(struct resource *res)
>> +{
>> +       return resource_size(res);
>> +}
>> +
>> +void __iomem *rust_helper_ioremap(resource_size_t addr, unsigned =
long size)
>> +{
>> +       return ioremap(addr, size);
>> +}
>> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
>> index =
addf5356f44f3cf233503aed97f1aa0d32f4f062..d152432c80a4499ead30ddaebe8d87a9=
679bfa97 100644
>> --- a/rust/kernel/platform.rs
>> +++ b/rust/kernel/platform.rs
>> @@ -4,11 +4,15 @@
>> //!
>> //! C header: =
[`include/linux/platform_device.h`](srctree/include/linux/platform_device.=
h)
>>=20
>> +use core::ops::Deref;
>> +
>> use crate::{
>>     bindings, container_of, device,
>>     device_id::RawDeviceId,
>> +    devres::Devres,
>>     driver,
>>     error::{to_result, Result},
>> +    io::Io,
>>     of,
>>     prelude::*,
>>     str::CStr,
>> @@ -208,6 +212,49 @@ fn as_raw(&self) -> *mut =
bindings::platform_device {
>>         // embedded in `struct platform_device`.
>>         unsafe { container_of!(self.0.as_raw(), =
bindings::platform_device, dev) }.cast_mut()
>>     }
>> +
>> +    /// Maps a platform resource through ioremap() where the size is =
known at
>> +    /// compile time.
>> +    pub fn ioremap_resource_sized<const SIZE: usize>(
>> +        &self,
>> +        resource: u32,
>> +    ) -> Result<Devres<IoMem<SIZE>>> {
>> +        let res =3D self.resource(resource)?;
>> +        let size =3D self.resource_len(resource)? as usize;
>=20
> You're calling platform_get_resource twice here? Can you be sure that
> it returns the same pointer each time?

This comes from the DT. Yes, it will be the same pointer (so long as we
pass the same index).

Although, I did not see where it is being called twice?

>=20
>> +        // SAFETY: `res` is guaranteed to be a valid MMIO address =
and the size
>> +        // is given by the kernel as per `self.resource_len()`.
>> +        let io =3D unsafe { IoMem::new(res as _, size) }?;
>=20
> Why do we know that `res` is a valid MMIO address? Is it because
> platform_get_resource always does so?

Again, if there=E2=80=99s a problem, the DT itself should be fixed. Also =
the C code would be broken too.

>=20
>> +        let devres =3D Devres::new(self.as_ref(), io, GFP_KERNEL)?;
>> +
>> +        Ok(devres)
>> +    }
>> +
>> +    /// Maps a platform resource through ioremap().
>> +    pub fn ioremap_resource(&self, resource: u32) -> =
Result<Devres<IoMem>> {
>> +        self.ioremap_resource_sized::<0>(resource)
>> +    }
>=20
> I guess size zero is special?
>=20

`ioremap_resource_sized` is used when you know the size at compile time. =
Setting SIZE =3D=3D 0
means that you get runtime checks on whether your reads and writes are =
within bounds,
because you will have to use try_read() and try_write() instead of =
read() and write() or your build
will fail.

This is not related to this patch in particular, but to a preceding one =
that introduces struct Io.

We merely expose the same API from Io to users here.

Although I do agree it=E2=80=99s a bit confusing that SIZE 0 is =
special-cased. It took me a while and
several read-throughs to understand what was going on.

Note that it=E2=80=99s common to have to read the size from the DT, so =
deferring to runtime checks
seems to be unavoidable in a lot of cases if we want to have a safe API.

Here=E2=80=99s the relevant code from that commit:

```
+macro_rules! define_write {
+ ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) =3D> {
+ /// Write IO data from a given offset known at compile time.
+ ///
+ /// Bound checks are performed on compile time, hence if the offset is =
not known at compile
+ /// time, the build will fail.
+ $(#[$attr])*
+ #[inline]
+ pub fn $name(&self, value: $type_name, offset: usize) {
+ 	let addr =3D self.io_addr_assert::<$type_name>(offset);
+
+ 	// SAFETY: By the type invariant `addr` is a valid address for =
MMIO operations.
+	 unsafe { bindings::$name(value, addr as _, ) }
+ }
+
+ /// Write IO data from a given offset.
+ ///
+ /// Bound checks are performed on runtime, it fails if the offset =
(plus the type size) is
+ /// out of bounds.
+ $(#[$attr])*
+ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
+ 	let addr =3D self.io_addr::<$type_name>(offset)?;
+
+ 	// SAFETY: By the type invariant `addr` is a valid address for =
MMIO operations.
+ 	unsafe { bindings::$name(value, addr as _) }
+ 	Ok(())
+ }
```

Where,

```
+ #[inline]
+ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
+ 	if !Self::offset_valid::<U>(offset, self.maxsize()) {
+ 		return Err(EINVAL);
+ }
+
+ // Probably no need to check, since the safety requirements of =
`Self::new` guarantee that
+ // this can't overflow.
+ self.base_addr().checked_add(offset).ok_or(EINVAL)
+ }
+ #[inline]
+ fn io_addr_assert<U>(&self, offset: usize) -> usize {
+ 	build_assert!(Self::offset_valid::<U>(offset, SIZE));
+
+ 	self.base_addr() + offset
+ }
```

And

```
+ #[inline]
+ const fn offset_valid<U>(offset: usize, size: usize) -> bool {
+ 	let type_size =3D core::mem::size_of::<U>();
+ 	if let Some(end) =3D offset.checked_add(type_size) {
+ 		end <=3D size && offset % type_size =3D=3D 0
+ 	} else {
+ 		false
+ 	}
+ }
```

>> +    /// Returns the resource len for `resource`, if it exists.
>> +    pub fn resource_len(&self, resource: u32) -> =
Result<bindings::resource_size_t> {
>=20
> Should this just return usize? Should we have a type alias for this =
size type?


I guess usize would indeed be a better fit, if we consider the code =
below:

```
#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

typedef phys_addr_t resource_size_t;

```

>=20
>> +        match self.resource(resource) {
>> +            // SAFETY: if a struct resource* is returned by the =
kernel, it is valid.
>> +            Ok(resource) =3D> Ok(unsafe { =
bindings::resource_size(resource) }),
>> +            Err(e) =3D> Err(e),
>> +        }
>> +    }
>> +
>> +    fn resource(&self, resource: u32) -> Result<*mut =
bindings::resource> {
>> +        // SAFETY: By the type invariants, we know that `self.ptr` =
is non-null and valid.
>> +        let resource =3D unsafe {
>> +            bindings::platform_get_resource(self.as_raw(), =
bindings::IORESOURCE_MEM, resource)
>> +        };
>> +        if !resource.is_null() {
>> +            Ok(resource)
>> +        } else {
>> +            Err(EINVAL)
>> +        }
>> +    }
>> }
>>=20
>> impl AsRef<device::Device> for Device {
>> @@ -215,3 +262,44 @@ fn as_ref(&self) -> &device::Device {
>>         &self.0
>>     }
>> }
>> +
>> +/// A I/O-mapped memory region for platform devices.
>> +///
>> +/// See also [`kernel::pci::Bar`].
>> +pub struct IoMem<const SIZE: usize =3D 0>(Io<SIZE>);
>> +
>> +impl<const SIZE: usize> IoMem<SIZE> {
>> +    /// Creates a new `IoMem` instance.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must make sure that `paddr` is a valid MMIO =
address.
>> +    unsafe fn new(paddr: usize, size: usize) -> Result<Self> {
>=20
> What happens if `size !=3D SIZE`?


```
+impl<const SIZE: usize> Io<SIZE> {
+ ///
+ ///
+ /// # Safety
+ ///
+ /// Callers must ensure that `addr` is the start of a valid I/O mapped =
memory region of size
+ /// `maxsize`.
+ pub unsafe fn new(addr: usize, maxsize: usize) -> Result<Self> {
+ 	if maxsize < SIZE {
+ 		return Err(EINVAL);
+	 }
```

As we=E2=80=99ve seen in the other code snippets I pasted, it=E2=80=99s =
SIZE that is used in the try_read and
try_write checks.

>=20
>> +        // SAFETY: the safety requirements assert that `paddr` is a =
valid MMIO address.
>> +        let addr =3D unsafe { bindings::ioremap(paddr as _, size as =
u64) };
>> +        if addr.is_null() {
>> +            return Err(ENOMEM);
>> +        }
>> +
>> +        // SAFETY: `addr` is guaranteed to be the start of a valid =
I/O mapped memory region of
>> +        // size `size`.
>> +        let io =3D unsafe { Io::new(addr as _, size)? };
>> +
>> +        Ok(IoMem(io))
>> +    }
>> +}
>> +
>> +impl<const SIZE: usize> Drop for IoMem<SIZE> {
>> +    fn drop(&mut self) {
>> +        // SAFETY: Safe as by the invariant of `Io`.
>> +        unsafe { bindings::iounmap(self.0.base_addr() as _) };
>> +    }
>> +}
>> +
>> +impl<const SIZE: usize> Deref for IoMem<SIZE> {
>> +    type Target =3D Io<SIZE>;
>> +
>> +    fn deref(&self) -> &Self::Target {
>> +        &self.0
>> +    }
>> +}
>>=20
>> ---
>> base-commit: 2a5c159f49a5801603af03510c7cef89ff4c9850
>> change-id: 20241023-topic-panthor-rs-platform_io_support-f97aeb2ea887
>>=20
>> Best regards,
>> --
>> Daniel Almeida <daniel.almeida@collabora.com>


=E2=80=94 Daniel


