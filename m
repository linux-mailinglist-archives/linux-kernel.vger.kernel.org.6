Return-Path: <linux-kernel+bounces-415254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D426E9D338C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF01284BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A3E545;
	Wed, 20 Nov 2024 06:30:43 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70013AA35;
	Wed, 20 Nov 2024 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084243; cv=none; b=TR6lQaFBujRuQWGCCWLsI/+TS2Km+Gg/jT2QvONztJIYO+k3ULg9omfvFuWgSg5VzUIna4gyb0r5z83YsI1Lol+2/pl+eDhpdm9SQBJyR+HyUyooX/SsfqwS+Y3P8kYPghIaVm+9XfzN5Q+8mb1hlBRZaIdV5dGaStxjzKonyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084243; c=relaxed/simple;
	bh=x4pF9P+dSwf3pf7DnLk4OH5H5h+ekvlJZgJzo+lB+wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVgIzdH8X3L8W93IdFq+PSFO1xUaPMN1rZuC1S20ktAIFWcdvgMx/9dg3Y4daaO/hhHBRyUmdE4njYRQn4Lz26DOKU2zekkV7JSaCH7gnQOvo3ek6Zrjm079wZXd74bgW/sbUQWjsDrohkQMTHy+NlZzPMkTj65+Nk5wABoyHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ee7adb9ca70811efa216b1d71e6e1362-20241120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:46847150-d6ab-475f-ba09-02a856bfa0b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.38,REQID:46847150-d6ab-475f-ba09-02a856bfa0b3,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:de267330cc945411189328a807ab337b,BulkI
	D:241120143027ZQFMHI9N,BulkQuantity:1,Recheck:0,SF:38|17|19|66|841|102,TC:
	nil,Content:0,EDM:5,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: ee7adb9ca70811efa216b1d71e6e1362-20241120
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2098635022; Wed, 20 Nov 2024 14:30:27 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com
Cc: broonie@kernel.org,
	arnd@arndb.de,
	xiaopeitux@foxmail.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] ALSA: ac97: bus: Fix the mistake in the comment
Date: Wed, 20 Nov 2024 14:30:19 +0800
Message-Id: <3990bfc8cd47637908eaa179802c1d91459d829b.1732083924.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3990bfc8cd47637908eaa179802c1d91459d829b.1732083924.git.xiaopei01@kylinos.cn>
References: <202411180804.FUfdymYO-lkp@intel.com>
 <3990bfc8cd47637908eaa179802c1d91459d829b.1732083924.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix mistake in the comment.
sound/ac97/bus.c:192: warning: Function parameter or member 'drv' not described in 'snd_ac97_codec_driver_register'
sound/ac97/bus.c:192: warning: Excess function parameter 'dev' description in 'snd_ac97_codec_driver_register'
sound/ac97/bus.c:205: warning: Function parameter or member 'drv' not described in 'snd_ac97_codec_driver_unregister'
sound/ac97/bus.c:205: warning: Excess function parameter 'dev' description in 'snd_ac97_codec_driver_unregister'
sound/ac97/bus.c:351: warning: Function parameter or member 'codecs_pdata' not described in 'snd_ac97_controller_register'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411180804.FUfdymYO-lkp@intel.com/
Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 sound/ac97/bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 96d4d7eb879f..8dfffdc101a2 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -180,7 +180,7 @@ static int ac97_bus_reset(struct ac97_controller *ac97_ctrl)
 
 /**
  * snd_ac97_codec_driver_register - register an AC97 codec driver
- * @dev: AC97 driver codec to register
+ * @drv: AC97 driver codec to register
  *
  * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
  * controller.
@@ -196,7 +196,7 @@ EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_register);
 
 /**
  * snd_ac97_codec_driver_unregister - unregister an AC97 codec driver
- * @dev: AC97 codec driver to unregister
+ * @drv: AC97 codec driver to unregister
  *
  * Unregister a previously registered ac97 codec driver.
  */
@@ -338,6 +338,7 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
  * @dev: the device providing the ac97 DC function
  * @slots_available: mask of the ac97 codecs that can be scanned and probed
  *                   bit0 => codec 0, bit1 => codec 1 ... bit 3 => codec 3
+ * @codecs_pdata: codec platform data
  *
  * Register a digital controller which can control up to 4 ac97 codecs. This is
  * the controller side of the AC97 AC-link, while the slave side are the codecs.
-- 
2.34.1


