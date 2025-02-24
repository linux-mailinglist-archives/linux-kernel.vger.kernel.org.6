Return-Path: <linux-kernel+bounces-530153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A56A42FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BEC3ADB50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DD1EC00B;
	Mon, 24 Feb 2025 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lLhtkzS2"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFAB15886C;
	Mon, 24 Feb 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434599; cv=none; b=MlKSCVSv4gXlC8/4LB3SmyJoVIxooIpA52UMqTN/qScQ8hQj6Tx52NV1CW4M0oXDdMHmSYM3aWgIgh2NGvg27oZRRSDSkJOB+2R7VxXBqQe9alVBNRzk2qO8IM0FigMB2g3hrTKjSBO33HyyfcMJ4oKRhvqVOzR2DU+eHPUBK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434599; c=relaxed/simple;
	bh=0+lZeYh5KRqhrNQ4J545nW8JrcC2WLfHJWxxmcCyMKQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCWXN3HQopXYotl6Xjhs0Ek2gLCoiN/xxR+lgNUYW44Sw4+8k2zr+sgHaL8ONFo2rg0yzcGMvZFOH1PQ1V+leZiCdv/iFB33sKML9G2GL/y8IQCUAGvpRJxAPPqQlMnOmlUOHGGaxEufin6ieymYZNsDobke0w25eBdWH2E4hDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lLhtkzS2; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740434593; x=1740693793;
	bh=olEumxK8qJ3sAV3kNUy7sNVzCLyVSpG2PZ8OZGIVLPc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lLhtkzS2ihZNhyl7Ws23MV1aGiZWppJk1AwV07aMO8PZv5PbIEwJvj0+2CVfgmTie
	 kEpejzjnxfBGmo+aQVYqKE8SP+KRrx8ILRWRN5vAgxM3UXTbab/xHpdbY3+H8d0YXm
	 3O55B35NVLVL5I4PqdRRor4qdfyPUGYepYFbCfuOtV9qS5y+l/3VyiPeYkf6JPDqAZ
	 oCxZIPTSMpGx642rCBVhWOPpE357Ee0Y56Ph3TErGl9POPG8y661WRK6ZZxomRsrQ0
	 Ys7/XaJ+eDauU0ONWvgVZ957S9efDg/29kZ9hams+ATVwIYt+KrRZkSWcmOqPT7U/8
	 ydaAu5L09U07g==
Date: Mon, 24 Feb 2025 22:03:04 +0000
To: Ventura Jack <venturajack85@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <c05cb400-969d-44a1-bd40-9b799ed894d7@proton.me>
In-Reply-To: <CAFJgqgRdiQ29bWvwsu11yokZb4OFF7pYYUU=ES6CYv9847KgVg@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <20250224002745.7d7460a7.gary@garyguo.net> <CAFJgqgSNjF=LfrCNTH3GdYssXz9YG-AeCtpibejJ7Ywtx0m3HQ@mail.gmail.com> <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me> <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com> <a4b79751-f1c8-4476-98a5-c59fb2e545ad@proton.me> <CAFJgqgRdiQ29bWvwsu11yokZb4OFF7pYYUU=ES6CYv9847KgVg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f98767773a4618dd148240bae5aa0217d42042e2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.02.25 17:57, Ventura Jack wrote:
> On Mon, Feb 24, 2025 at 5:47=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 24.02.25 13:21, Ventura Jack wrote:
>>>
>>> From what I can see in the documentation, `&UnsafeCell<T>` also does no=
t
>>> behave like `T*` in C. In C, especially if "strict aliasing" is turned
>>> off in the
>>> compiler, `T*` does not have aliasing requirements. You can have multip=
le
>>> C `T*` pointers pointing to the same object, and mutate the same object=
.
>>
>> This is true for `&UnsafeCell<T>`. You can have multiple of those and
>> mutate the same value via only shared references. Note that
>> `UnsafeCell<T>` is `!Sync`, so it cannot be shared across threads, so
>> all of those shared references have to be on the same thread. (there is
>> the `SyncUnsafeCell<T>` type that is `Sync`, so it does allow for
>> across-thread mutations, but that is much more of a footgun, since you
>> still have to synchronize the writes/reads)
>>
>>> The documentation for `UnsafeCell` conversely spends a lot of space
>>> discussing invariants and aliasing requirements.
>>
>> Yes, since normally in Rust, you can either have exactly one mutable
>> reference, or several shared references (which cannot be used to mutate
>> a value). `UnsafeCell<T>` is essentially a low-level primitive that can
>> only be used with `unsafe` to build for example a mutex.
>>
>>> I do not understand why you claim:
>>>
>>>     "`&UnsafeCell<T>` behaves like `T*` in C,"
>>>
>>> That statement is false as far as I can figure out, though I have taken=
 it
