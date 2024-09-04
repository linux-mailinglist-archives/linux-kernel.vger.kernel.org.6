Return-Path: <linux-kernel+bounces-314468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD92B96B3C2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24111C21FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F3215B108;
	Wed,  4 Sep 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T80SuPgS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aMm+reVd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01179146A7A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436787; cv=none; b=HM4SxbmVWAgH/S79THcmRhaojvhkSFAdpYjHEqc51Ko5sruTcYfd+j74m4guj+diribvW/l0okC/JcPynjQNsEt5FbAvcM7pCkWEmBapbE7Ymj3bPEHK+ATBXSzXUxl829b0s7Cfqn7edobxWu1DonYVQ1wQkwkkrFrBUTLWAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436787; c=relaxed/simple;
	bh=dcZ8sWtMjH+Z+LtHp1MMkosSAdDqBWptj5JaxlzvEZk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3PAT7BGI2iVEw8FJUuVNZncUYeSZ3SdGkC/obNYdkBQ6cJUrLGF3W4Qnai/IZ0mKZuKk8/EQZfbUGRZj+6ExsHlL5jXzv82+vVlqvBi9U8Bpi9D4goQaw+59A9rPSUl+JdS/2IaZg/LdxFPZ+OIgbZU8d1pqqPLkrRYwMIyfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T80SuPgS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aMm+reVd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Sep 2024 09:59:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725436783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19U+hr4GKHa4foG1/I7imHFQ5sK//rA/lLqCzRxxYeI=;
	b=T80SuPgStktC/oFLgeudqOUTa4wtZ3jq98lj6zIOQ1E2p8KfFuE4qXWMh5/5kjEe5F5qpZ
	yIIMRJsodG+936MJvlGn4u/w5wlsLNklpJblcoWL0qQM95qqYPjHvw/mgwS+09dtsTk3Ib
	HwGNPr+oHDoJ5U83QyJ0309AyfaQLvI3nC9iFFbJYvqbWq1m7ZzGZcMUCa3vxKnpDtM2/0
	7nAagd1lUtnSNfMUPTaGoSb+2DkXjrfQ1R+mWCag81eMDe0DxTuS4RRFFxrB1P6qukDVeR
	Fn9nkSKVzuQ7Az57xxI/QCSZ79aM/Yh/mvObhDdqUuLapLKpCGGTnUVaMmTmwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725436783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19U+hr4GKHa4foG1/I7imHFQ5sK//rA/lLqCzRxxYeI=;
	b=aMm+reVdAw61+ci/WINuniKHTtDjBZf1rYWGM6q3kEH6wYE8V1EOYa4PsAhfQuUHu/k15o
	AGfIN0pNRP0z5sAQ==
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
Message-ID: <20240904075937.xh2rLk3q@linutronix.de>
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
 <20240827075841.BO2qAOzq@linutronix.de>
 <yvcwdfgxnyet7rjf6lhnsypz72jmp5czfkb2muvgzcul53scn6@rkhqrfgdaxsw>
 <20240903103616.i0GrRAfD@linutronix.de>
 <lfvhfjj2ysuut7sawru6aoywjowpsba3z2t56pjxh5tbi7kxfw@h7twfxw5oalf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lfvhfjj2ysuut7sawru6aoywjowpsba3z2t56pjxh5tbi7kxfw@h7twfxw5oalf>

On Tue, Sep 03, 2024 at 11:56:57AM -0400, Liam R. Howlett wrote:
> * Nam Cao <namcao@linutronix.de> [240903 06:36]:
...
> > On Tue, Aug 27, 2024 at 12:01:28PM -0400, Liam R. Howlett wrote:
> > > * Nam Cao <namcao@linutronix.de> [240827 03:59]:
> > > > On Mon, Aug 26, 2024 at 09:58:11AM -0400, Liam R. Howlett wrote:
> > > > > * Nam Cao <namcao@linutronix.de> [240825 11:29]:
...
> > > > > > 
> > > > > > with the physical address starting from 0xfd000000, the range
> > > > > > (0xfd000000-0xfd002000) would be tracked with the mmap() call.
> > > > > > 
> > > > > > After mprotect(), the initial range gets splitted into
> > > > > > (0xfd000000-0xfd001000) and (0xfd001000-0xfd002000).
> > > > > > 
> > > > > > Then, at munmap(), the first range does not match any entry in
> > > > > > memtype_rbroot, and a message is seen in dmesg:
> > > > > > 
> > > > > >     x86/PAT: test:177 freeing invalid memtype [mem 0xfd000000-0xfd000fff]
> > > > > > 
> > > > > > The second range still matches by accident, because matching only the end
> > > > > > address is acceptable (to handle shrinking VMA, added by 2039e6acaf94
> > > > > > (x86/mm/pat: Change free_memtype() to support shrinking case)).
> > > > > 
> > > > > Does this need a fixes tag?
> > > > 
> > > > Yes, it should have
> > > > 	Fixes: 2e5d9c857d4e ("x86: PAT infrastructure patch")
> > > > thanks for the reminder.
> > > 
> > > That commit is from 2008, is there a bug report on this issue?
> > 
> > Not that I am aware of. I'm not entirely sure why, but I would guess due to
> > the combination of:
> > - This is not an issue for pages in RAM
> > - This only happens if VMAs are splitted
> > - The only user-visible effect is merely a pr_info(), and people may miss it.
> > 
> > I only encountered this issue while "trying to be smart" with mprotect() on
> > a portion of mmap()-ed device memory, I guess probably not many people do
> > that.
> 
> Or test it.  I would have though some bots would have caught this.
> Although the log message is just pr_info()?  That seems wrong - we have
> an error in the vma tree or the PAT tree and it's just an info printk?

