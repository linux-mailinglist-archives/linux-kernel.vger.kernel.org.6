Return-Path: <linux-kernel+bounces-246351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FB92C0C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A704288FC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E401D17B05E;
	Tue,  9 Jul 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLb4GTlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380217B048;
	Tue,  9 Jul 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542278; cv=none; b=KhAA5qXJLiHV9YDF0b1jp7BC85Ab5V+S3SfLmGR+fgE1PxbDbHk7Thnzi9P7eTl1CqZb1GvI9Fs/Ya8HplzJq/gcS81f6F8Emw6hHa7UU8LupSATtm9AwcX9IsqZsMBM6w5tK4Lg1xCphyCx7D4QDBxsSgTxJ9Ek/ujrAXraBPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542278; c=relaxed/simple;
	bh=6zXCNEk/FfVcSweKDebwNIp8i4GHsMOkSLcu7DY0MfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETTBKNzP9XT1k1cn6Y2Pa4LTVXu8TcWnTV7dlPFTOdhhVD+INTItZb88zNtMn+dIgwsVfESeG4QRYEpH/vwghTZf2ih2G3LuBYmoPN64YhRMMqTzGpg2+TKbeeiYH3YBF+NZjOynyDKtLulPj32vf93k8jTnasGIkQXLo6lDsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLb4GTlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1726EC3277B;
	Tue,  9 Jul 2024 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542278;
	bh=6zXCNEk/FfVcSweKDebwNIp8i4GHsMOkSLcu7DY0MfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLb4GTlYsMWKQEpSf6KXcNcmYy4lFqzo+l0z3ssPExRzq9v2TY4GXowqVKFFv0Mdl
	 QmAXOvlZ/6TC12bNVXhWDiD3iOwaZMP57ATa6OTwmITaFwImXh6MaU25FNA6QcuB9x
	 b8019RTqbFFT78NjtK9RA2UgkJK3F+mMdF/CoLMkiFCR5R/1/suNvlwThPSVNpyWT9
	 s4Ww0ba4U4hqFyt20Bi/QizZ79irWIXBnHF+42jjdymioBrroVHtgTkWec+9uST/G1
	 W2g6rEpKmX1eW8k0Xs7rTu3/EMPlOPrq6TIuHsHEbja3EAAFinov0qFc92bwZ6G+My
	 Uzhc0DdEj3p1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Agathe Boutmy <agathe@boutmy.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	matan@svgalib.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/27] platform/x86: lg-laptop: Change ACPI device id
Date: Tue,  9 Jul 2024 12:23:32 -0400
Message-ID: <20240709162401.31946-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 58a54f27a0dac81f7fd3514be01012635219a53c ]

The LGEX0815 ACPI device id is used for handling hotkey events, but
this functionality is already handled by the wireless-hotkey driver.

The LGEX0820 ACPI device id however is used to manage various
platform features using the WMAB/WMBB ACPI methods. Use this ACPI
device id to avoid blocking the wireless-hotkey driver from probing.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240606233540.9774-4-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lg-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index aa063c3c935b5..40051b043c422 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -770,7 +770,7 @@ static int acpi_remove(struct acpi_device *device)
 }
 
 static const struct acpi_device_id device_ids[] = {
-	{"LGEX0815", 0},
+	{"LGEX0820", 0},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
-- 
2.43.0


