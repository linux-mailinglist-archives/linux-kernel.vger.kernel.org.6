Return-Path: <linux-kernel+bounces-204033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CE58FE3BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7C0B2460C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AD152783;
	Thu,  6 Jun 2024 09:42:17 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E51514EE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666936; cv=none; b=Hgtp959+KDa3BBRFp0bs5ckVh88ENI6iq1LBKWJdvX/yDBvAgIY+CYpb5rX5jJfdcRWOo7fkC0bRAVKlBr7Vnte53Rik9Anh10aHHwE9SAyQwcSgLwa3LBqif8qrQLWoh64W9Yv+8UCwGr8v6Tdta0NHLvfJ0OZ5PWUcw37ka2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666936; c=relaxed/simple;
	bh=rAgI9GGJJTeCZyVaG2TflywO4JVeIlVSaK6x8F0N7Wc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=TK9tic4460eWYsakIOd9DjVJ2g1pSgPXMGYpBG9XAEe5apOZ6ACizEHtjmDvP4lBrLvzWpBkyNg2UfLU8B6Z6bTNekU6mRfZLaUO/5R1CoFcK1P7tSeLQK3gmfJ9fnM0Lvpw+NWOZzIkriLd94njB7A/tAJKBUtw3XIM5g6nf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VvzrG4pqkz4xPBc;
	Thu,  6 Jun 2024 17:42:06 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
	by mse-fl1.zte.com.cn with SMTP id 4569g0MO058198;
	Thu, 6 Jun 2024 17:42:00 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 6 Jun 2024 17:42:03 +0800 (CST)
Date: Thu, 6 Jun 2024 17:42:03 +0800 (CST)
X-Zmail-TransId: 2afa6661846bffffffff819-af71f
X-Mailer: Zmail v1.0
Message-ID: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <david@redhat.com>, <ziy@nvidia.com>, <v-songbaohua@oppo.com>,
        <akpm@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mhocko@kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <ran.xiaokai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIG1tOiBodWdlX21lbW9yeTogZml4IG1pc3VzZWQgbWFwcGluZ19sYXJnZV9mb2xpb19zdXBwb3J0KCnCoGZvciBhbm9uIGZvbGlvcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4569g0MO058198
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6661846E.000/4VvzrG4pqkz4xPBc

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

When I did a large folios split test, a WARNING
"[ 5059.122759][  T166] Cannot split file folio to non-0 order"
was triggered. But the test cases are only for anonmous folios.
while mapping_large_folio_support() is only reasonable for page
cache folios.

In split_huge_page_to_list_to_order(), the folio passed to
mapping_large_folio_support() maybe anonmous folio. The
folio_test_anon() check is missing. So the split of the anonmous THP
is failed. This is also the same for shmem_mapping(). We'd better add
a check for both. But the shmem_mapping() in __split_huge_page() is
not involved, as for anonmous folios, the end parameter is set to -1, so
(head[i].index >= end) is always false. shmem_mapping() is not called.

Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
for anon mapping, So we can detect the wrong use more easily.

THP folios maybe exist in the pagecache even the file system doesn't
support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
is enabled, khugepaged will try to collapse read-only file-backed pages
to THP. But the mapping does not actually support multi order
large folios properly.

Using /sys/kernel/debug/split_huge_pages to verify this, with this
patch, large anon THP is successfully split and the warning is ceased.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 include/linux/pagemap.h |  4 ++++
 mm/huge_memory.c        | 27 ++++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ee633712bba0..59f1df0cde5a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
  */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
+	/* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache folios */
+	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
+			"Anonymous mapping always supports large folio");
+
 	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 317de2afd371..62d57270b08e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;

-	/* Cannot split anonymous THP to order-1 */
-	if (new_order == 1 && folio_test_anon(folio)) {
-		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
-		return -EINVAL;
-	}
-
-	if (new_order) {
-		/* Only swapping a whole PMD-mapped folio is supported */
-		if (folio_test_swapcache(folio))
+	if (folio_test_anon(folio)) {
+		/* Cannot split anonymous THP to order-1 */
+		if (new_order == 1) {
+			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
 			return -EINVAL;
+		}
+	} else if (new_order) {
 		/* Split shmem folio to non-zero order not supported */
 		if (shmem_mapping(folio->mapping)) {
 			VM_WARN_ONCE(1,
 				"Cannot split shmem folio to non-0 order");
 			return -EINVAL;
 		}
-		/* No split if the file system does not support large folio */
-		if (!mapping_large_folio_support(folio->mapping)) {
+		/* No split if the file system does not support large folio.
+		 * Note that we might still have THPs in such mappings due to
+		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+		 * does not actually support large folios properly.
+		 */
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+			!mapping_large_folio_support(folio->mapping)) {
 			VM_WARN_ONCE(1,
 				"Cannot split file folio to non-0 order");
 			return -EINVAL;
 		}
 	}

+	/* Only swapping a whole PMD-mapped folio is supported */
+	if (folio_test_swapcache(folio) && new_order)
+		return -EINVAL;

 	is_hzp = is_huge_zero_folio(folio);
 	if (is_hzp) {
-- 
2.15.2

