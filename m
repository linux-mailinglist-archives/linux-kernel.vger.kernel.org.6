Return-Path: <linux-kernel+bounces-408227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EA9C7C49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BE9284B68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA2A205E10;
	Wed, 13 Nov 2024 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kHpGnyYB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDA171C9;
	Wed, 13 Nov 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527018; cv=pass; b=UxV16OEXPIk5fn22wKT829cyFHtTpjOqJMI0F+BiO7UfQCWxk3uqSA+3CIGzZXkV4Lxc85nJXEzs5V/TlghtX86zsl31cnnJ1lXreFhfgHet23JnrFsakO+jh88kyEcZYXcByiMIaDMCgbrq62QbGg0Qf+s2wVHKTg0XpKDcLvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527018; c=relaxed/simple;
	bh=ku1HtL50zBLNcDCpdQ7odL+fLST4Y4RSiIlJpkmcPnQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HBQSGVwWQ3xdXvPF9F66u0aAABIMoh8H1BWcz6kZNlFXGnEH53HFK3SOyjyl0Pr2HBX8Ka5YpgNrHwD5a0MKY38IInJdsISEaI8PDTsPHWT62hjkv7l9BVxP8lCXipUo1gdgjeWE3rrIhz1MtwmnlgYb96a8awv8PLGnvs20DQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=kHpGnyYB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731526997; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QACySsWRqoPkqLzf/d8eVOTiREYD8XE5OyIZWBNJX47Qo58utqpSc3vN0c07wPJGsEYn2BRiOB2sT5b7JHMJiT66TKcy7s6uI9wq+1lbU2svFBTQ18SpVfUd0lz7DfEVxISp1VrohvEQkILE+IRL7HfAM1ec/o59amnLZGBLGQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731526997; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pt0aH1Cv0KId6vLqu1CTlaUPEuxQC4UC25oqRdRFG3g=; 
	b=firK4b1TmhBGjP3s/OJeugL4FnoJarB5CaVws9R7DoMWdlWbVzDKnXerkiBIkIVGba6lzWVsKqL5DYRb9SAQD1DYtQqPwzrQ9EssQYRcc3WJJm+cw4/dMYzhBhYHs3s3sT6jLwrfIuVLFc8Mfc1nfBSf5w7+J6MTBQII0Njahqw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731526997;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=pt0aH1Cv0KId6vLqu1CTlaUPEuxQC4UC25oqRdRFG3g=;
	b=kHpGnyYBThHTm/uzajnnoX8Bmz17VjXykG4r8CGVlHsG9GDRNHqu98QL8NsAHDaz
	6XGaRY0G73qi5eCZZxI1AReiDPd92Vg+l3NBI3zer49RFMBXsqrkf5dXKw9r4qE7BQO
	EpLdsPTSds4SDXyt84KE0wJr9d/nFh0UJtvPhCX4=
Received: by mx.zohomail.com with SMTPS id 1731526995311171.71973113681167;
	Wed, 13 Nov 2024 11:43:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v2] rust: platform: add Io support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20241113-topic-panthor-rs-platform_io_support-v2-1-0dea1edc3a49@collabora.com>
Date: Wed, 13 Nov 2024 16:42:59 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Daniel Stone <daniels@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C6A62A2-B723-4066-9466-C3F0F9FB4B3F@collabora.com>
References: <20241113-topic-panthor-rs-platform_io_support-v2-1-0dea1edc3a49@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi all, hopefully I did not butcher anything using b4 this time.

See one question from me below.

