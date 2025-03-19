Return-Path: <linux-kernel+bounces-567518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1FA68745
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B289342176D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E79D25178C;
	Wed, 19 Mar 2025 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nopsOBB6"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB11DDC16
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374295; cv=none; b=QaWxF66FDKHk+cdQZQSWKWVIEZP49ci8tY/14whH1VZRB6udcFIlk2Mpf1LJADUrTo+AixF+WTYvQcvz5t0saymVvNVmX9FP3UysffinPqTnTnKd+X8MV7KZCEcieNIH8irHRYGAmcMK4upp0oDSrEEUbuOCYHz08PpVwfZ7SZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374295; c=relaxed/simple;
	bh=AmGXj3ruzoSWe5+wlIlNdCPehkcd+oQS5El9zpsFbu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PRBvAx36jq/9B2bxVlk5PQtnALQ9Fd97CNJ+k1VK1HBu/rT7tWftbaR+btGoquGzM9hMkqGRl3nvGLWyD7PTjd9AWkp2lw4GCQS0FNfDUQGRdjP0C0t9CQ18TKpKAMc0nm1RUW65Nem7iK27dVf8ENtXjPUgf/4Sw+/LXX7n/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nopsOBB6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nzHmD
	M3YZ3YvZXA64vQjO2nVq/e9p6/6zSO5dWO3xw0=; b=nopsOBB6cfFUuIBxoDnYz
	Y2WC0LLigjv25iQ3xLeMlDLq8VglWYt5mQA9ZMFAeXj62PHot3FLkcjW/pK+cqsQ
	0LnVQQTOG80PlBEF9YYoqt++QJ6zKPv2vxbw2Q1UaR2b8kpgj9bJES9tQCPjtA78
	LGVukFzphGtUJ8ewMygyXw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3_w6BhdpnZiK3AQ--.3480S2;
	Wed, 19 Mar 2025 16:51:14 +0800 (CST)
From: Liu Ye <liuyerd@163.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.com>
Subject: [PATCH] mm/page_alloc: Remove unnecessary __maybe_unused in order_to_pindex()
Date: Wed, 19 Mar 2025 16:51:11 +0800
Message-Id: <20250319085111.390813-1-liuyerd@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_w6BhdpnZiK3AQ--.3480S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1UArWfuFWkXF1UWFyrCrg_yoWfZFc_u3
	WUKrs29rZxCr95KanrCanaqw4ftF1kCr97GF1fWr1ayF12qF1Ivw48A343ArnxWrWI9rWr
	WasYqFW7Kw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnDxhJUUUUU==
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiKB4UTGfZLVt3nwABsP

From: Liu Ye <liuye@kylinos.com>

From : Liu Ye <liuye@kylinos.com>

The `movable` variable is always used when `CONFIG_TRANSPARENT_HUGEPAGE`
is enabled, so the `__maybe_unused` attribute is not necessary.
This patch removes it and keeps the variable declaration within the
`#ifdef` block for better clarity.

Signed-off-by: Liu Ye<liuye@kylinos.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 542d25f77be8..fe76fd237dd0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -508,9 +508,9 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
-	bool __maybe_unused movable;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	bool movable;
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != HPAGE_PMD_ORDER);
 
-- 
2.25.1


