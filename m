Return-Path: <linux-kernel+bounces-199018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C488D8095
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1096B24D03
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A584A28;
	Mon,  3 Jun 2024 11:09:38 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577EB78C80;
	Mon,  3 Jun 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412978; cv=none; b=tZf0r65E1ULaD59j+Ok/vQr3ATNSfue53ovMb7FKc7kjq+So+HNu3nLU/thlKN4EI8NLBBJb42G4L5uYZoGH3J/tZIx6tzbb0iHDtHQzamVC3IINVbReKq0R6h/awH3/Rjum3pKSOOz7IXzXSNC3DbP3pTRmRyqUxCKH/tmQTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412978; c=relaxed/simple;
	bh=PtCqHPVS3FFL6uoO57jPPA1TNGctf3qqzV2I29OQeBQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k/xJ8F9Sy+saqonc7tocLJn76wEloKTu2XgFAKEfWfoGAMXM1gFkWiDvCAo6pXWZHuntDusgnQHF5tTb42Js+QcTUJplZA59wCP/JMq9OMrGIsMgrVs7P91NB68CTEIkUixt1Y/yys2pYhWhcTDG2lybiN6UwXSLmIryE3/+FiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 00D3592009C; Mon,  3 Jun 2024 13:09:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id ED57992009B;
	Mon,  3 Jun 2024 12:09:27 +0100 (BST)
Date: Mon, 3 Jun 2024 12:09:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: "Paul E. McKenney" <paulmck@kernel.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
    Arnd Bergmann <arnd@arndb.de>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
    Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
In-Reply-To: <CAHk-=whiH6g+T7+YWSYgAhJ9HsJ2bUUDJfLLo_Yhbi8CVgkHDg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2405310457060.23854@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com> <alpine.DEB.2.21.2405302115130.23854@angie.orcam.me.uk> <CAHk-=whiH6g+T7+YWSYgAhJ9HsJ2bUUDJfLLo_Yhbi8CVgkHDg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 May 2024, Linus Torvalds wrote:

> > > The 21064 actually did atomicity with an external pin on the bus, the
> > > same way people used to do before caches even existed.
> >
> >  Umm, 8086's LOCK#, anyone?
> 
> Well, yes and no.
> 
> So yes, exactly like 8086 did before having caches.

 Well I wrote 8086 specifically, not x86.

> But no, not like the alpha contemporary PPro that did have caches. The
> PPro already did locked cycles in the caches.

 But the 21064 does predate the PPro by a couple of years: Feb 1992 vs Nov 
1995, so surely Intel folks had extra time to resolve this stuff properly.  

 Conversely the R4000 came about in Oct 1991, so before the 21064.  But 
only so slightly and not as much as I remembered (I thought the 21064 was 
more like 1993), so it seems like DEC couldn't have had enough time after 
all to figure out what SGI did (patents notwithstanding).  Surely the 
R4000MC cache coherency protocol was complex for the silicon technology of 
the time, but it's just MOESI in modern terms AFAICT, and LL/SC is handled 
there (and is in fact undefined for uncached accesses).

 I'm not sure what else was out there at the time, but going back to x86 
the i486 was contemporary, the original write-through cache version, which 
if memory serves, was not any better in this respect (and the "write-back 
enhanced" DX2/DX4 models with proper MESI cache protocol came out much 
later, after Pentium only, which they borrowed from).

> So I really feel the 21064 was broken.
> 
> It's probably related to the whole cache coherency being designed to
> be external to the built-in caches - or even the Bcache. The caches
> basically are write-through, and the weak memory ordering was designed
> for allowing this horrible model.

 In retrospect perhaps it wasn't the best design, but they have learnt 
from their mistakes.

> > > In fact, it's worse than "not thread safe". It's not even safe on UP
> > > with interrupts, or even signals in user space.
> >
> >  Ouch, I find it a surprising oversight.
> 
> The sad part is that it doesn't seem to have been an oversight. It
> really was broken-as-designed.
> 
> Basically, the CPU was designed for single-threaded Spec benchmarks
> and absolutely nothing else. Classic RISC where you recompile to fix
> problems like the atomicity thing - "just use a 32-bit sig_atomic_t
> and you're fine")

 Not OK however, as you correctly point out, for plain ordinary non-atomic 
stuff.  Point me at any document that claims that a pair of threads poking 
at even and odd byte vector elements each is not allowed.  Caches may not 
enjoy it, but there's nothing AFAIK saying this is UB or whatever.

> The original alpha architecture handbook makes a big deal of how
> clever the lack of byte and word operations is. I also remember

 I've seen that; dropped in v3 with the addition of the BWX extension.

> reading an article by Dick Sites - one of the main designers - talking
> a lot about how the lack of byte operations is great, and encourages
> vectorizing byte accesses and doing string operations in whole words.

 Yeah, the software folks at DEC must have been delighted porting all the 
VAX VMS software.  But pehaps this was the last attempt to try something 
different from the CPU architecture standards established back in 1970s 
(by the VAX among others) that make current designs so similar to one 
another.

 Anyway, back to my point.  A feasible solution non-intrusive for Linux 
and low-overhead for GCC has been found.  I can expedite implementation 
and I'll see if I can regression-test it too, but I may have to rely on 
other people to complete it after all, as I haven't been prepared for this 
effort in the light of certain issues I have recently suffered from in my 
lab.

 Is that going to be enough to bring the platform bits back?

 FAOD, with all the hacks so eagerly being removed now happily left in the 
dust bin where they belong, and which I wholeheartedly agree with: we 
shouldn't be suffering from design mistakes of systems that are no longer 
relevant, but I fail to see the reason why we should disallow their use 
where the burden is confined or plain elsewhere.

 For example we continue supporting old UP MIPS platforms that predate 
LL/SC, by just trapping and emulating these instructions.  Surely it sucks 
performance-wise and it's possibly hundreds of cycles too, but it works 
and the burden is confined to the exception handler, so not a big deal.

  Maciej

