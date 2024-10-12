Return-Path: <linux-kernel+bounces-362425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99799B4D8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AEC2834E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91B176AA5;
	Sat, 12 Oct 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJDe4Ysv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A911E481;
	Sat, 12 Oct 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728736658; cv=none; b=MhYT93jOSn6mfVzMv6ThHaIDUCLBNAgRU9K4EfgTHA+A/3X4WZVN4rMzKa1FAeE2Qxm70FlVls8+heigPiCKUuKGlLjCgcRnIoC2a6BjDKR2mPSvzikCJJFI7O485cW+lGco3m++eYwysl9yZA36fwIWLO/+rxthFXQJHX780+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728736658; c=relaxed/simple;
	bh=JHv4viOqJSZDxqWiMtnrCdy5tH/5QrH6R1LyFfppnC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgGI/49zrvtSu79T2w3Z4MJxbYFt4Wqpc079AsN9H3fIDKBeflqnEorZVTfv1jKPjby5ebxC1i1spsQiqGsQg+XvEwJegT1XeY9RFQ0ycnOzULnAw115n7cIZmP0dH2/Fb2QlmosOAE5tN6tZla4VzXOhBM2sRomn7Sq2+teKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dJDe4Ysv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476EAC4CEC6;
	Sat, 12 Oct 2024 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728736657;
	bh=JHv4viOqJSZDxqWiMtnrCdy5tH/5QrH6R1LyFfppnC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJDe4Ysv5G5OPVY0bdd0/oer1bcvGXuFL+5Em2YT0B3L1L+RAitVtr5mYbAY/X6QX
	 sKW33xVZIWbX+7fuWgLcnp1qmBgTih1Uwohdr0+3ikq47/OCnVg0aRpo03GvFgBKXh
	 5eV8ir3ia8oBVawFpGax9Bz1833roHXC2iGg9HFw=
Date: Sat, 12 Oct 2024 14:37:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Josef Zoller <josef@walterzollerpiano.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] samples: rust: add character device sample
Message-ID: <2024101222-theatrics-enrich-ba21@gregkh>
References: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
 <20241011-rust-char-dev-v1-3-350225ae228b@walterzollerpiano.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-rust-char-dev-v1-3-350225ae228b@walterzollerpiano.com>

On Fri, Oct 11, 2024 at 08:55:44PM +0200, Josef Zoller wrote:
> Provide a sample implementation of a character device in Rust, following
> the scull device from the well-known book "Linux Device Drivers".
> 
> This sample uses the abstractions from the previous patches in this
> series to implement the scull device in mostly safe Rust. All of the
> unsafe code comes from the fact that the data structure used in the C
> implementation is inherently unsafe and cannot easily be represented in
> safe Rust without a lot of memory overhead.
> 
> This sample should be a good starting point for people who want to start
> writing kernel code in Rust, as a character device is relatively simple
> and does not require a lot of kernel knowledge to understand.
> 
> Signed-off-by: Josef Zoller <josef@walterzollerpiano.com>
> ---
>  samples/rust/Kconfig          |  10 +
>  samples/rust/Makefile         |   1 +
>  samples/rust/rust_char_dev.rs | 506 ++++++++++++++++++++++++++++++++++++++++++

This feels like it could be a lot smaller, 500 lines for a sample char
driver seems excessive.

> --- /dev/null
> +++ b/samples/rust/rust_char_dev.rs
> @@ -0,0 +1,506 @@
> +// SPDX-License-Identifier: GPL-2.0

Again, copyright notice please.

> +
> +//! Rust character device sample.
> +//!
> +//! This sample demonstrates how to create a simple character device in Rust,
> +//! by reimplementing the `scull` device from the Linux Device Drivers book.
> +
> +use core::{mem, ptr::NonNull};
> +
> +use kernel::{
> +    c_str,
> +    char_dev::{CharDevice, CharDeviceID, DeviceRegistration, OpenCharDevice, Whence},
> +    fs::{file::flags, File, LocalFile},
> +    new_mutex,
> +    prelude::*,
> +    sync::{Arc, Mutex},
> +    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
> +};
> +
> +module! {
> +    type: RustCharDevModule,
> +    name: "rust_char_dev",
> +    author: "Rust for Linux Contributors",
> +    description: "Rust character device sample",
> +    license: "GPL",
> +}
> +
> +const DEVICE_NAME: &CStr = c_str!("rust_scull");
> +const DEFAULT_QSET_SIZE: usize = 1000;
> +const DEFAULT_QUANTUM_SIZE: usize = 4000;
> +const NUM_DEVS: usize = 4;

