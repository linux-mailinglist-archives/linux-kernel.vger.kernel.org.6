Return-Path: <linux-kernel+bounces-567628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63CA6887A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C571A883F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9925E803;
	Wed, 19 Mar 2025 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0N0w32J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834A25E471;
	Wed, 19 Mar 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376798; cv=none; b=AY30QuMbVlaxptLs6GKPGF4KYAEw3eWxgM4gfJvdGU/v0yHBoURt7lhHSiLDnaLCUwAL9GKTS70dqPa3oKBaUGlKVsmgduXxRA5A3v0wmOoHHhPCaxMZ+SjApCs3AcDa360XltC7ZqCa6IehOVIpl2oeO4119dfyp9ZB7/AZgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376798; c=relaxed/simple;
	bh=tY3E73/bPkQtD0w5fWJQJmN0LIORBH3zkcvPZlS7C7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGVEUrafN+JnoKC9mNVFiflhJlGwR2zGL/9InkR3bfz9sYmuBg/1Zs6fpc6FAp7//pb30vmekETr88yOD2Fmq9DLffoh09xVmBGNF3kQ9SL42ahmM/N6C5NhhGm0a58ycfiaGn54kGzyvhurnrwO0qXVidtlZp+eSVFUoBzgdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0N0w32J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA060C4CEEA;
	Wed, 19 Mar 2025 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376797;
	bh=tY3E73/bPkQtD0w5fWJQJmN0LIORBH3zkcvPZlS7C7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0N0w32JQiLhMY3LUt3I4++8wXWjh9nax/AvZ11mlkfxA+Z9bIpIFLigfWTFxvdyB
	 JlsCZYrmhcVecMZ3oHDA1z11QT/QDm0IKDTp+5BVjGLosRoW4wPTYlUyn+iJw0QB6h
	 j4XRYyxyTsWZJ8WJJJji7PicIzTi9VX88oiUWvkAKYC7kW+DcxB6AMwFqDRzTAPZAY
	 tXmZWKDPHEgI00VM0FBxM4slTzB9x3iptS1CShcDe4G6kixJlhKN1bwInYWcKxvPKO
	 3ZUgpAw+ZVjmuB5zzRM69Xa2GhhiAd83yuAQWZqJu2RIqXZ2X+Kl5hQ7Gx1NHGdZ6J
	 0N4EDGCq/LOyg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 52/57] irqdomain.h: Improve kernel-docs of functions
Date: Wed, 19 Mar 2025 10:29:45 +0100
Message-ID: <20250319092951.37667-53-jirislaby@kernel.org>
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

Many of irqdomain.h's functions are referenced in Documentation/ but are
not properly documented. Therefore, document these.

And use "Returns:" tag consistently, so that it is properly generated to
the resulting docs.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>

---
[v2] no () for functions names in the comments' headers
---
 include/linux/irqdomain.h | 42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 472f6bb91e9a..3e7103645c63 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -411,6 +411,15 @@ static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *f
 unsigned int irq_create_direct_mapping(struct irq_domain *domain);
 #endif
 
+/**
+ * irq_domain_create_linear - Allocate and register a linear revmap irq_domain.
+ * @fwnode: pointer to interrupt controller's FW node.
+ * @size: Number of interrupts in the domain.
+ * @ops: map/unmap domain callbacks
+ * @host_data: Controller private data pointer
+ *
+ * Returns: Newly created irq_domain
+ */
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
 					 unsigned int size,
 					 const struct irq_domain_ops *ops,
@@ -457,6 +466,18 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 void irq_dispose_mapping(unsigned int virq);
 
+/**
+ * irq_create_mapping - Map a hardware interrupt into linux irq space
+ * @domain: domain owning this hardware interrupt or NULL for default domain
+ * @hwirq: hardware irq number in that domain space
+ *
+ * Only one mapping per hardware interrupt is permitted.
+ *
+ * If the sense/trigger is to be specified, set_irq_type() should be called
+ * on the number returned from that call.
+ *
+ * Returns: Linux irq number or 0 on error
+ */
 static inline unsigned int irq_create_mapping(struct irq_domain *domain,
 					      irq_hw_number_t hwirq)
 {
@@ -467,6 +488,13 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
 				       irq_hw_number_t hwirq,
 				       unsigned int *irq);
 
+/**
+ * irq_resolve_mapping - Find a linux irq from a hw irq number.
+ * @domain: domain owning this hardware interrupt
+ * @hwirq: hardware irq number in that domain space
+ *
+ * Returns: Interrupt descriptor
+ */
 static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
 						   irq_hw_number_t hwirq)
 {
@@ -477,6 +505,8 @@ static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
  * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
+ *
+ * Returns: Linux irq number or 0 if not found
  */
 static inline unsigned int irq_find_mapping(struct irq_domain *domain,
 					    irq_hw_number_t hwirq)
@@ -539,7 +569,8 @@ void irq_domain_reset_irq_data(struct irq_data *irq_data);
  *
  * If successful the parent is associated to the new domain and the
  * domain flags are set.
- * Returns pointer to IRQ domain, or NULL on failure.
+ *
+ * Returns: A pointer to IRQ domain, or %NULL on failure.
  */
 static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 					    unsigned int flags,
@@ -570,6 +601,15 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 void irq_domain_deactivate_irq(struct irq_data *irq_data);
 
+/**
+ * irq_domain_alloc_irqs - Allocate IRQs from domain
+ * @domain:	domain to allocate from
+ * @nr_irqs:	number of IRQs to allocate
+ * @node:	NUMA node id for memory allocation
+ * @arg:	domain specific argument
+ *
+ * See __irq_domain_alloc_irqs()' documentation.
+ */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
 {
-- 
2.49.0


