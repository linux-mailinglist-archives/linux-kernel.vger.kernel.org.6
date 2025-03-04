Return-Path: <linux-kernel+bounces-543567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F379A4D713
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB423B030D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57289201027;
	Tue,  4 Mar 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SvpJnidM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gk/joHi9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD51FFC62
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078407; cv=none; b=QcGNV/3JEIldoWy1Y89Ptm2kSf+xyZj9/3SSoLn1SVaQV0h2DaWak1W4FMY3GoDO5BeQVC/xOePwbdN034EuprSoH65zJvI8P4NSeGIc6eZlppRZKjsiejXrx5AWypQVaeOFWjHAAyB9GYC4lJBHsdknA66In2uAJzTRnF18P4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078407; c=relaxed/simple;
	bh=S9n5Uxbkb9tkKocmV0n5rofb9brQ1W+BlY5KzhiqdWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrTlhFULbgYDFJIBZUAfCD29bm+sCd8gT82JSzOtrW8zfwBWWBLl1J2caoVyaizC+P2f1S/FragbNFVObMo2pzqNMY1iNsBim9mb9sTqvItZJBSA5SIpX9pTehCeamxfOeW8Js2bTCnUGr21TuDQEr94c1c5vRyg4KtrbD0POiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SvpJnidM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gk/joHi9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGPiw/y1VXFkz0VmEPAcv/TPFcSMGZnJR96c5iQBRwo=;
	b=SvpJnidMv8GRt8q7C+lCNjc8NdmTVEy9GfL5rpkEggDuU6h59Pd4FZiQpknVoeDSGAyezL
	IFTM7zVMkGYptd2KvCefuHiduTO2ZI3K3UZprkYdE/VlUxf2eeXzMKnuzy2JOi7ta2WF4P
	JCZSLz+8xrgDCBKgncSprcgC4JoG0FyXA//KMLlXPurDepbyhfXJ3nYFd47usdWG35sJrJ
	B0Z2KoAOxroidytq0EpAfJHAeUYepewRJflxNmJt/NhZ2LvrPqoIqUMBRTnWUEZltKUEZB
	y+aEBPbDuVUuufqgDp5BKg2TLa7c0UIk/q+t15enyJhq5RdhqdqdgcVDIH4Vcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGPiw/y1VXFkz0VmEPAcv/TPFcSMGZnJR96c5iQBRwo=;
	b=gk/joHi9AAvj9c6Wzf/uFWrQGKI62bqlji7wkSVELph9+ZROq2GJJJhsUKUnEfSDKS45rr
	NCpIymjeE4EnydDg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 23/40] x86/cacheinfo: Move AMD cache_disable_0/1 handling to separate file
Date: Tue,  4 Mar 2025 09:51:34 +0100
Message-ID: <20250304085152.51092-24-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parent commit decoupled amd_northbridge out of _cpuid4_info_regs, where
it was merely "parked" there until ci_info_init() can store it in the
priv pointer of the linux/cacheinfo.h API.

Given that decoupling, move the AMD-specific L3 cache_disable_0/1 sysfs
code from the generic (and already extremely convoluted) x86/cacheinfo
code into its own file.

Compile the file only if CONFIG_AMD_NB and CONFIG_SYSFS are both
enabled, which mirrors the existing logic.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/Makefile            |   3 +
 arch/x86/kernel/cpu/amd_cache_disable.c | 301 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/cacheinfo.c         | 298 -----------------------
 arch/x86/kernel/cpu/cpu.h               |   9 +
 4 files changed, 313 insertions(+), 298 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/amd_cache_disable.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 4efdf5c2efc8..3a39396d422d 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -38,6 +38,9 @@ obj-y					+= intel.o tsx.o
 obj-$(CONFIG_PM)			+= intel_epb.o
 endif
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
+ifeq ($(CONFIG_AMD_NB)$(CONFIG_SYSFS),yy)
+obj-y					+= amd_cache_disable.o
+endif
 obj-$(CONFIG_CPU_SUP_HYGON)		+= hygon.o
 obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
 obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
