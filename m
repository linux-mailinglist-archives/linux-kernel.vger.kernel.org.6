Return-Path: <linux-kernel+bounces-367297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C883C9A0094
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069B81C239EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72718BBBE;
	Wed, 16 Oct 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fbywkrjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F471885AF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056476; cv=none; b=ntez3BIjvgNkwUSyYUlRcPZ7TFhj8m5DaD3+aIC/omyZaAQlJy5bQkGAtU7+Hm6LfgXV2cRPeEK9dJe3MS8qR7w1t4qL1quZjOW4i+nokqEREHR9bjS16ZSCiDMZGGBJ6vTZNVHansUwO1ONGiqavZQXvEpcxl5NW0ZeeC3wp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056476; c=relaxed/simple;
	bh=68woyE75ZIGwOaOLLsh1imaUUCQWdiGYr0Y+KyS1j1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3ZhjuWdFZtBQx5nkt1gv8q778hkNPx183bBzqr01XJe0rHZ306Uy/QtNuUwJWzJ8VtgoMQX2Gk4fBt60SVwoB/H+z8aAtvxx2Xqo3c8RFb/t3tsFmhShcRKZbnkemzqc2BxzFAimYHBqmYH0m4cyapdhAHh2agaj9z84moGebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fbywkrjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F2C4CEC7;
	Wed, 16 Oct 2024 05:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729056475;
	bh=68woyE75ZIGwOaOLLsh1imaUUCQWdiGYr0Y+KyS1j1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fbywkrjj7Vlf6V20QnRMYPLTR0QlaLScl4vqg2Znzpnw+CdwPLcXYhTr2tmpbOqgF
	 mY/NnKTSR8lvq28GytdIHkQyln8LRLZc27IvwMUkelbMT1di7x2qGeNL9Qhi6YCrhB
	 YEBoO77IpasMYCWpA5GA7FTy4xKQtnLlm0V16n5ssMU2vTn/6j+BoyaHjuA5EshqmE
	 lte1VO8CN/yrhPrcP0T6F2tTCVocmcSFo/rXWj9F4NaRLU3nnuGXEFJ2sTLNrFnMYd
	 X8YwlYkD6zh0oHEPiyRht5mlhmsq8d4VRFf7ZC3QonAe723Ud+xhHBrNjGha83QflL
	 fYTh5B1XhxK5A==
From: Vineet Gupta <vgupta@kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 1/3] arc: rename aux.h to arc_aux.h
Date: Tue, 15 Oct 2024 22:27:47 -0700
Message-ID: <20241016052749.1640081-2-vgupta@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016052749.1640081-1-vgupta@kernel.org>
References: <20241016052749.1640081-1-vgupta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Benjamin Szőke <egyszeregy@freemail.hu>

The goal is to clean-up Linux repository from AUX file names, because
the use of such file names is prohibited on other operating systems
such as Windows, so the Linux repository cannot be cloned and
edited on them.

Reviewed-by: Shahab Vahedi <list+bpf@vahedi.org>
Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/arcregs.h       | 2 +-
 arch/arc/include/asm/mmu-arcv2.h     | 2 +-
 include/soc/arc/{aux.h => arc_aux.h} | 0
 include/soc/arc/mcip.h               | 2 +-
 include/soc/arc/timers.h             | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/soc/arc/{aux.h => arc_aux.h} (100%)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 4b13f60fe7ca..005d9e4d187a 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -146,7 +146,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include <soc/arc/aux.h>
+#include <soc/arc/arc_aux.h>
 
 /* Helpers */
 #define TO_KB(bytes)		((bytes) >> 10)
diff --git a/arch/arc/include/asm/mmu-arcv2.h b/arch/arc/include/asm/mmu-arcv2.h
index d85dc0721907..41412642f279 100644
--- a/arch/arc/include/asm/mmu-arcv2.h
+++ b/arch/arc/include/asm/mmu-arcv2.h
@@ -9,7 +9,7 @@
 #ifndef _ASM_ARC_MMU_ARCV2_H
 #define _ASM_ARC_MMU_ARCV2_H
 
-#include <soc/arc/aux.h>
+#include <soc/arc/arc_aux.h>
 
 /*
  * TLB Management regs
diff --git a/include/soc/arc/aux.h b/include/soc/arc/arc_aux.h
similarity index 100%
rename from include/soc/arc/aux.h
rename to include/soc/arc/arc_aux.h
diff --git a/include/soc/arc/mcip.h b/include/soc/arc/mcip.h
index d1a93c73f006..a78dacd149f1 100644
--- a/include/soc/arc/mcip.h
+++ b/include/soc/arc/mcip.h
@@ -8,7 +8,7 @@
 #ifndef __SOC_ARC_MCIP_H
 #define __SOC_ARC_MCIP_H
 
-#include <soc/arc/aux.h>
+#include <soc/arc/arc_aux.h>
 
 #define ARC_REG_MCIP_BCR	0x0d0
 #define ARC_REG_MCIP_IDU_BCR	0x0D5
diff --git a/include/soc/arc/timers.h b/include/soc/arc/timers.h
index ae99d3e855f1..51a74166296c 100644
--- a/include/soc/arc/timers.h
+++ b/include/soc/arc/timers.h
@@ -6,7 +6,7 @@
 #ifndef __SOC_ARC_TIMERS_H
 #define __SOC_ARC_TIMERS_H
 
-#include <soc/arc/aux.h>
+#include <soc/arc/arc_aux.h>
 
 /* Timer related Aux registers */
 #define ARC_REG_TIMER0_LIMIT	0x23	/* timer 0 limit */
-- 
2.43.0


