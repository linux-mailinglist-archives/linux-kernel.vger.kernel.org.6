Return-Path: <linux-kernel+bounces-362631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A027E99B733
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EF56B21433
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAB7152166;
	Sat, 12 Oct 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b="rYkJ7Fes"
Received: from dd3514.kasserver.com (dd3514.kasserver.com [85.13.129.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9232564;
	Sat, 12 Oct 2024 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.129.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728769745; cv=none; b=ki2x3B0e2Km9SFLaiqy4XyACcrJS3kfqcjTa5qiWVzGEYD1ABNV9B3jaev38IbtkooM5W/KPgGdfgDAiySmNt0Wa90xL53MqQBVEKjMC3SX7oCg2mFJKNliz6/GVMbMfAO9mZMXWgNqpAEpKQzJvwTo4HbA0CIOdrB8dgPH55sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728769745; c=relaxed/simple;
	bh=czsCTSHYoHKyHTg8bSdZp3H642CthsJm/P2MaOMfNDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AG9hrAnCrAjytsQA+WhF6KfSOY13YIzB6ROAZMUj27WyhmW9S8oPRDHbiLMOjZYlM+UjW8d0CPRN3k4IrIQx102ensouBwU7gvvu4lBSyQS++dnxGotLVidzX1nde6yCdnSdCdgFZpxfTGjRnPNNKzUhd0+eKTKVV/hJILotIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com; spf=pass smtp.mailfrom=walterzollerpiano.com; dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b=rYkJ7Fes; arc=none smtp.client-ip=85.13.129.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walterzollerpiano.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=walterzollerpiano.com; s=kas202409051210; t=1728769740;
	bh=cbgYXwrEoEp5y5FnxtUZ41ns07ndwEMx1dxwH63SO/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rYkJ7Fes3TV6xxErULasiWJh9I0rmIYVwpmELKh2Lznkj2MOzkaOdQW8def2+46Sj
	 xOjgYMdp3p+TatHVcss3lFvJzPrssdVBMz5pkqzMHBh7hrzn3ZoUXUEZuUoSlQHJHV
	 1M81yqK3Em+iWOlGkwqS7hKExXLHWeN198MNvb9KHLuGeqcpXw7S1FW/cUmMwNTxZ3
	 e7+loTn6ewctcM9qUqbi0n2obd149HDy+OJ/7vrXXw7Dd1ER5V9ijGxoIFeo7OhC/Q
	 G5w3S3aPxb4IIsO1NnkjF4khw/JnwA9OEa7bH7srxgbwubLuiVjvJYEO9ILrAP6ojY
	 ijm73/cCvLS4g==
Received: from [192.168.1.124] (31-10-158-205.cgn.dynamic.upc.ch [31.10.158.205])
	by dd3514.kasserver.com (Postfix) with ESMTPA id 17B38102283;
	Sat, 12 Oct 2024 23:49:00 +0200 (CEST)
Message-ID: <984f6b1b-b396-45e1-8325-90a01e4305c3@walterzollerpiano.com>
Date: Sat, 12 Oct 2024 23:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: char_dev: add character device abstraction
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
 <20241011-rust-char-dev-v1-1-350225ae228b@walterzollerpiano.com>
 <2024101253-golf-detonator-592c@gregkh>
Content-Language: en-US
From: Josef Zoller <josef@walterzollerpiano.com>
In-Reply-To: <2024101253-golf-detonator-592c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +



On 12.10.24 09:36, Greg Kroah-Hartman wrote:
> On Fri, Oct 11, 2024 at 08:55:42PM +0200, Josef Zoller wrote:
>> +unsigned int rust_helper_MAJOR(dev_t dev)
>> +{
>> +	return MAJOR(dev);
>> +}
>
> I don't think you use this function in the code anywhere.

Yes, I do. I use it at rust/kernel/char_dev.rs:41.

>> +unsigned int rust_helper_MINOR(dev_t dev)
>> +{
>> +	return MINOR(dev);
>> +}
>
> Is this really needed?  No driver should care about their minor number,
> except to possibly set it, not read it.

It's not really needed, but I use it in my scull example to just print
the major and minor numbers of the devices, which makes it easy to
quickly create a device file for testing using mknod.

>> +dev_t rust_helper_MKDEV(unsigned int major, unsigned int minor)
>> +{
>> +	return MKDEV(major, minor);
>> +}
>
> If you are only doing dynamic creation, as your initial text said, I
> don't think you need this either as the kernel should create it for you.

Yeah, you're right. I forgot to remove this one after I changed to only
allowing dynamic device number creation.

>> diff --git a/rust/kernel/char_dev.rs b/rust/kernel/char_dev.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..b81c0d55ab60f18dc82a99991318a5ae0a26e560
>> --- /dev/null
>> +++ b/rust/kernel/char_dev.rs
>> @@ -0,0 +1,976 @@
>> +// SPDX-License-Identifier: GPL-2.0
>
> Minor nit, you forgot a copyright line :)

Oh, I just looked at some other rust files in rust/kernel and saw that
most of them don't have a copyright line. I'll add one to this file.

>> +
>> +//! Character device support.
>> +//!
>> +//! C headers: [`include/linux/cdev.h`](srctree/include/linux/cdev.h) and
>> +//! [`include/linux/fs.h`](srctree/include/linux/fs.h)
>> +
>> +use crate::{
>> +    bindings, container_of,
>> +    error::{to_result, VTABLE_DEFAULT_ERROR},
>> +    fs::{File, LocalFile},
>> +    ioctl::IoctlCommand,
>> +    prelude::*,
>> +    types::{ForeignOwnable, Opaque},
>> +    uaccess::{UserPtr, UserSlice, UserSliceReader, UserSliceWriter},
>> +};
>> +use core::{ffi, mem, ops::Deref};
>> +
>> +/// Character device ID.
>> +///
>> +/// This is a wrapper around the kernel's `dev_t` type and identifies a
>> +/// character device by its major and minor numbers.
>> +#[derive(Clone, Copy, Default, PartialEq, Eq, PartialOrd, Ord, Hash)]
>> +#[repr(transparent)]
>> +pub struct CharDeviceID(bindings::dev_t); // u32
>> +
>> +impl CharDeviceID {
>> +    /// Creates a new device ID from the given major and minor numbers.
>> +    ///
>> +    /// This corresponds to the kernel's `MKDEV` macro.
>> +    pub fn new(major: u32, minor: u32) -> Self {
>> +        // SAFETY: The kernel's `MKDEV` macro is safe to call with any values.
>> +        Self(unsafe { bindings::MKDEV(major, minor) })
>> +    }
>> +
>> +    /// Returns the major number of the device ID.
>> +    ///
>> +    /// This corresponds to the kernel's `MAJOR` macro.
>> +    pub fn major(&self) -> u32 {
>> +        // SAFETY: The kernel's `MAJOR` macro is safe to call with any value.
>> +        unsafe { bindings::MAJOR(self.0) }
>> +    }
>> +
>> +    /// Returns the minor number of the device ID.
>> +    ///
>> +    /// This corresponds to the kernel's `MINOR` macro.
>> +    pub fn minor(&self) -> u32 {
>> +        // SAFETY: The kernel's `MINOR` macro is safe to call with any value.
>> +        unsafe { bindings::MINOR(self.0) }
>> +    }
>> +}
>> +
>> +/// Seek mode for the `llseek` method.
>> +///
>> +/// This enum corresponds to the `SEEK_*` constants in the kernel.
>> +#[repr(u32)]
>> +pub enum Whence {
>> +    /// Set the file position to `offset`.
>> +    Set = bindings::SEEK_SET,
>> +    /// Set the file position to the current position plus `offset`.
>> +    Cur = bindings::SEEK_CUR,
>> +    /// Set the file position to the end of the file plus `offset`.
>> +    End = bindings::SEEK_END,
>> +    /// Set the file position to the next location in the file greater than or
>> +    /// equal to `offset` containing data.
>> +    Data = bindings::SEEK_DATA,
>> +    /// Set the file position to the next hole in the file greater than or
>> +    /// equal to `offset`.
>> +    Hole = bindings::SEEK_HOLE,
>> +}
>> +
>> +// Make sure at compile time that the `Whence` enum can be safely converted
>> +// from integers up to `SEEK_MAX`.
>> +const _: () = assert!(Whence::Hole as u32 == bindings::SEEK_MAX);
>> +
>> +/// Trait implemented by a registered character device.
>> +///
>> +/// A registered character device just handles the `open` operation on the
>> +/// device file and returns an open device type (which implements the
>> +/// [`OpenCharDevice`] trait) that handles the actual I/O operations on the
>> +/// device file. Optionally, the `release` operation can be implemented to
>> +/// handle the final close of the device file, but simple cleanup can also be
>> +/// done in the `Drop` implementation of the open device type.
>
> release is traditionally where you handle cleaning up what was allocated
> for this "open", and then drop can handle any "global" state for the
> device associated with this specific instance.  So "simple cleanup"
> might not be possible in both places, as they are different parts of the
> lifecycle of a device.

I guess, I haven't explained this clearly enough in the doc comment.
We have two different types here that correspond to two different parts
of the lifecycle of a device file:

We have a type implementing the `CharDevice` trait. An instance of this
type is created on device registration and lives until the device is
deregistered. And we have a type implementing the `OpenCharDevice`
trait. An instance of this type is created by the CharDevice type in the
open implementation and lives until the corresponding release is called.
That means that the OpenCharDevice type instance is dropped in
f_ops->release, even when the CharDevice type doesn't implement release,
so simple cleanup can happen in the drop implementation of the type
implementing the OpenCharDevice trait and will correctly be called on
release.

Cheers,
Josef

