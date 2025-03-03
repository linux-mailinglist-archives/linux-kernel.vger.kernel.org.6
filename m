Return-Path: <linux-kernel+bounces-544445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE51A4E140
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E6717778F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7E9254AEF;
	Tue,  4 Mar 2025 14:33:14 +0000 (UTC)
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF20253F0D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098793; cv=fail; b=cpEyylaDUlZPrAHwm96Z+FdDQ9G5SLTUeos6kYuD/kJXe5oASI3cVQmswwtHmo42BGtgu/rCZC3HxVTup28C02Pdiryc+3TItqWTj3M1E28DXslsU0yysc3qJnoqceqP57WplULFogGhmq9XRgwJQwFxVU5EK9Hqjm6B2O2bHx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098793; c=relaxed/simple;
	bh=MFVz2CNzGOIq3xmPYiSsmtjamzHJkuW5MrkMsn95G8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTLB27YpWG3OW9xHTv505EfSOz0CE42nYXb1il64ELZ7miybOUaTqYCZRPOxxClSjiV+IeKY4T68mCNCdYGFKeHihiYnNVFPMGz6Mb+xhxNkV9VQZ0cU/ttS+izwadUqWwiFV7WKEc33LF2Tl7z7aIc55ECzEA9E8tutXAv6Rp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=124.126.103.232; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 088FE40D00D2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:33:09 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dRC4D9jzFwsy
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:31:35 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D56B142726; Tue,  4 Mar 2025 17:31:23 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541295-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 19EEE4294D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:45:18 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id E3C992DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:45:17 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96D31892B1D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C0C1F2B8B;
	Mon,  3 Mar 2025 09:44:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B441F0E4B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995066; cv=none; b=BqlBHmY5I5TD2OD6htlXYvPUR3+0gFuO1jl+qBKLYDWjAXsxYyjXZhpOxOcaH7gr3KUgKIOfffWwk56qSwhL5ZCPBRC88KqcdjGLO8PUEbfbO/8swxLrZpnJ7LdBWhZJ/8n9hneXVQA9mrYL8qt4J5SzPezOTck9jR++wfBlfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995066; c=relaxed/simple;
	bh=+XSsamOTQEQcCb+/kENBt2T0PIW2kJOQLD1ZnP+CGyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XLar0jS4J2qCeqafNXGnUu9RS+N3FgCdzDY1GsvFPTju4yheq9lNNT7geEJbKD51Ay1TNMFzkeWAVckjA4t79LVhH+BjMFxAeKqMErIHHlJoED53KUb3bskHtPQTS4tklGgohcPZKqWW2WRsxBikzQBbaFZ9BMIh4gOZBhSjHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1414a804f81411efa216b1d71e6e1362-20250303
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
X-CID-O-INFO: VERSION:1.1.45,REQID:6b2933d0-3783-4a12-99a9-67185eebebbc,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:6b2933d0-3783-4a12-99a9-67185eebebbc,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:9825fa440eeca6b013ca017a2ce8db47,BulkI
	D:250303172846P4IK2XY7,BulkQuantity:2,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1414a804f81411efa216b1d71e6e1362-20250303
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1860039833; Mon, 03 Mar 2025 17:44:19 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH 4/4] mm/vmalloc: Rename the variable real_align to original_align to prevent misunderstanding
Date: Mon,  3 Mar 2025 17:44:10 +0800
Message-Id: <20250303094410.437985-5-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303094410.437985-1-liuye@kylinos.cn>
References: <20250303094410.437985-1-liuye@kylinos.cn>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dRC4D9jzFwsy
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703496.26467@5pAQXtBmdz1vNsQAmFvHGQ
X-ITU-MailScanner-SpamCheck: not spam

The real prefix is generally used to indicate the adjusted value of a
parameter, but according to the code logic, it should indicate the
original value, so it is recommended to rename it to original_align.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 mm/vmalloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b4d2010e5105..a8488452b70b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3770,7 +3770,7 @@ void *__vmalloc_node_range_noprof(unsigned long siz=
e, unsigned long align,
 	struct vm_struct *area;
 	void *ret;
 	kasan_vmalloc_flags_t kasan_flags =3D KASAN_VMALLOC_NONE;
-	unsigned long real_align =3D align;
+	unsigned long original_align =3D align;
 	unsigned int shift =3D PAGE_SHIFT;
=20
 	if (WARN_ON_ONCE(!size))
@@ -3796,7 +3796,7 @@ void *__vmalloc_node_range_noprof(unsigned long siz=
e, unsigned long align,
 		else
 			shift =3D arch_vmap_pte_supported_shift(size);
=20
-		align =3D max(real_align, 1UL << shift);
+		align =3D max(original_align, 1UL << shift);
 	}
=20
 again:
@@ -3876,7 +3876,7 @@ void *__vmalloc_node_range_noprof(unsigned long siz=
e, unsigned long align,
 fail:
 	if (shift > PAGE_SHIFT) {
 		shift =3D PAGE_SHIFT;
-		align =3D real_align;
+		align =3D original_align;
 		goto again;
 	}
=20
--=20
2.25.1



