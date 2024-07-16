Return-Path: <linux-kernel+bounces-253282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2952931F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED461C2168F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0EC8E1;
	Tue, 16 Jul 2024 02:56:03 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886916AD7;
	Tue, 16 Jul 2024 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098563; cv=none; b=MFmv7GHfeKxL1k1yNOv7sg098gJl6RWFc7fX3aKfn24TfSzmoRD+6d3wYt3nXIszUvjMJs9UHCMezdYT9F7Cg1X0jmX8E3E7D+TFpkW67yYkmonB/ngW6CMN3CPPF5VYHRwhaViMvLFDFX15OdnbJ3kpxqf9p9BLY+mvC/ck+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098563; c=relaxed/simple;
	bh=A4sasep0wgFY/nol468aE8wUMXdmRa4J6+Hyubp4gQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RtFTjetJa3SOJGyH2h6XH9vUsQ3V67XycHUcA04bglj8k1wUq+m/rr93IbH4zqWYLEyAWCbZA6UqCjpZHuJ89UvUxwwoVhK2WidgkOldZxmVoRGd6FHyXPOgADdWsXqwNtOKd9JafUQZqa/37Ity8hy6o6rqZg/NqMuQaiOTrmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADX37cv4ZVm2umMAw--.46434S2;
	Tue, 16 Jul 2024 10:55:43 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.intel.com,
	sbinding@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: cs42l42: Convert comma to semicolon
Date: Tue, 16 Jul 2024 10:53:07 +0800
Message-Id: <20240716025307.400156-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX37cv4ZVm2umMAw--.46434S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Jw4UZF15Wry8AF4rXF4UCFg_yoW8JF1fpa
	1q9a95Z3yfJw47Z3sYyr1DW3W8GFWjka17Ary7Ga90ywnIqF9YqF1xAFsrJF9xJFyjkFZx
	XFyaqr45Crn0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbZ2-5UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: 90f6a2a20bd2 ("ASoC: cs42l42: Add SoundWire support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/codecs/cs42l42-sdw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
index 94a66a325303..29891c1f6bec 100644
--- a/sound/soc/codecs/cs42l42-sdw.c
+++ b/sound/soc/codecs/cs42l42-sdw.c
@@ -323,15 +323,15 @@ static int cs42l42_sdw_read_prop(struct sdw_slave *peripheral)
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 
 	/* DP1 - capture */
-	ports[0].num = CS42L42_SDW_CAPTURE_PORT,
-	ports[0].type = SDW_DPN_FULL,
-	ports[0].ch_prep_timeout = 10,
+	ports[0].num = CS42L42_SDW_CAPTURE_PORT;
+	ports[0].type = SDW_DPN_FULL;
+	ports[0].ch_prep_timeout = 10;
 	prop->src_dpn_prop = &ports[0];
 
 	/* DP2 - playback */
-	ports[1].num = CS42L42_SDW_PLAYBACK_PORT,
-	ports[1].type = SDW_DPN_FULL,
-	ports[1].ch_prep_timeout = 10,
+	ports[1].num = CS42L42_SDW_PLAYBACK_PORT;
+	ports[1].type = SDW_DPN_FULL;
+	ports[1].ch_prep_timeout = 10;
 	prop->sink_dpn_prop = &ports[1];
 
 	return 0;
-- 
2.25.1


