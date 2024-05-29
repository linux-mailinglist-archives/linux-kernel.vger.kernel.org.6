Return-Path: <linux-kernel+bounces-193254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5A8D2947
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEDC285826
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3036ECF;
	Wed, 29 May 2024 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="q0Su6Fku"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DE632;
	Wed, 29 May 2024 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941302; cv=none; b=F/l/vJAu7dZ5+VppVzHFCTdO354U6t2c2YCqa9erXjDPYSvHXIqGI+Fv8ZVtrjjL/egzeB/odQ4bPm1iKV6rq1PSdJtMWP4jTI+KiP3WV2H9wj/GKLNELsqhe0XEEES9nTKnG8UVRcnXlNwxUoVIUuGH5K8PBWsF1RptdebyA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941302; c=relaxed/simple;
	bh=gClIS7E7KZuGoZIdhNwR45IZraf6pB0wAT18WK2EMjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZ9u0CAwQnI0yxnw67MAQvRhD3srqOFrDftoO1P+MZ0frV48fuLGNALiZL3b0RmAKYmWQvwOLtFxHIUinuZdrLZvQLNYEUnC9DGq2vIjwG+gEMrPJGn64NEEwFHGNzgLYw45TQvrYL6iBP5V7Xv3dO1T6azQcFvpNLpskv9dKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=q0Su6Fku; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=opTWn1LdwdeEO+hSttdwuC2IlX6SoRmn1eLVulq3Iy8=; b=q0Su6FkuyZDQUrxy
	At1oY/P24loI7WbRIprYyLi3DkFrjBVF8E6tM6K35FkgYQCeky7jSDEPg37H98OSd7mADsFOA/HYb
	XToj+afOlkxTtNG8yOSP4tvt4z9yQ7kE0S6UgkX9IrKxAPuKyl7aKv7g7LfgJfUUQu6FMZneyYcYx
	lauls2yctHma0gbYfxuv4mNhimLpiE4gOFMHJXfM4cciY1ZKOLSctKpwtFIkh9YhPYi9qc7QTAxlz
	kNVldnTvgdfnLoFPyBbIMkTyXeJ/YpBpkahZCwiPe0alhoG43GmbnrF3o+2f9xzDBHHK7NLFQ0Xp8
	L5kG5Q6lV7nL1lweIQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sC6rX-0034Kk-1Z;
	Wed, 29 May 2024 00:08:16 +0000
From: linux@treblig.org
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] staging: r8712u: remove unused struct 'zero_bulkout_context'
Date: Wed, 29 May 2024 01:08:14 +0100
Message-ID: <20240529000814.233690-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'zero_bulkout_context' is unused since the original
commit 2865d42c78a9 ("staging: r8712u: Add the new driver to the
mainline kernel").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/staging/rtl8712/usb_ops_linux.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index b2181e1e2d38..0a3451cdc8a1 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -26,13 +26,6 @@
 #define	RTL871X_VENQT_READ	0xc0
 #define	RTL871X_VENQT_WRITE	0x40
 
-struct zero_bulkout_context {
-	void *pbuf;
-	void *purb;
-	void *pirp;
-	void *padapter;
-};
-
 uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv)
 {
 	pintfpriv->piorw_urb = usb_alloc_urb(0, GFP_ATOMIC);
-- 
2.45.1


