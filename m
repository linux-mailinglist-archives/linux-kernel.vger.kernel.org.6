Return-Path: <linux-kernel+bounces-309233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B6C9667DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CA41C24119
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449401BBBE7;
	Fri, 30 Aug 2024 17:19:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824271BBBD4
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038394; cv=none; b=Hgq8HEcKktqaYCIHgRI4f31NHHW62l8QDdi+Ylr/jkbubnURoqGm5bLrDJ00qwl1huL1tI09PrzS9GkKWXEH5Ii62/WiZNQHSuwOAo5+xDhulr0LDwsl6AwEQ1eQGiPkfh4vReoAVywAjsOZnQDsJ502FxwYPkJwvDsudGd5VFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038394; c=relaxed/simple;
	bh=nl1qHiV1x8/5ri/Uht90lr90+DM8SvMGdxBMUx8YZTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMtcTtEC5IReuHWaBynuors8ioss0WPF0U3DqsgVwcdSbJRv7XA5VNaCegcrClUMORRMOBCodq1voTwL8OdMui3phdxwBiwZ6YoudErUaVrWXipZzyXiwQQ5/yIOhZ1lwK+hHzs0/sQsOJ7vEXPX9IVl+4NB/GMi886GRblk2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E1211063;
	Fri, 30 Aug 2024 10:20:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 218733F66E;
	Fri, 30 Aug 2024 10:19:52 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v3 3/3] MAINTAINERS: List Arm interconnect PMUs as supported
Date: Fri, 30 Aug 2024 18:19:35 +0100
Message-Id: <5326ec8f4cc43f8d74f0925037740e9c31f0d29f.1725037424.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725037424.git.robin.murphy@arm.com>
References: <cover.1725037424.git.robin.murphy@arm.com>
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

v3: No change

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


