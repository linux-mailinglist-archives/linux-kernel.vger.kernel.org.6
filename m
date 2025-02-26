Return-Path: <linux-kernel+bounces-534882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF67A46C39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3892188C97B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286813A88A;
	Wed, 26 Feb 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="uJlD4sHS"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA72755F8;
	Wed, 26 Feb 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601356; cv=none; b=ZritpnykVIVVP3u9qA4pFxhWBc66DMwqxkR1RWm3EruV6cdgo10HWUZJIp3FrC4Ahu0bTJthVH5RCRFmMK6QXQrWwUadfIc0rMWX23kfuyRKUyqmEV82n+th3c6mqUZylkomiufGIlxW4DlIbA2AyAPa+pmruAE1gkVhohlPJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601356; c=relaxed/simple;
	bh=+NiVLCjGCkMFcNjDGegjFUZfwd/07pJkRp0C6DzWwB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfL6mGplmes3FmUJkZNPCo7Y13rXMEzUBJoqD26pExMGd4cajQnQnSIfxlniGNowhZjTYYHekXJ28l6k9/dkjXADYYBZO3hcciNj4WaYzoGddA1iovFXNBtV+riPFPiNXQ1XFXp10xO6+yEPtYuoLWDYdsj61hAvDYuHurWWjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=uJlD4sHS; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-172-88.tugraz.at (vra-172-88.tugraz.at [129.27.172.88])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z35Vl5cbzz1JJC0;
	Wed, 26 Feb 2025 21:22:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Z35Vl5cbzz1JJC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740601346;
	bh=yqdmvHeCKVQDDf3HLcQF5i/sDSm0SCxwQLW/hXfVQWg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uJlD4sHSjKBm+IsCSoz9FVD+83P5B73Ll8PjtDfn41UxMs0J8IN7XOj2Y9oa6K5Ii
	 2lmq9LGLzT6+RL8FpCKFI702cL2F19SMi8CJRfhl4zE+umv1zr3KkoGKBa2V0u6dqj
	 Cdx/tFn5hDw7QQLNvdDWPR22Y1Q4Acf/TItGO62c=
Message-ID: <ea961d5d824576753b614fe32cb2837403eac8d7.camel@tugraz.at>
Subject: Re: C aggregate passing (Rust kernel policy)
From: Martin Uecker <uecker@tugraz.at>
To: Ralf Jung <post@ralfj.de>, Ventura Jack <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Miguel Ojeda
	 <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, 
	torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Wed, 26 Feb 2025 21:22:23 +0100
In-Reply-To: <5f30546a-278d-4e99-9b2a-3cb7a6c45f89@ralfj.de>
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
	 <dd28fe6e2c174f605a104723a5ab8d5445fe8002.camel@tugraz.at>
	 <5f30546a-278d-4e99-9b2a-3cb7a6c45f89@ralfj.de>
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


Am Mittwoch, dem 26.02.2025 um 20:23 +0100 schrieb Ralf Jung:
> Hi all,
>=20
> > > > But it is much more significant for Rust than for C, at least in
> > > > regards to C's "restrict", since "restrict" is rarely used in C, wh=
ile
> > > > aliasing optimizations are pervasive in Rust. For C's "strict alias=
ing",
> > > > I think you have a good point, but "strict aliasing" is still easie=
r to
> > > > reason about in my opinion than C's "restrict". Especially if you
> > > > never have any type casts of any kind nor union type punning.
> > >=20
> > > Is it easier to reason about? At least GCC got it wrong, making no-al=
iasing
> > > assumptions that are not justified by most people's interpretation of=
 the model:
> > > https://bugs.llvm.org/show_bug.cgi?id=3D21725
> > > (But yes that does involve unions.)
> >=20
> > Did you mean to say LLVM got this wrong?   As far as I know,
> > the GCC TBBA code is more correct than LLVMs.  It gets
> > type-changing stores correct that LLVM does not implement.
>=20
> Oh sorry, yes that is an LLVM bug link. I mixed something up. I could hav=
e sworn=20
> there was a GCC bug, but I only found=20
> <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D57359> which has been fix=
ed.
> There was some problem with strong updates, i.e. the standard permits wri=
tes=20
> through a `float*` pointer to memory that aliases an `int*`. The C aliasi=
ng=20
> model only says it is UB to read data at the wrong type, but does not tal=
k about=20
> writes changing the type of memory.
> Martin, maybe you remember better than me what that issue was / whether i=
t is=20
> still a problem?

