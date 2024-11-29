Return-Path: <linux-kernel+bounces-425203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE89DBED4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B45B21B14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E5A7F7FC;
	Fri, 29 Nov 2024 03:02:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8BA3C3C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732849335; cv=none; b=foSMVMJyJuEVCgLACjzcdbbPa91+o6IhhQ+oc1RhWyUHdmjVg19kYCIObrIVcnSzr59I1AeJXOWzyGY26Sx2B2DHLbwlSctlRTEkrfjoOgdYSFoiEGAn0vS6aJcUDR5nmmR+FJ9CV1koZ9vQlJc3khrFeiyecolv78IA7jgKLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732849335; c=relaxed/simple;
	bh=wjk07jw1Mfrnejde7tfJqUHtjNnnPHt+rjSbnjMJMoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9TNSudZ71CA+/rshbX4p2IWpDI8wtHKeX8/pYqRVZiTOvzldlh44w7AJldCyfjHuVw1h/NuT8MrC8Pfoj/kjQJ5In2Cwx4DJ6EcHpj6+6xgFrMarYCYbHHMwLaWWk5lVg17JWK4m+mWEEkIBhii/PMeJoY+BRNZc2+dKRmW75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4d11c3f4adfe11efa216b1d71e6e1362-20241129
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:14d84a24-f49b-4c47-a252-0f4df906619b,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:25
X-CID-INFO: VERSION:1.1.38,REQID:14d84a24-f49b-4c47-a252-0f4df906619b,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:35b8a1c97a67c95beb2957a9a36033dc,BulkI
	D:2411291102005DW3XCYH,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|102,T
	C:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 4d11c3f4adfe11efa216b1d71e6e1362-20241129
X-User: tianyaxiong@kylinos.cn
Received: from ukylin-xiaoxinpro-16-irh8.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2099950808; Fri, 29 Nov 2024 11:01:59 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH] drivers core: bus: Remove unnecessary NULL assignments in the bus_register() function
Date: Fri, 29 Nov 2024 11:01:30 +0800
Message-ID: <20241129030130.3754-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bus_register(), Priv is a local pointer variable, so its assignment
can be ignored and the function can be returned directly. This can reduce
the NULL checks in the subsequent kfree function.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/base/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0d..c1fd2860e397 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -923,7 +923,7 @@ int bus_register(const struct bus_type *bus)
 bus_uevent_fail:
 	kset_unregister(&priv->subsys);
 	/* Above kset_unregister() will kfree @priv */
-	priv = NULL;
+	return retval;
 out:
 	kfree(priv);
 	return retval;
-- 
2.25.1


