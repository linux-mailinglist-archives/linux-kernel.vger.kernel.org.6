Return-Path: <linux-kernel+bounces-289463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A987C95467B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519061F225D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3C172BDE;
	Fri, 16 Aug 2024 10:04:52 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013716FF48;
	Fri, 16 Aug 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802691; cv=none; b=g1Hs4cqRDWCKDtEixtqVCsxNFm4Wk8dNRfGPYUZrDcsIkcQgNPyb0x1/okw80kwbcy4kF1rsTYWhrnWl/kAv7iOq3FC6Xc17jsj0wbxBu30rC67qtgHDyAKJpJUL6ckHJ4sg1YhXqxwuE8hRU4yV/Refw6EpmL0lad5lLirE2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802691; c=relaxed/simple;
	bh=NMAt0wOpD4QyPehcCBFQx25apbaun2IetC1sk1G/GUo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CN+ZqtOLvzVPjItwXXfLPwVSTlFC8URmLngJX7jxRpKT2y8CDRc06mjFP+8/pUwQvSBRmqTs7UDSjvHToWbLFUnGoX5E7G2vV9qYtY39VXJ5mZwE0YdzZiTLc847syrI5mmSfv4zhzgJ4244TAi1PklLDjL4jYd9o4fBgqpLfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wlcsz3C6Jz2Cmjq;
	Fri, 16 Aug 2024 17:59:51 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 019171A016C;
	Fri, 16 Aug 2024 18:04:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:04:45 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ALSA: oss: Remove unused declarations
Date: Fri, 16 Aug 2024 18:02:09 +0800
Message-ID: <20240816100209.879043-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

These functions is never implemented and used.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 sound/core/oss/pcm_plugin.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
index 55035dbf23f0..7b76cf64157e 100644
--- a/sound/core/oss/pcm_plugin.h
+++ b/sound/core/oss/pcm_plugin.h
@@ -74,7 +74,6 @@ int snd_pcm_plugin_build(struct snd_pcm_substream *handle,
                          size_t extra,
                          struct snd_pcm_plugin **ret);
 int snd_pcm_plugin_free(struct snd_pcm_plugin *plugin);
-int snd_pcm_plugin_clear(struct snd_pcm_plugin **first);
 int snd_pcm_plug_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t frames);
 snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size);
 snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size);
@@ -139,8 +138,6 @@ int snd_pcm_area_copy(const struct snd_pcm_channel_area *src_channel,
 		      size_t dst_offset,
 		      size_t samples, snd_pcm_format_t format);
 
-void *snd_pcm_plug_buf_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t size);
-void snd_pcm_plug_buf_unlock(struct snd_pcm_substream *plug, void *ptr);
 #else
 
 static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
-- 
2.34.1


