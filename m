Return-Path: <linux-kernel+bounces-432870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3BF9E5144
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA1D163B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC95B1D5ACD;
	Thu,  5 Dec 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thpLbIWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7518E028;
	Thu,  5 Dec 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390832; cv=none; b=fdDNzi6ksLoT3y/R4BziyBYm6HCoGK7a9f/MMka2exuMGyPN44zLJJnD/nFYl31T5okFl1xeEEwgq/BAZq9BnqeyLhmCCdYtDGwiN34pXEAZKvPGMrZmnqsnE34t6d83AnLPIG0vtmt3mgdgAsfi86WOLbwk3qTxL1K7uae9Cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390832; c=relaxed/simple;
	bh=V8mI7/n3IV0EOrdkAGn/fNSLzeaJ+6R5QpFstNb4NVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNVb5Id6NaS8JR+Yfn+FiXa8FdM+vdCmL9voz2yFtbiYq98LvefimPsChgLo/E41petCzExwnRO6NyU2RsIfWc2RyJAjJhjWr70yYZ+cz2sN/OYK/uLjUhnmbvQ4gwyMJ7aaKHJylqKI00IZ6wAFc6R4pytPrJL3ZrQ3W1oceHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thpLbIWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402DDC4CED1;
	Thu,  5 Dec 2024 09:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390831;
	bh=V8mI7/n3IV0EOrdkAGn/fNSLzeaJ+6R5QpFstNb4NVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thpLbIWKkDaAPc6+MQ+KXkXECk4euNpZiSg9r92QVpy0aUzdi6KJZwRq2QvgpQpsL
	 eKbnMlID87GL4NBqOqXWrogAP4AutXgSE+F++RMPkKHWPzIeKEBrIqaQJ7clQOh4x0
	 h53x2RaMsOS9B4dBAMxVvRDEI3Z6T/XtUORRpLtYhP7EGwWgGTlIbKcYKScP+Bc05+
	 V0PchRsvtUgGdppgkhRF69XCGFul2Q5RXt/Om/5jTHKJrx6SiWk8z9ACl9Zsn9tq3+
	 7V6o1QPq6yzjhHnkslavWCO54OZHjeofdyq1nkIislSR4qAsdV3SBcFEaWJW75sQz6
	 m/9ZAcvOSXL5w==
Date: Thu, 5 Dec 2024 09:27:06 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
Message-ID: <20241205092706.GG7451@google.com>
References: <20241204174627.1151288-1-lee@kernel.org>
 <20241204174627.1151288-2-lee@kernel.org>
 <2024120453-unfunded-oversight-5161@gregkh>
 <20241205083848.GD7451@google.com>
 <2024120517-bright-expire-955e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120517-bright-expire-955e@gregkh>

On Thu, 05 Dec 2024, Greg KH wrote:

