Return-Path: <linux-kernel+bounces-286515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DC3951BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC53B2545C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F261B1421;
	Wed, 14 Aug 2024 13:35:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9E1D52D;
	Wed, 14 Aug 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642537; cv=none; b=Ft7q/8MlhfgIxOsWLK+NUmXFibww2v8gAu17GO5xOtaxZccT3DjVxpo6dvANqzBM7reCFVk8ANRmYgV3zWalWkfRUGflMxM/XD6xlPIH7PtqcT97qYtMN7zCm3dPp4+6JJ6FlldaVvM0mWmHQGtRvFmtPKrovPyyca80+HvkrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642537; c=relaxed/simple;
	bh=cMIRtqN/0a8B+N1sqeKovZTt0QxKW3uFBxsbSS29tkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KmuYobYwBcOXjYFG0sPXukIq18oNRL2ac8cE3sQbqm9FzMt5g/1uGZHFFUBUi+6HN4HXjESOKvHuUK0qjVBIv70DNc17S4mK5JgvbXYxN95xOf84UFTtZYXi/83a4IDsZS3ol++MJDsrKpHYYi3Iw2XkE0M0x8chluJQUbff9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19BA4DA7;
	Wed, 14 Aug 2024 06:36:01 -0700 (PDT)
Received: from e121095-lin.cambridge.arm.com (e121095-lin.cambridge.arm.com [10.1.198.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 388A53F6A8;
	Wed, 14 Aug 2024 06:35:34 -0700 (PDT)
From: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
To: devicetree@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hugues.kambampiana@arm.com,
	abdellatif.elkhlifi@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Update Corstone-1000 maintainers
Date: Wed, 14 Aug 2024 14:35:25 +0100
Message-Id: <20240814133525.4090877-1-hugues.kambampiana@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add new maintainers: Abdellatif El Khlifi, Hugues Kamba Mpiana
- Remove maintainers: Vishnu Banavath, Rui Miguel Silva
- Update contact information for existing maintainers

Signed-off-by: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
---
 Documentation/devicetree/bindings/arm/arm,corstone1000.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,corstone1000.yaml b/Documentation/devicetree/bindings/arm/arm,corstone1000.yaml
index 693f3fe7be60..cff1cdaadb13 100644
--- a/Documentation/devicetree/bindings/arm/arm,corstone1000.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,corstone1000.yaml
@@ -7,8 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ARM Corstone1000
 
 maintainers:
-  - Vishnu Banavath <vishnu.banavath@arm.com>
-  - Rui Miguel Silva <rui.silva@linaro.org>
+  - Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+  - Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
 
 description: |+
   ARM's Corstone1000 includes pre-verified Corstone SSE-710 subsystem that

