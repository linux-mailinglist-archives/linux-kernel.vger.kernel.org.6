Return-Path: <linux-kernel+bounces-510409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D3A31C70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30502166C07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F041D79A0;
	Wed, 12 Feb 2025 02:59:14 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A215383A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329154; cv=none; b=c4NCFf1PEVUBcL4Fxo6HF9haor1g4X6VH67S7zPM+BzbPWx/x/V1+ZQ9moOU7MdPUM3aCPMRbDz24C+euwCMFUlGMSMEgyN6CIn51us/YqZPaGX9q7iMfK3hU0MOjKfnl5vbRXoEL4DeUfrtw09uZLDQ79D242hbXdPTgwvxMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329154; c=relaxed/simple;
	bh=aV2zxs1DuXLn0uXmKEXW6ei0/UBj7F6dHgJy8bNrhPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OW+4g3GYqA2HZPPZ1MbUIbgtLjCHikQalDF4xeA9vGnDTq2jmtPO7R8yHgo3xiV5Yz//8HaCG5eZlUT4E3+3tokYKeH1jXKXGa6sVs20dos8/WqJNR5UVyoh/HARu+JvBsuaaAblKdy10QwaqVdtMqX428w2YtIGoJbxEpvB5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4dcbfcc2e8ed11efa216b1d71e6e1362-20250212
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4a1a4eba-68ca-4d38-bcc7-1e9b35235e0a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:4a1a4eba-68ca-4d38-bcc7-1e9b35235e0a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:d0f04b039f54a4c60a986d9a7cf6b178,BulkI
	D:250212104650ZOX81WIR,BulkQuantity:2,Recheck:0,SF:17|19|25|38|45|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 4dcbfcc2e8ed11efa216b1d71e6e1362-20250212
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.253.31)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 789715939; Wed, 12 Feb 2025 10:58:58 +0800
From: Liu Ye <liuye@kylinos.cn>
To: brauner@kernel.org,
	dhowells@redhat.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH 0/2] mm: Optimize folio_order.
Date: Wed, 12 Feb 2025 10:58:41 +0800
Message-Id: <20250212025843.80283-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches about folio_order.
1. Delete __folio_order and use folio_order directly.
2. Write folio->_flags_1 & 0xff as a macro definition.

Liu Ye (2):
  mm/folio_queue: Delete __folio_order and use folio_order directly
  mm/mm.h: Write folio->_flags_1 & 0xff as a macro definition

 include/linux/folio_queue.h | 12 +++---------
 include/linux/mm.h          | 10 ++++++----
 2 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.25.1


