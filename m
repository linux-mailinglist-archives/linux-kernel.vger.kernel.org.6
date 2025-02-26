Return-Path: <linux-kernel+bounces-534743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C42A46AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6E77A7B94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01135239573;
	Wed, 26 Feb 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="mN42JVeg"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD18236A70;
	Wed, 26 Feb 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596870; cv=none; b=Vkz+TANWGx0GYKQJ+aSGdw//VTEtDZIMHcDnF5ZRoUORQ9XgNobokF1k3P07ipcgbjj1nZG8aOgtaSas0/OlLYQcg3OTFllTzkYiK3Z57vuqFgT4it1YrCXqxcSeg4f3Pn6+10RGRnX/5GPm1UpAl9pKHOdsyTJUhmJwSGZqnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596870; c=relaxed/simple;
	bh=LQc6T8tWWBk4IcNFOqld2ZcIVJBhbYgbzmhmv20T35Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GVgzyR7VUaP4Cm1832kZnmBshZpgEiy324uJkYKksRDT4WkHzVWskZ8RBy14oJ67owLdSeD6HZygoxRAM6LO0mVzKWhm+XmmZgviOF0MdWRk/ik6aDMZhaxXA1Z6WNo9cFzUNKkIUQBaMv4o13e+P6EOvZmmMZqM/9VxACceMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=mN42JVeg; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-172-88.tugraz.at (vra-172-88.tugraz.at [129.27.172.88])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z33rB2vrlz1LM0S;
	Wed, 26 Feb 2025 20:07:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Z33rB2vrlz1LM0S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740596844;
	bh=cBIHY7NjixY9R3mec4by4eNMqR4KPX/KoOMaOf8bOCY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mN42JVegxivQYDFjBQ8lV12Huw2FoF2uVXjcLcRYITxwsiT07gKtX/DyLziRlkdm3
	 EFMA3fDzkbyRTpTI4HtkfI38wExcxGlCwuBVQV1W+9YwLM8X8F7NB12kxCabvXZBXM
	 bf1y8O+H3hlX9p1OQogcADuQlve67JrDmyY0Dy9I=
Message-ID: <dd28fe6e2c174f605a104723a5ab8d5445fe8002.camel@tugraz.at>
Subject: Re: C aggregate passing (Rust kernel policy)
From: Martin Uecker <uecker@tugraz.at>
To: Ralf Jung <post@ralfj.de>, Ventura Jack <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Miguel Ojeda
	 <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, 
	torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Wed, 26 Feb 2025 20:07:22 +0100
In-Reply-To: <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
References: 
	<CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	 <20250222141521.1fe24871@eugeo>
	 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
	 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
	 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
	 <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
	 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
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

Am Mittwoch, dem 26.02.2025 um 17:32 +0100 schrieb Ralf Jung:
> Hi VJ,
>=20
> > >=20
> > > > - Rust has not defined its aliasing model.
> > >=20
> > > Correct. But then, neither has C. The C aliasing rules are described =
in English
> > > prose that is prone to ambiguities and misintepretation. The strict a=
liasing
> > > analysis implemented in GCC is not compatible with how most people re=
ad the
> > > standard (https://bugs.llvm.org/show_bug.cgi?id=3D21725). There is no=
 tool to
> > > check whether code follows the C aliasing rules, and due to the afore=
mentioned
> > > ambiguities it would be hard to write such a tool and be sure it inte=
rprets the
> > > standard the same way compilers do.
> > >=20
> > > For Rust, we at least have two candidate models that are defined in f=
ull
> > > mathematical rigor, and a tool that is widely used in the community, =
ensuring
> > > the models match realistic use of Rust.
> >=20
> > But it is much more significant for Rust than for C, at least in
> > regards to C's "restrict", since "restrict" is rarely used in C, while
> > aliasing optimizations are pervasive in Rust. For C's "strict aliasing"=
,
> > I think you have a good point, but "strict aliasing" is still easier to
> > reason about in my opinion than C's "restrict". Especially if you
> > never have any type casts of any kind nor union type punning.
>=20
> Is it easier to reason about? At least GCC got it wrong, making no-aliasi=
ng=20
> assumptions that are not justified by most people's interpretation of the=
 model:
> https://bugs.llvm.org/show_bug.cgi?id=3D21725
> (But yes that does involve unions.)

Did you mean to say LLVM got this wrong?   As far as I know,
the GCC TBBA code is more correct than LLVMs.  It gets=C2=A0
type-changing stores correct that LLVM does not implement.

>=20
> > > > - The aliasing rules in Rust are possibly as hard or
> > > >      harder than for C "restrict", and it is not possible to
> > > >      opt out of aliasing in Rust, which is cited by some
> > > >      as one of the reasons for unsafe Rust being
> > > >      harder than C.
> > >=20
> > > That is not quite correct; it is possible to opt-out by using raw poi=
nters.
> >=20
> > Again, I did have this list item:
> >=20
> > - Applies to certain pointer kinds in Rust, namely
> >      Rust "references".
> >      Rust pointer kinds:
> >      https://doc.rust-lang.org/reference/types/pointer.html
> >=20
> > where I wrote that the aliasing rules apply to Rust "references".
>=20
> Okay, fair. But it is easy to misunderstand the other items in your list =
in=20
> isolation.
>=20
> >=20
> > > >      the aliasing rules, may try to rely on MIRI. MIRI is
> > > >      similar to a sanitizer for C, with similar advantages and
> > > >      disadvantages. MIRI uses both the stacked borrow
> > > >      and the tree borrow experimental research models.
> > > >      MIRI, like sanitizers, does not catch everything, though
> > > >      MIRI has been used to find undefined behavior/memory
> > > >      safety bugs in for instance the Rust standard library.
> > >=20
> > > Unlike sanitizers, Miri can actually catch everything. However, since=
 the exact
> > > details of what is and is not UB in Rust are still being worked out, =
we cannot
> > > yet make in good conscience a promise saying "Miri catches all UB". H=
owever, as
> > > the Miri README states:
> > > "To the best of our knowledge, all Undefined Behavior that has the po=
tential to
> > > affect a program's correctness is being detected by Miri (modulo bugs=
), but you
> > > should consult the Reference for the official definition of Undefined=
 Behavior.
