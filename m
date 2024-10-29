Return-Path: <linux-kernel+bounces-387041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7946B9B4B17
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315C6283CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DED820607F;
	Tue, 29 Oct 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEJI9B2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA70205143;
	Tue, 29 Oct 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209328; cv=none; b=nWLzErLlaziW4taSGWk7acPaaQKSjx3/cHX9OvY6z860y7ub24/wbm8TRa1+OvqwnHYK5aS4tKZ/J+RfAzZdMDDsJ6Wwt8xguQQ3XLX7m9Am4lRxrHvOy/1J3uSCdkMdQ1u6tQPhUmtvzP3ZbEo11RMjEy3c59e+ZE7ZuMzociw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209328; c=relaxed/simple;
	bh=sw3TolEZ3I43vRjBY3K3D57EzWKqjwUKgg8Sef0n3U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DA99PPLpmRV8n0MuCIoHIieAvapqu9fbMPl2UC49shLEm84NjsUEu9Zsd84N1/DVvJ5H5WBs9kK1P80QIBitzO2CvJ9scofacUjRPItRLElFd5+cI6jpv5igOjinlY1YzRHxKU+WxTPO+RrMeE5Je6QCdAu8YRZC3O2PvDJTLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEJI9B2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8C4C4CECD;
	Tue, 29 Oct 2024 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209328;
	bh=sw3TolEZ3I43vRjBY3K3D57EzWKqjwUKgg8Sef0n3U4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OEJI9B2Fyiie60G+QtVoMTHQJhDOfwU3gYBP6VNErNwQkLX8Wo34iquf3unxd9TTj
	 hG+EZ0NcAuAcO+ED18zpkYyLtsl3mn43U3hjAWF8NgJbLqHOkJU1AVdN+wfroOSS0w
	 9HF6Yeuam7FWMFnhmOlk9fVGUm3Au0YbNkcZvBMEKzMsWV2yAu1yjRJci9gCSbOEOf
	 wMHOrEQueIJQROn+ymHwpPO5agqOK2DcZuybJCMJVYDlT1L84FpzaK9ctbJ5X5FsX4
	 VXDyYKXB9oK7cnCo2bjByapuFhyon0bkAra17BZTIdkI6FrrAoE3QkmPaHBv9UNuyK
	 TlBNsad1GwKzQ==
Message-ID: <e713fe2a-df7b-445d-9f2b-08a22161ff8e@kernel.org>
Date: Tue, 29 Oct 2024 14:42:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 4:20 PM, Daniel Almeida wrote:
> The IoMem is backed by ioremap_resource()

ioremap_resource()?

Also, that's a rather short commit message for such a core piece of
infrastructure, can you please expand on this?

> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
> The PCI/Platform abstractions are in-flight and can be found at:
> 
> https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
> ---
>   rust/bindings/bindings_helper.h |  1 +
>   rust/helpers/io.c               | 11 ++++++
>   rust/kernel/platform.rs         | 88 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 100 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 217c776615b9593a2fa921dee130c357dbd96761..90b2d29e7b99f33ceb313b4cc7f8232fef5eed17 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -13,6 +13,7 @@
>   #include <linux/errname.h>
>   #include <linux/ethtool.h>
>   #include <linux/firmware.h>
> +#include <linux/ioport.h>
>   #include <linux/jiffies.h>
>   #include <linux/mdio.h>
>   #include <linux/of_device.h>
> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
> index f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..f708c09c4c87634c56af29ef22ebaa2bf51d82a9 100644
> --- a/rust/helpers/io.c
> +++ b/rust/helpers/io.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include <linux/io.h>
> +#include <linux/ioport.h>
>   
>   u8 rust_helper_readb(const volatile void __iomem *addr)
>   {
> @@ -89,3 +90,13 @@ void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
>   	writeq_relaxed(value, addr);
>   }
>   #endif
> +
> +resource_size_t rust_helper_resource_size(struct resource *res)
> +{
> +	return resource_size(res);
> +}
> +
> +void __iomem *rust_helper_ioremap(resource_size_t addr, unsigned long size)
> +{
> +	return ioremap(addr, size);
> +}
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index addf5356f44f3cf233503aed97f1aa0d32f4f062..d152432c80a4499ead30ddaebe8d87a9679bfa97 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -4,11 +4,15 @@
>   //!
>   //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
>   
> +use core::ops::Deref;
> +
>   use crate::{
>       bindings, container_of, device,
>       device_id::RawDeviceId,
> +    devres::Devres,
>       driver,
>       error::{to_result, Result},
> +    io::Io,
>       of,
>       prelude::*,
>       str::CStr,
> @@ -208,6 +212,49 @@ fn as_raw(&self) -> *mut bindings::platform_device {
>           // embedded in `struct platform_device`.
>           unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
>       }
> +
> +    /// Maps a platform resource through ioremap() where the size is known at
> +    /// compile time.
> +    pub fn ioremap_resource_sized<const SIZE: usize>(
> +        &self,
> +        resource: u32,
> +    ) -> Result<Devres<IoMem<SIZE>>> {
> +        let res = self.resource(resource)?;
> +        let size = self.resource_len(resource)? as usize;
> +
> +        // SAFETY: `res` is guaranteed to be a valid MMIO address and the size
> +        // is given by the kernel as per `self.resource_len()`.
> +        let io = unsafe { IoMem::new(res as _, size) }?;
> +        let devres = Devres::new(self.as_ref(), io, GFP_KERNEL)?;
> +
> +        Ok(devres)
> +    }
> +
> +    /// Maps a platform resource through ioremap().
> +    pub fn ioremap_resource(&self, resource: u32) -> Result<Devres<IoMem>> {
> +        self.ioremap_resource_sized::<0>(resource)
> +    }
> +
> +    /// Returns the resource len for `resource`, if it exists.
> +    pub fn resource_len(&self, resource: u32) -> Result<bindings::resource_size_t> {
> +        match self.resource(resource) {
> +            // SAFETY: if a struct resource* is returned by the kernel, it is valid.
> +            Ok(resource) => Ok(unsafe { bindings::resource_size(resource) }),
> +            Err(e) => Err(e),
> +        }
> +    }
> +
> +    fn resource(&self, resource: u32) -> Result<*mut bindings::resource> {
> +        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
> +        let resource = unsafe {
> +            bindings::platform_get_resource(self.as_raw(), bindings::IORESOURCE_MEM, resource)
> +        };
> +        if !resource.is_null() {
> +            Ok(resource)
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
>   }
>   
>   impl AsRef<device::Device> for Device {
> @@ -215,3 +262,44 @@ fn as_ref(&self) -> &device::Device {
>           &self.0
>       }
>   }
> +
> +/// A I/O-mapped memory region for platform devices.
> +///
> +/// See also [`kernel::pci::Bar`].
> +pub struct IoMem<const SIZE: usize = 0>(Io<SIZE>);

Is this meant to be bus specific, such as `pci::Bar` is PCI specific?

If so, I think it'd be better to pass the platform device and resource index to
`platform::IoMem` (or whatever we want to call it) and let it take care of 
everything.

> +
> +impl<const SIZE: usize> IoMem<SIZE> {
> +    /// Creates a new `IoMem` instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must make sure that `paddr` is a valid MMIO address.
> +    unsafe fn new(paddr: usize, size: usize) -> Result<Self> {
> +        // SAFETY: the safety requirements assert that `paddr` is a valid MMIO address.
> +        let addr = unsafe { bindings::ioremap(paddr as _, size as u64) };

Do we need to consider ioremap_uc(), ioremap_wc(), ioremap_np()?

Also, I think you're missing request_region() here.

> +        if addr.is_null() {
> +            return Err(ENOMEM);
> +        }
> +
> +        // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
> +        // size `size`.
> +        let io = unsafe { Io::new(addr as _, size)? };
> +
> +        Ok(IoMem(io))
> +    }
> +}
> +
> +impl<const SIZE: usize> Drop for IoMem<SIZE> {
> +    fn drop(&mut self) {
> +        // SAFETY: Safe as by the invariant of `Io`.
> +        unsafe { bindings::iounmap(self.0.base_addr() as _) };
> +    }
> +}
> +
> +impl<const SIZE: usize> Deref for IoMem<SIZE> {
> +    type Target = Io<SIZE>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0
> +    }
> +}
> 
> ---
> base-commit: 2a5c159f49a5801603af03510c7cef89ff4c9850
> change-id: 20241023-topic-panthor-rs-platform_io_support-f97aeb2ea887
> 
> Best regards,


