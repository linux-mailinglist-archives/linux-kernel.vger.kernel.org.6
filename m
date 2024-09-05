Return-Path: <linux-kernel+bounces-317778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9996E3B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50F71F27CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B080918FC83;
	Thu,  5 Sep 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3bzdZQsf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+53uSW5J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F093D6D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566893; cv=none; b=eYp9zYoT8E1RA9BEyfqaQbhiP+aBxSC5DzWZVM+MW5j9RYMJrJ3lnDA3opDubIZG7rc6kwSLUOt4RapVq57jtprZbL0gcqOez0OjkNIW1b61J27gFkjxvYuBlrR9U2EurGWcXBGck06fN0NUe3E/8D1rijBu7doNsPfvXtzml5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566893; c=relaxed/simple;
	bh=xDcnY6lH0zf7ZW8j+K/b7pXHs+amBMZALfCmiD4bQ7E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7k6slai7SyzeooF9R5vP1OGlZfzKOr2ID3yc3XCbuI2YDLDPaDj/SvXdB3XhfNCH9/0w4D9lrvInqiDzpTSzr2RM3i5HbxYAMigRRrk9ogd8RAyCVoR5Kmi9Y5K6RHgqXf5FJk172ncXf2d3ZJb9e4J20kaIU3wcpaPuij48R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3bzdZQsf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+53uSW5J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Sep 2024 22:08:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725566889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgM0WkMalmx+pbbJgmLSbP7B3h75J4NY0XJJincjeU8=;
	b=3bzdZQsfWKXJZV5XYukBMdzAMaPxJtA9IO10loRsad8Finp7Ojgt2NfW81LNWnGtUHx1vh
	fJCAxAYSyxoJ8QVfdgcmKB4Xbf+zoU6o4MFStxQw10lmU7PdpXs9eznvdjABuszNDTXrqI
	oruAiJpieYs1kLOCM4S8pZef2QsVT5pAonGp+sKm8FCbMlhGCPHjmFq/ZbiLVnBybyoCJ0
	kwsNS5Nbw9IxLH1gdu8Cq8pHeqLEaysahitah6PCpbeGE8UkZiAkjaakA5RsxwJ1lNiAhT
	L884rsN2+Dt9Ng7eI0oeQEdiZh7ipWrLT22iL1eQUvk8ppjMCw8H6Ilkes7ZMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725566889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgM0WkMalmx+pbbJgmLSbP7B3h75J4NY0XJJincjeU8=;
	b=+53uSW5JfHSYC6EiCJmvorMX9fBbcW9K3gvvTEBFuQHwvtgPPk7DWDzwG7iD2/MybArZuS
	xg2EClXNphAORRCA==
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
Message-ID: <20240905200802.2vY0SstV@linutronix.de>
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
 <20240827075841.BO2qAOzq@linutronix.de>
 <yvcwdfgxnyet7rjf6lhnsypz72jmp5czfkb2muvgzcul53scn6@rkhqrfgdaxsw>
 <20240903103616.i0GrRAfD@linutronix.de>
 <lfvhfjj2ysuut7sawru6aoywjowpsba3z2t56pjxh5tbi7kxfw@h7twfxw5oalf>
 <20240904075937.xh2rLk3q@linutronix.de>
 <jv6v6bgvh2uidqqeava72pjh2d5uehtyim74r3gatxn6v2uebh@t3lbrkhh6fzw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jv6v6bgvh2uidqqeava72pjh2d5uehtyim74r3gatxn6v2uebh@t3lbrkhh6fzw>

On Wed, Sep 04, 2024 at 02:40:34PM -0400, Liam R. Howlett wrote:
> * Nam Cao <namcao@linutronix.de> [240904 03:59]:
> > On Tue, Sep 03, 2024 at 11:56:57AM -0400, Liam R. Howlett wrote:
> > > * Nam Cao <namcao@linutronix.de> [240903 06:36]:
> > ...
> > > > On Tue, Aug 27, 2024 at 12:01:28PM -0400, Liam R. Howlett wrote:
> > > > > * Nam Cao <namcao@linutronix.de> [240827 03:59]:
> > > > > > On Mon, Aug 26, 2024 at 09:58:11AM -0400, Liam R. Howlett wrote:
> > > > > > > * Nam Cao <namcao@linutronix.de> [240825 11:29]:
> > > > > So the interval split should occur when the PAT changes and needs to be
> > > > > tracked differently.  This does not happen when the vma is split - it
> > > > > happens when a vma is removed or when the PAT is changed.
> > > > > 
> > > > > And, indeed, for the mremap() shrinking case, you already support
> > > > > finding a range by just the end and have an abstraction layer.  The
> > > > > problem here is that you don't check by the start - but you could.  You
> > > > > could make the change to memtype_erase() to search for the exact, end,
> > > > > or start and do what is necessary to shrink off the front of a region as
> > > > > well.
> > > > 
> > > > I thought about this solution initially, but since the interval tree allow
> > > > overlapping ranges, it can be tricky to determine the "best match" out
> > > > of the overlapping ranges. But I agree that this approach (if possible)
> > > > would be better than the current patch.
> > > > 
> > > > Let me think about this some more, and I will come back later.
> > > 
> > > Reading this some more, I believe you can detect the correct address by
> > > matching the start address with the smallest end address (the smallest
> > > interval has to be the entry created by the vma mapping).
> > 
> > I don't think that would cover all cases. For example, if the tree has 2
> > intervals: [0x0000-0x2000] and [0x1000-0x3000]. Now, the mm subsystem tells
> > us that the interval [0x1000-0x2000] needs to be removed (e.g. user does
> > munmap()), your proposal would match this to the second interval. After the
> > removal, the tree has [0-0x2000] and [0x2000-0x3000]
> > 
> > Then, mm subsystem says [0x1000-0x3000] should be removed, and that doesn't
> > match anything. Turns out, the first removal was meant for the first
> > interval, but we didn't have enough information at the time to determine
> > that.
> > 
> > Bottom line is, it is not possible to correctly match [0x1000-0x2000] to
> > [0x0000-0x2000] and [0x1000-0x3000]: both matches can be valid.
> 
> But those ranges won't exist.  What appears to be happening in this code
> is that there are higher levels of non-overlapping ranges with
> memory (cache) types (or none are defined) , which are tracked on page
> granularity.  So we can't have a page that has two memory type.
> 
> The overlapping happens later, when the vmas are mapped.  And we are
> ensuring that the mapping of the vmas match the higher, larger areas.
> The vmas are inserted with memtype_check_insert() which calls
> memtype_check_conflict() that ensures any overlapping areas have the
> same type as the one being added, so either there is no match or the
> interval(s) with this page is set to a specific type.  I suspect there
> can only really be one range.
> 
> So I don't think overlapping areas like above could exist.  The vma
> cache type has to be the same throughout. It has to be the same type as
> all overlapping areas.

