Return-Path: <linux-kernel+bounces-445172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E082E9F124D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD09016AF22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647661E0B7C;
	Fri, 13 Dec 2024 16:32:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B51EC00E;
	Fri, 13 Dec 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107557; cv=none; b=UksRWVVU0C3GrZHVXA8Xu24sUexEh/YACOyEH6dRhUguW4etxBzThtW10MaZw07cWPRBJiBAjVkBFNnaA3vR7l7RX/2WCI9mZUGXso8i9m/D3IFJ1LTmkwm8mbebjRbSqDviNPaZtr54/wSRGsC5ZeW8hb56CsEQFsdA6OWH4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107557; c=relaxed/simple;
	bh=T3qmkBuZLQOTIecUS6FsHeZHQVAmH8NCq3yHhaZQbF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBeLjZoSqRVtRnNNPKXZ+9O73gccu9x2PzDlfengGBnRaS4N6Tdd4POqWKMOHRtg+P5NCmragotRN6Tqs1YsxRaZzrjkc+AV1r+Qn4geLok1RQN+grTpiK1FaQi6ul7RCBfM64TmFCI/VL72JUkX5owRmmZVVMq9os/MT5DuH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EAC11480;
	Fri, 13 Dec 2024 08:33:03 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D5333F5A1;
	Fri, 13 Dec 2024 08:32:34 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 8/8] MAINTAINERS: Add Vincenzo Frascino as Arm Morello Maintainer
Date: Fri, 13 Dec 2024 16:32:21 +0000
Message-ID: <20241213163221.3626261-9-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213163221.3626261-1-vincenzo.frascino@arm.com>
References: <20241213163221.3626261-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6e71b05710b..8199e5945fb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3304,6 +3304,12 @@ F:	drivers/clocksource/timer-versatile.c
 X:	drivers/cpufreq/vexpress-spc-cpufreq.c
 X:	Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
 
+ARM MORELLO PLATFORM SUPPORT
+M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/arm/morello*
+
 ARM/VFP SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0


