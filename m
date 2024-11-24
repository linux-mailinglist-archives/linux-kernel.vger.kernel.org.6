Return-Path: <linux-kernel+bounces-419757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9B9D7219
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D451A16354A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CEF1EF0A2;
	Sun, 24 Nov 2024 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6qbguNw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A61EF08C;
	Sun, 24 Nov 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455527; cv=none; b=QtQrqXRVNRw6u1chAcwFrSgbXUe5Zm8COSssQOBa7DCasN+dqcY/q32M6Bt9jWmMt9L/i+eB6JLvnKYJVeXtbC/HUZZww+l/YbBe0Cpt9bNcAxQONEmB7GXHCUEciDBPjh41V8gFFyEbKIm3aXrd61svg/xvPrxNXnKnaYwQtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455527; c=relaxed/simple;
	bh=VMeLgd7sPJvA6U7kFTj0pjXhVHyGZj300QfIcdTWspg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI40N/5JeRiTY2sPN5yvNHeEsjs59qir2X0ahl/cTnxPCJrfJfalhH3iXLcDHkr+NgRwwpYtOgDPmWKaGVxHoVPofY+v+0St/tvE9FUK5t7xRHXNBHPS0p2iDm73y1CvFtGU3Z9wCLsJYcuzOPlA7MbZE9w5t41WtziS01XKokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6qbguNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1933C4CED1;
	Sun, 24 Nov 2024 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455526;
	bh=VMeLgd7sPJvA6U7kFTj0pjXhVHyGZj300QfIcdTWspg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6qbguNwYgA3a59STYXGkexyYeYWbJDZXqJpyoI8XaIln7w9ViblR61k6OSBkkKqX
	 ZruH16FhW5HKjseZ99JSFkupEOSu6uxfZtLF96pOUzj5oHA44JBFJ9ml5AlFaR6y4E
	 NPnkCj+C5+Bb7nkuKubuZybXMKeG+P0As+X7DRCjyrL6OP/v0SSzP6EdpV2mlr7CMl
	 drEmg0PcsjKbteIvOf3VZLUbiHeWjGDuvaKtsV/3i1OP1+9WIeyaf9vwvg/NIs6F/1
	 oxHUa4AJOK40L/1FnPTi60W88jT2GSQtP38tHfJe2pjN7OToJw3MtYVB/AgFz5zI2x
	 RzEw6kThzLsOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Danil Pylaev <danstiv404@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 100/107] Bluetooth: Set quirks for ATS2851
Date: Sun, 24 Nov 2024 08:30:00 -0500
Message-ID: <20241124133301.3341829-100-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Danil Pylaev <danstiv404@gmail.com>

[ Upstream commit 677a55ba11a82c2835550a82324cec5fcb2f9e2d ]

This adds quirks for broken ats2851 features.

Signed-off-by: Danil Pylaev <danstiv404@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 343f535a81789..e1e8166c67307 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3910,6 +3910,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT, &hdev->quirks);
 	}
 
 	if (!reset)
-- 
2.43.0


