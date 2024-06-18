Return-Path: <linux-kernel+bounces-219818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586FB90D81F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6FD1C242D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E64CB4B;
	Tue, 18 Jun 2024 16:05:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FD95024E;
	Tue, 18 Jun 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726701; cv=none; b=bjjrOl+/QWuyq27DEEF0K48h5wJv/dsb5NdcRqthN1GQ8H2s+sEtZEAA729KHOc7Ho8FrWQBgHmyx2nCYZQchGymINNuQB6MhkeO1bGA+PocWQ0l7TYlIVbEc6ZZDhKlt2CvLF+SWaSNg1ZMClXjQpFOSB2X8p/zB0/oJj/qm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726701; c=relaxed/simple;
	bh=1s7vqofYqI9LHjoQBC3wRUH/YTaQ8aq9oY96lCWv8jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQ2t5+S8VFy9o4ZgD6djWWaOQ3rsB/SrqkWnvOJPkuoGxXINN/m67F4pvECrNPyaarm0Up2m34KkVmM+ScUiNXgWo0770h2uj8Uw8elp8xaiJYNsnP/QG1GVdsvqrDm5M6e+2rsQVyf2KH5tJnF1iBYmBZPcwH99E1XICJfeNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3245BDA7;
	Tue, 18 Jun 2024 09:05:20 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45AD13F6A8;
	Tue, 18 Jun 2024 09:04:54 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	Jun Wu <jun.wu@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: cpus: Add new Cortex and Neoverse names
Date: Tue, 18 Jun 2024 17:04:50 +0100
Message-Id: <20240618160450.3168005-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible strings for the Arm Cortex-A725 and Cortex-A925 CPUs, as
well as new Neoverse cores: Arm Neoverse N3, Neoverse V2, Neoverse V3,
and Neoverse V3AE.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index cc5a21b47e26a..f308ff6c3532e 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -147,6 +147,7 @@ properties:
       - arm,cortex-a710
       - arm,cortex-a715
       - arm,cortex-a720
+      - arm,cortex-a725
       - arm,cortex-m0
       - arm,cortex-m0+
       - arm,cortex-m1
@@ -161,10 +162,15 @@ properties:
       - arm,cortex-x2
       - arm,cortex-x3
       - arm,cortex-x4
+      - arm,cortex-x925
       - arm,neoverse-e1
       - arm,neoverse-n1
       - arm,neoverse-n2
+      - arm,neoverse-n3
       - arm,neoverse-v1
+      - arm,neoverse-v2
+      - arm,neoverse-v3
+      - arm,neoverse-v3ae
       - brcm,brahma-b15
       - brcm,brahma-b53
       - brcm,vulcan
-- 
2.25.1


