Return-Path: <linux-kernel+bounces-405019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711739C4BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10465281F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD17201009;
	Tue, 12 Nov 2024 01:40:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ABF2AF06;
	Tue, 12 Nov 2024 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375610; cv=none; b=WgdERCqnfKPgxSzAPqRZrhXsqKFL8RMQ/4tVCJxx97C26Alf0MWeH9saVoHtWHnSFL9zKbGfnsGzEK9m2MiQ8FKhfnAi1lqVtc68a5D06rHslxSIwEMJA6IsxzW82LaN/HMgxBzi7DY9zUpfIzSZ+oOHbIx3zKxIQoAMjrz0L9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375610; c=relaxed/simple;
	bh=6Wi9aebcSGkmNlmdPQNhTryMzIq0HWOcAnjtXeVsul8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K0oVSHTI5Qd27mxvnpQmZ8Df/AUT23KdVXG6tg2Vc/klj89xeG1cuq3ZhvicXOqiImSUh07L8EXgaF1ErvVGzsfP1XWOUICyT36WHN0wH32VCXilpUPCaNT0JIh5v3t4G4CnG/TOyRb9qWoIF2XCHid4JBy9TIJn30s4fuePfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 05b9e802a09711efa216b1d71e6e1362-20241112
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ab381db5-9f01-4f4b-81c2-f196bf66ae3e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:ab381db5-9f01-4f4b-81c2-f196bf66ae3e,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:c8e0fba263f780d9a13349e0305927fb,BulkI
	D:241112093957DRCLLM1L,BulkQuantity:0,Recheck:0,SF:19|66|841|38|17|102,TC:
	nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 05b9e802a09711efa216b1d71e6e1362-20241112
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1469781892; Tue, 12 Nov 2024 09:39:56 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaopeitux@foxmail.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] hwmon: (nct6775-core) Fix overflows seen when writing limit attributes
Date: Tue, 12 Nov 2024 09:39:51 +0800
Message-Id: <7d5084cea33f7c0fd0578c59adfff71f93de94d9.1731375425.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIV_ROUND_CLOSEST() after kstrtoul() results in an overflow if a large
number such as 18446744073709551615 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Fixes: c3963bc0a0cf ("hwmon: (nct6775) Split core and platform driver")
---
 drivers/hwmon/nct6775-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 934fed3dd586..ee04795b98aa 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -2878,8 +2878,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0,
-			data->target_temp_mask);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, data->target_temp_mask * 1000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -2959,7 +2958,7 @@ store_temp_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit tolerance as needed */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, data->tolerance_mask);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, data->tolerance_mask * 1000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->temp_tolerance[index][nr] = val;
@@ -3085,7 +3084,7 @@ store_weight_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 255000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->weight_temp[index][nr] = val;
-- 
2.34.1


