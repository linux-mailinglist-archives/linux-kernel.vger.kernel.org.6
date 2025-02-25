Return-Path: <linux-kernel+bounces-532368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5DA44C14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBCA1880516
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDC20E6E0;
	Tue, 25 Feb 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3+h1D30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525E20DD79;
	Tue, 25 Feb 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514322; cv=none; b=uy3rLBC+vhfhsHd9dBv/2iZTKZ+OPFQ8gqrgmzxIxAkKgi7K6IILpmvZ0qnRS+n6IgTLHBNsr6p1vv4El2DqugrwoJFsdkXw9TnB3RHpLVPTrPuOtMU5TaYVFwXKEBUs6Cqc2dQCqJpEmDjL1TS+RXAuKNdWUhCzDPYZLo1Qu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514322; c=relaxed/simple;
	bh=a0GeMkZG0232HfnLCqIvdoB14J+eWwO/Z0Wqyt65dDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lH47R5Z4Rfe1jSZ0G82KJPAVb+UNGA11lTjqJN8TU698ecsX1hnyhfYFMzVva23pK2xNEcW5K380QhQ7Xv8Dr8zTXsd1BmABbvh5dLAQURnz2M+MgolK1cL/iJCKY+3oIad2JYeipwQR6bT84lIzNodmBhKU5DJddWqsrian6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3+h1D30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168F4C4CEDD;
	Tue, 25 Feb 2025 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514322;
	bh=a0GeMkZG0232HfnLCqIvdoB14J+eWwO/Z0Wqyt65dDA=;
	h=From:To:Cc:Subject:Date:From;
	b=f3+h1D30cfKH+jGQC4JV8nWNgvMQL/Dk8nM7aZvgejiGNC3fsZ9/5lfjB4A6et7BK
	 CAOmumytdSYhtJyLWeekzDJ1hg+doGRppbJ733+McuPb9YgKrTqfdJ0Cyg6c1qIULR
	 RjHxrc1ynskTRGo4tVO0Q+G14l8i7jRLeqjeKbo05tmcRAMYhy8LlrG+q08aotgjmY
	 O1JlDh8ORGy9nShGYHOoX60TBVycwizDuU8F7WBRtS7dqopy54H+Fd/9OuAKDqJQ1F
	 LzJZ8934ULkUsQUYQmkWt600M2TgwNkCQM8FW4Xcrdhb8wHtxN/KqSzLTdMWfC/8Jp
	 CmjKrU+BywIHg==
From: Arnd Bergmann <arnd@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: soc@linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: mark imx53_suspend_sz as unused
Date: Tue, 25 Feb 2025 21:11:52 +0100
Message-Id: <20250225201157.4190864-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Unused 'static const' variables cause a warning when building with
W=1, and imx53_suspend_sz has a definition for this as an
alternative when CONFIG_SUSPEND is disabled:

    In file included from arch/arm/mach-imx/cpu.c:9:
    arch/arm/mach-imx/common.h:101:18: error: 'imx53_suspend_sz' defined but not used [-Werror=unused-const-variable=]

It's still referenced though, so mark it as __maybe_unused, so
the one user can address the dummy copy and other files that include
the header don't produce a warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 13f3068e9845..45c1a2a7b35f 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -98,7 +98,7 @@ extern const u32 imx53_suspend_sz;
 void imx6_suspend(void __iomem *ocram_vbase);
 #else
 static inline void imx53_suspend(void __iomem *ocram_vbase) {}
-static const u32 imx53_suspend_sz;
+static __maybe_unused const u32 imx53_suspend_sz;
 static inline void imx6_suspend(void __iomem *ocram_vbase) {}
 #endif
 
-- 
2.39.5


