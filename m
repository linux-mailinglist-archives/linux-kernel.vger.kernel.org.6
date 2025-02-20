Return-Path: <linux-kernel+bounces-524081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7203FA3DEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C783A690D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD91FE474;
	Thu, 20 Feb 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="fUEQkiaE"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98B1D6DC8;
	Thu, 20 Feb 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066015; cv=none; b=A3thHlxYnxFoEHmbqibY14ZQplDPQMtUfn1gX6tGFEHmOLM3nipUWUFEiLJ8hlPEGSjYX7AIjcazj0+UeK5jU3DIFItakHVK1lNlK5mP7WlP2BNvhjnpeOcW3zlhSD+K/rGdb+g68R5CeJux0VU9pFQWumPjRUzIaWwAs9nPWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066015; c=relaxed/simple;
	bh=HQ+1mutm60Ud2y0SLA8D3qqRkO88l0Xb6pTwlKL+pPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iw3OEKJj8QKY3wKHWWX3s/BEnsL5Nj2/b7qcLvGIAG5JH0MeubMV7tTdsk2NNmdUbGZCC+YUJNFiny+vm7YwduXkUbzPOvX552bJRXDV1OWh7LpzVGw9McWHUJx8bYrl5n02rNllygEaVIjHSC9pONfFJnmcbCTcDW9L0tgLI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=fUEQkiaE; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-197.tugraz.at (vra-171-197.tugraz.at [129.27.171.197])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4YzHWl0X09z1HNLY;
	Thu, 20 Feb 2025 16:40:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4YzHWl0X09z1HNLY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740066004;
	bh=adBc/y/Yrkupx3Ys/bczlm0TmSuRb7eig8obCOsmeXs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fUEQkiaE1jXyufROPVAT4k6lH48E2sPdVcaASySNef8i3DwR3XtE+dAbwJUWejQ4k
	 N2upU7nWbuYQvH7KIUVUJr3OtZr02h/ArGUv6uAe5YdRwpqMDuKHeJ0yY7ztlPCFwj
	 lerLm77PTj5B+WQIb3xkNFEe0lY/oFxKjHzf4zk0=
Message-ID: <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>,  David Airlie
 <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Thu, 20 Feb 2025 16:40:02 +0100
In-Reply-To: <2025022042-jot-favored-e755@gregkh>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	 <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh>
	 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	 <2025022024-blooper-rippling-2667@gregkh>
	 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	 <2025022042-jot-favored-e755@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116

Am Donnerstag, dem 20.02.2025 um 15:53 +0100 schrieb Greg KH:
> On Thu, Feb 20, 2025 at 09:57:29AM +0100, Martin Uecker wrote:
> > Am Donnerstag, dem 20.02.2025 um 08:10 +0100 schrieb Greg KH:
> > > On Thu, Feb 20, 2025 at 08:03:02AM +0100, Martin Uecker wrote:
> > > > Am Mittwoch, dem 19.02.2025 um 06:39 +0100 schrieb Greg KH:
> > > > > On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> > > > > > On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> > > > > > [...]
> > > > > > > > >=20
> > > > ...
> > > > >=20
> > > > >=20
> > > > > I'm all for moving our C codebase toward making these types of pr=
oblems
> > > > > impossible to hit, the work that Kees and Gustavo and others are =
doing
> > > > > here is wonderful and totally needed, we have 30 million lines of=
 C code
> > > > > that isn't going anywhere any year soon.  That's a worthy effort =
and is
> > > > > not going to stop and should not stop no matter what.
> > > >=20
> > > > It seems to me that these efforts do not see nearly as much attenti=
on
> > > > as they deserve.
> > >=20
> > > What more do you think needs to be done here?  The LF, and other
> > > companies, fund developers explicitly to work on this effort.  Should=
 we