Dave agreed with you, so I am likely the confused one, but I still think
the overlapping areas as I described do exist. For example, this userspace
code:

	#include <stdio.h>
	#include <sys/mman.h>
	#include <fcntl.h>
	#include <unistd.h>
	#include <errno.h>

	#define PCI_BAR "/sys/devices/pci0000:00/0000:00:02.0/resource0"

	int main(void)
	{
		void *p1, *p2;
		int fd, ret;

		fd = open(PCI_BAR, O_RDWR);

		// track 0xfd000000-0xfd001fff
		p1 = mmap(0, 0x2000, PROT_READ, MAP_SHARED, fd, 0);

		// track 0xfd001000-0xfd002fff
		p2 = mmap(0, 0x2000, PROT_READ, MAP_SHARED, fd, 0x1000);
		
		// untrack 0xfd001000-0xfd001fff
		munmap(p2, 0x1000);

		// untrack 0xfd000000-0xfd001fff
		munmap(p1, 0x2000);

		// untrack 0xfd002000-0xfd002fff
		munmap(p2 + 0x1000, 0x1000);
	}

If I pause this program right after the two mmap(), before any munmap(),
then:
$cat /sys/kernel/debug/x86/pat_memtype_list
PAT memtype list:
PAT: [mem 0x00000000bffe0000-0x00000000bffe2000] write-back
PAT: [mem 0x00000000bffe1000-0x00000000bffe2000] write-back
PAT: [mem 0x00000000fd000000-0x00000000fd002000] uncached-minus <-- what I described
PAT: [mem 0x00000000fd001000-0x00000000fd003000] uncached-minus <-- what I described
PAT: [mem 0x00000000febc0000-0x00000000febe0000] uncached-minus
PAT: [mem 0x00000000fed00000-0x00000000fed01000] uncached-minus
PAT: [mem 0x00000000fed00000-0x00000000fed01000] uncached-minus

The 2 mmap() call would create the overlapping intervals as I described.
Then, I let the C program run to completion, see what happen in dmesg:

x86/PAT: memtype_reserve added [mem 0xfd000000-0xfd001fff], track uncached-minus, req uncached-minus, ret uncached-minus
x86/PAT: Overlap at 0xfd000000-0xfd002000
x86/PAT: memtype_reserve added [mem 0xfd001000-0xfd002fff], track uncached-minus, req uncached-minus, ret uncached-minus
x86/PAT: memtype_free request [mem 0xfd001000-0xfd001fff]
x86/PAT: test:178 freeing invalid memtype [mem 0xfd000000-0xfd001fff]
x86/PAT: memtype_free request [mem 0xfd002000-0xfd002fff]

The problem I am raising is the first munmap() call:
[0xfd001000-0xfd001fff] would be untracked, but there is no way to tell for
sure which interval it belongs to. The current implementation matches it to
the first range, but it actually belongs to the second range. This
incorrect matching results in the "freeing invalid memtype" later on.

Hopefully I'm not being an idiot and wasting everyone's time..
> 
> Also, your ranges are inclusive while the ranges passed in seem to be
> exclusive on the end address, so your example would look more like:
> [0x0000-0x2000) [0x2000-0x3000).
> 
> You can see this documented in memtype_reserve() where sanitize_phys()
> is called.
> 
> So we could have a VMA of [0x1000-0x2000), but this vma would have to be
> in the first range.  [0x0000-0x0FFF) would also be in the first range.
> 
> I think that searching for the smallest area containing the entry will
> yield the desired entry in the interval tree.
> 
> Note that there is debugging support in the Documentation so you can go
> look at what is in there with debugfs.
> 
> ...
> 
> > One solution I can think of: stop allowing overlapping intervals. Instead,
> > the overlapping portions would be split into new intervals with some
> > reference counting. memtype_erase() would need to be modified to:
> >   - assemble the potentially split intervals
> >   - split the intervals if needed
> > The point is, there wouldn't be any confusion with matching overlapping
> > intervals.
> > 
> > I will give it a try when I have some time, unless someone sees a problem
> > with it or has a better idea.
> 
> I don't think this will work at all.  It is dependent of overlapping
> ranges to ensure the vmas match what is allowed in certain areas.

We can ensure that the cache type is the same, before splitting, so I think
it can work? But let's clear up the other disagreement first.

Best regards,
Nam

