Return-Path: <linux-kernel+bounces-272429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F5945BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82E51F22862
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA07D1DB450;
	Fri,  2 Aug 2024 10:12:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54282134B6;
	Fri,  2 Aug 2024 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722593569; cv=none; b=mPOVcSJc09d0JVUqeJjokGgB3XPVBPwOooAka92+Tj8B/jz3iSfLfDOzR0KRSmMzjSQyM2LlDFiFSUT+mGrz0/t9qtkk7O2tQWhCkjFRku1L318m5ncfOtjJmsjpnki64p489uNo/zPrt4DUPlqs9xCPgdMujosjaWE/riFpRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722593569; c=relaxed/simple;
	bh=GJ6YXFu2+K8t2pLjzgjjVxGLhJLL/2uUOaQIag8CUIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IDfsRmqVY2a6GbRnAumkTL+F7012NtIMz/iVuBeo1vm8pqt6uv0xGNcop8gXPXC7MLPjcJrjlLYc1fxWPEbtcmmasqcykWB1jab203Ix+v4zlmAa21fZonP9Xsr+Y/Faa1F+rY5Wqvb9C716atkgh0S84sFROrhqT46W9mI4ZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wb1q23pTwzxVrb;
	Fri,  2 Aug 2024 18:12:30 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B5F0618005F;
	Fri,  2 Aug 2024 18:12:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 2 Aug
 2024 18:12:44 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jonathan.downing@nautel.com>, <piotr.wojtaszczyk@timesys.com>,
	<vz@mleia.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
CC: <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: fsl: lpc3xxx: Make some symbols static
Date: Fri, 2 Aug 2024 18:10:44 +0800
Message-ID: <20240802101044.3302251-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

These symbols are not used outside of the files, make them static to fix
sparse warnings:

sound/soc/fsl/lpc3xxx-i2s.c:261:30: warning: symbol 'lpc3xxx_i2s_dai_ops' was not declared. Should it be static?
sound/soc/fsl/lpc3xxx-i2s.c:271:27: warning: symbol 'lpc3xxx_i2s_dai_driver' was not declared. Should it be static?
sound/soc/fsl/lpc3xxx-pcm.c:55:39: warning: symbol 'lpc3xxx_soc_platform_driver' was not declared. Should it be static?

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 sound/soc/fsl/lpc3xxx-i2s.c | 4 ++--
 sound/soc/fsl/lpc3xxx-pcm.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/lpc3xxx-i2s.c b/sound/soc/fsl/lpc3xxx-i2s.c
index 62ef624d6dd4..bdb320bb3719 100644
--- a/sound/soc/fsl/lpc3xxx-i2s.c
+++ b/sound/soc/fsl/lpc3xxx-i2s.c
@@ -258,7 +258,7 @@ static int lpc3xxx_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-const struct snd_soc_dai_ops lpc3xxx_i2s_dai_ops = {
+static const struct snd_soc_dai_ops lpc3xxx_i2s_dai_ops = {
 	.probe	= lpc3xxx_i2s_dai_probe,
 	.startup = lpc3xxx_i2s_startup,
 	.shutdown = lpc3xxx_i2s_shutdown,
@@ -268,7 +268,7 @@ const struct snd_soc_dai_ops lpc3xxx_i2s_dai_ops = {
 	.set_fmt = lpc3xxx_i2s_set_dai_fmt,
 };
 
-struct snd_soc_dai_driver lpc3xxx_i2s_dai_driver = {
+static struct snd_soc_dai_driver lpc3xxx_i2s_dai_driver = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
diff --git a/sound/soc/fsl/lpc3xxx-pcm.c b/sound/soc/fsl/lpc3xxx-pcm.c
index c0d499b9b8ba..e6abaf63895a 100644
--- a/sound/soc/fsl/lpc3xxx-pcm.c
+++ b/sound/soc/fsl/lpc3xxx-pcm.c
@@ -52,7 +52,7 @@ static const struct snd_dmaengine_pcm_config lpc3xxx_dmaengine_pcm_config = {
 	.prealloc_buffer_size = 128 * 1024,
 };
 
-const struct snd_soc_component_driver lpc3xxx_soc_platform_driver = {
+static const struct snd_soc_component_driver lpc3xxx_soc_platform_driver = {
 	.name = "lpc32xx-pcm",
 };
 
-- 
2.34.1


