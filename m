Return-Path: <linux-kernel+bounces-320395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E59709A8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD07D1C20AF0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247F178CDE;
	Sun,  8 Sep 2024 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZBMt+B8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8DF9EC;
	Sun,  8 Sep 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725826681; cv=none; b=pDlllKLxuzxTwjiEFObmaVR4iiT5yvaaPXfCZAZdZ6Zx6VPQIOlH4sh9hTJtxJSFZ0dcS+ZFfReO/+YFKqRP3473HeMpiHdHSS2WG8Jnv1JLZEqCo4yc0+dubmY2gF9xi+SWgr/fqFbeIvZOtFfQm1CGBe/ogmisQslvGmIiF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725826681; c=relaxed/simple;
	bh=cO0VA8sPCHSdvNTRaAgPs6NicHsgD6AL7kQaFUvXJBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ncf14v56/pz62NchEql4fnGqYn2iVuxtER4YSWUac4QaaZKqhd7YRumwQq/iCzhqs6bLbxlnxxD4140QjcR8L0OeNIBAJsm0hMhHTThWZpKwj9zXC2vaf9i4CowzPUt2+dH/hkQdIPcMMRNyGOBZwbzL1N4ze/aSDqNNi9d3gZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZBMt+B8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF378C4CEC3;
	Sun,  8 Sep 2024 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725826680;
	bh=cO0VA8sPCHSdvNTRaAgPs6NicHsgD6AL7kQaFUvXJBA=;
	h=From:To:Cc:Subject:Date:From;
	b=cZBMt+B8eG+8kL6yhFWRP1OiZyxxqgIG04xCyMaBhgoDw4rpmDAal1d9t459Ac5SH
	 T7FXM5+nSB0jYdhZTLo31IdE7SB+RghmlE4ys3ZGpPSA/sv6b9cu0fR9sZcW+LLT4X
	 F/wGmSh/AxnEuakZsr7pe0fT9KVyvRexuf5QKRYpjFPNv76jMruuDrgO5bW2m9lAnp
	 L3F9YnZ4smPRugvULJM0GlPiR/FY18bHWqX4uZqIgOYNprMlmTBBH5pUvs2s+lDWxJ
	 BG3rEMUdIv5mPGJzpjd0+uh2Ods/zwKwL81BPm95/lMTa/ayWs9xbvRgW6wggUoNHf
	 I/j5E0HP35iNw==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8365: include linux/bitfield.h
Date: Sun,  8 Sep 2024 22:17:34 +0000
Message-Id: <20240908221754.2210857-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On x86, the header is not already included implicitly,
breaking compile-testing:

In file included from sound/soc/mediatek/mt8365/mt8365-afe-common.h:19,
                 from sound/soc/mediatek/mt8365/mt8365-afe-pcm.c:18:
sound/soc/mediatek/mt8365/mt8365-afe-pcm.c: In function 'mt8365_afe_cm2_mux_conn':
sound/soc/mediatek/mt8365/mt8365-reg.h:952:41: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
  952 | #define CM2_AFE_CM2_CONN_CFG1(x)        FIELD_PREP(CM2_AFE_CM2_CONN_CFG1_MASK, (x))
      |                                         ^~~~~~~~~~

Included it ahead of the field definitions.

Fixes: 38c7c9ddc740 ("ASoC: mediatek: mt8365: Add common header")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

This started happening after I applied "ASoC: mt8365: Allow build coverage".
---
 sound/soc/mediatek/mt8365/mt8365-reg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt8365/mt8365-reg.h b/sound/soc/mediatek/mt8365/mt8365-reg.h
index b763cddc93db..4ebbb94ff02e 100644
--- a/sound/soc/mediatek/mt8365/mt8365-reg.h
+++ b/sound/soc/mediatek/mt8365/mt8365-reg.h
@@ -10,6 +10,8 @@
 #ifndef _MT8365_REG_H_
 #define _MT8365_REG_H_
 
+#include <linux/bitfield.h>
+
 #define AUDIO_TOP_CON0			(0x0000)
 #define AUDIO_TOP_CON1			(0x0004)
 #define AUDIO_TOP_CON2			(0x0008)
-- 
2.39.2


