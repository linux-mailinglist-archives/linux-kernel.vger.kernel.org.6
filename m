Return-Path: <linux-kernel+bounces-247878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D30192D5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6B7B20CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D93197A91;
	Wed, 10 Jul 2024 16:09:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D4197A6A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627789; cv=none; b=pu5moKyaqovvuPtes3UhZopPbmSM3ThbYAUro99NlNmzxQCgnfE8rz1idxoDLgg2u/2onB6DN+dq3gkPPn/6bAw3MwkFjSmiih9XVJyV0qKBDEweOdXNUU+s25gpmUUjj2fg99qvcxiXQA65Vpd5FZOYAQ9dgLSOolry8w+mCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627789; c=relaxed/simple;
	bh=+pRCWtu1oW2Aq+fFY6HXVsvpcuDlSczUz3gkpKQ6SSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=li4KphUP+iVtLUUFTN+cUrJb3VuILDTPEJ0Bl/SDxjBiyQlP60Z3bzoLPnWVTxVBqVa8OItbwkAvw/5vpUnGv5QSXMDLkiyxl+ihyn72h+0+IuzZNv4/kaKoObVnO0lrwwFREsGtEHxUTC283nelkVgtTTy6OzTg/EbJwlrKHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22B2B367;
	Wed, 10 Jul 2024 09:10:13 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC92E3F762;
	Wed, 10 Jul 2024 09:09:46 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v2 3/3] MAINTAINERS: List Arm interconnect PMUs as supported
Date: Wed, 10 Jul 2024 17:09:35 +0100
Message-Id: <69e234440d40c236f80a60308fb4fa527cba93b3.1720625639.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1720625639.git.robin.murphy@arm.com>
References: <cover.1720625639.git.robin.murphy@arm.com>
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

v2: Add new arm-ni.rst path

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf9c9221c388..60ce17fbed7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1724,6 +1724,17 @@ F:	drivers/mtd/maps/physmap-versatile.*
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


