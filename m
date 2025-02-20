Return-Path: <linux-kernel+bounces-524450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B50E3A3E346
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D882416B567
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E55214217;
	Thu, 20 Feb 2025 18:04:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34591DED51;
	Thu, 20 Feb 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074686; cv=none; b=OXh7ThqpPMSoYznZy4ox4G0rpm4skSU47PqeUyzif3zodyZ7iwgSkLps2E4aQEy+IMjrxpRvYtdvAzybVRSKVXecLyjCz0GjUe3PjqZv6U08KzR2+9qHgDCuX94SFH5ja+lKces9BJusTkZiOgizYZli4ofJCajsKIu6owWRSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074686; c=relaxed/simple;
	bh=VPMbdL1Vw7lgqdn6uC7hmtkVo6hwUFSfKhhgxZm5IJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lviX5YmBp2MLMD1a5OIdWjUdVFOIQreKMnK2PdYbhgW5UCSXSsaogq7VFXf9E9oWlECqjg2liACGGidNjaqcYP6aMzDdBHza9Ys+6JHyhKTPEtCnPy4JLRDCWuHp2CaxqwlFuu3Pn+FUeSMffURmcfbyHXcgQ7/CJKraOHc2REg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 221FF1BB0;
	Thu, 20 Feb 2025 10:05:02 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED0803F59E;
	Thu, 20 Feb 2025 10:04:41 -0800 (PST)
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
Subject: [PATCH v6 01/10] arm64: Kconfig: Update description for CONFIG_ARCH_VEXPRESS
Date: Thu, 20 Feb 2025 18:04:19 +0000
Message-ID: <20250220180427.3382482-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220180427.3382482-1-vincenzo.frascino@arm.com>
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com>
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


