Return-Path: <linux-kernel+bounces-330454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A8979EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778D72813FD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D315383F;
	Mon, 16 Sep 2024 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BuNgnnO4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE914B07A;
	Mon, 16 Sep 2024 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480239; cv=none; b=ZardCDoHH4NzLAyXMAaRQiriyn9c4lSa7GAFK9fsZzohd+aWgYJN0XAvLW6h55lvB3XmT+oIAXUAfIDNemh22sIspA1Yis80WLC/+qcT9/76q9HLHzU1Q2isvpq/hWdMOUMPh5aDV/rmjRGq02MfLv9+I8pxl8SAjBUwt+xLfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480239; c=relaxed/simple;
	bh=IMTQEf/JsEhNn9hxmAfyuprjfemrvmpeaN0K8J1Fyo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ttQ0D587mo/yPJtQcnZDxh9cDeh8FDDBEslgMBmmnl0p7Ba3Fl9Ybrj+YdyIxCb0xNmkGSj5bToTvTRzV+xqPc+GZfMpVsdceOS1pXYLq8mE3itIoDkRTHV0jkkC8ZrbiLC/q1Iws4fNOobMynSA9VmFmuRF5dbjax9+iUNi3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BuNgnnO4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726480238; x=1758016238;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IMTQEf/JsEhNn9hxmAfyuprjfemrvmpeaN0K8J1Fyo4=;
  b=BuNgnnO4ZMhjXnrUjWHIojSXKy7aZvRLa0sf/JV0PTq6D6xSg9Dh/xus
   zTHFz/eQ/4D9z5tfEXOU4PZ/NTenF63xJZUeXmOTvs//X1L5w0tU2iIWs
   56Sj5ta13cwUSgX3v3HVoEdKw9Z2Pb68G6ldC+8L6nnCe7fDGHH26mAzh
   XjmIQexrgQn0eMMIkS4TOj5tQZJwjSMzrJxmiSo/C6LQJTx3chHWbfIfP
   3FfwbRR9e0jV9Lx2t/MmaCgazK72rxKoWOK9c5SdMl3dSE3Y7tcoKtKjq
   id2wZp/CE4DXKYTbr8UjIn/elt/8J16DDb3FF9mFJ5OQTDdXT5L19KByC
   A==;
X-CSE-ConnectionGUID: FMt8JCZwTJSUmtKKgkwdXA==
X-CSE-MsgGUID: qpwBePRKSymtVYn7wrpYAg==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="199259965"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 02:50:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 02:50:19 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 02:50:17 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 16 Sep 2024 11:49:20 +0200
Subject: [PATCH 2/4] clk: lan966x: make clk_names const char * const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240916-lan969x-clock-v1-2-0e150336074d@microchip.com>
References: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
In-Reply-To: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kavyasree Kotagiri
	<kavyasree.kotagiri@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Change clk_names to const char * const to silence checkpatch in
subsequent patches.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/clk/clk-lan966x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index 870fd7df50c1..4dbd4eb0e507 100644
--- a/drivers/clk/clk-lan966x.c
+++ b/drivers/clk/clk-lan966x.c
@@ -24,7 +24,7 @@
 
 #define DIV_MAX		255
 
-static const char *clk_names[N_CLOCKS] = {
+static const char * const clk_names[N_CLOCKS] = {
 	"qspi0", "qspi1", "qspi2", "sdmmc0",
 	"pi", "mcan0", "mcan1", "flexcom0",
 	"flexcom1", "flexcom2", "flexcom3",

-- 
2.34.1


