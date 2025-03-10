Return-Path: <linux-kernel+bounces-554025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229CA591F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B1D3AECC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59A22F39B;
	Mon, 10 Mar 2025 10:49:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632A722E41D;
	Mon, 10 Mar 2025 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603786; cv=none; b=EownuCsI6DZUqgbGVshNu0Cd4b9GrGTWvg8yfZbeZgVuaPiRchOUlrxpPLGgE/Ajjqy05uVB91CfFDayQNEnnduIu4pXR+pqW5OgjhsTArqLjL7lPln6CaEMomyxavsdQye75lI3wH691CIAZbMz2zhNS1Xz1yirAGx3JFist4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603786; c=relaxed/simple;
	bh=HYKB4FoxEcUM24iTckyNLVXwttWEPBv6LkArHEDsK7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ng/Lz+J9hsY4Z5dqBJ2M3Sw+cxK+HNQ4xON+BiPLcoajCJ5RSCNRxfaGUmrpeVTzrwSAXCeZbnkgoIe4L62LyXFYuGUXswiWCM5Xc7j8I3x3eGRW2BMCcQfkGRO4XhvX68BdUxu9TRnEGcuKNnw2mf5cVIsFT6QrCceOzTeVjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3686115A1;
	Mon, 10 Mar 2025 03:49:56 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E51DA3F5A1;
	Mon, 10 Mar 2025 03:49:42 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 8/8] perf cs-etm: Sync kernel coresight-pmu.h header
Date: Mon, 10 Mar 2025 10:49:19 +0000
Message-Id: <20250310104919.58816-9-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310104919.58816-1-leo.yan@arm.com>
References: <20250310104919.58816-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the header in the tools to align with the kernel header.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/include/linux/coresight-pmu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 89b0ac0014b0..04147e30c2f2 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -35,6 +35,7 @@
 #define ETM_OPT_CTXTID2		15
 #define ETM_OPT_TS		28
 #define ETM_OPT_RETSTK		29
+#define ETM_OPT_UPDATE_BUF_ON_PAUSE	30
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_BB         3
-- 
2.34.1


