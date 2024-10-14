Return-Path: <linux-kernel+bounces-367548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B61C9A03AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080B61F21C05
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B461D222F;
	Wed, 16 Oct 2024 08:06:23 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9F1B2193;
	Wed, 16 Oct 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065983; cv=none; b=ZrLWMFe53zUdWxaDH4mN+RBNkR9B6FkFBrvBeLBvViwOorUaEn8ljEXmL3VGxZarjcec+2YfwDNbwT/arMSXqWp+PzcZlrPhkyDqIUlefTepJHTsxYvBabpWopEcEJBgN+A1xq4ILs7SBbcheLUOIvbUEp2QuFXBYMpo3Fu+bXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065983; c=relaxed/simple;
	bh=yCthBjUMgtU1Aa7fU8SdZTW4IzaSZ441Smq57WoVd9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FLA7Ydkum9pUg91ODjEPwHWilKd/0+p6n24ESp8pTQSS9sQ5taBGTIDq1WCVQmsGliY2bPwacQ/YYKPVa1srBt8li6RIriacdHOn2JGS6fONfu6SHbNpY+S06RgTHPLkKi6thohO9wBzQJKgsDefTwE83HOwN6XhoJsvRmm+M3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4670f73f1fdd-fc8de;
	Wed, 16 Oct 2024 16:06:09 +0800 (CST)
X-RM-TRANSID:2ee4670f73f1fdd-fc8de
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1670f73e2727-3d6fe;
	Wed, 16 Oct 2024 16:06:09 +0800 (CST)
X-RM-TRANSID:2ee1670f73e2727-3d6fe
From: Ba Jing <bajing@cmss.chinamobile.com>
To: jlee@suse.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] x86: acer-wmi: remove unused mocros
Date: Tue, 15 Oct 2024 02:38:56 +0800
Message-Id: <20241014183856.3942-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After reviewing the code, it was found that these macros are never
referenced in the code and are all set to 0. They should be removed.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/platform/x86/acer-wmi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 7169b84ccdb6..ae916a7a01ca 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -258,11 +258,6 @@ enum interface_flags {
 	ACER_WMID_v2,
 };
 
-#define ACER_DEFAULT_WIRELESS  0
-#define ACER_DEFAULT_BLUETOOTH 0
-#define ACER_DEFAULT_MAILLED   0
-#define ACER_DEFAULT_THREEG    0
-
 static int max_brightness = 0xF;
 
 static int mailled = -1;
-- 
2.33.0




