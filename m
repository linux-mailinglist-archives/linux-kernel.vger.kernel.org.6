Return-Path: <linux-kernel+bounces-371863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED19A416D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238B41C24551
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111401FF5E2;
	Fri, 18 Oct 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Ar7Lrt7k"
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E841F4278
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262549; cv=none; b=oFLq4c27eFllN+sBFJ889B9sujgdseo5JVxXbOfcREmHfo8YOhu/BbbslTA8cNzJ/oGXYXel2ttBnnXpNBwN3M2/A9KuRMG/TfJPtPdl6WWWv5RQkuRYUdkdjut+LtKBvXJy3LD6iGrQ+C1v29pu4jZoGSKG0QRG5idN4rQQ/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262549; c=relaxed/simple;
	bh=Gi43P9a/BLgdwrzvLfLrQ4OFlvq23EQb2JnzkqzJYOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ju3LehU0YglMiQAGTfcMi9UZpna0ZTPdpf6HJw8ZWu8kBWcDjPXJsEI2zuGbHnAX/+XXBVzT3a9AiZOuoM6AvxnSxybMEJfWCRRc5QJlvZKgRPsZGtcC43gG26pHwCfGpq/qLZzx3l368RT2fygqrXMhdLiBuMFjXOf3dPhyQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Ar7Lrt7k; arc=none smtp.client-ip=62.149.156.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1o8JtbKaEcvwV1o8KtrU9v; Fri, 18 Oct 2024 16:39:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1729262357; bh=Gi43P9a/BLgdwrzvLfLrQ4OFlvq23EQb2JnzkqzJYOk=;
	h=From:To:Subject:Date:MIME-Version;
	b=Ar7Lrt7kmKp72IdK/gl8ZmfvfNh9ki0llxZ3knw/XSkxOyisUb05riuY+KyR4s4PG
	 wVmdtOkaqcLpZZl4adnU6Wv0fMnn5OHfQvJt71x1P4Rx0Uq9QXKsdxgtXEPDcsYLlv
	 9eqJb/vO9RtrK/9VE4x0CU69ueu28y/EZV8XW1nfXUAtv/Z4OQbR7Uxb/K2yPkMsRB
	 vNKJBXo5oe1Kis4vt3pnrQQhUxxNi7hyIgM1arGhrevwO/5zMphdYXqz7qM2BA+Oh9
	 zlpyLHmCXWgZylKG2KF+ArJ0Ti0JvU55TBLM/lDYnyP841sRrKAEGqAiutj7VMkIyX
	 7VmmrWUJyXAjA==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V1 2/4] drivers pps/generators: add dummy PPS generator
Date: Fri, 18 Oct 2024 16:39:13 +0200
Message-Id: <20241018143915.3877425-3-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018143915.3877425-1-giometti@enneenne.com>
References: <20241018143915.3877425-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHAAvZVynokt+Fh/gYDT31LaOx6QueTeFPHeTaLAB2yNNvVYm+ULZem6GPFLtkjZIaBzKvPQPDfdfXJ5r3HVGHGIpQxY7dxJ74Ol8YEQPP2LRwdjphB0
 brM0IUQaDydHFrXNuJkRtknfGz/+hh+qE6oxt4zjiB48Z31BgigC1J0KRJo6iodERF2ZHclOzZJzWj4bFfkwZJnz5tjna/7vH/W4wHDEwmoqy03bixNwd/Rh
 qnHucwWlbKCtCAQwm+P7XHS8FhPAVmGXEaidkbIYkivGbhrYKgCXKXGtRN5meQimW/8lzY9OJJCkoSsNALk1IIulmNFmTvUa3K/RJTzClDrz24CS9hkJgWjd
 vF9+fd/4Y5pDvbZFN7cbd2/+miOwHq+0STYHdlLb2FkP3Hd/M2vhti1cQXKnTSP8TcNJnjKIUnRo9GUdsgX2n2DDSE5In2cqZzIkZtWXj5iAgfXzEYR7AQVF
 5yS4njpFXSHK+OOTWrHy57Sbign6DAEGcvR2rMj6++Gr7aaarTrTq/NyvdW36pq7NgvR/Af8qt0XmQojrgRpxN3HeY0KjzSFAS0xtNXu4sLhioUcrcRIumKI
 Rwi3WbNekPLEuzzwpsd6hCTjbD6wQlUWT2jjsoJeMixIWgfEx8G2pSdjy0JHG76lpF9rYFaRm69W2+urZpTKDbDJ9uCw8CrImFmIgzW25LfLlXXHe7hSaY2a
 FT4xAoYrQpWGjA2ikn6fsd6CsRJm133x

