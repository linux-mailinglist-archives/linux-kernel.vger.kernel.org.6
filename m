Return-Path: <linux-kernel+bounces-319892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1997037B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEAF1F2138C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08BC15B992;
	Sat,  7 Sep 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1UNP+ZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1D2E634;
	Sat,  7 Sep 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725732064; cv=none; b=mEiiC+1NpiCIHUuEy4megpraQG0losoLf+P22z4Wx7Ip9G6JtwlOkIXTIsY+5Mr7sW31FJlqdeTMqeL28k4RQaQwPCxDtLolUZMEg0OYU+H3Y0b9xCkGXt0gToTq0E9E2JuK04s26FS7yxi5rX3J/2/hqHFZS31lCqf3uJOuYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725732064; c=relaxed/simple;
	bh=Mv6kZrJv/bwLcYzdrAAeBS2GRlYFUpBzbrl5z92vyCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpHWwRKNGPNQMMWmVAc3YwewhHwd3cApm51EUTeVt/a02vFfN4n6QwMfN9UrJzdx5AjO/GCAZlPGxp8ntqzGoR6CIa7SpCOpzFoO5gqsaFx/N/Z4yaSuXh+kH2pcvmSDrdjF1jdfISUF/MBY/3OVolnSwt3+jKHaezntMTX3Ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1UNP+ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0F6C4CEC2;
	Sat,  7 Sep 2024 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725732063;
	bh=Mv6kZrJv/bwLcYzdrAAeBS2GRlYFUpBzbrl5z92vyCI=;
	h=From:To:Cc:Subject:Date:From;
	b=N1UNP+ZT/W0cRRK9h9TJ1sFXGw7CVe+SC6IIrJwU1X/PuMOkxDrzozGYfkV33GQ9R
	 PjZ0/BUxcInEi1WPSw5LplbVgq0vqm7k35owy4ps8NDFyggnFheOHh67AMUpFC49/t
	 r8EaFsfUqNx/7/Wqi9TGi06X0tilOOw13/5bgFhX7IXZo7cxZ4OBWewHU9iujf1wyB
	 ydDHboQnilo2j6R4p+Xpttmqd596iYZi1dl/bZGkk/DsjOKzEoV9Ia7nWjQLeGoSaN
	 ZlFaUWEm4Qg3BLQbMlOIyaWeXZ/FCF7S2uhqGhca5/C41lOEwPVclnZDhWg1p7KSNB
	 oNDgorq+YdIPg==
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
Subject: [PATCH] ASoC: mediatek: mt8365: remove unused mt8365_i2s_hd_str
Date: Sat,  7 Sep 2024 20:00:38 +0000
Message-Id: <20240907200053.3027553-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The mt8365_i2s_enum and mt8365_i2s_hd_str variables are not
used anywhere, but cause a warning when building with C=1
or when enabling -Wunused-const-variable:

sound/soc/mediatek/mt8365/mt8365-dai-i2s.c:781:27: error: 'mt8365_i2s_hd_str' defined but not used [-Werror=unused-const-variable=]
  781 | static const char * const mt8365_i2s_hd_str[] = {
      |                           ^~~~~~~~~~~~~~~~~

Remove these for the moment, they can be added back if a
user comes up.

Fixes: 402bbb13a195 ("ASoC: mediatek: mt8365: Add I2S DAI support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
index 6b4d8b7e24ca..3482d8f8b4e7 100644
--- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
@@ -777,13 +777,6 @@ static struct snd_soc_dai_driver mtk_dai_i2s_driver[] = {
 	}
 };
 
-/* low jitter control */
-static const char * const mt8365_i2s_hd_str[] = {
-	"Normal", "Low_Jitter"
-};
-
-static SOC_ENUM_SINGLE_EXT_DECL(mt8365_i2s_enum, mt8365_i2s_hd_str);
-
 static const char * const fmi2sin_text[] = {
 	"OPEN", "FM_2ND_I2S_IN"
 };
-- 
2.39.2


