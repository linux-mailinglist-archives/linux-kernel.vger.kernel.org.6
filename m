Return-Path: <linux-kernel+bounces-331375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E882097AC06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2D81F22D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7CA1487F1;
	Tue, 17 Sep 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="jXrjCm4C"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5344C77;
	Tue, 17 Sep 2024 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558046; cv=none; b=XuF7nibNvmhMpQkCLC/i6tTiRpcvCs4IZA2oZBrtDAHrKgjmxWJaKNMA3wWuRkJwP35DQqKxNj0ZC3geBE1mnbPvBj9e8tTsiiVOfvptbtruGDN8vo4wr1JqpM3pnyLeYIGlajc6LgfI5MdMDhx/kWcYyASMMC8WbLBTlw3YPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558046; c=relaxed/simple;
	bh=+TinekZI5C/JQzupIbP9P4sDVIzTo/2IvEjuIv7JWnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qe5d9gJpxoldaa2/Wv0AGgCAV7kvJNWtL0fET+0PpRIILd11iPO/F5LbByXd8R6ZBMuD+LNdQOgK1t3QcHqtK2RJWMo4Q8DuD2XikAIs57v3ZexU0rKy2HLMzUnFS0+220UwTXUY7HwwkuIoZ3neCKVbah/E/fUzSTF223moz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=jXrjCm4C; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDC631485498;
	Tue, 17 Sep 2024 09:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726558035; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=x6Pzxgu1m6lwysAs7YlOFPBChJ+MHFOE0L+Af1Qu82s=;
	b=jXrjCm4CE7G9z1SoUP3HDx1WZ81EziGkgai8ebXWDiQePcvNbaK0gwHcw1rz7B48nj7xNt
	oVATRVpdA+6LUKgHYPy5emjDodjCVNQHmVo5RYUstRaQadMsiB+hgKhvoJfBA3iK7dzVNL
	FN0LIWEcAl27s44Rx21rwHYBKBTi7rVbDFB5+Mx5Do1p3LUpRv8ACJOKoZwh+Sce5l2YUj
	ASVp5Yxxro5gdZhFYzZuWlK0kRnFwTmQu6u+Quax8AL31mS6yG9JpNIxxRDKA4IKOWrf4m
	iZtif8m8o690i9pDAcIjYGe0aj2fhmDPNxtG5hGTEs4pYgRzdftUpPHAbXmrGA==
From: Alexander Dahl <ada@thorsis.com>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: dts: microchip: rng node name and label tweaks
Date: Tue, 17 Sep 2024 09:27:08 +0200
Message-Id: <20240917072710.125435-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

this started out as a single trivial patch adding labels to device tree
nodes, so I could reference those in board files.

Greets
Alex

(series based on v6.11)

v2:
- Add second patch to unify node names

v1:
- Link: https://lore.kernel.org/linux-devicetree/20240916064233.697215-1-ada@thorsis.com/T/#u

Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Alexander Dahl (2):
  ARM: dts: microchip: Add trng labels for all at91 SoCs
  ARM: dts: microchip: Unify rng node names

 arch/arm/boot/dts/microchip/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/microchip/sam9x60.dtsi     | 2 +-
 arch/arm/boot/dts/microchip/sama5d2.dtsi     | 2 +-
 arch/arm/boot/dts/microchip/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/microchip/sama5d4.dtsi     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.39.5


