Return-Path: <linux-kernel+bounces-302817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B839603C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863F0281580
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01499157468;
	Tue, 27 Aug 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v53/TiXJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/K0UB8Rw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1B158D66
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745533; cv=none; b=vC44H01cC6eh34q0GVFwt4gRayjGWWOaULCrzV0VnhJJrDo/0DbNTaYOFQgJBlYTmaz3AUr4llyLrtLO+iOxLHb7EHl2UnQeQQqEeKCHO5JAI84DrcDR/eOSAa36fhBLB3MvAh2Bgmldcxy1ypVT+aVJ9S2eg5QvFc0H5HioFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745533; c=relaxed/simple;
	bh=jg++Ti+RrVMrLq15OsLjBqlIc9Z51Kq8fN3M3ELT8H4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCRtCFRDHXf/Of2PsGuScSMeXz2O4QLXrb1Qzr9K+tzA0tLBiLFljP3eYYJRWEt8M9Pf3EhSOXFlmU2enHO4v77I6zn/5fLFVUwzxk3fx2t8MrYSrQJs9MdJhk7XKrMzr8DUYfgwvwncjTytNen/03TwYmjQxUDr+ULanADQfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v53/TiXJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/K0UB8Rw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 09:58:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724745529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IoyFHNWujS6+SIVpU4DgMwB3fKrYFjEN5V13+7syUrU=;
	b=v53/TiXJ3XquxJXTaIyYl2vRb7Y/at/2FbCZyO9kgn5w9L4/zDzT+IW2ggV5HuW/bmHFDu
	yB2AThfoBUGU04gysIHAhgosCwmibCP+ACdhz8eglkzE0C8HoyccyNJNyMY96Ltp6pe1wa
	a43X22vpC4Xxd4itDj9goM36n9twN3QPE/2hbdec6uWw9LjGU5tbvj7/PezETGhywxb7GU
	PwkttnzA4tAdbb29exXvfObfjbZa8p7pJpP1vsvIg8WGwjsDFzEqxiO3/Xc8CQ3LconKIb
	QcrdwKMmZshgKbKvckmTzwUEOW2qCOyUpaXDdSk1iSL74cica0B92bS7TNxMnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724745529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IoyFHNWujS6+SIVpU4DgMwB3fKrYFjEN5V13+7syUrU=;
	b=/K0UB8RwEuQaEJLnn6eQPb8FSixdTSk/CAvUHtUPx8Qt2XcQ7FGZf3lA1xGi0GI1UctG2+
	eWVvbnl0Ym3NbgBw==
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
Message-ID: <20240827075841.BO2qAOzq@linutronix.de>
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>

On Mon, Aug 26, 2024 at 09:58:11AM -0400, Liam R. Howlett wrote:
> * Nam Cao <namcao@linutronix.de> [240825 11:29]:
> > When a virtual memory area (VMA) gets splitted, memtype_rbroot's entries
> > are not updated. This causes confusion later on when the VMAs get
> > un-mapped, because the address ranges of the splitted VMAs do not match the
> > address range of the initial VMA.
> > 
> > For example, if user does:
> > 
> > 	fd = open("/some/pci/bar", O_RDWR);
> > 	addr = mmap(0, 8192, PROT_READ, MAP_SHARED, fd, 0);
> > 	mprotect(addr, 4096, PROT_READ | PROT_WRITE);
> > 	munmap(p, 8192);
> > 
> > with the physical address starting from 0xfd000000, the range
> > (0xfd000000-0xfd002000) would be tracked with the mmap() call.
> > 
> > After mprotect(), the initial range gets splitted into
> > (0xfd000000-0xfd001000) and (0xfd001000-0xfd002000).
> > 
> > Then, at munmap(), the first range does not match any entry in
> > memtype_rbroot, and a message is seen in dmesg:
> > 
> >     x86/PAT: test:177 freeing invalid memtype [mem 0xfd000000-0xfd000fff]
> > 
> > The second range still matches by accident, because matching only the end
> > address is acceptable (to handle shrinking VMA, added by 2039e6acaf94
> > (x86/mm/pat: Change free_memtype() to support shrinking case)).
> 
> Does this need a fixes tag?

Yes, it should have
	Fixes: 2e5d9c857d4e ("x86: PAT infrastructure patch")
thanks for the reminder.

