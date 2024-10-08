Return-Path: <linux-kernel+bounces-355329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0609950BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE17F1C24FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D01DF996;
	Tue,  8 Oct 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="krMlnzVS"
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950BC1DF740
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395628; cv=none; b=YrXFUpi8+3L7XMTF275mOLqiQinYJYGy3E+4LaRFbQyiTn45MHmdAoFLM4wT9h71p9dwHAzWUS6zPN87ZyeDcUDMHLk1h8NKp9rjvMiD52r9jRZgpbn59ZjZeWW1HWxuIgiAQVv3hBCp6/vt80qjt6tQ5quGZAkqRCsELPpfbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395628; c=relaxed/simple;
	bh=EnafVLfyKyCevuDFetyQ8ecmUixnyfPmO4/Rq7Wievk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5NPy4+NIyAkpnXfihM52l0ceKHJbgRrPcNCi//N6FH4MhyH8+MY9jYCXyJ9DdZF9VkKJBRpu/0HYrrKgUiGZeQGrDfOoVwWTZ5CggoPsOdxhZ4wcQKLWj2GUIYxA3AbGgRCN6P9OmIngGOf1DXXrkJDm3wy/00TLfCnBpUl3PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=krMlnzVS; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id yAbisgixkbsngyAbksUWVN; Tue, 08 Oct 2024 15:50:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728395436; bh=EnafVLfyKyCevuDFetyQ8ecmUixnyfPmO4/Rq7Wievk=;
	h=From:To:Subject:Date:MIME-Version;
	b=krMlnzVSG3z23nSRs1wLxIuSC7HgjfGCHoURuAI0FhpeU/J/7uFmFWUd+fbzmxR0N
	 Muusgd17JWQKDFA5B4CDCpXgqmA9s1GQfSVrEcTrfOuGzlO9Zn/SNiL2MKsNiAZQSx
	 sVZk3wXFfZcdsCLY7e1BK5GXWaYnDQEVfaNUdJ2QmtM61bAyAdvb9k+aS96WJKKO7x
	 pc9BnP7bfCBNU6qyaek+2Ym0a3WJ7Y0MH7ypYHNryar6xrjIaKvFSMKxS+ba/ANDlI
	 7YpyFwhWRDlX19OYkKVBQjfgcB3IhMFKpToMiG/WpsHkqTxcuCfRhE40OrcowFNfhM
	 EU5QiPEINatqA==
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
Subject: [RFC 1/3] drivers pps: add PPS generators support
Date: Tue,  8 Oct 2024 15:50:31 +0200
Message-Id: <20241008135033.3171915-2-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008135033.3171915-1-giometti@enneenne.com>
References: <20241008135033.3171915-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNId7OsPM9/yZZ9XGwkfUE+O776vYmSDNIeh1CKkvBDeby2unYt1IXJLTyfagacrH6nvr/ryfWqjs5NAMcAbrwGFoF8nKMDvTdUH9Ll3b3WnPcmyeiI7
 WEmgqOOn8a8ZFNls33VAnOD5kgwJE+c7pHKI1Db+DBOgvJqshcvC45kCOMomdioUOA5ir/RM0TGLRUhMdBlSJj0bnbaMROi6AaLD2mHNe/DxP466tTSNwSVu
 5NPjVlw6Tz5YywG/JnvjFBR/klq8X6GZ6DbdhTFMuT5QwHnaylyPhVhXSimuJ2l1HdU1yQXWgF+/XJNK/4t+oaln6hZwMHhL0jz2705WDAi8w2XAQgY7IkEO
 5Nz3TH7D+1ek3nXvHUVVhNy9ZdrALQanx1ft8s62V4OpDWr74od7/5P4JMgvu7D6DOfqTUheyVdrHDQ94VfoJw8rjjkj5ZCs4nebFFALBjhVdfv/EdvLDzFh
 cPCu2ojTqorycdL7oGU36u+zJ8FC3e1ntE/FlvjGT+WlYMcbr6XsP+UZKpMMfnvVvf6LbL6QtahzhfRpBtLt80a/YlUZw0zygwranQxTMhybeCgMECDzPu7n
 4q06S7iZAW5fStz+hlTOcXNWhVX033sEIrxWhIQe4xMehqSrbYx0IsAap/Sxe1nSZiNNQBEJlcsD2+Xw2FlPZfTzS1HoCtfucjAO9Mt4hzk/+AQoKrNSU62s
 xcijyrs64+AP6CACetRFMPiWCxhHAKFv

