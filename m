Return-Path: <linux-kernel+bounces-567632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDC0A68878
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628EC426CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EE9260A33;
	Wed, 19 Mar 2025 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al64meZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E025FA29;
	Wed, 19 Mar 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376805; cv=none; b=ofJEswi9ckp88WFXFiuv3fy6kXDPMAXlh+3UQryBoFFbZhegiCgXJSvar6NqXLssILM7yTkY70gCzxRo5Wuhv7NcdsLtVvhbkhfoc2N1MPZ0rHxrHtvvh8lbruA1SwnzPMJnH3by5S3OtiDEiNfqUembS2Xwv7rpDxrmYe1o6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376805; c=relaxed/simple;
	bh=DmEkzV2v+M6KOzJs0lmtEuuY4Z9lzDwe2LwcKntFCqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKiPv0YmEkLG6hxK5JgoRVxDJP3oy/7kjfaKiwgS9FaDz7yvGw/2uX7q/JPwofTan/x+ieqxBGtDTW6UMw3atmda4yVxR+5jAYXigxA+mI4+88YweB56tVsOxNpBPn3t+g/9v5M5f159Hqo3vN0tI6SjazzhqpVcDOuqGfy2+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al64meZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25820C4CEEE;
	Wed, 19 Mar 2025 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376805;
	bh=DmEkzV2v+M6KOzJs0lmtEuuY4Z9lzDwe2LwcKntFCqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Al64meZo8AGAnyPcrbPrh4VYVc6YfuWGHe2bgEOAV5OWCtBUC76N0cxbAhhjw1odT
	 LzvSVvPV/YkXLHNQPcdJEgAbNtv8cBmp4OFqaC3UUJsAXOrNy6szFyYMpcn6iEl2nf
	 DDOjFKhzwYBueyMg8HqXr5Rnvp6W/oZHA/LeAoygzlKEBttXuci+BgUXMpfh4AlHtK
	 15Oz/SBonOrjxIIS8kKQDjcQ2HDBYiw3iQ7ZnA+2EnP4jpGXI6wTPjTLlc9FEt0Bbw
	 bu8rYVh5R0wuWk9xlCNyOMe/OinEM5Rmi3Oz/rUADiR4KPOyl8Qq2YqsnfzlOnqRDI
	 WDoBX/N7RUtLw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 56/57] docs: irqdomain: Update
Date: Wed, 19 Mar 2025 10:29:49 +0100
Message-ID: <20250319092951.37667-57-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irqdomain documentaion became obsolete over time. Update and extend
it a bit with respect to the current code and HW.

Most notably the doubled documentation of irq_domain (from .rst and .h)
was unified and let only in .rst. A reference link was added to .h.

Furthermore:
* Some 'struct' keywords added, so that the respective structs are
  hyperlinked.
* :c:member: used where appropriate to mark a member of a struct.
* Some wording rephrased to improve readability/understanding.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/irq/irq-domain.rst | 122 +++++++++++++---------
 include/linux/irqdomain.h                 |  26 +----
 2 files changed, 76 insertions(+), 72 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index c2f2728b1a35..7a418b3135de 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -3,8 +3,8 @@ The irq_domain Interrupt Number Mapping Library
 ===============================================
 
 The current design of the Linux kernel uses a single large number
-space where each separate IRQ source is assigned a different number.
-This is simple when there is only one interrupt controller, but in
+space where each separate IRQ source is assigned a unique number.
+This is simple when there is only one interrupt controller. But in
 systems with multiple interrupt controllers, the kernel must ensure
 that each one gets assigned non-overlapping allocations of Linux
 IRQ numbers.
@@ -15,45 +15,64 @@ such as GPIO controllers avoid reimplementing identical callback
 mechanisms as the IRQ core system by modelling their interrupt
 handlers as irqchips. I.e. in effect cascading interrupt controllers.
 
-Here the interrupt number loose all kind of correspondence to
-hardware interrupt numbers: whereas in the past, IRQ numbers could
-be chosen so they matched the hardware IRQ line into the root
-interrupt controller (i.e. the component actually fireing the
-interrupt line to the CPU) nowadays this number is just a number.
+So in the past, IRQ numbers could be chosen so that they match the
+hardware IRQ line into the root interrupt controller (i.e. the
+component actually firing the interrupt line to the CPU). Nowadays,
+this number is just a number and the number loose all kind of
+correspondence to hardware interrupt numbers.
 
 For this reason, we need a mechanism to separate controller-local
 interrupt numbers, called hardware IRQs, from Linux IRQ numbers.
 
 The irq_alloc_desc*() and irq_free_desc*() APIs provide allocation of
