Return-Path: <linux-kernel+bounces-403363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D1D9C349F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47EB1F21469
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6775F224D6;
	Sun, 10 Nov 2024 21:00:53 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703713A3F3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272453; cv=none; b=CosPW6VbEu6hWiC4s58qeyqiQOtkjFuGDUTBNDGbcxTIf4RU0/8PVqJZnd1PGwapYpK+/ZStUYrpRUMqE1XOSo/EVUUxKoP70TTwoBFy1l3j8kgI2iRF1+9IHWkf2nzzgfrubZ5OSD1xSBeDbB8VaT64aJ5q4sH3CynEMIE+TZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272453; c=relaxed/simple;
	bh=TuM2v4bKs88OnxQ4o+/Uan9qBoc3OIYsSMmfWP7RecA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGLVGJMwB5ea1iNlIvCqwQAz1AtfQXXcRh8IcQFGLjM+ilX1dWlQg/Na51pDDd2OH2bx+GpujCCZmQ57N9TOCj7sAUkrVpR2o+jEqPuypId2Y31zkyXEOhvKtKxhvFop0P9y2qvlZpwkzGBiDhppT5jxhgSMK6SHir6lt7HEVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id d97256e6-9fa6-11ef-9b01-005056bd6ce9;
	Sun, 10 Nov 2024 23:00:43 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 0/6] pinctrl: cy8c95x0: A portion of cleanups
Date: Sun, 10 Nov 2024 22:59:40 +0200
Message-ID: <20241110210040.18918-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A portion of ad-hoc cleanups to the driver. Saves a few dozens of LoCs.

Andy Shevchenko (6):
  pinctrl: cy8c95x0: Use 2-argument strscpy()
  pinctrl: cy8c95x0: switch to using devm_regulator_get_enable()
  pinctrl: cy8c95x0: use flexible sleeping in reset function
  pinctrl: cy8c95x0: Use temporary variable for struct device
  pinctrl: cy8c95x0: embed iterator to the for-loop
  pinctrl: cy8c95x0: remove unneeded goto labels

 drivers/pinctrl/pinctrl-cy8c95x0.c | 142 +++++++++--------------------
 1 file changed, 45 insertions(+), 97 deletions(-)

-- 
2.47.0


