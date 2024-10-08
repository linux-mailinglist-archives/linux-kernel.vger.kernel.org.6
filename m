Return-Path: <linux-kernel+bounces-356209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211A995DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435F11C21FBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CF13B58D;
	Wed,  9 Oct 2024 02:49:03 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46F420B0F;
	Wed,  9 Oct 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442143; cv=none; b=TNmj6K9ISAweXHhCgt45iaAElO76khxg8Q80GDGRa4JiDdf5PdrAPheDvn6Qtv20upf5tMaOVgltsaQysCE6aIJoxgMDcLjjs543xjKz+yJ3C3ELOOg0okCAc+AarXr85H87Hh9q1FnAfuaci9n+scROjt5DHxEElvFksxR3oLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442143; c=relaxed/simple;
	bh=bmyx8pS27sYQTK0+N2ige/SQhQWrej1KLvIlKMjI2S8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gD9WzcoDiEr35CoxT6X5VdrqYly4RczpWKgvqKeCL/g+l5V1kYl2IjwURQmD/GoVl6NhGRVJc7jfBOXEcqmXsCY6/+Bk7AG5kFnKT/nVIl6Ey5KQFwOUOsVSMhiLBA42vP7Q4YARFAkUsIL7jHO11Z4Wp9Gihe6lZ9e84WtzmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76705ef1899d-e89b0;
	Wed, 09 Oct 2024 10:48:56 +0800 (CST)
X-RM-TRANSID:2ee76705ef1899d-e89b0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16705ef098ff-ce6d2;
	Wed, 09 Oct 2024 10:48:56 +0800 (CST)
X-RM-TRANSID:2ee16705ef098ff-ce6d2
From: Ba Jing <bajing@cmss.chinamobile.com>
To: James.Bottomley@HansenPartnership.com
Cc: deller@gmx.de,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] parisc: lasi: remove unused macro
Date: Tue,  8 Oct 2024 15:43:42 +0800
Message-Id: <20241008074342.38891-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found the macro LASI_IO_CONF2 is 
never referenced in the code. Just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/parisc/lasi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/parisc/lasi.c b/drivers/parisc/lasi.c
index 73c93e9cfa51..b387ea7f1c28 100644
--- a/drivers/parisc/lasi.c
+++ b/drivers/parisc/lasi.c
@@ -29,7 +29,6 @@
 #define LASI_VER	0xC008	/* LASI Version */
 
 #define LASI_IO_CONF	0x7FFFE	/* LASI primary configuration register */
-#define LASI_IO_CONF2	0x7FFFF	/* LASI secondary configuration register */
 
 static void lasi_choose_irq(struct parisc_device *dev, void *ctrl)
 {
-- 
2.33.0




