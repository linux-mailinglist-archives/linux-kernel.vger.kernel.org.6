Return-Path: <linux-kernel+bounces-199431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C667E8D871E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA41F25F39
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97113698B;
	Mon,  3 Jun 2024 16:22:27 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6319F;
	Mon,  3 Jun 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431747; cv=none; b=aD13xsoJr7OkzWsmSudTE4w635YzTnc1C03Qp3Y5W2shmWT6je8iLmHIXhMzoxuzkGxtf22oFpdZgJ2WlluHG7ALOJoEcKMECcnsBeH/05oNNZ0PG4lcQJMffXThW/Bxx/sCOMkmD5EPcoF25NBfo92EG/gQvP/1f3fE/LCAAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431747; c=relaxed/simple;
	bh=8AXwzJpiVoCs+3CzzBhr4vragltIQHKERZT+lejjGro=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UMXTi7gCX1dIxaAnvUGOvD/DExSLZqSQc7WZ3xzSnkgZMcKlkjA7GBOx71YS6jiPABDza/D8mC0nd/8cxdJGVZlw9kJVrgPgXNrsNCJwfTAdTNQGGpG2uRdlxcWnqy66pkB8g33llqrjWXWad/I8vnyfnDo0VGg9q+MACKv+z7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 730D292009C; Mon,  3 Jun 2024 18:22:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6DFA792009B;
	Mon,  3 Jun 2024 17:22:22 +0100 (BST)
Date: Mon, 3 Jun 2024 17:22:22 +0100 (BST)
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
In-Reply-To: <7b0a434c-2165-45a0-8507-e7f992094705@paulmck-laptop>
Message-ID: <alpine.DEB.2.21.2406031716490.9248@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop> <alpine.DEB.2.21.2405310432190.23854@angie.orcam.me.uk> <7b0a434c-2165-45a0-8507-e7f992094705@paulmck-laptop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 May 2024, Paul E. McKenney wrote:

> >  You're the RCU expert so you know the answer.  I don't.  If it's OK for
> > successive writes to get reordered, or readers to see a stale value, then 
> > you don't need memory barriers.  Otherwise you do.  Whether byte accesses 
> > are available or not does not matter, the CPU *will* do reordering if it's 
> > allowed to (or more specifically, it won't do anything to prevent it from 
> > happening, especially in SMP configurations; I can't remember offhand if 
> > there are cases with UP).  Also adjacent byte writes may be merged, but I 
> > suppose it does not matter, or does it?
> 
> RCU uses whichever wrapper is required.  For example, if ordering is
> required, it might use smp_store_release() and smp_load_acquire().
> If ordering does not matter, it might use WRITE_ONCE() and READ_ONCE().
> If tearing/fusing/merging does not matter, as in there are not concurrent
> accesses, it uses plain C-language loads and stores.

 Fair enough.

> >  NB MIPS has similar architectural arrangements (and a bunch of barriers 
> > defined in the ISA), it's just most implementations are actually strongly 
> > ordered, so most people can't see the effects of this.  With MIPS I know 
> > for sure there are cases of UP reordering, but they only really matter for 
> > MMIO use cases and not regular memory.
> 
> Any given architecture is required to provide architecture-specific
> implementations of the various functions that meet the requirements of
> Linux-kernel memory model.  See tools/memory-model for more information.

 This is a fairly recent addition, thank you for putting it all together.  
I used to rely solely on Documentation/memory-barriers.txt.  Thanks for 
the reference.

  Maciej

