Return-Path: <linux-kernel+bounces-447298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3399F3036
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA8316779F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB8B2063E8;
	Mon, 16 Dec 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwolusgn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215E204C3A;
	Mon, 16 Dec 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351018; cv=none; b=coghqzoN8KQBhlYaGThVn1bYx2l+lXeJCjfoCx+7zBt0cPfuK48EDJIYPixinShuz6AATolzjgshGIicOHhAydZ+oa3p4XAMGUUU038p3RBIkLaIAGl9yt1v2ErwaZxd4s/ttR6gD+pyF7zVIxW8qPLhxdIz/ENNWTdjKH3mRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351018; c=relaxed/simple;
	bh=LdSIFjD47tQgAxT9afpdkg48p86bnJwIHfThv+l32Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH8uKU3thfAxYPXnhEES3/qyPpDaG7UHkKH84JvaEcvNSX5BDGG1gV5eWUMYE/ShHhE+3auE/mbMkr3r6jiBHcC4e8PLeG7KXGVu1cV/O3mF1tq7LbIhM7KdWv/LqMb39vrfvBM7L73+89MTGWVlia6BaBLzP8qBJOb8zlmUltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwolusgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFE3C4CED0;
	Mon, 16 Dec 2024 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734351016;
	bh=LdSIFjD47tQgAxT9afpdkg48p86bnJwIHfThv+l32Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwolusgnc436/vJQ4fOdagVoRYmUSm63K3JcDfwquIrF9q6Lrjg0KF6bTIIdy0vGX
	 GVj+raA/6qyNrQg0hF5RoLcN98yPGNGBJuxhJXEhLHYY8sNDbwJ4B7JmhUw3ReMe6u
	 dRGi2QYOBV5DGEvRyU8PB5DjvPXj+Qy4WSkGRQJ3EzQeJ/za+KafZvsNljFkiE32pz
	 FrET+PMmBTyo3Jxi5WzRzpcbKoQgrhRe2XZL9EdZ2rfyOkXCnSpAUPpdEtlS74/GIq
	 4/N60wW+SZMNM463wa7ZUWMvnnDKVv1LdMiwvdUpT0soUiBUXW5Z9E6s8pvpinE9Yq
	 iLBI2jB/DrNJQ==
Date: Mon, 16 Dec 2024 13:10:10 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v6 2/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <Z2AYoi6QvepL0m0r@cassiopeiae>
References: <20241213134715.601415-1-lee@kernel.org>
 <20241213134715.601415-3-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213134715.601415-3-lee@kernel.org>

On Fri, Dec 13, 2024 at 01:47:07PM +0000, Lee Jones wrote:
> This sample driver demonstrates the following basic operations:
> 
> * Register a Misc Device
> * Create /dev/rust-misc-device
> * Provide open call-back for the aforementioned character device
> * Operate on the character device via a simple ioctl()
> * Provide close call-back for the character device
> 
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> ---
>  samples/rust/Kconfig             | 10 ++++
>  samples/rust/Makefile            |  1 +
>  samples/rust/rust_misc_device.rs | 87 ++++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
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
> index 000000000000..324c3696ae3f
> --- /dev/null
> +++ b/samples/rust/rust_misc_device.rs
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Rust misc device sample.
> +
> +use kernel::{
> +    c_str,
> +    device::Device,
> +    fs::File,
> +    ioctl::_IO,
> +    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> +    prelude::*,
> +    types::ARef,
> +};
> +
> +const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 0x80);
> +
> +module! {
> +    type: RustMiscDeviceModule,
> +    name: "rust_misc_device",
> +    author: "Lee Jones",
> +    description: "Rust misc device sample",
> +    license: "GPL",
> +}
> +
> +#[pin_data]
> +struct RustMiscDeviceModule {
> +    #[pin]
> +    _miscdev: MiscDeviceRegistration<RustMiscDevice>,
> +}
> +
> +impl kernel::InPlaceModule for RustMiscDeviceModule {
> +    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
> +        pr_info!("Initialising Rust Misc Device Sample\n");
> +
> +        let options = MiscDeviceOptions {
> +            name: c_str!("rust-misc-device"),
> +        };
> +
> +        try_pin_init!(Self {
> +            _miscdev <- MiscDeviceRegistration::register(options),
> +        })
> +    }
> +}
> +
> +struct RustMiscDevice {
> +    dev: ARef<Device>,
> +}
> +
> +#[vtable]
> +impl MiscDevice for RustMiscDevice {
> +    type Ptr = KBox<Self>;
> +
> +    fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<KBox<Self>> {
> +        let dev = ARef::from(misc.device());
> +
> +        dev_info!(dev, "Opening Rust Misc Device Sample\n");
> +
> +        Ok(KBox::new(RustMiscDevice { dev }, GFP_KERNEL)?)
> +    }
> +
> +    fn ioctl(
> +        me: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
> +        _file: &File,
> +        cmd: u32,
> +        _arg: usize,
> +    ) -> Result<isize> {
> +        dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
> +
> +        match cmd {
> +            RUST_MISC_DEV_HELLO => dev_info!(me.dev, "Hello from the Rust Misc Device\n"),
> +            _ => {
> +                dev_err!(me.dev, "-> IOCTL not recognised: {}\n", cmd);
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
> +        dev_info!(self.dev, "Exiting the Rust Misc Device Sample\n");
> +    }
> +}
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
> 

