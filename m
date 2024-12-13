Return-Path: <linux-kernel+bounces-445169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71609F1244
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86782837BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9161EB9F8;
	Fri, 13 Dec 2024 16:32:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746C1E6DDD;
	Fri, 13 Dec 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107554; cv=none; b=V7OvgTqGc82YD7D2JxKl/CuOMfcT3WOXLFjg9z4OQddWQSMlOsqMUwEYepx4XU0hs4mfyEZ+sPz/Tr2BRosoQXjSVDol92JjT9OK+Z5kT0uoto1RxuJajlUK2shbHe4shOFg6Vh7k6bKW9cRrgSIi7VSMQ8yTkQCTPQbjyPKBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107554; c=relaxed/simple;
	bh=IgfT73FbN63LEJMuEc0uWO3bBGLK3ff5ppznG3IGQNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg4Rd5hIFQWboxSbzeNkuPAGMeFnNYGFb0lT3OJtj9gEYs7Oco9mBrfKEA09id4khn5ko5IW6kosz3QaiOEn0aNsr4DT+5VBeF3mFfNBlo25WJOXU17cZprkx+Ra5F5ZG9cdAQFJ/1iLSa+3wuqRf+NeM7hCMqOkQfJQIxhahiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20EFF1480;
	Fri, 13 Dec 2024 08:33:00 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F6693F5A1;
	Fri, 13 Dec 2024 08:32:31 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 5/8] arm64: Introduce Arm Morello System Development Platform
Date: Fri, 13 Dec 2024 16:32:18 +0000
Message-ID: <20241213163221.3626261-6-vincenzo.frascino@arm.com>
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

Introduce the Kconfig entry for the Arm Morello System Development
Platform.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 370a9d2b6919..1c4867ea9407 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -250,6 +250,11 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_MORELLO
+	bool "Arm Morello System Development Platform"
+	help
+	  Enables support for Arm Morello System Development Platform
+
 config ARCH_PENSANDO
 	bool "AMD Pensando Platforms"
 	help
-- 
2.43.0


