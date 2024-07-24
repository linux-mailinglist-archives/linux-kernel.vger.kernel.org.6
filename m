Return-Path: <linux-kernel+bounces-260561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC193AAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57E51F2325D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1B17758;
	Wed, 24 Jul 2024 02:08:16 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15EF4FB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786896; cv=none; b=uMOuLCpN8I+zrCux236e6HBUWpIl6FMB7tAb2tBt0EhXNjaDoB2aw52Kvi5xvhV28O+0Ay2L8BhXWtfgIrUCt8e5HY4tiRBlgBaJswRNXNriPl7pAbUw3OCxoJy96wrZJZLQxgUyG3aG6Rf7s1q+axB9IdbWL+0+6/vUCtyd3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786896; c=relaxed/simple;
	bh=BOgCXSS9gM4CS7YsaPM0Hgc4lXW3ePBNDyxaReHGDj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZNepLMfM8kiKt7+gUOn2aiQLsGez8zsEPeFlgwm0fWPaKfFDdWFhOSHAQWR1T4ZCRvSQ22pnioH4SEQR/gsNwSRCO6aD9V/BzTeRSKl2HOVoYlgU6vqKx1xd5f5IDUGfrAPKnHTW71WEKjGsROqRnuhiU6ERy0tZHkJG8PM+ONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAnDzoBYqBmsdWrAA--.46141S2;
	Wed, 24 Jul 2024 10:08:01 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] erofs: convert comma to semicolon
Date: Wed, 24 Jul 2024 10:07:21 +0800
Message-Id: <20240724020721.2389738-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnDzoBYqBmsdWrAA--.46141S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF18ZryDZF17Cr1xZrb_yoWfGwc_A3
	Zaqr48WF43Jr17K3y5G39YvF1kXay7ur4xAF4j9an0vrWUJr45Jr4DWa18Wrn8u3Waga1a
	kwn3Gry8JrZxCjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjfUOjjgDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: 84a2ceefff99 ("erofs: tidy up stream decompressors")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 fs/erofs/decompressor_lzma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 06a722b85a45..40666815046f 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -188,7 +188,7 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			       !rq->partial_decoding);
 	buf.in_size = min(rq->inputsize, PAGE_SIZE - rq->pageofs_in);
 	rq->inputsize -= buf.in_size;
-	buf.in = dctx.kin + rq->pageofs_in,
+	buf.in = dctx.kin + rq->pageofs_in;
 	dctx.bounce = strm->bounce;
 	do {
 		dctx.avail_out = buf.out_size - buf.out_pos;
-- 
2.25.1


