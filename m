Return-Path: <linux-kernel+bounces-279502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE5194BE1B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251141C233F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205A18CBEB;
	Thu,  8 Aug 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="mc7sMSVF"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159618A6B3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122139; cv=none; b=JV706o3pTKwrOMcsz4A6Lo5D+e4xrpj0sXiAvfw4lW5RxPgYc1Jp7WswdWi5ov1yK0GJKa9WOw2Oz9umsLug2UCt5lJriWFsVGO/QlRhvZovk5XR4fwqGi4Ey9X+1qgDkSMdVcdoAyulHXto8oKYVcCctAoJk+Dt5YkehXmnko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122139; c=relaxed/simple;
	bh=YyNYaGB7F+JZL0OnteVYOnqrrCQP8G1j+wMx7WVB1Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmy4Qg9duUQfZ1awLrlim1ZRet61aVAvPjiLURfC0Vgxeh9K7G4TfgOwWEov48Vz6mQwmgYA+6Tt5NAI4JiuCSeDWUbWWjFPAH9oWA/K2wmbPaFfmWMnry+v8LHaszBCI//v9JhU5kJK1Z7auPeS5tonP3vaNMjFCYNPGvrxc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=mc7sMSVF; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 482B71D50D2;
	Thu,  8 Aug 2024 15:02:13 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723122133; bh=9agqcgIrEcjdsnB4WkhjH9Unn9uvw/LkiVI9zz6kfwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mc7sMSVFJgURjephKnSot+ne0P5gWrRrDiizOJIZJMzKjqWcn+0gyR8fG7c+UT9wD
	 ClXw0EPlFPK1ivjwxegpsVtyAhP2QTtgxTk1R7TAeSlLlkbZAXaE81BQ5szfcqxOjT
	 JFkxIGLTzO/fo1/GUjJJhx7xvK8SGsl+mr8tS4QIGp/qQsiJvJOi3KFrXS/ZVYQ0rK
	 Srox0onovnstS+7hZVa0b1fgWuHnpi382pamVz6bPj9ViqqW0A+l7i0APVJG2wK0xX
	 13a53ASrOe93iNIiycQf2S0yMHXF/Tf0GiO/Q0jPgIxeCuSGsPohhKeIZYrVDg3KSb
	 OU6z6+7MhA6aw==
Date: Thu, 8 Aug 2024 15:02:08 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 05/10] mm: abstract vma_merge_new_vma() to use
 vma_merge_struct
Message-ID: <20240808150208.372bed7d@mordecai.tesarici.cz>
In-Reply-To: <f4f4b5d441379b22f92d7cd188c2095198cdbc86.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<f4f4b5d441379b22f92d7cd188c2095198cdbc86.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 13:13:52 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Abstract this function to so we can write tests which use the newly
> abstracted interface and maintain a stable interface for tests before/after
> refactoring.
> 
> We introduce a temporary wrapper vma_merge_new_vma_wrapper() to minimise
> the code changes, in a subsequent commit we will entirely refactor this
> function.
> 
> We also introduce a temporary implementation of vma_merge_modified() for
> the same reason - maintaining a common interface to the tests, this will be
> removed when vma_merge_modified() is correctly implemented in a subsequent
> commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c               |  6 +++---
>  mm/vma.c                | 33 ++++++++++++---------------------
>  mm/vma.h                | 33 ++++++++++++++++++++++++++++++---
>  tools/testing/vma/vma.c | 12 ++++++++----
>  4 files changed, 53 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 04145347c245..f6593a81f73d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1494,9 +1494,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 * vma again as we may succeed this time.
>  		 */
>  		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> -			merge = vma_merge_new_vma(&vmi, prev, vma,
> -						  vma->vm_start, vma->vm_end,
> -						  vma->vm_pgoff);
> +			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
> +							  vma->vm_start, vma->vm_end,
> +							  vma->vm_pgoff);
>  			if (merge) {
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput
> diff --git a/mm/vma.c b/mm/vma.c
> index 3d6ce04f1b9c..55615392e8d2 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1106,6 +1106,11 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  	return NULL;
>  }
> 
> +struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> +{
> +	return vma_merge(vmg);
> +}
> +
>  /*
>   * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
>   * context and anonymous VMA name within the range [start, end).
> @@ -1260,27 +1265,14 @@ struct vm_area_struct
>   * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
>   * must ensure that [start, end) does not overlap any existing VMA.
>   */
> -struct vm_area_struct
> -*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -		   struct vm_area_struct *vma, unsigned long start,
> -		   unsigned long end, pgoff_t pgoff)
> +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
>  {
> -	struct vma_merge_struct vmg = {
> -		.vmi = vmi,
> -		.prev = prev,
> -		.vma = vma,
> -		.start = start,
> -		.end = end,
> -		.flags = vma->vm_flags,
> -		.file = vma->vm_file,
> -		.anon_vma = vma->anon_vma,
> -		.pgoff = pgoff,
> -		.policy = vma_policy(vma),
> -		.uffd_ctx = vma->vm_userfaultfd_ctx,
> -		.anon_name = anon_vma_name(vma),
> -	};
> +	if (!vmg->prev) {
> +		vmg->prev = vma_prev(vmg->vmi);
> +		vma_iter_set(vmg->vmi, vmg->start);
> +	}
> 
> -	return vma_merge(&vmg);
> +	return vma_merge(vmg);
>  }
> 
>  /*
> @@ -1295,7 +1287,6 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  	struct vma_merge_struct vmg = {
>  		.vmi = vmi,
>  		.prev = vma,
> -		.vma = vma,

Yes, this member is not used later by vma_merge(), so it need not be
initialized. What about not adding this line in PATCH 02/10 of this
series? AFAICS vmg->vma was never used by vma_merge(). The net result
is the same, but it would make it easier to understand that this patch
in the series does not change the use of vmg->vma by vma_merge_extend().

Petr T

