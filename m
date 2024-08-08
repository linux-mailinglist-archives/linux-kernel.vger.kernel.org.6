Return-Path: <linux-kernel+bounces-279503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45394BE21
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCBC1C22F40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D5518CC00;
	Thu,  8 Aug 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="FbQWpyPN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E7EEA9;
	Thu,  8 Aug 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122185; cv=pass; b=G91Ba0sxRUtlGltNQZKh9lCAAYeYzNP+L1M0B0l8pjNlIoftXcy3+x6F2cHXt/PLJ1DBP8zBLFigYc9FKAS09InUT1cdhBuKgFC8daTTuK3sacL1VWFXuzzlC8khwB3ylLCt3agm9kpjupYHJ/VNnpROrezHssYhxvxFP0wEwWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122185; c=relaxed/simple;
	bh=8cXLudD3jlIVqEbOHp5lQPmmfgo28kZ6RDRU1ApMW3w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qv7OaBqetJPWYfmLvUzjKdIS6z7/5xeiwduCJMOpYpNucG6TS2W1QkfAVZZ49IJOMZXaYGWsAUKgPKb1bAhhRipgLU1WBCikvNNglp9VCR7D7PDObLmrT2+9XVddya21sMaJxvOXc0uhNDzL/5jcxXWrur8R/GJMmLRML5zs6xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=FbQWpyPN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723122135; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EtVf159KqLG1/xa7BMzTtcm0cffS51oaxocxSKwwjijUFZXW96oVJdqmi8/i3wni9gMOXnXNDZyKBd8gcYzbMMqj1/g/Fj8DmEiihxRaUZXlHY6omHsB5fRT22Op/+tyjRIjDmlOuBkvvOdrSDiuOicswNLOPKmZqt0QmpS0dhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723122135; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p6LfGa9J6fSCBWoMNVGPO1tGt+kDlRNB5yVGbNvsxxk=; 
	b=imyLF0rbIWv/uy3MpWEG6cXb3eNMDY/dxw7HjGu1LF22ugPBVjaWiU9ziTFYlDYNWVWiQtz22XJNWTfw3fBAsFgSRBYXoRZbng0DVDyxDzFErNGFTtyrxcF2LpTd7sj+YSl2VfNjgJ8g1NIoNYpUd4wwT56M2gZXIHy2zzncfeU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723122135;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=p6LfGa9J6fSCBWoMNVGPO1tGt+kDlRNB5yVGbNvsxxk=;
	b=FbQWpyPNLdYVYsl44ynqMC/Kci3bjxFNeS+K5NuXeF/9fWXOdjL2VQQnPR9AqBjY
	aQXMK0usZBfAzTifssWXN0kLdvWoztkRqv0r27pJKM8R36fPjTNlKsPFZqIUOZvD9vc
	aXpTzGrtfUtCoPSHg97+r3k3dCHLaGZ1pK+/qfco=
Received: by mx.zohomail.com with SMTPS id 1723122134264336.01001590107546;
	Thu, 8 Aug 2024 06:02:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <a5afc0ed-2193-42f2-a7ef-50fba68980a6@proton.me>
Date: Thu, 8 Aug 2024 10:01:55 -0300
Cc: Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEA74965-3ABB-42A4-AF0D-DC5D9E6CE7D3@collabora.com>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me>
 <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
 <a5afc0ed-2193-42f2-a7ef-50fba68980a6@proton.me>
To: Benno Lossin <benno.lossin@proton.me>
X-Mailer: Apple Mail (2.3774.600.62)
X-ZohoMailClient: External

Hi Benno,


