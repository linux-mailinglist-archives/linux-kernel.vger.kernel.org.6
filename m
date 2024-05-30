Return-Path: <linux-kernel+bounces-195994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F43B8D55D8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BABBFB22F95
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B7182D3C;
	Thu, 30 May 2024 22:57:40 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58FE17545;
	Thu, 30 May 2024 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109859; cv=none; b=qviG6vNQLC7KbELeCelYH/19d0PnnVu+Gk2WiNPJOADb4hDFEcZwY6n4Qz06jorBPstDjOQXbA6p56/hjov+58xJs3MyRgAyoYYlNMxA33MU3i6eQbEtTDw2K0Y2mtZZCzXBb6BUCi3pZ2pY5OYlRx9GvpH3NLBErZpsYYDjisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109859; c=relaxed/simple;
	bh=NQrd95QoApaEs9fJihobolQ+Eb73I7LZq0li/uDFwv0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VI2+7YW4sGcU9EBGVkSWFEMtKUQolWQBW1naxb6XZg+pz1vRquPI1gvDabzkApqb17wo3v1dKC+qk5wz/WhL1L+Gr2NYmfHvZoG1ZIga+qjfPIqBJRQ4zEt8eFIrWR0aryBg11rL1cHuxy6DXyQSZNVmLHN3mkZx4ngmdZmOGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id F388A92009C; Fri, 31 May 2024 00:57:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EC40692009B;
	Thu, 30 May 2024 23:57:29 +0100 (BST)
Date: Thu, 30 May 2024 23:57:29 +0100 (BST)
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
In-Reply-To: <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2405302115130.23854@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 May 2024, Linus Torvalds wrote:

> >              The only difference here is that with
> > hardware read-modify-write operations atomicity for sub-word accesses is
> > guaranteed by the ISA, however for software read-modify-write it has to be
> > explictly coded using the usual load-locked/store-conditional sequence in
> > a loop.
> 
> I have some bad news for you: the old alpha CPU's not only screwed up
> the byte/word design, they _also_ screwed up the
> load-locked/store-conditional.
> 
> You'd think that LL/SC would be done at a cacheline level, like any
> sane person would do.
> 
> But no.
> 
> The 21064 actually did atomicity with an external pin on the bus, the
> same way people used to do before caches even existed.

 Umm, 8086's LOCK#, anyone?

> Yes, it has an internal L1 D$, but it is a write-through cache, and
> clearly things like cache coherency weren't designed for. In fact,
> LL/SC is even documented to not work in the external L2 cache
> ("Bcache" - don't ask me why the odd naming).

 Board cache, I suppose.

> So LL/SC on the 21064 literally works on external memory.
> 
> Quoting the reference manual:
> 
>   "A.6 Load Locked and Store Conditional
>   The 21064 provides the ability to perform locked memory accesses through
>   the LDxL (Load_Locked) and STxC (Store_Conditional) cycle command pair.
>   The LDxL command forces the 21064 to bypass the Bcache and request data
>   directly from the external memory interface. The memory interface logic must
>   set a special interlock flag as it returns the data, and may
> optionally keep the
>   locked address"
> 
> End result: a LL/SC pair is very very slow. It was incredibly slow
> even for the time. I had benchmarks, I can't recall them, but I'd like
> to say "hundreds of cycles". Maybe thousands.

 Interesting and disappointing, given how many years the Alpha designers 
had to learn from the MIPS R4000.  Which they borrowed from already after 
all and which they had first-hand experience with present onboard, from 
the R4000 DECstation systems built at their WSE facility.  Hmm, I wonder 
if there was patent avoidance involved.

> So actual reliable byte operations are not realistically possible on
> the early alpha CPU's. You can do them with LL/SC, sure, but
> performance would be so horrendously bad that it would be just sad.

 Hmm, performance with a 30 years old system?  Who cares!  It mattered 30 
years ago, maybe 25.  And the performance of a system that runs slowly is 
still infinitely better than one of a system that doesn't boot anymore, 
isn't it?

> The 21064A had some "fast lock" mode which allows the data from the
> LDQ_L to come from the Bcache. So it still isn't exactly fast, and it
> still didn't work at CPU core speeds, but at least it worked with the
> external cache.
> 
> Compilers will generate the sequence that DEC specified, which isn't
> thread-safe.
> 
> In fact, it's worse than "not thread safe". It's not even safe on UP
> with interrupts, or even signals in user space.

 Ouch, I find it a surprising oversight.  Come to think of it indeed the 
plain unlocked read-modify-write sequences are unsafe.  I don't suppose 
any old DECies are still around, but any idea how this was sorted in DEC's 
own commercial operating systems (DU and OVMS)?

 So this seems like something that needs to be sorted in the compiler, by 
always using a locked sequence for 8-bit and 16-bit writes with non-BWX 
targets.  I can surely do it myself, not a big deal, and I reckon such a 
change to GCC should be pretty compact and self-contained, as all the bits 
are already within `alpha_expand_mov_nobwx' anyway.

 I'm not sure if Richard will be happy to accept it, but it seems to me 
the right thing to do at this point and with that in place there should be 
no safety concern for RCU or anything with the old Alphas, with no effort 
at all on the Linux side as all the burden will be on the compiler.  We 
may want to probe for the associated compiler option though and bail out 
if unsupported.

 Will it be enough to keep Linux support at least until the next obstacle?

  Maciej

