Return-Path: <linux-kernel+bounces-545139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22323A4E981
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F914421459
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452182980CD;
	Tue,  4 Mar 2025 17:12:08 +0000 (UTC)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EA26657B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108327; cv=fail; b=UIpV0i+z0jq4rIBSFjtmNMNqURwBTRZGXX2kW3hYrz+h8n/36wjtlArHMWkfYpWvzxci5OP+SLsbLJ9b70vOnU3EICXWUmxvflHf6PqSxCd3mBXZjYA1n66m97DeumC7xqCVr0akHspOnzs3D7Nmn9xoku7PL6J98W5xvP2JcKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108327; c=relaxed/simple;
	bh=ltBhOk9Y5xN4dspAXIvFss7sdrpf1lMFHOKjV3NuWeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aR1jzaofT78RlhwCJvZW6JGIN9ZbFJ5RleK/gb7XTJ2riIOIBFkq46p2OVC9masvoOlufojsiMotfBer3M5cTxVrLSC+9Oe6xvSjikKpkFt4T6U8jynOBVBwI5iuGRxJypc33/TMIQ0tU7kZbbsmLAJIACY+sPx+9u0IrveL3gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=124.126.103.232; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 9575240D570A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:12:03 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g8B712GzG1SN
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:48:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 1B37742734; Tue,  4 Mar 2025 18:48:34 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541297-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 9570041ADE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:45:25 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 4B9C93064C0B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:45:25 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAAE170FB9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D21F30DD;
	Mon,  3 Mar 2025 09:44:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3591F0E50
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995067; cv=none; b=Ne/9AMe/bZk8bTkas5Iq+tQH5a8X0StQFQdBII1KSOP8d8+wAr444pNrC+45GVMjlNzru4++n1hJDaGMn5IbF46H0RAD/C/4qoLtW0RPxK3kjINPkXYLwhMNRtdGTtiI4Lqekk4pUJdhKvL/KtFsn6CkMpYMsXMpiggejoPwims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995067; c=relaxed/simple;
	bh=YI01+IEJet/MxoYaPsQ1OyLXLV2hr0fROikgH+VyV1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMN/DKkdy8kYrXX184qG9uLPAxLZZJ1VJr6BYG7l9+0I/sqL4+cwgSrT1YMQDuZw3OXQiygZwYm1+oXGRrg0NhdPyYANLKNqn7gIBw3G6QqTRX2friLMG4B2Qyf9hupwtshrGZZcn6/xgMY1g/GGGgGqf5BtyNllLbMIjKZqhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1304a892f81411efa216b1d71e6e1362-20250303
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
X-CID-O-INFO: VERSION:1.1.45,REQID:640f4a1d-b6e1-4b54-99b6-4f59c703312a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:640f4a1d-b6e1-4b54-99b6-4f59c703312a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:b8ca024c1d5b539e7fd0599ac9ff1127,BulkI
	D:250303172843XSIG1O9W,BulkQuantity:2,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 1304a892f81411efa216b1d71e6e1362-20250303
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1306028357; Mon, 03 Mar 2025 17:44:17 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH 2/4] mm/vmalloc: Size should be used instead of real_size in __vmalloc_node_range_noprof
Date: Mon,  3 Mar 2025 17:44:08 +0800
Message-Id: <20250303094410.437985-3-liuye@kylinos.cn>
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
X-ITU-Libra-ESVA-ID: 4Z6g8B712GzG1SN
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713012.40836@GJNgamW9hwiGiLOTaXFUXA
X-ITU-MailScanner-SpamCheck: not spam

According to the logic of the code, this should be size instead of
real_size. Although there is no functional problem at present,
it is recommended to modify it to enhance readability.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 20d9b9de84b1..e311ee33f9ef 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3801,7 +3801,7 @@ void *__vmalloc_node_range_noprof(unsigned long siz=
e, unsigned long align,
 	}
=20
 again:
-	area =3D __get_vm_area_node(real_size, align, shift, VM_ALLOC |
+	area =3D __get_vm_area_node(size, align, shift, VM_ALLOC |
 				  VM_UNINITIALIZED | vm_flags, start, end, node,
 				  gfp_mask, caller);
 	if (!area) {
--=20
2.25.1