> On 24 Jul 2024, at 17:31, Benno Lossin <benno.lossin@proton.me> wrote:
>=20
> On 19.07.24 18:24, Daniel Almeida wrote:
>> Hi Benno,
>>=20
>> It=E2=80=99s nice to see this shaping up. I do agree that it=E2=80=99s =
a bit of a wild
>> west right now.
>>=20
>> IMHO, we need a lint to enforce compliance, unless we plan to have =
every patch
>> reviewed by the RFL community, which is unrealistic as time goes =
forward. I
>> myself have forgotten to properly document unsafe blocks because =
it=E2=80=99s easy
>> to miss things when submitting more than a thousand LOC.
>>=20
>> A new clippy lint would make sense here, since we already have clippy =
support
>> in the kernel anyways.
>=20
> I definitely see the potential, but I have no experience writing =
clippy
> lints. I also have no idea if it can detect comments.
> I also think that a lint solution will be very difficult, since it =
will
> either have to be a full proof assistant that mathematically checks if
> the safety comments are correct, or we still need human review.
> I think that if people are more familiar with safety comments, it will
> be easier, it's just how one improves at coding.
>=20
> I don't want to reject formal verification from the get-go; on the
> contrary, I would like to see it applied more in the kernel. Rust has
> several different implementations, but I haven't yet taken an in-depth
> look at them. However, from my past experience with formal proof
> assistants, I have my doubts that everyday developers will pick them =
up
> more easily/in favor of just plain safety comments.
>=20
> I think that we should apply formal verification to those areas that
> have been shown to be very difficult to get right. We currently do not
> have enough Rust to have such areas, but when we do, it might be a
> powerful tool. But I don't see it becoming the norm for Rust code (but
> maybe I am wrong, and I would be very happy to be wrong in this
> instance).
>=20
> There are also several clippy lints [1] that we could start using:
> - missing_safety_doc
> - multiple_unsafe_ops_per_block
> - undocumented_unsafe_blocks
> - unnecessary_safety_comment
> - unnecessary_safety_doc
>=20
> I personally think we should enable all of them.
>=20
> [1]: https://rust-lang.github.io/rust-clippy/master/index.html#/safety
>=20
> What did you expect/wish for with a clippy lint? Is it already present
> or did you want something that verifies your safety comments?


Yeah, I wasn=E2=80=99t referring to formal verification, just a lint =
that will complain when
it finds an unsafe block that has no safety comments at all. The clippy =
lints you
listed should work fine and, IIUC, Miguel already has a patch to enable =
(some of) them,
so I don=E2=80=99t think any further action is needed.

