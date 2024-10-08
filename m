Return-Path: <linux-kernel+bounces-354525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1C993EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDC4281EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A1166F3D;
	Tue,  8 Oct 2024 06:14:07 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DF13D52B;
	Tue,  8 Oct 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368046; cv=none; b=RVqFsO0cN9D7gi6OpgPtXb2QpQQrqOez0+96sUjyIVSJ8fAyQeYMFAIMMwQ8ZPmDCKLuig+2F8AwFFLT2cZF4BSo+W47V91OsVK3enGbI2G8STYDzG3BPRQhk4hyC4JzPtlNUUS0ZABvxzaBAP8by2onyZBgSvy1q7c0EZbkNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368046; c=relaxed/simple;
	bh=0S3nBWrFpEzQWp0w/N+cTcKJdl4qLDr2PmM9Owe4ixg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rur2SJKvsoziDr1lQB0m3iik1z4eJzMUV2GI+v+bgCNKyJhFzPdl7vV9YLAu9YpdwidlPI4+RMolqW33LIy50kdk3/TcTfGjysDtNaBs+MggK2Xqo37W4pVt+3X/qRBP2xNLJSlteKtAZjhLVOuHHjRLg+Nzyptj3+bx8ynViUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36704cda60b3-af8c3;
	Tue, 08 Oct 2024 14:13:59 +0800 (CST)
X-RM-TRANSID:2ee36704cda60b3-af8c3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26704cda6c40-96abe;
	Tue, 08 Oct 2024 14:13:59 +0800 (CST)
X-RM-TRANSID:2ee26704cda6c40-96abe
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	zhujun2@cmss.chinamobile.com,
	duoming@zju.edu.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sound:aica:Remove unused variable
Date: Mon,  7 Oct 2024 23:13:57 -0700
Message-Id: <20241008061357.12042-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The variable is never referenced in the code, just remove it

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/sh/aica.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 936cd6e91529..66b33623549f 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -315,8 +315,6 @@ static void aica_period_elapsed(struct timer_list *t)
 static void spu_begin_dma(struct snd_pcm_substream *substream)
 {
 	struct snd_card_aica *dreamcastcard;
-	struct snd_pcm_runtime *runtime;
-	runtime = substream->runtime;
 	dreamcastcard = substream->pcm->private_data;
 	/*get the queue to do the work */
 	schedule_work(&(dreamcastcard->spu_dma_work));
-- 
2.17.1




