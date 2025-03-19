Return-Path: <linux-kernel+bounces-567633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ECEA68866
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6810A1894792
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89147261384;
	Wed, 19 Mar 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtELG2Xf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0F26136A;
	Wed, 19 Mar 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376808; cv=none; b=ECMctZi2UN0dqURZhSozsHjiec+P5DnlEvj/7jVirfqPZqDevEw/D+95Tg26cCLdTWEDhFELO/ctSY5GklTrfP/lPMLe42dwQKTJsUYVN1wQXuxzD0ZXkZJ6slVx1dor0FnCFUD+EIVuh6hC0FaMASF9yPsqBKhP8T2SOEsfP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376808; c=relaxed/simple;
	bh=1ZnDtwr26F+gadypjJWqlvEkauGfR8o1OEkvjNk+RzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qvmtjfd/cH+xMdjSj7XqQ/swk7nvcnrqqxHhpMwKdTQ1aNMNaqAHjbXhA3PF64C3ngNOJlsznuSgr8dPvbbw32VR/htKL6/2wHf/OaZerP64RHSH0Ss/P02hzhc6YUMs8/5ybcci0CDJUd4FxJNAStZQIg8IQ9jkFVmFa8EXkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtELG2Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3632AC4CEE9;
	Wed, 19 Mar 2025 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376807;
	bh=1ZnDtwr26F+gadypjJWqlvEkauGfR8o1OEkvjNk+RzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtELG2XfRg/8Dwmk1xW4IS+e3e9tF9e3vgYax8DZEkyyHanh4+IN6MGWv/5A6OddR
	 nhmJtuFCfZID8d5BU1NvTlgdf51bshK9RklQEav4eOE88xQOeU7P9D15wzhOqB1vip
	 F7t3YX1fUsI8XmOFvqmp+YLb24Z8WHJXhgZtOlhWlm0ZCv+3wp3wtpED2sD0qVHrab
	 rzsRObcCkpKJfISXbKR227Lfo5v/JcVHHPUPdeRn8/NiUW/9/jdAjaTSAGEzscfyts
	 ILXzqKRz4lw/YXspB7FDEQ4f1sGcwieEH4EibOz+RxdHSK/u00u76z4sHAwgEIH57l
	 WjQEjia3/p3PQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 57/57] irqdomain.c: Fix kernel-doc and add it to Documentation
Date: Wed, 19 Mar 2025 10:29:50 +0100
Message-ID: <20250319092951.37667-58-jirislaby@kernel.org>
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

irqdomain.c's kernel-doc exists in that file, but is not plugged into
Documentation/ yet.

Before plugging it in, fix it first: irq_domain_get_irq_data() and
irq_domain_set_info() were documented twice. Identically, by both
definitions for CONFIG_IRQ_DOMAIN_HIERARCHY and
!CONFIG_IRQ_DOMAIN_HIERARCHY. Therefore, switch the second kernel-doc
into an ordinary comment -- change "/**" to simple "/*". This avoids
sphinx's:
  WARNING: Duplicate C declaration

Next, in commit b7b377332b96 ("irqdomain: Fix the kernel-doc and plug it
into Documentation"), I added irqdomain.h's (header) kernel-doc into
core-api/genericirq.rst. But given the amount of irqdomain functions and
structures, move all these to core-api/irq/irq-domain.rst now.

Finally, add these newly fixed irqdomain.c's (source) docs there as
well.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/genericirq.rst     |  2 --
 Documentation/core-api/irq/irq-domain.rst | 20 ++++++++++++++++++++
 kernel/irq/irqdomain.c                    |  4 ++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
index 25f94dfd66fa..582bde9bf5a9 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -410,8 +410,6 @@ which are used in the generic IRQ layer.
 .. kernel-doc:: include/linux/interrupt.h
    :internal:
 
-.. kernel-doc:: include/linux/irqdomain.h
-
 Public Functions Provided
 =========================
 
diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 7a418b3135de..4226e0bac4f0 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -299,3 +299,23 @@ Debugging
 
 Most of the internals of the IRQ subsystem are exposed in debugfs by
 turning CONFIG_GENERIC_IRQ_DEBUGFS on.
+
+Structures and Public Functions Provided
+========================================
+
+This chapter contains the autogenerated documentation of the structures
+and exported kernel API functions which are used for IRQ domains.
+
+.. kernel-doc:: include/linux/irqdomain.h
+
+.. kernel-doc:: kernel/irq/irqdomain.c
+   :export:
+
+Internal Functions Provided
+===========================
+
+This chapter contains the autogenerated documentation of the internal
+functions.
+
+.. kernel-doc:: kernel/irq/irqdomain.c
+   :internal:
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5bb3d2bbe229..5b21b568155b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1940,7 +1940,7 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain)
 		domain->flags |= IRQ_DOMAIN_FLAG_HIERARCHY;
 }
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
-/**
+/*
  * irq_domain_get_irq_data - Get irq_data associated with @virq and @domain
  * @domain:	domain to match
  * @virq:	IRQ number to get irq_data
@@ -1954,7 +1954,7 @@ struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 }
 EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
 
-/**
+/*
  * irq_domain_set_info - Set the complete data for a @virq in @domain
  * @domain:		Interrupt domain to match
  * @virq:		IRQ number
-- 
2.49.0