diff --git a/arch/x86/kernel/cpu/amd_cache_disable.c b/arch/x86/kernel/cpu/amd_cache_disable.c
new file mode 100644
index 000000000000..6d53aee0d869
--- /dev/null
+++ b/arch/x86/kernel/cpu/amd_cache_disable.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD L3 cache_disable_{0,1} sysfs handling
+ * Documentation/ABI/testing/sysfs-devices-system-cpu
+ */
+
+#include <linux/cacheinfo.h>
+#include <linux/capability.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+
+#include <asm/amd_nb.h>
+
+#include "cpu.h"
+
+/*
+ * L3 cache descriptors
+ */
+static void amd_calc_l3_indices(struct amd_northbridge *nb)
+{
+	struct amd_l3_cache *l3 = &nb->l3_cache;
+	unsigned int sc0, sc1, sc2, sc3;
+	u32 val = 0;
+
+	pci_read_config_dword(nb->misc, 0x1C4, &val);
+
+	/* calculate subcache sizes */
+	l3->subcaches[0] = sc0 = !(val & BIT(0));
+	l3->subcaches[1] = sc1 = !(val & BIT(4));
+
+	if (boot_cpu_data.x86 == 0x15) {
+		l3->subcaches[0] = sc0 += !(val & BIT(1));
+		l3->subcaches[1] = sc1 += !(val & BIT(5));
+	}
+
+	l3->subcaches[2] = sc2 = !(val & BIT(8))  + !(val & BIT(9));
+	l3->subcaches[3] = sc3 = !(val & BIT(12)) + !(val & BIT(13));
+
+	l3->indices = (max(max3(sc0, sc1, sc2), sc3) << 10) - 1;
+}
+
+/*
+ * check whether a slot used for disabling an L3 index is occupied.
+ * @l3: L3 cache descriptor
+ * @slot: slot number (0..1)
+ *
+ * @returns: the disabled index if used or negative value if slot free.
+ */
+static int amd_get_l3_disable_slot(struct amd_northbridge *nb, unsigned int slot)
+{
+	unsigned int reg = 0;
+
+	pci_read_config_dword(nb->misc, 0x1BC + slot * 4, &reg);
+
+	/* check whether this slot is activated already */
+	if (reg & (3UL << 30))
+		return reg & 0xfff;
+
+	return -1;
+}
+
+static ssize_t show_cache_disable(struct cacheinfo *ci, char *buf, unsigned int slot)
+{
+	int index;
+	struct amd_northbridge *nb = ci->priv;
+
+	index = amd_get_l3_disable_slot(nb, slot);
+	if (index >= 0)
+		return sprintf(buf, "%d\n", index);
+
+	return sprintf(buf, "FREE\n");
+}
+
+#define SHOW_CACHE_DISABLE(slot)					\
+static ssize_t								\
+cache_disable_##slot##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct cacheinfo *ci = dev_get_drvdata(dev);			\
+	return show_cache_disable(ci, buf, slot);			\
+}
+
+SHOW_CACHE_DISABLE(0)
+SHOW_CACHE_DISABLE(1)
+
+static void amd_l3_disable_index(struct amd_northbridge *nb, int cpu,
+				 unsigned int slot, unsigned long idx)
+{
+	int i;
+
+	idx |= BIT(30);
+
+	/*
+	 *  disable index in all 4 subcaches
+	 */
+	for (i = 0; i < 4; i++) {
+		u32 reg = idx | (i << 20);
+
+		if (!nb->l3_cache.subcaches[i])
+			continue;
+
+		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
+
+		/*
+		 * We need to WBINVD on a core on the node containing the L3
+		 * cache which indices we disable therefore a simple wbinvd()
+		 * is not sufficient.
+		 */
+		wbinvd_on_cpu(cpu);
+
+		reg |= BIT(31);
+		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
+	}
+}
+
+/*
+ * disable a L3 cache index by using a disable-slot
+ *
+ * @l3:    L3 cache descriptor
+ * @cpu:   A CPU on the node containing the L3 cache
+ * @slot:  slot number (0..1)
+ * @index: index to disable
+ *
+ * @return: 0 on success, error status on failure
+ */
+static int amd_set_l3_disable_slot(struct amd_northbridge *nb, int cpu,
+				   unsigned int slot, unsigned long index)
+{
+	int ret = 0;
+
+	/*  check if @slot is already used or the index is already disabled */
+	ret = amd_get_l3_disable_slot(nb, slot);
+	if (ret >= 0)
+		return -EEXIST;
+
+	if (index > nb->l3_cache.indices)
+		return -EINVAL;
+
+	/* check whether the other slot has disabled the same index already */
+	if (index == amd_get_l3_disable_slot(nb, !slot))
+		return -EEXIST;
+
+	amd_l3_disable_index(nb, cpu, slot, index);
+
+	return 0;
+}
+
+static ssize_t store_cache_disable(struct cacheinfo *ci, const char *buf,
+				   size_t count, unsigned int slot)
+{
+	struct amd_northbridge *nb = ci->priv;
+	unsigned long val = 0;
+	int cpu, err = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	cpu = cpumask_first(&ci->shared_cpu_map);
+
+	if (kstrtoul(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	err = amd_set_l3_disable_slot(nb, cpu, slot, val);
+	if (err) {
+		if (err == -EEXIST)
+			pr_warn("L3 slot %d in use/index already disabled!\n",
+				   slot);
+		return err;
+	}
+	return count;
+}
+
+#define STORE_CACHE_DISABLE(slot)					\
+static ssize_t								\
+cache_disable_##slot##_store(struct device *dev,			\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	struct cacheinfo *ci = dev_get_drvdata(dev);			\
+	return store_cache_disable(ci, buf, count, slot);		\
+}
+
+STORE_CACHE_DISABLE(0)
+STORE_CACHE_DISABLE(1)
+
+static ssize_t subcaches_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct cacheinfo *ci = dev_get_drvdata(dev);
+	int cpu = cpumask_first(&ci->shared_cpu_map);
+
+	return sprintf(buf, "%x\n", amd_get_subcaches(cpu));
+}
+
+static ssize_t subcaches_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct cacheinfo *ci = dev_get_drvdata(dev);
+	int cpu = cpumask_first(&ci->shared_cpu_map);
+	unsigned long val;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoul(buf, 16, &val) < 0)
+		return -EINVAL;
+
+	if (amd_set_subcaches(cpu, val))
+		return -EINVAL;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(cache_disable_0);
+static DEVICE_ATTR_RW(cache_disable_1);
+static DEVICE_ATTR_RW(subcaches);
+
+static umode_t cache_private_attrs_is_visible(struct kobject *kobj,
+					      struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cacheinfo *ci = dev_get_drvdata(dev);
+	umode_t mode = attr->mode;
+
+	if (!ci->priv)
+		return 0;
+
+	if ((attr == &dev_attr_subcaches.attr) &&
+	    amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
+		return mode;
+
+	if ((attr == &dev_attr_cache_disable_0.attr ||
+	     attr == &dev_attr_cache_disable_1.attr) &&
+	    amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE))
+		return mode;
+
+	return 0;
+}
+
+static struct attribute_group cache_private_group = {
+	.is_visible = cache_private_attrs_is_visible,
+};
+
+static void init_amd_l3_attrs(void)
+{
+	static struct attribute **amd_l3_attrs;
+	int n = 1;
+
+	if (amd_l3_attrs) /* already initialized */
+		return;
+
+	if (amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE))
+		n += 2;
+	if (amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
+		n += 1;
+
+	amd_l3_attrs = kcalloc(n, sizeof(*amd_l3_attrs), GFP_KERNEL);
+	if (!amd_l3_attrs)
+		return;
+
+	n = 0;
+	if (amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE)) {
+		amd_l3_attrs[n++] = &dev_attr_cache_disable_0.attr;
+		amd_l3_attrs[n++] = &dev_attr_cache_disable_1.attr;
+	}
+	if (amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
+		amd_l3_attrs[n++] = &dev_attr_subcaches.attr;
+
+	cache_private_group.attrs = amd_l3_attrs;
+}
+
+const struct attribute_group *cache_get_priv_group(struct cacheinfo *ci)
+{
+	struct amd_northbridge *nb = ci->priv;
+
+	if (ci->level < 3 || !nb)
+		return NULL;
+
+	if (nb && nb->l3_cache.indices)
+		init_amd_l3_attrs();
+
+	return &cache_private_group;
+}
+
+struct amd_northbridge *amd_init_l3_cache(int index)
+{
+	struct amd_northbridge *nb;
+	int node;
+
+	/* only for L3, and not in virtualized environments */
+	if (index < 3)
+		return NULL;
+
+	node = topology_amd_node_id(smp_processor_id());
+	nb = node_to_amd_nb(node);
+	if (nb && !nb->l3_cache.indices)
+		amd_calc_l3_indices(nb);
+
+	return nb;
+}
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 2a56c7cc3c2d..eadd117c05e1 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -9,12 +9,9 @@
  */
 
 #include <linux/cacheinfo.h>
