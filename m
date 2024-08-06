Return-Path: <linux-kernel+bounces-276297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5611A9491D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD16E1F222D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3D11D2F76;
	Tue,  6 Aug 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="yWtTmK8u"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C11D2F59
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951775; cv=none; b=Gdk86hHi6Ad4mQFePPZM6FGOfhuWagWQexXu6CX0WQ1JyrE1YQQJyCSJbg39frYtMKkcYQdazVliFgNEAwi6QL0TV3SmM3LSH+fnFJVoGKX2mg4G/uXjYylAR7f9hh0FjDDvmSbZQHE7ZRB8SDtTOp8MexN5dW5bwaY+Xn7WVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951775; c=relaxed/simple;
	bh=IIVGty0cEIrXufFMJ8Nhe2Opm9EHnTVU9P6tEmAjxS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blESSQMd+AdS9IYgkcZdQWRFMBG2jPidEwJTCmp5WLrXcHiwcHCLRjTWlZTzReOClNTcQ1NT7xcIuRQJt/sHcedMcr4968D380uZUCDe+UrzhiXu0d/V7RfDcmWsgtLF498LGOA39VNoevnLxGp3PtCxkEUGTNzd3w3z8mOhW2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=yWtTmK8u; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 81F191D0C1F;
	Tue,  6 Aug 2024 15:42:50 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722951770; bh=ynOxsOvj2vxrpSx7ExtAQhVyQxPl7E4m5WSKglsqVlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yWtTmK8uHSwNeTje1Y4wmo1yUYXdsCC+odulROG+2TWWEVZRQEgDAWVE0OI4PhGOs
	 6sjgozh7GOzg5r54Ba/jK5RZLNSQJQfu13jUgYni42EkJZb/nOFIq4rE4qMjwaAuZn
	 vTrg7WrKmCiYkQQJq66PXJ4AzKOWIB0qinTX+5x1GU5AhuHiKzZvsfSE30FScNoLhj
	 5bXEjBRbsqZs55AZfZ9F/DXY8dXlgXHmH6+Wq7lD+BLxA/l8I6XCVqraHi3A6EjPyD
	 E8DibkPn6vEGBW+LVMlvofE0XdpMnIDvge03YbQi+1BIYJn/So148BlhTVHgOmdO9C
	 UAmT9hKvBftmA==
Date: Tue, 6 Aug 2024 15:42:44 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 09/10] mm: refactor vma_merge() into modify-only
 vma_merge_modified()
Message-ID: <20240806154244.5faeba67@mordecai.tesarici.cz>
In-Reply-To: <5ffdf3241d10bfe96371947a27f596bf21761af8.1722849860.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<5ffdf3241d10bfe96371947a27f596bf21761af8.1722849860.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 13:13:56 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> The existing vma_merge() function is no longer required to handle what were
> previously referred to as cases 1-3 (i.e. the merging of a new VMA), as
> this is now handled by vma_merge_new_vma().
> 
> Additionally, we simplify the convoluted control flow of the original,
> maintaining identical logic only expressed more clearly and doing away with
> a complicated set of cases, rather logically examining each possible
> outcome - merging of both the previous and subsequent VMA, merging of the
> previous VMA and merging of the subsequent VMA alone.
> 
> We now utilise the previously implemented commit_merge() function to share
> logic with vma_expand() deduplicating code and providing less surface area
> for bugs and confusion.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c | 474 +++++++++++++++++++++++++++----------------------------
>  mm/vma.h |   6 -
>  2 files changed, 232 insertions(+), 248 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index b7e3c64d5d68..c55ae035f5d6 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -569,8 +569,7 @@ static int commit_merge(struct vma_merge_struct *vmg,
>  			struct vm_area_struct *adjust,
>  			struct vm_area_struct *remove,
>  			struct vm_area_struct *remove2,
> -			long adj_start,
> -			bool expanded)
> +			long adj_start, bool expanded)

Um. Oops? ;-)

Otherwise LGTM.

Petr T

