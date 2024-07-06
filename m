Return-Path: <linux-kernel+bounces-243192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE69292EF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16891F223A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54337145A0A;
	Sat,  6 Jul 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="j43F58M7"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2D13DDCA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264911; cv=none; b=M342VgrIvRFmPxLNoZLegHdP5VJ9J3EalDUtkZdGwHV50n8px9OcFZduy8ZZv/EFC19DyPKz7pUJ46PmW6VRn7cFh/DsOMdh3Ll/ymuKd2oWqnioQprSAlxfRI1kr5c4o4tk/sE6k3IKYAMRiskmy14elyRs3dynWHm2DNjsHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264911; c=relaxed/simple;
	bh=a9cIdRwbYAsMOQaFrms7Ds63b34iXruWtWg9od9s6BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLOo1EKEv55AJno4LMgVzjGuqqwY8yDBGNiDJcpQ47RTtd0wRajOlCLCVRcLXgCkYHNu4jWUBJ0EncvkI1ZnOA0OloOfqtHOFXxtcCqumqoMcTcQPpel4FXrLEKlCZIWBoB4Js/UAiaY/sRgPRJtYuuQ5khmuOPSMPgOxIWlDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=j43F58M7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=kFSHAcT0iazh/LMieZ8QFfwZuJMbJ2j1igrsGAApNvY=; b=j43F58
	M7AOoVPFgVCHH6Yc6H+IQVXaPqSesNy0QUPyzBv9hUe+0e5qjvis/8/LOOZnVtdc
	S3NIBfaGRdp3isjVrOEcEh7zKaUGbgHN6dcC5536NyRGIVi6eSnpJ/RqTzYBk2qO
	XQryr//TwJ62OIa7NIKVlCX62No5JDhvFkDZnxhLGEYDffwG6E6ISaxLio8yXHxl
	txGSbdL8Yjiga+qW8S6qKR4EUzq+sg7qdzSbldooqCzCDyLCBRhAtsYyDLkP92yL
	4UPLEjrAbR4nd8FMzhIvdvuaDWfkxjK2JZ1HAb2JpqP48h1tntOJ2MC3FJLUnqaN
	iCdFPqFHarEvu5uw==
Received: (qmail 3809831 invoked from network); 6 Jul 2024 13:21:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:33 +0200
X-UD-Smtp-Session: l3s3148p1@ZtDmYZIcsJBQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/60] i2c: gpio: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:16 +0200
Message-ID: <20240706112116.24543-17-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/busses/i2c-gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 4f1411b1a775..e0bd218e2f14 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -216,8 +216,8 @@ static int fops_lose_arbitration_set(void *data, u64 duration)
 
 	priv->scl_irq_data = duration;
 	/*
-	 * Interrupt on falling SCL. This ensures that the master under test has
-	 * really started the transfer. Interrupt on falling SDA did only
+	 * Interrupt on falling SCL. This ensures that the controller under test
+	 * has really started the transfer. Interrupt on falling SDA did only
 	 * exercise 'bus busy' detection on some HW but not 'arbitration lost'.
 	 * Note that the interrupt latency may cause the first bits to be
 	 * transmitted correctly.
@@ -245,8 +245,8 @@ static int fops_inject_panic_set(void *data, u64 duration)
 
 	priv->scl_irq_data = duration;
 	/*
-	 * Interrupt on falling SCL. This ensures that the master under test has
-	 * really started the transfer.
+	 * Interrupt on falling SCL. This ensures that the controller under test
+	 * has really started the transfer.
 	 */
 	return i2c_gpio_fi_act_on_scl_irq(priv, inject_panic_irq);
 }
-- 
2.43.0


