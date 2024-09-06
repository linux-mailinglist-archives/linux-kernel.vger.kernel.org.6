Return-Path: <linux-kernel+bounces-318890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0E96F4AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAB91C23186
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF911CCEC1;
	Fri,  6 Sep 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1q4NHCHJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1CCC13C;
	Fri,  6 Sep 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627206; cv=none; b=g1sXxsE+4CtjACl1uL2RHiYe3PD0+Z0B+JmYNiHy+zs/Z2Bt87YOUcxPLjJY/gmVvBaFhoFwQkBBYDm988RJST4l2/kX1FJ5KSgBePcNmzuqlngvGODeFjsQ6YTOxO+z2D6meBx5mx+5SgQrydLm3CIQwPhQ++3bQ95D7Uu/xOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627206; c=relaxed/simple;
	bh=Fha+Z84HnDt/VNF2ZA9BN4tGKWB4DIwzvakdA71UDqY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=f12Cw11JgknRPKh4va2YMR8LWk+e1EGM4LvVeomVzg1ZN7P3/8JiNWrdg6XbY4tW0U22WqhAbOy5rbIAYPdQuCfaPk/lPqLALpA0uLLAN6Tga9ulyAG0tFepzgAJ6LVOMjVpeXMBWW0RTN5yUwOTxXiHOGlPvrrnVLuUzI7WIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1q4NHCHJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725627204; x=1757163204;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Fha+Z84HnDt/VNF2ZA9BN4tGKWB4DIwzvakdA71UDqY=;
  b=1q4NHCHJxDPTSzdeMlGnwVxuJhXY0KeBMxPdIodAlDOv35Y2jk2gFYYU
   awkyzOmUetkrhCvS+TubMMt/r67cWz/2WZ2CE8/syFl4Eh07m2BiWWoyT
   1AxfQ7d4cvotM+jRmWkFVk/X1lPpStOxsp1ZK6qI7zLTVozHZdRMViZDe
   cUxs8qJpwL1GuvpJtMRXP5W0U+QVaYFReaTEqK7UvAVp1Cw+lhTuOzXIB
   1VpwVhCAmwAUNRmNE6HOQzi5CpOQit5D7BDIWWWXGmp88yD/J4ZwFAm7S
   +VkBZublvrUfvdkwUoWcvVjKr4YmrL+vXm0FExhgQUz9IalpVHgkPRXsH
   g==;
X-CSE-ConnectionGUID: aks78ZCLRxOyTJZTZgJsDQ==
X-CSE-MsgGUID: eMbYjd8PQR2gWI+MhhVkPA==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34534551"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 05:53:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 05:53:13 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 05:53:11 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH 0/9] phy: sparx5-serdes: add support for lan969x serdes
 driver
Date: Fri, 6 Sep 2024 14:52:37 +0200
Message-ID: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABX72mYC/x3MwQrCMAyA4VcZORuYdUrrq8gO6RJdQOtIYBTG3
 t3O43f4/w1cTMXh3m1gsqrrtzScTx1MM5WXoHIzhD4MfQwBfSGrV3xTSbdUseUsjmy6imG8xMS
 ZOVFM0BaLyVPrf/8YmzO5YDYq03xMP6QF9v0HueWURoUAAAA=
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

The lan969x switch chip (upstreaming efforts beginning soon) has ten 10G
SERDES'es which share the same features and data rates as the Sparx5 10G
SERDES'es. Lets take advantage of this and reuse the existing SERDES
driver for lan969x.

In order to do this, we add a new indirection layer to the register
macros, that takes register differences into account. Additionally, we
add driver match data for other differences that we need to handle.
These other differences are handled by a combination of constants (eg.
the number of SERDES'es), ops and if's

Patch #1 adds support for match data.

Patch #2 adds a struct to handle constants and adds a constant for the
number of SERDES'es.

Patch #3 adds a constant for the number of CMU's

Patch #4 adds a struct for ops and adds a function for setting SERDES
type.

Patch #5 adds a function for getting the number of CMU's.

Patch #6 adds register macro indirection layer.

Patch #7 adds SERDES target types (eg. Sparx5, lan969x) to be used for
branching out based on the target.

Patch #8 adds support for lan969x in the Sparx5 dt-bindings.

Patch #9 introduces the new lan969x SERDES driver.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (9):
      phy: sparx5-serdes: add support for private match data
      phy: sparx5-serdes: add constants to match data
      phy: sparx5-serdes: add constant for the number of CMU's
      phy: sparx5-serdes: add ops to match data
      phy: sparx5-serdes: add function for getting the CMU index
      phy: sparx5-serdes: add indirection layer to register macros
      phy: sparx5-serdes: add support for branching on chip type
      dt-bindings: phy: sparx5: document lan969x in sparx5 dt-bindings
      phy: lan969x-serdes: add support for lan969x serdes driver

 .../bindings/phy/microchip,sparx5-serdes.yaml      |  18 +-
 drivers/phy/microchip/sparx5_serdes.c              | 195 +++++-
 drivers/phy/microchip/sparx5_serdes.h              |  44 +-
 drivers/phy/microchip/sparx5_serdes_regs.h         | 746 ++++++++++++++-------
 4 files changed, 706 insertions(+), 297 deletions(-)
---
base-commit: 221f9cce949ac8042f65b71ed1fde13b99073256
change-id: 20240822-sparx5-lan969x-serdes-driver-8389dbdd9a89

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


