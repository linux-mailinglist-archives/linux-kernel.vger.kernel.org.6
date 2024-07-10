Return-Path: <linux-kernel+bounces-247876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8EF92D5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26FE1F2518A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AB1974F4;
	Wed, 10 Jul 2024 16:09:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8371194A7C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627783; cv=none; b=TeKS+YqMigSC9fQTpp9FqfTY/fPo4al/y8Ml4TepnndIYgbD/VhBbvErC25CYCyWlNOoM9oMggsJmIoVppicwd0IE0eoHn6ELh9t6chOOOmdy9/ZnVMnMGfJYZ1KHzLGM6vGEVF8CuX4O+ggYXMtqlaSkhF+mImyRvBd3sD1yjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627783; c=relaxed/simple;
	bh=MvpioBu39LF4CF8113GyzVamKrXmLsoml9nDIT15N5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WwHnSbo4PT0h1wX0r8YszfpmaOKcDW9/FRxeUE1j02Qb+u60BMvvUN4ZuNRs0gafll2AAifX6GJV7LYE9kjnhz4bZoo9lFSTSzPtUJWiqmkVKD7zEBzbB5doJWJhFyyXSN6SdQjKdniQg084cZwmtmEMYSZLdfWFsAwR4eO2Px0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D590367;
	Wed, 10 Jul 2024 09:10:06 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 656B43F762;
	Wed, 10 Jul 2024 09:09:40 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH v2 0/3] perf: Add Arm Network-on-Chip PMU driver
Date: Wed, 10 Jul 2024 17:09:32 +0100
Message-Id: <cover.1720625639.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-arm-kernel/cover.1713972897.git.robin.murphy@arm.com/

Hi all,

Probably a bit late now, but here's a v2 addressing Will's review
comments, and hoping to attract the DT maintainers' attention properly
this time...

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


