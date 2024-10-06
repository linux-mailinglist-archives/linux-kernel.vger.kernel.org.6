Return-Path: <linux-kernel+bounces-352652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F5992230
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CC428181E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB918BBBB;
	Sun,  6 Oct 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YoIqCU6k"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D6189F3F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255318; cv=none; b=OcttFpcI27ncESmoQKiRNgkTgMPNK6Dh08De1K9f2obGcMKczlymcSXy+hmqPcCj2p/cMs7n0Fz7rd+I4rYsF+CDKEuBvk64wiT+rAMXVNDTR6dLzqWhnyUTE5TkF37lguZs57uOMyY9/0rEoebYccc6jFQSwFZ7bS6iRvG+RKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255318; c=relaxed/simple;
	bh=lagJWk8SU2D98SWrrZx4DJjfRm4K1eJDvb+SdgpIyLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgHPRRQEPXJAqMeCZ55r0dQCEssLK0GeE5EavYAgNwbIgpUr+jHUCT02Mh1qltrvj4D4uGaJYD4YLRA4iY0C1fY/a0rQXwGMyvvTA+exq4VuV84ZbOSP5je0+X1VgwmDa6MAijmyfhAeS+RnDdeJUhW5CvlKccqt9PPmruLYSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YoIqCU6k; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9BP4B/IfvM42ahXgRgTste/nSR7JJMWEXNyvBtekDzY=; b=YoIqCU6kFeGn19sq
	HjF+fT7cpNlZQa40XuprvoF3DB81LzQONxHC+cr960Z94ioJ6MkiZo+kQSEebzxNaNDg94ihGKn7n
	pLN+TDChKRPI7/zFWF4Bo06/Ubj1Y/EY4tSBklgdDkHFIWbqUmcTOo24zrzejWs6q/iowlTS60eSp
	ny/j/azg4XPiakIOJ/xkdKKlBZOahgwkL9ecBVAkgZ/dI4UAP4plvoZLMuXTnaU7hncJY3QBPPSdU
	kKMANWIeNQWR3dnIYr3uGQQpOjn2Whn0GsIEd6ZaNIZogLOqILjU1L/Dz3PRKd8TjxueGL4CP2sAB
	xjPVdrGQCnvDKix7LA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxa9h-009Lff-0l;
	Sun, 06 Oct 2024 22:55:13 +0000
From: linux@treblig.org
To: ojeda@kernel.org,
	andy@kernel.org,
	geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] auxdisplay: Remove unused functions
Date: Sun,  6 Oct 2024 23:55:11 +0100
Message-ID: <20241006225511.121579-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cfag12864b_getrate() and cfag12864b_isenabled() were both added
in commit 70e840499aae ("[PATCH] drivers: add LCD support")
but never used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/auxdisplay/cfag12864b.c | 12 ------------
 include/linux/cfag12864b.h      | 17 -----------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864b.c b/drivers/auxdisplay/cfag12864b.c
index 6526aa51fb1d..e1a94ae3eb0c 100644
--- a/drivers/auxdisplay/cfag12864b.c
+++ b/drivers/auxdisplay/cfag12864b.c
@@ -37,11 +37,6 @@ module_param(cfag12864b_rate, uint, 0444);
 MODULE_PARM_DESC(cfag12864b_rate,
 	"Refresh rate (hertz)");
 
-unsigned int cfag12864b_getrate(void)
-{
-	return cfag12864b_rate;
-}
-
 /*
  * cfag12864b Commands
  *
@@ -249,11 +244,6 @@ void cfag12864b_disable(void)
 	mutex_unlock(&cfag12864b_mutex);
 }
 
-unsigned char cfag12864b_isenabled(void)
-{
-	return cfag12864b_updating;
-}
-
 static void cfag12864b_update(struct work_struct *work)
 {
 	unsigned char c;
@@ -293,10 +283,8 @@ static void cfag12864b_update(struct work_struct *work)
  */
 
 EXPORT_SYMBOL_GPL(cfag12864b_buffer);
-EXPORT_SYMBOL_GPL(cfag12864b_getrate);
 EXPORT_SYMBOL_GPL(cfag12864b_enable);
 EXPORT_SYMBOL_GPL(cfag12864b_disable);
-EXPORT_SYMBOL_GPL(cfag12864b_isenabled);
 
 /*
  * Is the module inited?
diff --git a/include/linux/cfag12864b.h b/include/linux/cfag12864b.h
index 6617d9c68d86..83e6613d12ae 100644
--- a/include/linux/cfag12864b.h
+++ b/include/linux/cfag12864b.h
@@ -27,13 +27,6 @@
  */
 extern unsigned char * cfag12864b_buffer;
 
-/*
- * Get the refresh rate of the LCD
- *
- * Returns the refresh rate (hertz).
- */
-extern unsigned int cfag12864b_getrate(void);
-
 /*
  * Enable refreshing
  *
@@ -49,16 +42,6 @@ extern unsigned char cfag12864b_enable(void);
  */
 extern void cfag12864b_disable(void);
 
-/*
- * Is enabled refreshing? (is anyone using the module?)
- *
- * Returns 0 if refreshing is not enabled (anyone is using it),
- * or != 0 if refreshing is enabled (someone is using it).
- *
- * Useful for buffer read-only modules.
- */
-extern unsigned char cfag12864b_isenabled(void);
-
 /*
  * Is the module inited?
  */
-- 
2.46.2


