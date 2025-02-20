Return-Path: <linux-kernel+bounces-523819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3407EA3DBB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B717AAB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211D1FF7A0;
	Thu, 20 Feb 2025 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CuMISBEn"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450B1FCF7C;
	Thu, 20 Feb 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059358; cv=pass; b=NFmNFV30dFGmYX/BgzMlFOVjTP/ednKkgL4c8xsWLhtEwV1qp7mxxcnA/MXQAoagPw9W8rxpQ/I3PffgVbJT1vaaVj5sgk/6Tt940aSBD07QhMZWr7wH3iEsIGvgLa/sHhoDVeJpsdnAN4jTcnb/oSwg0ytt6T7OTaxml7C6yDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059358; c=relaxed/simple;
	bh=sAItakCC+ihqDayZZe3hHiON83+dti11YznYUnH5Skw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kuJcRAGfJlFAN0UYDaE5OFDmFqeHUpCrXSw/TWS87oJ5THVebArlvjDb3z8GL6aSFlLb+to7Ra7sTgHD+6Ua3SNGi5x+ngSPfVMrw9Qdkwv6YuerTwxnmHpz7LMHM45lUl9s1v3DiryExn5L8rcQm2NXGwl6ME2U3hrWlPpQGOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=CuMISBEn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740059331; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FD0AWTgHte3ctO5Qht9ky6kIu2p8LYN1A6pRSFPdf3EOAa/+Px/p+UxOTm/E3TkWvxcmVmZ8G5GHkxctbokgGkucOoM+CrODa9jgY7xMpIMsSq3LZ8EWj3rSXMiEQElzhJ0UPlPgS7lNGgBkKoNxX6KztlA/foWgVtnojMIb6Ao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740059331; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WF6vfyJp4QhpNjr/nJ2H9NjFuFzr9IejWmcU1daW58E=; 
	b=HuTKH4l8NemCRYp1fgEp9r7cjHMqbZOaPcoGnYYDFuc6Jdt1VrMO0Zh16Iynvx6Qg74KUEu8Km+jqOVnh4+VKdxCjE2dJ/n+k2fUeHkwXd+5JyobWvds76PSy+QiI4aZun1n5tVpou9UMeOANuPBr0iYr0cKNpIhqwXKjBrBqPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740059331;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=WF6vfyJp4QhpNjr/nJ2H9NjFuFzr9IejWmcU1daW58E=;
	b=CuMISBEnx9nE8jG4HYbG0gSeRus5czuVGGFsWtJZIa1dKcbo+8RMwgDHYZJ4cjmY
	7zzyHbPXzRovOLr01S0yMgks15KB6TBYpeRVTrlirBbova5aEaNWeyDq3z/skRHosWb
	St0XqjDnpLcWkveUw2nc0SAjt08Pf6jiUROsV0f4=
Received: by mx.zohomail.com with SMTPS id 1740059328558287.2716659174573;
	Thu, 20 Feb 2025 05:48:48 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <Z7cbkfvJqkWaSwKR@finisterre.sirena.org.uk>
Date: Thu, 20 Feb 2025 10:48:31 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 lgirdwood@gmail.com,
 sebastian.reichel@collabora.com,
 sjoerd.simons@collabora.co.uk,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org,
 benno.lossin@proton.me,
 tmgross@umich.edu,
 dakr@kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <53A50677-CB35-441F-8E58-0FB1EA577C4E@collabora.com>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <CAH5fLgiErvnziU-hSCV6djNq7Q56ZfX9gZudmX7+r06hWoX0Tw@mail.gmail.com>
 <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>
 <Z7cbkfvJqkWaSwKR@finisterre.sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External



> On 20 Feb 2025, at 09:09, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Wed, Feb 19, 2025 at 02:10:24PM -0300, Daniel Almeida wrote:
>=20
>> This means that now, `EnabledRegulator` has to depend on `Regulator` =
somehow to ensure
>> a proper drop order. Otherwise you might have an enabled regulator =
for which you don=E2=80=99t own
>> the refcount. Furthermore, if Regulator drops while EnabledRegulator =
is alive, you get a splat.
>=20
> Having an enabled regulator object depend on a regulator object seems
> like a goal rather than a problem, surely it's common to need such
> relationships and there's an idiomatic way to do it?  It seems to be =
how
> Rust does mutexes=E2=80=A6

Not when you need to store both of them at the same time.

For Mutex<T>, for example, you don=E2=80=99t store both Mutex<T> and =
MutexGuard<'_,T>
at the same time. You store a Mutex<T>, and create MutexGuard<'_, T> on =
the
stack by locking the Mutex when you need to access T. When MutexGuard =
goes away,
the Mutex is automatically unlocked.

The equivalent behavior for us here would be to enable a regulator on =
the
stack, perform some work, and then have this regulator be automatically
disabled. There would be no way to keep it enabled for a longer period.

>=20
>> In a driver, you now have to store both Regulator - for the refcount =
- and EnabledRegulator
>> - as a way to tell the system you need that regulator to be active.
>=20
> That's true, unless you can make a type of enable that just fully =
takes
> ownership of the regulator (which TBH people want, people really want =
a
> devm_regulator_get_enable() C API which just gets and holds an enabled
> regulator for the simple case where you don't actually ever manage the
> power).  It's possible there's a need to split simple and complex
> consumer APIs in Rust?
>=20
>> If EnabledRegulator is a guard type, this doesn=E2=80=99t work, as it =
creates a self-reference - on top
>> of being extremely clunky.
>>=20
>> You can then have EnabledRegulator consume Regulator, but this =
assumes that the regulator
>> will be on all the time, which is not true. A simple pattern of
>=20
> I don't understand the self reference thing?