This dummy PPS generator can be used for debugging and documentation
purposes.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/pps/generators/Kconfig         |  9 +++
 drivers/pps/generators/Makefile        |  1 +
 drivers/pps/generators/pps_gen-dummy.c | 96 ++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/pps/generators/pps_gen-dummy.c

diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
index 5edbfdb8bd92..0c70df454caa 100644
--- a/drivers/pps/generators/Kconfig
+++ b/drivers/pps/generators/Kconfig
@@ -14,6 +14,15 @@ menuconfig PPS_GENERATOR
 
 if PPS_GENERATOR
 
+config PPS_GENERATOR_DUMMY
+        tristate "Dummy PPS generator (Testing generator, use for debug)"
+        help
+          If you say yes here you get support for a PPS debugging generator
+          (which actual generates no PPS signal at all).
+
+          This driver can also be built as a module.  If so, the module
+          will be called pps_gen-dummy.
+
 config PPS_GENERATOR_PARPORT
 	tristate "Parallel port PPS signal generator"
 	depends on PARPORT && BROKEN
diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index 034a78edfa26..dc1aa5a4688b 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -6,6 +6,7 @@
 pps_gen_core-y			:= pps_gen.o sysfs.o
 obj-$(CONFIG_PPS_GENERATOR)	:= pps_gen_core.o
 
+obj-$(CONFIG_PPS_GENERATOR_DUMMY)   += pps_gen-dummy.o
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
 
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/generators/pps_gen-dummy.c b/drivers/pps/generators/pps_gen-dummy.c
new file mode 100644
index 000000000000..b284c200cbe5
--- /dev/null
+++ b/drivers/pps/generators/pps_gen-dummy.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PPS dummy generator
+ *
+ * Copyright (C) 2024 Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/timer.h>
+#include <linux/random.h>
+#include <linux/pps_gen_kernel.h>
+
+static struct pps_gen_device *pps_gen;
+static struct timer_list ktimer;
+
+static unsigned int get_random_delay(void)
+{
+	unsigned int delay = get_random_u8() & 0x0f;
+
+	return (delay + 1) * HZ;
+}
+
+/*
+ * The kernel timer
+ */
+
+static void pps_gen_ktimer_event(struct timer_list *unused)
+{
+	pps_gen_event(pps_gen, PPS_GEN_EVENT_MISSEDPULSE, NULL);
+}
+
+/*
+ * PPS Generator methods
+ */
+
+static int pps_gen_dummy_get_time(struct pps_gen_device *pps_gen,
+					struct timespec64 *time)
+{
+	struct system_time_snapshot snap;
+
+	ktime_get_snapshot(&snap);
+	*time = ktime_to_timespec64(snap.real);
+
+	return 0;
+}
+
+static int pps_gen_dummy_enable(struct pps_gen_device *pps_gen, bool enable)
+{
+	if (enable)
+		mod_timer(&ktimer, jiffies + get_random_delay());
+	else
+		del_timer_sync(&ktimer);
+
+	return 0;
+}
+
+/*
+ * The PPS info struct
+ */
+
+static struct pps_gen_source_info pps_gen_dummy_info = {
+	.use_system_clock	= true,
+	.get_time		= pps_gen_dummy_get_time,
+	.enable			= pps_gen_dummy_enable,
+};
+
+/*
+ * Module staff
+ */
+
+static void __exit pps_gen_dummy_exit(void)
+{
+	del_timer_sync(&ktimer);
+	pps_gen_unregister_source(pps_gen);
+}
+
+static int __init pps_gen_dummy_init(void)
+{
+	pps_gen = pps_gen_register_source(&pps_gen_dummy_info);
+	if (IS_ERR(pps_gen))
+		return PTR_ERR(pps_gen);
+
+	timer_setup(&ktimer, pps_gen_ktimer_event, 0);
+
+	return 0;
+}
+
+module_init(pps_gen_dummy_init);
+module_exit(pps_gen_dummy_exit);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
+MODULE_DESCRIPTION("LinuxPPS dummy generator");
+MODULE_LICENSE("GPL");
-- 
2.34.1


