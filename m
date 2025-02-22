Return-Path: <linux-kernel+bounces-526995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD7A40605
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F39707D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F61204C26;
	Sat, 22 Feb 2025 07:12:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BDB2046BD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208358; cv=none; b=pLjaecUOy8sA8XrRQsoEI5DLMTdqgE3Ces6Jr18phoyT4+FNl8XmYJ/hmGKoNhgNgaL9Lx/73MN2L84dvbivMMd/UkAnY2n0uvaFM1lC1zK84GUwdcMQBf3iBlOyeqf4ziutE6iPWlnNH2Id2Du2eM4ZYD3DYlIqDoed7gHnniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208358; c=relaxed/simple;
	bh=lcMarZmdIa/O8qSOvi5bh0dtceBNI8DUtJN+5aIfq2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbHRwXefXI9xVJjpu9aqr2ATTNa9RJPgjsGQzTHh8jaLCZWkVYG7YOYkHzHIfB9rFbt5BUlpNy/X6FhXkIyTrZAkcHSvSS6tCtuGtNV0plzwy5M/lVSwONE6o0RdQ9/tVp9n/OnNnSaJwvdNEfKVIM8sb2fJGHl4rbUIPNgQFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0J8s4sQXz4f3jtC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 14F831A1402
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgBHBWjaeLlnrTsjEg--.26688S8;
	Sat, 22 Feb 2025 15:12:29 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm: swap: remove stale comment of swap_reclaim_full_clusters()
Date: Sun, 23 Feb 2025 00:08:50 +0800
Message-Id: <20250222160850.505274-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250222160850.505274-1-shikemeng@huaweicloud.com>
References: <20250222160850.505274-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHBWjaeLlnrTsjEg--.26688S8
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1kKrWfAF4fAr4kuw4rKrg_yoWxZFX_ua
	9Yy34kGrWrG3W8Ca43C34rXrZ7Wan3Za48Ary3KFW7A343GF1xZ3WkX343W343Xw4DX34r
	AwsYvrn3AwnrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

swap_reclaim_full_clusters() has no return value now, just remove the
stale comment which says swap_reclaim_full_clusters() wil return a bool
value.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6ff57ed23e27..dc0dc5a26a88 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -820,7 +820,6 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	return found;
 }
 
-/* Return true if reclaimed a whole cluster */
 static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 {
 	long to_scan = 1;
-- 
2.30.0


