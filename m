Return-Path: <linux-kernel+bounces-320515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B3970B72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C74281A62
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E71097B;
	Mon,  9 Sep 2024 01:45:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31E4A3C;
	Mon,  9 Sep 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846318; cv=none; b=JiJRTqAe4gs1dyyAojj9bBcXFIhvTpw00hxLQYkkzK+6FaEFbC1PUFVb8iPZnSvAcGj7eiUMhkeIWXSgcS0Bx5LEE5TYTf+EpOY50RY2Eo+twUj4Y/4TZnREdUrgiopzO//BRgG2+vANFSC5X+uIvEWF0b5au+45US/41mo5flU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846318; c=relaxed/simple;
	bh=+a6Be4S3xeBgg2YZiCzRhWMc5GDwehvdk/8vNlrHdic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EV9iB3wdyQANr36JfSdph9NhP6/D8onN//adreizpIh4kFkveR8m/bII03tP/02zapbM6KxViDenBt2dm4HibWV9dpNHG+Y6SJhthCfDdrkti1CEvt73E4MMoQV+UUCyPsKqqzwEdXNMmBhS3oaV9bXjXa+ktILPU95uP1g6Jpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2116cc4a6e4d11efa216b1d71e6e1362-20240909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:8dda0dab-a5cd-46eb-8f2b-21d70412469c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:2a627d5d7faf7d2c516b31f888c610e5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2116cc4a6e4d11efa216b1d71e6e1362-20240909
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 364132354; Mon, 09 Sep 2024 09:45:01 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id AB5C4B803C9D;
	Mon,  9 Sep 2024 09:45:01 +0800 (CST)
X-ns-mid: postfix-66DE531D-556247296
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node2.com.cn (NSMail) with ESMTPA id 99870B803C9D;
	Mon,  9 Sep 2024 01:45:00 +0000 (UTC)
From: zenghongling <zenghongling@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	zhongling0719@126.com,
	zenghongling <zenghongling@kylinos.cn>
Subject: [PATCH v2] ALSA: hda/cs8409: Support new Dell Dolphin for device
Date: Mon,  9 Sep 2024 09:44:57 +0800
Message-ID: <20240909014457.610682-1-zenghongling@kylinos.cn>
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
index 36b411d1..be0cc48 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -541,6 +541,7 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] =3D {
 	SND_PCI_QUIRK(0x1028, 0x0BBB, "Warlock MLK Dual Mic", CS8409_WARLOCK_ML=
K_DUAL_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0BBC, "Warlock MLK", CS8409_WARLOCK_MLK),
 	SND_PCI_QUIRK(0x1028, 0x0BBD, "Warlock MLK Dual Mic", CS8409_WARLOCK_ML=
K_DUAL_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0BAA, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0BD4, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0BD5, "Dolphin", CS8409_DOLPHIN),
 	SND_PCI_QUIRK(0x1028, 0x0BD6, "Dolphin", CS8409_DOLPHIN),
--=20
2.1.0