-irq numbers, but they don't provide any support for reverse mapping of
+IRQ numbers, but they don't provide any support for reverse mapping of
 the controller-local IRQ (hwirq) number into the Linux IRQ number
 space.
 
 The irq_domain library adds a mapping between hwirq and IRQ numbers on
-top of the irq_alloc_desc*() API.  An irq_domain to manage mapping is
-preferred over interrupt controller drivers open coding their own
+top of the irq_alloc_desc*() API. An irq_domain to manage the mapping
+is preferred over interrupt controller drivers open coding their own
 reverse mapping scheme.
 
-irq_domain also implements translation from an abstract irq_fwspec
-structure to hwirq numbers (Device Tree and ACPI GSI so far), and can
-be easily extended to support other IRQ topology data sources.
+irq_domain also implements a translation from an abstract struct
+irq_fwspec to hwirq numbers (Device Tree, non-DT firmware node, ACPI
+GSI, and software node so far), and can be easily extended to support
+other IRQ topology data sources. The implementation is performed
+without any extra platform support code.
 
 irq_domain Usage
 ================
 
-An interrupt controller driver creates and registers an irq_domain by
-calling one of the irq_domain_add_*() or irq_domain_create_*() functions
-(each mapping method has a different allocator function, more on that later).
-The function will return a pointer to the irq_domain on success. The caller
-must provide the allocator function with an irq_domain_ops structure.
+struct irq_domain could be defined as an irq domain controller. That
+is, it handles the mapping between hardware and virtual interrupt
+numbers for a given interrupt domain. The domain structure is
+generally created by the PIC code for a given PIC instance (though a
+domain can cover more than one PIC if they have a flat number model).
+It is the domain callbacks that are responsible for setting the
+irq_chip on a given irq_desc after it has been mapped.
+
+The host code and data structures use a fwnode_handle pointer to
+identify the domain. In some cases, and in order to preserve source
+code compatibility, this fwnode pointer is "upgraded" to a DT
+device_node. For those firmware infrastructures that do not provide a
+unique identifier for an interrupt controller, the irq_domain code
+offers a fwnode allocator.
+
+An interrupt controller driver creates and registers a struct irq_domain
+by calling one of the irq_domain_create_*() functions (each mapping
+method has a different allocator function, more on that later). The
+function will return a pointer to the struct irq_domain on success. The
+caller must provide the allocator function with a struct irq_domain_ops
+pointer.
 
 In most cases, the irq_domain will begin empty without any mappings
 between hwirq and IRQ numbers.  Mappings are added to the irq_domain
 by calling irq_create_mapping() which accepts the irq_domain and a
-hwirq number as arguments.  If a mapping for the hwirq doesn't already
-exist then it will allocate a new Linux irq_desc, associate it with
-the hwirq, and call the .map() callback so the driver can perform any
-required hardware setup.
+hwirq number as arguments. If a mapping for the hwirq doesn't already
+exist, irq_create_mapping() allocates a new Linux irq_desc, associates
+it with the hwirq, and calls the :c:member:`irq_domain_ops.map()`
+callback. In there, the driver can perform any required hardware
+setup.
 
 Once a mapping has been established, it can be retrieved or used via a
 variety of methods:
@@ -75,7 +94,8 @@ be allocated.
 
 If the driver has the Linux IRQ number or the irq_data pointer, and
 needs to know the associated hwirq number (such as in the irq_chip
-callbacks) then it can be directly obtained from irq_data->hwirq.
+callbacks) then it can be directly obtained from
+:c:member:`irq_data.hwirq`.
 
 Types of irq_domain Mappings
 ============================
@@ -231,20 +251,40 @@ There are four major interfaces to use hierarchy irq_domain:
 4) irq_domain_deactivate_irq(): deactivate interrupt controller hardware
    to stop delivering the interrupt.
 
-Following changes are needed to support hierarchy irq_domain:
+The following is needed to support hierarchy irq_domain:
 
-1) a new field 'parent' is added to struct irq_domain; it's used to
+1) The :c:member:`parent` field in struct irq_domain is used to
    maintain irq_domain hierarchy information.
