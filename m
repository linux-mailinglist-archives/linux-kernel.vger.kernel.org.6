Return-Path: <linux-kernel+bounces-435471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A104C9E7851
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F122856FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AD21D4359;
	Fri,  6 Dec 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CO+ewPu6"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8F1FD7B6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510815; cv=none; b=sAQUthlu8mjwy7ALmBZ557AmvwPzpOJpEbDXNNVUAUmymqY+prI9maC81OVDc3XozHidZiz8qUzipPWrPkVR5/ykW9Xec2/T7rNDkr88SSQ3NymxdeeHGIgFco86ttoIWOM+9jDGX/gtS5vUuYhuXfH8Kbci4ojhso8UN+PBOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510815; c=relaxed/simple;
	bh=WP8InOQ9Bbn59T6AiwUBks4Oi7aCTtKBhK4NRZz+94s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQ1ljTp7K24/XAWc7pFpgOSi7v7Tf07O4YPSkT14QU85NkrDMn52/oHKQkyDUTPMVTqANoXMTA5+3eVqaqSHb8m7ieeyClkqywaVqEfMuUQbLbWZPlgkRofadoXNc4IYeB+ggV0ScULRZ/M8MVqiD+5uuDpEr0kFIhphxVgOWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CO+ewPu6; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=CO+ewPu6hxhOmX+DSiZ97pHVlSW8y+r+3GxOdGG9VfQ8g3aw8DH1/fF5zT8Z3jESECqFFayeFEIdmeqXZ52rHMdGd/NB6kAyWCQdItVaQEFUmesvLJ59ru0xkbXoLTIAjCWCTX11IJKQYNUmNvHex8r1kRG4XZoRx6QQfcEjXtMhCFJWe7/py6NWXRQiZIW5As8fMSj44fxhGzTK/F989rF9zqQVBgK1mlfmypYk3aQ1A/f9oLi+4v892O5Yf8lfIherfErg1ZQf8WpP882gGAwlg+dxWchihr1kmjBdeyYGdQnTxAF5N2S8psCdHHnO+2wiU02FQpO9JXS7nLf6Cw==; s=purelymail2; d=purelymail.com; v=1; bh=WP8InOQ9Bbn59T6AiwUBks4Oi7aCTtKBhK4NRZz+94s=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68229:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1358913524;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 06 Dec 2024 18:46:21 +0000 (UTC)
From: Umer Uddin <umer.uddin@mentallysanemainliners.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	igor.belwon@mentallysanemainliners.org
Subject: [PATCH v6 1/4] dt-bindings: arm: samsung: samsung-boards: Add bindings for SM-G981B and SM-G980F board
Date: Fri,  6 Dec 2024 18:46:06 +0000
Message-ID: <20241206184609.2437-2-umer.uddin@mentallysanemainliners.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206184609.2437-1-umer.uddin@mentallysanemainliners.org>
References: <20241206184609.2437-1-umer.uddin@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Add devicetree bindings for Samsung Galaxy S20 5G
and Samsung Galaxy S20 board.

Signed-off-by: Umer Uddin <umer.uddin@mentallysanemainliners.org>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.y=
aml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 168e77375..fab29f95d 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -241,6 +241,8 @@ properties:
           - enum:
               - samsung,c1s                     # Samsung Galaxy Note20 5G=
 (SM-N981B)
               - samsung,r8s                     # Samsung Galaxy S20 FE (S=
M-G780F)
+              - samsung,x1s                     # Samsung Galaxy S20 5G (S=
M-G981B)
+              - samsung,x1slte                  # Samsung Galaxy S20 (SM-G=
980F)
           - const: samsung,exynos990
=20
       - description: Exynos Auto v9 based boards
--=20
2.47.1


