Return-Path: <linux-kernel+bounces-192823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0D8D22C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF3D1F20CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F845034;
	Tue, 28 May 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ebJHnbEf"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842A1B806
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918430; cv=none; b=tJE2aLUJ/gGUuVD1l3gpdAScoDTD1c0x9BkcJ8hSXF8ODlNfAaNby4vSUtHhxfmIpaoxzA++EmLg6kKeY/+rmayLcVRXVg6BjwZbRRuSNyocJRPHxg/6zZggf/BeFzvz0uFCFrgt8lb4/kgFf2y8PYWpvU5hBGbHdQdSBRm2o7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918430; c=relaxed/simple;
	bh=mK7q9uo/REm4oQhSB0xGhbMsX8E0sB1yF6lFefIuD5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZwILDp056VULSzKpOU0/J2+iZ1ks5i38384e+NPFFa7wfIxE3OZO8uUXjMMsu0Ld793yjA94bw1CerTHPEVWcvbH5BWF60qc35yCwSy6UwfJ2OKBIHlqhqWMuJqLHNjNem781kBRrQCQheJAa1GW/ZVnEMAvB5xmV1GKUwQUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ebJHnbEf; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=d5gPtHj54xlsbSzUV1/APVqL0EdAuZ4bmIYbJLUDEdc=; b=ebJHnbEfwI5LYZ8H
	nhyemFxTFywsQudMNqGNbLihgkVQCc1bYeN4z6EoqX5ZcWJqIyREl+1jtohKPC3PoJMrNbJQkRn1q
	rQXiTsH0+mVhsGjyEvaIbVOeYna2jE/VrP1VSF3qdD8Zb7k27duyQiqVUrCKZNDyorDrno8QXyunP
	9hKsuBDSHMobyZPAWNUWUqIbKFN272CvuWNooOxWqiwI7b/V2qTdYN4b2UnoROdK+Teyx+HIwfhLl
	HJmGEgFrySYmEMihEhmWJoedcGQXo+NODLK/TCy/ERr5qw/CW4I6hOjAU+OTbrtOrrFDjiRXKz3jt
	UlpOwqdfqXENNEnEUw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sC0uc-0030a6-0p;
	Tue, 28 May 2024 17:47:02 +0000
From: linux@treblig.org
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	gokhan.celik@analog.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] regulator: max77503: remove unused struct 'max77503_dev'
Date: Tue, 28 May 2024 18:46:59 +0100
Message-ID: <20240528174659.53022-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'max77503_dev' is unused since the original
commit a0c543bdf4ba ("regulator: max77503: Add ADI MAX77503 support").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/regulator/max77503-regulator.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/regulator/max77503-regulator.c b/drivers/regulator/max77503-regulator.c
index 4a6ba4dd2acd..c7c94e868fc1 100644
--- a/drivers/regulator/max77503-regulator.c
+++ b/drivers/regulator/max77503-regulator.c
@@ -25,14 +25,6 @@
 #define MAX77503_AD_ENABLED			0x1
 #define MAX77503_AD_DISABLED		0x0
 
-struct max77503_dev {
-	struct device *dev;
-	struct device_node *of_node;
-	struct regulator_desc desc;
-	struct regulator_dev *rdev;
-	struct regmap *regmap;
-};
-
 static const struct regmap_config max77503_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-- 
2.45.1


