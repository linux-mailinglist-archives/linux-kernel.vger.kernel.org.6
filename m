Return-Path: <linux-kernel+bounces-576414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAEA70EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D713BBE52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBD13AA31;
	Wed, 26 Mar 2025 02:20:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFAEEA9;
	Wed, 26 Mar 2025 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955642; cv=none; b=hVrb3DBcybriLmpa2SjkFVOCwRQR7KUcGjhO5evOeTPYYMPNzJ42LU0+coT2A0vJWNrnXj7iDP2a7CnjNkTZQUwGvArICXedyOzBJi8PgJ9DanpQEQSvDWRSrWjjQr35psIfzcVW9sNqQUG1xgBC6K045RPrP+PGMFJlLDzs6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955642; c=relaxed/simple;
	bh=Gd9ZdX7vXb/xGpvEuuY5fym5Nrk9/rQzhFroCZyhdHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AOnsLBSVnIIm5rjMEAwcONaTUF6FN8xwX6cBQwtRI/gizazRHYlJgUa0baaScvy+Xfoo6QjzrVgkawGZGMb+A5rREf4G9nksRd7dQ+/0FxJR4S1j6OSbY1VkcBnYeIiKoaItEwVqEXrFuVB56/J0igtKTxq6lVvNr8O/D+ePhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e10e9b7c09e811f0a216b1d71e6e1362-20250326
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:20e6d293-0125-4ee8-8d8d-b3dde439d568,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:20e6d293-0125-4ee8-8d8d-b3dde439d568,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
	lease,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:dd945ea749cb232eb412d347a8c5ed73,BulkI
	D:250326100250278RLHOF,BulkQuantity:1,Recheck:0,SF:19|38|66|72|78|102,TC:n
	il,Content:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-UUID: e10e9b7c09e811f0a216b1d71e6e1362-20250326
X-User: dengjie03@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 54479125; Wed, 26 Mar 2025 10:20:26 +0800
From: Jie Deng <dengjie03@kylinos.cn>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	xiehongyu1@kylinos.cn,
	Jie Deng <dengjie03@kylinos.cn>
Subject: [PATCH] usb-storage: apply IGNORE_UAS for Realtek on RTL9210
Date: Wed, 26 Mar 2025 10:20:19 +0800
Message-Id: <20250326022019.1593669-1-dengjie03@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UAS mode of Realtek USB_HDD is reported
to fail to work on several platforms with
the following error message, then after
re-connecting the device will be offlined
and not working at all.

[  143.361210] sd 9:0:0:0: [sdg]
tag#6 uas_eh_abort_handler 0 uas-tag 2 inflight: CMD IN
[  143.372377] sd 9:0:0:0: [sdg]
tag#6 CDB: Read(10) 28 00 00 00 00 10 00 00 10 00
[  143.382908] sd 9:0:0:0: [sdg]
tag#5 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
[  143.394080] sd 9:0:0:0: [sdg]
tag#5 CDB: Read(10) 28 00 00 00 00 00 00 00 10 00
[  143.404610] sd 9:0:0:0: [sdg]
tag#4 uas_eh_abort_handler 0 uas-tag 4 inflight: CMD IN
[  143.415782] sd 9:0:0:0: [sdg]
tag#4 CDB: Read(10) 28 00 00 00 00 30 00 00 10 00
[  148.437916][ 22] xhci_hcd 0000:ba:02.0:
xHCI host not responding to stop endpoint command.
[  148.462295][ 22] xhci_hcd 0000:ba:02.0:
xHCI host controller not responding, assume dead

The Realtek Manufacturer's device cannot
initialize properly using the UAS driver,
so we need to switch it to usb-storage

Signed-off-by: Jie Deng <dengjie03@kylinos.cn>
---
 drivers/usb/storage/uas-detect.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/uas-detect.h b/drivers/usb/storage/uas-detect.h
index 4d3b49e5b87a..23579a2a1181 100644
--- a/drivers/usb/storage/uas-detect.h
+++ b/drivers/usb/storage/uas-detect.h
@@ -125,8 +125,11 @@ static int uas_use_uas_driver(struct usb_interface *intf,
 	 */
 	if (le16_to_cpu(udev->descriptor.idVendor) == 0x0bda &&
 			le16_to_cpu(udev->descriptor.idProduct) == 0x9210 &&
-			(udev->manufacturer && !strcmp(udev->manufacturer, "HIKSEMI")) &&
-			(udev->product && !strcmp(udev->product, "MD202")))
+			(((udev->manufacturer && !strcmp(udev->manufacturer, "HIKSEMI")) &&
+			(udev->product && !strcmp(udev->product, "MD202"))) ||
+			((udev->manufacturer && !strcmp(udev->manufacturer, "Realtek")) &&
+			(udev->product && !strcmp(udev->product, "RTL9210")))
+			))
 		flags |= US_FL_IGNORE_UAS;
 
 	usb_stor_adjust_quirks(udev, &flags);
-- 
2.25.1


