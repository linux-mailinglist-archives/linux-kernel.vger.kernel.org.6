Return-Path: <linux-kernel+bounces-196230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06388D592B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F4B1F24CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB8777F08;
	Fri, 31 May 2024 03:56:33 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E10D51E;
	Fri, 31 May 2024 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717127793; cv=none; b=nUbrKN3MJFLeYYo9dQ9QdYNMJ1J1+Gfe9JON0qKV9pk6teV23+dqDmV9zM1f07oRSsIHSJSN/WTZM73oiYBmqiygbCxrwhvvML8rcUajkgOwoWkKQqixSjhPwCpMwseML9yH0AGK6ckRRe8vZPonG0YatlSD+TY8lqn2vY9fdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717127793; c=relaxed/simple;
	bh=YauT7wCmRx8kBE4DMQNErf1RhLlFHwMRcrG+c4Q0l0w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CjjoAWWZbuO13E01UvDgZnr0ZVPiddVhY+s3blPm5XC4mqneOoLlqFZSk22uqkBymMhnmkXqCtSl0Y9TXgzYYvU2R77wRpatz5+MOXsTNAjQDTmqJSJhWwNZd1l6DaKQAbHDIa2F2jFw4pwFxebw3dIV1QsPYcLvpcV74ROdOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C1D8D92009C; Fri, 31 May 2024 05:56:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B345092009B;
	Fri, 31 May 2024 04:56:28 +0100 (BST)
Date: Fri, 31 May 2024 04:56:28 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
    Arnd Bergmann <arnd@arndb.de>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Marc Zyngier <maz@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>, 
    Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
In-Reply-To: <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop>
Message-ID: <alpine.DEB.2.21.2405310432190.23854@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 May 2024, Paul E. McKenney wrote:

> >  Mind that the read-modify-write sequence that software does for sub-word 
> > write accesses with original Alpha hardware is precisely what hardware 
> > would have to do anyway and support for that was deliberately omitted by 
> > the architecture designers from the ISA to give it performance advantages 
> > quoted in the architecture manual.  The only difference here is that with 
> > hardware read-modify-write operations atomicity for sub-word accesses is 
> > guaranteed by the ISA, however for software read-modify-write it has to be 
> > explictly coded using the usual load-locked/store-conditional sequence in 
> > a loop.  I don't think it's a big deal really, it should be trivial to do 
> > in the relevant accessors, along with the memory barriers that are needed 
> > anyway for EV56+ and possibly other ports such as the MIPS one.
> 
> There shouldn't be any memory barriers required, and don't EV56+ have
> single-byte loads and stores?

 I should have commented on this in my original reply.

 You're the RCU expert so you know the answer.  I don't.  If it's OK for
successive writes to get reordered, or readers to see a stale value, then 
you don't need memory barriers.  Otherwise you do.  Whether byte accesses 
are available or not does not matter, the CPU *will* do reordering if it's 
allowed to (or more specifically, it won't do anything to prevent it from 
happening, especially in SMP configurations; I can't remember offhand if 
there are cases with UP).  Also adjacent byte writes may be merged, but I 
suppose it does not matter, or does it?

 NB MIPS has similar architectural arrangements (and a bunch of barriers 
defined in the ISA), it's just most implementations are actually strongly 
ordered, so most people can't see the effects of this.  With MIPS I know 
for sure there are cases of UP reordering, but they only really matter for 
MMIO use cases and not regular memory.

  Maciej

