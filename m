Return-Path: <linux-kernel+bounces-194789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03278D421C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B49F285DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961711CB333;
	Wed, 29 May 2024 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZWyv8Pqk"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C0161307;
	Wed, 29 May 2024 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717026458; cv=none; b=QRdA4AqHj+C7FatHm6Mjlwatf+oXt9+OdFtjA/MDF0aR1a+Zkrg4Ne3hnHcBIJ/qownOB0+RsZNGZJ7lts8fvOe5jKYhfqovME2XAhAwDD7VIA7kzXg3R53Bw7yuS+AumRyHa+WXgKjAJpXriIpqQCxl6dgDWiAgzxfBGvXa5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717026458; c=relaxed/simple;
	bh=unE9cQM2ykKko8yDjn4/0lYmGVxN9SA3OFTB+8xandc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYlTaIFpkMbmk6gC4RxtQuckjqwLNnoZCBIQWpXMBCLZ21PrzQ1wBw+422h6zIfWtY6jQaazFIhCM0gzPvOL8m/J0B3+UeAfKrGT94Vhr9PcSiqyTk+X7BosRceh+YM+1C/duQoLVJGLKFjBkmVd7oI5qpWU9e48V9dt6Grz3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZWyv8Pqk; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=fJLI85pjJZ+aBSyfh46qnH+tG9YwMLBD7JtgxKsZ4gE=; b=ZWyv8PqkOzMZEHs4
	qCR+mBDVPsiG+nJb127/WRB2xZojTx3UpIT/wz3Yg7F/igjz8EZHMbBj1XYqryunIQa1IytQ97CuR
	l2llImpIVihmT6DqPDwM3Kw186Rabvl3nIqykiQUmkCxSciUt14608bGEFPKWtRfp0HPBv975J/Oo
	mxJLP2+Zb5VCtlHjwwRLeAAZrqb0rSnVXF92e9pjT3I/yrEYCckK7xkpXebkH9JTAg9OVhcm9cIO3
	/fEaeMXDtYoFCaZdbs44Uv00bDHyrCcFf9sLY2KbAC3baM4U0Lkut55VxzX5+bJ3wD0i2m8tGZyMJ
	LVgCkoWCdyYHGgKtwQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCT0x-003HKk-1y;
	Wed, 29 May 2024 23:47:28 +0000
From: linux@treblig.org
To: johan@kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] USB: serial: spcp8x5: remove unused struct 'spcp8x5_usb_ctrl_arg'
Date: Thu, 30 May 2024 00:47:22 +0100
Message-ID: <20240529234722.130609-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'spcp8x5_usb_ctrl_arg' has been unused since the original
commit 619a6f1d1423 ("USB: add usb-serial spcp8x5 driver").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/usb/serial/spcp8x5.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index 09a972a838ee..6b294bf8bc43 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -49,16 +49,6 @@ static const struct usb_device_id id_table[] = {
 };
 MODULE_DEVICE_TABLE(usb, id_table);
 
-struct spcp8x5_usb_ctrl_arg {
-	u8	type;
-	u8	cmd;
-	u8	cmd_type;
-	u16	value;
-	u16	index;
-	u16	length;
-};
-
-
 /* spcp8x5 spec register define */
 #define MCR_CONTROL_LINE_RTS		0x02
 #define MCR_CONTROL_LINE_DTR		0x01
-- 
2.45.1


