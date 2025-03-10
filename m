Return-Path: <linux-kernel+bounces-554631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F944A59AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4053A9570
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFD822F16F;
	Mon, 10 Mar 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="oSf6XTIW"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC322A7FA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622959; cv=none; b=HLPa6pWrlevEVhYfYe3VJUeEVIE4L99Cx9LIvakZ6SKvCDVHmJw4ZN+2hLFS18Eajpbsx0Lb6NElPvPHz2O8f2LCBdkji/V94Icx0jWa9g1WTN12lfEsC+zet/wFJEILWVML8eW8MKdJXOAMorTwhr8iZjPM4Tha8PMp1BOQZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622959; c=relaxed/simple;
	bh=D4Vb33RNqJrJxqz1esDLVLlIZGIk1xCNfU2hCUsdZEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsVLlFte+mMlaiQcRQSYVwqHPPlxPZShHIB35seU/uDufZXyvY6uRzCWrGfJH4bZf+IWQH9CfnNuQ+bEsAMRdEQwUAHvL+8WNp+lPzE02sr8/jNN51ubtmzijQSjbGXAyzlm791MBZapOm3XkezMN7eYIAwGa8/4fcP44zymGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=oSf6XTIW; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id BD6EA240028
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741622953; bh=D4Vb33RNqJrJxqz1esDLVLlIZGIk1xCNfU2hCUsdZEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=oSf6XTIWaf3kcYQPaXMyBvlku3naljwgcKCOjL5MTN4HmVbS5lbHjF/GKS48lQQr2
	 PQ2IfKNhDK4jgdtVSg87waMP0yJY0TTtZHsWObWvgzub2koRmXtfOX1Q2RuSD6ZNAH
	 slqAAmiBvgwIo6CR+7O1ysgyY1099U8LOFLJMI7LdOag7lwq2OLFB4bp2wJc870EXd
	 b9o4x83uoPOxzfslQWoCea50q4BhyjDaqV+rvV+/C2cjVyHFs7YBXnoI6Xsw7dO0yr
	 G+Hx4Q28I39qEATaSViavXZGuO5smlGIH/q73/1+uA473TOBdA5mUzYq+w9UCNacv2
	 pChMtSUKN5xOQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZBMK161dtz6tvZ;
	Mon, 10 Mar 2025 17:09:09 +0100 (CET)
Message-ID: <87725b0d-42e9-4273-a51f-90c82aad2254@posteo.net>
Date: Mon, 10 Mar 2025 16:09:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rust: task: mark Task methods inline
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250310-inline-c-wrappers-v1-1-d726415e6332@posteo.net>
 <CAH5fLgi1YOP9gbXEmYfBtjWeMaqsYpNrrC1fd2rGABCKWYVcbg@mail.gmail.com>
Content-Language: en-US
From: Panagiotis Foliadis <pfoliadis@posteo.net>
In-Reply-To: <CAH5fLgi1YOP9gbXEmYfBtjWeMaqsYpNrrC1fd2rGABCKWYVcbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/3/25 12:23, Alice Ryhl wrote:
> On Mon, Mar 10, 2025 at 10:40 AM Panagiotis Foliadis
> <pfoliadis@posteo.net> wrote:
>> When you build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
>> toolchain provided by kernel.org, the following symbols are generated:
>>
>> $ nm vmlinux | grep ' _R'.*Task | rustfilt
>> ffffffff817b2d30 T <kernel::task::Task>::get_pid_ns
>> ffffffff817b2d50 T <kernel::task::Task>::tgid_nr_ns
>> ffffffff817b2c90 T <kernel::task::Task>::current_pid_ns
>> ffffffff817b2d00 T <kernel::task::Task>::signal_pending
>> ffffffff817b2cc0 T <kernel::task::Task>::uid
>> ffffffff817b2ce0 T <kernel::task::Task>::euid
>> ffffffff817b2c70 T <kernel::task::Task>::current
>> ffffffff817b2d70 T <kernel::task::Task>::wake_up
>> ffffffff817b2db0 T <kernel::task::Task as kernel::types::AlwaysRefCounted>::dec_ref
>> ffffffff817b2d90 T <kernel::task::Task as kernel::types::AlwaysRefCounted>::inc_ref
>>
>> Most of these Rust symbols are trivial wrappers around the C functions
>> signal_pending, uid, euid, wake_up, dec_ref and inc_ref.It doesn't
>> make sense to go through a trivial wrapper for these functions, so
>> mark them inline.
> There's no C function called dec_ref or inc_ref? Please use the C
> function names instead of the Rust ones.
>
>> After applying this patch, the above command will produce this output:
>>
>> ffff8000805aa004 T <kernel::task::Task>::get_pid_ns
>> ffff8000805aa01c T <kernel::task::Task>::tgid_nr_ns
>> ffff8000805a9fe8 T <kernel::task::Task>::current_pid_ns
>> ffff8000805a9fd0 T <kernel::task::Task>::current
> I think it'd be nice with an explanation of why you did not mark these
> #[inline].

Since the issue focuses on the functions that are trivial wrappers around
c and `do nothing that call a C function` I thought i would leave this out
since there is some other functionality (albeit sometimes minimal) other
that being just a c-wrapper.

>
>> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> The SoB usually goes at the bottom of the tags.
>
>>   rust/kernel/task.rs | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
>> index 07bc22a7645c0c7d792a0a163dd55b8ff0fe5f92..996d7c96e48689a5752817f9ca196c021865291d 100644
>> --- a/rust/kernel/task.rs
>> +++ b/rust/kernel/task.rs
>> @@ -273,18 +273,21 @@ pub fn pid(&self) -> Pid {
>>       }
>>
>>       /// Returns the UID of the given task.
>> +    #[inline]
>>       pub fn uid(&self) -> Kuid {
>>           // SAFETY: It's always safe to call `task_uid` on a valid task.
>>           Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
>>       }
>>
>>       /// Returns the effective UID of the given task.
>> +    #[inline]
>>       pub fn euid(&self) -> Kuid {
>>           // SAFETY: It's always safe to call `task_euid` on a valid task.
>>           Kuid::from_raw(unsafe { bindings::task_euid(self.as_ptr()) })
>>       }
>>
>>       /// Determines whether the given task has pending signals.
>> +    #[inline]
>>       pub fn signal_pending(&self) -> bool {
>>           // SAFETY: It's always safe to call `signal_pending` on a valid task.
>>           unsafe { bindings::signal_pending(self.as_ptr()) != 0 }
>> @@ -319,6 +322,7 @@ pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
>>       }
>>
>>       /// Wakes up the task.
>> +    #[inline]
>>       pub fn wake_up(&self) {
>>           // SAFETY: It's always safe to call `signal_pending` on a valid task, even if the task
>>           // running.
>> @@ -328,11 +332,13 @@ pub fn wake_up(&self) {
>>
>>   // SAFETY: The type invariants guarantee that `Task` is always refcounted.
>>   unsafe impl crate::types::AlwaysRefCounted for Task {
>> +    #[inline]
>>       fn inc_ref(&self) {
>>           // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>>           unsafe { bindings::get_task_struct(self.as_ptr()) };
>>       }
>>
>> +    #[inline]
>>       unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>>           // SAFETY: The safety requirements guarantee that the refcount is nonzero.
>>           unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
>>
>> ---
>> base-commit: 7f0e9ee5e44887272627d0fcde0b19a675daf597
>> change-id: 20250308-inline-c-wrappers-da83ec1c2a77
>>
>> Best regards,
>> --
>> Panagiotis Foliadis <pfoliadis@posteo.net>
>>


