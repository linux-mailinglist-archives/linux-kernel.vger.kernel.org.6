Return-Path: <linux-kernel+bounces-432876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640209E5159
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ADF1880667
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC8F1A8F84;
	Thu,  5 Dec 2024 09:30:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669654C83
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391050; cv=none; b=mG3uMTiLBbuVYtcSXTbv1mf1K6ZKJVZrevOUsbP+Up+e+11dEuYO5rwFQwIxOrXZfc4yopC2G10oSWvLqefmEtHRaSIZ1t+p/qYhze1Flu50cZH8TEczVtuqH53ecc5gJ5o1dKWLa6oaR+nwcGQ3SWyzbXsu++xapON2pZd3G/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391050; c=relaxed/simple;
	bh=Do75xYj3w2ozTv44OpEef3YHUjGKN3lzdu+WjH3CfC8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MUA7opxqJPUg/7Qn4WaQI+3Y/1qvXBwI5xzRkBp6vSeoRRfXgSgKeRlGFEE4rszBXb1wb3Aovpc33ksFhu4qgg59w6Lkk6hp6CTWyQ1W9JoDQuTaobAcnUSSXO9R4eDvdjde+WDB8fexuN8v+XhQIWLOn7/vf80GRCuzaKSROwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 96f30112b2eb11efa216b1d71e6e1362-20241205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d4291519-b14f-47b7-8113-bb04506bd85b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:e270c473d69c7e920ad64021b0b6ebfe,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 96f30112b2eb11efa216b1d71e6e1362-20241205
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1346963702; Thu, 05 Dec 2024 17:30:39 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id E7BC716002081;
	Thu,  5 Dec 2024 17:30:38 +0800 (CST)
X-ns-mid: postfix-675172BE-8614061473
Received: from [10.42.116.241] (unknown [10.42.116.241])
	by node4.com.cn (NSMail) with ESMTPA id 862DC16002081;
	Thu,  5 Dec 2024 09:30:38 +0000 (UTC)
Message-ID: <3493dccc-6004-43fe-9ac1-fcf3dacd9875@kylinos.cn>
Date: Thu, 5 Dec 2024 17:30:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: 6751189a.050a0220.17bd51.0084.GAE@google.com,
 syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, mazin@getstate.dev,
 syzkaller-bugs@googlegroups.com
From: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] test
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test

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
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+	struct mgmt_cp_remove_adv_monitor *cp;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;

+	cp = cmd->param;
  	hci_dev_lock(hdev);

  	rp.monitor_handle = cp->monitor_handle;
@@ -5540,8 +5544,14 @@ static void 
mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
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

