Return-Path: <linux-kernel+bounces-526394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C58A3FE31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEF6440158
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CFC2528F5;
	Fri, 21 Feb 2025 18:04:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19F25332D;
	Fri, 21 Feb 2025 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161045; cv=none; b=Ql52qyBp/PBD17Qfg6OYOe3iG8d2OfaXn63uoA45BEbJ1AjuIX0ds4cLWCZHEOw9xzDmO0tZc872yoEyUXEtq1ujIcVS9K2y2FiNskE4lWekAeEvtSTb2A5ChE+im3jo2mAsjH5h7qxmpeZRobXht/gSpt4KSipVOwSRJwIuwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161045; c=relaxed/simple;
	bh=aeOJd1pNcikYlgrHklgsL8hYd4QhP4EpxZRIKOihJcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKGi+yo3R7Pu9TywskXtF2lFslxbcaXWbOjNQf2eSaKAojtnUHsMPLY0ak2YK0yze2P+XrBZm6gtfH0znL0GoIooQQFTEQWGZMacWx7w/NtXAIMER5BZEe0IT/f/38gfFZBpI/Oi1sDDHMsp1CPRf/2wvG+mrq7zUsYDQOCnp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607D61CC4;
	Fri, 21 Feb 2025 10:04:21 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CB503F59E;
	Fri, 21 Feb 2025 10:04:01 -0800 (PST)
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
Subject: [PATCH v7 03/10] dt-bindings: arm: Add Morello fvp compatibility
Date: Fri, 21 Feb 2025 18:03:42 +0000
Message-ID: <20250221180349.1413089-4-vincenzo.frascino@arm.com>
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

Add compatibility to Arm Morello Fixed Virtual Platform.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/devicetree/bindings/arm/arm,morello.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,morello.yaml b/Documentation/devicetree/bindings/arm/arm,morello.yaml
index b4cfa8d048c4..e843b97fa485 100644
--- a/Documentation/devicetree/bindings/arm/arm,morello.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,morello.yaml
@@ -23,9 +23,11 @@ properties:
     const: '/'
   compatible:
     oneOf:
-      - description: Arm Morello System Development Platform
+      - description: Arm Morello System Platforms
         items:
-          - const: arm,morello-sdp
+          - enum:
+              - arm,morello-sdp
+              - arm,morello-fvp
           - const: arm,morello
 
 additionalProperties: true
-- 
2.43.0


