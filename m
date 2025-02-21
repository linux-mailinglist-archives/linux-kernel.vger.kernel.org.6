Return-Path: <linux-kernel+bounces-526392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33012A3FE20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400C13BD7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52942528F6;
	Fri, 21 Feb 2025 18:04:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925F2512F3;
	Fri, 21 Feb 2025 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161041; cv=none; b=oWEC8YMqnEG/63GYkokiRvosIt+Z8UmqAkM2D3QxfIsMetAWsCdXhik006a+yMhe6nlAJVHn6QjrA0C46lUs6GDsmkzUAu+MDW4VHrVIRu2VfAFZ6XeCoillBZpGm+vtSMbTF2+cIGwrY+iOW4sncKSInAAYRO065TBn1n04Etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161041; c=relaxed/simple;
	bh=VPMbdL1Vw7lgqdn6uC7hmtkVo6hwUFSfKhhgxZm5IJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0Wj8c4LaLgU0FRES5Vkz4J4/XaozHz6cYgHFR56PxqNkjZTDb1GYwjfPy08HxU4CTWJuFLObJiFTL6q01TYO5MbPbVXJUzfds/CQ/rPE3S5x4quu+XXsZ33DxrPNU48LAsTWWede4y9qDfNk508lU4ppCZGO6PbEZC/bfRMhtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6567B1CC4;
	Fri, 21 Feb 2025 10:04:16 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90B463F59E;
	Fri, 21 Feb 2025 10:03:56 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH v7 01/10] arm64: Kconfig: Update description for CONFIG_ARCH_VEXPRESS
Date: Fri, 21 Feb 2025 18:03:40 +0000
Message-ID: <20250221180349.1413089-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the description and contextually the help text of
CONFIG_ARCH_VEXPRESS to reflect the inclusion of all ARM Ltd Platforms.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig.platforms | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 02f9248f7c84..c468c23b2bba 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -374,13 +374,12 @@ config ARCH_UNIPHIER
 	  This enables support for Socionext UniPhier SoC family.
 
 config ARCH_VEXPRESS
-	bool "ARMv8 software model (Versatile Express)"
+	bool "ARM Ltd Platforms"
 	select GPIOLIB
 	select PM
 	select PM_GENERIC_DOMAINS
 	help
-	  This enables support for the ARMv8 software model (Versatile
-	  Express).
+	  This enables support for the ARM Ltd Platforms.
 
 config ARCH_VISCONTI
 	bool "Toshiba Visconti SoC Family"
-- 
2.43.0


