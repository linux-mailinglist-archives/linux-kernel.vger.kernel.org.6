Return-Path: <linux-kernel+bounces-379926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96E9AE5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6381C214D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E401D8A12;
	Thu, 24 Oct 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS90Y9zu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090F1D63DB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775931; cv=none; b=o7wkuwuu0rRmSPK2Gxt+5Thp7talRK87CF5lQFoQqyykBwpwHVL1mRmWoPtAExrnZrf9Si+2a7GcmrfJYwH7zmJeAiNDXvi1gynhQwNWS2wxXcbAHWtXqzndLt339STar+LhKu/NCvJ8iglYoXt3cHn3619UVriacDEETN9iRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775931; c=relaxed/simple;
	bh=tyI7JDkp0t33YbBcSFvFoSSEBcFZuHm9pqI3LNWIbmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru9BAuYwKqKCf/yvonWgGSU/YuwgcLQI/Tf/VPGvMR6+uqRCVL478BCcZEUgkjbckUODpZNbzCq1JIygiV8/LOXuVHycD5TW5N5VEXHWwIWkultuVr+t7SKLKb5pfDA6JHTfRzXWx2n7WCYfLu6T4RURhFNp4Ucqg5Pzak+h6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS90Y9zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21B2C4CECC;
	Thu, 24 Oct 2024 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729775930;
	bh=tyI7JDkp0t33YbBcSFvFoSSEBcFZuHm9pqI3LNWIbmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QS90Y9zusgjWlncMcUS0Hbjl3NF3iem9EQ//727OBCCjvQDez0N0wvZ+uJbyDSkNE
	 znswK6t/2WOAE99SVSXVgqhTjF9LvcsMadEB6PuS3kpZ4R+jQiuKrP4PqyfasG/Hsa
	 9jjQZ6etYJ8fVt2RbYzBYWoBjK5ygLm34iBXHg9IR8zSEXtnXGFcxRn2kz7T6/0NLR
	 ohxVEAd70vCT8nKCZERaWIwPhOLdBSsuk97wfmisdMoPaOoStt/20iEaQPkW7V8T8Q
	 DvryfvWHJlDt2tXSqhLZkD6QlowlJeUkjmvEXRkx96RP7cNq45aB1UQOPKSqbmKxHP
	 UhJCMKzyq9wtA==
Date: Thu, 24 Oct 2024 14:18:45 +0100
From: Will Deacon <will@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jordan Niethe <jniethe@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kaslr: rename physmem_end and PHYSMEM_END to
 direct_map_physmem_end
Message-ID: <20241024131844.GI30704@willie-the-truck>
References: <20241009025024.89813-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009025024.89813-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 08, 2024 at 07:50:24PM -0700, John Hubbard wrote:
> For clarity. It's increasingly hard to reason about the code, when KASLR
> is moving around the boundaries. In this case where KASLR is randomizing
> the location of the kernel image within physical memory, the maximum
> number of address bits for physical memory has not changed.
> 
> What has changed is the ending address of memory that is allowed to be
> directly mapped by the kernel.
> 
> Let's name the variable, and the associated macro accordingly.
> 
> Also, enhance the comment above the direct_map_physmem_end definition,
> to further clarify how this all works.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Jordan Niethe <jniethe@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> David Hildenbrand, I recall you had an unanswered question in this
> vicinity [1] when tglx's recent kaslr fix was being reviewed. Maybe this
> will help with that.
> 
> 
> [1] https://lore.kernel.org/linux-mm/ee205448-5fdd-495e-9d7c-c8a2b59f9c9e@roeck-us.net/T/#mdf442f077c9023590e144dbed2b04a109793484d
> 
> thanks,
> John Hubbard
> 
> 
>  arch/arm64/include/asm/memory.h         |  2 +-
>  arch/x86/include/asm/page_64.h          |  2 +-
>  arch/x86/include/asm/pgtable_64_types.h |  2 +-
>  arch/x86/mm/init_64.c                   |  2 +-
>  arch/x86/mm/kaslr.c                     | 14 +++++++++-----
>  include/linux/mm.h                      |  6 +++---
>  kernel/resource.c                       |  4 ++--
>  mm/memory_hotplug.c                     |  2 +-
>  mm/sparse.c                             |  2 +-
>  9 files changed, 20 insertions(+), 16 deletions(-)

For arm64:

Acked-by: Will Deacon <will@kernel.org>

Will