Yeah right, I think pr_info() is another issue, it should be pr_warn() or
pr_err(). That is probably another patch.

...
> > > 
> > > So the interval split should occur when the PAT changes and needs to be
> > > tracked differently.  This does not happen when the vma is split - it
> > > happens when a vma is removed or when the PAT is changed.
> > > 
> > > And, indeed, for the mremap() shrinking case, you already support
> > > finding a range by just the end and have an abstraction layer.  The
> > > problem here is that you don't check by the start - but you could.  You
> > > could make the change to memtype_erase() to search for the exact, end,
> > > or start and do what is necessary to shrink off the front of a region as
> > > well.
> > 
> > I thought about this solution initially, but since the interval tree allow
> > overlapping ranges, it can be tricky to determine the "best match" out
> > of the overlapping ranges. But I agree that this approach (if possible)
> > would be better than the current patch.
> > 
> > Let me think about this some more, and I will come back later.
> 
> Reading this some more, I believe you can detect the correct address by
> matching the start address with the smallest end address (the smallest
> interval has to be the entry created by the vma mapping).

I don't think that would cover all cases. For example, if the tree has 2
intervals: [0x0000-0x2000] and [0x1000-0x3000]. Now, the mm subsystem tells
us that the interval [0x1000-0x2000] needs to be removed (e.g. user does
munmap()), your proposal would match this to the second interval. After the
removal, the tree has [0-0x2000] and [0x2000-0x3000]

Then, mm subsystem says [0x1000-0x3000] should be removed, and that doesn't
match anything. Turns out, the first removal was meant for the first
interval, but we didn't have enough information at the time to determine
that.

Bottom line is, it is not possible to correctly match [0x1000-0x2000] to
[0x0000-0x2000] and [0x1000-0x3000]: both matches can be valid.

> 
> > 
> > > 
> > > What I find very strange is that 2039e6acaf94 ("x86/mm/pat: Change
> > > free_memtype() to support shrinking case") enables shrinking of
> > > VM_PFNMAP, but doesn't allow shrinking the end address.  Why is one
> > > allowed and the other not allowed?
> > 
> > Not really sure what you mean. I think you are ultimately asking why that
> > commit only matches end address, and not start address? That's because
> > mremap() may shrink a VMA from [start, end] to [start, new_end] (with
> > new_end < end). In that case, the range [new_end, end] would be removed
> > from the interval tree, and that commit wants to match [new_end, end] to
> > [start, end].
> > And I don't think mremap() can shrink [start, end] to [new_start, end]?
> 
> Even an untrack_pfn() call will only remove the first entry that
> matches exactly or the end.  Since the tree is sorted by start address,
> I guess the smallest (since it's not specified if it's ordered
> descending or ascending, and smaller makes more sense) interval will be
> deleted?  That is, a vma cannot span different attributes but attributes
> can span vmas.
> 
> Oh wow, this also means if you unmap the end vma first, you will not
> have an issue because the memtype_erase() (incorrectly named now) will
> resize your PAT entry to match the start vma range.

Right. Also funnily, if I run the test program in the description multiple
times, only the first run causes the message in dmesg; the following runs
do not see any problem, because of happy accident: the first run "leaks"
the 0xfd000000-0xfd000fff interval in the tree, which is accidentally
matched by the following runs.

> 
> I wonder what would happen in the "punch a hole" scenario where we
> move/MAP_FIXED/unmap the middle of a vma.

If we think more about it, I'm sure we will come up with more scenarios
that are broken with the current implementation.

> 
> My point is that it is unclear as to how the interval tree tracks the
> PAT to vma mappings (a more clean comment would be nice). It seems
> inconsistent and the situation you found should be handled in the
> translation layer, and not the generic code.

One solution I can think of: stop allowing overlapping intervals. Instead,
the overlapping portions would be split into new intervals with some
reference counting. memtype_erase() would need to be modified to:
  - assemble the potentially split intervals
  - split the intervals if needed
The point is, there wouldn't be any confusion with matching overlapping
intervals.

I will give it a try when I have some time, unless someone sees a problem
with it or has a better idea.

Best regards,
Nam

