Return-Path: <linux-kernel+bounces-235886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E199B91DAD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EED11F21FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE9084A35;
	Mon,  1 Jul 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xCTAsNKT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998B8289C;
	Mon,  1 Jul 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824357; cv=none; b=dakUYCXSr2KYoXl+JqJeh2mEhk4If2Vw9xOf0mSCff/+KpeonM9F+tt9N/qunJiigO08cgkPf48sHNDqVDgZha8h7fn37QozpuDdtYTxRjQyp/R26DMnTJ1v5lX0M1YaOZ4/lnfn2/IHMOyEl3f0R6MlGAuHY3laL9Bn2WCOdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824357; c=relaxed/simple;
	bh=sabomtZUjVsNbbWpDbVJPR/Q2916OvcV2yNhBaRDqMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o5BE2lu/miFiVkpXDQTeGVlKwP9UFevcb89a3nV5HXruRIVz30t7gIqJIFsrjHN8zQvJ0VWCiwPOkmHjGHC/JWd9ecf40uQIJJwMIzIIhP4j5it+2J7NVCgF7jc97e8uvPdNjf44Ffg1l/QexQ2dd1mcRxIY4ddXPf2FwEiZERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xCTAsNKT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719824355; x=1751360355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sabomtZUjVsNbbWpDbVJPR/Q2916OvcV2yNhBaRDqMk=;
  b=xCTAsNKTn9fvripQk4P44bVaUXdiDvccc0qq3/+iAxwx8Pi59aMGJiGS
   iMhyQd8FjhgfbpcAYEvBK1gafewQWtz7gkvWEFtVbz27QqnuN0gabp3jN
   DZbFjcSvZC6iYz2+uuWvkwwU3imU/Za9dijame4vQ0ndYP6L/HQv5CBfr
   MBupfVcNK2oS+vdGQUtQhX3X5ZDbLU1l6liig5v1Licr0AJnK5oxpjRsp
   VncetC6MlwiQA+NfgYlr6GVimIQFw9iQlpC5hRdBjmZokkSuI2PIMU0L1
   CTYGMc6KIvpwWX0Pp3sDo+g3YAujsYc4USuewJXHs8Z4SYt+XH8AdfydS
   Q==;
X-CSE-ConnectionGUID: T3Ozs11LSS25nP8hYlNUig==
X-CSE-MsgGUID: e2+G/LfdTWWlbtGRJ2gvXQ==
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="29328369"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2024 01:59:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jul 2024 01:58:45 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jul 2024 01:58:39 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <megi@xff.cz>, <javierm@redhat.com>, <neil.armstrong@linaro.org>,
	<quic_jesszhan@quicinc.com>, <sam@ravnborg.org>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 0/3] Panel HIMAX support for Microchip's AC40T08A MIPI display
Date: Mon, 1 Jul 2024 14:28:34 +0530
Message-ID: <20240701085837.50855-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds panel himax display controller support for the
Microchip's AC40T08A MIPI display.

yaml file is validated using the following commands

make dt_binding_check DT_SCHEMA_FILES=<converted_yaml_file>
make CHECK_DTBS=y DT_SCHEMA_FILES=<converted_yaml_file>

Changelogs are available in respective patches.

Manikandan Muralidharan (3):
  dt-bindings: display: himax-hx8394: Add Microchip AC40T08A MIPI
    Display panel
  drm/panel: himax-hx8394: switch to devm_gpiod_get_optional() for
    reset_gpio
  drm/panel: himax-hx8394: Add Support for Microchip AC40T08A MIPI
    Display Panel

 .../bindings/display/panel/himax,hx8394.yaml  |  17 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c    | 153 +++++++++++++++++-
 2 files changed, 165 insertions(+), 5 deletions(-)

-- 
2.25.1