>  {
>  	struct vma_prepare vp;
>  
> @@ -607,6 +606,236 @@ static int commit_merge(struct vma_merge_struct *vmg,
>  	return 0;
>  }
>  
> +/*
> + * vma_merge_modified - Attempt to merge VMAs based on a VMA having its
> + * attributes modified.
> + *
> + * @vmg: Describes the modifications being made to a VMA and associated
> + *       metadata.
> + *
> + * When the attributes of a range within a VMA change, then it might be possible
> + * for immediately adjacent VMAs to be merged into that VMA due to having
> + * identical properties.
> + *
> + * This function checks for the existence of any such mergeable VMAs and updates
> + * the maple tree describing the @vmg->vma->vm_mm address space to account for
> + * this, as well as any VMAs shrunk/expanded/deleted as a result of this merge.
> + *
> + * As part of this operation, if a merge occurs, the @vmg object will have its
> + * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
> + * calls to this function should reset these fields.
> + *
> + * Returns: The merged VMA if merge succeeds, or NULL otherwise.
> + *
> + * ASSUMPTIONS:
> + * - The caller must assign the VMA to be modifed to vmg->vma.
> + * - The caller must have set vmg->prev to the previous VMA, if there is one.
> + * - The caller does not need to set vmg->next, as we determine this.
> + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> + */
> +static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> +{
> +	struct vm_area_struct *vma = vmg->vma;
> +	struct vm_area_struct *prev = vmg->prev;
> +	struct vm_area_struct *next, *res;
> +	struct vm_area_struct *anon_dup = NULL;
> +	struct vm_area_struct *adjust = NULL;
> +	unsigned long start = vmg->start;
> +	unsigned long end = vmg->end;
> +	bool left_side = vma && start == vma->vm_start;
> +	bool right_side = vma && end == vma->vm_end;
> +	bool merge_will_delete_vma, merge_will_delete_next;
> +	bool merge_left, merge_right;
> +	bool merge_both = false;
> +	int err = 0;
> +	long adj_start = 0;
> +
> +	VM_WARN_ON(!vma); /* We are modifying a VMA, so caller must specify. */
> +	VM_WARN_ON(vmg->next); /* We set this. */
> +	VM_WARN_ON(prev && start <= prev->vm_start);
> +	VM_WARN_ON(start >= end);
> +	/*
> +	 * If vma == prev, then we are offset into a VMA. Otherwise, if we are
> +	 * not, we must span a portion of the VMA.
> +	 */
> +	VM_WARN_ON(vma && ((vma != prev && vmg->start != vma->vm_start) ||
> +			   vmg->end > vma->vm_end));
> +
> +	/*
> +	 * If a special mapping or neither at the furthermost left or right side
> +	 * of the VMA, then we have no chance of merging and should abort.
> +	 *
> +	 * We later require that vma->vm_flags == vm_flags, so this tests
> +	 * vma->vm_flags & VM_SPECIAL, too.
> +	 */
> +	if (vmg->flags & VM_SPECIAL || (!left_side && !right_side))
> +		return NULL;
> +
> +	if (left_side && prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> +		merge_left = true;
> +		vma_prev(vmg->vmi);
> +	} else {
> +		merge_left = false;
> +	}
> +
> +	if (right_side) {
> +		next = vmg->next = vma_lookup(vma->vm_mm, end);
> +
> +		/*
> +		 * We can merge right if there is a subsequent VMA, if it is
> +		 * immediately adjacent, and if it is compatible with vma.
> +		 */
> +		merge_right = next && end == next->vm_start &&
> +			can_vma_merge_before(vmg);
> +
> +		/*
> +		 * We can only merge both if the anonymous VMA of the previous
> +		 * VMA is compatible with the anonymous VMA of the subsequent
> +		 * VMA.
> +		 *
> +		 * Otherwise, we default to merging only the left.
> +		 */
> +		if (merge_left && merge_right)
> +			merge_right = merge_both =
> +				is_mergeable_anon_vma(prev->anon_vma,
> +						      next->anon_vma, NULL);
> +	} else {
> +		merge_right = false;
> +		next = NULL;
> +	}
> +
> +	/* If we have nothing to merge, abort. */
> +	if (!merge_left && !merge_right)
> +		return NULL;
> +
> +	/* If we span the entire VMA, a merge implies it will be deleted. */
> +	merge_will_delete_vma = left_side && right_side;
> +	/* If we merge both VMAs, then next is also deleted. */
> +	merge_will_delete_next = merge_both;
> +
> +	/* No matter what happens, we will be adjusting vma. */
> +	vma_start_write(vma);
> +
> +	if (merge_left)
> +		vma_start_write(prev);
> +
> +	if (merge_right)
> +		vma_start_write(next);
> +
> +	if (merge_both) {
> +		/*
> +		 *         |<----->|
> +		 * |-------*********-------|
> +		 *   prev     vma     next
> +		 *  extend   delete  delete
> +		 */
> +
> +		vmg->vma = prev;
> +		vmg->start = prev->vm_start;
> +		vmg->end = next->vm_end;
> +		vmg->pgoff = prev->vm_pgoff;
> +
> +		/*
> +		 * We already ensured anon_vma compatibility above, so now it's
> +		 * simply a case of, if prev has no anon_vma object, which of
> +		 * next or vma contains the anon_vma we must duplicate.
> +		 */
> +		err = dup_anon_vma(prev, next->anon_vma ? next : vma, &anon_dup);
> +	} else if (merge_left) {
> +		/*
> +		 *         |<----->| OR
> +		 *         |<--------->|
> +		 * |-------*************
> +		 *   prev       vma
> +		 *  extend shrink/delete
> +		 */
> +
> +		unsigned long end = vmg->end;
> +
> +		vmg->vma = prev;
> +		vmg->start = prev->vm_start;
> +		vmg->pgoff = prev->vm_pgoff;
> +
> +		if (merge_will_delete_vma) {
> +			/*
> +			 * can_vma_merge_after() assumed we would not be
> +			 * removing vma, so it skipped the check for
> +			 * vm_ops->close, but we are removing vma.
> +			 */
> +			if (vma->vm_ops && vma->vm_ops->close)
> +				err = -EINVAL;
> +		} else {
> +			adjust = vma;
> +			adj_start = end - vma->vm_start;
> +		}
> +
> +		if (!err)
> +			err = dup_anon_vma(prev, vma, &anon_dup);
> +	} else { /* merge_right */
> +		/*
> +		 *     |<----->| OR
> +		 * |<--------->|
> +		 * *************-------|
> +		 *      vma       next
> +		 * shrink/delete extend
> +		 */
> +
> +		pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> +
> +		VM_WARN_ON(!merge_right);
> +		/* If we are offset into a VMA, then prev must be vma. */
> +		VM_WARN_ON(vmg->start > vma->vm_start && prev && vma != prev);
> +
> +		if (merge_will_delete_vma) {
> +			vmg->vma = next;
> +			vmg->end = next->vm_end;
> +			vmg->pgoff = next->vm_pgoff - pglen;
> +		} else {
> +			/*
> +			 * We shrink vma and expand next.
> +			 *
> +			 * IMPORTANT: This is the ONLY case where the final
> +			 * merged VMA is NOT vmg->vma, but rather vmg->next.
> +			 */
> +
> +			vmg->start = vma->vm_start;
> +			vmg->end = start;
> +			vmg->pgoff = vma->vm_pgoff;
> +
> +			adjust = next;
> +			adj_start = -(vma->vm_end - start);
> +		}
> +
> +		err = dup_anon_vma(next, vma, &anon_dup);
> +	}
> +
> +	if (err)
> +		goto abort;
> +
> +	if (commit_merge(vmg, adjust,
> +			 merge_will_delete_vma ? vma : NULL,
> +			 merge_will_delete_next ? next : NULL,
> +			 adj_start,
> +			 /*
> +			  * In nearly all cases, we expand vmg->vma. There is
> +			  * one exception - merge_right where we partially span
> +			  * the VMA. In this case we shrink the end of vmg->vma
> +			  * and adjust the start of vmg->next accordingly.
> +			  */
> +			 !merge_right || merge_will_delete_vma))
> +		return NULL;
> +
> +	res = merge_left ? prev : next;
> +	khugepaged_enter_vma(res, vmg->flags);
> +
> +	return res;
> +
> +abort:
> +	vma_iter_set(vmg->vmi, start);
> +	vma_iter_load(vmg->vmi);
> +	return NULL;
> +}
> +
>  /*
>   * vma_merge_new_vma - Attempt to merge a new VMA into address space
>   *
> @@ -1022,245 +1251,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
>  }
>  
> -/*
> - * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
> - * figure out whether that can be merged with its predecessor or its
> - * successor.  Or both (it neatly fills a hole).
> - *
> - * In most cases - when called for mmap, brk or mremap - [addr,end) is
> - * certain not to be mapped by the time vma_merge is called; but when
> - * called for mprotect, it is certain to be already mapped (either at
> - * an offset within prev, or at the start of next), and the flags of
> - * this area are about to be changed to vm_flags - and the no-change
> - * case has already been eliminated.
> - *
> - * The following mprotect cases have to be considered, where **** is
> - * the area passed down from mprotect_fixup, never extending beyond one
> - * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
> - * at the same address as **** and is of the same or larger span, and
> - * NNNN the next vma after ****:
> - *
> - *     ****             ****                   ****
> - *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
> - *    cannot merge    might become       might become
> - *                    PPNNNNNNNNNN       PPPPPPPPPPCC
> - *    mmap, brk or    case 4 below       case 5 below
> - *    mremap move:
> - *                        ****               ****
> - *                    PPPP    NNNN       PPPPCCCCNNNN
> - *                    might become       might become
> - *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
> - *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
> - *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
> - *
> - * It is important for case 8 that the vma CCCC overlapping the
> - * region **** is never going to extended over NNNN. Instead NNNN must
> - * be extended in region **** and CCCC must be removed. This way in
> - * all cases where vma_merge succeeds, the moment vma_merge drops the
> - * rmap_locks, the properties of the merged vma will be already
> - * correct for the whole merged range. Some of those properties like
> - * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
> - * be correct for the whole merged range immediately after the
> - * rmap_locks are released. Otherwise if NNNN would be removed and
> - * CCCC would be extended over the NNNN range, remove_migration_ptes
> - * or other rmap walkers (if working on addresses beyond the "end"
> - * parameter) may establish ptes with the wrong permissions of CCCC
> - * instead of the right permissions of NNNN.
> - *
> - * In the code below:
> - * PPPP is represented by *prev
> - * CCCC is represented by *curr or not represented at all (NULL)
> - * NNNN is represented by *next or not represented at all (NULL)
> - * **** is not represented - it will be merged and the vma containing the
> - *      area is returned, or the function will return NULL
> - */
> -static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> -{
> -	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
> -	struct vm_area_struct *prev = vmg->prev;
> -	struct vm_area_struct *curr, *next, *res;
> -	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> -	struct vm_area_struct *anon_dup = NULL;
> -	struct vma_prepare vp;
> -	pgoff_t vma_pgoff;
> -	int err = 0;
> -	bool merge_prev = false;
> -	bool merge_next = false;
> -	bool vma_expanded = false;
> -	unsigned long addr = vmg->start;
> -	unsigned long end = vmg->end;
> -	unsigned long vma_start = addr;
> -	unsigned long vma_end = end;
> -	pgoff_t pglen = PHYS_PFN(end - addr);
> -	long adj_start = 0;
> -
> -	/*
> -	 * We later require that vma->vm_flags == vm_flags,
> -	 * so this tests vma->vm_flags & VM_SPECIAL, too.
> -	 */
> -	if (vmg->flags & VM_SPECIAL)
> -		return NULL;
> -
> -	/* Does the input range span an existing VMA? (cases 5 - 8) */
> -	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> -
> -	if (!curr ||			/* cases 1 - 4 */
> -	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> -		next = vmg->next = vma_lookup(mm, end);
> -	else
> -		next = vmg->next = NULL;	/* case 5 */
> -
> -	if (prev) {
> -		vma_start = prev->vm_start;
> -		vma_pgoff = prev->vm_pgoff;
> -
> -		/* Can we merge the predecessor? */
> -		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
> -			merge_prev = true;
> -			vma_prev(vmg->vmi);
> -		}
> -	}
> -
> -	/* Can we merge the successor? */
> -	if (next && can_vma_merge_before(vmg)) {
> -		merge_next = true;
> -	}
> -
> -	/* Verify some invariant that must be enforced by the caller. */
> -	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> -	VM_WARN_ON(addr >= end);
> -
> -	if (!merge_prev && !merge_next)
> -		return NULL; /* Not mergeable. */
> -
> -	if (merge_prev)
> -		vma_start_write(prev);
> -
> -	res = vma = prev;
> -	remove = remove2 = adjust = NULL;
> -
> -	/* Can we merge both the predecessor and the successor? */
> -	if (merge_prev && merge_next &&
> -	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> -		vma_start_write(next);
> -		remove = next;				/* case 1 */
> -		vma_end = next->vm_end;
> -		err = dup_anon_vma(prev, next, &anon_dup);
> -		if (curr) {				/* case 6 */
> -			vma_start_write(curr);
> -			remove = curr;
> -			remove2 = next;
> -			/*
> -			 * Note that the dup_anon_vma below cannot overwrite err
> -			 * since the first caller would do nothing unless next
> -			 * has an anon_vma.
> -			 */
> -			if (!next->anon_vma)
> -				err = dup_anon_vma(prev, curr, &anon_dup);
> -		}
> -	} else if (merge_prev) {			/* case 2 */
> -		if (curr) {
> -			vma_start_write(curr);
> -			if (end == curr->vm_end) {	/* case 7 */
> -				/*
> -				 * can_vma_merge_after() assumed we would not be
> -				 * removing prev vma, so it skipped the check
> -				 * for vm_ops->close, but we are removing curr
> -				 */
> -				if (curr->vm_ops && curr->vm_ops->close)
> -					err = -EINVAL;
> -				remove = curr;
> -			} else {			/* case 5 */
> -				adjust = curr;
> -				adj_start = end - curr->vm_start;
> -			}
> -			if (!err)
> -				err = dup_anon_vma(prev, curr, &anon_dup);
> -		}
> -	} else { /* merge_next */
> -		vma_start_write(next);
> -		res = next;
> -		if (prev && addr < prev->vm_end) {	/* case 4 */
> -			vma_start_write(prev);
> -			vma_end = addr;
> -			adjust = next;
> -			adj_start = -(prev->vm_end - addr);
> -			err = dup_anon_vma(next, prev, &anon_dup);
> -		} else {
> -			/*
> -			 * Note that cases 3 and 8 are the ONLY ones where prev
> -			 * is permitted to be (but is not necessarily) NULL.
> -			 */
> -			vma = next;			/* case 3 */
> -			vma_start = addr;
> -			vma_end = next->vm_end;
> -			vma_pgoff = next->vm_pgoff - pglen;
> -			if (curr) {			/* case 8 */
> -				vma_pgoff = curr->vm_pgoff;
> -				vma_start_write(curr);
> -				remove = curr;
> -				err = dup_anon_vma(next, curr, &anon_dup);
> -			}
> -		}
> -	}
> -
> -	/* Error in anon_vma clone. */
> -	if (err)
> -		goto anon_vma_fail;
> -
> -	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
> -		vma_expanded = true;
> -
> -	if (vma_expanded) {
> -		vma_iter_config(vmg->vmi, vma_start, vma_end);
> -	} else {
> -		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> -				adjust->vm_end);
> -	}
> -
> -	if (vma_iter_prealloc(vmg->vmi, vma))
> -		goto prealloc_fail;
> -
> -	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> -	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
> -		   vp.anon_vma != adjust->anon_vma);
> -
> -	vma_prepare(&vp);
> -	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
> -	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
> -
> -	if (vma_expanded)
> -		vma_iter_store(vmg->vmi, vma);
> -
> -	if (adj_start) {
> -		adjust->vm_start += adj_start;
> -		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
> -		if (adj_start < 0) {
> -			WARN_ON(vma_expanded);
> -			vma_iter_store(vmg->vmi, next);
> -		}
> -	}
> -
> -	vma_complete(&vp, vmg->vmi, mm);
> -	khugepaged_enter_vma(res, vmg->flags);
> -	return res;
> -
> -prealloc_fail:
> -	if (anon_dup)
> -		unlink_anon_vmas(anon_dup);
> -
> -anon_vma_fail:
> -	vma_iter_set(vmg->vmi, addr);
> -	vma_iter_load(vmg->vmi);
> -	return NULL;
> -}
> -
> -struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> -{
> -	return vma_merge(vmg);
> -}
> -
>  /*
>   * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
>   * context and anonymous VMA name within the range [start, end).
> @@ -1280,7 +1270,7 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
>  	struct vm_area_struct *merged;
>  
>  	/* First, try to merge. */
> -	merged = vma_merge(vmg);
> +	merged = vma_merge_modified(vmg);
>  	if (merged)
>  		return merged;
>  
> diff --git a/mm/vma.h b/mm/vma.h
> index bbb173053f34..bf29ff569a3d 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -110,12 +110,6 @@ struct vm_area_struct
>  
>  struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg);
>  
> -/*
> - * Temporary wrapper around vma_merge() so we can have a common interface for
> - * tests.
> - */
> -struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg);
> -
>  struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  					struct vm_area_struct *vma,
>  					unsigned long delta);


