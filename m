Return-Path: <linux-kernel+bounces-567631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE0A68862
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AC7188E82A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A425F989;
	Wed, 19 Mar 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVQw6HEW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567D25F963;
	Wed, 19 Mar 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376803; cv=none; b=gg6hTajHcX66YU6TVBqNLbNnIIX2vBxACOJfOr2zdwlUrO5YZ9s/R9X0cxOAKfBRuQ/Hg6zG8Qp/LhBhreeIDsEIYZrKk7VpyTng5WeJKN5v8i2bp5vnMRk9YeECiNACpXjbcqFKz7+B6mJT0Feb4gijRn5XZ/S5Za46P9dZCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376803; c=relaxed/simple;
	bh=UFLfqYAPRyP0zMZMJni7dgt7MkfzfaxNTSDWCN3V7Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMDCSp2fysW/67RdKjhCt71aetmxaWSjSiqrWTZtQYP3b1dJGZSIveolsC8z1eWiwxUo04CpHzQpkX6HuWVwUOYazxGQmb+yJOI3Rwja0uSibF8/ud6ZNx91DrtXhJibuGTOrN0aZCw6ULRD9w0ZRcOEZdron9KDYCHpOedO5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVQw6HEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16957C4CEEA;
	Wed, 19 Mar 2025 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376803;
	bh=UFLfqYAPRyP0zMZMJni7dgt7MkfzfaxNTSDWCN3V7Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVQw6HEWw/rNx703pdxYurP52goB6uxBLpnpc5pizQMLD4cFfgGh4VTW3MwkHPaeE
	 tRgDw+2X9d2y6C6XBO0pR0a8uRrT6nDSTeSXLhHNz1gVTy+J78/2T3xHyzVXiYF/nb
	 7F6LXUB1shDH1FdcBk13Df8wW1zvQ1RtGriE9KiMod2xEXC47L+gco+ht3Sqh0s4gS
	 bR/tzuFzxzG+foF+eMGm3ptEtyd3Tjoeg45VNYR7nuFYKSZfZ8ToF/yUGz09j+tuVL
	 83C2LQT8hshQ2QM13QmfoWBrlffWCrbWSE5RZBYG9uBRdtbIX8ElC4jNZHJiXvhRnN
	 a7H19bndOizHA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 55/57] docs: irq-domain.rst: Simple improvements
Date: Wed, 19 Mar 2025 10:29:48 +0100
Message-ID: <20250319092951.37667-56-jirislaby@kernel.org>
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

The improvements include:
* Capitals in headlines.
* Added commas: for easier reading, it is always desired to add commas
  at some places in text. Like before adverbs or after fronted
  sentences.
* 3rd person -> add 's' to verbs.
* End some sentences with period and start a new one. Avoid thus heavy
  sentences.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/irq/irq-domain.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 775dd43b3340..c2f2728b1a35 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -1,19 +1,19 @@
 ===============================================
-The irq_domain interrupt number mapping library
+The irq_domain Interrupt Number Mapping Library
 ===============================================
 
 The current design of the Linux kernel uses a single large number
 space where each separate IRQ source is assigned a different number.
 This is simple when there is only one interrupt controller, but in
-systems with multiple interrupt controllers the kernel must ensure
+systems with multiple interrupt controllers, the kernel must ensure
 that each one gets assigned non-overlapping allocations of Linux
 IRQ numbers.
 
 The number of interrupt controllers registered as unique irqchips
-show a rising tendency: for example subdrivers of different kinds
+shows a rising tendency. For example, subdrivers of different kinds
 such as GPIO controllers avoid reimplementing identical callback
 mechanisms as the IRQ core system by modelling their interrupt
-handlers as irqchips, i.e. in effect cascading interrupt controllers.
+handlers as irqchips. I.e. in effect cascading interrupt controllers.
 
 Here the interrupt number loose all kind of correspondence to
 hardware interrupt numbers: whereas in the past, IRQ numbers could
@@ -21,15 +21,15 @@ be chosen so they matched the hardware IRQ line into the root
 interrupt controller (i.e. the component actually fireing the
 interrupt line to the CPU) nowadays this number is just a number.
 
-For this reason we need a mechanism to separate controller-local
-interrupt numbers, called hardware irq's, from Linux IRQ numbers.
+For this reason, we need a mechanism to separate controller-local
+interrupt numbers, called hardware IRQs, from Linux IRQ numbers.
 
 The irq_alloc_desc*() and irq_free_desc*() APIs provide allocation of
 irq numbers, but they don't provide any support for reverse mapping of
 the controller-local IRQ (hwirq) number into the Linux IRQ number
 space.
 
-The irq_domain library adds mapping between hwirq and IRQ numbers on
+The irq_domain library adds a mapping between hwirq and IRQ numbers on
 top of the irq_alloc_desc*() API.  An irq_domain to manage mapping is
 preferred over interrupt controller drivers open coding their own
 reverse mapping scheme.
@@ -38,7 +38,7 @@ irq_domain also implements translation from an abstract irq_fwspec
 structure to hwirq numbers (Device Tree and ACPI GSI so far), and can
 be easily extended to support other IRQ topology data sources.
 
-irq_domain usage
+irq_domain Usage
 ================
 
 An interrupt controller driver creates and registers an irq_domain by
@@ -77,7 +77,7 @@ If the driver has the Linux IRQ number or the irq_data pointer, and
 needs to know the associated hwirq number (such as in the irq_chip
 callbacks) then it can be directly obtained from irq_data->hwirq.
 
-Types of irq_domain mappings
+Types of irq_domain Mappings
 ============================
 
 There are several mechanisms available for reverse mapping from hwirq
@@ -102,7 +102,7 @@ map are fixed time lookup for IRQ numbers, and irq_descs are only
 allocated for in-use IRQs.  The disadvantage is that the table must be
 as large as the largest possible hwirq number.
 
-The majority of drivers should use the linear map.
+The majority of drivers should use the Linear map.
 
 Tree
 ----
@@ -190,7 +190,7 @@ that the driver using the simple domain call irq_create_mapping()
 before any irq_find_mapping() since the latter will actually work
 for the static IRQ assignment case.
 
-Hierarchy IRQ domain
+Hierarchy IRQ Domain
 --------------------
 
 On some architectures, there may be multiple interrupt controllers
-- 
2.49.0


