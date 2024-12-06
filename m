Return-Path: <linux-kernel+bounces-434512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC64F9E67AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3B280EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C531DC74A;
	Fri,  6 Dec 2024 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrdeLKgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535F1DA0E9;
	Fri,  6 Dec 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469181; cv=none; b=qKyyji76H54EX5tv5nKIlnfwK9Qt7PeUWf7j3RhDyn2HfT5Cepy0e9osiIs0/KTdyH8j1hnL6We3VrebTDEo1nF7o8BUaD33unb5Z5S71ExAO0e4Sl7kLzSBcClrU1nWFH347TFEM7a6NNmXd5r3Yiz6wZtQJfti0DBBdV8Xlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469181; c=relaxed/simple;
	bh=E7BtaM4w2sZ9Ofgw+4DsejwJANfQSqIJgDgyOLUYe1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxbPkrOpQdJrWl7rgRo1Rb54qb8I7FyVvAivJMZYvBvvfzdYZuyirwScutaiH7XR4Juy2IDg/j9WD1wfPjJtBCbadlzUu9HRu4Qxel2ooQW0Okup1nQvbWV45/9WaIvss8ycmC40IiRWyI0umeaFCJXqt0+U/2+L7GIG/dLLTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrdeLKgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F350FC4CED1;
	Fri,  6 Dec 2024 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733469181;
	bh=E7BtaM4w2sZ9Ofgw+4DsejwJANfQSqIJgDgyOLUYe1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrdeLKgv1bEVeuse7guIYPKovP0S68PQMjxNy2EFpm0F3o62fXiv8/JLVo7kel+w/
	 3Ap8tIwqwGhC1aAcEM2RLP1xYkxhlcJxZ3GwRO9lBgED7GvgmKDa1GZ/yFrpf+18b8
	 tF2KiCVq1stc4XLD3bYVS6HQXOkgX85MM0sEJ/4LFXk24BN+tyuJ1ACn5pEneEeYQe
	 vsQ6UYYFxAxgWqyAMB/93KuMvZ6Nv2At7U5IYNcM2uBGQE2ffvlLuY/xBviRvz62Qt
	 l8+SDqZRR79s/LDiCoV6KtE/ia0ow+BohgBYRRMh+QyXyafHqcZux4qVwsQZfy0+yS
	 x4LIgCeD8fYaA==
Date: Fri, 6 Dec 2024 07:12:56 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <20241206071256.GB8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
 <2024120642-trend-omnivore-69d3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120642-trend-omnivore-69d3@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Thu, Dec 05, 2024 at 04:25:20PM +0000, Lee Jones wrote:
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
> >  samples/rust/rust_misc_device.rs | 80 ++++++++++++++++++++++++++++++++
> >  3 files changed, 91 insertions(+)
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
> > index 000000000000..f50925713f1a
> > --- /dev/null
> > +++ b/samples/rust/rust_misc_device.rs
> > @@ -0,0 +1,80 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
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
> > +#[vtable]
> > +impl MiscDevice for RustMiscDevice {
> > +    type Ptr = KBox<Self>;
> > +
> > +    fn open() -> Result<KBox<Self>> {
> > +        pr_info!("Opening Rust Misc Device Sample\n");
> > +
> > +        Ok(KBox::new(RustMiscDevice, GFP_KERNEL)?)
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
> > +                return Err(ENOIOCTLCMD);
> 
> To quote errno.h:
> 	These should never be seen by user programs
> 
> The correct value here is ENOTTY.
> 
> Yeah, fun stuff.  Not intuitive at all, sorry.

I read the instructions in: Documentation/driver-api/ioctl.rst

"When the ioctl callback is called with an unknown command number, the
 handler returns either -ENOTTY or -ENOIOCTLCMD, which also results in
 -ENOTTY being returned from the system call. Some subsystems return
 -ENOSYS or -EINVAL here for historic reasons, but this is wrong."

This makes it sound like the system call itself converts one to the
other.  Either way, I'll make the change.  Thanks.

-- 
Lee Jones [李琼斯]

