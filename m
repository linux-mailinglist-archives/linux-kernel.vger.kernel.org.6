Return-Path: <linux-kernel+bounces-217365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767FD90AEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D511C21321
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDD119755B;
	Mon, 17 Jun 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gordius.net header.i=@gordius.net header.b="ubmqlfZW"
Received: from m32-23.eu.mailgun.net (m32-23.eu.mailgun.net [141.193.32.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66091194AC7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.193.32.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629854; cv=none; b=oWf0K5ZfVC3iWO7Z3gJ4o7GnFfR9RQOXxTQ1u2b91Mmuz8E33hLE/6WArjBSfVlm0z1CzWImGRdUqdPacbDY3Q0fG7AUIz1L+XFVmNUQRiB7iD04WgvBwSg6NG4J/IcGDDYYY8RtoLEp52/UDiib3CII6e7DRkkysCP82U6+25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629854; c=relaxed/simple;
	bh=yUmzYgcW/NyvPz4/fk4wizEbF64Cn8ibPIuPkBvLrHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfUmd27mN4htsaWSoyvhePGn6LJ6FHhn79ol8JO0uiXp5CeCtBoYTvi+HRoZLtV4F3tM+CZ+1za+gXYuQaMUOlrfb8qHRxnT7PrYpYcMrkplVeMRX8e7G32tuaHOA6fDz/GXkafdtpmPbAtX30a7bnEoRZvtuqruA7uQDomi3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gordius.net; spf=pass smtp.mailfrom=gordius.net; dkim=pass (2048-bit key) header.d=gordius.net header.i=@gordius.net header.b=ubmqlfZW; arc=none smtp.client-ip=141.193.32.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gordius.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gordius.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=gordius.net; q=dns/txt; s=s1; t=1718629850; x=1718637050;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=qzAG31RCjK0xPR71N2wyKqglgCcqQuVbd50OPGMPLpk=;
 b=ubmqlfZWw0qpqmhU5AwjmaIiu4cEq50+m6ils79ZC8P4DouxBbgy98bdPBBhEYNxRlNqHqjpLjWE/VmNXogE5HmzY/3B5jDVAXeLXG7xXed3WaXNV/50hNyq/LXzWvCmV1c+6PCLbcoVSn2qIVODp+BuMWwzAANNMsub7i1fsP6KM7glFnMZhJM6fbWpELO7eC+l3xgqoqw5lDIAyPRrkrNM9umvDDFF7gbal50AYwoQqpKpt8xeVCYzNwj2bo+0K817kGxLDViLpN9H/ECqXStTH36Kzw7szWrYScaAwznyBjYr/+6IF4R7GvJT968vYxtY4hzos2OcUmuOeMSuRQ==
X-Mailgun-Sending-Ip: 141.193.32.23
X-Mailgun-Sid: WyIwOGE0YSIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI3NjMyZCJd
Received: from personal.com (<unknown> [46.189.19.114]) by 14d122e98982 with SMTP id
 667035da76de11bca020d8e8 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 17 Jun 2024 13:10:50 GMT
Sender: alex@gordius.net
From: Alexander Gordeev <alex@gordius.net>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <alex@gordius.net>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] pps: Update my email address.
Date: Mon, 17 Jun 2024 15:10:11 +0200
Message-ID: <20240617131016.661879-1-alex@gordius.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old email address at lvk.cs.msu.su doesn't exist anymore. I saw
folks trying to reach me a few years ago, so I'd like to put my
personal address here.

Signed-off-by: Alexander Gordeev <alex@gordius.net>
---
 drivers/pps/clients/pps_parport.c        | 4 ++--
 drivers/pps/generators/pps_gen_parport.c | 4 ++--
 drivers/pps/kc.c                         | 2 +-
 drivers/pps/kc.h                         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index af972cdc04b5..7ecd1df9aa59 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -2,7 +2,7 @@
 /*
  * pps_parport.c -- kernel parallel port PPS client
  *
- * Copyright (C) 2009   Alexander Gordeev <lasaine@lvk.cs.msu.su>
+ * Copyright (C) 2009   Alexander Gordeev <alex@gordius.net>
  */
 
 
@@ -220,6 +220,6 @@ static struct parport_driver pps_parport_driver = {
 };
 module_parport_driver(pps_parport_driver);
 
-MODULE_AUTHOR("Alexander Gordeev <lasaine@lvk.cs.msu.su>");
+MODULE_AUTHOR("Alexander Gordeev <alex@gordius.net>");
 MODULE_DESCRIPTION("parallel port PPS client");
 MODULE_LICENSE("GPL");
diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
index b3e084b75c23..4c6cb55ec5ae 100644
--- a/drivers/pps/generators/pps_gen_parport.c
+++ b/drivers/pps/generators/pps_gen_parport.c
@@ -2,7 +2,7 @@
 /*
  * pps_gen_parport.c -- kernel parallel port PPS signal generator
  *
- * Copyright (C) 2009   Alexander Gordeev <lasaine@lvk.cs.msu.su>
+ * Copyright (C) 2009   Alexander Gordeev <alex@gordius.net>
  */
 
 
@@ -236,6 +236,6 @@ static struct parport_driver pps_gen_parport_driver = {
 };
 module_parport_driver(pps_gen_parport_driver);
 
-MODULE_AUTHOR("Alexander Gordeev <lasaine@lvk.cs.msu.su>");
+MODULE_AUTHOR("Alexander Gordeev <alex@gordius.net>");
 MODULE_DESCRIPTION("parallel port PPS signal generator");
 MODULE_LICENSE("GPL");
diff --git a/drivers/pps/kc.c b/drivers/pps/kc.c
index 50dc59af45be..fd1e0b1f9639 100644
--- a/drivers/pps/kc.c
+++ b/drivers/pps/kc.c
@@ -2,7 +2,7 @@
 /*
  * PPS kernel consumer API
  *
- * Copyright (C) 2009-2010   Alexander Gordeev <lasaine@lvk.cs.msu.su>
+ * Copyright (C) 2009-2010   Alexander Gordeev <alex@gordius.net>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/pps/kc.h b/drivers/pps/kc.h
index 24730559449c..2404eeadc017 100644
--- a/drivers/pps/kc.h
+++ b/drivers/pps/kc.h
@@ -2,7 +2,7 @@
 /*
  * PPS kernel consumer API header
  *
- * Copyright (C) 2009-2010   Alexander Gordeev <lasaine@lvk.cs.msu.su>
+ * Copyright (C) 2009-2010   Alexander Gordeev <alex@gordius.net>
  */
 
 #ifndef LINUX_PPS_KC_H
-- 
2.45.1