> On 13 Nov 2024, at 16:30, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
> Add support for iomem regions by providing a struct IoMem abstraction
> for the platform bus. This will request a memory region and remap it
> into a kernel virtual address using ioremap(). The underlying reads =
and
> writes are performed by struct Io, which is itself embedded in Iomem.
> This is the equivalent of pci::Bar for the platform bus.
>=20
> Memory-mapped I/O devices are common, and this patch offers a way to
> program them in Rust, usually by reading and writing to their
> memory-mapped register set.
>=20
> Both sized and unsized versions are exposed. Sized allocations use
> `ioremap_resource_sized` and specify their size at compile time. =
Reading
> and writing to IoMem is infallible in this case and no extra runtime
> checks are performed. Unsized allocations have to check the offset
> against the regions's max length at runtime and so return Result.
>=20
> Lastly, like pci::Bar, platform::IoMem uses the Devres abstraction to
> revoke access to the region if the device is unbound or the underlying
> resource goes out of scope.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
> This series depend on the v3 of PCI/Platform abstractions
>=20
> The PCI/Platform abstractions are in-flight and can be found at:
>=20
> https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
> ---
> Changes in v2:
> - reworked the commit message
> - added missing request_mem_region call (Thanks Alice, Danilo)
> - IoMem::new() now takes the platform::Device, the resource number and
>  the name, instead of an address and a size (thanks, Danilo)
> - Added a new example for both sized and unsized versions of IoMem.
> - Compiled the examples using kunit.py (thanks for the tip, Alice!)
> - Removed instances of `foo as _`. All `as` casts now spell out the =
actual
>  type.
> - Now compiling with CLIPPY=3D1 (I realized I had forgotten, sorry)
> - Rebased on top of rust-next to check for any warnings given the new
>  unsafe lints.
> - Link to v1: =
https://lore.kernel.org/r/20241024-topic-panthor-rs-platform_io_support-v1=
-1-3d1addd96e30@collabora.com
> ---
> rust/bindings/bindings_helper.h |   1 +
> rust/helpers/io.c               |  22 ++++++
> rust/kernel/platform.rs         | 149 =
++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 172 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index =
217c776615b9593a2fa921dee130c357dbd96761..90b2d29e7b99f33ceb313b4cc7f8232f=
ef5eed17 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -13,6 +13,7 @@
> #include <linux/errname.h>
> #include <linux/ethtool.h>
> #include <linux/firmware.h>
> +#include <linux/ioport.h>
> #include <linux/jiffies.h>
> #include <linux/mdio.h>
> #include <linux/of_device.h>
> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
> index =
f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..0d31552d5f90e69b8132725a958813d4=
ab8bd9fa 100644
> --- a/rust/helpers/io.c
> +++ b/rust/helpers/io.c
> @@ -1,6 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0
>=20
> #include <linux/io.h>
> +#include <linux/ioport.h>
>=20
> u8 rust_helper_readb(const volatile void __iomem *addr)
> {
> @@ -89,3 +90,24 @@ void rust_helper_writeq_relaxed(u64 value, volatile =
void __iomem *addr)
> writeq_relaxed(value, addr);
> }
> #endif
> +
> +resource_size_t rust_helper_resource_size(struct resource *res)
> +{
> + return resource_size(res);
> +}
> +
> +void __iomem *rust_helper_ioremap(resource_size_t addr, unsigned long =
size)
> +{
> + return ioremap(addr, size);
> +}
> +
> +struct resource *rust_helper_request_mem_region(resource_size_t =
start, resource_size_t n,
> +    const char *name)
> +{
> + return request_mem_region(start, n, name);
> +}
> +
> +void rust_helper_release_mem_region(resource_size_t start, =
resource_size_t n)
> +{
> + release_mem_region(start, n);
> +}
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index =
addf5356f44f3cf233503aed97f1aa0d32f4f062..a6e676e0b983fea2dc2090563a138b1c=
c365a97d 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -4,11 +4,15 @@
> //!
> //! C header: =
[`include/linux/platform_device.h`](srctree/include/linux/platform_device.=
h)
>=20
> +use core::ops::Deref;
> +
> use crate::{
>     bindings, container_of, device,
>     device_id::RawDeviceId,
> +    devres::Devres,
>     driver,
>     error::{to_result, Result},
> +    io::Io,
>     of,
>     prelude::*,
>     str::CStr,
> @@ -208,6 +212,47 @@ fn as_raw(&self) -> *mut =
bindings::platform_device {
>         // embedded in `struct platform_device`.
>         unsafe { container_of!(self.0.as_raw(), =
bindings::platform_device, dev) }.cast_mut()
>     }
> +
> +    /// Maps a platform resource through ioremap() where the size is =
known at
> +    /// compile time.
> +    pub fn ioremap_resource_sized<const SIZE: usize>(
> +        &self,
> +        num: u32,
> +        name: &CStr,
> +    ) -> Result<Devres<IoMem<SIZE>>> {
> +        // SAFETY: `res` is guaranteed to be a valid MMIO address and =
the size
> +        // is given by the kernel as per `self.resource_len()`.
> +        let io =3D unsafe { IoMem::new(self, num, name) }?;
> +        let devres =3D Devres::new(self.as_ref(), io, GFP_KERNEL)?;
> +
> +        Ok(devres)
> +    }
> +
> +    /// Maps a platform resource through ioremap().
> +    pub fn ioremap_resource(&self, resource: u32, name: &CStr) -> =
Result<Devres<IoMem>> {
> +        self.ioremap_resource_sized::<0>(resource, name)
> +    }
> +
> +    /// Returns the resource len for `resource`, if it exists.
> +    pub fn resource_len(&self, resource: u32) -> =
Result<bindings::resource_size_t> {
> +        match self.resource(resource) {
> +            // SAFETY: if a struct resource* is returned by the =
kernel, it is valid.
> +            Ok(resource) =3D> Ok(unsafe { =
bindings::resource_size(resource) }),
> +            Err(e) =3D> Err(e),
> +        }
> +    }
> +
> +    pub(crate) fn resource(&self, resource: u32) -> Result<*mut =
bindings::resource> {
> +        // SAFETY: By the type invariants, we know that `self.ptr` is =
non-null and valid.
> +        let resource =3D unsafe {
> +            bindings::platform_get_resource(self.as_raw(), =
bindings::IORESOURCE_MEM, resource)
> +        };
> +        if !resource.is_null() {
> +            Ok(resource)
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> }

Should this return an immutable reference instead of a pointer?

Once the pointer is known not to be null, I think it should. So far, =
this
is the only place in the kernel crate calling `platform_get_resource`, =
so
there would be no risk of breaking the reference rules and it would make
the API more ergonomic to use.

>=20
> impl AsRef<device::Device> for Device {
> @@ -215,3 +260,107 @@ fn as_ref(&self) -> &device::Device {
>         &self.0
>     }
> }
> +
> +/// A I/O-mapped memory region for platform devices.
> +///
> +/// See also [`kernel::pci::Bar`].
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{bindings, c_str, platform};
> +///
> +/// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
> +///     let offset =3D 42; // Some offset.
> +///
> +///     // If the size is known at compile time, use =
`ioremap_resource_sized`.
> +///     // No runtime checks will apply when reading and writing.
> +///     let iomem =3D pdev.ioremap_resource_sized::<42>(0, =
c_str!("my-device"))?;
> +///
> +///     // Read and write a 32-bit value at `offset`. Calling =
`try_access()` on
> +///     // the `Devres` makes sure that the resource is still valid.
> +///     let data =3D iomem.try_access().ok_or(ENODEV)?.readl(offset);
> +///
> +///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
> +///
> +///     // Unlike `ioremap_resource_sized`, here the size of the =
memory region
> +///     // is not known at compile time, so only the `try_read*` and =
`try_write*`
> +///     // family of functions are exposed, leading to runtime checks =
on every
> +///     // access.
> +///     let iomem =3D pdev.ioremap_resource(0, c_str!("my-device"))?;
> +///
> +///     let data =3D =
iomem.try_access().ok_or(ENODEV)?.try_readl(offset)?;
> +///
> +///     iomem.try_access().ok_or(ENODEV)?.try_writel(data, offset)?;
> +///
> +///     # Ok::<(), Error>(())
> +/// }
> +/// ```
> +///
> +pub struct IoMem<const SIZE: usize =3D 0>(Io<SIZE>);
> +
> +impl<const SIZE: usize> IoMem<SIZE> {
> +    /// Creates a new `IoMem` instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must make sure that `paddr` is a valid MMIO =
address.
> +    unsafe fn new(pdev: &Device, num: u32, name: &CStr) -> =
Result<Self> {
> +        let size =3D pdev.resource_len(num)?;
> +        if size =3D=3D 0 {
> +            return Err(ENOMEM);
> +        }
> +
> +        let res =3D pdev.resource(num)?;
> +
> +        // SAFETY: `res` is guaranteed to be a valid pointer to a =
`struct
> +        // resource` as per the semantics of =
`bindings::platform_get_resource()`
> +        let res_start =3D unsafe { *res }.start;
> +
> +        // SAFETY:
> +        // - `res_start` is guaranteed to be a valid MMIO address.
> +        // - `size` is known not to be zero at this point.
> +        // - `name` is a valid C string.
> +        let mem_region =3D
> +            unsafe { bindings::request_mem_region(res_start, size, =
name.as_char_ptr()) };
> +        if mem_region.is_null() {
> +            return Err(EBUSY);
> +        }
> +
> +        // SAFETY:
> +        // - `res_start` is guaranteed to be a valid MMIO address.
> +        // - `size` is known not to be zero at this point.
> +        let addr =3D unsafe { bindings::ioremap(res_start, size) };
> +        if addr.is_null() {
> +            // SAFETY:
> +            // - `res_start` is guaranteed to be a valid MMIO =
address.
> +            // - `size` is the same as the one passed to =
`request_mem_region`.
> +            unsafe { bindings::release_mem_region(res_start, size) };
> +            return Err(ENOMEM);
> +        }
> +
> +        // SAFETY: `addr` is guaranteed to be the start of a valid =
I/O mapped memory region of
> +        // size `size`.
> +        let io =3D unsafe { Io::new(addr as usize, size.try_into()?)? =
};
> +
> +        Ok(IoMem(io))
> +    }
> +}
> +
> +impl<const SIZE: usize> Drop for IoMem<SIZE> {
> +    fn drop(&mut self) {
> +        // SAFETY: Safe as by the invariant of `Io`.
> +        unsafe { bindings::release_mem_region(self.0.base_addr() as =
u64, self.0.maxsize() as u64) }
> +
> +        // SAFETY: Safe as by the invariant of `Io`.
> +        unsafe { bindings::iounmap(self.0.base_addr() as *mut =
core::ffi::c_void) }
> +    }
> +}
> +
> +impl<const SIZE: usize> Deref for IoMem<SIZE> {
> +    type Target =3D Io<SIZE>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0
> +    }
> +}
>=20
> ---
> base-commit: 2a5c159f49a5801603af03510c7cef89ff4c9850
> change-id: 20241023-topic-panthor-rs-platform_io_support-f97aeb2ea887
>=20
> Best regards,
> --=20
> Daniel Almeida <daniel.almeida@collabora.com>
>=20

=E2=80=94 Daniel


