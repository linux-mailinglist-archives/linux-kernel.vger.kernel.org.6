Return-Path: <linux-kernel+bounces-432760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4EA9E4FE9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78301168AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6CB1D45FE;
	Thu,  5 Dec 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0wOHvRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B001E517;
	Thu,  5 Dec 2024 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387934; cv=none; b=A+SuOjoBCxR3N8eZ7jpqy+6h1FgqiL5blu2qLSQgzkKtsVtxRcNcLbDtEpNZciDZ35UYJu6li0g121SUgCR3uvqSza6ADkzOADG35tphBYtV1KaE6OSgfuoFkGZs1ApxYJW9KP2JDfk706S8VU8mDgGjTw8NXDm7J6Y8w26O1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387934; c=relaxed/simple;
	bh=JVAEKgCjLZWv+v/1SKl7QI67l+o1nSWiq8HMELTmjy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLF5HHCv0GK8/ugd76xRQO9T/F3RPo8nfPRCUC7J2B0JBIL3G8/wMOe2s2khVRv/R1fn8uubO4eWHINU7bsvDqSXI1OHTClzke0HjLZy4+sGSJ4bYWk5Yq1BO1btc7wdXcM3gcnS/FnjkCCoy2CysZjYc48CxHefuVGhN6cCzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0wOHvRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBDDC4CED1;
	Thu,  5 Dec 2024 08:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733387933;
	bh=JVAEKgCjLZWv+v/1SKl7QI67l+o1nSWiq8HMELTmjy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0wOHvRv1pTkAod4h3nKsytdhQipbib4P7RUK3YjiiH+NPGLNJOMTLO4PZssniGMy
	 kWePGJPtUrDVk50oL1zMujfGL5yLv/hx9dsoFdQ/JwidhD1mn6qQyJ/d02Lq9KbMBK
	 aaw1u6U5BLVb8YFml/zTx5Vpew7IpZryl+iuYhOGfhgVhypng/+smVQmWL1CUtwhjs
	 xdRi2Ru+U6fEbv/Prf0tVuj9zGZ8qaeAbsAXu5IHLJTH7/7x3L5csUdrg7ZcrbAYiW
	 Yl3yUnyIwucQfm0WvN6L4pcTKOti7OIzlLFh8OdDf6NlDTG3ADVvXUSEcIQeT1xtuA
	 XazzWsE5ZWSVg==
Date: Thu, 5 Dec 2024 08:38:48 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
Message-ID: <20241205083848.GD7451@google.com>
References: <20241204174627.1151288-1-lee@kernel.org>
 <20241204174627.1151288-2-lee@kernel.org>
 <2024120453-unfunded-oversight-5161@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120453-unfunded-oversight-5161@gregkh>

On Wed, 04 Dec 2024, Greg KH wrote:

> On Wed, Dec 04, 2024 at 05:46:25PM +0000, Lee Jones wrote:
> > Expand the complexity of the sample driver by providing the ability to
> > get and set an integer.  The value is protected by a mutex.
> > 
> > Here is a simple userspace program that fully exercises the sample
> > driver's capabilities.
> > 
> > int main() {
> >   int value, new_value;
> >   int fd, ret;
> > 
> >   // Open the device file
> >   printf("Opening /dev/rust-misc-device for reading and writing\n");
> >   fd = open("/dev/rust-misc-device", O_RDWR);
> >   if (fd < 0) {
> >     perror("open");
> >     return errno;
> >   }
> > 
> >   // Make call into driver to say "hello"
> >   printf("Calling Hello\n");
> >   ret = ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
> >   if (ret < 0) {
> >     perror("ioctl: Failed to call into Hello");
> >     close(fd);
> >     return errno;
> >   }
> > 
> >   // Get initial value
> >   printf("Fetching initial value\n");
> >   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
> >   if (ret < 0) {
> >     perror("ioctl: Failed to fetch the initial value");
> >     close(fd);
> >     return errno;
> >   }
> > 
> >   value++;
> > 
> >   // Set value to something different
> >   printf("Submitting new value (%d)\n", value);
> >   ret = ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
> >   if (ret < 0) {
> >     perror("ioctl: Failed to submit new value");
> >     close(fd);
> >     return errno;
> >   }
> > 
> >   // Ensure new value was applied
> >   printf("Fetching new value\n");
> >   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
> >   if (ret < 0) {
> >     perror("ioctl: Failed to fetch the new value");
> >     close(fd);
> >     return errno;
> >   }
> > 
> >   if (value != new_value) {
> >     printf("Failed: Committed and retrieved values are different (%d - %d)\n", value, new_value);
> >     close(fd);
> >     return -1;
> >   }
> > 
> >   // Call the unsuccessful ioctl
> >   printf("Attempting to call in to an non-existent IOCTL\n");
> >   ret = ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
> >   if (ret < 0) {
> >     perror("ioctl: Succeeded to fail - this was expected");
> >   } else {
> >     printf("ioctl: Failed to fail\n");
> >     close(fd);
> >     return -1;
> >   }
> > 
> >   // Close the device file
> >   printf("Closing /dev/rust-misc-device\n");
> >   close(fd);
> > 
> >   printf("Success\n");
> >   return 0;
> > }
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  samples/rust/rust_misc_device.rs | 82 ++++++++++++++++++++++++--------
> >  1 file changed, 62 insertions(+), 20 deletions(-)
> > 
> > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> > index 5f1b69569ef7..9c041497d881 100644
> > --- a/samples/rust/rust_misc_device.rs
> > +++ b/samples/rust/rust_misc_device.rs
> > @@ -2,13 +2,20 @@
> >  
> >  //! Rust misc device sample.
> >  
> > +use core::pin::Pin;
> > +
> >  use kernel::{
> >      c_str,
> > -    ioctl::_IO,
> > +    ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
> >      miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> > +    new_mutex,
> >      prelude::*,
> > +    sync::Mutex,
> > +    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
> >  };
> >  
> > +const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('R' as u32, 7);
> > +const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('R' as u32, 8);
> 
> Shouldn't this be 'W'?