> > > Miri will be updated with the Rust compiler to protect against UB as =
it is
> > > understood by the current compiler, but it makes no promises about fu=
ture
> > > versions of rustc."
> > > See the Miri README (https://github.com/rust-lang/miri/?tab=3Dreadme-=
ov-file#miri)
> > > for further details and caveats regarding non-determinism.
> > >=20
> > > So, the situation for Rust here is a lot better than it is in C. Unfo=
rtunately,
> > > running kernel code in Miri is not currently possible; figuring out h=
ow to
> > > improve that could be an interesting collaboration.
> >=20
> > I do not believe that you are correct when you write:
> >=20
> >      "Unlike sanitizers, Miri can actually catch everything."
> >=20
> > Critically and very importantly, unless I am mistaken about MIRI, and
> > similar to sanitizers, MIRI only checks with runtime tests. That means
> > that MIRI will not catch any undefined behavior that a test does
> > not encounter. If a project's test coverage is poor, MIRI will not
> > check a lot of the code when run with those tests. Please do
> > correct me if I am mistaken about this. I am guessing that you
> > meant this as well, but I do not get the impression that it is
> > clear from your post.
>=20
> Okay, I may have misunderstood what you mean by "catch everything". All=
=20
> sanitizers miss some UB that actually occurs in the given execution. This=
 is=20
> because they are inserted in the pipeline after a bunch of compiler-speci=
fic=20
> choices have already been made, potentially masking some UB. I'm not awar=
e of a=20
> sanitizer for sequence point violations. I am not aware of a sanitizer fo=
r=20
> strict aliasing or restrict. I am not aware of a sanitizer that detects U=
B due=20
> to out-of-bounds pointer arithmetic (I am not talking about OOB accesses;=
 just=20
> the arithmetic is already UB), or UB due to violations of "pointer lifeti=
me end=20
> zapping", or UB due to comparing pointers derived from different allocati=
ons. Is=20
> there a sanitizer that correctly models what exactly happens when a struc=
t with=20
> padding gets copied? The padding must be reset to be considered "uninitia=
lized",=20
> even if the entire struct was zero-initialized before. Most compilers imp=
lement=20
> such a copy as memcpy; a sanitizer would then miss this UB.

Note that reading padding bytes in C is not UB. Regarding
uninitialized variables, only automatic variables whose address
is not taken is UB in C. =C2=A0 Although I suspect that compilers
have compliance isues here.

But yes, it sanitizers are still rather poor.

Martin

>=20
> In contrast, Miri checks for all the UB that is used anywhere in the Rust=
=20
> compiler -- everything else would be a critical bug in either Miri or the=
 compiler.
> But yes, it only does so on the code paths you are actually testing. And =
yes, it=20
> is very slow.
>=20
> Kind regards,
> Ralf
>=20


