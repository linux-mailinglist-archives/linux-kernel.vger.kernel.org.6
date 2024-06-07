Return-Path: <linux-kernel+bounces-205748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C98FFFC0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F758287523
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4322C15CD79;
	Fri,  7 Jun 2024 09:41:10 +0000 (UTC)
Received: from mxde.zte.com.cn (mxde.zte.com.cn [209.9.37.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44FB15CD5C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.9.37.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753269; cv=none; b=qIk7Wsa+JeduYPm6Fj8BuCbTJ1gByxAKTO/6/p3kLFBhAY+qhs4gSNVwtDyktfUpAX2UpDrjRDsr0NRh1WmihReT3aDWzsnm4144IIoJhAi2iCwngjGSqas3S8NXeOEEF0ZBgEA6/+F6EFLP9CzRtIZeh147I7OXkkQHXcw5ArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753269; c=relaxed/simple;
	bh=x9fp+gWVJGtIzJ6GcT0SwqoJs5luw78VAYq6ovnD3x4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=u8BMOiDrRaTZUMDYYCiYiffp2CCEkdppnq6iA7guQlu53ijTCwTpfFwsf7Y4n8Yf56W/pS03FSkkpuERy3dwRutbWXJ9ZHlrWA+l97m0gWOWl2o1wuYvXDyhrGlwzDwoj0RyqxuHcHpt6bCnklLpUg0zK7nwRur63RaeqYyCkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=209.9.37.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4VwbmW6Wx7z5TCGC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:40:59 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VwbmJ0Sy0z8XrS1;
	Fri,  7 Jun 2024 17:40:48 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 4579ejtn002111;
	Fri, 7 Jun 2024 17:40:45 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 7 Jun 2024 17:40:48 +0800 (CST)
Date: Fri, 7 Jun 2024 17:40:48 +0800 (CST)
X-Zmail-TransId: 2afa6662d5a0ffffffffa1b-000d9
X-Mailer: Zmail v1.0
Message-ID: <202406071740485174hcFl7jRxncsHDtI-Pz-o@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjNdIG1tOiBodWdlX21lbW9yeTogZml4IG1pc3VzZWQgbWFwcGluZ19sYXJnZV9mb2xpb19zdXBwb3J0KCnCoCBmb3IgYW5vbiBmb2xpb3M=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4579ejtn002111
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6662D5AA.000/4VwbmW6Wx7z5TCGC

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

Changes since v2:
 - fix two coding style problems suggested by David
 - update the comments of the order-1 case suggested by Barry

Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 include/linux/pagemap.h |  4 ++++
 mm/huge_memory.c        | 28 +++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

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
index 317de2afd371..155d6a9f73be 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3009,30 +3009,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
+		/* order-1 is not supported for anonymous THP. */
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
+		/*
+		 * No split if the file system does not support large folio.
+		 * Note that we might still have THPs in such mappings due to
+		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+		 * does not actually support large folios properly.
+		 */
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		    !mapping_large_folio_support(folio->mapping)) {
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

