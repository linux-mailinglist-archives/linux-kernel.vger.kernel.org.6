Return-Path: <linux-kernel+bounces-371206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765369A37F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360BD283B58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64F18C91F;
	Fri, 18 Oct 2024 08:03:51 +0000 (UTC)
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132E35894;
	Fri, 18 Oct 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238631; cv=none; b=PjVWwvmBjcxo6nu0IrBM+vMRRxMDyc82LafXw6fZnE+79hdepRDbSK/n75IU5BDCd07pBfBnBSLJj53vc5/nC+ZvQqJ3rKe9NTtm3I0LCDwlfCzRYNfy9tr/k+jArUV9xf/wZfRRwc/QFYHPNLSLkIwh4Nth+/PD3GTQEks+pjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238631; c=relaxed/simple;
	bh=3rV8tTUsBQcUQE9oTYau21TraFKQe+oy6TUXbWoYxS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHmPAGxhckIrWMMm30BCzIiOrfUCPcsQZxUY0Ct3P1RTD2Y2F6OMNL4BLYwrwLGlbq6ky9jJ7lO3/8sy5fT/pukHxX1uRoHoVceJCaV0TyX4pfYCSGBTUz2iC/OmA34QuYOYcqHiWK5K4xqGMs9gjGYF8WQWpAvdJiDUf2lWGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sarah.maedel@hetzner-cloud.de>)
	id 1t1hgu-0001y7-DY; Fri, 18 Oct 2024 09:46:32 +0200
Received: from [79.252.227.100] (helo=localhost.localdomain)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sarah.maedel@hetzner-cloud.de>)
	id 1t1hgu-0007tO-0a;
	Fri, 18 Oct 2024 09:46:32 +0200
From: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Sarah Maedel <sarah.maedel@hetzner-cloud.de>,
	Tommy Giesler <tommy.giesler@hetzner.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6775) update ASUS WMI monitoring list 665-ACE/600M-CL
Date: Fri, 18 Oct 2024 09:46:10 +0200
Message-ID: <20241018074611.358619-1-sarah.maedel@hetzner-cloud.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sarah.maedel@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27430/Thu Oct 17 10:33:26 2024)

Boards such as
* Pro WS 665-ACE
* Pro WS 600M-CL
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Co-developed-by: Tommy Giesler <tommy.giesler@hetzner.com>
Signed-off-by: Tommy Giesler <tommy.giesler@hetzner.com>
Signed-off-by: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
---
 drivers/hwmon/nct6775-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 096f1daa8f2b..1218a3b449a8 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1350,6 +1350,8 @@ static const char * const asus_msi_boards[] = {
 	"Pro H610M-CT D4",
 	"Pro H610T D4",
 	"Pro Q670M-C",
+	"Pro WS 600M-CL",
+	"Pro WS 665-ACE",
 	"Pro WS W680-ACE",
 	"Pro WS W680-ACE IPMI",
 	"Pro WS W790-ACE",
-- 
2.44.0


