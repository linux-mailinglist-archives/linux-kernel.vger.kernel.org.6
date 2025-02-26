Return-Path: <linux-kernel+bounces-533820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713FCA45ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736FB165A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3592206A6;
	Wed, 26 Feb 2025 12:23:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A02E2206BB;
	Wed, 26 Feb 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572619; cv=none; b=pRybqMyYSzj6BU0Z505QRQvJRLKMARTmCIby1aFr/r6g82jsUHg+zHW7Je1yurKEMrqsj6BGmmyXJNE4zlRIv25G90EP5P/LMPM+hcTR4Us3Qmy5CpXta+U9bvjbK/82E3glXXfDywd0dMvQtaBjW2CAW9cwO+dhtdaj54ApLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572619; c=relaxed/simple;
	bh=nFlhUJpu5IyDOM3Yvq2TQXWWyR5FKc900AMjUz0SMXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsD2EMmBe4PmritLdSZVdzoDb5lztElgCBiq7yTVKZ7pQhRBJ/b0Bp1t/8cqz/kki9PQKZbMGY3jn3tr0dhKt2Y86mT22z6jk9nvLoO/RmDgQps7wRdzT8YqRSrJl5/vKtwDwquthSj+6xFDXOE16ORE+6wwns+tVVzk6mec6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61F813D5;
	Wed, 26 Feb 2025 04:23:53 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 374903F5A1;
	Wed, 26 Feb 2025 04:23:36 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-sound@vger.kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add Vincenzo Frascino as Xilinx Sound Driver Maintainer
Date: Wed, 26 Feb 2025 12:23:25 +0000
Message-ID: <20250226122325.2014547-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226122325.2014547-1-vincenzo.frascino@arm.com>
References: <20250226122325.2014547-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Vincenzo Frascino <vincenzo.frascino@arm.com> as Xilinx Sound Driver
Maintainer.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b0cc181db74..8dea8da3d6d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26011,6 +26011,14 @@ S:	Maintained
 F:	drivers/pwm/pwm-xilinx.c
 F:	include/clocksource/timer-xilinx.h
 
+XILINX SOUND DRIVERS
+M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
+F:	Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
+F:	Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
+F:	sound/soc/xilinx/*
+
 XILINX SD-FEC IP CORES
 M:	Derek Kiernan <derek.kiernan@amd.com>
 M:	Dragan Cvetic <dragan.cvetic@amd.com>
-- 
2.43.0


