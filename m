Return-Path: <linux-kernel+bounces-436155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E49E81DD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A155E165DB7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0991415382E;
	Sat,  7 Dec 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I91hPp31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6668829422
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733601224; cv=none; b=nyBV8g/ZillZwv7+KCIbNuW+w7jrrrOetaBPCd1T6aDMK0Gjgw+FpTDPeMRtL9kOGhYC2fh32yITY1SJ6pla7PN7eqnmcViMCg1Sr3WFWp43HMFhlMtmvUG7QH8wj1R9AF2Lxszyl77kXdzPYTng37Cn7P5/mri82umCHNIC2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733601224; c=relaxed/simple;
	bh=uiWNwCAU1Ek1lr+t0M6XPgbDqA5vrC17dsi7zbgeCVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePIbyhF2SJm+NeICuX8yrVadss7f3B8XVvJRrMke20KSDhOrTSS3rnx12US3qYduujJiXoPjP/gkfYEqzaEM4brXMOAcM1RpYK1K5/Kl2s/553G/R1+ql7Uejwd00EbeTXScOMwh9ROArOOVWj12WFI4/yORF9/zXIZMkeuBxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I91hPp31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE75FC4CECD;
	Sat,  7 Dec 2024 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733601224;
	bh=uiWNwCAU1Ek1lr+t0M6XPgbDqA5vrC17dsi7zbgeCVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I91hPp314DXk4zsq/ROKlM6JiklpZEhUm0Gpyo5mFtGkUtzoJboF1tHB9R4rfE2Sm
	 ekN8GZDYYJe9f4gHgAlSvuGigs1fvtRaNhFHkjczej6dEtZd7pIQH9qEXN9xCwXWDD
	 /SgUpOl36jNm9+9MibQsDTcjCmLZR5nMXCCJdOB2XJVPU3oRA2QoX/rpVjCKtVrwW3
	 d2voHVERtJdMBc2phucZahlvQyyl0LiPN3sV7MDxhlBpnwixVoaneoNpHJhGY2z4MZ
	 3CQhjD8Qt+CrRrbjGcL51bdqqB4xrHToEDBYAB0e3b7dNEOg4ybTOfWvRgGDw7zUm/
	 9z2yIJnajpvdw==
From: SeongJae Park <sj@kernel.org>
To: Junjie Fu <fujunjie1@qq.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	mhocko@suse.com,
	gourry@gourry.net
Subject: Re: [PATCH] mempolicy.h: Remove unnecessary header file inclusions
Date: Sat,  7 Dec 2024 11:53:41 -0800
Message-Id: <20241207195341.279560-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <tencent_08B979048FE091821B290B18AE97E70DC507@qq.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junie,


On Fri, 6 Dec 2024 23:53:49 +0800 Junjie Fu <fujunjie1@qq.com> wrote:

> Originally, linux/mempolicy.h included linux/pagemap.h because vma_migratable()
> was implemented inline within the header, requiring mapping_gfp_mask()
> function to implement vma_migratable(). Now that vma_migratable() is only
> declared in linux/mempolicy.h and its implementation has been moved to mempolicy.c,
> the inclusion of linux/pagemap.h in the header is no longer necessary.
> 
> Additionally, since mempolicy.c includes internal.h, and internal.h already
> includes linux/pagemap.h, so there is no need to modify mempolicy.c after
> removing the direct inclusion of linux/pagemap.h from linux/mempolicy.h
> 
> Signed-off-by: Junjie Fu <fujunjie1@qq.com>
> ---
>  include/linux/mempolicy.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index ce9885e0178a..d36877557b00 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -12,7 +12,6 @@
>  #include <linux/rbtree.h>
>  #include <linux/spinlock.h>
>  #include <linux/nodemask.h>
> -#include <linux/pagemap.h>
>  #include <uapi/linux/mempolicy.h>

I noticed kunit UM build errors as below on mm-unstable, and git bisect points
this patch.

    $ ./tools/testing/kunit/kunit.py run --kunitconfig ./mm/damon/tests/
    [...]
    fs/aio.c:525:71: error: ‘FGP_CREAT’ undeclared (first use in this function); did you mean ‘IPC_CREAT’?
      525 |                                             FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
          |                                                                       ^~~~~~~~~
          |                                                                       IPC_CREAT
    fs/aio.c:532:17: error: implicit declaration of function ‘folio_end_read’; did you mean ‘folio_test_head’? [-Werror=implicit-function-declaration]
      532 |                 folio_end_read(folio, true);
          |                 ^~~~~~~~~~~~~~
          |                 folio_test_head
    [...]

I also confirmed including pagemap.h on fs/aio.c as below fixes the issue.  I
would like to hear you or others opinions though, since I'm not familiar with
the inclusion routes of the file.

diff --git a/fs/aio.c b/fs/aio.c
index 50671640b588..9fad51dc823f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -39,6 +39,7 @@
 #include <linux/compat.h>
 #include <linux/migrate.h>
 #include <linux/ramfs.h>
+#include <linux/pagemap.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>


Thanks,
SJ

[...]

