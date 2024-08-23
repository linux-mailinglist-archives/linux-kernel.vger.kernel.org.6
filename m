Return-Path: <linux-kernel+bounces-298720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC15D95CA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDB9B22C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF128EA;
	Fri, 23 Aug 2024 10:39:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2418308E;
	Fri, 23 Aug 2024 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409585; cv=none; b=gtZoo1hu0bhPkjdC49HJdLJgOz1rgEjsV36B6Dlo9wi0ZBgbB9nLUIkgaLApBueuZlqU6aaLjrQy74qxtjDQJwdKTEAiKXrbR7JnZx7Bhk1kQ4JQn4ia+Unx3qLR2TuXFjQVhcOAs+tDcX7NnNrUAqBY42RC85nN1EORKNuXq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409585; c=relaxed/simple;
	bh=N9KQYoHIt8wWtFmEO28dJFEBDCKvzUkXQxi3GVbTIyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHkwnuL5LQDuexc8VOGh9BS2GbFFi3IKhUYmD5D6fIspWfAsvtgwBBctxwEksMGJUy98Y94STz3m1dQJDsTA8yGQlnkCjlL80IQUqknr9kFFjOyfi8cU+dysqNi6xudQVt9mqxQXehlnA6zAn9Kst5nKyVwtIp+DK9hlUXY4HkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8AxmOnrZshmh1UdAA--.60573S3;
	Fri, 23 Aug 2024 18:39:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMAxYeHqZshm6jcfAA--.4588S2;
	Fri, 23 Aug 2024 18:39:38 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: corbet@lwn.net,
	alexs@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	gaoliang@loongson.cn,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	zhangtianyang@loongson.cn,
	yijun@loongson.cn,
	mhocko@suse.com,
	akpm@linux-foundation.org,
	dianders@chromium.org,
	maobibo@loongson.cn,
	xry111@xry111.site,
	zhaotianrui@loongson.cn,
	nathan@kernel.org,
	yangtiezhu@loongson.cn,
	zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v11 3/7] LoongArch: Move irqchip function prototypes to irq-loongson.h
Date: Fri, 23 Aug 2024 18:39:32 +0800
Message-Id: <20240823103936.25092-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxYeHqZshm6jcfAA--.4588S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKrykGw1rWryxWryfCw18Xrc_yoWxGFy8pF
	W5Aa92vr43GayUWr15GFW5Ary3A3WfKrZrtayxXa43ZrZ8Cw1DCF1UAFn8urn7ArsrWa42
	9r1FqF4UuFn8AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUx2Q6DUUUU

From: Huacai Chen <chenhuacai@loongson.cn>

Some irqchip functions are only for internal use by irqchip drivers, so
move their prototypes from asm/irq.h to drivers/irqchip/irq-loongson.h.

All related driver files include the new irq-loongson.h.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 arch/loongarch/include/asm/irq.h       | 14 --------------
 drivers/irqchip/irq-loongarch-cpu.c    |  2 ++
 drivers/irqchip/irq-loongson-eiointc.c |  2 ++
 drivers/irqchip/irq-loongson-htvec.c   |  2 ++
 drivers/irqchip/irq-loongson-liointc.c |  2 ++
 drivers/irqchip/irq-loongson-pch-lpc.c |  2 ++
 drivers/irqchip/irq-loongson-pch-msi.c |  1 +
 drivers/irqchip/irq-loongson-pch-pic.c |  2 ++
 drivers/irqchip/irq-loongson.h         | 25 +++++++++++++++++++++++++
 9 files changed, 38 insertions(+), 14 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongson.h

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 480418bc5071..65503c9eb529 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -88,20 +88,6 @@ struct acpi_madt_bio_pic;
 struct acpi_madt_msi_pic;
 struct acpi_madt_lpc_pic;
 
-int liointc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_lio_pic *acpi_liointc);
-int eiointc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_eio_pic *acpi_eiointc);
-
-int htvec_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_ht_pic *acpi_htvec);
-int pch_lpc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_lpc_pic *acpi_pchlpc);
-int pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi);
-int pch_pic_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_bio_pic *acpi_pchpic);
-int find_pch_pic(u32 gsi);
 struct fwnode_handle *get_pch_msi_handle(int pci_segment);
 
 extern struct acpi_madt_lio_pic *acpi_liointc;
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 9d8f2c406043..83f7492290a8 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -13,6 +13,8 @@
 #include <asm/loongarch.h>
 #include <asm/setup.h>
 
+#include "irq-loongson.h"
+
 static struct irq_domain *irq_domain;
 struct fwnode_handle *cpuintc_handle;
 
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index b1f2080be2be..34b5ca2f5e62 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -17,6 +17,8 @@
 #include <linux/syscore_ops.h>
 #include <asm/numa.h>
 
+#include "irq-loongson.h"
+
 #define EIOINTC_REG_NODEMAP	0x14a0
 #define EIOINTC_REG_IPMAP	0x14c0
 #define EIOINTC_REG_ENABLE	0x1600
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 0bff728b25e3..5da02c7ad0b3 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -17,6 +17,8 @@
 #include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
 
+#include "irq-loongson.h"
+
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 7c4fe7ab4b83..2b1bd4a96665 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -22,6 +22,8 @@
 #include <asm/loongson.h>
 #endif
 
+#include "irq-loongson.h"
+
 #define LIOINTC_CHIP_IRQ	32
 #define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loongson-pch-lpc.c
index 9b35492fb6be..2d4c3ec128b8 100644
--- a/drivers/irqchip/irq-loongson-pch-lpc.c
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/syscore_ops.h>
 
+#include "irq-loongson.h"
+
 /* Registers */
 #define LPC_INT_CTL		0x00
 #define LPC_INT_ENA		0x04
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 2242f63c66fc..d43731878800 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include "irq-msi-lib.h"
+#include "irq-loongson.h"
 
 static int nr_pics;
 
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index cbaef65e804c..69efda35a8e7 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -17,6 +17,8 @@
 #include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
 
+#include "irq-loongson.h"
+
 /* Registers */
 #define PCH_PIC_MASK		0x20
 #define PCH_PIC_HTMSI_EN	0x40
diff --git a/drivers/irqchip/irq-loongson.h b/drivers/irqchip/irq-loongson.h
new file mode 100644
index 000000000000..b155f1258ed5
--- /dev/null
+++ b/drivers/irqchip/irq-loongson.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef _DRIVERS_IRQCHIP_IRQ_LOONGSON_H
+#define _DRIVERS_IRQCHIP_IRQ_LOONGSON_H
+
+int find_pch_pic(u32 gsi);
+
+int liointc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lio_pic *acpi_liointc);
+int eiointc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_eio_pic *acpi_eiointc);
+
+int htvec_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_ht_pic *acpi_htvec);
+int pch_lpc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc);
+int pch_pic_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_bio_pic *acpi_pchpic);
+int pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi);
+
+#endif /* _DRIVERS_IRQCHIP_IRQ_LOONGSON_H */
-- 
2.20.1


