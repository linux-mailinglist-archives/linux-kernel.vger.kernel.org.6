Return-Path: <linux-kernel+bounces-228543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82791617C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37091F21415
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208A148829;
	Tue, 25 Jun 2024 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NWYItuT/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB51487D8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304807; cv=none; b=O8qRhdVVP9+kFTS449kQ+WeVXr/r4bO+al98Gp1EksJAakWt1p55a8uROSbqRbavA/fBBjAa1WKb4Naj5yWdjkoCxBg31Wcmr0I59YlWw5WWvtTMo0Rnvlib1/mOq6kAfxFNXz6rhaS3Nunz21zxCGL7zJqpEEUN8g5Bf2dL/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304807; c=relaxed/simple;
	bh=aCU7F80QRCvZK9ERBs+1z/isxE3iEOP4UYkzLyOszNo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a9R4LbmJdITMW6uY2m6F7pOujhg6nh9WpdhwXMefpMiOXTVvQg7MrK+bjO38dBuIhYajXsOKFTxTjMZr14tDKcZ9NoRWgdAFSlnNBXhkZjwnEzbxJ7ez0gxgzcUZkeOrvcy9dW0evpYrtKJsLgOIdv8corlUpwfFpco60KdB7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NWYItuT/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 82060bac32ce11ef8da6557f11777fc4-20240625
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=P6NGLArjM/jU5V8YJGX2B1WlLVZG4c754OTzUfKkh2M=;
	b=NWYItuT/8PY92qGnJ8xdpDMBi5qhVJrOSKSGhCvE3RZHKe6AkJgopVetG4LnQZTM9v5fCeDr/Fj8K3x1C5K3VYNOLE+8ei+gzq7jOWFuiq5L9prbMqIP7jiJQOjfjgM6xpqYJRK3cuu7pxc+I7zkLJdibs1P//ncxs8H2CBi6uQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:cb501b69-c089-4d6c-a0fc-36401257f995,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:f00dff44-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 82060bac32ce11ef8da6557f11777fc4-20240625
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 51181535; Tue, 25 Jun 2024 16:39:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jun 2024 16:39:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jun 2024 16:39:58 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Hsiao Chien Sung
	<shawn.sung@mediatek.com>
Subject: [PATCH] soc: mtk-cmdq: Add cmdq_pkt_logic_command to support math operation
Date: Tue, 25 Jun 2024 16:39:57 +0800
Message-ID: <20240625083957.3540-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add cmdq_pkt_logic_command to support math operation.

cmdq_pkt_logic_command can append logic command to the CMDQ packet,
ask GCE to execute a arithmetic calculate instruction,
such as add, subtract, multiply, AND, OR and NOT, etc.

Note that all arithmetic instructions are unsigned calculations.
If there are any overflows, GCE will sent the invalid IRQ to notify
CMDQ driver.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 34 +++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 42 ++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 046522664dc1..f3cd15387f2d 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -15,6 +15,7 @@
 /* dedicate the last GPR_R15 to assign the register address to be poll */
 #define CMDQ_POLL_ADDR_GPR	(15)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
+#define CMDQ_IMMEDIATE_VALUE	0
 #define CMDQ_REG_TYPE		1
 #define CMDQ_JUMP_RELATIVE	0
 #define CMDQ_JUMP_ABSOLUTE	1
@@ -45,6 +46,16 @@ struct cmdq_instruction {
 	u8 op;
 };
 
+static inline u8 cmdq_operand_get_type(struct cmdq_operand *op)
+{
+	return op->reg ? CMDQ_REG_TYPE : CMDQ_IMMEDIATE_VALUE;
+}
+
+static inline u16 cmdq_operand_get_idx_value(struct cmdq_operand *op)
+{
+	return op->reg ? op->idx : op->value;
+}
+
 int cmdq_dev_get_client_reg(struct device *dev,
 			    struct cmdq_client_reg *client_reg, int idx)
 {
@@ -461,6 +472,29 @@ int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mas
 }
 EXPORT_SYMBOL(cmdq_pkt_poll_addr);
 
+int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
+			   struct cmdq_operand *left_operand,
+			   enum cmdq_logic_op s_op,
+			   struct cmdq_operand *right_operand)
+{
+	struct cmdq_instruction inst = { {0} };
+
+	if (!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX)
+		return -EINVAL;
+
+	inst.op = CMDQ_CODE_LOGIC;
+	inst.dst_t = CMDQ_REG_TYPE;
+	inst.src_t = cmdq_operand_get_type(left_operand);
+	inst.arg_c_t = cmdq_operand_get_type(right_operand);
+	inst.sop = s_op;
+	inst.reg_dst = result_reg_idx;
+	inst.src_reg = cmdq_operand_get_idx_value(left_operand);
+	inst.arg_c = cmdq_operand_get_idx_value(right_operand);
+
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_logic_command);
+
 int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 {
 	struct cmdq_instruction inst = {};
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index d4a8e34505e6..5bee6f7fc400 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -25,6 +25,31 @@
 
 struct cmdq_pkt;
 
+enum cmdq_logic_op {
+	CMDQ_LOGIC_ASSIGN = 0,
+	CMDQ_LOGIC_ADD = 1,
+	CMDQ_LOGIC_SUBTRACT = 2,
+	CMDQ_LOGIC_MULTIPLY = 3,
+	CMDQ_LOGIC_XOR = 8,
+	CMDQ_LOGIC_NOT = 9,
+	CMDQ_LOGIC_OR = 10,
+	CMDQ_LOGIC_AND = 11,
+	CMDQ_LOGIC_LEFT_SHIFT = 12,
+	CMDQ_LOGIC_RIGHT_SHIFT = 13,
+	CMDQ_LOGIC_MAX,
+};
+
+struct cmdq_operand {
+	/* register type */
+	bool reg;
+	union {
+		/* index */
+		u16 idx;
+		/* value */
+		u16 value;
+	};
+};
+
 struct cmdq_client_reg {
 	u8 subsys;
 	u16 offset;
@@ -272,6 +297,23 @@ int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
 int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
 		       u16 offset, u32 value, u32 mask);
 
+/**
+ * cmdq_pkt_logic_command() - Append logic command to the CMDQ packet, ask GCE to
+ *		          execute an instruction that store the result of logic operation
+ *		          with left and right operand into result_reg_idx.
+ * @pkt:		the CMDQ packet
+ * @result_reg_idx:	SPR index that store operation result of left_operand and right_operand
+ * @left_operand:	left operand
+ * @s_op:		the logic operator enum
+ * @right_operand:	right operand
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
+			   struct cmdq_operand *left_operand,
+			   enum cmdq_logic_op s_op,
+			   struct cmdq_operand *right_operand);
+
 /**
  * cmdq_pkt_assign() - Append logic assign command to the CMDQ packet, ask GCE
  *		       to execute an instruction that set a constant value into
-- 
2.18.0