>=20
>>> On 17 Jul 2024, at 19:12, Benno Lossin <benno.lossin@proton.me> =
wrote:
>>>=20
>>> `unsafe` Rust code in the kernel is required to have safety
>>> documentation. This is to ensure the correctness of `unsafe` code =
and is
>>> thus very important.
>>> However, at this point in time there does not exist a standard way =
of
>>> writing safety documentation. This leads to confusion, as authors
>>> struggle to find the right way to convey their desired intentions.
>>> Readers struggle with correctly interpreting the existing =
documentation.
>>>=20
>>> Add the safety standard that will document the meaning of safety
>>> documentation. This first document gives an overview of the problem =
and
>>> gives general information about the topic.
>>>=20
>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>> ---
>>> Documentation/rust/general-information.rst   |   1 +
>>> Documentation/rust/index.rst                 |   1 +
>>> Documentation/rust/safety-standard/index.rst | 246 =
+++++++++++++++++++
>>> 3 files changed, 248 insertions(+)
>>> create mode 100644 Documentation/rust/safety-standard/index.rst
>>>=20
>>> diff --git a/Documentation/rust/general-information.rst =
b/Documentation/rust/general-information.rst
>>> index e3f388ef4ee4..ddfe4e2e5307 100644
>>> --- a/Documentation/rust/general-information.rst
>>> +++ b/Documentation/rust/general-information.rst
>>> @@ -54,6 +54,7 @@ the same invocation used for compilation, e.g.::
>>> Please note that Clippy may change code generation, thus it should =
not be
>>> enabled while building a production kernel.
>>>=20
>>> +.. _rust-abstractions:
>>>=20
>>> Abstractions vs. bindings
>>> -------------------------
>>> diff --git a/Documentation/rust/index.rst =
b/Documentation/rust/index.rst
>>> index 46d35bd395cf..968e9aace301 100644
>>> --- a/Documentation/rust/index.rst
>>> +++ b/Documentation/rust/index.rst
>>> @@ -39,6 +39,7 @@ configurations.
>>>    quick-start
>>>    general-information
>>>    coding-guidelines
>>> +    safety-standard/index
>>>    arch-support
>>>    testing
>>>=20
>>> diff --git a/Documentation/rust/safety-standard/index.rst =
b/Documentation/rust/safety-standard/index.rst
>>> new file mode 100644
>>> index 000000000000..1cbc8d3dea04
>>> --- /dev/null
>>> +++ b/Documentation/rust/safety-standard/index.rst
>>> @@ -0,0 +1,246 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +.. highlight:: rust
>>> +
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +Rust Safety Standard
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +Safe Rust code cannot have memory related bugs. This is a guarantee =
by the Rust compiler. Of course
>>> +it is not without caveats: no compiler bugs, no bugs in the =
specification etc. But the possibly most
>>> +important caveat is that of ``unsafe`` code. ``unsafe`` code needs =
to follow certain rules in order
>>> +for safe code to enjoy the no-memory-bugs privilege. A simple =
example of such a rule is that
>>> +references must be valid for the duration of their lifetime. If any =
rule is violated, it can lead
>>> +to undefined behavior even in safe code! The term undefined =
behavior in Rust has a lot stricter
>>> +meaning than in C or C++: UB in Rust is totally forbidden. In C one =
might rely on the compiler
>>> +implementation to ensure correct code generation, but that is not =
the case for Rust. You can read
>>> +more about UB in Rust
>>> +`here =
<https://doc.rust-lang.org/reference/behavior-considered-undefined.html>`_=
.
>>> +
>>> +If ``unsafe`` code makes our life this difficult, one might ask the =
question "why do we even need
>>> +it?" and the answer to that is that it gives users an escape hatch =
to do things that the compiler
>>> +normally forbids. ``unsafe`` code is a tool that enables =
programmers to write more performant code,
>>> +or code that interacts with hardware or C. These things are =
particularly important in kernel
>>> +development.
>>> +
>>> +The most effective way to prevent issues in ``unsafe`` code is to =
just not write ``unsafe`` code in
>>> +the first place. That is why minimizing the amount of ``unsafe`` =
code is very important. For
>>> +example, drivers are not allowed to directly interface with the C =
side. Instead of directly
>>> +communicating with C functions, they interact with Rust =
abstractions. This concentrates the usage
>>> +of ``unsafe`` code, making it easy to fix issues, since only the =
abstraction needs to be fixed.
>>> +Abstractions also allow taking advantage of other Rust language =
features. Read more in
>>> +:ref:`rust-abstractions`.
>>=20
>> This is something that I think we should discuss at Kangrejos. I do =
not think
>> that we should set in stone that the kernel crate is the only place =
where
>> unsafe code is acceptable.
>=20
> Oh then I need to rephrase the above paragraph, since I don't meant to
> say that. What I want to say is this:
> (1) concentrate as much `unsafe` code as possible, and put it =
somewhere
>     where everyone can use it (ie the `kernel` crate)
> (2) abstract over common use-patterns of `unsafe` code via safe
>     abstractions
> (3) disallow access to *raw* `bindings::` function calls from drivers.
>=20
> =46rom what you write below, I think that we are on the same page for =
(1)
> and (2). What I want to accomplish with (3) is that we don't have =
hacky
> drivers that are just like a C driver with `unsafe` sprinkled
> throughout. If you want to do that, just write a C driver instead.
>=20
> As Alice already replied, there should be no issue with having an
> `unsafe` function in an Abstraction. But we should strive for them to =
be
> as few as possible.
>=20
>> I am in no way disagreeing with the use of safe abstractions, but I =
think we
>> should have abstractions where they make sense. This is the case in =
the vast
>> majority of times, but not in *all* of them.
>>=20
>> A simple example is a MMIO read or write. Should a driver be =
forbidden to call
>> readX/writeX for an address it knows to be valid? How can you =
possibly write an
>> abstraction for this, when the driver is the only one aware of the =
actual
>> device addresses, and when the driver author is the person with =
actual access
>> to the HW docs?
>=20
> One idea that I have in this concrete example would be to make the
> driver specify in exactly one place what the addresses are that are
> read/writeable. If there are devices with dynamic addresses, then we
> could additionally provide an `unsafe` API, but link to the safe one =
for
> people to prefer.
>=20
>> If a driver is written partially in Rust, and partially in C, and it =
gets a
>> pointer to some kcalloc=E2=80=99d memory in C, should It be forbidden =
to use unsafe
>> in order to build a slice from that pointer? How can you possibly =
design a
>> general abstraction for something that is, essentially, a =
driver-internal API?
>=20
> This also would be a good example for an exception of (3). In this =
case,
> you could still write a driver-specific abstraction that does =
everything
> under the hood and then every place in the driver can use the safe
> abstraction.
>=20
>> For these corner cases, a simple safety comment should suffice. By =
all means,
>> let's strive to push as much of the unsafe bits into the kernel =
crate. But,
>> IMHO, we shouldn=E2=80=99t treat Rust drivers as some unprivileged =
entity, they=E2=80=99re
>> also kernel code, after all.
>=20
> That is true, but I want to prevent that we just "ship it" and then a
> couple of days later it turns out that there was a good abstraction
> after all. I personally like to spend a lot of time thinking about =
safe
> abstractions before giving in to `unsafe`, but I understand that we =
need
> to find a balance. In the end, we can also always change things. But
> when something lands, it most of the time won't get people thinking
> about whether there is a better way of doing things. Not unless the
> status quo is annoying/burdensome, at which point it already "was too
> late", ie there could have been more thought at the beginning.
>=20
> ---
> Cheers,
> Benno

I see,

There has been extensive discussion about this topic in this series and =
I no
longer see any problems. Thanks everybody for all the clarification =
provided.

=E2=80=94 Daniel


