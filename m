Return-Path: <linux-kernel+bounces-362047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863BD99B04C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1821284981
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EDA82D83;
	Sat, 12 Oct 2024 03:02:28 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9D14286
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702148; cv=none; b=E/Zz7pk1bO0J4j+pWZ8WsxYaIiF9+Vks5pjLfXTIxr/4wPWP5C11j1c1EIHXxj0Bd4vOnV6fBtBfNDszOrj0Uoo6qWxY3yvstINkLVAgavjdS/S8zSe68ThMUQI+WmEwk2vKxGfa8Kl6HtYOlBXZiT+ETzoBC8NvXOYHty0E76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702148; c=relaxed/simple;
	bh=HCZ9JOHcYGexPtpzGDwDhStphnljPqDDu2Ych1GnYcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WL0+QAa3xmLB7KwB2MgVe3M5TQ9QpB1LT5jkxnYhndVsfnzf8foSqIpCV3oBNZ4Mav8sbVpjsV4/ZJBh7+Cx+aLLJOxKQvi3YS1vGKmvXEbrOIGbCvIBx+3c1oLpp4jnicjI8uKUWDCudn7lUyHPYFh4lLW+CkzoHbZ46klh22U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXLBHj5AlnDX9yBg--.1264S2;
	Sat, 12 Oct 2024 10:54:27 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: david.e.box@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] tools/arch/x86/intel_sdsi: Remove unneeded semicolon
Date: Sat, 12 Oct 2024 10:52:49 +0800
Message-Id: <20241012025249.44890-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXLBHj5AlnDX9yBg--.1264S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw1xXrWrCr15urg_yoW3Jrb_uF
	10kw48CryrXFZYqrn5Jw4fuFnava4ftF4kZFy8Xa15Aa42yF15AFWDZF1kXrZYqryjq3y7
	Cw13XryrAr4akjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
	JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ3ktUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 766a5d26f534..1863f7fa247f 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -521,7 +521,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
 				lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE);
 
 		offset += blob_size;
-	};
+	}
 
 	return 0;
 }
-- 
2.25.1