Comments for what these const are for?

> +// This is probably too specific a function to be in the Rust standard library...
> +trait OptionExt<T> {
> +    fn get_or_try_insert_with<F, E>(&mut self, f: F) -> Result<&mut T, E>
> +    where
> +        F: FnOnce() -> Result<T, E>;
> +}
> +
> +impl<T> OptionExt<T> for Option<T> {
> +    fn get_or_try_insert_with<F, E>(&mut self, f: F) -> Result<&mut T, E>
> +    where
> +        F: FnOnce() -> Result<T, E>,
> +    {
> +        if self.is_none() {
> +            *self = Some(f()?);
> +        }
> +
> +        Ok(self.as_mut().unwrap())
> +    }
> +}

What are these for?  No comments makes it confusing to me :)

> +
> +#[derive(IoctlCommand)]
> +#[ioctl(code = b'k')]
> +enum Command {
> +    Reset,                       // 0
> +    SetQuantum(UserSliceReader), // 1
> +    SetQset(UserSliceReader),    // 2
> +    TellQuantum(u64),            // 3
> +    TellQset(u64),               // 4
> +    GetQuantum(UserSliceWriter), // 5
> +    GetQset(UserSliceWriter),    // 6
> +    QueryQuantum,                // 7
> +    QueryQset,                   // 8
> +    ExchangeQuantum(UserSlice),  // 9
> +    ExchangeQset(UserSlice),     // 10
> +    ShiftQuantum(u64),           // 11
> +    ShiftQset(u64),              // 12
> +}

Trying to keep ioctl numbers identical from kernel/userspace means they
should go in a .h file, putting them here is not going to work well.

> +// We implement `ScullQset` as close as possible to the `struct scull_qset` implementation from
> +// the book. This means that we have to use raw pointers and some unsafe code for the data.

That's not a good idea overall, why not look at the "untrusted data"
patch on the list and tie that into here so that things are not unsafe?
That is ideally what we want to do for ALL rust user/kernel interfaces.

> +// Otherwise, we'd have massive memory overhead by storing sizes/capacities unnecessarily.
> +// E.g. every `ScullQset` would be 8 * qset_size bytes larger if we used `Box<[_]>` and
> +// 16 * qset_size bytes larger if we used `Vec<_>`.
> +// However, the knowledge that all data arrays are of the same size isn't possible to express
> +// in safe Rust without this memory overhead.
> +struct ScullQset {
> +    data: Option<NonNull<Option<NonNull<u8>>>>,
> +    quantum_size: usize,
> +    qset_size: usize,
> +    next: Option<Box<ScullQset>>,
> +}

I'm sorry, I don't understand why this is so odd and has to be "unsafe".
It's just chunks of memory read from userspace.  And we do have a list
structure somewhere (or something like that), that probably works better
than the next pointer from what I recall.

