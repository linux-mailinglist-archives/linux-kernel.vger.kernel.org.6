Return-Path: <linux-kernel+bounces-333625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2548497CB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC772873BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3F419994B;
	Thu, 19 Sep 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gwuMj+Rw"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88B1EF1D;
	Thu, 19 Sep 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726759267; cv=none; b=Hp7vUy5KK4EL97GyTvq4wcniGa6/3skN1savyx21YcxEE8ggaRoxJqJa5wtSfsnmLMBHZnaVIdZJ2J8nj9QuXr4EIAJFBXxggEtLYPOWw37iDipAbatZ0C84vzSs7t1ceglo9Cjx4niCcQoeQjtlRLdyPAkSUmkSfg6xDycpvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726759267; c=relaxed/simple;
	bh=nvVtJPZU+6i/0iKiXxq0eINrojPz7dYMmz/1raiBwfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0ryDHj4dvMhmrMZxfb4zvevJhERKZE+7Lb33MRFrGWjJ+V+BfkV8SwQMBicD4UyrKVxqiaUTIhLp3FBoWvn2WBfvq/RJawpEEwoTLILNE1+1ErOgd57fO/1kbuGXv35oWs4soaZnQnY6MwmQAXbC5zli8aJyI3X2kMYZ/68zHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gwuMj+Rw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6C96323D4F;
	Thu, 19 Sep 2024 17:21:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNWoonSMiFBj; Thu, 19 Sep 2024 17:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1726759263; bh=nvVtJPZU+6i/0iKiXxq0eINrojPz7dYMmz/1raiBwfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwuMj+RwZMpwd6/9vwtYGrppumnTO+qGQlMpTtJ1TVudHFNR/ZjqUykKTazDdSSXz
	 WZBRnt4N4d2HGJ00vXRCFsvZ9i4YZ0tV1yZy5VyHrQtv9nYa7GnQB420X0RhkWMzUU
	 4wqRg474W28Rvd6bTlCFGIAiACDItLBxzW6wCC6VJU15NHyyGq2FJS11lNkJM73rAF
	 yzwCjsiLzPCTk54W2k+WZkhtM40ZK5t4LXk1G7Yrfnc2vkoZf4SgvSYC+tmo3ILv0c
	 Nh6w1djHuKjpyRww3NTODoSKuiwOomoiCNczoMNqv/GH1VvaCIr//Z6dwgPMpUcDSk
	 NiPAhJ0wIPRvA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: kauschluss@disroot.org
Cc: airlied@gmail.com,
	alim.akhtar@samsung.com,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	inki.dae@samsung.com,
	krzk@kernel.org,
	kyungmin.park@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	robh@kernel.org,
	simona@ffwll.ch,
	sw0312.kim@samsung.com,
	tzimmermann@suse.de
Subject: [PATCH 6/6] dt-bindings: display: samsung,exynos7-decon: add exynos7870 compatible
Date: Thu, 19 Sep 2024 20:50:42 +0530
Message-ID: <20240919-exynosdrm-decon-v1-6-8c3e3ccffad5@disroot.org>
In-Reply-To: <20240919-exynosdrm-decon-v1-0-6c5861c1cb04@disroot.org>
References: <20240919-exynosdrm-decon-v1-0-6c5861c1cb04@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add the compatible string of Exynos7870 to the existing list.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
index 992c23ca7a4e..53916e4c95d8 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
@@ -19,7 +19,9 @@ description: |
 
 properties:
   compatible:
-    const: samsung,exynos7-decon
+    enum:
+      - samsung,exynos7-decon
+      - samsung,exynos7870-decon
 
   clocks:
     maxItems: 4

-- 
2.46.1

