Return-Path: <linux-kernel+bounces-423741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146C99DAC11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90219B23637
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9620103F;
	Wed, 27 Nov 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="eZgYKECN"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260C1FF7D5;
	Wed, 27 Nov 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726326; cv=none; b=PATKa+7ewBXZ7Hp2szpxyhROZb/pyerIF22c8wzJoBYUDEFHeeREaAXEeg/vah34gpSkdMThp+B5ehIG1CX18cmEHI33HSpyJNq4Jyaqvod4Wx28Ae8800/QRRNL20QT0wZDcNBZ8Cw6yHj/MKe+eMP0Ih1qQYlTFuVzH+c3MCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726326; c=relaxed/simple;
	bh=8BtAZvLv2Wi3K3tsJjRifOeqXcfFLeDRinUvaxCQRuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uumq79v1Fx3UnCoCqDqvignNOo+i09G+8ftR8Hz1Qkb1eiUFc/b/95HihtLBEuZDIKO/ElaI7Sadbu30bINRdN/fIGs2EE7gB7MpMWPzbst0XwehcKcJeJTN7jPaYbHP3vGzT85uzoahB18Q8eUFJSvgsAdDyENiayIYLqKYY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=eZgYKECN; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D59B5BFB90;
	Wed, 27 Nov 2024 17:44:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725871; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=h9azNNhaWuPAfFs9DSNTPEvOM+I77JF+eKXGxfYhoI4=;
	b=eZgYKECNx0QOlu12zh/r3KYDjPyIZru9stiH6XPzsCfT1x7w46uziaYCVM7dD6bHqKzEJd
	WFcfJ0/43XogZEhTvl5rWziHt5LyCDnyAo0pajq2xuLu1Zqr7IJG6M5bsYk05mciKEFhr2
	3IA1Vqs8VXn5hRDp5Bd2yUZkspUIKixr02KmAaLSJDKQ+2l3Cd+iCdtMYgVmkZhxXVOkzJ
	7jeLb7fos5OeVB8yyS6Tcf94bShjteJ80TwCF/l/MiW0yyXyfnGOu/xTim5epeB18HvZOh
	Bp5KSOwG+jSaKBUwbm6S3WyDYs4wGvS5p7jhawECglqF6iCsc4ypyg6385dnfA==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v2 01/11] Revert "regulator: pca9450: Add sd-vsel GPIO"
Date: Wed, 27 Nov 2024 17:42:17 +0100
Message-ID: <20241127164337.613915-2-frieder@fris.de>
In-Reply-To: <20241127164337.613915-1-frieder@fris.de>
References: <20241127164337.613915-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This reverts commit 27866e3e8a7e93494f8374f48061aa73ee46ceb2.

It turned out that this feature was implemented based on
the wrong assumption that the SD_VSEL signal needs to be
controlled as GPIO in any case.

In fact the straight-forward approach is to mux the signal
as USDHC_VSELECT and let the USDHC controller do the job.

Most users never even used this property and the few who
did have been or are getting migrated to the alternative
approach.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* split revert into separate patch
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index f8057bba747a5..79fc0baf5fa2f 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -77,11 +77,6 @@ properties:
 
     additionalProperties: false
 
-  sd-vsel-gpios:
-    description: GPIO that is used to switch LDO5 between being configured by
-      LDO5CTRL_L or LDO5CTRL_H register. Use this if the SD_VSEL signal is
-      connected to a host GPIO.
-
   nxp,i2c-lt-enable:
     type: boolean
     description:
-- 
2.46.1


