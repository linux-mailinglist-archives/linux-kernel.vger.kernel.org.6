Return-Path: <linux-kernel+bounces-222964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E82BE910ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7066B226D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4688B1B14EB;
	Thu, 20 Jun 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Jiq3iPNn"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899F1AF697
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899253; cv=none; b=DAR9nlAQKfQX+/HNJ90BkbC5yxMk+phGkNLPUyRycNlBPma7L+pJ7u80VtMvOthlMnhzhktj93JI8crETq1I+7pPHy9hHgLnHtljyvpYOgBnJWEisIQv56SRFMCb8LNUVmDW+mprEmfxdeoR1NRbsrwmKQqbkQMfmCzZffpzJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899253; c=relaxed/simple;
	bh=eesPK28GctZjR3wRHpMTA0/kjF6ZQa3XpdOHyGiKgek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHUOCvrSmAKEvvvYCY3bhGkoo3UZnJuTfIgkrbpyiIQv6nM9XMsGz3EI+KvBxirgj6ruyyOKiR2ivVKGLnwcw7Udpefm/tdzWwlZM4rglhHX/avumF4Bzc1tQIkbMEy4vKoSx5v5hsfHTsYnI//6M2zjnONiAKr8szS+DlRoJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Jiq3iPNn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718899248;
	bh=eesPK28GctZjR3wRHpMTA0/kjF6ZQa3XpdOHyGiKgek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jiq3iPNnlYjRenUVSnnURqtwDPy4BSlp8L7bXdP/50PZy8Q40ZcJdmrtj5EmbIAAc
	 iPSmgBtpXhVajfGw/qFbAkF2gHwV87/por+k+SOy33rCHxQFq+lOwDd25XpvXo3/pF
	 XJSWtoENEXqJHiCd/UQ9TNr4RpFP5t0jXdzvsMjc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 20 Jun 2024 18:00:34 +0200
Subject: [PATCH 2/5] nvmem: core: mark bin_attr_nvmem_eeprom_compat as
 const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240620-nvmem-compat-name-v1-2-700e17ba3d8f@weissschuh.net>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
In-Reply-To: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718899247; l=697;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=eesPK28GctZjR3wRHpMTA0/kjF6ZQa3XpdOHyGiKgek=;
 b=TquupzYeFF+EW/WR32Mr+hF7oPCr/c7uFFwFU7/pAEn3e0+0C4TIIT6kJOZ+8zD8V+U8JEYul
 AE+KaJh3Sj+ADRamWMYw2vZ1VfpUcDgkh6dHS4NKXqmT15Ol8kZx5fY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The attribute is only a template from which copies are created.
It should not be changed, so mark it const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1285300ed239..d74297d10631 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -372,7 +372,7 @@ static const struct attribute_group *nvmem_cells_groups[] = {
 	NULL,
 };
 
-static struct bin_attribute bin_attr_nvmem_eeprom_compat = {
+static const struct bin_attribute bin_attr_nvmem_eeprom_compat = {
 	.attr	= {
 		.name	= "eeprom",
 	},

-- 
2.45.2


