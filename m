Return-Path: <linux-kernel+bounces-416527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E560A9D4666
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790F7B22EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C655312F59C;
	Thu, 21 Nov 2024 03:55:52 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D249652;
	Thu, 21 Nov 2024 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732161352; cv=none; b=RqR35B7ZVmnkD1g324uvwyRy5uULfLRaobl6LUAlrvxgEnJx8V1NyCYpleh9y4jDgtdQXTqzloLWcw1HsojcFGZP8fUZn58yI6yU2Qe9BJoPD87mRAlp/rrXg/8U8Jo0LLZDZaJIHxpW+/K81dJ4TyToLTtIGEbT8abnGOfkQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732161352; c=relaxed/simple;
	bh=Ow9RTFdrQ4oOvpUDH4Qejbiz1iCr0XL2PGEH92IPSCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gERoduiZUtCR/uXRvAffE3b87zZON0vlACxQHPlW7vgU7BeIK28+gLSc+Rwj0VyA8Xunp74sYiZZShDYMNiT4jAVQJ1FUabfS0w8irS8uU2y16j+mIcfrqWDbbRe+N0B3NIMta96EF6e2CUC4v69hvNkHyar3jtU7EW46ZteXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 78dbc356a7bc11efa216b1d71e6e1362-20241121
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:641ea83f-472c-4b89-8e3e-f3428b142dad,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:641ea83f-472c-4b89-8e3e-f3428b142dad,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:b5f3703de92dcc30843066aac6904296,BulkI
	D:241121115540NU8O3AH3,BulkQuantity:0,Recheck:0,SF:38|17|19|66|841|102,TC:
	nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 78dbc356a7bc11efa216b1d71e6e1362-20241121
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1783700527; Thu, 21 Nov 2024 11:55:39 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] platform/x86: x86-android-tablets: make platform data be static
Date: Thu, 21 Nov 2024 11:55:34 +0800
Message-Id: <daafd1371e7e9946217712ce8720e29cd5c52f7a.1732161310.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202410160432.oJAPbrW9-lkp@intel.co>
References: <202410160432.oJAPbrW9-lkp@intel.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make lenovo_yoga_tab2_1380_bq24190_pdata and lenovo_yoga_tab2_1380_modules
to be static

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410160432.oJAPbrW9-lkp@intel.com/
Fixes: 3eee73ad42c3 ("platform/x86: x86-android-tablets: Add Lenovo Yoga Tablet 2 Pro 1380F/L data")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/platform/x86/x86-android-tablets/lenovo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index ae087f1471c1..a60efbaf4817 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -601,7 +601,7 @@ static const struct regulator_init_data lenovo_yoga_tab2_1380_bq24190_vbus_init_
 	.num_consumer_supplies = 1,
 };
 
-struct bq24190_platform_data lenovo_yoga_tab2_1380_bq24190_pdata = {
+static struct bq24190_platform_data lenovo_yoga_tab2_1380_bq24190_pdata = {
 	.regulator_init_data = &lenovo_yoga_tab2_1380_bq24190_vbus_init_data,
 };
 
@@ -726,7 +726,7 @@ static const struct platform_device_info lenovo_yoga_tab2_1380_pdevs[] __initcon
 	},
 };
 
-const char * const lenovo_yoga_tab2_1380_modules[] __initconst = {
+static const char * const lenovo_yoga_tab2_1380_modules[] __initconst = {
 	"bq24190_charger",            /* For the Vbus regulator for lc824206xa */
 	NULL
 };
-- 
2.34.1


