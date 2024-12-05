Return-Path: <linux-kernel+bounces-432895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406C29E51A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EC52821B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934591D63EE;
	Thu,  5 Dec 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF79G41m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB11D5174;
	Thu,  5 Dec 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391977; cv=none; b=g+P3gXOlo58m8ln1bXSP1XiwG1Tc9Q5ZjeOgYcaOSsfsyRyJ1K9NERokj3kKbucjlPOJhzalRzjVwCklVqXrBtZlbXgeaLPd0lKkt4B1oKlIXhiJRknMvpx+mJ/a9AX3YmK81tTHegD0TitcLVIP6QUKJ+lJ/btXPQm4fkCj8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391977; c=relaxed/simple;
	bh=uBYY7dTJxOCr0fjZS/JNFk/KYTbEh3BXVvsjq7nWa9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meaXDJw6yDfFPwGPC1dOOGADzPAypS/HpFDjISYgUt7xOmqdu0p0OE/GQq1SpJf/jSQAQlfHml5mY0MTiYKCGMJtSSVmO4LFun933B80tIiqgPZFmPN6+z5PWpS21pgYZkumMc31CmUc2Kpby49oSeBsxRI4t8MmnAyyGIkchto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF79G41m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62BCC4CED6;
	Thu,  5 Dec 2024 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733391976;
	bh=uBYY7dTJxOCr0fjZS/JNFk/KYTbEh3BXVvsjq7nWa9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eF79G41mh7sQlLr0KChsB1lMjNA6S1EYA20jZfvhFj+sLYHhRsSwjeAWYibbvgLya
	 ROG6LTDaVL0fI9V8KUUYGFOFlzrqZX7pn1JPlwB4KLjUj2RQXuS/3nrqePXDI63yrp
	 5TmzvDnfkghFjzMe1LOOmrzUlcu9zLGJ2kIFg+VhPOmzkWaW81Q8FxrO/Yq5U2vK2N
	 20IwLiWn0UzMnkNVhYBrgiX1LmeSLnyTUYrR4ZUG11vblb+C7XJBP6vnEfr+7WK++K
	 e8kFB0rfEgxPE7hv3LWK6Z5XJ1Ow4nvRgY1WZC5FMEVqDBD9MIh0wBsL8LZwB3XYNg
	 5fCRE1WjVsolQ==
Date: Thu, 5 Dec 2024 09:46:10 +0000
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt?= du Garreau <benoit@dugarreau.fr>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <20241205094610.GH7451@google.com>
References: <20241204174627.1151288-1-lee@kernel.org>
 <20241205092135.48978-1-benoit@dugarreau.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205092135.48978-1-benoit@dugarreau.fr>

On Thu, 05 Dec 2024, Benoît du Garreau wrote:

> On Wed, 4 Dec 2024 17:46:24 +0000 Lee Jones <lee@kernel.org> wrote:
> 
> > This sample driver demonstrates the following basic operations:
> >
> > * Register a Misc Device
> > * Create /dev/rust-misc-device
> > * Open the aforementioned character device
> > * Operate on the character device via a simple ioctl()
> > * Close the character device
> >
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  samples/rust/Kconfig             | 10 ++++
> >  samples/rust/Makefile            |  1 +
> >  samples/rust/rust_misc_device.rs | 84 ++++++++++++++++++++++++++++++++
> >  3 files changed, 95 insertions(+)
> >  create mode 100644 samples/rust/rust_misc_device.rs
> >
> > diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> > index b0f74a81c8f9..df384e679901 100644
> > --- a/samples/rust/Kconfig
> > +++ b/samples/rust/Kconfig
> > @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
> >
> >  	  If unsure, say N.
> >
> > +config SAMPLE_RUST_MISC_DEVICE
> > +	tristate "Misc device"
> > +	help
> > +	  This option builds the Rust misc device.
> > +
> > +	  To compile this as a module, choose M here:
> > +	  the module will be called rust_misc_device.
> > +
> > +	  If unsure, say N.
> > +
> >  config SAMPLE_RUST_PRINT
> >  	tristate "Printing macros"
> >  	help
> > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > index c1a5c1655395..ad4b97a98580 100644
> > --- a/samples/rust/Makefile
> > +++ b/samples/rust/Makefile
> > @@ -2,6 +2,7 @@
> >  ccflags-y += -I$(src)				# needed for trace events
> >
> >  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> > +obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
> >  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> >
> >  rust_print-y := rust_print_main.o rust_print_events.o
> > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> > new file mode 100644
> > index 000000000000..5f1b69569ef7
> > --- /dev/null
> > +++ b/samples/rust/rust_misc_device.rs
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Rust misc device sample.
> > +
> > +use kernel::{
> > +    c_str,
> > +    ioctl::_IO,
> > +    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> > +    prelude::*,
> > +};
> > +
> > +const RUST_MISC_DEV_HELLO: u32 = _IO('R' as u32, 9);
> > +
> > +module! {
> > +    type: RustMiscDeviceModule,
> > +    name: "rust_misc_device",
> > +    author: "Lee Jones",
> > +    description: "Rust misc device sample",
> > +    license: "GPL",
> > +}
> > +
> > +struct RustMiscDeviceModule {
> > +    _miscdev: Pin<KBox<MiscDeviceRegistration<RustMiscDevice>>>,
> > +}
> > +
> > +impl kernel::Module for RustMiscDeviceModule {
> 
> This could probably use `kernel::InPlaceModule` and avoid allocating
> the registration.

Is there a way to do this and keep the print?

> > +    fn init(_module: &'static ThisModule) -> Result<Self> {
> > +        pr_info!("Initialising Rust Misc Device Sample\n");
> > +
> > +        let options = MiscDeviceOptions {
> > +            name: c_str!("rust-misc-device"),
> > +        };
> > +
> > +        Ok(Self {
> > +            _miscdev: KBox::pin_init(
> > +                MiscDeviceRegistration::<RustMiscDevice>::register(options),
> > +                GFP_KERNEL,
> > +            )?,
> > +        })
> > +    }
> > +}
> > +
> > +struct RustMiscDevice;
> > +
> > +impl RustMiscDevice {
> > +    fn new() -> Self {
> > +        Self
> > +    }
> > +}
> 
> Given that this function is nearly empty and removed in the next commit,
> it could probably not exist in the first place.

This is showing my Rust immaturity here.

How does one create a new Self without new() in this context?

> > +
> > +#[vtable]
> > +impl MiscDevice for RustMiscDevice {
> > +    type Ptr = KBox<Self>;
> > +
> > +    fn open() -> Result<KBox<Self>> {
> > +        pr_info!("Opening Rust Misc Device Sample\n");
> > +
> > +        Ok(KBox::new(RustMiscDevice::new(), GFP_KERNEL)?)
> > +    }
> > +
> > +    fn ioctl(
> > +        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
> > +        cmd: u32,
> > +        _arg: usize,
> > +    ) -> Result<isize> {
> > +        pr_info!("IOCTLing Rust Misc Device Sample\n");
> > +
> > +        match cmd {
> > +            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
> > +            _ => {
> > +                pr_err!("IOCTL not recognised: {}\n", cmd);
> > +                return Err(EINVAL);
> > +            }
> > +        }
> > +
> > +        Ok(0)
> > +    }
> > +}
> > +
> > +impl Drop for RustMiscDevice {
> > +    fn drop(&mut self) {
> > +        pr_info!("Exiting the Rust Misc Device Sample\n");
> > +    }
> > +}
> > --
> > 2.47.0.338.g60cca15819-goog
> 
> 
> Benoît du Garreau

-- 
Lee Jones [李琼斯]

