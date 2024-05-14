Return-Path: <linux-kernel+bounces-178494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F878C4E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047EE1F22AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EAF3A1BA;
	Tue, 14 May 2024 09:13:34 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7903717F;
	Tue, 14 May 2024 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678014; cv=none; b=amgxyMVAeddJ8hIgN70JjhZ5uAVr+lcHDa58JfwRlei0CAUJTALZqyIFZXxfCMMpeNFAWcyZ4PjvvoBRCI/XCWnsx3I6DOcAOCo8/Iu0+4hM8k08Ve+m5EfoIZVX45NDYsq+/lHFY17JHkw27i92ynORlRMwHLh4hoiQYD2nPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678014; c=relaxed/simple;
	bh=UEdhYL3cMgFIuThNHCfuqEPNpl7OpPotitWx/s83DB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJW9QVRilA2pposSROfnEZqGd537NvDXjeoYVGyjO77DWvX5kM6E2CPj3INw10V/zvCAJWZDGzYnEA4CJ89yA6BQxsJzt8k2FGAfSqJhI6P5XQZSAsBgI8B2PEc13lG3dASTHjXIJNw8uLhI1Gcj8S0G4KubmFh4tAmXqtBdR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 18B5D201C4C;
	Tue, 14 May 2024 11:13:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C3E30201C7F;
	Tue, 14 May 2024 11:13:30 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A4A3D180222F;
	Tue, 14 May 2024 17:13:28 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add firmware-name property
Date: Tue, 14 May 2024 14:43:19 +0530
Message-Id: <20240514091320.1508015-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514091320.1508015-1-neeraj.sanjaykale@nxp.com>
References: <20240514091320.1508015-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds a new optional device tree property called firware-name.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: Add maxItems, simplify description, remove "nxp/". (Krzysztof)
v3: Corrected subject. Dropped description. (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index f01a3988538c..37a65badb448 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -31,6 +31,9 @@ properties:
       This property depends on the module vendor's
       configuration.
 
+  firmware-name:
+    maxItems: 1
+
 required:
   - compatible
 
@@ -42,5 +45,6 @@ examples:
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
+            firmware-name = "uartuart8987_bt_v0.bin";
         };
     };
-- 
2.34.1


