Return-Path: <linux-kernel+bounces-200075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494318FAA43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95E0B2461F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A213DDA3;
	Tue,  4 Jun 2024 05:53:28 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C899199BC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480408; cv=none; b=h76D13KE+YGWV+F7ZnKtHyMzUSjgtIpMf/zk9SV+Ch1zU4HSVCkatyv78NH8z0bTk2th2iHk1Q97sj/6Ht2axzAk0qI0KY5ReLVtqkUbud5ZIZpvYgcIVHD4DIeircou54Ds6cIWFOOBmo+/SeNsZH7LDk0yUEKg+v6m3gD31EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480408; c=relaxed/simple;
	bh=IoB/yV/6K+QghVV3rsD9UF32nbZm90OaPHf1zCxHcuM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=pj0+scUvNJ2xJhe8t3BS3HeJRdPFtFOVXVh8IHSRM5MiQAOEMBFpuRrgfc+MwzBZxGKurUeA/p414b/WQimnUE8jLlzUxjlRU//elH7oLU6vhGlJW7FCfpF9TPilk36q8PsFUDf5Y+NvCBzcbK7kL0tw70LV3irOTJPbbFgi0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Vtfl34DhpzKhm
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:47:59 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4Vtfkw4tx9z5TCG9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:47:52 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Vtfkl3JFsz5R9kD;
	Tue,  4 Jun 2024 13:47:43 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 4545laZs009782;
	Tue, 4 Jun 2024 13:47:36 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 4 Jun 2024 13:47:38 +0800 (CST)
Date: Tue, 4 Jun 2024 13:47:38 +0800 (CST)
X-Zmail-TransId: 2af9665eaa7a03e-7c67f
X-Mailer: Zmail v1.0
Message-ID: <20240604134738264WKaKYb3q_YTE32hNAy2lz@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <ziy@nvidia.com>
Cc: <v-songbaohua@oppo.com>, <mhocko@kernel.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1tOiBodWdlX21lbW9yeTogZml4IG1pc3VzZWQgbWFwcGluZ19sYXJnZV9mb2xpb19zdXBwb3J0KCnCoGZvciBhbm9uIGZvbGlvcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 4545laZs009782
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 665EAA8E.000/4Vtfl34DhpzKhm

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

When I did a large folios split test, a WARNING
"[ 5059.122759][  T166] Cannot split file folio to non-0 order"
was triggered. But my test cases are only for anonmous folios. 
while mapping_large_folio_support() is only reasonable for page
cache folios. 

In split_huge_page_to_list_to_order(), the folio passed to
mapping_large_folio_support() maybe anonmous folio. The
folio_test_anon() check is missing. So the split of the anonmous THP
is failed. This is also the same for shmem_mapping(). We'd better add
a check for both. But the shmem_mapping() in __split_huge_page() is
not involved, as for anonmous folios, the end parameter is set to -1, so
(head[i].index >= end) is always false. shmem_mapping() is not called.

Using /sys/kernel/debug/split_huge_pages to verify this, with this
patch, large anon THP is successfully split and the warning is ceased.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/huge_memory.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 317de2afd371..4c9c7e5ea20c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;

-	/* Cannot split anonymous THP to order-1 */
-	if (new_order == 1 && folio_test_anon(folio)) {
-		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
-		return -EINVAL;
-	}
-
 	if (new_order) {
 		/* Only swapping a whole PMD-mapped folio is supported */
 		if (folio_test_swapcache(folio))
 			return -EINVAL;
-		/* Split shmem folio to non-zero order not supported */
-		if (shmem_mapping(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split shmem folio to non-0 order");
-			return -EINVAL;
-		}
-		/* No split if the file system does not support large folio */
-		if (!mapping_large_folio_support(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split file folio to non-0 order");
-			return -EINVAL;
+
+		if (folio_test_anon(folio)) {
+			/* Cannot split anonymous THP to order-1 */
+			if (new_order == 1) {
+				VM_WARN_ONCE(1, "Cannot split to order-1 folio");
+				return -EINVAL;
+			}
+		} else {
+			/* Split shmem folio to non-zero order not supported */
+			if (shmem_mapping(folio->mapping)) {
+				VM_WARN_ONCE(1,
+					"Cannot split shmem folio to non-0 order");
+				return -EINVAL;
+			}
+			/* No split if the file system does not support large folio */
+			if (!mapping_large_folio_support(folio->mapping)) {
+				VM_WARN_ONCE(1,
+					"Cannot split file folio to non-0 order");
+				return -EINVAL;
+			}
 		}
 	}

-
 	is_hzp = is_huge_zero_folio(folio);
 	if (is_hzp) {
 		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");
-- 
2.15.2

