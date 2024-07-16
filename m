Return-Path: <linux-kernel+bounces-253346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7104931FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1EA4B2178F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49017556;
	Tue, 16 Jul 2024 05:09:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85C6AC0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721106570; cv=none; b=KNWAT5tVNak/Ao+Egyvmsyxxs5K/v0Znp+QulwwdwhAs07b8rT4zOdwm5GFi3mX5QhooPX1D4CC3fCk0kOE5EXSv+9DxjAIWZoZP5paIoBKQhAZuZJiiZkmpammAndexqBJ4YuGdIs/H6jh86B95gbL/3f2XVLTQQ+OF9c+McwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721106570; c=relaxed/simple;
	bh=hdU+xSbWjmQzvnT9M2PFv03mnobO6Zq6HAo/Ev5ViDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBtOmB4tcs0NpW39lLvVyRdH3tfxk0cAwKe49/nZRoXCNoiXJ+KD+tVLJaSS1u4C2ywwvHGo8ug4SbT+R095VYT7U63w9AeMdbAKdBZR8Yc1Plt7C/9a5PKeEhss1MYhJ8UzIBVn0bCJa79OJGVKTugdf7OIohRlkuq5XvG2tlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA7D51063;
	Mon, 15 Jul 2024 22:09:52 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.45.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2ED0A3F762;
	Mon, 15 Jul 2024 22:09:22 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com,
	masahiroy@kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/Kconfig: Remove redundant 'if HAVE_FUNCTION_GRAPH_TRACER'
Date: Tue, 16 Jul 2024 10:39:15 +0530
Message-Id: <20240716050915.2657694-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the commit 819e50e25d0c ("arm64: Add ftrace support"),
HAVE_FUNCTION_GRAPH_TRACER has always been enabled. Although a subsequent
commit 364697032246 ("arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")
redundantly added check on HAVE_FUNCTION_GRAPH_TRACER, while enabling the
config HAVE_FUNCTION_GRAPH_RETVAL. Let's just drop this redundant check.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 79a656a62cbc..cf1781cdc062 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -211,8 +211,8 @@ config ARM64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_RETVAL
 	select HAVE_GCC_PLUGINS
 	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
 		HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
-- 
2.30.2


