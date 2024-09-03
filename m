Return-Path: <linux-kernel+bounces-312719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B09969A4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B83B2406A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA71A0BEC;
	Tue,  3 Sep 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iz/I/FCb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bD+GUwmk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE611A0BC7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359787; cv=none; b=jUENuKWn4hnaKPL8HQaSMYOXETpMQEwbCrX3g2WAR9edFxto/Nfs1ZZu0A4dVDBefOQnMV8ROa0af4VMnpAiQa/EvdP+352JmbMRT2kX9Kpb7Qs64bHJ5QCDz79E+IJO2yuANudgE0U/7SgbSEB/SOjqlRYcNYJcwFU1vl489uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359787; c=relaxed/simple;
	bh=cNntLfzflnVh0S0jANv4LpLfJWvxb++G3I5jH7WtMrY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvr7v9Pf2NBho6oup39nXKovzAIYdDC5Vmhu4aRV5O+Vv5SfclLhKDmb63aFVpnsWX1bVJzUs3tJYrX4NZQuqJ046TTKSUV/fG+79fXaWN2tjF19cYNM5sDkHM1wsvtlTztzI1JmncznZ0N4jSQWLQ9kK4vT3p71uSwsg/ovXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iz/I/FCb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bD+GUwmk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Sep 2024 12:36:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725359782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojtxnyS4O7KDOKCfeZk7mENAq6gaSLvpMXtpfjPtxzk=;
	b=iz/I/FCbft6jtUwrTh0tVl+H+mfN9TRfMiDUAi8wWTz3zQXPCxaoANmFoVOftABESq1to4
	5dvjoctxtV4a+siRmHISB97+4AB5CvhJ3Ud93ZcLCJh2rDP7tz7nKK0TODeHML9kLrukFz
	s4u2aBslOFxNsTyDTBVxlD/8rsU0M5ywT5CX4v7DiPbXWHl96XLjlaZ1fPEOZcK5m+DYvE
	r2d209vPF7DP0kzLprng9BKdEO5yjX1223ywNe5e8UYOYjjWnnxwMzG5uAMd5kHuBXFKrx
	8Hz+24j8eyHMvBfFhJuc3FUlQNU3ZFwDqno1epeFakTcc6qQIekEOw2ivRi63A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725359782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojtxnyS4O7KDOKCfeZk7mENAq6gaSLvpMXtpfjPtxzk=;
	b=bD+GUwmkP/6q6dVnEA5lDqXqdC9HzIz8QWjlSjDOCdLPwIPndG/7WkPkHgfOM2lwLKGIq5
	SK4397Z2++oJCqBw==
From: Nam Cao <namcao@linutronix.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	bigeasy@linutronix.de
Subject: Re: [PATCH] x86/mm/pat: Support splitting of virtual memory areas
Message-ID: <20240903103616.i0GrRAfD@linutronix.de>
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
 <20240827075841.BO2qAOzq@linutronix.de>
 <yvcwdfgxnyet7rjf6lhnsypz72jmp5czfkb2muvgzcul53scn6@rkhqrfgdaxsw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yvcwdfgxnyet7rjf6lhnsypz72jmp5czfkb2muvgzcul53scn6@rkhqrfgdaxsw>

Sorry for the late reply, I was a bit busy, and needed some time to digest
your email.

On Tue, Aug 27, 2024 at 12:01:28PM -0400, Liam R. Howlett wrote:
> * Nam Cao <namcao@linutronix.de> [240827 03:59]:
> > On Mon, Aug 26, 2024 at 09:58:11AM -0400, Liam R. Howlett wrote:
> > > * Nam Cao <namcao@linutronix.de> [240825 11:29]:
> > > > When a virtual memory area (VMA) gets splitted, memtype_rbroot's entries
> > > > are not updated. This causes confusion later on when the VMAs get
> > > > un-mapped, because the address ranges of the splitted VMAs do not match the
> > > > address range of the initial VMA.
> > > > 
> > > > For example, if user does:
> > > > 
> > > > 	fd = open("/some/pci/bar", O_RDWR);
> > > > 	addr = mmap(0, 8192, PROT_READ, MAP_SHARED, fd, 0);
> > > > 	mprotect(addr, 4096, PROT_READ | PROT_WRITE);
> > > > 	munmap(p, 8192);
> 
> What is p?  By the comments below, you mean addr here?
Yes, it should be addr. Sorry about that.

> 
> > > > 
> > > > with the physical address starting from 0xfd000000, the range
> > > > (0xfd000000-0xfd002000) would be tracked with the mmap() call.
> > > > 
> > > > After mprotect(), the initial range gets splitted into
> > > > (0xfd000000-0xfd001000) and (0xfd001000-0xfd002000).
> > > > 
> > > > Then, at munmap(), the first range does not match any entry in
> > > > memtype_rbroot, and a message is seen in dmesg:
> > > > 
> > > >     x86/PAT: test:177 freeing invalid memtype [mem 0xfd000000-0xfd000fff]
> > > > 
> > > > The second range still matches by accident, because matching only the end
> > > > address is acceptable (to handle shrinking VMA, added by 2039e6acaf94
> > > > (x86/mm/pat: Change free_memtype() to support shrinking case)).
> > > 
> > > Does this need a fixes tag?
> > 
> > Yes, it should have
> > 	Fixes: 2e5d9c857d4e ("x86: PAT infrastructure patch")
> > thanks for the reminder.
> 
> That commit is from 2008, is there a bug report on this issue?

