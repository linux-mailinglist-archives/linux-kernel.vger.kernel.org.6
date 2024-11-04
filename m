Return-Path: <linux-kernel+bounces-395498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934879BBEC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EC3281599
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977891E570C;
	Mon,  4 Nov 2024 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="inI3xzpn"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B81C876D;
	Mon,  4 Nov 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751924; cv=pass; b=jEx5Ez6DHB3+UnY1P7AxrfsmNTCALPZzagTZLZPds6y7eCSVH5VmBFMjb91cDQS6nuqS3IGjzyDtUKfSHMh3VOu66oifTO4SmmEkD8ot6kufTFN7RJTD6BrhLbCI+k2zJzQggn1p37BdTN2PS1/FATyLhnkdrb7Wck1Lkz1kCaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751924; c=relaxed/simple;
	bh=IgH0Hi9twoxRqlIfhGMWyNWOyhNYrOjcFQdTclRMvXE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FlLSZ9IXwxhJMLIKP7zCTGLZepj2LcX4ahfpPJYY4zk12C0iBDuUBH95Ux++csgadwwsjW/iWpHAb+bQVr/GYnzZ+bPwktWCy7UygfbeH4j2O5xs/For4jYj8c3Pt96HHPilKRp7Ix0FJdtNIRhCN4YkFuWPqPU8VbxN4TKxMU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=inI3xzpn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730751905; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RWD5eQlrw8bowUcvX/gJOsiJsblWBq/XADeT9X9WiKWgjg+mj72NPCKqAK+uQqpMzhFLRPcbKZvmTnxH4lJT2hCMVmj/y9hqIK+qz4AciRzP+TSRhhSYo+mqAfvVQZtJtk0+xZkTMYGXbER2bCNichNAp15QmsWO3+VYbYNY2k4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730751905; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s6jThQfUMqEvoXJre/xevuEPnTumQrVzYHlNzE7HSCg=; 
	b=jO3N8QDcxONa5yMwzlCB/Han4ldGnTOlldkRpRnNWh1SMi5K1xDbASylrFdGbbXI/Vn4x6MzHMo/ZSQEP68r63qy3qtS4mFjebc+Lo18z9yP+7n3zD3xSvKhWlPXcUT6MY/izJleiwlnL/7/i3wIxumfrC8UdXL/Hzyn67CUxX4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730751905;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=s6jThQfUMqEvoXJre/xevuEPnTumQrVzYHlNzE7HSCg=;
	b=inI3xzpnP77TZuLN8ymkamrYQpT/kLvVWk86ceryQtvhCCaRGeaT2UWm979jVLLO
	THXkhrt0YxlxlrtCo6nCgn8ncXF9709UbaL2FYyxsifwt1Gdpfy3JnDbbABjMmfOC7n
	SUkY3fiM+wY40fvBiLBJzmZZkXgl0tGbC6N5ctZs=
Received: by mx.zohomail.com with SMTPS id 1730751904089317.91208057147844;
	Mon, 4 Nov 2024 12:25:04 -0800 (PST)
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
In-Reply-To: <e713fe2a-df7b-445d-9f2b-08a22161ff8e@kernel.org>
Date: Mon, 4 Nov 2024 17:24:48 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <738E8478-D2B8-4A25-9FEE-41D31C50DB4C@collabora.com>
References: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
 <e713fe2a-df7b-445d-9f2b-08a22161ff8e@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Danilo, thanks for the review!

> On 29 Oct 2024, at 10:42, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On 10/24/24 4:20 PM, Daniel Almeida wrote:
>> The IoMem is backed by ioremap_resource()
>=20
> ioremap_resource()?

Yeah, a small mixup with the similarly named `devm_ioremap_resource`.

Thanks for catching that.

