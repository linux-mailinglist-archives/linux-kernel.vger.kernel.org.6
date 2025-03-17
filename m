Return-Path: <linux-kernel+bounces-564960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C2A65DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B663919A0193
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECDC1E833E;
	Mon, 17 Mar 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="l+YImy4a"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04E15573A;
	Mon, 17 Mar 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239310; cv=none; b=M/0TCSA/fhcyLvOp+7gnpKc57cPIivTn2tT2R/DTNncfjwhKZxiQgfr9RjpvCE2c3vcmW37fQH8fnHimfR6tobwWlgMor65UsCc61tqDUt+6oDRLBaFF4oZDcSpQRHYXmq22sUn2K65aS8Z658PF1b2LXTAMdbgYmnVhoH0g7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239310; c=relaxed/simple;
	bh=NgHB5DloDHIam4+aHZexc6F7ttmxCu/XVF8xokkwquA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n38/uCmGKkWr2SiDXbteIgOStT+QS1Dba8tGWzZpPlSiMoDQy3ZbvMscyus4qYeDC5Rt4HoQAEzeVv78ZiwKA7+p8pRfpsF1wjEpOnWImaMTZhxFLXtYDpM66fKTewtRE3Q8gJCVQJI2GKYniB3AT4AcR+nV4i+L4RpoPd+oJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=l+YImy4a; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 49DA4219D8;
	Mon, 17 Mar 2025 20:21:40 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kxohck1h9amb; Mon, 17 Mar 2025 20:21:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742239297; bh=NgHB5DloDHIam4+aHZexc6F7ttmxCu/XVF8xokkwquA=;
	h=From:Date:Subject:To:Cc;
	b=l+YImy4aQlQv0I0Anwet+lGQrE6VSpB9qlQteehdh6qiyDn79CnMF5Ds5e72K7mPw
	 UGtyf8fu0tGm6VprKTvPEkFOS9f+qePsu7X9QnkHqgIaFsmPhZOkgyF3rHbJvAYU6X
	 +psKT7kDIubpNdRF73kJWfeUgB0SYTmissoO+CAINUguxqWCf3ysv5SOzs3fjjVHPC
	 DQRmyHpwWaGdHLQAk5MC2UEzu1ZXfmwinornAmh+fncD9C/OUn5VMpHK4FNli+WGIT
	 XZ8vGfcU7kdQ1JOfqDTsUlOPtaTWtQ5H2JYb3YqZxr+3fCVQnHdLu2qtm10XIuMyl+
	 7yIxWUnHc89Mw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 18 Mar 2025 00:50:51 +0530
Subject: [PATCH RESEND] dt-bindings: gpu: arm,mali-midgard: add
 exynos7870-mali compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-exynos7870-gpu-v1-1-084863f28b5c@disroot.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Sergey Lisov <sleirsgoevy@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742239290; l=1463;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=NgHB5DloDHIam4+aHZexc6F7ttmxCu/XVF8xokkwquA=;
 b=5AWkfH6JBT7GtIr30t5ZeuidQwBQJjvOsSNHSN1mjAhWajpxjQo3OHQF3a7zfzfDPKi5Yb/CM
 NsBOKLPJ/OjBRklcXN8mQaUszht7FKeYS3IovG+S9fSNA6UYIhWyfFQ
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Exynos7870 SoC uses the ARM Mali T830 GPU, document its compatible
string with the appropriate fallback. The T830 compatible is already
defined in the panfrost driver, but was commented out as it was unused.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
This patch series is a part of Exynos7870 upstreaming.
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 0801da33a385b42fa3a7ff367fafee54b1aae458..48daba21a890d24c02383672518bbd5cd7885d16 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -45,12 +45,15 @@ properties:
               - samsung,exynos7-mali
           - const: samsung,exynos5433-mali
           - const: arm,mali-t760
+      - items:
+          - enum:
+              - samsung,exynos7870-mali
+          - const: arm,mali-t830
       - items:
           - enum:
               - rockchip,rk3399-mali
           - const: arm,mali-t860
 
-          # "arm,mali-t830"
           # "arm,mali-t880"
 
   reg:

---
base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
change-id: 20250203-exynos7870-gpu-ccb918e23b2e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


