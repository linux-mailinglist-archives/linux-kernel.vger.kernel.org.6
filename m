Return-Path: <linux-kernel+bounces-415348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B17FB9D34D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B9DB264EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC384197A8B;
	Wed, 20 Nov 2024 07:51:55 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBA17DE16;
	Wed, 20 Nov 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089115; cv=none; b=kV30WCYc7Gqy9BEUo/b0oQe4WBGTYCyath3CAEWWQ/H1ZQbNb2BjZeZg+CLsCdsA8cZlHi0oeyw8Jz7b+odZdPKk9Nyvap0rKmodH9Hix1NoyzJMhPiWA9qrPza4Zhym6X+P/r00saFxvfQMGcmWt0MSDzpDhGXrGuJSJxGneng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089115; c=relaxed/simple;
	bh=J1s2mQxZkN6kCT43h92yVoRcuUzkhPg4z6+1kNmao4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVfQDfn/2upmdUsU0UYVaBLv7wrdxcUwo+eiDY0On2aPdQ2il9O+zNAc7vKS0LpZxXjmzUWgfsr06jEOPKA84GJ1Cv2EM4BcpumwcLACgzuF+C+/O0mIn0jh7InRlDf1r7TLxTq8JDMiIM99l3j1B3dibnnlOGuFSBQTAf5FRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a1451c6a71411efa216b1d71e6e1362-20241120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:778b825b-dd58-4f14-88f1-3aa94b4016e8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:778b825b-dd58-4f14-88f1-3aa94b4016e8,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:04117c721b646a09e15582845e1b6941,BulkI
	D:241120155146BCKL4QQB,BulkQuantity:0,Recheck:0,SF:66|841|38|17|19|102,TC:
	nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 4a1451c6a71411efa216b1d71e6e1362-20241120
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 689002947; Wed, 20 Nov 2024 15:51:45 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	vadimp@nvidia.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davthompson@nvidia.com,
	Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] platform/mellanox: mlxbf-pmc: incorrect type in assignment
Date: Wed, 20 Nov 2024 15:51:39 +0800
Message-Id: <fece26ad40620b1e0beb733b9bba3de3ce325761.1732088929.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202411121935.cgFcEMO4-lkp@intel.com>
References: <202411121935.cgFcEMO4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse warning,expected 'void __iomem *addr',but got 'void *addr'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411121935.cgFcEMO4-lkp@intel.com/
Fixes: 423c3361855c ("platform/mellanox: mlxbf-pmc: Add support for BlueField-3")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 9d18dfca6a67..9ff7b487dc48 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1168,7 +1168,7 @@ static int mlxbf_pmc_program_l3_counter(unsigned int blk_num, u32 cnt_num, u32 e
 /* Method to handle crspace counter programming */
 static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num, u32 evt)
 {
-	void *addr;
+	void __iomem *addr;
 	u32 word;
 	int ret;
 
@@ -1192,7 +1192,7 @@ static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num,
 /* Method to clear crspace counter value */
 static int mlxbf_pmc_clear_crspace_counter(unsigned int blk_num, u32 cnt_num)
 {
-	void *addr;
+	void __iomem *addr;
 
 	addr = pmc->block[blk_num].mmio_base +
 		MLXBF_PMC_CRSPACE_PERFMON_VAL0(pmc->block[blk_num].counters) +
@@ -1405,7 +1405,7 @@ static int mlxbf_pmc_read_l3_event(unsigned int blk_num, u32 cnt_num, u64 *resul
 static int mlxbf_pmc_read_crspace_event(unsigned int blk_num, u32 cnt_num, u64 *result)
 {
 	u32 word, evt;
-	void *addr;
+	void __iomem *addr;
 	int ret;
 
 	addr = pmc->block[blk_num].mmio_base +
-- 
2.34.1


