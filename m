Return-Path: <linux-kernel+bounces-557564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240DA5DAD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1811899B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5223E34B;
	Wed, 12 Mar 2025 10:47:32 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302C23AE9A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776451; cv=none; b=B2rms+BNyrUVTw158w95vMU7JEcCQSovnVg88Lt+uqMnSsn5z+eiQJRFNzJSxRnhrdKanG08ZRLhvvPiULSytvWyjaa3e44no/JUUCoxnZpLmM9pIlJ3MJHoIX2mGiDBgkqNa9gZn2XYSi15Z+2g+3R7crV19il/v2kmYwCXXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776451; c=relaxed/simple;
	bh=3xsN0kx24BXP3yguHMFGTD7H6CnWMEE7M3OPME5SAFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyAR7I6RzsVOq053rVM3vSF+zGRXVoSmPq4bzvYzqSU2iAP4PbtHAQN2WcKAmOLZU3RxUfcySH9FfGrnFdjEzLMMrPOF9EK+5g5B+NKc1a1/5kvNsl0QQ/Iu2+TTV55pKotZTCuHTXAVDzzEdIsfDNSpt0bIX2KOTP8E3Fbw/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:bb30:6286:99f4:5b9d])
	by albert.telenet-ops.be with cmsmtp
	id PmnN2E0014xs17S06mnNQp; Wed, 12 Mar 2025 11:47:22 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tsJc2-0000000Dg35-1VaC;
	Wed, 12 Mar 2025 11:47:22 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tsJcQ-00000000Rr8-08zI;
	Wed, 12 Mar 2025 11:47:22 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM: core: Fix indentation in dpm_wait_for_children()
Date: Wed, 12 Mar 2025 11:47:19 +0100
Message-ID: <9c8ff2b103c3ba7b0d27bdc8248b05e3b1dc9551.1741776430.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The body of dpm_wait_for_children() is indented by 7 spaces instead of a
single TAB.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e4103d29a21a6b2f..2fc37658b0b582e2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -249,7 +249,7 @@ static int dpm_wait_fn(struct device *dev, void *async_ptr)
 
 static void dpm_wait_for_children(struct device *dev, bool async)
 {
-       device_for_each_child(dev, &async, dpm_wait_fn);
+	device_for_each_child(dev, &async, dpm_wait_fn);
 }
 
 static void dpm_wait_for_suppliers(struct device *dev, bool async)
-- 
2.43.0


