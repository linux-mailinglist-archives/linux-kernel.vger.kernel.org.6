Return-Path: <linux-kernel+bounces-362651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84C99B7B7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED77C282A92
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8670319B3ED;
	Sat, 12 Oct 2024 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b="elnfXI6E"
Received: from dd3514.kasserver.com (dd3514.kasserver.com [85.13.129.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C779B8E;
	Sat, 12 Oct 2024 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.129.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728776319; cv=none; b=Mhv8JVW7YuEXlNhhbKR+F6o7syg3K6yFpOS+Y1XHKVkMT6odBC2P2O0jOMRqBR+LTAluBZsJ+P5grg9Y7pYDOPB8/xZleqrUftjUiHTKg5GD/ktqyIcFQILJN/sHxXfAAQ637iZ4NLioRBn1mRxBpyNx56N5unNcwTwm6JZ4lpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728776319; c=relaxed/simple;
	bh=BkEqU4V+j+bCjYbPQrW08uQ7DsM/7BhxAXq7PAM6J+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQOPtpKXzcHvF2IbNbZxjnh6ppeF/ZdvsP+XHfJpPzf2Z0Re1MHsE/cJTkP9tAsG9MukMFYFd1otMQq8X4xmFtY4IhZl3U+dwvLFACXkWq0H2TCrFohNS57E6XNlIKsH69AVpYnt7spSBEDjl4bBlrS1DjX3MPxsCJA4nAx5kHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com; spf=pass smtp.mailfrom=walterzollerpiano.com; dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b=elnfXI6E; arc=none smtp.client-ip=85.13.129.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walterzollerpiano.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=walterzollerpiano.com; s=kas202409051210; t=1728776312;
	bh=SydHp0uuoCjBH2T2Ew+W+PmTXBO7bfPJHZG7xj+gF2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=elnfXI6EFFxbrsnJ70PYYsXYmrvhhHSEjn0ZHMo1nyvOSuMHalXG7aTjFcVGScjen
	 CHn4pxWxuXsv8AiD2Mhuwe6Bx9YFzPnELq8ZzWBKUHg5vnMRuacRRhn0lg/3VWlMG4
	 ApqqM3Dh3aZ84QCM5em+pMsOBzKwwZQkbh8//fTRTSBdNvtfVYsg3SM7Ne/6ACfm9y
	 Md+53LGuaWgIqamUNGkgipMRbxocAbAyxsewZq4a/5v+ELNxHPEA6xIOT1HI0mVaUg
	 Lh+WSZhqZC46afgb8YjNIogHtLL7EKxXVfgH59NC8D2xaC/sPX71V/YGDYKIcH1D/L
	 x8z/uhelQ/6aQ==
Received: from [192.168.1.124] (31-10-158-205.cgn.dynamic.upc.ch [31.10.158.205])
	by dd3514.kasserver.com (Postfix) with ESMTPA id 329431023B7;
	Sun, 13 Oct 2024 01:38:32 +0200 (CEST)
Message-ID: <dfe8c9be-5a04-480a-a7ef-def5bd9d000f@walterzollerpiano.com>
Date: Sun, 13 Oct 2024 01:38:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] samples: rust: add character device sample
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
 <20241011-rust-char-dev-v1-3-350225ae228b@walterzollerpiano.com>
 <2024101222-theatrics-enrich-ba21@gregkh>
Content-Language: en-US
From: Josef Zoller <josef@walterzollerpiano.com>
In-Reply-To: <2024101222-theatrics-enrich-ba21@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++



On 12.10.24 14:37, Greg Kroah-Hartman wrote:
> On Fri, Oct 11, 2024 at 08:55:44PM +0200, Josef Zoller wrote:
>> Provide a sample implementation of a character device in Rust, following
>> the scull device from the well-known book "Linux Device Drivers".
>>
>> This sample uses the abstractions from the previous patches in this
>> series to implement the scull device in mostly safe Rust. All of the
>> unsafe code comes from the fact that the data structure used in the C
>> implementation is inherently unsafe and cannot easily be represented in
>> safe Rust without a lot of memory overhead.
>>
>> This sample should be a good starting point for people who want to start
>> writing kernel code in Rust, as a character device is relatively simple
>> and does not require a lot of kernel knowledge to understand.
>>
>> Signed-off-by: Josef Zoller <josef@walterzollerpiano.com>
>> ---
>>   samples/rust/Kconfig          |  10 +
>>   samples/rust/Makefile         |   1 +
>>   samples/rust/rust_char_dev.rs | 506 ++++++++++++++++++++++++++++++++++++++++++
>
> This feels like it could be a lot smaller, 500 lines for a sample char
> driver seems excessive.

You're totally right and I'm not too happy with this either. It's mainly
that large because I wanted to model the storage of the device as
closely as possible to the C version, which probably just doesn't make
a lot of sense. I'll try to find a way to make this more rusty without
having the massive memory overhead that comes with a naive translation.

>> --- /dev/null
>> +++ b/samples/rust/rust_char_dev.rs
>> @@ -0,0 +1,506 @@
>> +// SPDX-License-Identifier: GPL-2.0
>
> Again, copyright notice please.

Sure, maybe it should be added to all rust files?

>> +
>> +//! Rust character device sample.
>> +//!
>> +//! This sample demonstrates how to create a simple character device in Rust,
>> +//! by reimplementing the `scull` device from the Linux Device Drivers book.
>> +
>> +use core::{mem, ptr::NonNull};
>> +
>> +use kernel::{
>> +    c_str,
>> +    char_dev::{CharDevice, CharDeviceID, DeviceRegistration, OpenCharDevice, Whence},
>> +    fs::{file::flags, File, LocalFile},
>> +    new_mutex,
>> +    prelude::*,
>> +    sync::{Arc, Mutex},
>> +    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
>> +};
>> +
>> +module! {
>> +    type: RustCharDevModule,
>> +    name: "rust_char_dev",
>> +    author: "Rust for Linux Contributors",
>> +    description: "Rust character device sample",
>> +    license: "GPL",
>> +}
>> +
>> +const DEVICE_NAME: &CStr = c_str!("rust_scull");
>> +const DEFAULT_QSET_SIZE: usize = 1000;
>> +const DEFAULT_QUANTUM_SIZE: usize = 4000;
>> +const NUM_DEVS: usize = 4;
>
> Comments for what these const are for?

If you're familiar with the scull device data structure, these should be
pretty much self-explanatory. So probably some explanatory comment about
that data structure would be more helpful. Noted.

>> +// This is probably too specific a function to be in the Rust standard library...
>> +trait OptionExt<T> {
>> +    fn get_or_try_insert_with<F, E>(&mut self, f: F) -> Result<&mut T, E>
>> +    where
>> +        F: FnOnce() -> Result<T, E>;
>> +}
>> +
>> +impl<T> OptionExt<T> for Option<T> {
>> +    fn get_or_try_insert_with<F, E>(&mut self, f: F) -> Result<&mut T, E>
>> +    where
>> +        F: FnOnce() -> Result<T, E>,
>> +    {
>> +        if self.is_none() {
>> +            *self = Some(f()?);
>> +        }
>> +
>> +        Ok(self.as_mut().unwrap())
>> +    }
>> +}
>
> What are these for?  No comments makes it confusing to me :)