>=20
> Also, that's a rather short commit message for such a core piece of
> infrastructure, can you please expand on this?
>=20
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> ---
>> The PCI/Platform abstractions are in-flight and can be found at:
>> https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
>> ---
>>  rust/bindings/bindings_helper.h |  1 +
>>  rust/helpers/io.c               | 11 ++++++
>>  rust/kernel/platform.rs         | 88 =
+++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 100 insertions(+)
>> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
>> index =
217c776615b9593a2fa921dee130c357dbd96761..90b2d29e7b99f33ceb313b4cc7f8232f=
ef5eed17 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -13,6 +13,7 @@
>>  #include <linux/errname.h>
>>  #include <linux/ethtool.h>
>>  #include <linux/firmware.h>
>> +#include <linux/ioport.h>
>>  #include <linux/jiffies.h>
>>  #include <linux/mdio.h>
>>  #include <linux/of_device.h>
>> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
>> index =
f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..f708c09c4c87634c56af29ef22ebaa2b=
f51d82a9 100644
>> --- a/rust/helpers/io.c
>> +++ b/rust/helpers/io.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>    #include <linux/io.h>
>> +#include <linux/ioport.h>
>>    u8 rust_helper_readb(const volatile void __iomem *addr)
>>  {
>> @@ -89,3 +90,13 @@ void rust_helper_writeq_relaxed(u64 value, =
volatile void __iomem *addr)
>>   writeq_relaxed(value, addr);
>>  }
>>  #endif
>> +
>> +resource_size_t rust_helper_resource_size(struct resource *res)
>> +{
>> + return resource_size(res);
>> +}
>> +
>> +void __iomem *rust_helper_ioremap(resource_size_t addr, unsigned =
long size)
>> +{
>> + return ioremap(addr, size);
>> +}
>> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
>> index =
addf5356f44f3cf233503aed97f1aa0d32f4f062..d152432c80a4499ead30ddaebe8d87a9=
679bfa97 100644
>> --- a/rust/kernel/platform.rs
>> +++ b/rust/kernel/platform.rs
>> @@ -4,11 +4,15 @@
>>  //!
>>  //! C header: =
[`include/linux/platform_device.h`](srctree/include/linux/platform_device.=
h)
>>  +use core::ops::Deref;
>> +
>>  use crate::{
>>      bindings, container_of, device,
>>      device_id::RawDeviceId,
>> +    devres::Devres,
>>      driver,
>>      error::{to_result, Result},
>> +    io::Io,
>>      of,
>>      prelude::*,
>>      str::CStr,
>> @@ -208,6 +212,49 @@ fn as_raw(&self) -> *mut =
bindings::platform_device {
>>          // embedded in `struct platform_device`.
>>          unsafe { container_of!(self.0.as_raw(), =
bindings::platform_device, dev) }.cast_mut()
>>      }
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
>> +
>> +        // SAFETY: `res` is guaranteed to be a valid MMIO address =
and the size
>> +        // is given by the kernel as per `self.resource_len()`.
>> +        let io =3D unsafe { IoMem::new(res as _, size) }?;
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
>> +
>> +    /// Returns the resource len for `resource`, if it exists.
>> +    pub fn resource_len(&self, resource: u32) -> =
Result<bindings::resource_size_t> {
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
>>  }
>>    impl AsRef<device::Device> for Device {
>> @@ -215,3 +262,44 @@ fn as_ref(&self) -> &device::Device {
>>          &self.0
>>      }
>>  }
>> +
>> +/// A I/O-mapped memory region for platform devices.
>> +///
>> +/// See also [`kernel::pci::Bar`].
>> +pub struct IoMem<const SIZE: usize =3D 0>(Io<SIZE>);
>=20
> Is this meant to be bus specific, such as `pci::Bar` is PCI specific?

Yes.

> If so, I think it'd be better to pass the platform device and resource =
index to
> `platform::IoMem` (or whatever we want to call it) and let it take =
care of everything.

Ack.

>=20
>> +
>> +impl<const SIZE: usize> IoMem<SIZE> {
>> +    /// Creates a new `IoMem` instance.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must make sure that `paddr` is a valid MMIO =
address.
>> +    unsafe fn new(paddr: usize, size: usize) -> Result<Self> {
>> +        // SAFETY: the safety requirements assert that `paddr` is a =
valid MMIO address.
>> +        let addr =3D unsafe { bindings::ioremap(paddr as _, size as =
u64) };
>=20
> Do we need to consider ioremap_uc(), ioremap_wc(), ioremap_np()?

Do you guys need it for Nova? Maybe we can return different types =
depending on
which ioremap function was called.

>=20
> Also, I think you're missing request_region() here.

That=E2=80=99s true

>=20
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
>> ---
>> base-commit: 2a5c159f49a5801603af03510c7cef89ff4c9850
>> change-id: 20241023-topic-panthor-rs-platform_io_support-f97aeb2ea887
>> Best regards,
>=20
>=20

=E2=80=94 Daniel