Sometimes one needs to be able not only to catch PPS signals but to
produce them also. For example, running a distributed simulation,
which requires computers' clock to be synchronized very tightly.

This patch adds PPS generators class in order to have a well-defined
interface for these devices.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/pps/Makefile                   |   3 +-
 drivers/pps/generators/Kconfig         |  19 +-
 drivers/pps/generators/Makefile        |   4 +
 drivers/pps/generators/pps_gen-dummy.c |  83 ++++++++
 drivers/pps/generators/pps_gen.c       | 283 +++++++++++++++++++++++++
 drivers/pps/generators/sysfs.c         |  89 ++++++++
 include/linux/pps_gen_kernel.h         |  57 +++++
 include/uapi/linux/pps_gen.h           |  35 +++
 8 files changed, 571 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pps/generators/pps_gen-dummy.c
 create mode 100644 drivers/pps/generators/pps_gen.c
 create mode 100644 drivers/pps/generators/sysfs.c
 create mode 100644 include/linux/pps_gen_kernel.h
 create mode 100644 include/uapi/linux/pps_gen.h

diff --git a/drivers/pps/Makefile b/drivers/pps/Makefile
index ceaf65cc1f1d..0aea394d4e4d 100644
--- a/drivers/pps/Makefile
+++ b/drivers/pps/Makefile
@@ -6,6 +6,7 @@
 pps_core-y			:= pps.o kapi.o sysfs.o
 pps_core-$(CONFIG_NTP_PPS)	+= kc.o
 obj-$(CONFIG_PPS)		:= pps_core.o
-obj-y				+= clients/ generators/
+obj-y				+= clients/
+obj-$(CONFIG_PPS_GENERATOR)	+= generators/
 
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
index d615e640fcad..e3dfe31609ba 100644
--- a/drivers/pps/generators/Kconfig
+++ b/drivers/pps/generators/Kconfig
@@ -3,7 +3,22 @@
 # PPS generators configuration
 #
 
-comment "PPS generators support"
+menuconfig PPS_GENERATOR
+	tristate "PPS generators support"
+	help
+	  PPS generators are special hardware which are able to produce PPS
+	  (Pulse Per Second) signals.
+
+if PPS_GENERATOR
+
+config PPS_GENERATOR_DUMMY
+        tristate "Dummy PPS generator (Testing generator, use for debug)"
+        help
+          If you say yes here you get support for a PPS debugging generator
+          (which actual generates no PPS signal at all).
+
+          This driver can also be built as a module.  If so, the module
+          will be called pps_gen-dummy.
 
 config PPS_GENERATOR_PARPORT
 	tristate "Parallel port PPS signal generator"
@@ -12,3 +27,5 @@ config PPS_GENERATOR_PARPORT
 	  If you say yes here you get support for a PPS signal generator which
 	  utilizes STROBE pin of a parallel port to send PPS signals. It uses
 	  parport abstraction layer and hrtimers to precisely control the signal.
+
+endif # PPS_GENERATOR
diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index 2589fd0f2481..dc1aa5a4688b 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -3,6 +3,10 @@
 # Makefile for PPS generators.
 #
 