Yeah, that's a blunder on my part :)
Sometimes I forget that, especially in this project, the rust code is
read by people who are not necessarily that familiar with the language.
This is a pretty common pattern in Rust, so I just didn't think about it
too much.

Basically, there is a problem with the Rust borrow checker right now,
that makes it hard to do some basic stuff.
In this case, we have the following problem:

Suppose, we want to write a function that takes an option and returns a
mutable reference to its value. If the option is None, we want to insert
a new value first and then get a mutable reference to it. A naive
approach would be to do this (insert returns a mutable reference to the
inserted value):

fn foo(opt: &mut Option<usize>) -> &mut usize {
     if let Some(reference) = opt.as_mut() {
         reference
     } else {
         opt.insert(42)
     }
}

However, this does not work, because the borrow checker doesn't allow
multiple mutable references to the same value and (currently) doesn't
understand that the references in the two if branches are mutually
exclusive. To work around this, we can use the get_or_insert method on
Option, which does exactly what we want:

fn foo(opt: &mut Option<usize>) -> &mut usize {
     opt.get_or_insert(42)
}

However, this eagerly evaluates the value to insert, which is not what
we want later in this file, because we want to allocate only when we
have to. The rust standard library also has a get_or_insert_with method,
which takes a closure that returns the value to insert. However, this
method doesn't allow us to fail an allocation, because the closure can't
return a Result. So I extended Option with the get_or_try_insert_with
method, which allows us to return a Result from the closure.