No, I don't think so.

'W' doesn't mean 'write'.  It's supposed to be a unique identifier:

'W'   00-1F  linux/watchdog.h                                        conflict!
'W'   00-1F  linux/wanrouter.h                                       conflict! (pre 3.9)
'W'   00-3F  sound/asound.h                                          conflict!
'W'   40-5F  drivers/pci/switch/switchtec.c
'W'   60-61  linux/watch_queue.h

'R' isn't registered for this either:

'R'   00-1F  linux/random.h                                          conflict!
'R'   01     linux/rfkill.h                                          conflict!
'R'   20-2F  linux/trace_mmap.h
'R'   C0-DF  net/bluetooth/rfcomm.h
'R'   E0     uapi/linux/fsl_mc.h

... but since this is just example code with no real purpose, I'm going
to hold short of registering a unique identifier for it.

> >  const RUST_MISC_DEV_HELLO: u32 = _IO('R' as u32, 9);
> >  
> >  module! {
> > @@ -40,45 +47,80 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
> >      }
> >  }
> >  
> > -struct RustMiscDevice;
> > +struct Inner {
> > +    value: i32,
> > +}
> >  
> > -impl RustMiscDevice {
> > -    fn new() -> Self {
> > -        Self
> > -    }
> > +#[pin_data(PinnedDrop)]
> > +struct RustMiscDevice {
> > +    #[pin]
> > +    inner: Mutex<Inner>,
> >  }
> >  
> >  #[vtable]
> >  impl MiscDevice for RustMiscDevice {
> > -    type Ptr = KBox<Self>;
> > +    type Ptr = Pin<KBox<Self>>;
> >  
> > -    fn open() -> Result<KBox<Self>> {
> > +    fn open() -> Result<Pin<KBox<Self>>> {
> >          pr_info!("Opening Rust Misc Device Sample\n");
> >  
> > -        Ok(KBox::new(RustMiscDevice::new(), GFP_KERNEL)?)
> > +        KBox::try_pin_init(
> > +            try_pin_init! {
> > +                RustMiscDevice { inner <- new_mutex!( Inner{ value: 0_i32 } )}
> > +            },
> > +            GFP_KERNEL,
> > +        )
> >      }
> >  
> > -    fn ioctl(
> > -        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
> > -        cmd: u32,
> > -        _arg: usize,
> > -    ) -> Result<isize> {
> > +    fn ioctl(device: Pin<&RustMiscDevice>, cmd: u32, arg: usize) -> Result<isize> {
> >          pr_info!("IOCTLing Rust Misc Device Sample\n");
> >  
> > -        match cmd {
> > -            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
> > +        let size = _IOC_SIZE(cmd);
> > +
> > +        let _ = match cmd {
> > +            RUST_MISC_DEV_GET_VALUE => device.get_value(UserSlice::new(arg, size).writer())?,
> > +            RUST_MISC_DEV_SET_VALUE => device.set_value(UserSlice::new(arg, size).reader())?,
> > +            RUST_MISC_DEV_HELLO => device.hello()?,
> >              _ => {
> > -                pr_err!("IOCTL not recognised: {}\n", cmd);
> > +                pr_err!("-> IOCTL not recognised: {}\n", cmd);
> >                  return Err(EINVAL);
> 
> Nit, wrong return value for an invalid ioctl, I missed that in patch 1,
> sorry about that.

Good shout, thanks.

> >              }
> > -        }
> > +        };
> >  
> >          Ok(0)
> >      }
> >  }
> >  
> > -impl Drop for RustMiscDevice {
> > -    fn drop(&mut self) {
> > +#[pinned_drop]
> > +impl PinnedDrop for RustMiscDevice {
> > +    fn drop(self: Pin<&mut Self>) {
> >          pr_info!("Exiting the Rust Misc Device Sample\n");
> >      }
> >  }
> > +
> > +impl RustMiscDevice {
> > +    fn set_value(&self, mut reader: UserSliceReader) -> Result<isize> {
> > +        let new_value = reader.read::<i32>()?;
> > +        let mut guard = self.inner.lock();
> > +
> > +        pr_info!("-> Copying data from userspace (value: {})\n", new_value);
> > +
> > +        guard.value = new_value;
> > +        Ok(0)
> > +    }
> > +
> > +    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
> > +        let guard = self.inner.lock();
> > +
> > +        pr_info!("-> Copying data to userspace (value: {})\n", &guard.value);
> > +
> > +        writer.write::<i32>(&guard.value)?;
> 
> What happens if it fails, shouldn't your pr_info() happen after this?

If this fails, I need the line in the log to show where it failed.

It says "copying" as in "attempting to copy", rather than "copied".

-- 
Lee Jones [李琼斯]

