Return-Path: <linux-kernel+bounces-250343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B939C92F6BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B811283F70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E213D8BA;
	Fri, 12 Jul 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yYwNxIPI"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940313E41A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771937; cv=none; b=ImanAdq6RBPudt0TeFPJuCSOpuoZY16Bj3TN99mfiDxNVtxjrQxqD2izZPzxs5/78JMkswPELUxABHh25Ge8PdGvuIg5LB+gIxdIlh1tB+Ao5j+ARCiM6qHNzmA/pjogWecCn1rmXcrJZNxf4tdDt5fyAmgk6j02VIog/HCwt0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771937; c=relaxed/simple;
	bh=r5zyrr3BYxHHWnaVzyJpQtFrnqL+NXqeS5ERjugOHb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ISBroby3HqgHd49mNO5qLLd6N7OlpJRTN7uLMHSVh9f6X1IIvAl3x+obtjOnBXWSwSf4ghmknQux7yqfsaVvzteZo3HzHs8bfTK828yPnTWsaJ3+EzVh8oiBORV6er88VJRGAMjpo6HAYBloE5Huf7FCmLbciDqJnEjQkD4GrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yYwNxIPI; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720771927; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/wPJluxUonZQmG3kBDuVNlFzELRzhrhx8+rANc3wuGA=;
	b=yYwNxIPIjNfKCbHIQt7TFFbcNy25CpwKCbmfs1SN3ZzaC7183Lj53+k+Bfm2mF53HtMarOzAhOUyJUXfYFuan9crDDIL0OahLjx0PMz2Anc8bJHr6GQ7efdgMzjWdP88qkk2Mtq6zLk2mA537xXvmkY1+M99WiqPZ1XqfRNg5E0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WANUZb3_1720771926;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WANUZb3_1720771926)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 16:12:06 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] dm: vdo: Add missing kernel-doc function comments.
Date: Fri, 12 Jul 2024 16:12:04 +0800
Message-Id: <20240712081204.79723-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kernel-doc function comments to enhance code readability and
maintainability in accordance with the kernel coding standards.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9518
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/md/dm-vdo/repair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/dm-vdo/repair.c b/drivers/md/dm-vdo/repair.c
index ff09e4a14333..8947e6092a91 100644
--- a/drivers/md/dm-vdo/repair.c
+++ b/drivers/md/dm-vdo/repair.c
@@ -319,6 +319,7 @@ static bool __must_check abort_on_error(int result, struct repair_completion *re
 /**
  * drain_slab_depot() - Flush out all dirty refcounts blocks now that they have been rebuilt or
  *                      recovered.
+ * @completion: The completion to convert.
  */
 static void drain_slab_depot(struct vdo_completion *completion)
 {
@@ -656,6 +657,7 @@ static void rebuild_reference_counts(struct vdo_completion *completion)
 
 /**
  * increment_recovery_point() - Move the given recovery point forward by one entry.
+ * @point: The location of the next recovery journal entry to apply.
  */
 static void increment_recovery_point(struct recovery_point *point)
 {
@@ -953,6 +955,7 @@ static void abort_block_map_recovery(struct repair_completion *repair, int resul
 /**
  * find_entry_starting_next_page() - Find the first journal entry after a given entry which is not
  *                                   on the same block map page.
+ * @repair: The repair completion.
  * @current_entry: The entry to search from.
  * @needs_sort: Whether sorting is needed to proceed.
  *
@@ -1219,6 +1222,7 @@ static bool __must_check is_exact_recovery_journal_block(const struct recovery_j
 
 /**
  * find_recovery_journal_head_and_tail() - Find the tail and head of the journal.
+ * @repair: The repair completion.
  *
  * Return: True if there were valid journal blocks.
  */
@@ -1447,6 +1451,7 @@ static int validate_heads(struct repair_completion *repair)
 
 /**
  * extract_new_mappings() - Find all valid new mappings to be applied to the block map.
+ * @repair: The repair completion.
  *
  * The mappings are extracted from the journal and stored in a sortable array so that all of the
  * mappings to be applied to a given block map page can be done in a single page fetch.
@@ -1501,6 +1506,7 @@ static int extract_new_mappings(struct repair_completion *repair)
 /**
  * compute_usages() - Compute the lbns in use and block map data blocks counts from the tail of
  *                    the journal.
+ * @repair: The repair completion.
  */
 static noinline int compute_usages(struct repair_completion *repair)
 {
-- 
2.20.1.7.g153144c


