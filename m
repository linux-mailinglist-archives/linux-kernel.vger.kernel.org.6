Return-Path: <linux-kernel+bounces-434030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33749E606F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807732842F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E31C8FBA;
	Thu,  5 Dec 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="JMs95la5"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D11CDFCE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437368; cv=none; b=LXNzdCBDeP0HKRjnVsTAyJCi81Ai5Ojs64hef2Ye+GXIW1StS8BTbSUK5jdB48Ssec5CbSrkxgBwJxTdgXWQgUS3pw+STPI/Q+b2iSqvW24bTWUoSi+0B83jtL7erZGbONACDhgj6dyoHKD8Ay0c+hFtbmwsUOA7nd8A6EdGUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437368; c=relaxed/simple;
	bh=d8HrQDCVcr8oHaNUZbKI6K/ZXmZCBRKzc7jggl9VdZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFv/cJQY6UMieQreFi44UKXYMxeiBdVjFxrOzOm4WV9fPwFU0eqyuqQz590ggVXOiNCyIeNT5f5ilp6Sni2wqMHefQBRSxto9ZQpTZZr6D98WLRsOL8+jRoUloAzOFZKnJt/uuPqUT3iLbAvvqGqQu70kgHtcwXIpjcphsdydEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=JMs95la5; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from localhost.localdomain (c-73-204-82-80.hsd1.fl.comcast.net [73.204.82.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 18DF31635A5;
	Thu,  5 Dec 2024 23:22:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1733437357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nRLupu4JH3T/Yi2wqWYVCgOiaSoWVY88YqycFTyIcC8=;
	b=JMs95la5pQkkJOReCW3H2l1LqAocxEaSOG6IgARZ3eXRUTC3pP+Al/VlAOOliE4Z8POnRI
	1mBVM37srDjcrZbOfGrj3CWMudAh8aCfAITIrl8OAhDeJDTL2/Pd2yoR8m9Wz2qwdd8Sm/
	pkMlF5ELHWGu2IMvLPnV44td654XnAg=
From: David Heidelberg <david@ixit.cz>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Heidelberg <david@ixit.cz>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] samples: add a sample list module
Date: Thu,  5 Dec 2024 17:18:39 -0500
Message-ID: <20241205221928.1155984-2-david@ixit.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sample list module that creates a proc entry /proc/sample_list
and registers read/write file operations.

Each write to the proc will copy the buffer
and store it in a data structure.

Each read from the proc will populate the read buffer with
list entries, up to the read length (buffer size).

Signed-off-by: David Heidelberg <david@ixit.cz>
---
I would love to receive feedback on this list implementation approach.
If there are any implementation mistakes, I am open to revising
this sample to make it more accurate.

 samples/Kconfig       |  13 +++++
 samples/Makefile      |   1 +
 samples/list/Makefile |   2 +
 samples/list/list.c   | 125 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 samples/list/Makefile
 create mode 100644 samples/list/list.c

diff --git ./samples/Kconfig ./samples/Kconfig
index b288d9991d27..7bc9c2c85599 100644
--- ./samples/Kconfig
+++ ./samples/Kconfig
@@ -128,6 +128,19 @@ config SAMPLE_RPMSG_CLIENT
 	  to communicate with an AMP-configured remote processor over
 	  the rpmsg bus.
 
+config SAMPLE_LIST
+	tristate "Build list implementation sample"
+	depends on PROC_FS
+	help
+	  Build a sample list module that creates a proc entry
+	  /proc/sample_list and registers read/write file operations.
+
+	  Each write to the proc will copy the buffer
+	  and store it in a data structure.
+
+	  Each read from the proc will populate the read buffer with
+	  list entries, up to the read length (buffer size).
+
 config SAMPLE_LIVEPATCH
 	tristate "Build live patching samples -- loadable modules only"
 	depends on LIVEPATCH && m
diff --git ./samples/Makefile ./samples/Makefile
index b85fa64390c5..68158af60c96 100644
--- ./samples/Makefile
+++ ./samples/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SAMPLE_KFIFO)		+= kfifo/
 obj-$(CONFIG_SAMPLE_KOBJECT)		+= kobject/
 obj-$(CONFIG_SAMPLE_KPROBES)		+= kprobes/
 subdir-$(CONFIG_SAMPLE_LANDLOCK)	+= landlock
