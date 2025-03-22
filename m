Return-Path: <linux-kernel+bounces-572426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A0CA6CA3A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA91A17F6B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63621D3C5;
	Sat, 22 Mar 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPSKBiKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB613BE5E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649257; cv=none; b=H3TdUh9ZahYF2MtcgsT5uB0txTzZhbRRos7j0zzVkeFqd8/J17v1REDZRjjjOJ2adn6O1LL/8w5C4Le5tImLYjIsgkO/z8sdZ62kSMF1n+Si86fPa8wpRQcUfFpfY+zjtaDkpLICKmAhRKkuRStWX+ubEmTn/ThtmRTsd/fd3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649257; c=relaxed/simple;
	bh=+A6W4L8qnk06KFMX4eOcxk4TkajtUMzHqqpxvjcEB98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGkl9ci/n0xX07Ei0PKAuG1EhElLGNgaTPA6XEcq+c5pJAnwvJwwRvmX6qz/PArGiumknb/D7Ua2xZBGFrTRchw4pvoUMYa0SQJfDQEyiP2TqigzrCt3OP/RntONS3V2d/6rbfFl+AD9/+4nEI+U7IOsFFiYkXjVpie7ObOfOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPSKBiKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83928C4CEDD;
	Sat, 22 Mar 2025 13:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742649255;
	bh=+A6W4L8qnk06KFMX4eOcxk4TkajtUMzHqqpxvjcEB98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPSKBiKhO/ofNz7l55CAFpS3R/5HNOli3PUurgN03+3MaU5/gfewtEyUpptQ4Ybao
	 GtVVp+7QYujpxHDM22FNerAjf6aNilqugsPvwpG2LeVvhYactv175bu6Wp9DhnJAnF
	 uWRDqNJVVXeTW7J9bGwuZQXANsycfl+5x9lghAex447uAksF+TCZ1xgE9lM/V7KGO7
	 isQjEWKdJk3N/8qRuu9dmzWi+7x8xS53e+i9MPBF8FcKoWH25GoVjg3gHr9txndBHH
	 l/VxS4xGbp0hGh2Im+nhZPm7u56ECZLjX2Zw5fNIvrL0RVSyAaewPFc4mata+o0jD3
	 0vazA+ALbceDw==
Date: Sat, 22 Mar 2025 09:14:12 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as userfaultfd reviewer
Message-ID: <Z963pPq50wpt6a6S@kernel.org>
References: <20250322002124.131736-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322002124.131736-1-peterx@redhat.com>

Hi Peter,

On Fri, Mar 21, 2025 at 08:21:24PM -0400, Peter Xu wrote:
> Add an entry for userfaultfd and make myself a reviewer of it, just in case
> it helps people manage the cc list.
> 
> I named it MEMORY USERFAULTFD, could be a bad name, but then it can be
> together with the MEMORY* entries when everything is in alphabetic order,
> which is definitely a benefit.
> 
> The line may not change much on how I'd work with userfaultfd; I think I'll
> do the same as before..  But maybe it still, more or less, adds some
> responsibility on top, indeed.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e714ea3a7c9f..844e3e1e05d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15220,6 +15220,17 @@ F:	mm/vma.h
>  F:	mm/vma_internal.h
>  F:	tools/testing/vma/
>  
> +MEMORY USERFAULTFD
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	Peter Xu <peterx@redhat.com>
> +S:	Maintained
> +F:	mm/userfaultfd.c
> +F:	fs/userfaultfd.c
> +F:	include/uapi/linux/userfaultfd.h

There's also
F: include/linux/userfaultfd_k.h

> +F:	include/asm-generic/pgtable_uffd.h
> +F:	Documentation/admin-guide/mm/userfaultfd.rst
> +F:	tools/testing/selftests/mm/uffd-*.[ch]
> +
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>
> -- 
> 2.48.1
> 

-- 
Sincerely yours,
Mike.

