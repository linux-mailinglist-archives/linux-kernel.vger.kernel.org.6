Return-Path: <linux-kernel+bounces-315663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2982796C585
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55ED71C24C64
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB11E1A33;
	Wed,  4 Sep 2024 17:35:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA031E1A27
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471300; cv=none; b=Fca/0BIdAeOG3SKCoNY4cB5WKhVEzPsEJ0I0TPTHeMMt8L2LkPqXQsCD6iwQxI4WEYcaOtEUoDxfKO3n1N2USsxOE5CjPqD3OrCy3OUEn4SYiSM3fRoE7gMXKLYpDjZYhOflgQecKXV/mPq3SDFZ5/5bLhNqspTqEekLTc8UTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471300; c=relaxed/simple;
	bh=p4GH829a5aow/1LPripFJa295UA8JMYkY1ywThrtXGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHW6/PRE8knJYl5g9Qq20A/PgpPoWLU8rFTHMAlUahMeEDJu+XETqLtrDIkctCDLVbO7IgUnz8rxhFvnRjN8qoaDfL5wijuu2DAwIbo1Cwtvg84G+KDXdfuaXGx7xlVmFHMUxHdJ4rDd2t8n3D+dqcK2QNVaqmZobQcqL54RV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 905B8FEC;
	Wed,  4 Sep 2024 10:35:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 288AD3F73B;
	Wed,  4 Sep 2024 10:34:57 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v4 3/3] MAINTAINERS: List Arm interconnect PMUs as supported
Date: Wed,  4 Sep 2024 18:34:04 +0100
Message-Id: <22ef1687ff3aa9da49b4577b3a179ccc055433ae.1725470837.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725470837.git.robin.murphy@arm.com>
References: <cover.1725470837.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whatever I may or may not have hoped for, looking after these drivers
seems to have firmly stuck as one of the responsibilities of the job Arm
pays me for, and I would still like to be aware of any other patches, so
make it official.

CC: Ilkka Koskinen <ilkka@os.amperecomputing.com>
CC: Jing Zhang <renyu.zj@linux.alibaba.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..1e1cd7414f06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1737,6 +1737,17 @@ F:	drivers/mtd/maps/physmap-versatile.*
 F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
+ARM INTERCONNECT PMU DRIVERS
+M:	Robin Murphy <robin.murphy@arm.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/arm-cmn.rst
+F:	Documentation/admin-guide/perf/arm-ni.rst
+F:	Documentation/devicetree/bindings/perf/arm,cmn.yaml
+F:	Documentation/devicetree/bindings/perf/arm,ni.yaml
+F:	drivers/perf/arm-cmn.c
+F:	drivers/perf/arm-ni.c
+F:	tools/perf/pmu-events/arch/arm64/arm/cmn/
+
 ARM KOMEDA DRM-KMS DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
-- 
2.39.2.101.g768bb238c484.dirty


