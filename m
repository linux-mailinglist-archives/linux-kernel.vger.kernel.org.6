Return-Path: <linux-kernel+bounces-237171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7131791ED08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E768B20C69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8905416419;
	Tue,  2 Jul 2024 02:41:32 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AB12E7C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888092; cv=none; b=jtY95FsO1c3ICiDVTCw8lgevWIV0e7qlW7DImdyZv4ykBU/GSg4m7jwzzkRKH6y5kPhvIwbmrx6YL4qjUVBB3tzZXAPXy+B7WlMBO7j/ezUFdkyA7tmb2zkh8qc2nMx3oSMaTI4kDbEQFNeCBb+i3I9KkLMFMvmsoljDRG1eItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888092; c=relaxed/simple;
	bh=YHVdNgYiGR5c7/BUXjHdFiMqNGxnGKGfvWKxwH9D6z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yw4jKD0ba2bqxfUVYqUlS5AaNMoDJztgONRk9oa8xsQWPF1Vn+Cb1E2O3THlnBlDhbo+dMo95J9Exv5OEtyg0A5d6FqzxFpDjo2QjwKhTrwWtqSexCHFRs8qJJgafyUcNbZAhrHRGHpYFfJR4hruCysY4IiXpacZJ/oiRvwEJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowADX33fGaINmaOCWEw--.36013S2;
	Tue, 02 Jul 2024 10:41:10 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] afs: Convert comma to semicolon
Date: Tue,  2 Jul 2024 10:40:55 +0800
Message-Id: <20240702024055.1411407-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX33fGaINmaOCWEw--.36013S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47JrWfZr13Arb_yoWDAFX_A3
	WjyFnYyw4jqw1v9a1Dtrya9F92v34DK3Wktr43KrZ8t3y0qan8Jr4DXF97Cw47Ww1jqFn8
	Ar1Dtr1DJF47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
	Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUDWrAUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 fs/afs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 15bb7989c387..3acf5e050072 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -512,7 +512,7 @@ static int afs_iget5_set_root(struct inode *inode, void *opaque)
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 
 	vnode->volume		= as->volume;
-	vnode->fid.vid		= as->volume->vid,
+	vnode->fid.vid		= as->volume->vid;
 	vnode->fid.vnode	= 1;
 	vnode->fid.unique	= 1;
 	inode->i_ino		= 1;
@@ -545,7 +545,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 	BUG_ON(!(inode->i_state & I_NEW));
 
 	vnode = AFS_FS_I(inode);
-	vnode->cb_v_check = atomic_read(&as->volume->cb_v_break),
+	vnode->cb_v_check = atomic_read(&as->volume->cb_v_break);
 	afs_set_netfs_context(vnode);
 
 	op = afs_alloc_operation(key, as->volume);
-- 
2.25.1