-#include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
-#include <linux/pci.h>
 #include <linux/stop_machine.h>
-#include <linux/sysfs.h>
 
 #include <asm/amd_nb.h>
 #include <asm/cacheinfo.h>
@@ -300,301 +297,6 @@ amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		(ebx->split.ways_of_associativity + 1) - 1;
 }
 
-#if defined(CONFIG_AMD_NB) && defined(CONFIG_SYSFS)
-
-/*
- * L3 cache descriptors
- */
-static void amd_calc_l3_indices(struct amd_northbridge *nb)
-{
-	struct amd_l3_cache *l3 = &nb->l3_cache;
-	unsigned int sc0, sc1, sc2, sc3;
-	u32 val = 0;
-
-	pci_read_config_dword(nb->misc, 0x1C4, &val);
-
-	/* calculate subcache sizes */
-	l3->subcaches[0] = sc0 = !(val & BIT(0));
-	l3->subcaches[1] = sc1 = !(val & BIT(4));
-
-	if (boot_cpu_data.x86 == 0x15) {
-		l3->subcaches[0] = sc0 += !(val & BIT(1));
-		l3->subcaches[1] = sc1 += !(val & BIT(5));
-	}
-
-	l3->subcaches[2] = sc2 = !(val & BIT(8))  + !(val & BIT(9));
-	l3->subcaches[3] = sc3 = !(val & BIT(12)) + !(val & BIT(13));
-
-	l3->indices = (max(max3(sc0, sc1, sc2), sc3) << 10) - 1;
-}
-
-/*
- * check whether a slot used for disabling an L3 index is occupied.
- * @l3: L3 cache descriptor
- * @slot: slot number (0..1)
- *
- * @returns: the disabled index if used or negative value if slot free.
- */
-static int amd_get_l3_disable_slot(struct amd_northbridge *nb, unsigned slot)
-{
-	unsigned int reg = 0;
-
-	pci_read_config_dword(nb->misc, 0x1BC + slot * 4, &reg);
-
-	/* check whether this slot is activated already */
-	if (reg & (3UL << 30))
-		return reg & 0xfff;
-
-	return -1;
-}
-
-static ssize_t show_cache_disable(struct cacheinfo *ci, char *buf, unsigned int slot)
-{
-	int index;
-	struct amd_northbridge *nb = ci->priv;
-
-	index = amd_get_l3_disable_slot(nb, slot);
-	if (index >= 0)
-		return sprintf(buf, "%d\n", index);
-
-	return sprintf(buf, "FREE\n");
-}
-
-#define SHOW_CACHE_DISABLE(slot)					\
-static ssize_t								\
-cache_disable_##slot##_show(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)	\
-{									\
-	struct cacheinfo *ci = dev_get_drvdata(dev);			\
-	return show_cache_disable(ci, buf, slot);			\
-}
-SHOW_CACHE_DISABLE(0)
-SHOW_CACHE_DISABLE(1)
-
-static void amd_l3_disable_index(struct amd_northbridge *nb, int cpu,
-				 unsigned slot, unsigned long idx)
-{
-	int i;
-
-	idx |= BIT(30);
-
-	/*
-	 *  disable index in all 4 subcaches
-	 */
-	for (i = 0; i < 4; i++) {
-		u32 reg = idx | (i << 20);
-
-		if (!nb->l3_cache.subcaches[i])
-			continue;
-
-		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
-
-		/*
-		 * We need to WBINVD on a core on the node containing the L3
-		 * cache which indices we disable therefore a simple wbinvd()
-		 * is not sufficient.
-		 */
-		wbinvd_on_cpu(cpu);
-
-		reg |= BIT(31);
-		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
-	}
-}
-
-/*
- * disable a L3 cache index by using a disable-slot
- *
- * @l3:    L3 cache descriptor
- * @cpu:   A CPU on the node containing the L3 cache
- * @slot:  slot number (0..1)
- * @index: index to disable
- *
- * @return: 0 on success, error status on failure
- */
-static int amd_set_l3_disable_slot(struct amd_northbridge *nb, int cpu,
-			    unsigned slot, unsigned long index)
-{
-	int ret = 0;
-
-	/*  check if @slot is already used or the index is already disabled */
-	ret = amd_get_l3_disable_slot(nb, slot);
-	if (ret >= 0)
-		return -EEXIST;
-
-	if (index > nb->l3_cache.indices)
-		return -EINVAL;
-
-	/* check whether the other slot has disabled the same index already */
-	if (index == amd_get_l3_disable_slot(nb, !slot))
-		return -EEXIST;
-
-	amd_l3_disable_index(nb, cpu, slot, index);
-
-	return 0;
-}
-
-static ssize_t store_cache_disable(struct cacheinfo *ci, const char *buf,
-				   size_t count, unsigned int slot)
-{
-	unsigned long val = 0;
-	int cpu, err = 0;
-	struct amd_northbridge *nb = ci->priv;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	cpu = cpumask_first(&ci->shared_cpu_map);
-
-	if (kstrtoul(buf, 10, &val) < 0)
-		return -EINVAL;
-
-	err = amd_set_l3_disable_slot(nb, cpu, slot, val);
-	if (err) {
-		if (err == -EEXIST)
-			pr_warn("L3 slot %d in use/index already disabled!\n",
-				   slot);
-		return err;
-	}
-	return count;
-}
-
-#define STORE_CACHE_DISABLE(slot)					\
-static ssize_t								\
-cache_disable_##slot##_store(struct device *dev,			\
-			     struct device_attribute *attr,		\
-			     const char *buf, size_t count)		\
-{									\
-	struct cacheinfo *ci = dev_get_drvdata(dev);			\
-	return store_cache_disable(ci, buf, count, slot);		\
-}
-STORE_CACHE_DISABLE(0)
-STORE_CACHE_DISABLE(1)
-
-static ssize_t subcaches_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct cacheinfo *ci = dev_get_drvdata(dev);
-	int cpu = cpumask_first(&ci->shared_cpu_map);
-
-	return sprintf(buf, "%x\n", amd_get_subcaches(cpu));
-}
-
-static ssize_t subcaches_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
-{
-	struct cacheinfo *ci = dev_get_drvdata(dev);
-	int cpu = cpumask_first(&ci->shared_cpu_map);
-	unsigned long val;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (kstrtoul(buf, 16, &val) < 0)
-		return -EINVAL;
-
-	if (amd_set_subcaches(cpu, val))
-		return -EINVAL;
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(cache_disable_0);
-static DEVICE_ATTR_RW(cache_disable_1);
-static DEVICE_ATTR_RW(subcaches);
-
-static umode_t
-cache_private_attrs_is_visible(struct kobject *kobj,
-			       struct attribute *attr, int unused)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct cacheinfo *ci = dev_get_drvdata(dev);
-	umode_t mode = attr->mode;
-
-	if (!ci->priv)
-		return 0;
-
-	if ((attr == &dev_attr_subcaches.attr) &&
-	    amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
-		return mode;
-
-	if ((attr == &dev_attr_cache_disable_0.attr ||
-	     attr == &dev_attr_cache_disable_1.attr) &&
-	    amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE))
-		return mode;
-
-	return 0;
-}
-
-static struct attribute_group cache_private_group = {
-	.is_visible = cache_private_attrs_is_visible,
-};
-
-static void init_amd_l3_attrs(void)
-{
-	int n = 1;
-	static struct attribute **amd_l3_attrs;
-
-	if (amd_l3_attrs) /* already initialized */
-		return;
-
-	if (amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE))
-		n += 2;
-	if (amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
-		n += 1;
-
-	amd_l3_attrs = kcalloc(n, sizeof(*amd_l3_attrs), GFP_KERNEL);
-	if (!amd_l3_attrs)
-		return;
-
-	n = 0;
-	if (amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE)) {
-		amd_l3_attrs[n++] = &dev_attr_cache_disable_0.attr;
-		amd_l3_attrs[n++] = &dev_attr_cache_disable_1.attr;
-	}
-	if (amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
-		amd_l3_attrs[n++] = &dev_attr_subcaches.attr;
-
-	cache_private_group.attrs = amd_l3_attrs;
-}
-
-const struct attribute_group *
-cache_get_priv_group(struct cacheinfo *ci)
-{
-	struct amd_northbridge *nb = ci->priv;
-
-	if (ci->level < 3 || !nb)
-		return NULL;
-
-	if (nb && nb->l3_cache.indices)
-		init_amd_l3_attrs();
-
-	return &cache_private_group;
-}
-
-static struct amd_northbridge *amd_init_l3_cache(int index)
-{
-	struct amd_northbridge *nb;
-	int node;
-
-	/* only for L3, and not in virtualized environments */
-	if (index < 3)
-		return NULL;
-
-	node = topology_amd_node_id(smp_processor_id());
-	nb = node_to_amd_nb(node);
-	if (nb && !nb->l3_cache.indices)
-		amd_calc_l3_indices(nb);
-
-	return nb;
-}
-#else
-static struct amd_northbridge *amd_init_l3_cache(int index)
-{
-	return NULL;
-}
-#endif  /* CONFIG_AMD_NB && CONFIG_SYSFS */
-
 /*
  * Fill passed _cpuid4_info_regs structure.
  * Intel-only code paths should pass NULL for the amd_northbridge
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 51deb60a9d26..bc38b2d56f26 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -75,6 +75,15 @@ extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c);
 
+#if defined(CONFIG_AMD_NB) && defined(CONFIG_SYSFS)
+struct amd_northbridge *amd_init_l3_cache(int index);
+#else
+static inline struct amd_northbridge *amd_init_l3_cache(int index)
+{
+	return NULL;
+}
+#endif
+
 unsigned int aperfmperf_get_khz(int cpu);
 void cpu_select_mitigations(void);
 
-- 
2.48.1


