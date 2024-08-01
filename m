Return-Path: <linux-kernel+bounces-271719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F7C945285
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CA91C238E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422013D63A;
	Thu,  1 Aug 2024 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="Sd+HjG3d"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D73A1B5;
	Thu,  1 Aug 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535479; cv=none; b=gb1Ipsi5Q44dmaNp9QKUS26Qd+mb+pgpbwFmnRGudhCWbHQR3BkO39vDbb+f56wMHRPNQmp8h43rHEDAvJkT7nHz0OuCbgs5aFJZsaYHWCyFQwX7TYmhz1nhHbuRGa2B+rdGrC7iWkunQ/LbbECPNuzO6dSFvjLCfrujSJYnZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535479; c=relaxed/simple;
	bh=4jtqVeRk8i45uB6Vce88P8reMQMRwNTaDj7OWx8+YiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mENfcRAja8i6DF+WOxWVh+CkX6QYLwU/9ixqXNK8antKehoUTVNF0HB9EBVk+MLZHQS0YgKeHRxb9GYzdHQ+G+px3fENIKGZiMmK2EvfugGFFCxRP9Fqdy/VKqrwuA6WgJ6U84vwkq8xbLErKZngKystZYV0VUftLD+2C4OWHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=Sd+HjG3d; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id 5542A40460CE; Thu,  1 Aug 2024 17:58:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su 5542A40460CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1722535092;
	bh=4jtqVeRk8i45uB6Vce88P8reMQMRwNTaDj7OWx8+YiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sd+HjG3do+tDc9TVIStTiBaOqpRZKquT1h3myjJ+FI99O1rm4oHA3d9D1XrKsZrxS
	 a+XCLHZKP6EjQBr6RfmonsW926jSsVQYOKiumHVge0B1QBoAGBk9J/dM85xS1Upizg
	 aYmT3VEKgrPAuWzLU5OXNo5W9FA1wN2/cNTXV4f4upPEOJO1QgqK9GRkRE3I0k0SDf
	 Kc2OrZ+0fCexidUtwjT5TqDGxAGJRQVSYW+85gMkDZjmE7gDcCVL0BeOlBMTWow3zq
	 hLK9AxrwrOgGx2fZl2Nk0MX1vlPWxNQQemV89ERFaTTRiQ7bszywKF6LQm6y0uv4yL
	 Qm9BxdUttSLxA==
From: Sergey Bostandzhyan <jin@mediatomb.cc>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Bostandzhyan <jin@mediatomb.cc>
Subject: [PATCH V2 2/2 RESEND] dt-bindings: arm: rockchip: Add NanoPi R2S Plus
Date: Thu,  1 Aug 2024 17:57:36 +0000
Message-Id: <20240801175736.16591-3-jin@mediatomb.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240801175736.16591-1-jin@mediatomb.cc>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <20240801175736.16591-1-jin@mediatomb.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the NanoPi R2S Plus variant, which is an R2S with eMMC.

Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..e3121d4eba18 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -216,6 +216,7 @@ properties:
               - friendlyarm,nanopi-r2c
               - friendlyarm,nanopi-r2c-plus
               - friendlyarm,nanopi-r2s
+              - friendlyarm,nanopi-r2s-plus
           - const: rockchip,rk3328
 
       - description: FriendlyElec NanoPi4 series boards
-- 
2.20.1


