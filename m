Return-Path: <linux-kernel+bounces-245283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3372C92B0AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E111C21641
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686813DDAA;
	Tue,  9 Jul 2024 06:52:11 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89913C699
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507930; cv=none; b=pEvP93/3FMnfZn7ThGWV1YQrynQZUXioaEZQkxL/xIUB0aKEBNmRvAJrce7FvjDRc633DCTRqxJkDMtKFDl7YgS7ZQKS66h5r7Kb9TxcdHRGGFooaOV3uuvez+hYvVpimHPvy4vBcQKHbbd4C6J4do0IyYDcgA+62SrtA5cNHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507930; c=relaxed/simple;
	bh=NlhbpVlzBisRb3uUIcsg28/MryMoNaL1+d5GF/ddONg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N30w/kId0CqmsvBrx84BSQsYBY8on8tbtww3YkD6fRDA2hCagdJbgP5iifqmqeGqaSWOzrGu/58mFwOL75fpjSOM3PyqxQGpl0f+wWB70Jj4XX8LFsMrttOTmFzEDfH0wJ9Cx9m453rhi0Zirz3cMO0ZnSMlacMMfEvmfoA7Crw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABHTpIQ3oxm2DrLFA--.39884S2;
	Tue, 09 Jul 2024 14:52:00 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: me@bobcopeland.com
Cc: linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] fs: omfs: Convert comma to semicolon
Date: Tue,  9 Jul 2024 14:51:51 +0800
Message-Id: <20240709065151.869737-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHTpIQ3oxm2DrLFA--.39884S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47Jw4UGr4fGrg_yoW3Zrc_A3
	sFqry8JFs8JFnakr1xJ34Yv3s5X39YvF1S9rySqFWv9a4qqa95J34Dur18GwnxXrZ8Xr13
	GrykurnIyFyjvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
	GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0T5lUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 fs/omfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 6b580b9da8e3..94cb3b454c6f 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -22,8 +22,8 @@ void omfs_make_empty_table(struct buffer_head *bh, int offset)
 	struct omfs_extent *oe = (struct omfs_extent *) &bh->b_data[offset];
 
 	oe->e_next = ~cpu_to_be64(0ULL);
-	oe->e_extent_count = cpu_to_be32(1),
-	oe->e_fill = cpu_to_be32(0x22),
+	oe->e_extent_count = cpu_to_be32(1);
+	oe->e_fill = cpu_to_be32(0x22);
 	oe->e_entry[0].e_cluster = ~cpu_to_be64(0ULL);
 	oe->e_entry[0].e_blocks = ~cpu_to_be64(0ULL);
 }
-- 
2.25.1