>>> out of context here.
>>
>> Not sure how you arrived at that conclusion, the following code is legal
>> and sound Rust:
>>
>>     let val =3D UnsafeCell::new(42);
>>     let x =3D &val;
>>     let y =3D &val;
>>     unsafe {
>>         *x.get() =3D 0;
>>         *y.get() =3D 42;
>>         *x.get() =3D 24;
>>     }
>>
>> You can't do this with `&mut i32`.
>=20
> I think I see what you mean. The specific Rust "const reference"
> `&UnsafeCell<T>` sort of behaves like C `T*`. But you have to get a
> Rust "mutable raw pointer" `*mut T` when working with it using
> `UnsafeCell::get()`.

Exactly, you always have to use a raw pointer (as a reference would
immediately run into the aliasing issue), but while writing to the same
memory location, another `&UnsafeCell<T>` may still exist.

> And you have to be careful with lifetimes if you
> do any casts or share it or certain other things. And to dereference a
> Rust "mutable raw pointer", you must use unsafe Rust. And you have to
> understand aliasing.

Yes.

> One example I tested against MIRI:
>=20
>     use std::cell::UnsafeCell;
>=20
>     fn main() {
>=20
>         let val: UnsafeCell<i32> =3D UnsafeCell::new(42);
>         let x: & UnsafeCell<i32> =3D &val;
>         let y: & UnsafeCell<i32> =3D &val;
>=20
>         unsafe {
>=20
>             // UB.
>             //let pz: & i32 =3D & *val.get();
>=20
>             // UB.
>             //let pz: &mut i32 =3D &mut *val.get();
>=20
>             // Okay.
>             //let pz: *const i32 =3D &raw const *val.get();
>=20
>             // Okay.
>             let pz: *mut i32 =3D &raw mut *val.get();
>=20
>             let px: *mut i32 =3D x.get();
>             let py: *mut i32 =3D y.get();
>=20
>             *px =3D 0;
>             *py +=3D 42;
>             *px +=3D 24;
>=20
>             println!("x, y, z: {}, {}, {}", *px, *py, *pz);
>         }
>     }
>=20
> It makes sense that the Rust "raw pointers" `*const i32` and `*mut
> i32` are fine here, and that taking Rust "references" `& i32` and
> `&mut i32` causes UB, since Rust "references" have aliasing rules that
> must be followed.

So it depends on what exactly you do, since if you just uncomment one of
the "UB" lines, the variable never gets used and thus no actual UB
happens. But if you were to do this:

    let x =3D UnsafeCell::new(42);
    let y =3D unsafe { &mut *x.get() };
    let z =3D unsafe { &*x.get() };
    println!("{z}");
    *y =3D 0;
    println!("{z}");

Then you have UB, since the value that `z` points at changed (this is
obviously not allowed for shared references [^1]).


[^1]: Except of course values that lie behind `UnsafeCell` inside of the
      value. For example:

      struct Foo {
          a: i32,
          b: UnsafeCell<i32>,
      }

      when you have a `&Foo`, you can be sure that the value of `a`
      stays the same, but the value of `b` might change during the
      lifetime of that reference.

---
Cheers,
Benno