It=E2=80=99s a Rust thing.

Let=E2=80=99s say you have this:

```
let regulator: Regulator =3D Regulator::get(/*=E2=80=A6*/)?;
let regulator_enable: EnabledRegulator =3D regulator.enable()?;
```

You can encode that `EnabledRegulator` depends on Regulator, i.e.: that =
it must
not outlive it:

```
struct EnabledRegulator<=E2=80=98a>(&=E2=80=99a Regulator);

<snip>=20

impl Regulator {
  pub fn enable(&self) -> Result<EnabledRegulator<=E2=80=98_>> {
    /* do the work to enable, error check, etc, then.. */
   =20
    EnabledRegulator(&self) // EnabledRegulator keeps a reference to =
Regulator
  }
}
```

Now the compiler will enforce that EnabledRegulator doesn=E2=80=99t =
outlive
Regulator:

```
let regulator =3D Regulator::get(/*=E2=80=A6*/)?;
let enabled_regulator =3D regulator.enable()?;

 // error: regulator is needed by enabled_regulator, so you can=E2=80=99t =
do this.
core::mem::drop(regulator);
```

This is fine on the stack, but if you want to store both of them in a =
struct,
that is a problem.

```
struct Foo {
  // A refcount obtained by regulator_get()
  regulator: Regulator,
  =20
  // Indicates that the regulator is enabled.
  enabled: EnabledRegulator<=E2=80=98a>  // error: what is =E2=80=98a ?
}=20
```

Now `enabled` contains an internal reference to `regulator`, which is a =
sibling
member.

This is where my =E2=80=9Cself-reference=E2=80=9D comment comes from, =
i.e.: Foo has a
member that has a reference to another member of Foo itself.

The problem here is that Rust has move semantics by default. If you =
allow a
struct to keep a reference to parts of itself, this breaks when the type =
is
moved. In other words, if Foo is ever moved, `enabled` would contain a
reference to the location it was moved from, which would be unsound.

There is no way to fix this, because, unlike C++, Rust does not have =
move
constructors, move assignments and etc. Here, moving means a bitwise =
copy from
address A to B, where A is then invalidated. This means that =
self-references
are simply disallowed. (Well, there is Pin<T>, but let's not get into =
that)

Note that, in this particular example, we never access this reference, =
it's
there just to tell the compiler that we need a Regulator to be alive in =
order
for a EnabledRegulator to exist. It does not matter though, it still =
won't
compile.

Even if we use the PhantomData type, which doesn't store a reference to =
the
actual memory location within it, just the lifetime itself, it will =
still not
work for the same reason. At no point can you create a self-referential
type even when there is no actual memory location involved.


I am not saying that we cannot encode this relationship through some =
other
means. I am merely saying that doing it *this way* will not work.

>=20
>> ```
>> regulator_enable()
>> do_fancy_stuff()
>> regulator_disable()
>> ```
>=20
>> Becomes a pain when one type consumes the other:
>>=20
>> ```
>> self.my_regulator.enable() // error, moves out of `&self`
>> ```
>=20
> Your second block of code doesn't look obviously painful there?

It is painful in the sense that it won=E2=80=99t even compile.

This example assumes a different API where EnabledRegulator consumes =
Regulator
to exist, instead of keeping an internal reference:

```
impl Regulator {
  // Note that we take `self`, not `&self`, so this moves `Regulator` =
into
  // `enable()`, therefore 'killing' it.

  fn enable(self) -> Result<EnabledRegulator> {

    /* enable, do error checking, etc, and then */

    EnabledRegulator(self) // We transformed Regulator into =
EnabledRegulator.
  }
}

In our struct Foo example, this would move the Regulator out of the =
field, i.e.:

```
let foo =3D Foo { regulator: Regulator::get(/*...*/)?; };

let regulator_enabled =3D foo.regulator.enable()?;
```

This is an error, because if we move out of foo.regulator to create
EnabledRegulator, then what would be left in there?

We can get around this using Option<T>:

```
let foo =3D Foo { regulator: Some(Regulator::get(/*...*/)?); };

let regulator_enabled =3D foo.regulator.take()?.enable()?;
```

But this is extremely unergonomic because Option<T> is meant for cases =
where we
may or may not have something, but this is not the case here. We're =
simply
abusing its API to make our own Regulator API work.

>=20
>> I am sure we can find ways around that, but a simple `bool` here =
seems to fix this problem.
>=20
>> Now you only have to store `Regulator`. If you need another part of =
your code to also keep
>> the regulator enabled, you store a `Regulator` there and enable that =
as well. All calls to
>> enable and disable will be automatically balanced for all instances =
of `Regulator` by
>> virtue of the `enabled` bool as well.
>=20
> What you're describing here with creating one Regulator object per
> enable sounds more like you want it to be an error to do multiple
> enables on a single regulator.  Instead of reference counting or
> silently ignoring duplicate enables it should error out on a duplicate
> enable.

The problem here isn't necessarily forbiding multiple enables, but =
figuring out
a way to make sure they are balanced in Rust. Let me think this through =
some
more, because I do not have a solution in hand right now.

=E2=80=94 Daniel=

