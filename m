Return-Path: <linux-kernel+bounces-377422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7BA9ABE99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431D61C211FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A72145B2E;
	Wed, 23 Oct 2024 06:21:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BF40BF5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664498; cv=none; b=jbPlJVTAIUyo690x5KIVQxVnDMdoEqj4ir7E588/X9Eu4/1plPce/ZQD95f50tkylAbcl7buRUjEvUc0ficcn8Xi8d1265/oPgMveK9sKLybDRCREyFK4+FjCT8aQCuywlwUcficji6vK3tUZyalfyFvQvNNx79loN1Bk1Rl2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664498; c=relaxed/simple;
	bh=i7HAztIF2lHeNjLEE+b3ZN9i34EOSphbSjCXHsEXAsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5c8JbcpdTv3hWvR0ujoL3hRBu/zjh38jLIUoCo+/QYm+7IylAobEbDX6muqKBbsHiEkRXapOWj3SYI5pPgWv4L0jCabuiXFJ7xaErhi+gtlJYONmaKdDDkdjbtVfNc+Cax1Zo9IERVNBJV1/Ux2idRxzuOqOpx1FAU6cf45Km0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06cf927c910711efa216b1d71e6e1362-20241023
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a7177d0e-955b-4d31-8c79-b40951c37bf4,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-INFO: VERSION:1.1.38,REQID:a7177d0e-955b-4d31-8c79-b40951c37bf4,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:30
X-CID-META: VersionHash:82c5f88,CLOUDID:fb46e68ba4aa035b83d1e11ad33e5b48,BulkI
	D:241023135508YRKI0UUL,BulkQuantity:2,Recheck:0,SF:841|72|19|66|102,TC:nil
	,Content:0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 06cf927c910711efa216b1d71e6e1362-20241023
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 219048297; Wed, 23 Oct 2024 14:21:23 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: surenb@google.com
Cc: akpm@linux-foundation.org,
	gehao@kylinos.cn,
	hao.ge@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	xiaopei01@kylinos.cn,
	xiaopeitux@foxmail.com,
	xiongxin@kylinos.cn,
	yuzhao@google.com
Subject: [PATCH] slub_kunit:fix a WARNING due to __kmalloc_cache_noprof incorretly use
Date: Wed, 23 Oct 2024 14:21:17 +0800
Message-Id: <0c215961308b0433cd76389fe53d7f7776a32dcb.1729663738.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJuCfpHxrN_12h3pmK6Z+k7W1_6QWgAym9xgczcKTjYyLQ+S_Q@mail.gmail.com>
References: <CAJuCfpHxrN_12h3pmK6Z+k7W1_6QWgAym9xgczcKTjYyLQ+S_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'modprobe slub_kunit',will have a warning [1].The root cause is that
__kmalloc_cache_noprof was directly used,which resulted in no alloc_tag
being allocated.This caused current->alloc_tag to be null,leading to
a warning in alloc_tag_add_check.

Let's add an alloc_hook layer to __kmalloc_cache_noprof specifically
within lib/slub_kunit.c.

[1].
[58162.947016] WARNING: CPU: 2 PID: 6210 at
./include/linux/alloc_tag.h:125 alloc_tagging_slab_alloc_hook+0x268/0x27c
[58162.957721] Call trace:
[58162.957919]  alloc_tagging_slab_alloc_hook+0x268/0x27c
[58162.958286]  __kmalloc_cache_noprof+0x14c/0x344
[58162.958615]  test_kmalloc_redzone_access+0x50/0x10c [slub_kunit]
[58162.959045]  kunit_try_run_case+0x74/0x184 [kunit]
[58162.959401]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kunit]
[58162.959841]  kthread+0x10c/0x118
[58162.960093]  ret_from_fork+0x10/0x20
[58162.960363] ---[ end trace 0000000000000000 ]---

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Fixes: a0a44d9175b3 ("mm, slab: don't wrap internal functions with alloc_hooks()")
Fixes: a286da323418 ("mm/slub, kunit: Add testcase for krealloc redzone and zeroing")
---
 lib/slub_kunit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 3cd1cc667988..f11691315c2f 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -141,7 +141,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 {
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
 				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
-	u8 *p = __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
+	u8 *p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 18));
 
 	kasan_disable_current();
 
@@ -199,7 +199,7 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_krealloc", 64,
 				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
 
-	p = __kmalloc_cache_noprof(s, GFP_KERNEL, 48);
+	p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 48));
 	memset(p, 0xff, 48);
 
 	kasan_disable_current();
-- 
2.34.1