-2) a new field 'parent_data' is added to struct irq_data; it's used to
-   build hierarchy irq_data to match hierarchy irq_domains. The irq_data
-   is used to store irq_domain pointer and hardware irq number.
-3) new callbacks are added to struct irq_domain_ops to support hierarchy
-   irq_domain operations.
-
-With support of hierarchy irq_domain and hierarchy irq_data ready, an
-irq_domain structure is built for each interrupt controller, and an
+2) The :c:member:`parent_data` field in struct irq_data is used to
+   build hierarchy irq_data to match hierarchy irq_domains. The
+   irq_data is used to store irq_domain pointer and hardware irq
+   number.
+3) The :c:member:`alloc()`, :c:member:`free()`, and other callbacks in
+   struct irq_domain_ops to support hierarchy irq_domain operations.
+
+With the support of hierarchy irq_domain and hierarchy irq_data ready,
+an irq_domain structure is built for each interrupt controller, and an
 irq_data structure is allocated for each irq_domain associated with an
-IRQ. Now we could go one step further to support stacked(hierarchy)
+IRQ.
+
+For an interrupt controller driver to support hierarchy irq_domain, it
+needs to:
+
+1) Implement irq_domain_ops.alloc() and irq_domain_ops.free()
+2) Optionally, implement irq_domain_ops.activate() and
+   irq_domain_ops.deactivate().
+3) Optionally, implement an irq_chip to manage the interrupt controller
+   hardware.
+4) There is no need to implement irq_domain_ops.map() and
+   irq_domain_ops.unmap(). They are unused with hierarchy irq_domain.
+
+Note the hierarchy irq_domain is in no way x86-specific, and is
+heavily used to support other architectures, such as ARM, ARM64 etc.
+
+Stacked irq_chip
+~~~~~~~~~~~~~~~~
+
+Now, we could go one step further to support stacked (hierarchy)
 irq_chip. That is, an irq_chip is associated with each irq_data along
 the hierarchy. A child irq_chip may implement a required action by
 itself or by cooperating with its parent irq_chip.
@@ -254,20 +294,6 @@ with the hardware managed by itself and may ask for services from its
 parent irq_chip when needed. So we could achieve a much cleaner
 software architecture.
 
-For an interrupt controller driver to support hierarchy irq_domain, it
-needs to:
-
-1) Implement irq_domain_ops.alloc and irq_domain_ops.free
-2) Optionally implement irq_domain_ops.activate and
-   irq_domain_ops.deactivate.
-3) Optionally implement an irq_chip to manage the interrupt controller
-   hardware.
-4) No need to implement irq_domain_ops.map and irq_domain_ops.unmap,
-   they are unused with hierarchy irq_domain.
-
-Hierarchy irq_domain is in no way x86 specific, and is heavily used to
-support other architectures, such as ARM, ARM64 etc.
-
 Debugging
 =========
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 3e7103645c63..b8bb37cfcee2 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -1,30 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * irq_domain - IRQ translation domains
+ * irq_domain - IRQ Translation Domains
  *
- * Translation infrastructure between hw and linux irq numbers.  This is
- * helpful for interrupt controllers to implement mapping between hardware
- * irq numbers and the Linux irq number space.
- *
- * irq_domains also have hooks for translating device tree or other
- * firmware interrupt representations into a hardware irq number that
- * can be mapped back to a Linux irq number without any extra platform
- * support code.
- *
- * Interrupt controller "domain" data structure. This could be defined as a
- * irq domain controller. That is, it handles the mapping between hardware
- * and virtual interrupt numbers for a given interrupt domain. The domain
- * structure is generally created by the PIC code for a given PIC instance
- * (though a domain can cover more than one PIC if they have a flat number
- * model). It's the domain callbacks that are responsible for setting the
- * irq_chip on a given irq_desc after it's been mapped.
- *
- * The host code and data structures use a fwnode_handle pointer to
- * identify the domain. In some cases, and in order to preserve source
- * code compatibility, this fwnode pointer is "upgraded" to a DT
- * device_node. For those firmware infrastructures that do not provide
- * a unique identifier for an interrupt controller, the irq_domain
- * code offers a fwnode allocator.
+ * See Documentation/core-api/irq/irq-domain.rst for the details.
  */
 
 #ifndef _LINUX_IRQDOMAIN_H
-- 
2.49.0


