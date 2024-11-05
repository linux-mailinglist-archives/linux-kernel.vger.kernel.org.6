Return-Path: <linux-kernel+bounces-396227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565F9BC990
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05F81F23ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD6F1D0784;
	Tue,  5 Nov 2024 09:50:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF6163
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800234; cv=none; b=iVUw65amEyGjmfSVFDaRgCrSMiYvqilao9hxtHE1nxEEO22T5uy1GDSalNwL3LHBjq4o/ZoNdTOm18ms+uosA3EZ2ahpz1eOyoCeTDMyaRhcgK1Rd6YSbb1VePinHCRYlWATgBQsPwGR7OKJN2mJ61p0TqfC2StZpM5d/NRXvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800234; c=relaxed/simple;
	bh=m/Ix/B5cYcaGR0H8bw0CtJiYweqhPKvHLj5gVJf36CM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JF+sTK6pOJLn7yRjXL+vMDEr4zDReRqdH7zqQoWlqEKDgRORAwWS1K6z4mP56jCJzzbNzHfrftYqfQqPcHi508o2nN4q3Ccnnl8prqSlm41n5wKO9jdiCQEhAbceRvvgNcvm3IwIz7Dmgy5UPX5jOGNYz+Eb8RqeGyvsvbRCzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5bf9f1769b5b11efa216b1d71e6e1362-20241105
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	DN_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED
	SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6e3c4b8d-f751-4922-af94-fd9f1ced5b1b,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.38,REQID:6e3c4b8d-f751-4922-af94-fd9f1ced5b1b,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:a17ae252df21acc5267abab62b9334a4,BulkI
	D:2411051750188MZ4VDPY,BulkQuantity:0,Recheck:0,SF:24|72|19|44|66|841|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 5bf9f1769b5b11efa216b1d71e6e1362-20241105
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1526205533; Tue, 05 Nov 2024 17:50:15 +0800
From: zhangguopeng <zhangguopeng@kylinos.cn>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: daniel.lezcano@linaro.org,
	festevam@denx.de,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	zhangguopeng <zhangguopeng@kylinos.cn>
Subject: [PATCH] kernel/reboot: replace sprintf() with sysfs_emit()
Date: Tue,  5 Nov 2024 17:49:41 +0800
Message-Id: <20241105094941.33739-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Documentation/filesystems/sysfs.rst suggested, show() should only use
sysfs_emit() or sysfs_emit_at() when formatting the value to be returned
to user space.

No functional change intended.

Signed-off-by: zhangguopeng <zhangguopeng@kylinos.cn>
---
 kernel/reboot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ffdf86b717ab..a701000bab34 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1137,7 +1137,7 @@ static ssize_t mode_show(struct kobject *kobj, struct kobj_attribute *attr, char
 		val = REBOOT_UNDEFINED_STR;
 	}
 
-	return sprintf(buf, "%s\n", val);
+	return sysfs_emit(buf, "%s\n", val);
 }
 static ssize_t mode_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t count)
@@ -1167,7 +1167,7 @@ static struct kobj_attribute reboot_mode_attr = __ATTR_RW(mode);
 #ifdef CONFIG_X86
 static ssize_t force_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", reboot_force);
+	return sysfs_emit(buf, "%d\n", reboot_force);
 }
 static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t count)
@@ -1214,7 +1214,7 @@ static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char
 		val = REBOOT_UNDEFINED_STR;
 	}
 
-	return sprintf(buf, "%s\n", val);
+	return sysfs_emit(buf, "%s\n", val);
 }
 static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t count)
@@ -1247,7 +1247,7 @@ static struct kobj_attribute reboot_type_attr = __ATTR_RW(type);
 #ifdef CONFIG_SMP
 static ssize_t cpu_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", reboot_cpu);
+	return sysfs_emit(buf, "%d\n", reboot_cpu);
 }
 static ssize_t cpu_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t count)
-- 
2.25.1


