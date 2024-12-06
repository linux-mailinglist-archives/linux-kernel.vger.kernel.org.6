Return-Path: <linux-kernel+bounces-434715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51609E6A14
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1593018848EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840561F12E1;
	Fri,  6 Dec 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2JYy2jj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62891E1022;
	Fri,  6 Dec 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477357; cv=none; b=gUV14L+y+v5zfVosODhF8k6EXECFrCXLaC+nMNubBKsLmPohL1ZKIJ3K+GgFRHy9fFsk6C1l7/I+Glt3rFbCUD5h6GjAlfsIS6FrwQcNU15HhxXbfYHu1pq5dzIuMixhCiJKyPvZXwkl0EoyTYSKORM6c//RvMn5/NIFgfvzy4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477357; c=relaxed/simple;
	bh=bDttRsnyVJw/ISB0XyqLGm2dkQcrbpIOGlqcwn0yjps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+4ayfGU3oT9fLlGkf19Q6wDMO01GtzTBGUHZLcjZYdvOos1IiFe7/qSaH07NhpyfC2AIBNh9hMiL+RV5v6jP3Ww0D5L0caJMuF4ybRjk+Laq4oa7LPWLHtkDqHdXyZ+BprQapjfSZtOJMbpqGV2h6hCPE30sRvA9HNF4kWm2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2JYy2jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E8AC4CED1;
	Fri,  6 Dec 2024 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733477356;
	bh=bDttRsnyVJw/ISB0XyqLGm2dkQcrbpIOGlqcwn0yjps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2JYy2jjS/gVqj16h3fI9c7eMU3tb10aK/4TxGX4rAqd36KHCnHKmbTxfSvFXp1FT
	 AMN897nnw62yg2/AbTb+oXq7zjR1dlWRwj6QJdJH5O9zCZZDtvIXBTAuqUOuqj1KHC
	 0aDBgInEPyx5uD9lIgp9ZddMzwcZd4WoeciUmmCjANY6I8YSIUBRSes/QuLvjyS03H
	 QB0qd4Fo+v0/0QK+GMavbQPaezcC0aYzCyB7WVDeE6PTfI6pqQTv864Vb+ON0rP6y+
	 TIl1KtT9FQnMmHb9NtdRKAQcoulrBqWdL6ecr6meCPRVcs6Ku6Lpy0h5QdXdvNAQyP
	 3QF50eQBKG6HA==
Date: Fri, 6 Dec 2024 10:29:07 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 2/4] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <Z1LD42UsCvtAhluY@pollux>
References: <20241206090515.752267-1-lee@kernel.org>
 <20241206090515.752267-5-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206090515.752267-5-lee@kernel.org>

On Fri, Dec 06, 2024 at 09:05:06AM +0000, Lee Jones wrote:
> This sample driver demonstrates the following basic operations:
> 
> * Register a Misc Device
> * Create /dev/rust-misc-device
> * Provide open call-back for the aforementioned character device
> * Operate on the character device via a simple ioctl()
> * Provide close call-back for the character device
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  samples/rust/Kconfig             | 10 ++++
>  samples/rust/Makefile            |  1 +
>  samples/rust/rust_misc_device.rs | 80 ++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 samples/rust/rust_misc_device.rs
> 
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index b0f74a81c8f9..df384e679901 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_RUST_MISC_DEVICE
> +	tristate "Misc device"
> +	help
> +	  This option builds the Rust misc device.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_misc_device.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_PRINT
>  	tristate "Printing macros"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index c1a5c1655395..ad4b97a98580 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -2,6 +2,7 @@
>  ccflags-y += -I$(src)				# needed for trace events
>  
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> +obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>  
>  rust_print-y := rust_print_main.o rust_print_events.o
> diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> new file mode 100644
> index 000000000000..3837532d259e
> --- /dev/null
> +++ b/samples/rust/rust_misc_device.rs
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Rust misc device sample.
> +
> +use kernel::{
> +    c_str,
> +    ioctl::_IO,
> +    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> +    prelude::*,
> +};
> +
> +const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 9);
> +
> +module! {
> +    type: RustMiscDeviceModule,
> +    name: "rust_misc_device",
> +    author: "Lee Jones",
> +    description: "Rust misc device sample",
> +    license: "GPL",
> +}
> +
> +struct RustMiscDeviceModule {
> +    _miscdev: Pin<KBox<MiscDeviceRegistration<RustMiscDevice>>>,
> +}
> +
> +impl kernel::Module for RustMiscDeviceModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Initialising Rust Misc Device Sample\n");
> +
> +        let options = MiscDeviceOptions {
> +            name: c_str!("rust-misc-device"),
> +        };
> +
> +        Ok(Self {
> +            _miscdev: KBox::pin_init(
> +                MiscDeviceRegistration::<RustMiscDevice>::register(options),
> +                GFP_KERNEL,
> +            )?,
> +        })

Since this v4 was sent just when I was commenting on v3:

Why do we add examples where we ask people to allocate those structures with
kmalloc()?

`MiscDevice` should switch to the generic `Registration` type in [1] and use
`InPlaceModule`, such that those structures land in the .data section of the
binary.

[1] https://lore.kernel.org/rust-for-linux/20241205141533.111830-3-dakr@kernel.org/

> +    }
> +}
> +
> +struct RustMiscDevice;
> +
> +#[vtable]
> +impl MiscDevice for RustMiscDevice {
> +    type Ptr = KBox<Self>;
> +
> +    fn open() -> Result<KBox<Self>> {
> +        pr_info!("Opening Rust Misc Device Sample\n");

This should be `dev_info!`, but I see why you don't have access to the device
structure here...

@Greg: How do miscdev drivers do this in C? I looked at a couple of them, but
all of those seem to use pr_* macros. They can't get the device pointer from
the inode or file pointer.

However, C drivers could refer to the struct miscdevice directly since it's
almost always a static variable in the file scope.

In Rust we do the static allocation part with `InPlaceModule` as mentioned
above. However, this still doesn't let us refer to the underlying struct
miscdevice.

This all would be much cleaner if there'd be a "fake" probe() callback for a
struct miscdevice. This way we could perfectly align the miscdevice abstraction
with the abstractions for all other drivers, such as PCI, platform, etc.

- Danilo

> +
> +        Ok(KBox::new(RustMiscDevice, GFP_KERNEL)?)
> +    }
> +
> +    fn ioctl(
> +        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
> +        cmd: u32,
> +        _arg: usize,
> +    ) -> Result<isize> {
> +        pr_info!("IOCTLing Rust Misc Device Sample\n");
> +
> +        match cmd {
> +            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
> +            _ => {
> +                pr_err!("IOCTL not recognised: {}\n", cmd);
> +                return Err(ENOTTY);
> +            }
> +        }
> +
> +        Ok(0)
> +    }
> +}
> +
> +impl Drop for RustMiscDevice {
> +    fn drop(&mut self) {
> +        pr_info!("Exiting the Rust Misc Device Sample\n");
> +    }
> +}
> -- 
> 2.47.0.338.g60cca15819-goog
> 
> 

