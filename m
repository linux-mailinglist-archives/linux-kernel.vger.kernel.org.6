Return-Path: <linux-kernel+bounces-290646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D707F9556D0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA931F22285
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF53C1487DC;
	Sat, 17 Aug 2024 09:38:18 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C7881E;
	Sat, 17 Aug 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887498; cv=none; b=skJjBAW0dqOpUvnP3MP7wLFevfWFlVUAqV/FSAwG71jPkkSIGNXUqMdiZWfJbM7DjzXIESedbUdkptj1wo1sfvWwE7xF+d9LV8nzoM+Xrv+DS9ocqai2UfW9EbJ/v4Cwlo9gPFWJWT/OjAVbk39MmleOSdXHwlaAo6iyvqrNprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887498; c=relaxed/simple;
	bh=4LZBxysOt7p5mfbtXH+sIKwMGMV4pKHPmn22fhN6098=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NjZphulRuX5rQWmh9OKyieryhogwTrtGI4jBqLNh5b9DD9/5l6aZEtKn3W8tgIGBUTgRnvgJnWbwtmBt6JSyAOi714utPRwWhv8RA/uscXbXwdyRthq4ecuwpvgJaZWkgxesI44zPXRd6JCvv3gMH8cAjoKkzLv8bXmL8rAejYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WmDF96FtHz20lqF;
	Sat, 17 Aug 2024 17:33:33 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B6B3140154;
	Sat, 17 Aug 2024 17:38:11 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 17 Aug
 2024 17:38:10 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ALSA: trident: Remove unused declarations
Date: Sat, 17 Aug 2024 17:35:27 +0800
Message-ID: <20240817093527.1120240-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 8bb8b453cb45 ("[ALSA] trident - clean up obsolete synth codes")
remove synth functions but leave declarations.
And Commit e5723b41abe5 ("[ALSA] Remove sequencer instrument layer")
left snd_trident_attach_synthesizer().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 sound/pci/trident/trident.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/trident/trident.h b/sound/pci/trident/trident.h
index 9768a7fc2349..ed2d4eecc704 100644
--- a/sound/pci/trident/trident.h
+++ b/sound/pci/trident/trident.h
@@ -406,7 +406,6 @@ int snd_trident_create_gameport(struct snd_trident *trident);
 int snd_trident_pcm(struct snd_trident *trident, int device);
 int snd_trident_foldback_pcm(struct snd_trident *trident, int device);
 int snd_trident_spdif_pcm(struct snd_trident *trident, int device);
-int snd_trident_attach_synthesizer(struct snd_trident * trident);
 struct snd_trident_voice *snd_trident_alloc_voice(struct snd_trident * trident, int type,
 					     int client, int port);
 void snd_trident_free_voice(struct snd_trident * trident, struct snd_trident_voice *voice);
@@ -419,9 +418,5 @@ extern const struct dev_pm_ops snd_trident_pm;
 struct snd_util_memblk *snd_trident_alloc_pages(struct snd_trident *trident,
 						struct snd_pcm_substream *substream);
 int snd_trident_free_pages(struct snd_trident *trident, struct snd_util_memblk *blk);
-struct snd_util_memblk *snd_trident_synth_alloc(struct snd_trident *trident, unsigned int size);
-int snd_trident_synth_free(struct snd_trident *trident, struct snd_util_memblk *blk);
-int snd_trident_synth_copy_from_user(struct snd_trident *trident, struct snd_util_memblk *blk,
-				     int offset, const char __user *data, int size);
 
 #endif /* __SOUND_TRIDENT_H */
-- 
2.34.1