>> +
>> +#[derive(IoctlCommand)]
>> +#[ioctl(code = b'k')]
>> +enum Command {
>> +    Reset,                       // 0
>> +    SetQuantum(UserSliceReader), // 1
>> +    SetQset(UserSliceReader),    // 2
>> +    TellQuantum(u64),            // 3
>> +    TellQset(u64),               // 4
>> +    GetQuantum(UserSliceWriter), // 5
>> +    GetQset(UserSliceWriter),    // 6
>> +    QueryQuantum,                // 7
>> +    QueryQset,                   // 8
>> +    ExchangeQuantum(UserSlice),  // 9
>> +    ExchangeQset(UserSlice),     // 10
>> +    ShiftQuantum(u64),           // 11
>> +    ShiftQset(u64),              // 12
>> +}
>
> Trying to keep ioctl numbers identical from kernel/userspace means they
> should go in a .h file, putting them here is not going to work well.

Hmm, this is a tricky problem to solve. A solution like this, where the
commands are automatically parsed into a Rust enum using a derive macro,
would definitely be the rustiest way to do it, but it's obviously not
too easy to export these commands for userspace.

>> +// We implement `ScullQset` as close as possible to the `struct scull_qset` implementation from
>> +// the book. This means that we have to use raw pointers and some unsafe code for the data.
>
> That's not a good idea overall, why not look at the "untrusted data"
> patch on the list and tie that into here so that things are not unsafe?
> That is ideally what we want to do for ALL rust user/kernel interfaces.

I don't think this particular problem can be solved with the untrusted
data patch, as it's only about data storage for data that's already been
copied into kernel space.

>> +// Otherwise, we'd have massive memory overhead by storing sizes/capacities unnecessarily.
>> +// E.g. every `ScullQset` would be 8 * qset_size bytes larger if we used `Box<[_]>` and
>> +// 16 * qset_size bytes larger if we used `Vec<_>`.
>> +// However, the knowledge that all data arrays are of the same size isn't possible to express
>> +// in safe Rust without this memory overhead.
>> +struct ScullQset {
>> +    data: Option<NonNull<Option<NonNull<u8>>>>,
>> +    quantum_size: usize,
>> +    qset_size: usize,
>> +    next: Option<Box<ScullQset>>,
>> +}
>
> I'm sorry, I don't understand why this is so odd and has to be "unsafe".
> It's just chunks of memory read from userspace.  And we do have a list
> structure somewhere (or something like that), that probably works better
> than the next pointer from what I recall.

So, first of all, the linked list itself doesn't require unsafe code at
all. Option<Box<Self>> is exactly the right pattern to use for linked
lists and directly corresponds to how you'd write a linked list in C,
only with the safety guarantees of Rust.

The problem is with the data field, which should be an optional
heap-allocated array of arrays, where the outer array has qset_size
elements and each of those elements is an optional heap-allocated array
of quantum_size elements. If QSET_SIZE and QUANTUM_SIZE were known
constants at compile time, we could simply use a

