Return-Path: <linux-kernel+bounces-408532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AAA9C8015
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393241F221C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFABF1E3DF2;
	Thu, 14 Nov 2024 01:40:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CC42AA3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548415; cv=none; b=A8HFQ2lZOhm+kN3mK0AzB2DOTfRUP2cdXEhlIJVSIdBnH4kXTUaGFbyqYuVuMROnIPLb6OtbN9yhTAT1jap5PHt2qd7Rxb1kYAQ1wZ9m9iFzrtvfqNe6fep/yFk6oYH5nsqpVd6kt3JFrbOqp1EG7QZXD+CfzfNhmIZkytOpkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548415; c=relaxed/simple;
	bh=ZJ/ujmIN1i9K9n54X6yUfiA9sCxlY+oOdFSHdgyuRVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R548ncZnSrnTwWCoUIT4/Bo+wJwzV3x6p1qKr5PpTEmWLmj8dD20HsiaxQwwwqPn+KPC5umscXe/3hVgUOGuZuUYdheuU++kPsdVSxOiTegobavO6VsPe914BLX/Pw7wLMviBAlLt1O8ME57j5ar9cTkMH4G93i6wBqjghN5kr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5fbd7254a22911efa216b1d71e6e1362-20241114
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_QUESTION
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f6cb0ad7-cb49-4101-a81d-ab4fd07473a0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:f6cb0ad7-cb49-4101-a81d-ab4fd07473a0,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:08d76a92274c45324604f474c891344e,BulkI
	D:241113230005088VC21T,BulkQuantity:3,Recheck:0,SF:17|19|66|841|38|102,TC:
	nil,Content:0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-UUID: 5fbd7254a22911efa216b1d71e6e1362-20241114
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 263850326; Thu, 14 Nov 2024 09:40:05 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+3fa2af55f15bd21cada9@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
Cc: xiaopei01@kylinos.cn
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton
Date: Thu, 14 Nov 2024 09:40:01 +0800
Message-Id: <20241114014002.7435-1-xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <67321ded.050a0220.a83d0.0016.GAE@google.com>
References: <67321ded.050a0220.a83d0.0016.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 81d6c734c8bc..ead1d338fa58 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -66,8 +66,11 @@ static s32 snto32(__u32 value, unsigned int n)
 
 static u32 s32ton(__s32 value, unsigned int n)
 {
-	s32 a = value >> (n - 1);
+	s32 a;
 
+	if (n >= 32)
+		return value;
+	a = value >> (n - 1);
 	if (a && a != -1)
 		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
 	return value & ((1 << n) - 1);


