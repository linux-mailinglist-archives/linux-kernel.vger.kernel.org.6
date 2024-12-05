Return-Path: <linux-kernel+bounces-432757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9311F9E4FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D97E188234C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A71D416A;
	Thu,  5 Dec 2024 08:36:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126B18E37B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387795; cv=none; b=gGxVXzY7m85LEiPYp3D7LwYgGulTlbn0jomsKQ1wdHHmgLI8QRyrScs7lrl0ay4m6X32ynP1RFIBB9hq+IjDn1V5gAFGbJT+Gd8HE7JejBfW7mBDzzuAqKYmyWWK03Jz8FRIfRzxJFaAA1rksTbzq1la3xzu2vERiO/EW5bRW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387795; c=relaxed/simple;
	bh=yfHqPXpquhASuzXa1f4fajpGbUaY/PjUvi+ZzWfe8kY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3vU0GA02CBbqacGylVVOD0+iYkEZhF9Fb/q3f0TR+y/5m9lm49lx3GBwo/eDzYmBkYaXe5bDkWxmYh+3QkbYRrCAVvibf3ypBwxZEXijtK2dRBwJMWoAeQaAx2dkQHsMQGo7c7Z6QgaDutlF5fPgqRHQTx2iiiJYCyl+FiZrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fd678722b2e311efa216b1d71e6e1362-20241205
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:42a85f3d-2c12-44ab-bee5-e05542092c61,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-INFO: VERSION:1.1.38,REQID:42a85f3d-2c12-44ab-bee5-e05542092c61,IP:0,URL
	:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:30c822b82ac0a3fb54e177ef4cbb82d7,BulkI
	D:241205163617X4O8AJQR,BulkQuantity:0,Recheck:0,SF:17|19|66|81|82|102,TC:n
	il,Content:0,EDM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: fd678722b2e311efa216b1d71e6e1362-20241205
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 991976174; Thu, 05 Dec 2024 16:36:15 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	mazin@getstate.dev,
	syzkaller-bugs@googlegroups.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] [PATCH] TEST
Date: Thu,  5 Dec 2024 16:36:10 +0800
Message-Id: <f7ea7d2ea6efebf66a6c5a27409ac76e404c7241.1733387703.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6751189a.050a0220.17bd51.0084.GAE@google.com>
References: <6751189a.050a0220.17bd51.0084.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b31192d473d0..bbc86b7dce07 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5519,8 +5519,12 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 {
 	struct mgmt_rp_remove_adv_monitor rp;
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+	struct mgmt_cp_remove_adv_monitor *cp;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;
 
+	cp = cmd->param;
 	hci_dev_lock(hdev);
 
 	rp.monitor_handle = cp->monitor_handle;
@@ -5540,8 +5544,14 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
-	u16 handle = __le16_to_cpu(cp->monitor_handle);
+	struct mgmt_cp_remove_adv_monitor *cp;
+	u16 handle;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;
+
+	cp = cmd->param;
+	handle = __le16_to_cpu(cp->monitor_handle);
 
 	if (!handle)
 		return hci_remove_all_adv_monitor(hdev);
-- 
2.34.1