> > > be doing more, and if so, what can we do better?
> >=20
> > Kees communicates with the GCC side and sometimes this leads to
> > improvements, e.g. counted_by (I was peripherily involved in the
> > GCC implementation). But I think much much more could be done,
> > if there was a collaboration between compilers, the ISO C working
> > group, and the kernel community to design and implement such
> > extensions and to standardize them in ISO C.
>=20
> Sorry, I was referring to the kernel work happening here by Kees and
> Gustavo and others.  Not ISO C stuff, I don't know of any company that
> wants to fund that :(

My point is that the kernel work could probably benefit from better
compiler support and also ISO C work to get proper language extensions,
because otherwise it ends up as adhoc language extensions wrapped in
macros. =C2=A0For example, we now can do today

#define __counted_by(len) __attribute__((counted_by(len)))
struct foo {
  int len;
  char buf[] __counted_by(len);
};=20

in GCC / clang, but what we are thinking about having is

struct foo {
  int len;
  char buf[.len];
};=20

or

struct bar {
 char (*ptr)[.len];
 int len;
};

For a transitional period you may need the macros anyway, but in the
long run I think nice syntax would help a lot.

It would be sad if nobody wants to fund such work, because this would
potentially have a very high impact, not just for the kernel.=C2=A0
(I am happy to=C2=A0 collaborate if somebody wants to work on or fund this)=
.

> > >=20
...
> > > > I find this strange, because to me it is very obvious that a lot mo=
re
> > > > could be done towards making C a lot safer (with many low hanging f=
ruits),
> > > > and also adding a memory safe=C2=A0subset seems possible.
> > >=20
> > > Are there proposals to C that you feel we should be supporting more?
> >=20
> > There are many things.
> >=20
> > For example, there is an effort to remove cases of UB.  There are about
> > 87 cases of UB in the core language (exlcuding preprocessor and library=
)
> > as of C23, and we have removed 17 already for C2Y (accepted by WG14 int=
o
> > the working draft) and we have concrete propsoals for 12 more. =C2=A0Th=
is
> > currently focusses on low-hanging fruits, and I hope we get most of the
> > simple cases removed this year to be able to focus on the harder issues=
.
> >=20
> > In particulary, I have a relatively concrete plan to have a memory safe
> > mode for C that can be toggled for some region of code and would make
> > sure there is no UB or memory safety issues left (I am experimenting wi=
th
> > this in the GCC FE).=C2=A0 So the idea is that one could start to activ=
ate this
> > for certain critical=C2=A0regions of code to make sure there is no sign=
ed
> > integer overflow or OOB access in it.   This is still in early stages, =
but
> > seems promising. Temporal memory safety is harder and it is less clear
> > how to do this ergonomically, but Rust shows that this can be done.
>=20
> What do you mean by "memory safe" when it comes to C?  Any pointers to
> that (pun intended)?

I mean "memory safe" in the sense that you can not have an OOB access
or use-after-free or any other UB.  The idea would be to mark certain
code regions as safe, e.g.

#pragma MEMORY_SAFETY STATIC
unsigned int foo(unsigned int a, unsigned int b)
{
  return a * b;
}

static int foo(const int a[static 2])
{
  int r =3D 0;
  if (ckd_mul(&r, a[0], a[1]))
    return -1;
  return r;
}

static int bar(int x)
{
  int a[2] =3D { x, x };
  return foo(a);
}


and the compiler would be required to emit a diagnostic when there
is any operation that could potentially cause UB.

I would also have a DYNAMIC mode that traps for UB detected at
run-time (but I understand that this is not useful for the kernel).=20

Essentially, the idea is that we can start with the existing subset
of C that is already memory safe but very limited, and=C2=A0incrementally
grow this subset.   From a user perspectice, you would do the
same:  You would start by making certain critical code regions
safe by turning on the safe mode and refactoring the code, and you
can then be sure that inside this region there is no memory safety
issue left.  Over time and with more and more language support,
one could increase these safe regions.

My preliminary proposal is here:
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3211.pdf

(temporal memory safety would need addressing, but here we can
learn from Cyclone / Rust)

There also different initiatives such as Clang's bounds checking
and GCC's analyzer and others that I hope we can build on here
to increase the scope of these safe regions.

>=20
> > I also have a proposal for a length-prefixed string type and for=C2=A0
> > polymorhic types / genericity, but this may not be so relevant to the
> > kernel at this point.
>=20
> We have a string type in the kernel much like this, it's just going to
> take some work in plumbing it up everywhere.  Christoph touched on that
> in one of his emails in this thread many messages ago.  Just grinding
> out those patches is "all" that is needed, no need for us to wait for
> any standard committee stuff.
>=20
> > Even more important than ISO C proposals would be compiler extensions
> > that can be tested before standardization.
>=20
> We support a few already for gcc, and I don't think we've refused
> patches to add more in the past, but I might have missed them.

Do you mean patches to the kernel for using them?  I would like help with
developing such features in GCC.  I added a couple of warnings (e.g.
-Wzero-as-null-pointer-constant or -Walloc-size) recently, but more
complex features quickly exceed the time I can use for this.  But knowing
the GCC FE and also C, I see many low-hanging fruits here.

Martin


