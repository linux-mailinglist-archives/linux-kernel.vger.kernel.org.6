Return-Path: <linux-kernel+bounces-412348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F9F9D07E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635FAB21C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BF2D627;
	Mon, 18 Nov 2024 02:30:58 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916D915D1;
	Mon, 18 Nov 2024 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731897057; cv=none; b=HhJGpavSd0bsILLdHh5M0P1hmFdxR1/cLQc2ixaaNUNCPolabsDOTTaecyda9mma8SzBq80jU0SfWP7nRZzS2E4Z81zTSNGBlMkUVGlLhj2BXl2ueQBNHPyrHTmZo+KtFcj6TCXnu5InLRp2i4kZdZrd3LIYZsc1SwSb+Or+GWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731897057; c=relaxed/simple;
	bh=TtXfN5H4J4ndzSU8WuIWwo4OK0Z8eJ7MsbV2nYDHcf8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=siMM/GNTdua9BmY6FiH5lsxYp2XEYkllOczNF+1eeBBg14Q255buA43prLtjmrNkrL0Dl/iIZsJlyXKIhGW4HkWP3JuLlHyRHVjjrH64Ttp5wh2KJ20vsQCALi3vqePbe2XHVTvoTimFxQN41KE0RPiRA0QsYl/gzBtFUFvmSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5673aa68a3eb-3b401;
	Mon, 18 Nov 2024 10:29:31 +0800 (CST)
X-RM-TRANSID:2ee5673aa68a3eb-3b401
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1673aa68a6d9-a67ca;
	Mon, 18 Nov 2024 10:29:31 +0800 (CST)
X-RM-TRANSID:2ee1673aa68a6d9-a67ca
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: thierry.reding@gmail.com
Cc: jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] soc/tegra: bpmp: Fix typo in bpmp-abi.h
Date: Sun, 17 Nov 2024 18:29:28 -0800
Message-Id: <20241118022928.11305-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The word 'traget' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 include/soc/tegra/bpmp-abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
index 6b995a8f0f6d..dc0789c20333 100644
--- a/include/soc/tegra/bpmp-abi.h
+++ b/include/soc/tegra/bpmp-abi.h
@@ -3755,7 +3755,7 @@ enum mrq_pwr_limit_cmd {
  * @defgroup bpmp_pwr_limit_type PWR_LIMIT TYPEs
  * @{
  */
-/** @brief Limit value specifies traget cap */
+/** @brief Limit value specifies target cap */
 #define PWR_LIMIT_TYPE_TARGET_CAP		0U
 /** @brief Limit value specifies maximum possible target cap */
 #define PWR_LIMIT_TYPE_BOUND_MAX		1U
-- 
2.17.1




