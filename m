Return-Path: <linux-kernel+bounces-288138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022A95365E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A246284EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9CC1A76B7;
	Thu, 15 Aug 2024 14:56:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1818D630;
	Thu, 15 Aug 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733804; cv=none; b=MzC3kkp4FBl8WS99y3DrZFsPYR/0WhPae2mraaQi3kK/nggIHQHgLugo0p51U9bODRAzYJBixXw3TXuudgCxLQfB9i6U7sJvOIe2nmkMIahQFTrj1ncS/uGLqtlOB5PqdKV1r8EVfcaXaATIpLt0H5+u2ofVvTaxHoENbOmHAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733804; c=relaxed/simple;
	bh=39IJ24J5R0YDMf945oAM0V0+N/O8iR965QihVEp7ZXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELxfFOCzS+KcTLPJvuHaKESthxhjCi9o+pv5VfrDcIsKIV8J8EkmuMBqh4CyCgCatr7610VENHBw/tlpIyGWN6q5FTgSnQPDXFALWzD25S1mZwmcn04FMegHZq/RoJ38RfVTumTHOg1rUKjH6p/rTlDJrRZ2WED6C307P+lhGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB89414BF;
	Thu, 15 Aug 2024 07:57:07 -0700 (PDT)
Received: from e121095-lin.cambridge.arm.com (e121095-lin.cambridge.arm.com [10.1.198.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9D23F58B;
	Thu, 15 Aug 2024 07:56:40 -0700 (PDT)
From: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
To: conor+dt@kernel.org
Cc: abdellatif.elkhlifi@arm.com,
	hugues.kambampiana@arm.com,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH v2] dt-bindings: arm: Update Corstone-1000 maintainers
Date: Thu, 15 Aug 2024 15:56:22 +0100
Message-Id: <20240815145622.377614-1-hugues.kambampiana@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814133525.4090877-1-hugues.kambampiana@arm.com>
References: <20240814133525.4090877-1-hugues.kambampiana@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous maintainers are no longer working on the Corstone-1000.
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