+pps_gen_core-y			:= pps_gen.o sysfs.o
+obj-$(CONFIG_PPS_GENERATOR)	:= pps_gen_core.o
+
+obj-$(CONFIG_PPS_GENERATOR_DUMMY)   += pps_gen-dummy.o
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
 
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/generators/pps_gen-dummy.c b/drivers/pps/generators/pps_gen-dummy.c
new file mode 100644
index 000000000000..2d257f3f9bf9
--- /dev/null
+++ b/drivers/pps/generators/pps_gen-dummy.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PPS dummy generator
+ *
+ * Copyright (C) 2024   Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/pps_gen_kernel.h>
+
+/*
+ * Global variables
+ */
+
+static struct pps_gen_device *pps_gen;
+
+/*
+ * PPS Generator methods
+ */
+
+static int pps_gen_dummy_get_time(struct pps_gen_device *pps_gen,
+                                        struct timespec64 *time)
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
+	/* always enabled */
+	return 0;
+}
+
+/*
+ * The PPS info struct
+ */
+
+static struct pps_gen_source_info pps_gen_dummy_info = {
+        .name			= "dummy",
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
+        dev_info(pps_gen->dev, "dummy PPS generator unregistered\n");
+
+        pps_gen_unregister_source(pps_gen);
+}
+
+static int __init pps_gen_dummy_init(void)
+{
+        pps_gen = pps_gen_register_source(&pps_gen_dummy_info);
+        if (IS_ERR(pps_gen)) {
+                pr_err("cannot register PPS generator\n");
+                return PTR_ERR(pps_gen);
+        }
+
+        dev_info(pps_gen->dev, "dummy PPS generator registered\n");
+
+        return 0;
+}
+
+module_init(pps_gen_dummy_init);
+module_exit(pps_gen_dummy_exit);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
+MODULE_DESCRIPTION("LinuxPPS dummy generator");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
new file mode 100644
index 000000000000..40b05087b4b4
--- /dev/null
+++ b/drivers/pps/generators/pps_gen.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PPS generators core file
+ *
+ * Copyright (C) 2024   Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/uaccess.h>
+#include <linux/idr.h>
+#include <linux/mutex.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/pps_gen_kernel.h>
+#include <linux/slab.h>
+
+/*
+ * Local variables
+ */
+
+static int pps_gen_major;
+static struct class *pps_gen_class;
+
+static DEFINE_MUTEX(pps_gen_idr_lock);
+static DEFINE_IDR(pps_gen_idr);
+
+/*
+ * Char device methods
+ */
+
+static long pps_gen_cdev_ioctl(struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	struct pps_gen_device *pps_gen = file->private_data;
+	unsigned int __user *uiuarg = (unsigned int __user *) arg;
+	unsigned int status;
+	int ret;
+
+	switch (cmd) {
+	case PPS_GEN_SETENABLE:
+		dev_dbg(pps_gen->dev, "PPS_GEN_SETENABLE\n");
+
+		ret = get_user(status, uiuarg);
+		if (ret)
+			return -EFAULT;
+
+		ret = pps_gen->info.enable(pps_gen, status);
+		if (ret)
+			return ret;
+		pps_gen->enabled = status;
+
+		break;
+
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_COMPAT
+static long pps_gen_cdev_compat_ioctl(struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
+	return pps_gen_cdev_ioctl(file, cmd, arg);
+}
+#else
+#define pps_gen_cdev_compat_ioctl	NULL
+#endif
+
+static struct pps_gen_device *pps_gen_idr_get(unsigned long id)
+{
+	struct pps_gen_device *pps_gen;
+
+	mutex_lock(&pps_gen_idr_lock);
+	pps_gen = idr_find(&pps_gen_idr, id);
+	if (pps_gen)
+		kobject_get(&pps_gen->dev->kobj);
+
+	mutex_unlock(&pps_gen_idr_lock);
+	return pps_gen;
+}
+
+static int pps_gen_cdev_open(struct inode *inode, struct file *file)
+{
+	struct pps_gen_device *pps_gen = pps_gen_idr_get(iminor(inode));
+
+	if (!pps_gen)
+		return -ENODEV;
+
+	file->private_data = pps_gen;
+	return 0;
+}
+
+static int pps_gen_cdev_release(struct inode *inode, struct file *file)
+{
+	struct pps_gen_device *pps_gen = file->private_data;
+
+	WARN_ON(pps_gen->id != iminor(inode));
+	kobject_put(&pps_gen->dev->kobj);
+	return 0;
+}
+
+/*
+ * Char device stuff
+ */
+
+static const struct file_operations pps_gen_cdev_fops = {
+	.owner		= THIS_MODULE,
+	.compat_ioctl	= pps_gen_cdev_compat_ioctl,
+	.unlocked_ioctl	= pps_gen_cdev_ioctl,
+	.open		= pps_gen_cdev_open,
+	.release	= pps_gen_cdev_release,
+};
+
+static void pps_gen_device_destruct(struct device *dev)
+{
+	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+
+	pr_debug("deallocating pps-gen%d\n", pps_gen->id);
+	kfree(dev);
+	kfree(pps_gen);
+}
+
+static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
+{
+	int err;
+	dev_t devt;
+
+	mutex_lock(&pps_gen_idr_lock);
+
+	err = idr_alloc(&pps_gen_idr, pps_gen, 0, PPS_GEN_MAX_SOURCES,
+					GFP_KERNEL);
+	if (err < 0) {
+		if (err == -ENOSPC) {
+			pr_err("%s: too many PPS sources in the system\n",
+			       pps_gen->info.name);
+			err = -EBUSY;
+		}
+		goto out_unlock;
+	}
+	pps_gen->id = err;
+
+	devt = MKDEV(pps_gen_major, pps_gen->id);
+	pps_gen->dev = device_create(pps_gen_class, pps_gen->info.parent, devt,
+					pps_gen, "pps-gen%d", pps_gen->id);
+	if (IS_ERR(pps_gen->dev)) {
+		err = PTR_ERR(pps_gen->dev);
+		goto free_idr;
+	}
+
+	/* Override the release function with our own */
+	pps_gen->dev->release = pps_gen_device_destruct;
+
+	pr_debug("generator %s got cdev (%d:%d)\n",
+			pps_gen->info.name, pps_gen_major, pps_gen->id);
+
+	kobject_get(&pps_gen->dev->kobj);
+	mutex_unlock(&pps_gen_idr_lock);
+	return 0;
+
+free_idr:
+	idr_remove(&pps_gen_idr, pps_gen->id);
+out_unlock:
+	mutex_unlock(&pps_gen_idr_lock);
+	return err;
+}
+
+static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
+{
+	pr_debug("unregistering pps-gen%d\n", pps_gen->id);
+	device_destroy(pps_gen_class, pps_gen->dev->devt);
+
+	/* Now we can release the ID for re-use */
+	mutex_lock(&pps_gen_idr_lock);
+	idr_remove(&pps_gen_idr, pps_gen->id);
+	kobject_put(&pps_gen->dev->kobj);
+	mutex_unlock(&pps_gen_idr_lock);
+}
+
+/*
+ * Exported functions
+ */
+
+/* pps_gen_register_source - add a PPS generator in the system
+ * @info: the PPS generator info struct
+ *
+ * The function returns, in case of success, the PPS generaor device. Otherwise
+ * ERR_PTR(errno).
+ */
+
+struct pps_gen_device *pps_gen_register_source(struct pps_gen_source_info *info)
+{
+        struct pps_gen_device *pps_gen;
+        int err;
+
+        pps_gen = kzalloc(sizeof(struct pps_gen_device), GFP_KERNEL);
+        if (pps_gen == NULL) {
+                err = -ENOMEM;
+                goto pps_gen_register_source_exit;
+        }
+        pps_gen->info = *info;
+	pps_gen->enabled = false;
+
+        /* Create the char device */
+        err = pps_gen_register_cdev(pps_gen);
+        if (err < 0) {
+                pr_err("%s: unable to create char device\n",
+                                        info->name);
+                goto kfree_pps_gen;
+        }
+
+        dev_info(pps_gen->dev, "new PPS generator %s\n", info->name);
+
+        return pps_gen;
+
+kfree_pps_gen:
+        kfree(pps_gen);
+
+pps_gen_register_source_exit:
+        pr_err("%s: unable to register generaor\n", info->name);
+
+        return ERR_PTR(err);
+}
+EXPORT_SYMBOL(pps_gen_register_source);
+
+/* pps_gen_unregister_source - remove a PPS generator from the system
+ * @pps_gen: the PPS generator
+ */
+
+void pps_gen_unregister_source(struct pps_gen_device *pps_gen)
+{
+        pps_gen_unregister_cdev(pps_gen);
+}
+EXPORT_SYMBOL(pps_gen_unregister_source);
+
+/*
+ * Module stuff
+ */
+
+static void __exit pps_gen_exit(void)
+{
+	class_destroy(pps_gen_class);
+	__unregister_chrdev(pps_gen_major, 0, PPS_GEN_MAX_SOURCES, "pps-gen");
+}
+
+static int __init pps_gen_init(void)
+{
+	pps_gen_class = class_create("pps-gen");
+	if (IS_ERR(pps_gen_class)) {
+		pr_err("failed to allocate class\n");
+		return PTR_ERR(pps_gen_class);
+	}
+	pps_gen_class->dev_groups = pps_gen_groups;
+
+	pps_gen_major = __register_chrdev(0, 0, PPS_GEN_MAX_SOURCES, "pps-gen",
+				      &pps_gen_cdev_fops);
+	if (pps_gen_major < 0) {
+		pr_err("failed to allocate char device region\n");
+		goto remove_class;
+	}
+
+	return 0;
+
+remove_class:
+	class_destroy(pps_gen_class);
+	return pps_gen_major;
+}
+
+subsys_initcall(pps_gen_init);
+module_exit(pps_gen_exit);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
+MODULE_DESCRIPTION("LinuxPPS generators support");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pps/generators/sysfs.c b/drivers/pps/generators/sysfs.c
new file mode 100644
index 000000000000..247030d138e1
--- /dev/null
+++ b/drivers/pps/generators/sysfs.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PPS generators sysfs support
+ *
+ * Copyright (C) 2024   Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/pps_gen_kernel.h>
+
+/*
+ * Attribute functions
+ */
+
+static ssize_t system_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+        struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+
+        return sysfs_emit(buf, "%d\n", pps_gen->info.use_system_clock);
+}
+static DEVICE_ATTR_RO(system);
+
+static ssize_t time_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+        struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+	struct timespec64 time;
+	int ret;
+
+        ret = pps_gen->info.get_time(pps_gen, &time);
+        if (ret)
+                return ret;
+
+        return sysfs_emit(buf, "%llu %09lu\n", time.tv_sec, time.tv_nsec);
+}
+static DEVICE_ATTR_RO(time);
+
+static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+        struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+	bool status;
+	unsigned int enable;
+        int ret;
+
+	ret = sscanf(buf, "%u", &enable);
+        if (ret != 1)
+		return -EINVAL;
+	status = !!enable;
+
+        ret = pps_gen->info.enable(pps_gen, status);
+        if (ret)
+                return ret;
+	pps_gen->enabled = status;
+
+        return count;
+}
+static DEVICE_ATTR_WO(enable);
+
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
+                         char *buf)
+{
+        struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
+
+        return sysfs_emit(buf, "%s\n", pps_gen->info.name);
+}
+static DEVICE_ATTR_RO(name);
+
+static struct attribute *pps_gen_attrs[] = {
+        &dev_attr_enable.attr,
+        &dev_attr_name.attr,
+        &dev_attr_time.attr,
+        &dev_attr_system.attr,
+        NULL,
+};
+
+static const struct attribute_group pps_gen_group = {
+        .attrs = pps_gen_attrs,
+};
+
+const struct attribute_group *pps_gen_groups[] = {
+        &pps_gen_group,
+        NULL,
+};
diff --git a/include/linux/pps_gen_kernel.h b/include/linux/pps_gen_kernel.h
new file mode 100644
index 000000000000..5513415b53ec
--- /dev/null
+++ b/include/linux/pps_gen_kernel.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * PPS generator API kernel header
+ *
+ * Copyright (C) 2024   Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#ifndef LINUX_PPS_GEN_KERNEL_H
+#define LINUX_PPS_GEN_KERNEL_H
+
+#include <linux/pps_gen.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+
+/*
+ * Global defines
+ */
+
+struct pps_gen_device;
+
+/* The specific PPS source info */
+struct pps_gen_source_info {
+	char name[PPS_GEN_MAX_NAME_LEN];	/* symbolic name */
+	bool use_system_clock;
+
+	int (*get_time)(struct pps_gen_device *pps_gen,
+					struct timespec64 *time);
+	int (*enable)(struct pps_gen_device *pps_gen, bool enable);
+
+	struct module *owner;
+	struct device *parent;			/* for device_create */
+};
+
+/* The main struct */
+struct pps_gen_device {
+	struct pps_gen_source_info info;	/* PSS generator info */
+	bool enabled;				/* PSS generator status */
+
+	unsigned int id;			/* PPS generator unique ID */
+	struct device *dev;
+};
+
+/*
+ * Global variables
+ */
+
+extern const struct attribute_group *pps_gen_groups[];
+
+/*
+ * Exported functions
+ */
+
+extern struct pps_gen_device *pps_gen_register_source(
+		struct pps_gen_source_info *info);
+extern void pps_gen_unregister_source(struct pps_gen_device *pps_gen);
+
+#endif /* LINUX_PPS_GEN_KERNEL_H */
diff --git a/include/uapi/linux/pps_gen.h b/include/uapi/linux/pps_gen.h
new file mode 100644
index 000000000000..7b6f50fcab8c
--- /dev/null
+++ b/include/uapi/linux/pps_gen.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * PPS generator API header
+ *
+ * Copyright (C) 2024   Rodolfo Giometti <giometti@enneenne.com>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+
+#ifndef _PPS_GEN_H_
+#define _PPS_GEN_H_
+
+#include <linux/types.h>
+
+#define PPS_GEN_MAX_SOURCES	16		/* should be enough... */
+#define PPS_GEN_MAX_NAME_LEN	32
+
+#include <linux/ioctl.h>
+
+#define PPS_GEN_SETENABLE	_IOW('g', 0xa1, unsigned int *)
+
+#endif /* _PPS_GEN_H_ */
-- 
2.34.1


