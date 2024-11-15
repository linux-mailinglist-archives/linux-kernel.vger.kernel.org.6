Return-Path: <linux-kernel+bounces-411046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0169CF232
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339AF1F2176F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85A1D5AD7;
	Fri, 15 Nov 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cs+nXupu"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691D762E0;
	Fri, 15 Nov 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689695; cv=none; b=NmZ9kumtrh6S6Gomtaj9OFiBS7RI5GYdo8F9nNu3MBlpBiqna0aQATUro1prbQsOR0t2aHv9iI5QIzaRWOgL20H2sG3XggdNI/WtDCkj2FWxoZGLCu1lBq77fh42jdMwAc8y/Z9NT3JBg4yqqa+sGIdeCZzY5D5ar8mmXT5UIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689695; c=relaxed/simple;
	bh=NdGgJpbrkxwQPIZY7b3OV48z5XqL9DWgYsE/gbcOlQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkKJNYovwMO3aw3Zx0BJvWManJazE/WXegK9YIjP+zFXICW84LUkGy9Yaz2gqaRTvkOMIkZ87E3ast6ocNzZmITe83O5iloONYDUCf7uUmvEux6n2Gj92u74s5ZV/aSvIRF3bSS2pMp0lz/52d81Z6nT02vEPEjtCNc15l2OR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cs+nXupu; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id BzamtxBk9W6lUBzantT11p; Fri, 15 Nov 2024 17:54:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731689686;
	bh=VjL0T8V3592eoi9zyDm4yaxJadogguU7vBFf2SgAtkM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cs+nXupuvX2UUZFgePhpnFr4+FZ3OO/E9X8iNxzxe3Cdoh+N/tfFIcOpAWa0P0Jrr
	 QfAj8YEfeP8z8e8p6tvvK0bfRMD2bYObEFS1putMrdf9NIlPJ5mlcwBlLYuQsdqbNs
	 aaNslRxrs2eVdlTSXI/vjJyjii0IM5uJpU0irp1aXG0cE1osFEgPB/fkYOuGQfz8Dt
	 G8l30Luv5/OmsPXpbSseH+e0razkzCPtUdt89TmnSLNm04hiLc8W+sE8GRQUk16bpP
	 71azQXcQvowRhQYz1pDmAJZDWBE/AKtQlE3PkwoVGg2XGi9CHVzhwjD7XYaimIcmJH
	 BaxzWvrFpA1JQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Nov 2024 17:54:46 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: [PATCH] ASoC: cs42l51: Constify struct i2c_device_id
Date: Fri, 15 Nov 2024 17:54:25 +0100
Message-ID: <d5e686f47eddb14245d0fde693ff77ae749f7a08.1731689646.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct i2c_device_id' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

While at it, also add some space to be consistent with cs42l51_of_match a
few lines below.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   1551	    384	     16	   1951	    79f	sound/soc/codecs/cs42l51-i2c.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   1631	    304	     16	   1951	    79f	sound/soc/codecs/cs42l51-i2c.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 sound/soc/codecs/cs42l51-i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index e7cc50096297..f171bd66fcac 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -13,9 +13,9 @@
 
 #include "cs42l51.h"
 
-static struct i2c_device_id cs42l51_i2c_id[] = {
-	{"cs42l51"},
-	{}
+static const struct i2c_device_id cs42l51_i2c_id[] = {
+	{ "cs42l51" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
 
-- 
2.47.0