> +impl ScullQset {
> +    fn new(quantum_size: usize, qset_size: usize) -> Self {
> +        Self {
> +            data: None,
> +            quantum_size,
> +            qset_size,
> +            next: None,
> +        }
> +    }
> +
> +    /// Returns a reference to the quantum at index `i` if it exists.
> +    fn get_quantum(&self, i: usize) -> Option<&[u8]> {
> +        let data_slice = NonNull::slice_from_raw_parts(self.data?, self.qset_size);
> +        // SAFETY: `data_slice` points to a valid slice of `Option<NonNull<u8>>`.
> +        let quantum = unsafe { data_slice.as_ref()[i] };
> +        let quantum_slice = NonNull::slice_from_raw_parts(quantum?, self.quantum_size);
> +        // SAFETY: `quantum_slice` points to a valid slice of `u8`.
> +        Some(unsafe { quantum_slice.as_ref() })
> +    }
> +
> +    /// Returns a mutable reference to the quantum at index `i`, allocating it first if necessary.
> +    fn get_quantum_mut(&mut self, i: usize) -> Option<&mut [u8]> {
> +        let data = self
> +            .data
> +            .get_or_try_insert_with(|| {
> +                let mut data =
> +                    mem::ManuallyDrop::new(Vec::with_capacity(self.qset_size, GFP_KERNEL)?);
> +                for _ in 0..self.qset_size {
> +                    data.push(None, GFP_KERNEL)?;
> +                }
> +
> +                assert!(data.len() == data.capacity());
> +
> +                // SAFETY: `data.as_mut_ptr()` is non-null.
> +                Ok::<_, Error>(unsafe { NonNull::new_unchecked(data.as_mut_ptr()) })
> +            })
> +            .ok()?;
> +
> +        let mut data_slice = NonNull::slice_from_raw_parts(*data, self.qset_size);
> +
> +        // SAFETY: `data_slice` points to a valid slice of `Option<NonNull<u8>>`.
> +        let maybe_quantum = unsafe { &mut data_slice.as_mut()[i] };
> +        let quantum = maybe_quantum
> +            .get_or_try_insert_with(|| {
> +                let mut quantum =
> +                    mem::ManuallyDrop::new(Vec::with_capacity(self.quantum_size, GFP_KERNEL)?);
> +                for _ in 0..self.quantum_size {
> +                    quantum.push(0, GFP_KERNEL)?;
> +                }
> +
> +                assert!(quantum.len() == quantum.capacity());
> +
> +                // SAFETY: `quantum.as_mut_ptr()` is non-null.
> +                Ok::<_, Error>(unsafe { NonNull::new_unchecked(quantum.as_mut_ptr()) })
> +            })
> +            .ok()?;
> +
> +        let mut quantum_slice = NonNull::slice_from_raw_parts(*quantum, self.quantum_size);
> +        // SAFETY: `quantum_slice` points to a valid slice of `u8`.
> +        Some(unsafe { quantum_slice.as_mut() })
> +    }
> +}
> +
> +impl Drop for ScullQset {
> +    fn drop(&mut self) {
> +        if let Some(data) = self.data.take() {
> +            // SAFETY: `data` was created by `Vec::with_capacity` with a capacity of `qset_size`.
> +            let data_vec =
> +                unsafe { Vec::from_raw_parts(data.as_ptr(), self.qset_size, self.qset_size) };
> +
> +            for quantum in data_vec {
> +                let Some(quantum) = quantum else { continue };
> +
> +                // SAFETY: `quantum` was created by `Vec::with_capacity` with a capacity of
> +                // `quantum_size`.
> +                let _ = unsafe {
> +                    Vec::from_raw_parts(quantum.as_ptr(), self.quantum_size, self.quantum_size)
> +                };
> +            }
> +        }
> +    }
> +}
> +
> +// SAFETY: The raw pointers are uniquely owned by `ScullQset` and not shared, so it's safe to send
> +// it to another thread.
> +unsafe impl Send for ScullQset {}

What other thread are you sending this to?

I don't see any "threads" here in the driver, do you mean "can be shared
by different userspace processes"?

