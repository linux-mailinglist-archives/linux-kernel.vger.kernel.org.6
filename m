Return-Path: <linux-kernel+bounces-532288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4DA44B14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675DD3B49CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A120DD74;
	Tue, 25 Feb 2025 19:08:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27C1CEAB2;
	Tue, 25 Feb 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510482; cv=none; b=lm3OcsYzE68LypdiWXjyqtlXENQyL0tWx8viHrFTNCRQhTdpZrSX6Nj5XtxhTqH0HrnoPpnBFG6XBgcqZG1giNN5S1R5EETbvlLG4mmnFzEsKKON8oJiJlIcdmStp2UmKaqzlZVgi/7MzIJsr7qQltVjzvHDbPlmzP69qZUMDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510482; c=relaxed/simple;
	bh=8HFWOPfaQ6julYwmLt/9ypWpA6ib6AebIuo0sdAJ4YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UecimwBS/3oWbSd07RHmtNJmp8GBWLgtkNxrvqnGSUXa/Cu9feaKE4DAqqHz4vQXwGEvRdizxzrZXW+LcKSWJVPFKEONyrUcTMCt4EeYsyJN0uRh7K10jUofNfm94sbCdKJNKdSIa/G+Z+quh7EW3kBPPpthO80cqYGA6/GmDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A492152B;
	Tue, 25 Feb 2025 11:08:16 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EBDC3F5A1;
	Tue, 25 Feb 2025 11:07:58 -0800 (PST)
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
Subject: [PATCH v5 4/4] MAINTAINERS: Add Vincenzo Frascino as Xilinx Sound Driver Maintainer
Date: Tue, 25 Feb 2025 19:07:46 +0000
Message-ID: <20250225190746.541587-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225190746.541587-1-vincenzo.frascino@arm.com>
References: <20250225190746.541587-1-vincenzo.frascino@arm.com>
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
index db9588b1065c..98c878b1aa05 100644
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


