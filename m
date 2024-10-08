Return-Path: <linux-kernel+bounces-354362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DB993C81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FBDB22920
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CEA18EB1;
	Tue,  8 Oct 2024 01:51:25 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5F41C695;
	Tue,  8 Oct 2024 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352285; cv=none; b=n42IpieU9YHo8d7mnjh7uzTVqK/9ucBfXPpCT1uYg46PkZ7FNzf35ELrapNynMDpgkOY4ov8GV6XbVacxElQWdxT5hanFhzAsY1SA8vhM2mqnXLJQaZVyiD4AZ6LNzEOfOYrAdTs4kvHNmpMOQqHzSpGKhY8MiQOzBR486SyEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352285; c=relaxed/simple;
	bh=vZOBNbEZs0Rfo7A5bAl8df+cNkkn7NVEylmQziEjhNY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uqlf2BDdJ5Flb40ZtarZb+IuGvfC1xiRb5bz8L16ii9nNO793WjlTDSBjgZkTgzRmNk1nd22LGp/aUI/azUgVMcVqCbesQtcStxSSGROGSKIVbmSNdKVrlhDg6ApgfiCNdg9esnF3dqFJVTzFRpUG1zBYNFSLYb2DIR9EU066Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee467048f58187-aea80;
	Tue, 08 Oct 2024 09:48:08 +0800 (CST)
X-RM-TRANSID:2ee467048f58187-aea80
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea67048f57b35-8143b;
	Tue, 08 Oct 2024 09:48:08 +0800 (CST)
X-RM-TRANSID:2eea67048f57b35-8143b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	zhujun2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] Sound:vx_uer:Delete extra blank lines
Date: Mon,  7 Oct 2024 18:48:06 -0700
Message-Id: <20241008014806.7573-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Delete extra blank lines inside in vx_uer.c

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/drivers/vx/vx_uer.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/drivers/vx/vx_uer.c b/sound/drivers/vx/vx_uer.c
index 3eca22151225..a0ce9b205e4d 100644
--- a/sound/drivers/vx/vx_uer.c
+++ b/sound/drivers/vx/vx_uer.c
@@ -12,7 +12,6 @@
 #include <sound/vx_core.h>
 #include "vx_cmd.h"
 
-
 /*
  * vx_modify_board_clock - tell the board that its clock has been modified
  * @sync: DSP needs to resynchronize its FIFO
@@ -127,7 +126,6 @@ static int vx_read_uer_status(struct vx_core *chip, unsigned int *mode)
 	return freq;
 }
 
-
 /*
  * compute the sample clock value from frequency
  *
@@ -144,7 +142,6 @@ static int vx_read_uer_status(struct vx_core *chip, unsigned int *mode)
  *    case 0x00000700: HexFreq = (dword) (((double) 28224000 / (double) (Frequency*2)) - 1)
  *    default        : HexFreq = (dword) ((double) 28224000 / (double) (Frequency*4)) - 0x000001FF
  */
-
 static int vx_calc_clock_from_freq(struct vx_core *chip, int freq)
 {
 	int hexfreq;
@@ -169,7 +166,6 @@ static int vx_calc_clock_from_freq(struct vx_core *chip, int freq)
 	return 0x5fe; 	/* min freq = 6893 Hz */
 }
 
-
 /*
  * vx_change_clock_source - change the clock source
  * @source: the new source
@@ -186,7 +182,6 @@ static void vx_change_clock_source(struct vx_core *chip, int source)
 	vx_toggle_dac_mute(chip, 0);
 }
 
-
 /*
  * set the internal clock
  */
@@ -209,7 +204,6 @@ void vx_set_internal_clock(struct vx_core *chip, unsigned int freq)
 	mutex_unlock(&chip->lock);
 }
 
-
 /*
  * set the iec958 status bits
  * @bits: 32-bit status bits
@@ -225,7 +219,6 @@ void vx_set_iec958_status(struct vx_core *chip, unsigned int bits)
 		vx_write_one_cbit(chip, i, bits & (1 << i));
 }
 
-
 /*
  * vx_set_clock - change the clock and audio source if necessary
  */
@@ -267,7 +260,6 @@ int vx_set_clock(struct vx_core *chip, unsigned int freq)
 	return 0;
 }
 
-
 /*
  * vx_change_frequency - called from interrupt handler
  */
-- 
2.17.1




