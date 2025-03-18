Return-Path: <linux-kernel+bounces-566668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927CA67AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA45719C11CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E61DB361;
	Tue, 18 Mar 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ayQDJK6J"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6A9460;
	Tue, 18 Mar 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319109; cv=none; b=bdpwDh94QQnEgF87hIIsfEv7A9r6xScHsAVMFCEmHgIUz+WsY682AJDKKvBfCZfKON6Sw0TFJ7Ewvc1DF3z+iqlRfcyX5Y4j9stA7CIXIxK7KE1AQx20wekqED8RIcQW63cdn3a3ecTLyMSUCIF5N9PNqOoGJEqWxIA6ul2zRbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319109; c=relaxed/simple;
	bh=2mxyo1QWsb0cKmtR8daQLgYMmyIzI1jWM/p5CIZf9tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TY3OVx/SG5wCkfOpEutdXBKnWyWLpo6R1835tpgVEzMsvSrgeLZPFMD0HLjtucYaRQPWPKEA+UTDBt4+TQJMtIICDTo2JF9wWpgO9ZKdZr8qUYTQJRHrnPhb5at5UERNR8pASz63CGYwxCxmXLe+HfS6O6zOOJ2uToy+ivO4Fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ayQDJK6J; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 08ED922D5D;
	Tue, 18 Mar 2025 18:31:44 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lccN4SBgsolE; Tue, 18 Mar 2025 18:31:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742319099; bh=2mxyo1QWsb0cKmtR8daQLgYMmyIzI1jWM/p5CIZf9tk=;
	h=From:Date:Subject:To:Cc;
	b=ayQDJK6JSTn5LMsDMGZ0Je/k1suQ2syWcJtdMOsiKu/s2kL4qRXpqjnF0o/MrnCW/
	 QLtmdfS9cZTrEz0YWQuAKUrKJvUzT8too3ROeNd53A2+YA9zKl82pi4Bpuw/KtqbA+
	 fJPvWq1QGXIHin7SRUD4hIG8c2nwrAZdzECsQaEIDeZ1Hon9IK2tIkvSd/vZt8qxMr
	 M19Yd96RWJfHdehZZWb9WecJQSEcIJHUgqc01CtLEi/a9RBXG/53sNeihFL5vGrej9
	 z+NBkMqPTOnltlWwpPCbd0kkWm9g0Zkxg/Kh9vEKRD/LooDkBz4WiEPAgQN8ObSJbw
	 x5FjuE3NDvd6Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 18 Mar 2025 23:01:09 +0530
Subject: [PATCH v2] dt-bindings: gpu: arm,mali-midgard: add exynos7870-mali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-exynos7870-gpu-v2-1-58dc2094dc7f@disroot.org>
X-B4-Tracking: v=1; b=H4sIANyt2WcC/13MQQ6CMBCF4auQWVszbVHQlfcwLKCMMBtKpthAS
 O9uJXHj8n/J+3YIJEwB7sUOQpED+ymHORXgxnYaSHGfGwyaCxq0itZt8qGqK1TD/FbOdTddk7G
 dIcinWejF6wE+m9wjh8XLdvhRf9cfVf5TUSutsO9Kp6+2RYuPnoN4v5y9DNCklD5JS3OorgAAA
 A==
X-Change-ID: 20250203-exynos7870-gpu-ccb918e23b2e
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742319093; l=1667;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=2mxyo1QWsb0cKmtR8daQLgYMmyIzI1jWM/p5CIZf9tk=;
 b=J7+nzaE6aKQDV2gA16Fm6HytV1GJzc/88PtwMgkAa/zEJBnLbGipln9Pvdfd5KQkGCt0FX9M3
 /FTvRQq06ClAUflP5Uutkq2yN6IIoq2FV8cUTQAxboR0xYfIPINjOw5
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Exynos7870 SoC uses the ARM Mali T830 GPU, document its compatible
string with the appropriate fallback. The T830 compatible is already
defined in the panfrost driver, but was commented out as it was unused.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
This patch series is a part of Exynos7870 upstreaming.
---
Changes in v2:
- Reviewed-by krzk.
- Link to v1: https://lore.kernel.org/r/20250204-exynos7870-gpu-v1-1-0db4c163a030@disroot.org
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
base-commit: e94bd4ec45ac156616da285a0bf03056cd7430fc
change-id: 20250203-exynos7870-gpu-ccb918e23b2e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


