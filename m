Return-Path: <linux-kernel+bounces-202020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BD8FC6B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF081B2AFB8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16941946C2;
	Wed,  5 Jun 2024 08:38:19 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0741946A7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576699; cv=none; b=nsmY2UYBJ/OmmQyiW1uUCt+p9vHztlFEeww0NU5cryVl+rGrW9TIQmUFuU2f5Y5M0gljdY9Coo9eTeNvotEzRj9pdro3LqmUBbT1ivh52Jj6jg7ssYTV8OyGbRfni8L6gMWXH9G4lsF7gFzGKqv/4Zwwn3sTp2C1msf+T90XDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576699; c=relaxed/simple;
	bh=bGC3C+2xwWd6OYkZRJW0Xp+S0CBDQum5pqSO3u6vVCw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=MlDHBJ85A4aI7YXh6Rc9aad7ZjigDZzN/6JeSj0IKdNK86vOHa917CCmZB2IcrbkmxarLTCtneHrXH0FZOWbs6dW1ZnTA/M8iFYasHmWI5eiSQJMs5jT+Cl6QqyTyXuAfoqhbAGqr6+HUe6W48vl2nviOI/fphfHcmP8OGrIJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VvLSx4NJFz6G3wn;
	Wed,  5 Jun 2024 16:38:09 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 4558bS2q014156;
	Wed, 5 Jun 2024 16:37:28 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 5 Jun 2024 16:37:31 +0800 (CST)
Date: Wed, 5 Jun 2024 16:37:31 +0800 (CST)
X-Zmail-TransId: 2af9666023cb0a5-00b6d
X-Mailer: Zmail v1.0
Message-ID: <20240605163731027tu4GJzm7fzc00snHCyF_3@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <willy@infradead.org>, <ziy@nvidia.com>, <akpm@linux-foundation.org>
Cc: <ran.xiaokai@zte.com.cn>, <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <mhocko@kernel.org>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?4oCLIFtQQVRDSCBsaW51eC1uZXh0XSBtbTogaHVnZV9tZW1vcnk6IHJlbW92ZSBpc190cmFuc3BhcmVudF9odWdlcGFnZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 4558bS2q014156
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 666023F1.000/4VvLSx4NJFz6G3wn

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

is_transparent_hugepage() was first introduced to ensure the page is
2M THP page. After commit de53c05f2ae3 ("mm: add large_rmappable
page flag") and commit fc4d182316bd ("mm: huge_memory: enable debugfs
to split huge pages to any order"), any large folio of mTHP suitable order
can be split, not only 2M THP page.
so the check in split_huge_pages_pid() is not needed here, instead
a folio_test_large() check is sufficient. To ensure a 2M THP folio,
we should use "folio_order(folio) == HPAGE_PMD_ORDER" for now.

As split_huge_pages_pid() is the only user of is_transparent_hugepage(),
we can remove this helper.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 mm/huge_memory.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 317de2afd371..f1a992945007 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -839,15 +839,6 @@ struct deferred_split *get_deferred_split_queue(struct folio *folio)
 }
 #endif

-static inline bool is_transparent_hugepage(const struct folio *folio)
-{
-	if (!folio_test_large(folio))
-		return false;
-
-	return is_huge_zero_folio(folio) ||
-		folio_test_large_rmappable(folio);
-}
-
 static unsigned long __thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len,
 		loff_t off, unsigned long flags, unsigned long size,
@@ -3439,7 +3430,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 			continue;

 		folio = page_folio(page);
-		if (!is_transparent_hugepage(folio))
+		if (!folio_test_large(folio))
 			goto next;

 		if (new_order >= folio_order(folio))
-- 
2.15.2

