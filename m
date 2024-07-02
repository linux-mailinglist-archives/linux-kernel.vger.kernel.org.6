Return-Path: <linux-kernel+bounces-237181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED791ED1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72FF2843E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0AC168A8;
	Tue,  2 Jul 2024 02:48:38 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B428385
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888518; cv=none; b=ISeBh8E3NtaSC5ZraQytDQDNFW4rJesgS8BsTYw0IHZBfrVlYj5t1hjVPSMpdUF1TZ8KyYxMUhaCxEUXv4uj6x6J70iisGB25uyH6M1BzYjIDBckFhMia0Eby1GEsTxWu604lrAk7gnu5elsuE2KOLTmr6kYDl5gPKVDrOuDqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888518; c=relaxed/simple;
	bh=egxj00bAm237tAR5xsPTNlx3oMwWUnxzJKHmcy1c/eY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rdk3VHZg9zjTdzecyOAWCJ2g0Ix6cUkYpfV26DpmAochzzeUvht0E4vg/YxBw2D+SlK92eCVoWF5zyqEMVPl/RAUQej2dH8DnY6Zpm0LV48rGYBwriffAiVeoHeRdvwDh0IGeu74IeYJEMLvAq3c835USRF4hpVmi69xZOEFBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXX3d2aoNmnBeXEw--.36213S2;
	Tue, 02 Jul 2024 10:48:22 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] i3c: master: svc: Convert comma to semicolon
Date: Tue,  2 Jul 2024 10:47:58 +0800
Message-Id: <20240702024758.1411569-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXX3d2aoNmnBeXEw--.36213S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrWUJrW5ZFb_yoWfWFg_KF
	15AF4xtFs8Ar1jka4Fkr9I9r12y34rXF4kKF9YqF93uFWxJw1kJ3WUJr47AFyUGa17XrZr
	KrWDKrn3Cr97GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
	Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnhFxUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index f0362509319e..eb42280f465a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1351,7 +1351,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->addr = ccc->dests[0].addr;
 	cmd->rnw = ccc->rnw;
 	cmd->in = ccc->rnw ? ccc->dests[0].payload.data : NULL;
-	cmd->out = ccc->rnw ? NULL : ccc->dests[0].payload.data,
+	cmd->out = ccc->rnw ? NULL : ccc->dests[0].payload.data;
 	cmd->len = xfer_len;
 	cmd->actual_len = actual_len;
 	cmd->continued = false;
-- 
2.25.1


