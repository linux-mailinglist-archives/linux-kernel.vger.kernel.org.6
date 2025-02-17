Return-Path: <linux-kernel+bounces-517120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4DCA37C60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16963162080
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F69198A36;
	Mon, 17 Feb 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34ofnFwJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSAYgVR5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6F19048F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777925; cv=none; b=idCIXoI7r8kJXsYkaCkrWr95h5NO6/7X7sVDtrGcYppds45J0J2xhliZXyVtWuoEzu8GLvCte/HicAkaZHRUUlZ7mLEi6GYsYSjkQHzc72RCVemJR8hmYaW4pzT9zXcdmZQilKl28fga7U6zA0omk/xLGrXn9k8WMtMV+PGJLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777925; c=relaxed/simple;
	bh=DzCmSKwn2Q7/+q1uLCVQqEVP2Z5fvNZrI1/dmAalTWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kJIwcCI3fThy0mHPX1dm28G86GzAn9JRQ7mV+TcA4qfqIoSjO8kX0w+jl0FU2QneZmEKqIALLG6qpJLN0lDg8FQJsmFVpwq5Bk9pdaPWb9iwFEMFzJE9P378kff6hVUsCLaB3EEDY+Jf1WGPk0kf30uq2Hc+TTsLt8IwNLM33tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34ofnFwJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSAYgVR5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739777921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9mlA1/guLuh60WCK2DaO4DFUk7OzFKB8ZoIzCPZt1mY=;
	b=34ofnFwJEtJouMlmHF/ZUBiNwYQonokDI5vQpMrQM3qDz67jnqeJkccZcW6beWTPUZ2ue5
	Bq5MCDR2bOnu9jRb4qJQNMp2y3+BYTQZuG5QL/99UV2UqBSfCvqORA5N4shU44WfB2m4cm
	EC22fQvSAZwpjDdI8SpI4GXkjancGrc6fhusWp4mCEujwQjRaDVjGsuPYUVcuqOMfyZ1Mo
	40oItNWQFLMpXi4+aSS+9ZtrBrsZvabMvc+sqwP2RM8rvTqUvfSMdCYTFD5AIaMtKuXmmV
	ZB7YvxCH6MQMOUnX18S8vEwLrqxJ1WcaLSD/S9+T0jEWtv9AO9rC2e9+0BqBGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739777921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9mlA1/guLuh60WCK2DaO4DFUk7OzFKB8ZoIzCPZt1mY=;
	b=HSAYgVR5LjY0wopQ0uT/pTTiyDNoGSLVbxLXLr8zMLUWUqj6wC7uRwyO4kYaGXEoCij2W8
	IC6LhJ4fdiAZ1UDA==
Date: Mon, 17 Feb 2025 08:38:37 +0100
Subject: [PATCH] ARM: mm: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-restricted-pointers-arm-v1-1-aaa0fb22e18c@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHznsmcC/x3MMQqAMAxA0atIZgNtVUSvIg61Rs1glaSIIN7d4
 viG/x9QEiaFvnhA6GLlI2bYsoCw+bgS8pwNzrjGONuikCbhkGjG8+CYSBS97Gjauqsma4NZAuT
 6FFr4/s/D+L4fTLOUwmkAAAA=
X-Change-ID: 20250217-restricted-pointers-arm-07493b11c0fc
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739777921; l=1214;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DzCmSKwn2Q7/+q1uLCVQqEVP2Z5fvNZrI1/dmAalTWs=;
 b=200qmgczWGefMX2ALuAf/85dinyilfNwPpX2sxD3XwPMd2kkWZiDqLpEYjJlwj4Qi4xhvljNT
 oFgGutxHif9Cda1CoQXuqQSHMJtVnbE8ch4HqSEFCXeTgBz4FySfAzP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/mm/physaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/physaddr.c b/arch/arm/mm/physaddr.c
index 3f263c840ebc462e13c34d33be0161e7a473173d..1176c75ebf74f9b948041d3356c411e0693d7873 100644
--- a/arch/arm/mm/physaddr.c
+++ b/arch/arm/mm/physaddr.c
@@ -38,7 +38,7 @@ static inline bool __virt_addr_valid(unsigned long x)
 phys_addr_t __virt_to_phys(unsigned long x)
 {
 	WARN(!__virt_addr_valid(x),
-	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
+	     "virt_to_phys used for non-linear address: %p (%pS)\n",
 	     (void *)x, (void *)x);
 
 	return __virt_to_phys_nodebug(x);

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-restricted-pointers-arm-07493b11c0fc

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


