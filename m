Return-Path: <linux-kernel+bounces-354670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4749940BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4B21C20930
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CF17A922;
	Tue,  8 Oct 2024 07:31:42 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57970157465
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372701; cv=none; b=tXVQgAVvppnWGuLO8PmR7zN7Ql7Hzq/9f4AUQd+rbhRyX3aMDwrvRIDjRpETCv6p1IpLchjKp6taG3m7kd9Y1JFY2vguRfYX0dxehFBIt8tJtv4XU1Aq8j5FBDotMOjQc32uFVdM0Wwkko+wXOJr25P1TILEbqZvZljK+RZ2Q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372701; c=relaxed/simple;
	bh=4QuhkTSEX8NVgBvVnxMjl6Npxhm57XLNjtkKQA6hMoI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Wr1KjoqW8l1edAW3BgYeSKtumsxwkqbxtwgCtGL+qKAd2ycTG7Zhe2jVnAdKb/ouDsRDPXiA8YhMBVrr+12KrSvfFVfvNkyHCmXbutD50tyv7oeIiB/sw8XOQ2M3icW31PItgtjKyxxLbqlovO1M3KIOAbQ5icAj9TgBOLKkQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66704df1abd1-b0496;
	Tue, 08 Oct 2024 15:28:27 +0800 (CST)
X-RM-TRANSID:2ee66704df1abd1-b0496
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66704df198bb-9a54d;
	Tue, 08 Oct 2024 15:28:26 +0800 (CST)
X-RM-TRANSID:2ee66704df198bb-9a54d
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	zhujun2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/applicom:Removed the unused variable byte_reset_it
Date: Tue,  8 Oct 2024 00:28:25 -0700
Message-Id: <20241008072825.12937-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove unused variable and redundant readb in ac_register_board

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/char/applicom.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index 9fed9706d9cd..ea25caf35346 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -127,8 +127,6 @@ static int dummy;	/* dev_id for request_irq() */
 static int ac_register_board(unsigned long physloc, void __iomem *loc, 
 		      unsigned char boardno)
 {
-	volatile unsigned char byte_reset_it;
-
 	if((readb(loc + CONF_END_TEST)     != 0x00) ||
 	   (readb(loc + CONF_END_TEST + 1) != 0x55) ||
 	   (readb(loc + CONF_END_TEST + 2) != 0xAA) ||
@@ -156,7 +154,6 @@ static int ac_register_board(unsigned long physloc, void __iomem *loc,
 	apbs[boardno].RamIO = loc;
 	init_waitqueue_head(&apbs[boardno].FlagSleepSend);
 	spin_lock_init(&apbs[boardno].mutex);
-	byte_reset_it = readb(loc + RAM_IT_TO_PC);
 
 	numboards++;
 	return boardno + 1;
-- 
2.17.1




