Return-Path: <linux-kernel+bounces-567630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8B5A68860
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E4A188C0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CAD25F7A3;
	Wed, 19 Mar 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahZUF/SI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C325F789;
	Wed, 19 Mar 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376801; cv=none; b=CERJwhQz0CBpoi/E/r1wG7Izh3s9V8KCn4eX70LlH+MZpcq+B96P4UhthWX0EEE1ZsEnqBoCN+ZSxmy0X/vPuDN32Rchfxt9LPzUZyz4cPvOxOQDcRo9Hi4E+RxIoUaLZBanqIEL+Wbd+mkMYDaw0kNDPrXMEhjwHDijawJYAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376801; c=relaxed/simple;
	bh=dsnO03vflDPM3U5wnWk1Hio9rfg5sKAr73z1/gt+U0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWThqr7tjF43ppzkRKyKSAZWKKRRVFIQo9QI5QeAEUMCQaH+RtgDvXlMBVoDkxQe1/3bi1GevkO2JrdksQEvBK4dszX9bDGiLWZ2dIhNrYjB5DVmrMxK19M2eo9/jhhVBxxfGZTA6t/Il1Tlud+z8k2HVoOZyDVz2/WJMTz/s6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahZUF/SI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05804C4CEEA;
	Wed, 19 Mar 2025 09:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376801;
	bh=dsnO03vflDPM3U5wnWk1Hio9rfg5sKAr73z1/gt+U0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahZUF/SIZlYuqdQyeagjqTMby1Rl4vLvz5hrXUHoSYbPf2spMIpunYhFCKAuomKqg
	 DroIRfo72rQXCsV6yT8yNTA/17wX7Wcu2HX8Tvvz4mH3cyfgFjOMtVB7dbZGSCsEMe
	 ehmAdatG1tKFWkVTuCmil9RIw6UcClHktllzKo9+dNT05Gi01K6pptU1N4xKgk8KGu
	 uTGbL6UvEjUWzZaxYdNmMDcKtGtDX3AeotBIbcqEHg8ijHcQeMpDptp1S0zSWJKnr/
	 wclllW8wA0S4aFCRnQ5Vbfqi2RvvN0WtvMdxWrmpcyosxnvA5u7OEbWuKfef8jWOUx
	 AcUlMyO7reLZw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 54/57] docs: irq/concepts: Minor improvements
Date: Wed, 19 Mar 2025 10:29:47 +0100
Message-ID: <20250319092951.37667-55-jirislaby@kernel.org>
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

Just note in the docs:
1) A PCI as an example for shared interrupts,
2) a sparse tree can be used for interrupts too, and
3) two i8259s have 8 pins.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/irq/concepts.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/irq/concepts.rst b/Documentation/core-api/irq/concepts.rst
index f166006a81f6..7c4564f3cbdf 100644
--- a/Documentation/core-api/irq/concepts.rst
+++ b/Documentation/core-api/irq/concepts.rst
@@ -4,18 +4,20 @@ What is an IRQ?
 
 An IRQ is an interrupt request from a device. Currently, they can come
 in over a pin, or over a packet. Several devices may be connected to
-the same pin thus sharing an IRQ.
+the same pin thus sharing an IRQ. Such as on legacy PCI bus: All devices
+typically share 4 lanes/pins. Note that each device can request an
+interrupt on each of the lanes.
 
 An IRQ number is a kernel identifier used to talk about a hardware
 interrupt source. Typically, this is an index into the global irq_desc
-array, but except for what linux/interrupt.h implements, the details
-are architecture specific.
+array or sparse_irqs tree. But except for what linux/interrupt.h
+implements, the details are architecture specific.
 
 An IRQ number is an enumeration of the possible interrupt sources on a
 machine. Typically, what is enumerated is the number of input pins on
 all of the interrupt controllers in the system. In the case of ISA,
-what is enumerated are the 16 input pins on the two i8259 interrupt
-controllers.
+what is enumerated are the 8 input pins on each of the two i8259
+interrupt controllers.
 
 Architectures can assign additional meaning to the IRQ numbers, and
 are encouraged to in the case where there is any manual configuration
-- 
2.49.0