> 
> > 
> > Make sure VMA splitting is handled properly, by splitting the entries in
> > memtype_rbroot.
> > 
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> >  arch/x86/mm/pat/memtype.c          | 59 ++++++++++++++++++++++++++++++
> >  arch/x86/mm/pat/memtype.h          |  3 ++
> >  arch/x86/mm/pat/memtype_interval.c | 22 +++++++++++
> >  include/linux/pgtable.h            |  6 +++
> >  mm/mmap.c                          |  8 ++++
> >  5 files changed, 98 insertions(+)
> > 
> > diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> > index bdc2a240c2aa..b60019478a76 100644
> > --- a/arch/x86/mm/pat/memtype.c
> > +++ b/arch/x86/mm/pat/memtype.c
> > @@ -935,6 +935,46 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
> >  	return 0;
> >  }
> >  
> > +static int split_pfn_range(u64 start, u64 end, u64 addr)
> > +{
> > +	struct memtype *entry_new;
> > +	int is_range_ram, ret;
> > +
> > +	if (!pat_enabled())
> > +		return 0;
> > +
> > +	start = sanitize_phys(start);
> > +	end = sanitize_phys(end - 1) + 1;
> > +
> > +	/* Low ISA region is not tracked, it is always mapped WB */
> > +	if (x86_platform.is_untracked_pat_range(start, end))
> > +		return 0;
> > +
> > +	is_range_ram = pat_pagerange_is_ram(start, end);
> > +	if (is_range_ram == 1)
> > +		return 0;
> > +
> > +	if (is_range_ram < 0)
> > +		return -EINVAL;
> > +
> > +	entry_new = kmalloc(sizeof(*entry_new), GFP_KERNEL);
> > +	if (!entry_new)
> > +		return -ENOMEM;
> > +
> > +	spin_lock(&memtype_lock);
> > +	ret = memtype_split(start, end, addr, entry_new);
> > +	spin_unlock(&memtype_lock);
> > +
> > +	if (ret) {
> > +		pr_err("x86/PAT: %s:%d splitting invalid memtype [mem %#010Lx-%#010Lx]\n",
> > +			current->comm, current->pid, start, end - 1);
> > +		kfree(entry_new);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Internal interface to free a range of physical memory.
> >   * Frees non RAM regions only.
> > @@ -1072,6 +1112,25 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
> >  	return 0;
> >  }
> >  
> > +int track_pfn_split(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	unsigned long vma_size = vma->vm_end - vma->vm_start;
> > +	resource_size_t start_paddr, split_paddr;
> > +	int ret;
> > +
> > +	if (vma->vm_flags & VM_PAT) {
> > +		ret = get_pat_info(vma, &start_paddr, NULL);
> > +		if (ret)
> > +			return ret;
> > +
> > +		split_paddr = start_paddr + addr - vma->vm_start;
> > +
> > +		return split_pfn_range(start_paddr, start_paddr + vma_size, split_paddr);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
> >  {
> >  	enum page_cache_mode pcm;
> > diff --git a/arch/x86/mm/pat/memtype.h b/arch/x86/mm/pat/memtype.h
> > index cacecdbceb55..e01dc2018ab6 100644
> > --- a/arch/x86/mm/pat/memtype.h
> > +++ b/arch/x86/mm/pat/memtype.h
> > @@ -31,6 +31,7 @@ static inline char *cattr_name(enum page_cache_mode pcm)
> >  #ifdef CONFIG_X86_PAT
> >  extern int memtype_check_insert(struct memtype *entry_new,
> >  				enum page_cache_mode *new_type);
> > +extern int memtype_split(u64 start, u64 end, u64 addr, struct memtype *entry_new);
> 
> I think we are dropping unnecessary externs now.

It would look a bit odd, since the surrounding declarations all have
"extern". I have no strong preference, so if you prefer it that way, then
sure.
> 
> >  extern struct memtype *memtype_erase(u64 start, u64 end);
> >  extern struct memtype *memtype_lookup(u64 addr);
> >  extern int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos);
> > @@ -38,6 +39,8 @@ extern int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos);
> >  static inline int memtype_check_insert(struct memtype *entry_new,
> >  				       enum page_cache_mode *new_type)
> >  { return 0; }
> > +static inline int memtype_split(u64 start, u64 end, u64 addr, struct memtype *entry_new)
> > +{ return 0; }
> >  static inline struct memtype *memtype_erase(u64 start, u64 end)
> >  { return NULL; }
> >  static inline struct memtype *memtype_lookup(u64 addr)
> > diff --git a/arch/x86/mm/pat/memtype_interval.c b/arch/x86/mm/pat/memtype_interval.c
> > index 645613d59942..c75d9ee6b72f 100644
> > --- a/arch/x86/mm/pat/memtype_interval.c
> > +++ b/arch/x86/mm/pat/memtype_interval.c
> > @@ -128,6 +128,28 @@ int memtype_check_insert(struct memtype *entry_new, enum page_cache_mode *ret_ty
> >  	return 0;
> >  }
> >  
> > +int memtype_split(u64 start, u64 end, u64 addr, struct memtype *entry_new)
> > +{
> > +	struct memtype *entry_old;
> > +
> > +	entry_old = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
> > +	if (!entry_old)
> > +		return -EINVAL;
> > +
> > +	interval_remove(entry_old, &memtype_rbroot);
> > +
> > +	entry_new->start = addr;
> > +	entry_new->end	 = entry_old->end;
> > +	entry_new->type	 = entry_old->type;
> > +
> > +	entry_old->end = addr;
> > +
> > +	interval_insert(entry_old, &memtype_rbroot);
> > +	interval_insert(entry_new, &memtype_rbroot);
> > +
> > +	return 0;
> > +}
> > +
> >  struct memtype *memtype_erase(u64 start, u64 end)
> >  {
> >  	struct memtype *entry_old;
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 2a6a3cccfc36..8bfc8d0f5dd2 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1502,6 +1502,11 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
> >  	return 0;
> >  }
> >  
> > +static inline int track_pfn_split(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	return 0;
> > +}
> > +
> >  /*
> >   * track_pfn_insert is called when a _new_ single pfn is established
> >   * by vmf_insert_pfn().
> > @@ -1542,6 +1547,7 @@ static inline void untrack_pfn_clear(struct vm_area_struct *vma)
> >  extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
> >  			   unsigned long pfn, unsigned long addr,
> >  			   unsigned long size);
> > +extern int track_pfn_split(struct vm_area_struct *vma, unsigned long addr);
> 
> Same extern comment here.

Same answer as above.

> 
> >  extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
> >  			     pfn_t pfn);
> >  extern int track_pfn_copy(struct vm_area_struct *vma);
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d0dfc85b209b..64067ddb8382 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2486,6 +2486,12 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	if (err)
> >  		goto out_free_mpol;
> >  
> > +	if (unlikely(vma->vm_flags & VM_PFNMAP)) {
> 
> It is also a bit odd that you check VM_PFNMAP() here, then call a
> function to check another flag?

Right, this check is redundant, thanks for pointing it out.

I stole this "style" from unmap_single_vma(), but I think the check is
redundant there as well.

> 
> > +		err = track_pfn_split(vma, addr);
> > +		if (err)
> > +			goto out_vma_unlink;
> > +	}
> > +
> 
> I don't think the __split_vma() location is the best place to put this.
> Can this be done through the vm_ops->may_split() that is called above?

I don't think ->may_split() is a suitable place. Its name gives me the
impression that it only checks whether it is okay to split the VMA, but not
really does any splitting work. Also that function pointer can be
overwritten by any driver.
> 
> This is arch independent code that now has an x86 specific check, and
> I'd like to keep __split_vma() out of the flag checking.

I think these track_pfn_*() functions are meant to be arch-independent,
it's just that only x86 implements it at the moment. For instance,
untrack_pfn() and track_pfn_remap() are called in mm/ code.

> The only error
> after the vm_ops check is ENOMEM (without any extra GFP restrictions on
> the allocations), you don't need the new vma, and use the same arguments
> passed to vm_ops->may_split().
> 
> 
> >  	if (new->vm_file)
> >  		get_file(new->vm_file);
> >  
> > @@ -2515,6 +2521,8 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		vma_next(vmi);
> >  	return 0;
> >  
> > +out_vma_unlink:
> > +	unlink_anon_vmas(vma);
> >  out_free_mpol:
> >  	mpol_put(vma_policy(new));
> >  out_free_vmi:
> > -- 
> > 2.39.2
> > 

Thanks for the comments,
Nam

