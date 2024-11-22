Return-Path: <linux-kernel+bounces-418023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819CD9D5BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4693728219B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9541D88D1;
	Fri, 22 Nov 2024 09:29:12 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EF1D47A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267752; cv=none; b=Oy0QP8e+nrO2OSLZ5l5onyS5C1WF62ebnrAu0l7JA/vkqLbi2ss4VaOOaRFVUbIShPmW47H/cxMW6cfs8qNLF2ZZcPS7oG4QxkbuL8AdIWkd7TeEJReJdmvt3Qjf7SpSGNwU9QbCkjpNmIXfR96a4rYQXbRATFcSovHL58s4Jpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267752; c=relaxed/simple;
	bh=VjR/w5HQyOyqCUeFRwUvpo8VsC91Isa5gXh7Yksg95E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Yxu1VCc9tPJ/7nskFebOB7LHPAbMw8C+AHxwLzPUbZI655YaGPVjQhIZb3zAsP4VCm5c36L9VwCydxwU0MTes4tyBXs2qm7kd96CzmoX5kG4eIQTHklBNmYfOkgzu8Gy6+F/V70jCp2kJGcPpOl+lXsFgAPrmQP1eXJLyXisqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 363e8f08a8b411efa216b1d71e6e1362-20241122
X-CTIC-Tags:
	HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP
	DN_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a37141d4-185a-4478-8dd5-a709db39fdd6,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:63
X-CID-INFO: VERSION:1.1.38,REQID:a37141d4-185a-4478-8dd5-a709db39fdd6,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:18,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
	ON:quarantine,TS:63
X-CID-META: VersionHash:82c5f88,CLOUDID:31e71d4d61855c1377ffcc828ed128db,BulkI
	D:241122172903BPJA7191,BulkQuantity:0,Recheck:0,SF:16|19|23|38|43|66|74,TC
	:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD
X-UUID: 363e8f08a8b411efa216b1d71e6e1362-20241122
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(111.48.69.246)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1678279502; Fri, 22 Nov 2024 17:29:02 +0800
From: Minhong He <heminhong@kylinos.cn>
To: heminhong@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: prevent resource leak
Date: Fri, 22 Nov 2024 17:28:30 +0800
Message-Id: <20241122092830.91079-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the main() function, the fopen() is used to open the file.
When the file is successfully opened, not using fclose() to close the file.
It will cause memory leak or file corruption.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 scripts/insert-sys-cert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c2342..dcd1902b495e 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -361,6 +361,7 @@ int main(int argc, char **argv)
 		get_symbol_from_map(hdr, system_map, USED_SYM, &used_sym);
 		get_symbol_from_map(hdr, system_map, LSIZE_SYM, &lsize_sym);
 		cert_sym.size = used_sym.address - cert_sym.address;
+		fclose(system_map);
 	} else {
 		info("Symbol table found.\n");
 		if (system_map_file)
-- 
2.25.1


