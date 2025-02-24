Return-Path: <linux-kernel+bounces-528706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6457A41B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96445189695E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819A12512CE;
	Mon, 24 Feb 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X48YGP+B"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B6158558;
	Mon, 24 Feb 2025 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393105; cv=none; b=E1oxokQDGRFnHdKGzJk/u5Qcu1w59HT0zXkECDxjzLTga2SEdJsPIkaA3l5jpXOSLqBo2QMsIlxMj5PphM3PykZ5l86wM9YJ9u6M0Qgypr2AM/C8PfSSqoPXwlCsbImKk9KL1YeFUmYBFPa+L+CKNcSWhAYNU1s34YJd60wc+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393105; c=relaxed/simple;
	bh=YEqwAb4jpfigQsG7TUy3nfN96kHKam8dsx5o2/l+LRc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/Fzs2ReMs9shyWPlj15/ZRSR1BvlUNBzUeyOpeGq3W1Ns+EIRLhLW2DzYCz3CtYGwr6S2+WWZfB++wvX4skUi8Km80uL23HbfvXFvcYJEla6K6w/n0qX5km14Gv5kXBv9/xHALUH9TRUp0OuMzavYQV9mW3Xu5nY3A2H98xeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=X48YGP+B; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740393093; x=1740652293;
	bh=CyvL81nQqc7Glcr/5M3NTDnb4ToLegoQ7u3L4LySJ0M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=X48YGP+BmWrP66qBQtOwFg1HuJMzimXUlkpUzhM3/RvuWcvyo7Tlcmx31hTTirfQt
	 SxHp8tfmFpwN7oCRCYyD9Pzr4bHe6XXXuOnipM4fgiaTqJcIl2FVYnFKvnqiGEHWrm
	 RiGtWUO864Rm8OHUWgMSJkWp0AAl9BEE7jV0BvBGtRf2/MuxjyjccPogppRnJK5EWL
	 x09j4bu3fTuSMWCsiaQC0wj9LpGFvce/yjahMGjdHKtACblUi85gyzxoK1qZkDV63S
	 d0m1s0Fz3Vm3j+A8OobmnGajACDLF1pqttIjB8Emb3vSJDLXrO/olSfiBfPe565dJU
	 H5/DFn/NrUPmQ==
Date: Mon, 24 Feb 2025 10:31:30 +0000
To: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me>
In-Reply-To: <CAFJgqgSNjF=LfrCNTH3GdYssXz9YG-AeCtpibejJ7Ywtx0m3HQ@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com> <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <20250224002745.7d7460a7.gary@garyguo.net> <CAFJgqgSNjF=LfrCNTH3GdYssXz9YG-AeCtpibejJ7Ywtx0m3HQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9760e1a328d1ec9880efa1afb336abcc8ff10c8a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.02.25 10:57, Ventura Jack wrote:
> On Sun, Feb 23, 2025 at 5:27=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> On Sun, 23 Feb 2025 08:30:06 -0700
>> Ventura Jack <venturajack85@gmail.com> wrote:
>>
>>> - In unsafe Rust, it is the programmer's responsibility
>>>     to obey the aliasing rules, though the type system
>>>     can offer limited help.
>>> - The aliasing rules in Rust are possibly as hard or
>>>     harder than for C "restrict", and it is not possible to
>>>     opt out of aliasing in Rust, which is cited by some
>>>     as one of the reasons for unsafe Rust being
>>>     harder than C.
>>
>> The analogy is correct, you can more or less treat all Rust references
>> a `restrict` pointers. However it is possible to opt out, and it is
>> done at a per-type basis.
>>
>> Rust provides `UnsafeCell` to make a immutable reference mutable (i.e.
>> "interior mutability"), and this makes `&UnsafeCell<T>` behaves like
>> `T*` in C.
>>
>> There's another mechanism (currently under rework, though) that makes a
>> mutable reference behave like `T*` in C.
>>
>> RfL provides a `Opaque` type that wraps these mechanisms so it
>> absolutely cancel out any assumptions that the compiler can make about
>> a pointer whatsoever. For extra peace of mind, this is used for all
>> data structure that we share with C.
>>
>> This type granularity is very useful. It allows selective opt-out for
>> harder to reason stuff, while it allows the compiler (and programmers!)
>> to assume that, say, if you're dealing with an immutable sequence of
>> bytes, then calling an arbitrary function will not magically change
>> contents of it.
>>
>> Best,
>> Gary
>=20
> In regards to `UnsafeCell`, I believe that you are correct in regards
> to mutability. However, if I understand you correctly, and if I
> am not mistaken, I believe that you are wrong about `UnsafeCell`
> making it possible to opt-out of the aliasing rules. And thus that
> `UnsafeCell` does not behave like `T*` in C.

