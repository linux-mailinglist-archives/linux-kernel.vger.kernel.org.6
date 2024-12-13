Return-Path: <linux-kernel+bounces-444476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E761E9F0773
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E94718861AE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69A1ADFEC;
	Fri, 13 Dec 2024 09:15:43 +0000 (UTC)
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C817BEC5;
	Fri, 13 Dec 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081343; cv=none; b=EIjm7VbA1eOud7F9D+A6TqH8UyG7gCl8gj2CjzeXWNtQIC+BBcwD5+napeIS74zYCfYtaf482EHISPnZtMs6OEtdfLvRT+RDMzh29R6xJxQeY/gV0sGBYpX/AAI33wnbg9+ckanVIXG3XcDz7YjPT4LYv0XDx3sB1U1Rxw9IETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081343; c=relaxed/simple;
	bh=vWirsml4zmxor401zn+jRR+FeZpw7mL5CA0UfvZ89XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZCBnuomSXKtwvIzS2FmlVH6Gb6NzNNxnLW5BYH1GDT24i3vk4jqZxpAbjQAswxXhDIF9Cip/EB52/E4emRfVD5OokQfOFjuYD9RHJGKRPmDH3Rz/q5267PaAlmL9tvOZbUUJ5Cge4evyVmVZX2kaABw0J+7AavFYbyLYCGn5kcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from localhost.localdomain(mailfrom:huangborong@bosc.ac.cn fp:SMTPD_---.ad2ZQpQ_1734081005 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 17:10:12 +0800
From: Huang Borong <huangborong@bosc.ac.cn>
To: anup@brainfault.org,
	tglx@linutronix.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	trivial@kernel.org,
	Huang Borong <huangborong@bosc.ac.cn>
Subject: [PATCH] dt-bindings: interrupt-controller: update imsic reg address to 0x24000000 in Example 1
Date: Fri, 13 Dec 2024 17:09:24 +0800
Message-Id: <20241213090924.181249-1-huangborong@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the 'reg' property address from 0x28000000 to 0x24000000
to match the node label interrupt-controller@24000000.

Signed-off-by: Huang Borong <huangborong@bosc.ac.cn>
---
 .../devicetree/bindings/interrupt-controller/riscv,imsics.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
index 84976f17a4a1..c23b5c09fdb9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
@@ -142,7 +142,7 @@ examples:
                             <&cpu2_intc 11>,
                             <&cpu3_intc 11>,
                             <&cpu4_intc 11>;
-      reg = <0x28000000 0x4000>;
+      reg = <0x24000000 0x4000>;
       interrupt-controller;
       #interrupt-cells = <0>;
       msi-controller;
-- 
2.34.1