> +struct ScullDevInner {
> +    data: Option<Box<ScullQset>>,
> +    quantum_size: usize,
> +    qset_size: usize,
> +    size: usize,
> +}
> +
> +impl Default for ScullDevInner {
> +    fn default() -> Self {
> +        Self {
> +            data: None,
> +            quantum_size: DEFAULT_QUANTUM_SIZE,
> +            qset_size: DEFAULT_QSET_SIZE,
> +            size: 0,
> +        }
> +    }
> +}
> +
> +impl ScullDevInner {
> +    fn trim(&mut self) {
> +        mem::take(&mut self.data);
> +        self.size = 0;
> +    }
> +
> +    fn follow(&mut self, n: usize) -> Option<&mut ScullQset> {
> +        let mut qs = self
> +            .data
> +            .get_or_try_insert_with(|| {
> +                Box::new(
> +                    ScullQset::new(self.quantum_size, self.qset_size),
> +                    GFP_KERNEL,
> +                )
> +            })
> +            .ok()?;
> +
> +        for _ in 0..n {
> +            qs = qs
> +                .next
> +                .get_or_try_insert_with(|| {
> +                    // We use `qs.quantum_size` and `qs.qset_size` here to avoid subtly
> +                    // different behavior from the original C implementation.
> +                    // If we used the sizes from `self`, we could end up with differently
> +                    // sized qsets in the linked list (which would not be a safety problem).
> +                    // Like this, we only use an updated size after `trim` has been called,
> +                    // which is the same behavior as in the book.
> +                    Box::new(ScullQset::new(qs.quantum_size, qs.qset_size), GFP_KERNEL)

As one of the authors of the book in reference here, I really don't
understand this at all :)

What am I missing?  Why is this so complex?

You don't have to follow the implementation identically, just because
something is simple to do in C doesn't mean you have to do the same
thing in rust at all.  We just implemented stuff to make the concepts
simple to follow, not to implement something specific that was trying to
solve a real problem here.  So try to keep it simple, I think there are
other examples of rust char drivers in other trees that might be better
to use as an example, as this complexity probably isn't needed and will
just confuse new people (i.e. me!) more than is needed.

> +                })
> +                .ok()?;
> +        }
> +
> +        Some(qs)
> +    }
> +}
> +
> +#[derive(Clone)]
> +struct ScullDev {
> +    inner: Arc<Mutex<ScullDevInner>>,
> +}
> +
> +#[vtable]
> +impl CharDevice for ScullDev {
> +    type OpenPtr = Box<Self>;
> +    type Err = Error;
> +
> +    fn new(_dev_id: CharDeviceID) -> Result<Self> {
> +        Ok(Self {
> +            inner: Arc::pin_init(new_mutex!(ScullDevInner::default()), GFP_KERNEL)?,
> +        })
> +    }
> +
> +    fn open(&self, file: &File) -> Result<Self::OpenPtr> {
> +        if file.flags() & flags::O_ACCMODE == flags::O_WRONLY {
> +            // TODO: this should be lock_interruptible, but that's not in the Rust API yet

I think patches for that are floating around, right?

> +            self.inner.lock().trim();
> +        }
> +
> +        Ok(Box::new(self.clone(), GFP_KERNEL)?)
> +    }
> +}
> +
> +#[vtable]
> +impl OpenCharDevice for ScullDev {
> +    type IoctlCmd = Command;
> +    type Err = Error;
> +
> +    fn read(&self, _file: &LocalFile, mut buf: UserSliceWriter, offset: &mut i64) -> Result<usize> {
> +        let pos = usize::try_from(*offset).map_err(|_| EINVAL)?;
> +
> +        // TODO: this should be lock_interruptible, but that's not in the Rust API yet
> +        let mut inner = self.inner.lock();
> +
> +        // To keep the behavior of the original C implementation, namely that the quantum and qset
> +        // sizes are only updated after a trim, we use the sizes from the inner data if it exists.
> +        let (quantum_size, qset_size) = inner
> +            .data
> +            .as_ref()
> +            .map_or((inner.quantum_size, inner.qset_size), |qs| {
> +                (qs.quantum_size, qs.qset_size)
> +            });
> +        let item_size = quantum_size * qset_size;
> +
> +        if pos >= inner.size {
> +            return Ok(0);
> +        }
> +
> +        let mut count = buf.len().min(inner.size - pos);
> +        let item = pos / item_size;
> +        let rest = pos % item_size;
> +        let s_pos = rest / quantum_size;
> +        let q_pos = rest % quantum_size;
> +
> +        let Some(q) = inner.follow(item).and_then(|qs| qs.get_quantum(s_pos)) else {
> +            return Ok(0);
> +        };
> +
> +        count = count.min(quantum_size - q_pos);
> +
> +        buf.write_slice(&q[q_pos..q_pos + count])?;
> +
> +        *offset += count as i64;
> +
> +        Ok(count)
> +    }
> +
> +    fn write(
> +        &self,
> +        _file: &LocalFile,
> +        mut buf: UserSliceReader,
> +        offset: &mut i64,
> +    ) -> Result<usize> {
> +        let pos = usize::try_from(*offset).map_err(|_| EINVAL)?;
> +
> +        // TODO: this should be lock_interruptible, but that's not in the Rust API yet
> +        let mut inner = self.inner.lock();
> +
> +        // To keep the behavior of the original C implementation, namely that the quantum and qset
> +        // sizes are only updated after a trim, we use the sizes from the inner data if it exists.
> +        let (quantum_size, qset_size) = inner
> +            .data
> +            .as_ref()
> +            .map_or((inner.quantum_size, inner.qset_size), |qs| {
> +                (qs.quantum_size, qs.qset_size)
> +            });
> +        let item_size = quantum_size * qset_size;
> +
> +        let item = pos / item_size;
> +        let rest = pos % item_size;
> +        let s_pos = rest / quantum_size;
> +        let q_pos = rest % quantum_size;
> +
> +        let Some(q) = inner.follow(item).and_then(|qs| qs.get_quantum_mut(s_pos)) else {
> +            return Err(ENOMEM);
> +        };
> +
> +        let count = buf.len().min(quantum_size - q_pos);
> +
> +        buf.read_slice(&mut q[q_pos..q_pos + count])?;
> +
> +        let new_pos = pos + count;
> +        *offset = new_pos as i64;
> +
> +        if new_pos > inner.size {
> +            inner.size = new_pos;
> +        }
> +
> +        Ok(count)
> +    }
> +
> +    fn ioctl(
> +        &self,
> +        _file: &File,
> +        cmd: Self::IoctlCmd,
> +        #[cfg(CONFIG_COMPAT)] _compat: bool,
> +    ) -> Result<u64> {
> +        // The original implementation from the book actually doesn't consider the lock here at all,
> +        // but Rust forces us to do so :)
> +        let mut inner = self.inner.lock();

Does that mean the C implementation is wrong?  It could be, but what
makes this so special that rust is requiring it and C doesn't?

> +
> +        // We should definitely check if the user is trying to set a size to 0, or we'll
> +        // end up with panics in the read/write functions due to division by zero.
> +        // However, the original implementation doesn't account for this, so we won't either.

We should :)

And invalid userspace data is the #1 security bug in the kernel, let's
not copy bad examples for others to also make the same mistake wherever
possible please.

> +        match cmd {
> +            Command::Reset => {
> +                inner.quantum_size = DEFAULT_QUANTUM_SIZE;
> +                inner.qset_size = DEFAULT_QSET_SIZE;
> +            }
> +            Command::SetQuantum(mut reader) => {
> +                // TODO: guard this command (and all others where a size can be set by the user)
> +                // with `capability(CAP_SYS_ADMIN)`, which is not yet possible in the Rust API.
> +                let quantum_size = reader.read()?;
> +
> +                if !reader.is_empty() {
> +                    return Err(EINVAL);
> +                }
> +
> +                inner.quantum_size = quantum_size;
> +            }
> +            Command::TellQuantum(quantum) => {
> +                inner.quantum_size = quantum as usize;
> +            }
> +            Command::GetQuantum(mut writer) => {
> +                writer.write(&inner.quantum_size)?;
> +
> +                if !writer.is_empty() {
> +                    return Err(EINVAL);
> +                }
> +            }
> +            Command::QueryQuantum => {
> +                return Ok(inner.quantum_size as u64);
> +            }
> +            Command::ExchangeQuantum(slice) => {
> +                let (mut reader, mut writer) = slice.reader_writer();
> +                let quantum_size = reader.read()?;
> +
> +                if !reader.is_empty() {
> +                    return Err(EINVAL);
> +                }
> +
> +                writer.write(&inner.quantum_size)?;
> +
> +                inner.quantum_size = quantum_size;
> +            }
> +            Command::ShiftQuantum(quantum) => {
> +                let old_quantum = inner.quantum_size;
> +                inner.quantum_size = quantum as usize;
> +                return Ok(old_quantum as u64);
> +            }
> +            Command::SetQset(mut reader) => {
> +                let qset_size = reader.read()?;
> +
> +                if !reader.is_empty() {
> +                    return Err(EINVAL);
> +                }
> +
> +                inner.qset_size = qset_size;
> +            }
> +            Command::TellQset(qset) => {
> +                inner.qset_size = qset as usize;
> +            }
> +            Command::GetQset(mut writer) => {
> +                writer.write(&inner.qset_size)?;
> +
> +                if !writer.is_empty() {
> +                    return Err(EINVAL);
> +                }
> +            }
> +            Command::QueryQset => {
> +                return Ok(inner.qset_size as u64);
> +            }
> +            Command::ExchangeQset(slice) => {
> +                let (mut reader, mut writer) = slice.reader_writer();
> +                let qset_size = reader.read()?;
> +
> +                if !reader.is_empty() {
> +                    return Err(EINVAL);
> +                }
> +
> +                writer.write(&inner.qset_size)?;
> +
> +                inner.qset_size = qset_size;
> +            }
> +            Command::ShiftQset(qset) => {
> +                let old_qset = inner.qset_size;
> +                inner.qset_size = qset as usize;
> +                return Ok(old_qset as u64);
> +            }
> +        }
> +
> +        Ok(0)
> +    }
> +
> +    fn llseek(
> +        &self,
> +        _file: &LocalFile,
> +        pos: &mut i64,
> +        offset: i64,
> +        whence: Whence,
> +    ) -> Result<u64, Self::Err> {
> +        let size = self.inner.lock().size as i64;
> +
> +        let new_offset = match whence {
> +            Whence::Set => offset,
> +            Whence::Cur => *pos + offset,
> +            Whence::End => size + offset,
> +            _ => return Err(EINVAL),
> +        };
> +
> +        if new_offset < 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        *pos = new_offset;
> +
> +        Ok(new_offset as u64)
> +    }
> +}
> +
> +struct RustCharDevModule {
> +    reg: Pin<Box<DeviceRegistration<ScullDev, NUM_DEVS>>>,

You really want NUM_DEVS of these statically?  I haven't read the old
book example code, but that's really a bad example if so, the authors
should have known better :)

Ideally these are created dynamically, like what happens in the real
world.

thanks,

greg k-h

