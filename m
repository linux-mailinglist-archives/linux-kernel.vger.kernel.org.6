Return-Path: <linux-kernel+bounces-445166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D059F1240
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E09316650D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F901E47CA;
	Fri, 13 Dec 2024 16:32:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1C71E3DE6;
	Fri, 13 Dec 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107550; cv=none; b=Y3aWVQfLjtsWbdU2Cq6H9Pv2MDr0h+MwoWavk6tAQyR4xXG+2veEdYg9+ETWXqcJHgO5NuRPcn4KuNWiyrXaASZ4rWkpa33TVdDGhQ0qoMJQCNeR5734ZaLS5hB4Gg5Zo+rICn1noJ51BGo0QXYObU+a7tWLQtpBhZUju5iXX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107550; c=relaxed/simple;
	bh=d2wSywQ+sHb/Jc3Nb++hlewo+hF6z7VtpICQMCKwuh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc7KWzNARA0GCbT5rREBfwNy1vYETmzYf4vPr5SIqL8VPnzlyZXsqj6wWFeIC4WFB0ZADZVmw/vEpprQzwALYYCcFFTPJt9Y5S8jaZrvCyA0os2eaqayGzGMgOx+XI7EuAZjByL9z2/tkHmHTDCY2HjUXEkMAgwkCwtjfHyseCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638FA1480;
	Fri, 13 Dec 2024 08:32:55 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 722933F5A1;
	Fri, 13 Dec 2024 08:32:26 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 1/8] dt-bindings: arm: Add Morello compatibility
Date: Fri, 13 Dec 2024 16:32:14 +0000
Message-ID: <20241213163221.3626261-2-vincenzo.frascino@arm.com>
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

Add compatibility to Arm Morello System Development Platform.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
index 8dd6b6446394..ea5a5e179ed1 100644
--- a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
@@ -118,6 +118,9 @@ properties:
         items:
           - const: arm,foundation-aarch64
           - const: arm,vexpress
+      - description: Arm Morello System Development Platform
+        items:
+          - const: arm,morello
 
   arm,vexpress,position:
     description: When daughterboards are stacked on one site, their position
-- 
2.43.0


