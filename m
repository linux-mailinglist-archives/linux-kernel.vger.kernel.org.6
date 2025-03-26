Return-Path: <linux-kernel+bounces-576487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D03FA70FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4B53B5882
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B881632F2;
	Wed, 26 Mar 2025 04:23:10 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363E2AF0A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742962990; cv=none; b=K8S6eN8weccFMGj8OjPkJxamQI0Uw63Ymfhp2FWw0NQ3CgyEYF2GZLlSii/b3yCnCNoOsRY9oyoUMrukLPltEIkPsb81rQiVJTws3rPMv/W5kdlvIv66FwVtyCZSQ4gEY2kSQmztQTGJREYWk+Qr2UAJAzmtaswUt6+i+iUZi3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742962990; c=relaxed/simple;
	bh=4RLVWi51Pcf+yC82Yda0DuKmc+fKle+xF6kOZxe9+Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KjTZkMyvAnpDtLcN4g8tHE7/pMxPWt70cx2/kkY71Mk5zG2Q0iibDNwdWhgmYGuGRx7ngLsTl7wSmGK3fJQPQmTdpPIz9w9RP78mkG0Ikx3H/RkweiN8ywQbplnPWP8HGEnuup+km9e4t4gf0U77QSfsaFS9yaA2v9YeQU1srng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAn0j4ZgeNnuvCyAQ--.39892S2;
	Wed, 26 Mar 2025 12:22:50 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] smccc: kvm_guest: Remove unneeded semicolon
Date: Wed, 26 Mar 2025 12:06:59 +0800
Message-Id: <20250326040659.1190696-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAn0j4ZgeNnuvCyAQ--.39892S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWry5CFWfKrg_yoW3uFbEkr
	1qgwsrWFyUWrZ0gF45Zw43ur15Zw4kX3Z2vF4S93yay347Zw4UWFW8W3WfAw13ArW0yFy5
	AFy3trsYkw10gjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUDPE
	fUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/firmware/smccc/kvm_guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/kvm_guest.c
index 5767aed25cdc..ffe9f3c013df 100644
--- a/drivers/firmware/smccc/kvm_guest.c
+++ b/drivers/firmware/smccc/kvm_guest.c
@@ -103,7 +103,7 @@ void  __init kvm_arm_target_impl_cpu_init(void)
 		target[i].midr = res.a1;
 		target[i].revidr = res.a2;
 		target[i].aidr = res.a3;
-	};
+	}
 
 	if (!cpu_errata_set_target_impl(max_cpus, target)) {
 		pr_warn("Failed to set target implementation CPUs\n");
-- 
2.25.1


