Return-Path: <linux-kernel+bounces-255441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605309340C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E3A1C212AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986ED182A79;
	Wed, 17 Jul 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zJGWl85i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B871181CE0;
	Wed, 17 Jul 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234835; cv=none; b=Am6otuf7qQCxF2jrv6+HSYY/Mh5MJW9NOEmXMBKAqKw0u5TpN5aLwEsbzEF5NPG2axV14UDwA8u2veJoniV5YjQMt/Et2OGga50PTckfHXl92wZnpaZvea/AukpK2E+7AfkM8XP6s1v88OtLmlKsn3Buj9FWn6l7ZBzqx7sC0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234835; c=relaxed/simple;
	bh=k9q0V9TcOQIA1PbY90EhLUeU/WhgnoateJ2JCPh/1u4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KStpHhPbutemS14m93JNMo3JyJH3U1SfdOZ0B381b7NFoRtYQ4f2Dj7F1KKLnwilVkWsQoZ/MYZTPXm0k4fvb2gNH2VrlwopOfLLGwOGn+95B0JWq2NwCuzVWu0SwEWZc7oSXeXJreWB3WkhRdswHER2Z9PX1YCbrBEwt5GF1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zJGWl85i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721234829;
	bh=k9q0V9TcOQIA1PbY90EhLUeU/WhgnoateJ2JCPh/1u4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zJGWl85iKQ0TazdnXhopSNq0QA29dN0TLmeIcoVb1SSX4oKQYzpqk2/WDbpaC3bRO
	 53EjQqa9bgvXFHkmfPHhU3tS4LsJRcJjJogXH242aPI0rf1XKC8T7F59SarveOdmM1
	 rojrRHj54gDCg3ztnpUV0YEsvR4z2uAfQX0uviZ54GL8qX7YvG+S6xCd6VjiOVPwfr
	 fU5iU0gzngHN/iBCNZyyK9gapCjdUapxPJq7N6uw5ub8olb9C84+sa36roMlzLj9BS
	 5GD1hZKUcgqzQe2ShPMfFZsnARirdirhRaTox98IUCRfeSPSSkcwJ8eNGPvf4lZ61P
	 mpHYu+OLrcvpQ==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1C81937813C0;
	Wed, 17 Jul 2024 16:47:09 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Date: Wed, 17 Jul 2024 17:46:59 +0100
Subject: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 with baseboard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-rockchip-px30-firefly-v2-1-06541a5a5946@collabora.com>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
In-Reply-To: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
 Collabora Kernel Mailing List <kernel@collabora.com>, 
 Christopher Obbard <chris.obbard@collabora.com>
X-Mailer: b4 0.13.0

Add binding for the Firefly Core-PX30-JD4 SoM when used in conjunction
with the MB-JD4-RK3328 & PX30 baseboard.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf5..33ca8028bc151 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -148,6 +148,12 @@ properties:
           - const: engicam,px30-core
           - const: rockchip,px30
 
+      - description: Firefly Core-PX30-JD4 with MB-JD4-PX30 baseboard
+        items:
+          - const: firefly,px30-mb-jd4
+          - const: firefly,px30-core-jd4
+          - const: rockchip,px30
+
       - description: Firefly Firefly-RK3288
         items:
           - enum:

-- 
2.45.2


