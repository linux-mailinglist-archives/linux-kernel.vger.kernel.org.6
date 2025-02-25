Return-Path: <linux-kernel+bounces-531343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7894A43F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146577ACE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24605267B11;
	Tue, 25 Feb 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlcPOlQ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297419C54F;
	Tue, 25 Feb 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486310; cv=none; b=k2y7DGlV3oG7mfipkxDNC4pl7vf42NRNftSwYt7mxTKZqNsJnCs+4VzHBf71EytJzI0pCH1koRzdh/THyF/BB9PhBIzHTzzj2x8DF9mNA230AMm0BuMCZ7sIabuLrGuExW/azhLA45i2BOMgmvJkmz6rn3zF9s39jhlLiOcMt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486310; c=relaxed/simple;
	bh=kbpcK4FCsjeS4/yzXpTsCA1vCB3JiRQU+VHatU2MrvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QrHQBDVsbhck4WOQPmOuB9zKDgPUkUSzQSkh/aSMGAw3KX9AT+/P0dKABYhIk2WQKbyKkXCXepB6gv7BKdyG7RB+jTEnZdQR83CzEQQOD14cAgdmhKW0mvzoFFcSKladlx0wxRotn/rP427GHTWSIhIA3rBdyO/0PuCUxZ75vzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlcPOlQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B6EC4CEDD;
	Tue, 25 Feb 2025 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740486310;
	bh=kbpcK4FCsjeS4/yzXpTsCA1vCB3JiRQU+VHatU2MrvA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SlcPOlQ17nYFY2gOmAoNSmkOWb+2KLw4oUPVVDIDyOT3vb3bEYCcVnbp2MDPlADAA
	 BOF1Ar5OX1dKIf5I2zXTnFbvPnLuwwChRj4z/XEyE0RnR4AXJg30fVyA+bKavcRuL5
	 BQCqw5T7RKowFziFSMSAmPx6lZ+ErmpS9C69lR0ejSXDOzQhM7Rp3NgZKC7L825g3D
	 6oIHXt7HZlQzCQp+joddJ0eVBzsX4O6IaujNEU1odNYEPth90806aOT9LKdyAxSIaq
	 VStvsNaua657fD6uOCechvFUFipfHN04dFonyjikGPd7eWI9ZSLzK3Z7yLFWJZYpJP
	 oan47uf0pC73Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33DFC021B2;
	Tue, 25 Feb 2025 12:25:09 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 25 Feb 2025 13:25:03 +0100
Subject: [PATCH] usb: storage: jumpshot: Use const for constant arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-misc-const-v1-1-121ff3b86437@posteo.net>
X-B4-Tracking: v=1; b=H4sIAJ+2vWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwND3dzM4mTd5Py84hLdVPMkk+Q0I4MU0zRLJaCGgqLUtMwKsGHRsbW
 1AOPiNc9cAAAA
X-Change-ID: 20240401-misc-const-e7b4cf20d5f9
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740486309; l=1810;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=8rz6vHhtFj67IR1PYVzJt/W+sDgjep7yfy8XQRNUyVM=;
 b=xcrvT+n6wVQZdgOquo/5oCozE3BNKpweD3XshACH5KiYMKRKGFNmqrlpzJa9go/5yaUOv/1m6
 J215lkf+nznAm3bUW8JpZvqPnlnHgmQGXmbgm/03EEUBACJssgxzOWh
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

These arrays are not modified. Make them const.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

This change was compile-tested with ARCH=powerpc
---
 drivers/usb/storage/jumpshot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/storage/jumpshot.c b/drivers/usb/storage/jumpshot.c
index 39ca84d6859122903de4e64b13e697e8b7d4ab31..089c6f8ac85fbb683cca8b03a2ff06c0ca776167 100644
--- a/drivers/usb/storage/jumpshot.c
+++ b/drivers/usb/storage/jumpshot.c
@@ -367,16 +367,16 @@ static int jumpshot_handle_mode_sense(struct us_data *us,
 				      struct scsi_cmnd * srb, 
 				      int sense_6)
 {
-	static unsigned char rw_err_page[12] = {
+	static const unsigned char rw_err_page[12] = {
 		0x1, 0xA, 0x21, 1, 0, 0, 0, 0, 1, 0, 0, 0
 	};
-	static unsigned char cache_page[12] = {
+	static const unsigned char cache_page[12] = {
 		0x8, 0xA, 0x1, 0, 0, 0, 0, 0, 0, 0, 0, 0
 	};
-	static unsigned char rbac_page[12] = {
+	static const unsigned char rbac_page[12] = {
 		0x1B, 0xA, 0, 0x81, 0, 0, 0, 0, 0, 0, 0, 0
 	};
-	static unsigned char timer_page[8] = {
+	static const unsigned char timer_page[8] = {
 		0x1C, 0x6, 0, 0, 0, 0
 	};
 	unsigned char pc, page_code;
@@ -477,7 +477,7 @@ static int jumpshot_transport(struct scsi_cmnd *srb, struct us_data *us)
 	int rc;
 	unsigned long block, blocks;
 	unsigned char *ptr = us->iobuf;
-	static unsigned char inquiry_response[8] = {
+	static const unsigned char inquiry_response[8] = {
 		0x00, 0x80, 0x00, 0x01, 0x1F, 0x00, 0x00, 0x00
 	};
 

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20240401-misc-const-e7b4cf20d5f9

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



