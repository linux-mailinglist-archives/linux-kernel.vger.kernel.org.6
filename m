Return-Path: <linux-kernel+bounces-527397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBBA40AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC216CB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8C20A5E2;
	Sat, 22 Feb 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVnQuUZd"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32A5588F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245694; cv=none; b=UQzmOvEFZtvKUBLLbVDiuHtPRI4DU6yj7FEHYjcYK0mRymxk2P/zqfIAAGesJInlx3HOD1dpy1e0Rd2qO0mV5l2yWv/KbcyZo3CihTa1mtDIqyXmOflu/pAtlhvq3zBZX0jr5AELE5F06p0GJVKzvF197NZIy4l3qwOvFqXgJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245694; c=relaxed/simple;
	bh=4dCMro2jgSSytYneGs45DXGEgNz1AxxCmVMizvO/wNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFOAQXlljcYHe5ENd7II2VEprvUFsS58aW+a61bEsZb6CApYGaUCpXy6j6BhN9zpvup20gH5FxJa8DVX9ki0d88aRtnV9oy1M+Aj48/yteLxNm6C5U4hlYzW/S0/T0mliaR/3sbOlPg5kHnSZze0aObK6drqS41YE41BsZeHI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVnQuUZd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 12:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740245680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omd3G77CNX6tI/IE4jiGqYCbLrVtlrc+oM1TvZV2E+A=;
	b=ZVnQuUZdr/yAvo7jdJuVCGxXfbGgnlpeC15ubKGRFgMlfrubAS5Ag/Zymkt5z/hqspJ0C8
	1To7TVw0V+2XEfUxs91DuO40g1mAbaoIh9acxWsCgpdFOIg5KaiLG0b7gAMFk8/Z/ZYjH/
	mGaDknu5oWOgxxSApjWBrN/FyI9NfJM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ventura Jack <venturajack85@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <qh7r6vpnmegxf6ofro2axhewt5ojntesxrlqs7vguo7tjc6gy6@4cucfg233kf7>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <sbcgis4vibueieejklfvv5zgz5omirryjyiynd5kloilxfygqb@zcqrjc6snxey>
 <CAFJgqgTFoqH8kDquHjhKXCvsXrF-uoHo=bq52Fgv+MKePy4zhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJgqgTFoqH8kDquHjhKXCvsXrF-uoHo=bq52Fgv+MKePy4zhA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 22, 2025 at 10:10:40AM -0700, Ventura Jack wrote:
> On Sat, Feb 22, 2025 at 9:04 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Wed, Feb 19, 2025 at 06:39:10AM +0100, Greg KH wrote:
> > > Rust isn't a "silver bullet" that will solve all of our problems, but it
> > > sure will help in a huge number of places, so for new stuff going
> > > forward, why wouldn't we want that?
> >
> > The big thing we run into when trying to bring this to a practical
> > systems language, and the fundamental reason the borrow checker looks
> > the way it does, is Rice's theorem. Rice's theorem is a direct corollary
> > of the halting problem - "any nontrivial property of a program is either
> > a direct consequence of the syntax or undecidable".
> >
> 
> How do runtime checks play into Rice's Theorem? As far as I know, Rust
> has or can have a number of runtime checks, for instance in some of
> the places where a panic can happen.

Rust can't do full theorem proving. You can do quite a bit with the
borrow checker and other type system enhancements, but you definitely
can't do everything.

So if the compiler can't prove something at compile time, you may need a
runtime check to avoid undefined behaviour.

And the fact that Rust eliminates undefined behaviour in safe code is
huge. That's really a fundamental prerequisite for anything that would
be meaningfully better than C, and Rust gets that right.

(which required the borrow checker, because memory safety = UB...)

That means that even if you don't know if your code is correct, it's at
least going to fail in predictable ways. You're going to get meaningful
backtraces, good error messages if you weren't horribly lazy (the Rust
Display trait makes that a lot more ergonomic) - that means no more two
week bisect + bughunts for a UAF that was silently corrupting data.

We _just_ had one of those. Just the initial bisect (and it turned out
to be in the fuse code) interrupted the work I and a user were doing to
test bcachefs fsck scalability for a full week, when we'd just dedicated
and setup a machine for that that we only had for a limited time.

That sucked: there's a massive hidden cost to the sorts of heisenbugs
that C allows.

Of course higher level logic errors could still result in a silent
data corruption bug in Rust: intelligent thought is still required,
until we climb the next mountain, and the next mountain, until we do get
to full correctness proofs (and then we still have to write the code).

> The type system holes in the Rust type system, and the bugs in rustc's
> solver, grates me a bit. A lot of hard work is done in Rust language
> land on fixing the type system holes and on a new solver for rustc
> without the issues of the current solver, while maintaining as much
> backwards compatibility as possible. Difficult work as I gather. The
> alternative GCC Rust compiler, gccrs, is (as I gather) planned to also
> use the new solver once it is ready. There were some versions of
> rustc, also in 2020, where compile times for some production Rust
> projects went from fine to exponential, and where it took some
> compiler work to mitigate the issues, due to the issues being related
> to holes in the type system.

I don't expect such issues to affect us normal kernel developers much.
Yes, the compiler folks have a lot to deal with, but "can it build the
kernel" is an easy thing to add to their automated testing pipeline.

And it's not like we never have to deal with compiler issues now.

> The more complex a type system checker and solver, the more difficult
> it can be to avoid holes in the type system and bugs in the solver.
> Hindley-Milner is great, also because it is relatively simple, and has
> proofs for it and its algorithms for type checking. Mainstream
> programming languages inspired by ML/Hindley-Milner do generally
> extend its type system, often to provide more flexibility.

If you want a real mental trip, consider that a type system powerful
enough for theorem proving must itself be turing complete (not
inherently, but in practice), and thus the halting problem applies to
"can the compiler even process its inputs without terminating?".

But compiler folks have been dealing with such issues for years already,
that's their ballgame.


