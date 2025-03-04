Return-Path: <linux-kernel+bounces-544086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A179A4DD3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95FF168223
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFC202984;
	Tue,  4 Mar 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="Uqrg+qR2"
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82153201018;
	Tue,  4 Mar 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089490; cv=none; b=lK1eFdFLEKIjJpt/NYaKy1/F7jAdgYH3dcsIk37De3YgGDjZLhrzakoTeJuSwaicploWESCLfWSyrTJr/cAihJ/gKtuUl9sPU2BKsFU+SQEJvxYkIY3nw9qlhEwNhnBei+WETsyIX8iJuHUPaV3LjgLlXmXTQLqJF9fwi8eX4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089490; c=relaxed/simple;
	bh=mxkGe76fANnDNUd93SXNtSBMrY87h5WgLsqxXocUux8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UUcw5leQQqGUvRbwhnvBlWOwn0fUY/Ycrt8U8KapIcPog2VSsbe+j7p9tWx5Z6InR1gEEJpPbAJ5EyuGCZW4dw/q7HI9XehyeO8HHdgkU+ACHVIHH5nvvUkyVcRdhHugyIzR5iA6Qpxz0EEbKum+T2Uu3FU3YnQGuGyrl+7krPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=Uqrg+qR2; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 52DFDC000F;
	Tue,  4 Mar 2025 14:57:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 52DFDC000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1741089477; bh=I+2PHlKZ/Tp6XTpd0mZkHPbi2TiqITlIRsNyBnyDVK8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Uqrg+qR2xSSGqhLQsZENJPDv82LWxWZXKH6/srWXO6zMjr+XgJXVijObEGPaSe8ku
	 5XdiVSZYkG6zegSk9LiZ6/nQMtniKTjAsXMiu1z6h+o8fQQS5dNOdokgs1lKaOZu/c
	 9DQFsfdwMEA+5AiWBP83UUUj9KkAP+gcydGYFLcNDvycBWmrHBt5T8lofha6Hmh8tp
	 3XT0wBz4RHdFeNbKDzz08IhmRlGyth98THP4EvfT+OHJ3eZpaVaS6UOHpmPL7EPDiG
	 1cKUeML4oP54RE8TOzEJIO6LT3TnW5L3ShbzgW4l4/B3b8jagXOrympzzrfVbUWezQ
	 p1mMZNdP5hdIw==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 14:57:57 +0300 (MSK)
Received: from localhost.maximatelecom.ru (5.1.51.168) by mmail-p-exch01.mt.ru
 (81.200.124.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Tue, 4 Mar 2025
 14:57:55 +0300
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: David Rhodes <david.rhodes@cirrus.com>
CC: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, Richard Fitzgerald
	<rf@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Lucas Tanure <tanureal@opensource.cirrus.com>, Charles
 Keepax <ckeepax@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
	<patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] ASoC: cs35l41: check the return value from spi_setup()
Date: Tue, 4 Mar 2025 16:56:37 +0500
Message-ID: <20250304115643.2748-1-v.shevtsov@mt-integration.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1;81.200.124.61:7.1.2;mt-integration.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191457 [Mar 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/04 09:41:00 #27591543
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Currently the return value from spi_setup() is not checked for a failure.
It is unlikely it will ever fail in this particular case but it is still
better to add this check for the sake of completeness and correctness. This
is cheap since it is performed once when the device is being probed.

Handle spi_setup() return value.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 872fc0b6bde8 ("ASoC: cs35l41: Set the max SPI speed for the whole device")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
---
 sound/soc/codecs/cs35l41-spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41-spi.c b/sound/soc/codecs/cs35l41-spi.c
index a6db44520c06..f9b6bf7bea9c 100644
--- a/sound/soc/codecs/cs35l41-spi.c
+++ b/sound/soc/codecs/cs35l41-spi.c
@@ -32,13 +32,16 @@ static int cs35l41_spi_probe(struct spi_device *spi)
 	const struct regmap_config *regmap_config = &cs35l41_regmap_spi;
 	struct cs35l41_hw_cfg *hw_cfg = dev_get_platdata(&spi->dev);
 	struct cs35l41_private *cs35l41;
+	int ret;
 
 	cs35l41 = devm_kzalloc(&spi->dev, sizeof(struct cs35l41_private), GFP_KERNEL);
 	if (!cs35l41)
 		return -ENOMEM;
 
 	spi->max_speed_hz = CS35L41_SPI_MAX_FREQ;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
 
 	spi_set_drvdata(spi, cs35l41);
 	cs35l41->regmap = devm_regmap_init_spi(spi, regmap_config);
-- 
2.48.1


