Return-Path: <linux-kernel+bounces-170578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D668BD952
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE971C21286
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504514C85;
	Tue,  7 May 2024 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TLpadRJk"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EB3FE4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715048169; cv=none; b=UymuzATiNBlu+iAQxxnKxsVfCzgCPwEOC37mlAUGCMgHYx+TJF1NqRey39iZeo4G3crwW+MMZE4ePCOkdC8fq4JtiM8nbbfreyoo7hJtF+ju8zFopQscAARkqTpoLUHPkqxEWYgGR0OPIkxFNFZLi5LuKCYhYJBEoqdzhcmdEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715048169; c=relaxed/simple;
	bh=Tlg2msnuHEnP6RLCR6+Oxh1TTRZaMFlw6rLi2MhjLGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKv88eXN91VNwuoudMOUXiM3SfIantblg4yEi+x1+3eLbDF3aA4Lkh3RtU0JnVXwt+21WSzv/AVtnEkgQDO798eCRnGREDX6SDiO9wIBYUjmWpVaO9K9SvLxcbV+jtYGJH7NyQng/xeAYUVh12w8ui386DBNl00fQy/LYElmZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TLpadRJk; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9dbad1140c1511efb92737409a0e9459-20240507
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OkbheN73NOmkxbTzCeJVpVCAkNTb+uG4tFp2uucwYAQ=;
	b=TLpadRJk75RzdzbqokqlXSgJs19HzlTh/1pv4twmQlLAsF3P0XkjXrjM0lYUWU6y1wLZUV0Y9xufIPBPocSiqdm1qvfK/ggwCmNQoMYMNempU1uIlMgXrx7GsJHRiuAY+YHx3hRCHDxO8y4aJD3MX0SHbww+l2kVG4sAsdMZROk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:8f27c4fa-1286-4ede-8ff3-c894e0523740,IP:0,U
	RL:0,TC:0,Content:0,EDM:-32768,RT:0,SF:-32768,FILE:0,BULK:-32768,RULE:Rele
	ase_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:f20f6e92-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:nil,IP:nil,
	URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
	,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9dbad1140c1511efb92737409a0e9459-20240507
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <gavin.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1715883791; Tue, 07 May 2024 10:00:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 May 2024 10:00:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 May 2024 10:00:43 +0800
From: gavin.liu <gavin.liu@mediatek.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, Sumit Garg
	<sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Gavin Liu <gavin.liu@mediatek.com>
Subject: [PATCH v3] optee: add timeout value to optee_notif_wait() to support timeout
Date: Tue, 7 May 2024 10:00:37 +0800
Message-ID: <20240507020037.14009-1-gavin.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Gavin Liu <gavin.liu@mediatek.com>

Add timeout value to support self waking when timeout to avoid waiting
indefinitely.

Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
---
change in v3:
1. change the comment in optee_rpc_cmd.h
2. add macro for "TEE_ERROR_TIMEOUT"
3. change from "TEEC_ERROR_BUSY" to "TEE_ERROR_TIMEOUT"
---
 drivers/tee/optee/notif.c         |  9 +++++++--
 drivers/tee/optee/optee_private.h |  5 ++++-
 drivers/tee/optee/optee_rpc_cmd.h |  1 +
 drivers/tee/optee/rpc.c           | 10 ++++++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index 0d7878e770cd..1970880c796f 100644
--- a/drivers/tee/optee/notif.c
+++ b/drivers/tee/optee/notif.c
@@ -29,7 +29,7 @@ static bool have_key(struct optee *optee, u_int key)
 	return false;
 }
 
-int optee_notif_wait(struct optee *optee, u_int key)
+int optee_notif_wait(struct optee *optee, u_int key, u32 timeout)
 {
 	unsigned long flags;
 	struct notif_entry *entry;
@@ -70,7 +70,12 @@ int optee_notif_wait(struct optee *optee, u_int key)
 	 * Unlock temporarily and wait for completion.
 	 */
 	spin_unlock_irqrestore(&optee->notif.lock, flags);
-	wait_for_completion(&entry->c);
+	if (timeout != 0) {
+		if (!wait_for_completion_timeout(&entry->c, timeout))
+			rc = -ETIMEDOUT;
+	} else {
+		wait_for_completion(&entry->c);
+	}
 	spin_lock_irqsave(&optee->notif.lock, flags);
 
 	list_del(&entry->link);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 429cc20be5cc..424898cdc4e9 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -26,6 +26,9 @@
 #define TEEC_ERROR_BUSY			0xFFFF000D
 #define TEEC_ERROR_SHORT_BUFFER		0xFFFF0010
 
+/* API Return Codes are from the GP TEE Internal Core API Specification */
+#define TEE_ERROR_TIMEOUT		0xFFFF3001
+
 #define TEEC_ORIGIN_COMMS		0x00000002
 
 /*
@@ -252,7 +255,7 @@ struct optee_call_ctx {
 
 int optee_notif_init(struct optee *optee, u_int max_key);
 void optee_notif_uninit(struct optee *optee);
-int optee_notif_wait(struct optee *optee, u_int key);
+int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
 int optee_notif_send(struct optee *optee, u_int key);
 
 u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_cmd.h
index f3f06e0994a7..4576751b490c 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -41,6 +41,7 @@
  * Waiting on notification
  * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_WAIT
  * [in]    value[0].b	    notification value
+ * [in]    value[0].c	    timeout in milliseconds or 0 if no timeout
  *
  * Sending a synchronous notification
  * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_SEND
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index f086812f1179..5de4504665be 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -130,6 +130,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 static void handle_rpc_func_cmd_wq(struct optee *optee,
 				   struct optee_msg_arg *arg)
 {
+	int rc = 0;
+
 	if (arg->num_params != 1)
 		goto bad;
 
@@ -139,7 +141,8 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
 
 	switch (arg->params[0].u.value.a) {
 	case OPTEE_RPC_NOTIFICATION_WAIT:
-		if (optee_notif_wait(optee, arg->params[0].u.value.b))
+		rc = optee_notif_wait(optee, arg->params[0].u.value.b, arg->params[0].u.value.c);
+		if (rc)
 			goto bad;
 		break;
 	case OPTEE_RPC_NOTIFICATION_SEND:
@@ -153,7 +156,10 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
 	arg->ret = TEEC_SUCCESS;
 	return;
 bad:
-	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+	if (rc == -ETIMEDOUT)
+		arg->ret = TEE_ERROR_TIMEOUT;
+	else
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 }
 
 static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
-- 
2.18.0


