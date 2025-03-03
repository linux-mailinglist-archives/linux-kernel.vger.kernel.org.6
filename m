Return-Path: <linux-kernel+bounces-544468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16454A4E192
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BEA177D19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310CE26A0D6;
	Tue,  4 Mar 2025 14:38:20 +0000 (UTC)
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0526461F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099099; cv=fail; b=iCWJPBrqh+9cMWrMvVT/CRHkA+7zidRrcp2Z/JbUEoYCkJYEBKH6FTNnelzp8WqHGcdUeSkB9Ym1DIEh6JpkTcfIS/KEmoNBYzHUv+ud9NPUnX0foWLJx+Bu08XNHqXTnfAS3CBauslKDDlhpAd6M87OJHvNHI+YtdvZxHL0Xmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099099; c=relaxed/simple;
	bh=lapp8E10+2tewTZMEmUBh5C4W4dpLuw0ZlHm90GU09I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fozfqWOEP3gGvUPLs2afwve0kFXiSRdioDdNV3VxQwyzMnEaWLnOja0f9ivBWZBxVY9dLB+30O26oQoEJQgu/FIIOMsiqeXFIhunguocKNhyChEXqeyqYTVmAuHgiE9ye9bAeQj39b/CxPOP+6jkTTosCRjmXj3nWrOlj3PYaBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=124.126.103.232; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id A103440CF134
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:38:15 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dYP4fTQzFx29
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:36:57 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6E5AB42726; Tue,  4 Mar 2025 17:36:48 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541294-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 22617424A3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:45:07 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id CCBE33064C0C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:45:06 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B80D170EB5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515871F2B82;
	Mon,  3 Mar 2025 09:44:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F62E630
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995066; cv=none; b=koBDOcBHJ2ora9IyhjI7hhvX6n1ubEp3CcxThlhY7ZptYvFzJAUc7ASuONoxtlZ+08Uy/2IIhzPbmq6+G4R2wh8K/3ALws4Xb6dSuOcQOA7vVTqOy0JnTN+t9t+ULjawv4itnpgvAsGsAnu20Aqhu4+GwnHsHLI85LKIOACgwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995066; c=relaxed/simple;
	bh=/VN/BIVlA7mcSzHD+zvXxjMnGVgIzQaLlLiBpPUpFbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fo9AayEW5c5IwxNT82UQEoaLRgkMq93wYfflF1yg5iyfqLLDpa5ZrSShUxMppC8kbqge7+g37J3sXeO16yCoUffGY3etygP4ln2xzDmPmP1LRMsDkl9zns9QdiLiVXReAJmbfef3LWv8kuQsT5AaYziX1mxmhEYqvwLkPFyoBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 11c425c0f81411efa216b1d71e6e1362-20250303
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:76d86c97-c7f6-46e3-822a-127c01f09800,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:76d86c97-c7f6-46e3-822a-127c01f09800,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:236222dcadf08c8573a848a7cbdd98cf,BulkI
	D:250303172844UX4Y89Y6,BulkQuantity:2,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 11c425c0f81411efa216b1d71e6e1362-20250303
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 956718363; Mon, 03 Mar 2025 17:44:15 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH 0/4] Optimize __vmalloc_node_range_noprof function.
Date: Mon,  3 Mar 2025 17:44:06 +0800
Message-Id: <20250303094410.437985-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dYP4fTQzFx29
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703823.2702@yPBPr1aOxTDpiusCloAPaQ
X-ITU-MailScanner-SpamCheck: not spam

The use of variables real_size and real_align in function=20
__vmalloc_node_range_noprof is unreadable. Optimize it in four patches.

Liu Ye (4):
  mm/vmalloc: Remove unnecessary size ALIGN in
    __vmalloc_node_range_noprof
  mm/vmalloc: Size should be used instead of real_size in
    __vmalloc_node_range_noprof
  mm/vmalloc: Remove the real_size variable to simplify the code in
    __vmalloc_node_range_noprof
  mm/vmalloc: Rename the variable real_align to original_align to
    prevent misunderstanding

 mm/vmalloc.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--=20
2.25.1



