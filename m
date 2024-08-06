Return-Path: <linux-kernel+bounces-276333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18283949238
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D91C213F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0283205E29;
	Tue,  6 Aug 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hQW0CjW9"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3B1D54F2;
	Tue,  6 Aug 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952361; cv=none; b=ZOvSJq+9lq3OBWXvlw2GUuTaMIzmsMcZZz4/5Z3LU+M61qKyvTA/o1DkvvBp7MRTGPGkL87zJ21kh7/xR8CTcaeRWpohqSw5Jv4b7TldKDc3N4jTh8a8G7jlPa4UYDRU4ahZ6w///QtMqEUbU72DNwFMLdFn91R+vb6pqhmG6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952361; c=relaxed/simple;
	bh=1xp8MpcbIf4SJReiGGRUdwOnwB4XlkxoI0nTOvXGop0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0R1Ky2M7/kN//q0K1VGvu1HEzZXYTIiI6hqvD6VWztphzyijwf2Zbx5V63UtSWBYbYzfPKZK3gFD0Iw+U7TPHt5gKOED4wA7RPJxXgSOo1NAxv53GnPPXmZksXggC8q50RDAvtCNuNo0gkXjA8VKIy09tTwsIJjSiAbEzy/PKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hQW0CjW9; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bKbzsGbpa1n2IbKbzsv4Xt; Tue, 06 Aug 2024 15:52:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722952350;
	bh=mc++s71P86r5Z0x7KKuuJQxBX0xc+KPuIQNkerrGWJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hQW0CjW9L9pEKnBc4HRnBH49bThclJIlf+wQTLUm+ku4twf8fJugchH1cnt7PDvIB
	 t1UlDvFuJgY2O/V7wqFZkWPbkE8VRCeoXCCVmpbZOqM2difB2ol8ORk52NUXYNVUdi
	 hGsFj1kwQlNn5OBHEINdGgfPJGU2a7021Ox8K7DvoszuNSdjeGT0C8+U8D3pmUFS6x
	 H+tTCXkXuEEQqbCEENZ5umBySDXJKNT/s4SAIv0HwAfWq8fxas/8t12XT86BMEqJ4i
	 riBkkqEP0uLk9YeObjscXBPzljWN5R6PkOLpsgHeClS3QonKg42uCVxASxMb5ryej3
	 HMOZcvd3Lh+Kg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Aug 2024 15:52:30 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: rt1318: Constify struct reg_sequence
Date: Tue,  6 Aug 2024 15:52:24 +0200
Message-ID: <96561dd2962d4312eb0e68ab850027f44350d070.1722952334.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct reg_sequence' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

While at it, remove rt1318_INIT_REG_LEN which is ununsed.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  22062	   4859	     32	  26953	   6949	sound/soc/codecs/rt1318.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  24742	   2171	     32	  26945	   6941	sound/soc/codecs/rt1318.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 sound/soc/codecs/rt1318.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1318.c b/sound/soc/codecs/rt1318.c
index 83b29b441be9..e12b1e96a53a 100644
--- a/sound/soc/codecs/rt1318.c
+++ b/sound/soc/codecs/rt1318.c
@@ -30,7 +30,7 @@
 
 #include "rt1318.h"
 
-static struct reg_sequence init_list[] = {
+static const struct reg_sequence init_list[] = {
 	{ 0x0000C000, 0x01},
 	{ 0x0000F20D, 0x00},
 	{ 0x0000F212, 0x3E},
@@ -254,7 +254,6 @@ static struct reg_sequence init_list[] = {
 	{ 0x0000C320, 0x20},
 	{ 0x0000C203, 0x9C},
 };
-#define rt1318_INIT_REG_LEN ARRAY_SIZE(init_list)
 
 static const struct reg_default rt1318_reg[] = {
 	{ 0xc000, 0x00 },
-- 
2.45.2


