Return-Path: <linux-kernel+bounces-336754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B498405B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6BD1F225D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD7A14B084;
	Tue, 24 Sep 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="gESwmPYe"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E27145B0F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166239; cv=none; b=Yex6vCfFK6ShGQMlYKaONgKyqQyaqTVxYZo8QQLgF+Fv72dlIM2flr99LcV91228IZp+Zyme095s5mREdgJeOZgG3bRiqJwSQfuCLb4ifxnjzIO4Wm/2muY+oQel87Oo1GlCHWivUtGDg04Qy+WLKfCQCI4pyS04JQAqDQnLWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166239; c=relaxed/simple;
	bh=uv/F0+QNX21Vcc4ZV33nCNk1otifWMjv/1o/svQYAlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCiEGBMfKjThBDtI+/Un2IjydgRUTTfjok8hZ3VQX5pmQkxNB/3EpAoWtUHADenZWVdoNaRoCkl8JBFs5mVy1OaWJ75Of7sqVQEMt31JONwsX12kE2xsB4gNRZMJdkqH+WNC3jobN2BT8kao4721yRiDwGFLk802F6p2xXeiU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=gESwmPYe; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727166234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/zOw2Fx9GEN9HIlLC3EoOVa+hkvhGF6/jf2SXzGj3+U=;
	b=gESwmPYehYrhyRhxgZ298xHiwXGLK/mG4AW0Gq/ByKpQefZTT/pgD6uiwjQ9er/DzOgtcP
	ZfBFlpoPPVrjfAf4OsxPSibPddCiLh8nmfBNj9w800gtnvKIpiHGrU8wzcJO/4LxjD91Sk
	FHrfgZso9B8KnCDX1HjMQNDsJYIpw+w3hoGFQskYPWLIV0Pqm5UsTKW4sX34ZwTKdgArd3
	PNkqUMzAFvVMuQJsDw8NzGc6N69UzfndLVRG9Gv5VdC6ja3AbfuvQAgXXQ8SoKnRCwP/F4
	OTvTL5yfz8KEmun9EBX38z9vOFqlOmKnuCnpB4zVAr6JWuc+5P3LnhmkOtsp3Q==
From: Diederik de Haas <didi.debian@cknow.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH v2] mm/damon/Kconfig: Update DAMON doc URL
Date: Tue, 24 Sep 2024 10:21:46 +0200
Message-ID: <20240924082331.11499-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The old URL doesn't really work anymore and as the documentation has
been integrated in the main kernel documentation site, change the URL to
point to that.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
Changes v1 -> v2:
- Add 'Kconfig' to subject
- collect R-b tag

 mm/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index fecb8172410c..35b72f88983a 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -9,7 +9,7 @@ config DAMON
 	  access frequency of each memory region. The information can be useful
 	  for performance-centric DRAM level memory management.
 
-	  See https://damonitor.github.io/doc/html/latest-damon/index.html for
+	  See https://www.kernel.org/doc/html/latest/mm/damon/index.html for
 	  more information.
 
 config DAMON_KUNIT_TEST
-- 
2.45.2


