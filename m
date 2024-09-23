Return-Path: <linux-kernel+bounces-335713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393CB97E984
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE19A283819
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD06197552;
	Mon, 23 Sep 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Sej25HZv"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967A19580F
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086050; cv=none; b=ZsAqvWITynb9x47Gbu8rrIdsa/+RZGeWc1RAmI+AyYMMicKAmulD79g53a5La6Wvwpe+8isOovDPOYdglZX/hioWUkGRrWJyLEMK90DVmAbuMupBCnS8Qbc08H8ohBkoD5MxaPS6n4BgehpSDl8O9Z9x5g3FR+KGviBTVKZC4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086050; c=relaxed/simple;
	bh=TQpL3doUAOzqaH4/O3lCAacdc2AFb3+M/efOrt9mt74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7PfrVQdps66TdvQmu8AVhwRhJDYrU/dEHiuDzH8WL3PUTA3bJbPFbr5ern1Bfbs2P14TmY9W28Dv9ZVnG64JjpBZzWNMQEq/ImauxMq/PC6eygOKP9bo3+jDD/eTbHUTgrlz+FV09scGSJDS3Kkgt919tcYAi++lAJ6gd6mm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Sej25HZv; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727086043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oCYcTAl+PnkECGw3Xrm07VTjSkzOitgt3KoVAnQzsKE=;
	b=Sej25HZvJ5ZCAj6DXEJVKc8iRhTq9vBj2P99vmv82/IeV8OHXq9Oegowka8vD7wCYOi7N2
	q011T3UJ8ulPlmLETWCRzIN7zOmhH+toIG24XoEQf57Y9EJiO1IDc18lf7qCy8fWQIWJIV
	+t+taNC/p3jmBjVbNTSx7a+ig6gXC8GqImzz9BY9RyiKikfVUOKyKSbfLdFUInBaYl9bKC
	G+iEKhUomQ3QO+neJluHwGiVkP/MQweBKN9GypNq18SgZyuXCE0Zh/J1R6EIBsav8AuvaA
	9u04oGh1qzBqwDPhtS1GwWR+X1p/LIn89wdadiSiDuMtWLuLUWqOA2ubD4ku/w==
From: Diederik de Haas <didi.debian@cknow.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] mm/damon: Update DAMON doc URL
Date: Mon, 23 Sep 2024 12:05:58 +0200
Message-ID: <20240923100615.14160-1-didi.debian@cknow.org>
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

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
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