There are plenty of problems ;-)  But GCC mostly gets the type-changing
stores correct as specified in the C standard.  The bugs related to this
that I tracked got fixed. Clang still does not implement this as specified.
It implements the C++ model which does not require type-changing stores
to work (but I am not an expert on the C++ side).   To be fair, there
was also incorrect guidance from WG14 at some point that added to the
confusion.

So I think for C one could use GCC with strict aliasing if one is careful
and observes the usual rules, but I would certainly recommend against
doing this for Clang.=20

What both compilers still get wrong are all the corner cases related to
provenance including the integer-pointer roundtrips.
The LLVM maintainer said they are going to fix the later soon, so
there is some hope on this side.

>=20
> > > > > So, the situation for Rust here is a lot better than it is in C. =
Unfortunately,
> > > > > running kernel code in Miri is not currently possible; figuring o=
ut how to
> > > > > improve that could be an interesting collaboration.
> > > >=20
> > > > I do not believe that you are correct when you write:
> > > >=20
> > > >       "Unlike sanitizers, Miri can actually catch everything."
> > > >=20
> > > > Critically and very importantly, unless I am mistaken about MIRI, a=
nd
> > > > similar to sanitizers, MIRI only checks with runtime tests. That me=
ans
> > > > that MIRI will not catch any undefined behavior that a test does
> > > > not encounter. If a project's test coverage is poor, MIRI will not
> > > > check a lot of the code when run with those tests. Please do
> > > > correct me if I am mistaken about this. I am guessing that you
> > > > meant this as well, but I do not get the impression that it is
> > > > clear from your post.
> > >=20
> > > Okay, I may have misunderstood what you mean by "catch everything". A=
ll
> > > sanitizers miss some UB that actually occurs in the given execution. =
This is
> > > because they are inserted in the pipeline after a bunch of compiler-s=
pecific
> > > choices have already been made, potentially masking some UB. I'm not =
aware of a
> > > sanitizer for sequence point violations. I am not aware of a sanitize=
r for
> > > strict aliasing or restrict. I am not aware of a sanitizer that detec=
ts UB due
> > > to out-of-bounds pointer arithmetic (I am not talking about OOB acces=
ses; just
> > > the arithmetic is already UB), or UB due to violations of "pointer li=
fetime end
> > > zapping", or UB due to comparing pointers derived from different allo=
cations. Is
> > > there a sanitizer that correctly models what exactly happens when a s=
truct with
> > > padding gets copied? The padding must be reset to be considered "unin=
itialized",
> > > even if the entire struct was zero-initialized before. Most compilers=
 implement
> > > such a copy as memcpy; a sanitizer would then miss this UB.
> >=20
> > Note that reading padding bytes in C is not UB. Regarding
> > uninitialized variables, only automatic variables whose address
> > is not taken is UB in C. =C2=A0 Although I suspect that compilers
> > have compliance isues here.
>=20
> Hm, now I am wondering how clang is compliant here. To my knowledge, padd=
ing is=20
> effectively reset to poison or undef on a copy (due to SROA), and clang m=
arks=20
> most integer types as "noundef", thus making it UB to ever have undef/poi=
son in=20
> such a value.

I haven't kept track with this, but I also do not believe that
Clang is conforming to the C standard, but again follows C++ rules
which has more UB.   I am also not entirely sure GCC gets this
completely right though.

Martin


>=20
> Kind regards,
> Ralf
>=20
> >=20
> > But yes, it sanitizers are still rather poor.
>=20
>=20
>=20
> >=20
> > Martin
> >=20
> > >=20
> > > In contrast, Miri checks for all the UB that is used anywhere in the =
Rust
> > > compiler -- everything else would be a critical bug in either Miri or=
 the compiler.
> > > But yes, it only does so on the code paths you are actually testing. =
And yes, it
> > > is very slow.
> > >=20
> > > Kind regards,
> > > Ralf
> > >=20
> >=20
>=20


