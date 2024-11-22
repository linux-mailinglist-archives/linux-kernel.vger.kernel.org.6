Return-Path: <linux-kernel+bounces-418084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED79D5CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DA5B226F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09F51DE891;
	Fri, 22 Nov 2024 10:06:52 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580501DE2AB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270012; cv=none; b=iq6pBM9NBpqNeL6vK81fLLnCgA2PXdGdmdXW07Y/bsI8zD8BkPEfqCYZ3JjG9CR5D1HggQE0jMpq5BMHiXhtiwhMwUEhi2E8uljYatiGtttoJGL9ddgBWi2JLbXEGd6tzHyKsStrxuquSngwFlfoSh2gYCIwk6caRSmPg8QVGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270012; c=relaxed/simple;
	bh=hsF5fWrVqhTNjzKpab+I24/AxZT8J5BfR0pQu+wZeC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxdhNv4mFiMsjzS4cpt1/PsrCMYo6fwI6f84ePEqYEOxXmQkd2ykzZGXQq0jNmsQUStUAPCb20OTUYvZnUNwxcfpoxMPLNbWBwIsy8w6uI8aMC9+82GbQqQz3A6hukd9Yyg9Qf4XXwsyiyr5Pgzt8fbXmu7U7LK3F7MIxl5VRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7888d698a8b911efa216b1d71e6e1362-20241122
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1dba1e93-ae19-4cb5-a41b-51cf4c6a1607,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:1dba1e93-ae19-4cb5-a41b-51cf4c6a1607,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:38bfd48e11d4299de25a51e090a9ddd1,BulkI
	D:241122180448WVKOXOYN,BulkQuantity:1,Recheck:0,SF:17|19|66|81|82|102,TC:n
	il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 7888d698a8b911efa216b1d71e6e1362-20241122
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 468294209; Fri, 22 Nov 2024 18:06:41 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+84d0441b9860f0d63285@syzkaller.appspotmail.com
Cc: xiaopeitux@foxmail.com,
	linux-kernel@vger.kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] BUG: using smp_processor_id() in preemptible [00000000] code: syz.3.1627/12102 caller is nft_inner_eval+0xda/0x18e0 net/netfilter/nft_inner.c:251
Date: Fri, 22 Nov 2024 18:06:36 +0800
Message-Id: <309c3e431edf9ac461bb9513a3ed795069590ed2.1732269855.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <673fca0e.050a0220.363a1b.012a.GAE@google.com>
References: <673fca0e.050a0220.363a1b.012a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 net/netfilter/nft_inner.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index 928312d01eb1..86c94d8b90c8 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -248,9 +248,13 @@ static bool nft_inner_parse_needed(const struct nft_inner *priv,
 static void nft_inner_eval(const struct nft_expr *expr, struct nft_regs *regs,
 			   const struct nft_pktinfo *pkt)
 {
-	struct nft_inner_tun_ctx *tun_ctx = this_cpu_ptr(&nft_pcpu_tun_ctx);
+	struct nft_inner_tun_ctx *tun_ctx;
 	const struct nft_inner *priv = nft_expr_priv(expr);
 
+	local_bh_disable();
+	tun_ctx = this_cpu_ptr(&nft_pcpu_tun_ctx);
+	local_bh_enable();
+
 	if (nft_payload_inner_offset(pkt) < 0)
 		goto err;
 
-- 
2.34.1


