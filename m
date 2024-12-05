Return-Path: <linux-kernel+bounces-432894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDD9E519F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD5A16677C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA71D5ACD;
	Thu,  5 Dec 2024 09:46:12 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BD1D2B34
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391971; cv=none; b=D7gEqP87VxKtZXJLDpZP9r7ht2USwO08cTIuPI6rDGsng1sTPzsSxtnWvXTJpSU2XtwIxsRgCkcq2+BlQRurrFBNaG8Ein81VEjErpd7csfpcG/XPGPl0skEuScDRaqmRmd041g7PD4tfaQijsPHKlbQTfVw4SET/Mn/aduMh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391971; c=relaxed/simple;
	bh=4pG798z/THNta8eXvNDT+S5SWP5fuPaFRfrYx+/+1LI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=usoXQCQ0VMaPpp2kROi1NWWqGeoRTLehx3/pHa03LLwEXcVOZAGMdIoCIaVUEpJ6Mjx5F5d9f47tX707H2s1SIUZWI3h3JfTy2/hETPGHKeknOh11ShtnlzJqi1TTG6F3kOJqCfOO3/AAu/JrAIXxO+lJ0/KZEDuoF6TnevZ3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc00cf0ab2ed11efa216b1d71e6e1362-20241205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:29b9214c-b29c-45ce-a6aa-6efe3a3bc8e0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:9175b06ae415ab2075fc116474be49ba,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:1
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: bc00cf0ab2ed11efa216b1d71e6e1362-20241205
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 36185986; Thu, 05 Dec 2024 17:46:00 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 1775716002081;
	Thu,  5 Dec 2024 17:46:00 +0800 (CST)
X-ns-mid: postfix-67517657-9780111538
Received: from [10.42.116.241] (unknown [10.42.116.241])
	by node4.com.cn (NSMail) with ESMTPA id 5C5E416002081;
	Thu,  5 Dec 2024 09:45:59 +0000 (UTC)
Message-ID: <1ecc5960-41c1-4e20-8972-c0f46f894ebd@kylinos.cn>
Date: Thu, 5 Dec 2024 17:45:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: 6751747b.050a0220.17bd51.0097.GAE@google.com,
 syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com,
 6751189a.050a0220.17bd51.0084.gae@google.com, linux-kernel@vger.kernel.org,
 mazin@getstate.dev, syzkaller-bugs@googlegroups.com
From: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [patch] test
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
  net/bluetooth/mgmt.c | 16 +++++++++++++---
  1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b31192d473d0..bbc86b7dce07 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5519,8 +5519,12 @@ static void 
mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
  {
      struct mgmt_rp_remove_adv_monitor rp;
      struct mgmt_pending_cmd *cmd = data;
-    struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+    struct mgmt_cp_remove_adv_monitor *cp;
+
+    if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+        return -ECANCELED;

+    cp = cmd->param;
      hci_dev_lock(hdev);

      rp.monitor_handle = cp->monitor_handle;
@@ -5540,8 +5544,14 @@ static void 
mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
  static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
  {
      struct mgmt_pending_cmd *cmd = data;
-    struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
-    u16 handle = __le16_to_cpu(cp->monitor_handle);
+    struct mgmt_cp_remove_adv_monitor *cp;
+    u16 handle;
+
+    if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+        return -ECANCELED;
+
+    cp = cmd->param;
+    handle = __le16_to_cpu(cp->monitor_handle);

      if (!handle)
          return hci_remove_all_adv_monitor(hdev);
-- 
2.34.1

