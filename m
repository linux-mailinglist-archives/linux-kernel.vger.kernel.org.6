Return-Path: <linux-kernel+bounces-344071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8FB98A3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9261A1F27B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6418F2FF;
	Mon, 30 Sep 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WvXtww8Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9C41A84;
	Mon, 30 Sep 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701214; cv=none; b=r60glU1mrknQ0edAw55INI2cHMCY4syrEyvoAPzG9yGS3srth42YLxYQFAZ2gCCaHHCU2VFOyCdiye9ovIIhvNkQpmZbDp0ME/Q8FZSjpByibjg5w/JPqkKrjGnutvxyJrbaVtS2Q23UcG+FrM6OzaFefWIVH446yOxBIVxNYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701214; c=relaxed/simple;
	bh=alX16+TngjNUUW1BU65HouL7lyi2z88wPghZMl73xq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhS0U1IRAFYJl05XGBZ/FJubgNd1DYnB78/7rbvzby3s2THXa494eBRgFAmj2a6uutNE2yQBuYzzrCMNeYg6HnCiKA6rTkOQOUfNWqoRi+T7qGPlS8rf+uc03N6b8QUwtiyo37njI32lL29cWO0Cn3vUDOoMb81b5YGp6zPP2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WvXtww8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B474C4CEC7;
	Mon, 30 Sep 2024 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727701214;
	bh=alX16+TngjNUUW1BU65HouL7lyi2z88wPghZMl73xq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvXtww8Zimt6Zhg/+60hwoDi8h6IYa6jfUgcD6i+ktZXMeXif1Uf+cWgPiHsoZsEe
	 35bitjOxm2vbEX9Nl0UyhIt0Ddjq54Ru+X6cQRvPDleWHUH29O4pRXkBupiKetCLjY
	 DhmfimVOAQiFo1d8+JU2jcdLceBE102zqVxNFHN4=
Date: Mon, 30 Sep 2024 15:00:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] device: rust: change the name function
Message-ID: <2024093055-rickety-shut-4a8c@gregkh>
References: <20240930123957.49181-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930123957.49181-1-trintaeoitogc@gmail.com>

On Mon, Sep 30, 2024 at 09:39:55AM -0300, Guilherme Giacomo Simoes wrote:
> Why did I make this change?
> This function "Device::from_raw()" increments the refcount by this command "bindings::get_device(prt)". This can be confused because the function Arc::from_raw() from the standard library, doesn't increment the refcount.
> 
> This discussion is in
> https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E
> 
> The options can be:
> 1) Rename the function for don't make confusing with the Arc::from_raw().
> 2) Remove this function and use the unsafe { Device::as_ref(ptr) }.into() when I need the get pointer for the device.
> 
> Proposed solution
> I like the first option. Because, how was will commented by Boqun Feng , when the people write the "unsafe { Device::as_ref(ptr) }.into()" again, again and again... inevitably anybody will create a help function for this.
> 
> Then I think that we should rename this function for Device::get_from_raw() or maybe Device::get_device() and I like more of the second option because, this will be equal the get_device() function that already exists in .c code.
> 
> 
> How do I test this:
> I create this simple file in sample/rust/device.rs
> """"""""
> use kernel::device::Device;
> use kernel::prelude::*;
> use kernel::types::ARef;
> 
> module! {
>     type: DeviceTest,
>     name: "device_test",
>     author: "Test device",
>     description: "A simple module for test device",
>     license: "GPL",
> }
> 
> struct DeviceTest;
> 
> impl kernel::Module for DeviceTest {
>     fn init(_module: &'static ThisModule) -> Result<Self> {
>         pr_info!("initial device test");
>         let device = create_and_get_device();
>         pr_info!("device created");
> 
>         Ok(DeviceTest)
>     }
> }
> 
> impl Drop for DeviceTest {
>     fn drop(&mut self) {
>         pr_info!("bye bye driver test");
>     }
> }
> 
> fn create_and_get_device() -> ARef<Device> {
>     let device = unsafe { Device::get_device(core::ptr::null_mut()) };
>     device
> }
> """"""""
> 
> I set this in Kconfig
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index b0f74a81c8f9..7779969e7dd6 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -37,4 +37,9 @@ config SAMPLE_RUST_HOSTPROGS
> 
>           If unsure, say N.
> 
> +config SAMPLE_DEVICE_TEST
> +       tristate "Device test"
> +       help
> +               This option is for device test
> +
>  endif # SAMPLES_RUST
> 
> 
> and in Makefile
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 03086dabbea4..85a8b30100e7 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -2,5 +2,6 @@
> 
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)              += rust_minimal.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)                        += rust_print.o
> +obj-$(CONFIG_SAMPLE_DEVICE_TEST)                       += device.o
> 
>  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)         += hostprogs
> 
> 
> Then I enable this in menu config... compile the kernel e run this in a qemu:
> qemu-system-x86_64 -kernel bzImage -initrd initramfs.img -m 2G -machine q35 -device ich9-ahci,id=sata -drive id=disk,file=rootfs.img,if=none,format=raw -device ide-hd,drive=disk,bus=sata.0 -append "root=/dev/sda console=ttyS0" -nographic -monitor telnet:127.0.0.1:5555,server,nowai
> 
> the expected print is showing
> [    2.786174] device_test: initial device test
> [    2.786541] device_test: device created
> 
> 
> Guilherme Giacomo Simoes (1):
>   device: rust: change the name function
> 
>  rust/kernel/device.rs   | 2 +-
>  rust/kernel/firmware.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.46.2
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