Not that I am aware of. I'm not entirely sure why, but I would guess due to
the combination of:
- This is not an issue for pages in RAM
- This only happens if VMAs are splitted
- The only user-visible effect is merely a pr_info(), and people may miss it.

I only encountered this issue while "trying to be smart" with mprotect() on
a portion of mmap()-ed device memory, I guess probably not many people do
that.

> 
> > 
> > > 
> > > > 
> > > > Make sure VMA splitting is handled properly, by splitting the entries in
> > > > memtype_rbroot.
> > > > 
> > > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > > ---
> > > >  arch/x86/mm/pat/memtype.c          | 59 ++++++++++++++++++++++++++++++
> > > >  arch/x86/mm/pat/memtype.h          |  3 ++
> > > >  arch/x86/mm/pat/memtype_interval.c | 22 +++++++++++
> > > >  include/linux/pgtable.h            |  6 +++
> > > >  mm/mmap.c                          |  8 ++++
> > > >  5 files changed, 98 insertions(+)
> > > > 
> ...
> 
> > > 
> > > It is also a bit odd that you check VM_PFNMAP() here, then call a
> > > function to check another flag?
> > 
> > Right, this check is redundant, thanks for pointing it out.
> > 
> > I stole this "style" from unmap_single_vma(), but I think the check is
> > redundant there as well.
> 
> If you have identified a redundant check, can you please remove it with
> a separate patch?

Sure.

> 
> > 
> > > 
> > > > +		err = track_pfn_split(vma, addr);
> > > > +		if (err)
> > > > +			goto out_vma_unlink;
> > > > +	}
> > > > +
> > > 
> > > I don't think the __split_vma() location is the best place to put this.
> > > Can this be done through the vm_ops->may_split() that is called above?
> > 
> > I don't think ->may_split() is a suitable place. Its name gives me the
> > impression that it only checks whether it is okay to split the VMA, but not
> > really does any splitting work. Also that function pointer can be
> > overwritten by any driver.
> 
> It's a callback that takes the arguments you need and is called as long
> as it exists.  Your function would deny splitting if it failed, so it
> may not split in that case.
> 
> Also, any driver that overwrites it should do what is necessary for PAT
> then. I don't love the idea of using the vm_ops either, I just like it
> better than dropping in flag checks and arch-specific code.  I can see
> issue with using the callback and drivers that may have their own vma
> mapping that also use PAT, I guess.

Yeah I don't love this. You mentioned another approach below, which I
think would be the best (if it's possible). I will attempt that other
approach.

> 
> > > 
> > > This is arch independent code that now has an x86 specific check, and
> > > I'd like to keep __split_vma() out of the flag checking.
> > 
> > I think these track_pfn_*() functions are meant to be arch-independent,
> > it's just that only x86 implements it at the moment. For instance,
> > untrack_pfn() and track_pfn_remap() are called in mm/ code.
> > 
> 
> Arch-independent wrappers that are only used by one arch are not
> arch-independent.  PAT has been around for ages and only exists for x86
> and x86_64.
> 
> We just went through removing arch_unmap(), which was used just for ppc.
> They cause problems for general mm changes and just get in the way.  If
> we can avoid them, we should.
> 
> memtype_interval.c doesn't have any knowledge of the vmas, so you have
> this extraction layer in memtype.c that is being bypassed here for the
> memtype_erase(); ensuring the start-end match or at least the end
> matches.
> 
> So your comment about the second range still matching by accident is
> misleading - it's not matched at all because you are searching for the
> exact match or the end address being the same (which it isn't in your
> interval tree).

But the second range *does* match, because the end address match?
The second range is (0xfd001000-0xfd002000), which matches with
(0xfd000000-0xfd002000) in the interval tree.

Perhaps I should be clearer in the description..

> 
> Taking a step back here, you are splitting a range in an interval tree
> to match a vma split, but you aren't splitting the range based on PAT
> changing; you are splitting it based on the vma becoming two vmas.
> 
> Since VM_PFNMAP is in VM_SPECIAL, the splitting is never undone and will
> continue to fragment the interval tree, so even if flags change back to
> match each other there will always be two vams - and what changed may
> not even be the PAT.

Right, I did not consider this scenario.

> 
> So the interval split should occur when the PAT changes and needs to be
> tracked differently.  This does not happen when the vma is split - it
> happens when a vma is removed or when the PAT is changed.
> 
> And, indeed, for the mremap() shrinking case, you already support
> finding a range by just the end and have an abstraction layer.  The
> problem here is that you don't check by the start - but you could.  You
> could make the change to memtype_erase() to search for the exact, end,
> or start and do what is necessary to shrink off the front of a region as
> well.

I thought about this solution initially, but since the interval tree allow
overlapping ranges, it can be tricky to determine the "best match" out
of the overlapping ranges. But I agree that this approach (if possible)
would be better than the current patch.

Let me think about this some more, and I will come back later.

> 
> What I find very strange is that 2039e6acaf94 ("x86/mm/pat: Change
> free_memtype() to support shrinking case") enables shrinking of
> VM_PFNMAP, but doesn't allow shrinking the end address.  Why is one
> allowed and the other not allowed?

Not really sure what you mean. I think you are ultimately asking why that
commit only matches end address, and not start address? That's because
mremap() may shrink a VMA from [start, end] to [start, new_end] (with
new_end < end). In that case, the range [new_end, end] would be removed
from the interval tree, and that commit wants to match [new_end, end] to
[start, end].
And I don't think mremap() can shrink [start, end] to [new_start, end]?

Thanks for sharing your thoughts.

Best regards,
Nam