> On Thu, Dec 05, 2024 at 08:38:48AM +0000, Lee Jones wrote:
> > On Wed, 04 Dec 2024, Greg KH wrote:
> > 
> > > On Wed, Dec 04, 2024 at 05:46:25PM +0000, Lee Jones wrote:
> > > > Expand the complexity of the sample driver by providing the ability to
> > > > get and set an integer.  The value is protected by a mutex.
> > > > 
> > > > Here is a simple userspace program that fully exercises the sample
> > > > driver's capabilities.
> > > > 
> > > > int main() {
> > > >   int value, new_value;
> > > >   int fd, ret;
> > > > 
> > > >   // Open the device file
> > > >   printf("Opening /dev/rust-misc-device for reading and writing\n");
> > > >   fd = open("/dev/rust-misc-device", O_RDWR);
> > > >   if (fd < 0) {
> > > >     perror("open");
> > > >     return errno;
> > > >   }
> > > > 
> > > >   // Make call into driver to say "hello"
> > > >   printf("Calling Hello\n");
> > > >   ret = ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
> > > >   if (ret < 0) {
> > > >     perror("ioctl: Failed to call into Hello");
> > > >     close(fd);
> > > >     return errno;
> > > >   }
> > > > 
> > > >   // Get initial value
> > > >   printf("Fetching initial value\n");
> > > >   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
> > > >   if (ret < 0) {
> > > >     perror("ioctl: Failed to fetch the initial value");
> > > >     close(fd);
> > > >     return errno;
> > > >   }
> > > > 
> > > >   value++;
> > > > 
> > > >   // Set value to something different
> > > >   printf("Submitting new value (%d)\n", value);
> > > >   ret = ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
> > > >   if (ret < 0) {
> > > >     perror("ioctl: Failed to submit new value");
> > > >     close(fd);
> > > >     return errno;
> > > >   }
> > > > 
> > > >   // Ensure new value was applied
> > > >   printf("Fetching new value\n");
> > > >   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
> > > >   if (ret < 0) {
> > > >     perror("ioctl: Failed to fetch the new value");
> > > >     close(fd);
> > > >     return errno;
> > > >   }
> > > > 
> > > >   if (value != new_value) {
> > > >     printf("Failed: Committed and retrieved values are different (%d - %d)\n", value, new_value);
> > > >     close(fd);
> > > >     return -1;
> > > >   }
> > > > 
> > > >   // Call the unsuccessful ioctl
> > > >   printf("Attempting to call in to an non-existent IOCTL\n");
> > > >   ret = ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
> > > >   if (ret < 0) {
> > > >     perror("ioctl: Succeeded to fail - this was expected");
> > > >   } else {
> > > >     printf("ioctl: Failed to fail\n");
> > > >     close(fd);
> > > >     return -1;
> > > >   }
> > > > 
> > > >   // Close the device file
> > > >   printf("Closing /dev/rust-misc-device\n");
> > > >   close(fd);
> > > > 
> > > >   printf("Success\n");
> > > >   return 0;
> > > > }
> > > > 
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > ---
> > > >  samples/rust/rust_misc_device.rs | 82 ++++++++++++++++++++++++--------
> > > >  1 file changed, 62 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> > > > index 5f1b69569ef7..9c041497d881 100644
> > > > --- a/samples/rust/rust_misc_device.rs
> > > > +++ b/samples/rust/rust_misc_device.rs
> > > > @@ -2,13 +2,20 @@
> > > >  
> > > >  //! Rust misc device sample.
> > > >  
> > > > +use core::pin::Pin;
> > > > +
> > > >  use kernel::{
> > > >      c_str,
> > > > -    ioctl::_IO,
> > > > +    ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
> > > >      miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> > > > +    new_mutex,
> > > >      prelude::*,
> > > > +    sync::Mutex,
> > > > +    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
> > > >  };
> > > >  
> > > > +const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('R' as u32, 7);
> > > > +const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('R' as u32, 8);
> > > 
> > > Shouldn't this be 'W'?
> > 
> > No, I don't think so.
> > 
> > 'W' doesn't mean 'write'.  It's supposed to be a unique identifier:
> > 
> > 'W'   00-1F  linux/watchdog.h                                        conflict!
> > 'W'   00-1F  linux/wanrouter.h                                       conflict! (pre 3.9)
> > 'W'   00-3F  sound/asound.h                                          conflict!
> > 'W'   40-5F  drivers/pci/switch/switchtec.c
> > 'W'   60-61  linux/watch_queue.h
> > 
> > 'R' isn't registered for this either:
> > 
> > 'R'   00-1F  linux/random.h                                          conflict!
> > 'R'   01     linux/rfkill.h                                          conflict!
> > 'R'   20-2F  linux/trace_mmap.h
> > 'R'   C0-DF  net/bluetooth/rfcomm.h
> > 'R'   E0     uapi/linux/fsl_mc.h
> > 
> > ... but since this is just example code with no real purpose, I'm going
> > to hold short of registering a unique identifier for it.
> 
> Ah, sorry, I missed that this is the ioctl "name".  As the ptrace people
> will complain, why not use a new one?  Ick, ioctl-number.rst is way out
> of date, but I guess we should carve out one for "sample drivers, do not
> use in anything real" use cases like here.

I can carve one out for Samples.

> > > > +    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
> > > > +        let guard = self.inner.lock();
> > > > +
> > > > +        pr_info!("-> Copying data to userspace (value: {})\n", &guard.value);
> > > > +
> > > > +        writer.write::<i32>(&guard.value)?;
> > > 
> > > What happens if it fails, shouldn't your pr_info() happen after this?
> > 
> > If this fails, I need the line in the log to show where it failed.
> 
> pr_info() doesn't show file lines from what I remember has that changed?
> 
> But wait, this is a misc device, you should be using dev_info() and
> friends here, no pr_*() stuff please.

Looks like no other Rust driver does this, so I would be the first.

I need to figure out how to obtain Device data via these APIs.

Can I put it on the subsequent work priority list _before_ read/write?

> > It says "copying" as in "attempting to copy", rather than "copied".
> 
> Fair enough, but if the copy fails, nothing gets printed out, right?

Not from the kernel, but userspace catches it without issue:

  ioctl: Failed to submit new value: Bad address

This does not appear to be common practice in kernel Rust.

The commonly used ? operator seems to just propagate.

-- 
Lee Jones [李琼斯]

