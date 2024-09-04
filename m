Return-Path: <linux-kernel+bounces-315660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AD296C581
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EC81F245C2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658C1E0B68;
	Wed,  4 Sep 2024 17:34:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F15EE8D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471292; cv=none; b=ItV2gIfDc0EWxRWuGSjdBsObUBsolbgGbuYXEDtixulNxj6Kqvdx3hbn0amkOUJU7CGfpJazv1qrvQGITaQemKNKxekB9aYAQRtDjxudM2u3qzk4ElIAbI4U6/09S8tXPLvCqdtNm3ZIkadPqIn2dgwPVYXKVlzZThdLVpbJYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471292; c=relaxed/simple;
	bh=Kh4LlsJ2LO/txtAqfhL7qHCaQo1Q7cxC2N/pjxbM4Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJkzaVjitzlPBfX4KbYalpn2D5wfReDAnT4g1xVczBMuMF8zNsxrr5vAwZVwKyzYrlxgtn9jjvfcl2QK9ZTGyn8NcgOX7SLVVab/3MgaXdwJ9CjymjrenZ1DNXZUagnh+aZ+4i7L6ItN6MutXBqzifPqlTmuNvPh4aWNk9ko4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AD51FEC;
	Wed,  4 Sep 2024 10:35:16 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D33803F73B;
	Wed,  4 Sep 2024 10:34:48 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH v4 0/3] perf: Add Arm Network-on-Chip PMU driver
Date: Wed,  4 Sep 2024 18:34:01 +0100
Message-Id: <cover.1725470837.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: https://lore.kernel.org/linux-arm-kernel/cover.1725037424.git.robin.murphy@arm.com/

OK, hopefully these really are the final trivial tweaks :)

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
 drivers/perf/arm-ni.c                         | 781 ++++++++++++++++++
 7 files changed, 848 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/arm-ni.rst
 create mode 100644 Documentation/devicetree/bindings/perf/arm,ni.yaml
 create mode 100644 drivers/perf/arm-ni.c

-- 
2.39.2.101.g768bb238c484.dirty


