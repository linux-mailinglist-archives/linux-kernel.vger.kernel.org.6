Return-Path: <linux-kernel+bounces-318524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F296EF29
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D11B2815A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3571A1C7B9D;
	Fri,  6 Sep 2024 09:27:45 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5EF1C7B94;
	Fri,  6 Sep 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614864; cv=none; b=EANDmCPsbagR1e61QEEXTd7ohrCtfiMG747XdOafAR/c6gnX0Bzm69+rpi9uW+EWawZVSrcssApbDiaCHuexd/o9sC9l03XDTbA3/3QezH7e975YKk1ycCswC8daq9Ihlfkc9oKrB3XUdR7cbrqSGGrzhMU5i6hgaXbKLYcoq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614864; c=relaxed/simple;
	bh=hSgLbdVySfl4Q6f8eJEadZzN87CI9P4mpBAqv75zD6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idsgedAl48m73VtoVRQYvKqgm7vlrcgbRjJ2rnkdaXW1eOl5MJLyGzR3pmCY0JitUCCDV3qvo7SuH/SE+7IsSZaIYT4wWTMOzqZ0VylcGNbk6msR6/lU54TefQ1s2qOUdYbpof7OazUPYWdv+Rk3+OMKMK/ZdtlhTzbJxCPYEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3adb8d866c3211efa216b1d71e6e1362-20240906
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b028dc87-11cf-4581-ae29-bfdb57adfd4d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:1a3dffae82510f9c76cde797f2b905e8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3adb8d866c3211efa216b1d71e6e1362-20240906
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 761202791; Fri, 06 Sep 2024 17:27:26 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 27A40B80758A;
	Fri,  6 Sep 2024 17:27:26 +0800 (CST)
X-ns-mid: postfix-66DACAFE-17534928
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node2.com.cn (NSMail) with ESMTPA id 01340B80758A;
	Fri,  6 Sep 2024 09:27:19 +0000 (UTC)
From: zenghongling <zenghongling@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	zhongling0719@126.com,
	zenghongling <zenghongling@kylinos.cn>
Subject: [PATCH] ALSA: hda/cs8409: Support new Dell Dolphin for device
Date: Fri,  6 Sep 2024 17:27:03 +0800
Message-ID: <20240906092703.1303605-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add 1 new Dell Dolphin Systems, same configuration as older systems.

Signed-off-by: zenghongling <zenghongling@kylinos.cn>
---
 sound/pci/hda/patch_cs8409-tables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs=
8409-tables.c
index 36b411d1..bc14b18 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -546,6 +546,7 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] =3D {
 	SND_PCI_QUIRK(0x1028, 0x0BD6, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0BD7, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0BD8, "Dolphin", CS8409_DOLPHIN),
+	SND_PCI_QUIRK(0x1028, 0x0BAA, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0C43, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0C50, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0C51, "Dolphin", CS8409_DOLPHIN),
--=20
2.1.0


