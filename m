Return-Path: <linux-kernel+bounces-377622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E156E9AC16B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15C6282925
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318E15852F;
	Wed, 23 Oct 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GOQGZ7NP"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25BC487BE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671657; cv=none; b=kqQs8OJ4OsOWfmZlr99bwz7U5CgSEJrqCxRXhJ0LH9kh2/PQ4KDyKXGh/qlNnwfLnjWxePjt9gqjPMomZfUoKcCLNwKoIXD28lePd9Z2cK+YrGUGJoIpK9hhpk4ke/HRG5WStlvXQCnfzPDgqnJOgyTAfoFXZr5zLU7ZC3eFpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671657; c=relaxed/simple;
	bh=KpnRT1xC/tIbXBp6E358NazGB6fngel/3zML+wcej1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzu4p9MklXq5YPzwAF3VNPBkol339O0OfTkPVoYZL7dk4giU3w9d9wLs0Q4BG/Gi5QG/+QiEQcsEx4u550LdLb8vLJEAuB+AR5g1yu6qKw/nJ9Y82s48B9nr4EFFKqhpdulFC9Bqf2zC2wLbtxEkEASgHFehGQqRzQ7m+YWH0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GOQGZ7NP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729671652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z4IzQB+NoYFM2VGiSAk2wHwrWrI6hUrE0dV4AhWkjbI=;
	b=GOQGZ7NPwIySBq463OYSR9hc/o3IabRADnK0/GVAi2PrtRrWkKgf6R3jZ9hUf1O17Z/1Sz
	mTleSO8hV+5X72oDwU7ICGMvM5bo1AFHm0aPlfYSZ84asVsrOSRlZ9Qpt7zDvTeV/gRZ3E
	oiRhnvzEFmws/VKXrqrfnzV5waXmtPo=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] auxbus: fix a typo
Date: Wed, 23 Oct 2024 16:20:38 +0800
Message-Id: <20241023082038.2921436-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the "domain- pecific" with "domain-specific", since its a typo.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/base/auxiliary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 7823888af4f6..c16d3b4c1513 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -92,7 +92,7 @@
  * Auxiliary devices are created and registered by a subsystem-level core
  * device that needs to break up its functionality into smaller fragments. One
  * way to extend the scope of an auxiliary_device is to encapsulate it within a
- * domain- pecific structure defined by the parent device. This structure
+ * domain-specific structure defined by the parent device. This structure
  * contains the auxiliary_device and any associated shared data/callbacks
  * needed to establish the connection with the parent.
  *
-- 
2.34.1