+obj-$(CONFIG_SAMPLE_LIST)		+= list/
 obj-$(CONFIG_SAMPLE_LIVEPATCH)		+= livepatch/
 subdir-$(CONFIG_SAMPLE_PIDFD)		+= pidfd
 obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+= qmi/
diff --git ./samples/list/Makefile ./samples/list/Makefile
new file mode 100644
index 000000000000..8e77d97aaa9c
--- /dev/null
+++ ./samples/list/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SAMPLE_LIST) += list.o
diff --git ./samples/list/list.c ./samples/list/list.c
new file mode 100644
index 000000000000..1db693ee65b3
--- /dev/null
+++ ./samples/list/list.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * list.c - Kernel list sample code
+ *
+ * Copyright 2024 David Heidelberg <david@ixit.cz>
+ */
+
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+
+#define PROC_NAME "list_sample"
+#define BUFFER_SIZE 128
+
+LIST_HEAD(data_list);
+
+struct data_node {
+	struct list_head list;
+	char data[BUFFER_SIZE];
+};
+
+static struct proc_dir_entry *proc_entry;
+
+static ssize_t proc_write(struct file *file, const char __user *buffer, size_t count, loff_t *pos)
+{
+	struct data_node *new_node;
+
+	if (count >= BUFFER_SIZE)
+		count = BUFFER_SIZE - 1;
+
+	new_node = kmalloc(sizeof(*new_node), GFP_KERNEL);
+	if (!new_node)
+		return -ENOMEM;
+
+	if (strncpy_from_user(new_node->data, buffer, count) < 0) {
+		kfree(new_node);
+		return -EFAULT;
+	}
+
+	list_add_tail(&new_node->list, &data_list);
+
+	return count;
+}
+
+/*
+ * Several copy_to_user() is a bit less efficient
+ * comparing to list_for_each_entry_safe, but makes code simpler.
+ */
+static ssize_t proc_read(struct file *file, char __user *buffer, size_t count, loff_t *pos)
+{
+	static struct list_head *start, *cur;
+	struct data_node *node;
+	size_t data_len, batch_len = 0;
+	char temp_buf[2 * BUFFER_SIZE] = {0};
+
+	if (*pos == 0) {
+		start = &data_list;
+		cur = &data_list;
+	}
+
+	if (*pos != 0 && cur->next == start)
+		return 0;
+
+	if (list_empty(cur))
+		return 0;
+
+	while (batch_len < BUFFER_SIZE) {
+		node = list_entry(cur->next, struct data_node, list);
+		data_len = snprintf(temp_buf + strlen(temp_buf),
+				     BUFFER_SIZE - strlen(temp_buf),
+				     "%s",
+				     node->data);
+		if (data_len + batch_len > BUFFER_SIZE)
+			break;
+
+		batch_len += data_len;
+
+		cur = cur->next;
+		if (cur->next == start)
+			break;
+	}
+
+	if (copy_to_user(buffer, temp_buf, batch_len))
+		return -EFAULT;
+
+	*pos += batch_len;
+
+	return batch_len;
+}
+
+static const struct proc_ops proc_fops = {
+	.proc_read = proc_read,
+	.proc_write = proc_write,
+};
+
+static int __init list_sample_init(void)
+{
+	proc_entry = proc_create(PROC_NAME, 0666, NULL, &proc_fops);
+	if (!proc_entry) {
+		pr_err("Failed to create proc entry\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void __exit list_sample_exit(void)
+{
+	struct data_node *node, *tmp;
+
+	proc_remove(proc_entry);
+
+	list_for_each_entry_safe(node, tmp, &data_list, list) {
+		list_del(&node->list);
+		kfree(node);
+	}
+}
+
+module_init(list_sample_init);
+module_exit(list_sample_exit);
+
+MODULE_AUTHOR("David Heidelberg");
+MODULE_DESCRIPTION("List sample module.");
+MODULE_LICENSE("GPL v2");
-- 
2.45.2


