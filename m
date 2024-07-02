Return-Path: <linux-kernel+bounces-237620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F25923BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6A01C23098
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30615921B;
	Tue,  2 Jul 2024 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="DnvLzSmi"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAF154449;
	Tue,  2 Jul 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916916; cv=none; b=BruMLb2bB6NGuc3+73LynC+g/7dLf2pswno8mqtb2unKkE/mBZmQOx/0bGfnFfGHxDAEE7iV9Fgdro8/g7o+FRtnUVohmUO2AQ4RcRjx0TNMqob5YuFGb2gKRoUcMzohXQVN7Kd4mM+qzuPYdIs1b6QXB3f7zgHlgVhgr+WKqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916916; c=relaxed/simple;
	bh=vVZBtjQdyGHelO9SJKEk9PcX9Cn9HJoNYjoKVzUunvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHYcIZoVm0qkBoHeF3r1N/hT/wE8rjextyMECp0jUb6YwYCtPTX/D9QObfMG0tNGu8A2RD49QXuWlaOtpvL0JG9V77f+jstb3NQ7zG0CCsCU77uQhJYm89HDVtNrO0i2KLTCr4lKo7DUaZT0ROkqpRcy18Ra7XWrgwjGQ0QcCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=DnvLzSmi; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE5DCBFC11;
	Tue,  2 Jul 2024 12:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1719916379; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=d77ZQOlbpJuUyjITV/doinN4bcdAcaYxN2IVFgTz3ss=;
	b=DnvLzSmiOKxBQOFynE4Nmyh7y75kzaQVXwR0XATifdikXWYvuthO3VSpt//AcQ8o1CvLgV
	ZVLmtRWJQ9eDaLB3v5NgnFXtMuISm8J2PCOxmk9pbymc8gJlWat+hU8Hc14yCpCi9+yIZ0
	/q+YLtWrxKdE1UvB/H85ipdVmSTpOemjlz7c50aF/UZuTMtrK24ePU3nWn/O2RUIG8syrJ
	8g06H6ZfAb1y1lfAQPZf1zD4p3NolwDbJRg3LGrfxm2nkPoCMDOdOrR5SFmmhEIf3q8VGi
	f0cGFcbsDBn4Ed3dQ9IhXY5anpV+ojKkzhft0KvnQqNAEiL3ZLWnneY0gMmUAw==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/7] dt-bindings: regulator: pca9450: Make interrupt optional
Date: Tue,  2 Jul 2024 12:31:16 +0200
Message-ID: <20240702103155.321855-5-frieder@fris.de>
In-Reply-To: <20240702103155.321855-1-frieder@fris.de>
References: <20240702103155.321855-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The interrupt line is currently only used for printing warnings and
the PMIC works just fine without it.

Allow boards to not use the interrupt line and therefore make it
optional.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 849bfa50bdbab..f8057bba747a5 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -96,7 +96,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
   - regulators
 
 additionalProperties: false
-- 
2.45.2


