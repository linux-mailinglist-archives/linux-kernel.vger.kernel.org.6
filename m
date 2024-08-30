Return-Path: <linux-kernel+bounces-309230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10D9667D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C501F2218F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A61BA888;
	Fri, 30 Aug 2024 17:19:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6C1AF4E4
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038389; cv=none; b=jY3PIyDT9OYH9nYDqTHdrZKX3AKsRfaSF8+ZhnCNmOA9eaFvtwMNx391kZUuozuD2YYXpgBmmTzGWWslo8N8NA73+kgEXutuLnhOAaazZW0aBpJchTENkh3leOJ8P7p0u2bHs/B+9QrcXQJAewt0D19uXlPDIDbu5Rv5lWDik+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038389; c=relaxed/simple;
	bh=71hc8ryXzm/KMVBs36etFtvRbkqUJ1Z3gMMMaMBWK14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pez61ZR+iTyUbp0z6TVE+NsCSVzBq4ayq17uM8Qx57a6QPwcfmJXAR3VObsaYaAlgmbiOgvdkvP/EnEgbBKQWb/Zw39nMXomvlUyzwDvuuTFFmgrdGMxvXcKJAI9v6IyouKbNtGtSFOdh/TsQbAeAr5IHSYYN+CBKQmbhiq/83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAF861063;
	Fri, 30 Aug 2024 10:20:11 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A398C3F66E;
	Fri, 30 Aug 2024 10:19:44 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH v3 0/3] perf: Add Arm Network-on-Chip PMU driver
Date: Fri, 30 Aug 2024 18:19:32 +0100
Message-Id: <cover.1725037424.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/linux-arm-kernel/cover.1720625639.git.robin.murphy@arm.com/

Hi all,

Hopefully this is good for 6.12 now. I've not managed to double-check
the interaction with userspace PMU aggregation behaviour yet, but I
think that's something to look into separately as it's not specific to
this driver.

Thanks,
Robin.


Robin Murphy (3):
  dt-bindings/perf: Add Arm NI-700 PMU
  perf: Add driver for Arm NI-700 interconnect PMU
  MAINTAINERS: List Arm interconnect PMUs as supported

 Documentation/admin-guide/perf/arm-ni.rst     |  17 +
 Documentation/admin-guide/perf/index.rst      |   1 +
 .../devicetree/bindings/perf/arm,ni.yaml      |  30 +
 MAINTAINERS                                   |  11 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/arm-ni.c                         | 778 ++++++++++++++++++
 7 files changed, 845 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/arm-ni.rst
 create mode 100644 Documentation/devicetree/bindings/perf/arm,ni.yaml
 create mode 100644 drivers/perf/arm-ni.c

-- 
2.39.2.101.g768bb238c484.dirty


