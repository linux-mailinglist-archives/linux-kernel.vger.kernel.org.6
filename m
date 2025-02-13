Return-Path: <linux-kernel+bounces-513648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D352A34CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D575162A12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D1241693;
	Thu, 13 Feb 2025 18:03:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC526E14E;
	Thu, 13 Feb 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469813; cv=none; b=YY7VeF2UB5DIFk7EZrNFsFE0VLg05b4St/Tat3+6ylUGXKw/Sy4Pa5zdRwkX4vruh+LcfZT2qAyXMeukI8YOQhknVbUQtPudgE2ViHGwjWmifIeQ5u3Tk4iN4QQ2Llq3BMK6I+N1cyJPmyS21wqsyuWNk5qYXeOpwuj0Xe2qhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469813; c=relaxed/simple;
	bh=vV0p1mhn8GKvnqTCnbhTpWW/fIw6GhJlSmcfWmuz1Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yg9g7iNqIDsCLHhKk+BwMfidICdV3yg5GriPf+IUeDwxr7BO5BNxKF25FeYxvOO2KaIrJxcMCwOIy5mejU+5E5RA0NfRrWX6JOZwAiTuUBrtDlB9UzRacgM3j8u7QYRn3cLtQg6A9zxsouZMWsynKIkDYxTZM+GQGv6koz0eqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E89B9113E;
	Thu, 13 Feb 2025 10:03:51 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524F53F5A1;
	Thu, 13 Feb 2025 10:03:29 -0800 (PST)
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
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 3/8] dt-bindings: arm: Add Rainier compatibility
Date: Thu, 13 Feb 2025 18:03:04 +0000
Message-ID: <20250213180309.485528-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213180309.485528-1-vincenzo.frascino@arm.com>
References: <20250213180309.485528-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm Morello System Development Platform uses Rainier CPUs.

Add compatibility to Rainier.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 73dd73d2d4fa..2e666b2a4dcd 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -177,6 +177,7 @@ properties:
       - arm,neoverse-v2
       - arm,neoverse-v3
       - arm,neoverse-v3ae
+      - arm,rainier
       - brcm,brahma-b15
       - brcm,brahma-b53
       - brcm,vulcan
-- 
2.43.0


