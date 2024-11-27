Return-Path: <linux-kernel+bounces-423337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD29DA5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B50128139D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7EE197A8F;
	Wed, 27 Nov 2024 10:38:59 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14440145B0F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703938; cv=none; b=kcssrQWpamGsq1+g6LfcIAS3Xyh9ZWVo885Jrs51fOIHq79SRdwIR8qKpzVbwgxt26Pjz0lQVwqZTLuK0Pd1gqQCC5P7Ha77Jycc3rNoqZQepwo3uGvXtrbP2iGkeQvGMgfK6cfnqpnZ0727R3jQpuo3OhHxOn9e/1mKSjyYpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703938; c=relaxed/simple;
	bh=ZYvcVW323NA1Uz0R0y6vV9hQQgnQEtYSCpswGooTjps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KmuxmZqkft0GmK+NF1iT9HWIYQzf5UDBef1i7BlhECXFUh3p9kpsY66W9LP8HhbGnEM5JwOkF6gd/2O6A+RTr5DjTWeZLwX5nGHO9JcXryVVEJx+tNmIhsFcLOcvt3sOT0Dps5GDRtlDyz5Crzx2mNvAzeIjYMghJF69NGIp4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c88d85eeacab11efa216b1d71e6e1362-20241127
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4c49f6c0-06fd-4933-a697-b0e3d56c6535,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:4c49f6c0-06fd-4933-a697-b0e3d56c6535,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:cf4ea15cbe626a5561605d49b7c36fee,BulkI
	D:241127183519U1COWKNK,BulkQuantity:1,Recheck:0,SF:17|19|38|66|102,TC:nil,
	Content:0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: c88d85eeacab11efa216b1d71e6e1362-20241127
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 994606237; Wed, 27 Nov 2024 18:38:47 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: alexandre.belloni@bootlin.com,
	aniketmaurya@google.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] i3c: dw: Fix use-after-free in dw_i3c_master driver due to race condition
Date: Wed, 27 Nov 2024 18:38:41 +0800
Message-Id: <bfc49c9527be5b513e7ceafeba314ca40a5be4bc.1732703537.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dw_i3c_common_probe, &master->hj_work is bound with
dw_i3c_hj_work. And dw_i3c_master_irq_handler can call
dw_i3c_master_irq_handle_ibis function to start the work.

If we remove the module which will call dw_i3c_common_remove to
make cleanup, it will free master->base through i3c_master_unregister
while the work mentioned above will be used. The sequence of operations
that may lead to a UAF bug is as follows:

CPU0                                      CPU1

                                     | dw_i3c_hj_work
dw_i3c_common_remove                 |
i3c_master_unregister(&master->base) |
device_unregister(&master->dev)      |
device_release                       |
//free master->base                  |
                                     | i3c_master_do_daa(&master->base)
                                     | //use master->base

Fix it by ensuring that the work is canceled before proceeding with
the cleanup in dw_i3c_common_remove.

Fixes: 1dd728f5d4d4 ("i3c: master: Add driver for Synopsys DesignWare IP")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/i3c/master/dw-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 8d694672c110..dbcd3984f257 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1624,6 +1624,7 @@ EXPORT_SYMBOL_GPL(dw_i3c_common_probe);
 
 void dw_i3c_common_remove(struct dw_i3c_master *master)
 {
+	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
 	pm_runtime_disable(master->dev);
-- 
2.34.1


