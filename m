Return-Path: <linux-kernel+bounces-536340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D0A47E64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EA7189108F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000A22FAC3;
	Thu, 27 Feb 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI0Kfvi5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2B22D7B4;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661075; cv=none; b=l1C2GZZq8nLvohYP5cljoXNB05//81Y09XPodFqv4Llk+f+gU5KCNAgcrqwVo+P8LeG2Q/4qkXe5oBoM2SrFYO9ox5uCa0JKNkqdq9MChXl1U6B7cFqdjsRtKGs7GlYlOQs5bqoj/sYA+IBGYir5N1TRz+Yobq3zWcKo7ztYjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661075; c=relaxed/simple;
	bh=99NMalzGkPtmA6Q9fOO7m5HZlPfV0uzaGv+dOeEGQ7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEnMdOuN+kaw52bpwCRphuxBtvW07scnA6BwfNTu1tfB8cdCPcgj9USrs8ASPMigKrcmPVHFnpFIwQ00HbKkQnZHrbhbMQsx0OwyNglu7ADNLf97YvSeBPrI1y1VhKyq8W5ttSYB/K0/Sv2UsKgY7Ocb6vn58ZmPFStzy20jAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI0Kfvi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14A8BC4CEE7;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740661075;
	bh=99NMalzGkPtmA6Q9fOO7m5HZlPfV0uzaGv+dOeEGQ7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XI0Kfvi56OC6h2ZCIfcSc/FkYpHakCDibQYLzLbzaACHQ5K019rg9bEBN8M6R6XD9
	 s2X6XjgY1EqtwyXkulAhvaGUlX9cNMitfX7Pv88rnZ0XA7rDOB+Z1weoK4YqbfjnNE
	 HnCnSl62gpiNeyzosDIA0EixgnM3xL7prgNnOVfiQbcC0fIYt7H/8QV2q11DHlYXfY
	 tXBBd2s2w2V8bCbdYbH7GaEMPmzVbrIiFGIF9/Oijz8V10b9gagTTqcqpPqCLLDLQE
	 8qip5e78zf4iZLkB6bQl4t5gbbmmmB6skPpJet/14e2qftuLZYT8FL5fcJfl/74pCt
	 Ek7au5FhiSKTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF9C19F2E;
	Thu, 27 Feb 2025 12:57:54 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 27 Feb 2025 13:57:51 +0100
Subject: [PATCH 1/3] hwmon: (ntc_thermistor) Fix module name in the Kconfig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-ntc_thermistor_fixes-v1-1-70fa73200b52@gocontroll.com>
References: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
In-Reply-To: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Joseph McNally <jmcna06@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740661074; l=743;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=CLTYjs2EJuZ8AOQpyWvAI5IZIGOf4Vy3v9F7+NSObQI=;
 b=jIE6CDMcjNgjAACih30JjMeRi7CzIfb/aOj4o3bAKwrLEDf6KQWIuGs0pUyA/lIMyvkTH/Eat
 x4bPYgzLzDzA9N19Dhe1ccbg5GPLT/T8oBM6Z9VYsENJKZhQd/Wi0c0
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The module name is incorrectly stated with a hyphen while it is an
underscore.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index f114d0c55d7831fc5d914d19a6e543cb2dbb5659..56494ab85b83b1c10a7dbf3085abea2900e9aaa1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1625,7 +1625,7 @@ config SENSORS_NTC_THERMISTOR
 	  B57891S0103 from EPCOS.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called ntc-thermistor.
+	  will be called ntc_thermistor.
 
 config SENSORS_NCT6683
 	tristate "Nuvoton NCT6683D"

-- 
2.48.1



