Return-Path: <linux-kernel+bounces-568052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5679BA68D81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFBB17B545
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6FE2566D7;
	Wed, 19 Mar 2025 13:14:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7420ADF9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390057; cv=none; b=h7XBcCg3JPLJzwhDcjz8CO40YsU1DW2zuKdpTZZHhKARSVtuMAJPmsMbzTkz2syXVAkZY/QBZu7j8JaiBXA2oT4qlH3QxOJbaWV+ON9gzSh+rSDgOI6crHDekl545U2Hng4LdkidfSIPaCD9ftne909KNpoQTXIgmm1qkhecwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390057; c=relaxed/simple;
	bh=CKX6fcJLa6/FsWrJmVcv0lfz1wPz2PJbBuhR3jgvNJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hCCZSZvd+GvwE733+y8DCsLj/AQxVZBpl5oLYtRFbzAjaGqzwtzP8cZzTQdIaOxsjsLT16CTB+qpSEWFY91zxVfYg47JTxrFMdcuTHVVCSnPokRTrHobEToGxal6kcV+Lo9PjC3exAi3f9CUIxOnW0vS62YvZ9gLfsnGb7km7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A325FEC;
	Wed, 19 Mar 2025 06:14:22 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.85.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E4FF3F673;
	Wed, 19 Mar 2025 06:14:11 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com
Cc: juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	vincent.guittot@linaro.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 0/2] sched/topology: Fix sched_is_eas_possible() prints
Date: Wed, 19 Mar 2025 13:13:22 +0000
Message-Id: <20250319131324.224228-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two EAS abort condition prints by adding the missing newline

v2:
Split series for backports, Cc stable and add fixes tags.

Christian Loehle (2):
  sched/topology: Fix EAS cpufreq check print
  sched/topology: Fix EAS freq-invariance print

 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
2.34.1