`UnsafeCell<T>` does not behave like `T*` in C, because it isn't a
pointer. Like Gary said, `&UnsafeCell<T>` behaves like `T*` in C, while
`&mut UnsafeCell<T>` does not. That is what you quote from the docs
below. (Those ampersands mark references in Rust, pointers that have
additional guarantees [1])

For disabling the uniqueness guarantee for `&mut`, we use an official
"hack" that the Rust language developers are working on replacing with
a better mechanism (this was also mentioned by Gary above).

[1]: https://doc.rust-lang.org/std/primitive.reference.html

> Documentation for `UnsafeCell`:
>     https://doc.rust-lang.org/std/cell/struct.UnsafeCell.html
>=20
>     "Note that only the immutability guarantee for shared
>     references is affected by `UnsafeCell`. The uniqueness
>     guarantee for mutable references is unaffected. There is no
>     legal way to obtain aliasing `&mut`, not even with `UnsafeCell<T>`."
>=20
>     "Note that whilst mutating the contents of an `&UnsafeCell<T>`
>     (even while other `&UnsafeCell<T>` references alias the cell) is
>     ok (provided you enforce the above invariants some other way),
>     it is still undefined behavior to have multiple
>     `&mut UnsafeCell<T>` aliases."
>=20
> The documentation for `UnsafeCell` is long, and also mentions
> that the precise aliasing rules for Rust are somewhat in flux.
>=20
>     "The precise Rust aliasing rules are somewhat in flux, but the
>     main points are not contentious:"
>=20
> In regards to the `Opaque` type, it looks a bit like a C++
> "smart pointer" or wrapper type, if I am not mistaken.

It is not a smart pointer, as it has nothing to do with allocating or
deallocating. But it is a wrapper type that just removes all aliasing
guarantees if it is placed behind a reference (be it immutable or
mutable).

> Documentation and related links for `Opaque`:
>     https://rust.docs.kernel.org/kernel/types/struct.Opaque.html
>     https://rust.docs.kernel.org/src/kernel/types.rs.html#307-310
>     https://github.com/Rust-for-Linux/pinned-init
>=20
> It uses `UnsafeCell`, Rust "pinning", and the Rust for Linux library
> "pinned-init".

pinned-init is not specific to `Opaque` and not really relevant with
respect to discussing aliasing guarantees.

> "pinned-init" uses a number of experimental, unstable and nightly
> features of Rust.

This is wrong. It uses no unstable features when you look at the version
in-tree (at `rust/kernel/init.rs`). The user-space version uses a single
unstable feature: `allocator_api` for accessing the `AllocError` type
from the standard library. You can disable the `alloc` feature and use
it on a stable compiler as written in the readme.

> Working with the library implementation requires having a good
> understanding of unsafe Rust and many advanced features of Rust.

pinned-init was explicitly designed such that you *don't* have to write
unsafe code for initializing structures that require pinning from the
get-go (such as the kernel's mutex). Yes, at some point you need to use
`unsafe` (eg in the `Mutex::new` function), but that will only be
required in the abstraction.
I don't know which "advanced features of Rust" you are talking about,
since a user will only need to read the docs and then use one of the
`[try_][pin_]init!` macros to initialize their struct.
(If you have any suggestions for what to improve in the docs, please let
me know. Also if you think something isn't easy to understand also let
me know, then I might be able to improve it. Thanks!)

> `Opaque` looks interesting. Do you know if it will become a more
> widely used abstraction outside the Linux kernel?

Only in projects that do FFI with C/C++ (or other such languages).
Outside of that the `Opaque` type is rather useless, since it disables
normal guarantees and makes working with the inner type annoying.

---
Cheers,
Benno


