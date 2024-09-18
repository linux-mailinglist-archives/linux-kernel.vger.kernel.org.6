Return-Path: <linux-kernel+bounces-332439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11697B9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468501F25736
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD0017C7D9;
	Wed, 18 Sep 2024 08:57:12 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306117C992
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649831; cv=none; b=nAizilr1X1zO4GHBWIEE9lOwY1509HtnxF6efx4r/ygwekbQSSfLw/7ZF1zQK6c2jmHWyWClUwM2U91qSw//8oaKQSmVhGZ/sYg4ihI03Yq+QxUS5w2uNrXPD5QzjeXl7EgAhjBaHJOidUtNAv/DMwiuZcrdGgVw9ef6uV+GZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649831; c=relaxed/simple;
	bh=9y1TmfOOnHGxnOgcz8kP1phwrVmvMZKokpJXbTe/ICM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKkHKMjvUjAdAfy8WudwZjfS/wkk6cE6/dBK+Of24JZbQLr3QNJFkSD9JXCGFux2+u0TbtkgrQ3k8wMnQifkhk/Fvs4NlV/w7iHnLd51E/BpTO0+ZNFBH0crBev2ajJNJVzJvMe2BkwK60sJn2GqHQ2dP4MZ81zVzDnB3VA1ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAHD9fNlepmqNFiBA--.408S2;
	Wed, 18 Sep 2024 16:56:46 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: stefan@agner.ch,
	alison.wang@nxp.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] sfc: remove newlines in NL_SET_ERR_MSG_MOD
Date: Wed, 18 Sep 2024 16:56:14 +0800
Message-Id: <20240918085614.2508563-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHD9fNlepmqNFiBA--.408S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4fXw18Zw1UKFyxGw43trb_yoWfWFXEkF
	4q9F43JF4rZrWj9a1FyF4Y9a4Y934DXws5ZFZ2yayaq39rZa4Iq395Xr17Jw1DWry0kF9r
	Wr9xWFWIy342yjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUPOz3UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Fix following coccicheck warning:
./drivers/net/ethernet/sfc/tc.c:1584:29-80: WARNING avoid newline at end
of message in NL_SET_ERR_MSG_MOD

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/ethernet/sfc/tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 0d93164988fc..e2cd20350178 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1581,7 +1581,7 @@ static int efx_tc_flower_replace_foreign_lhs(struct efx_nic *efx,
 
 	type = efx_tc_indr_netdev_type(net_dev);
 	if (type == EFX_ENCAP_TYPE_NONE) {
-		NL_SET_ERR_MSG_MOD(extack, "Egress encap match on unsupported tunnel device\n");
+		NL_SET_ERR_MSG_MOD(extack, "Egress encap match on unsupported tunnel device");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.25.1


