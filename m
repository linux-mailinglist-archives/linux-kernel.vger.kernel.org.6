Return-Path: <linux-kernel+bounces-567629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55573A6885E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399E619C334B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599225EF89;
	Wed, 19 Mar 2025 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrsmGZZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E325E820;
	Wed, 19 Mar 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376799; cv=none; b=ne7i5AmwDKbX/AVWuMxs+nqHf4e23GPKwjrDe8pMIgU0ckimXBQDgsAvDVQiLSv3+jZu1ISUMhLoiLOawZtKVtmVx9HbQ+o9pWNa8+X3Lbl53ScPuGJ99XqNeGp1VjleqGPjLPJX8Q6scBJh8/fzqm5E8TGjRxa8NZ5J4x5ftUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376799; c=relaxed/simple;
	bh=d9EgjtX6NglS06OR7rjXgzo2p+SLKBGgjWU8YxisvHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSpyHCWLKtMfjdL+CoheYHWF/T+/rV1FuPVxVq+Y/fzQ7RJQOam+DTdi6vJhs5Wgsb21oNF1OxkWvajvGAgydBwS8gBt3IWB2TrjQdo+fRCjs5WIQisToFoG/tngx4wjv0jo/FH95JCzKkq9RhFj+YFUpEGM1jtLlwQgz601jBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrsmGZZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7EBC4CEE9;
	Wed, 19 Mar 2025 09:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376799;
	bh=d9EgjtX6NglS06OR7rjXgzo2p+SLKBGgjWU8YxisvHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrsmGZZRNcEWcTwHA7WIEknh3maSV8yZL3aTp6fFGphheMp2kc119iS/XEysAhk35
	 JFwhvzIRmVwRIPHeoNekhecfzwa3Kxcoh0KNvAdJMdonwQtiTymnOAeWh4KPx8valY
	 MDt4C3Nfhz5TJBLw4AhudbIAlWQltKnFLRk5IhdP68TQ/ZPfb/eRmopIXGmgzpvEF2
	 XBWN9YN0r1IrnLAvFb0KZuVMERVdEM8lxfVlg2M0oOKszj71O6F4fQwHxgwl6uNA2a
	 p+cYRkk4NojviRR2cCjRobMyCINrj34SSX38Qw7U2evDG/euqNo/jSPaqYiJjXAVzz
	 /vWPA2S8xDpXg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 53/57] docs: irq/concepts: Add commas and reflow
Date: Wed, 19 Mar 2025 10:29:46 +0100
Message-ID: <20250319092951.37667-54-jirislaby@kernel.org>
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

For easier reading, it is always desired to add commas at some places in
text. Like before adverbs or after fronted sentences.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/irq/concepts.rst | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/irq/concepts.rst b/Documentation/core-api/irq/concepts.rst
index 4273806a606b..f166006a81f6 100644
--- a/Documentation/core-api/irq/concepts.rst
+++ b/Documentation/core-api/irq/concepts.rst
@@ -2,23 +2,22 @@
 What is an IRQ?
 ===============
 
-An IRQ is an interrupt request from a device.
-Currently they can come in over a pin, or over a packet.
-Several devices may be connected to the same pin thus
-sharing an IRQ.
+An IRQ is an interrupt request from a device. Currently, they can come
+in over a pin, or over a packet. Several devices may be connected to
+the same pin thus sharing an IRQ.
 
 An IRQ number is a kernel identifier used to talk about a hardware
-interrupt source.  Typically this is an index into the global irq_desc
-array, but except for what linux/interrupt.h implements the details
+interrupt source. Typically, this is an index into the global irq_desc
+array, but except for what linux/interrupt.h implements, the details
 are architecture specific.
 
 An IRQ number is an enumeration of the possible interrupt sources on a
-machine.  Typically what is enumerated is the number of input pins on
-all of the interrupt controller in the system.  In the case of ISA
+machine. Typically, what is enumerated is the number of input pins on
+all of the interrupt controllers in the system. In the case of ISA,
 what is enumerated are the 16 input pins on the two i8259 interrupt
 controllers.
 
 Architectures can assign additional meaning to the IRQ numbers, and
-are encouraged to in the case  where there is any manual configuration
-of the hardware involved.  The ISA IRQs are a classic example of
+are encouraged to in the case where there is any manual configuration
+of the hardware involved. The ISA IRQs are a classic example of
 assigning this kind of additional meaning.
-- 
2.49.0