Option<Box<[Option<Box<[u8; QUANTUM_SIZE]>; QSET_SIZE]>>

to represent this. However, it's not so easy when the sizes can change
at runtime. Naively, we could use a Option<Vec<Option<Vec<u8>>>>, but
that has the following downside: The outer Vec has to store qset_size
times the size of Option<Vec<u8>>, which is 24 bytes on a 64-bit system,
because each Vec stores not only a pointer, but also both a capacity and
a size. This is obviously unnecessary, because we know that all the
inner Vecs will have the same size, but we cannot prove this to the
compiler. Using a Option<Box<[Option<Box<[u8]>>]>, we can avoid storing
the size, but we still store the length for each inner array and also
the rest of our code will again be much more complicated.

Thus, I settled on using raw pointers for this version of the patch.
However, I hear your concerns about this and - as I'm myself not happy
with this solution - I would come up with a better solution in a second
version of this patch.

>> +impl ScullQset {
>> +    fn new(quantum_size: usize, qset_size: usize) -> Self {
>> +        Self {
>> +            data: None,
>> +            quantum_size,
>> +            qset_size,
>> +            next: None,
>> +        }
>> +    }
>> +
>> +    /// Returns a reference to the quantum at index `i` if it exists.
>> +    fn get_quantum(&self, i: usize) -> Option<&[u8]> {
>> +        let data_slice = NonNull::slice_from_raw_parts(self.data?, self.qset_size);
>> +        // SAFETY: `data_slice` points to a valid slice of `Option<NonNull<u8>>`.
>> +        let quantum = unsafe { data_slice.as_ref()[i] };
>> +        let quantum_slice = NonNull::slice_from_raw_parts(quantum?, self.quantum_size);
>> +        // SAFETY: `quantum_slice` points to a valid slice of `u8`.
>> +        Some(unsafe { quantum_slice.as_ref() })
>> +    }
>> +
>> +    /// Returns a mutable reference to the quantum at index `i`, allocating it first if necessary.
>> +    fn get_quantum_mut(&mut self, i: usize) -> Option<&mut [u8]> {
>> +        let data = self
>> +            .data
>> +            .get_or_try_insert_with(|| {
>> +                let mut data =
>> +                    mem::ManuallyDrop::new(Vec::with_capacity(self.qset_size, GFP_KERNEL)?);
>> +                for _ in 0..self.qset_size {
>> +                    data.push(None, GFP_KERNEL)?;
>> +                }
>> +
>> +                assert!(data.len() == data.capacity());
>> +
>> +                // SAFETY: `data.as_mut_ptr()` is non-null.
>> +                Ok::<_, Error>(unsafe { NonNull::new_unchecked(data.as_mut_ptr()) })
>> +            })
>> +            .ok()?;
>> +
>> +        let mut data_slice = NonNull::slice_from_raw_parts(*data, self.qset_size);
>> +
>> +        // SAFETY: `data_slice` points to a valid slice of `Option<NonNull<u8>>`.
>> +        let maybe_quantum = unsafe { &mut data_slice.as_mut()[i] };
>> +        let quantum = maybe_quantum
>> +            .get_or_try_insert_with(|| {
>> +                let mut quantum =
>> +                    mem::ManuallyDrop::new(Vec::with_capacity(self.quantum_size, GFP_KERNEL)?);
>> +                for _ in 0..self.quantum_size {
>> +                    quantum.push(0, GFP_KERNEL)?;
>> +                }
>> +
>> +                assert!(quantum.len() == quantum.capacity());
>> +
>> +                // SAFETY: `quantum.as_mut_ptr()` is non-null.
>> +                Ok::<_, Error>(unsafe { NonNull::new_unchecked(quantum.as_mut_ptr()) })
>> +            })
>> +            .ok()?;
>> +
>> +        let mut quantum_slice = NonNull::slice_from_raw_parts(*quantum, self.quantum_size);
>> +        // SAFETY: `quantum_slice` points to a valid slice of `u8`.
>> +        Some(unsafe { quantum_slice.as_mut() })
>> +    }
>> +}
>> +
>> +impl Drop for ScullQset {
>> +    fn drop(&mut self) {
>> +        if let Some(data) = self.data.take() {
>> +            // SAFETY: `data` was created by `Vec::with_capacity` with a capacity of `qset_size`.
>> +            let data_vec =
>> +                unsafe { Vec::from_raw_parts(data.as_ptr(), self.qset_size, self.qset_size) };
>> +
>> +            for quantum in data_vec {
>> +                let Some(quantum) = quantum else { continue };
>> +
>> +                // SAFETY: `quantum` was created by `Vec::with_capacity` with a capacity of
>> +                // `quantum_size`.
>> +                let _ = unsafe {
>> +                    Vec::from_raw_parts(quantum.as_ptr(), self.quantum_size, self.quantum_size)
>> +                };
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> +// SAFETY: The raw pointers are uniquely owned by `ScullQset` and not shared, so it's safe to send
>> +// it to another thread.
>> +unsafe impl Send for ScullQset {}
>
> What other thread are you sending this to?
>
> I don't see any "threads" here in the driver, do you mean "can be shared
> by different userspace processes"?

I'm not sending this to another thread here, I'm just saying that it
would be safe to do so. This is a requirement for implementing the
CharDevice and OpenCharDevice traits, which I added because I assumed
that the methods on f_ops can probably be called by different threads
in the kernel, which would mean that we access the device data from
different threads even if we don't explicitly spawn any threads in the
device driver. Rust requires types that can be accessed from different
threads to be Send, so I added this requirement to the device traits.

>> +struct ScullDevInner {
>> +    data: Option<Box<ScullQset>>,
>> +    quantum_size: usize,
>> +    qset_size: usize,
>> +    size: usize,
>> +}
>> +
>> +impl Default for ScullDevInner {
>> +    fn default() -> Self {
>> +        Self {
>> +            data: None,
>> +            quantum_size: DEFAULT_QUANTUM_SIZE,
>> +            qset_size: DEFAULT_QSET_SIZE,
>> +            size: 0,
>> +        }
>> +    }
>> +}
>> +
>> +impl ScullDevInner {
>> +    fn trim(&mut self) {
>> +        mem::take(&mut self.data);
>> +        self.size = 0;
>> +    }
>> +
>> +    fn follow(&mut self, n: usize) -> Option<&mut ScullQset> {
>> +        let mut qs = self
>> +            .data
>> +            .get_or_try_insert_with(|| {
>> +                Box::new(
>> +                    ScullQset::new(self.quantum_size, self.qset_size),
>> +                    GFP_KERNEL,
>> +                )
>> +            })
>> +            .ok()?;
>> +
>> +        for _ in 0..n {
>> +            qs = qs
>> +                .next
>> +                .get_or_try_insert_with(|| {
>> +                    // We use `qs.quantum_size` and `qs.qset_size` here to avoid subtly
>> +                    // different behavior from the original C implementation.
>> +                    // If we used the sizes from `self`, we could end up with differently
>> +                    // sized qsets in the linked list (which would not be a safety problem).
>> +                    // Like this, we only use an updated size after `trim` has been called,
>> +                    // which is the same behavior as in the book.
>> +                    Box::new(ScullQset::new(qs.quantum_size, qs.qset_size), GFP_KERNEL)
>
> As one of the authors of the book in reference here, I really don't
> understand this at all :)
>
> What am I missing?  Why is this so complex?

In the C implementation of scull, the quantum and qset sizes are global
variables that are copied to a device's private data structure when its
trim method is called. I'm emulating this behaviour, but without global
variables. It is not very complex at all (I'm just using qs.quantum_size
and qs.qset_size instead of self.quantum_size and self.qset_size in this
line), I just wanted to exlain this in the comment. I think, the comment
makes it sound more complex than it actually is...

> You don't have to follow the implementation identically, just because
> something is simple to do in C doesn't mean you have to do the same
> thing in rust at all.  We just implemented stuff to make the concepts
> simple to follow, not to implement something specific that was trying to
> solve a real problem here.  So try to keep it simple, I think there are
> other examples of rust char drivers in other trees that might be better
> to use as an example, as this complexity probably isn't needed and will
> just confuse new people (i.e. me!) more than is needed.

Yeah, I agree. I wanted to perfectly replicate the C implementation's
behaviour, but maybe that's just not very nice for sample code that is
supposed to be as simple as possible. In a second version of this patch,
I would definitely simplify this part.

By the way, as I was writing the above paragraph, I realized, that I
already hadn't quite replicated the C implementation's behaviour
regarding the global variables (because they are shared between all
devices in the C implementation) :)

>> +                })
>> +                .ok()?;
>> +        }
>> +
>> +        Some(qs)
>> +    }
>> +}
>> +
>> +#[derive(Clone)]
>> +struct ScullDev {
>> +    inner: Arc<Mutex<ScullDevInner>>,
>> +}
>> +
>> +#[vtable]
>> +impl CharDevice for ScullDev {
>> +    type OpenPtr = Box<Self>;
>> +    type Err = Error;
>> +
>> +    fn new(_dev_id: CharDeviceID) -> Result<Self> {
>> +        Ok(Self {
>> +            inner: Arc::pin_init(new_mutex!(ScullDevInner::default()), GFP_KERNEL)?,
>> +        })
>> +    }
>> +
>> +    fn open(&self, file: &File) -> Result<Self::OpenPtr> {
>> +        if file.flags() & flags::O_ACCMODE == flags::O_WRONLY {
>> +            // TODO: this should be lock_interruptible, but that's not in the Rust API yet
>
> I think patches for that are floating around, right?

I don't think so:
https://lore.kernel.org/rust-for-linux/?q=lock_interruptible

>> +            self.inner.lock().trim();
>> +        }
>> +
>> +        Ok(Box::new(self.clone(), GFP_KERNEL)?)
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl OpenCharDevice for ScullDev {
>> +    type IoctlCmd = Command;
>> +    type Err = Error;
>> +
>> +    fn read(&self, _file: &LocalFile, mut buf: UserSliceWriter, offset: &mut i64) -> Result<usize> {
>> +        let pos = usize::try_from(*offset).map_err(|_| EINVAL)?;
>> +
>> +        // TODO: this should be lock_interruptible, but that's not in the Rust API yet
>> +        let mut inner = self.inner.lock();
>> +
>> +        // To keep the behavior of the original C implementation, namely that the quantum and qset
>> +        // sizes are only updated after a trim, we use the sizes from the inner data if it exists.
>> +        let (quantum_size, qset_size) = inner
>> +            .data
>> +            .as_ref()
>> +            .map_or((inner.quantum_size, inner.qset_size), |qs| {
>> +                (qs.quantum_size, qs.qset_size)
>> +            });
>> +        let item_size = quantum_size * qset_size;
>> +
>> +        if pos >= inner.size {
>> +            return Ok(0);
>> +        }
>> +
>> +        let mut count = buf.len().min(inner.size - pos);
>> +        let item = pos / item_size;
>> +        let rest = pos % item_size;
>> +        let s_pos = rest / quantum_size;
>> +        let q_pos = rest % quantum_size;
>> +
>> +        let Some(q) = inner.follow(item).and_then(|qs| qs.get_quantum(s_pos)) else {
>> +            return Ok(0);
>> +        };
>> +
>> +        count = count.min(quantum_size - q_pos);
>> +
>> +        buf.write_slice(&q[q_pos..q_pos + count])?;
>> +
>> +        *offset += count as i64;
>> +
>> +        Ok(count)
>> +    }
>> +
>> +    fn write(
>> +        &self,
>> +        _file: &LocalFile,
>> +        mut buf: UserSliceReader,
>> +        offset: &mut i64,
>> +    ) -> Result<usize> {
>> +        let pos = usize::try_from(*offset).map_err(|_| EINVAL)?;
>> +
>> +        // TODO: this should be lock_interruptible, but that's not in the Rust API yet
>> +        let mut inner = self.inner.lock();
>> +
>> +        // To keep the behavior of the original C implementation, namely that the quantum and qset
>> +        // sizes are only updated after a trim, we use the sizes from the inner data if it exists.
>> +        let (quantum_size, qset_size) = inner
>> +            .data
>> +            .as_ref()
>> +            .map_or((inner.quantum_size, inner.qset_size), |qs| {
>> +                (qs.quantum_size, qs.qset_size)
>> +            });
>> +        let item_size = quantum_size * qset_size;
>> +
>> +        let item = pos / item_size;
>> +        let rest = pos % item_size;
>> +        let s_pos = rest / quantum_size;
>> +        let q_pos = rest % quantum_size;
>> +
>> +        let Some(q) = inner.follow(item).and_then(|qs| qs.get_quantum_mut(s_pos)) else {
>> +            return Err(ENOMEM);
>> +        };
>> +
>> +        let count = buf.len().min(quantum_size - q_pos);
>> +
>> +        buf.read_slice(&mut q[q_pos..q_pos + count])?;
>> +
>> +        let new_pos = pos + count;
>> +        *offset = new_pos as i64;
>> +
>> +        if new_pos > inner.size {
>> +            inner.size = new_pos;
>> +        }
>> +
>> +        Ok(count)
>> +    }
>> +
>> +    fn ioctl(
>> +        &self,
>> +        _file: &File,
>> +        cmd: Self::IoctlCmd,
>> +        #[cfg(CONFIG_COMPAT)] _compat: bool,
>> +    ) -> Result<u64> {
>> +        // The original implementation from the book actually doesn't consider the lock here at all,
>> +        // but Rust forces us to do so :)
>> +        let mut inner = self.inner.lock();
>
> Does that mean the C implementation is wrong?  It could be, but what
> makes this so special that rust is requiring it and C doesn't?

Well, yes, the C implementation is probably wrong. It doesn't take a
lock here, which could at least lead to bad interleavings in the
operations that are supposed to be atomic like exchange/shift, I think.

As I have wrapped the inner data in a Mutex, Rust forces me to take the
lock here, because I cannot access the inner data in any other way. In
C, you can just access the data directly, the lock is just a field next
to the data, so you can ignore it if you want to.

>> +
>> +        // We should definitely check if the user is trying to set a size to 0, or we'll
>> +        // end up with panics in the read/write functions due to division by zero.
>> +        // However, the original implementation doesn't account for this, so we won't either.
>
> We should :)
>
> And invalid userspace data is the #1 security bug in the kernel, let's
> not copy bad examples for others to also make the same mistake wherever
> possible please.

Fair enough :)

>> +        match cmd {
>> +            Command::Reset => {
>> +                inner.quantum_size = DEFAULT_QUANTUM_SIZE;
>> +                inner.qset_size = DEFAULT_QSET_SIZE;
>> +            }
>> +            Command::SetQuantum(mut reader) => {
>> +                // TODO: guard this command (and all others where a size can be set by the user)
>> +                // with `capability(CAP_SYS_ADMIN)`, which is not yet possible in the Rust API.
>> +                let quantum_size = reader.read()?;
>> +
>> +                if !reader.is_empty() {
>> +                    return Err(EINVAL);
>> +                }
>> +
>> +                inner.quantum_size = quantum_size;
>> +            }
>> +            Command::TellQuantum(quantum) => {
>> +                inner.quantum_size = quantum as usize;
>> +            }
>> +            Command::GetQuantum(mut writer) => {
>> +                writer.write(&inner.quantum_size)?;
>> +
>> +                if !writer.is_empty() {
>> +                    return Err(EINVAL);
>> +                }
>> +            }
>> +            Command::QueryQuantum => {
>> +                return Ok(inner.quantum_size as u64);
>> +            }
>> +            Command::ExchangeQuantum(slice) => {
>> +                let (mut reader, mut writer) = slice.reader_writer();
>> +                let quantum_size = reader.read()?;
>> +
>> +                if !reader.is_empty() {
>> +                    return Err(EINVAL);
>> +                }
>> +
>> +                writer.write(&inner.quantum_size)?;
>> +
>> +                inner.quantum_size = quantum_size;
>> +            }
>> +            Command::ShiftQuantum(quantum) => {
>> +                let old_quantum = inner.quantum_size;
>> +                inner.quantum_size = quantum as usize;
>> +                return Ok(old_quantum as u64);
>> +            }
>> +            Command::SetQset(mut reader) => {
>> +                let qset_size = reader.read()?;
>> +
>> +                if !reader.is_empty() {
>> +                    return Err(EINVAL);
>> +                }
>> +
>> +                inner.qset_size = qset_size;
>> +            }
>> +            Command::TellQset(qset) => {
>> +                inner.qset_size = qset as usize;
>> +            }
>> +            Command::GetQset(mut writer) => {
>> +                writer.write(&inner.qset_size)?;
>> +
>> +                if !writer.is_empty() {
>> +                    return Err(EINVAL);
>> +                }
>> +            }
>> +            Command::QueryQset => {
>> +                return Ok(inner.qset_size as u64);
>> +            }
>> +            Command::ExchangeQset(slice) => {
>> +                let (mut reader, mut writer) = slice.reader_writer();
>> +                let qset_size = reader.read()?;
>> +
>> +                if !reader.is_empty() {
>> +                    return Err(EINVAL);
>> +                }
>> +
>> +                writer.write(&inner.qset_size)?;
>> +
>> +                inner.qset_size = qset_size;
>> +            }
>> +            Command::ShiftQset(qset) => {
>> +                let old_qset = inner.qset_size;
>> +                inner.qset_size = qset as usize;
>> +                return Ok(old_qset as u64);
>> +            }
>> +        }
>> +
>> +        Ok(0)
>> +    }
>> +
>> +    fn llseek(
>> +        &self,
>> +        _file: &LocalFile,
>> +        pos: &mut i64,
>> +        offset: i64,
>> +        whence: Whence,
>> +    ) -> Result<u64, Self::Err> {
>> +        let size = self.inner.lock().size as i64;
>> +
>> +        let new_offset = match whence {
>> +            Whence::Set => offset,
>> +            Whence::Cur => *pos + offset,
>> +            Whence::End => size + offset,
>> +            _ => return Err(EINVAL),
>> +        };
>> +
>> +        if new_offset < 0 {
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        *pos = new_offset;
>> +
>> +        Ok(new_offset as u64)
>> +    }
>> +}
>> +
>> +struct RustCharDevModule {
>> +    reg: Pin<Box<DeviceRegistration<ScullDev, NUM_DEVS>>>,
>
> You really want NUM_DEVS of these statically?  I haven't read the old
> book example code, but that's really a bad example if so, the authors
> should have known better :)

Well, the book registers scull_nr_devs devices, which is 4 by default
but can be set using a module param, so it's not completely static.

> Ideally these are created dynamically, like what happens in the real
> world.

Hmm, do you mean that we should actually register more devices (e.g.
using register_chrdev_region) when needed? How would that work?

Otherwise, you could see the const generic on the DeviceRegistration
struct more as a way to specify the maximum number of devices that are
registered, but not necessarily the number of devices that have data
allocated for them (currently, we allocate some data for every device
on registration, but I could also change it, so that it's only allocated
on the first open of the device or something like that).

Cheers,
Josef

