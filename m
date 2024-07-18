Return-Path: <linux-kernel+bounces-256162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD13934A17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE661F226A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432897E782;
	Thu, 18 Jul 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="14XfDL4Q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BF76C76;
	Thu, 18 Jul 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292048; cv=none; b=OySf88cG0KqmY/0zgcgmtT3oN/Mj4OOx/3AnTpy/KcCQ4kxR7VFP0nVI/g2E1wFCI32M955M+E0EDh5v9+aZrnLA/MjlLrm8CvWpUltFUrY3niO73TM3UT/2vCSe5J3HqTaO2gVr1CxrARI0HNE1tnGIFJQmcSbZrqaFNc/CW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292048; c=relaxed/simple;
	bh=EYoYuwremqMe2y2Izc1s/Hay7S4LTF9d105e4SREN+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uf4/NLD+qPHT+V0XELCfaQVZqBqUEks5TJuyn3+NzCQsnR5z2wuK2G++Ir8Dor0fonw8FKyI9uwmSs5vOcbXZNTskhO/JWiQw2K99y+sXf1EfYjtbY9kaF7HICPrt9VWEBgXQ74PeYBiM5Ia9s4fT9ArmQ4Tp3XZtpHGJNzq3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=14XfDL4Q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721292045;
	bh=EYoYuwremqMe2y2Izc1s/Hay7S4LTF9d105e4SREN+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=14XfDL4QLqEh36YjHC4OUphqxChLT4yNq8fL2Lw0jhG80Jfq135unpsnwyosrXJUA
	 TzQmxGhR8xouMvmk41ZehXPRY0jDnQzACbNVLI59q8Ms0v6ENAcJfosy4SbJy8lJP1
	 Q5dgVe0fV8a5nrV1+OhvHIWhI65j3UgG/a8T3/Pp+lMFNiaQo51CHG2Aw/cvah6QnS
	 4B8pTUCZa3gfezqs2PBlyQz6tlvUe4aPFa+46wlLOlEkCi9mvFaRNCBsyMoxya8aI1
	 h+Agw0M75LJp6evHeneaWA+kjZuQNhyKo9R8iXKBTVbOcZtCDlfk+mREwPtbTwE1rN
	 CFLx7rUO7iCRA==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CB02A378219E;
	Thu, 18 Jul 2024 08:40:44 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Date: Thu, 18 Jul 2024 09:40:24 +0100
Subject: [PATCH v3 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 on baseboard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-rockchip-px30-firefly-v3-1-3835cdd22eae@collabora.com>
References: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
In-Reply-To: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
 Collabora Kernel Mailing List <kernel@collabora.com>, 
 Christopher Obbard <chris.obbard@collabora.com>
X-Mailer: b4 0.13.0

Add binding for the Firefly Core-PX30-JD4 SoM when used in conjunction
with the MB-JD4-PX30 baseboard.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf5..2ad835f4068e2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -148,6 +148,12 @@ properties:
           - const: engicam,px30-core
           - const: rockchip,px30
 
+      - description: Firefly Core-PX30-JD4 on MB-JD4-PX30 baseboard
+        items:
+          - const: firefly,px30-jd4-core-mb
+          - const: firefly,px30-jd4-core
+          - const: rockchip,px30
+
       - description: Firefly Firefly-RK3288
         items:
           - enum:

-- 
2.45.2


