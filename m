Return-Path: <linux-kernel+bounces-194379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9928D3B43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28711F28658
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077A7181CEA;
	Wed, 29 May 2024 15:43:13 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC211B947
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997392; cv=none; b=C2jlP3yQnr0/a4SxBGm5meJ+Kz3otZY66ofrnxFibQYXZ03kphzx7ZhCnSWwEFtwdfcnVLv7ydMIoe+uggQJcRa65NaTvl1rvlmGRpMGerFilM/A2tzfOUiXiQAfDkYE5ys7loW8BJTQKqRK+rqOwssfvhsx5gWyPlBzxjFRJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997392; c=relaxed/simple;
	bh=gJ64NPAH8gOQD4B7kGLZJDpKEjS1FPsyFxnDrdzTq2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lInrIGu4klfqfdFzI03mLFvuvT89J9XtRF4CxjkabhZYGLHmKgIloQNFDx3SnKIbNgJrG8e2lSqqpw1ZR+BnCMKNyg+9IB3kP1ZQuWlujfKycCYvzuHok0FDKZSopbiXE7HkNzYiFIdUX1ExpgXMppK4A3JN9+5LTsPkjOvkZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e9819a6327so26472971fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997389; x=1717602189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5A6Owu5nCCfigxsQSQjSW3E/HUi1TirfJVySwzCRU4=;
        b=xDqbMeFqNHfvRD3pc9XCyNpKtX6VpZzrLlioMfmRxj91j3GTGbMI6ssD21qPkAkHU9
         wJUht9BtDgrtdvr/WT4dg916lfCEcLtKvsij7RZT/Y+RKlKlwI7hKLfMivxBMLok6ndZ
         a2Ne1kUkoYcgS9b4FULu/90B9He4PhhodiMpR9db8FLhVwLAx/WWjho/90L5bcz3BTTd
         ipJUdq3h6JwrdXBt8dd1o+X5A10UM+F5xKUNg5a8q5D60ia9hggTm1FQtOY+G0BunGUS
         lXDIu9XcnDEfKQPzBlMT6ZKY/cEbNX7/htbweFUijwvhTHYwm3gKxSr7y35jyQwigGpF
         +Dug==
X-Forwarded-Encrypted: i=1; AJvYcCXTvcJ0k0LBKfbLg7Jy9y4YWkHsOB3IlAJx+cWnvrgv+rib1V29hOHyGicKB/noyvvtBhNop4K/f8FX9D9VYdwpjAevAeUL9+CiiqOW
X-Gm-Message-State: AOJu0YzYfGOtM7dRBZKerbZqFAaYxOA7CrXjrjjh8gJYMGH3qneokyzz
	FDhmRLREw5UWpNxFhNWCufg+DBeg9non7kfECHLuebrkZKk5BWZE
X-Google-Smtp-Source: AGHT+IFyQNUSc9Pi+sOtG/54fkZ1MbMpE5ltiGitvLIjUHxiXGG6Ep8TRL/MCRlTOKXzb/lGn7EdBw==
X-Received: by 2002:a2e:2c12:0:b0:2ea:7e50:6c94 with SMTP id 38308e7fff4ca-2ea7e506d11mr11694151fa.16.1716997388651;
        Wed, 29 May 2024 08:43:08 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579cf481a7fsm4776859a12.52.2024.05.29.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:43:08 -0700 (PDT)
Date: Wed, 29 May 2024 08:43:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/hugetlb: Do not call vma_add_reservation upon ENOMEM
Message-ID: <ZldNCutdbyroqoNv@gmail.com>
References: <20240528205323.20439-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528205323.20439-1-osalvador@suse.de>

On Tue, May 28, 2024 at 10:53:23PM +0200, Oscar Salvador wrote:
> sysbot reported a splat [1] on __unmap_hugepage_range().
> This is because vma_needs_reservation() can return -ENOMEM if
> allocate_file_region_entries() fails to allocate the file_region struct for
> the reservation.
> Check for that and do not call vma_add_reservation() if that is the case,
> otherwise region_abort() and region_del() will see that we do not have any
> file_regions.
> 
> If we detect that vma_needs_reservation() returned -ENOMEM, we clear the
> hugetlb_restore_reserve flag as if this reservation was still consumed,
> so free_huge_folio() will not increment the resv count.
> 
> [1] https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/T/#ma5983bc1ab18a54910da83416b3f89f3c7ee43aa
> 
> Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
> Reported-and-tested-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/hugetlb.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6be78e7d4f6e..f35abff8be60 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5768,8 +5768,20 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		 * do_exit() will not see it, and will keep the reservation
>  		 * forever.
>  		 */
> -		if (adjust_reservation && vma_needs_reservation(h, vma, address))
> -			vma_add_reservation(h, vma, address);
> +		if (adjust_reservation) {
> +			int rc = vma_needs_reservation(h, vma, address);

vma_needs_reservation returns a long.

	static long vma_needs_reservation(struct hstate *h,
				struct vm_area_struct *vma, unsigned long addr)
				
Other than that, this is reviewed.

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for fixing it.

