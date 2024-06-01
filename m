Return-Path: <linux-kernel+bounces-197863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888438D7028
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BDA28377A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3E152181;
	Sat,  1 Jun 2024 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GketFNtX"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD9DDB8;
	Sat,  1 Jun 2024 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247786; cv=none; b=Imq4Xt90118QytTcLrsUTPR0yZimSXKPVlSvohet5yblX48hWomLozxR+otehPHrwhyb/W6s1enEPXr0BRocI1HrmmWa0ylZwfJm0yE1YXbVPo4lxGgp50GzgORVSfVcjdc6VB+KrSEQ8LyXBaAl5dmgRcgdGJBTJIRWiUJZpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247786; c=relaxed/simple;
	bh=GcZoulpfNKwRDYAmVIZeAXOPBhs+++k+Rmiq/aZbe14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDfyZvCZr9SbYJXHcO7pmc8q6XIwTTswD8dziKV/HWHUcGNFnNGPqzP+Qdv+0QkEtIkJv5nXi6ssiF51hPXdFB2UpegYYHeQOrzDKi1u08d52rtQDnT7j3sJttSZEl5CNPLkaCven5033iPTjDVu7fvvL59LjOdR9KNviXl8H4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GketFNtX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Xua/3eiXF3woSwR7tG90GsoW9bS2vNPBoTss/RlnlLA=; b=GketFNtXvmzI2wEc
	NUQYf3OTU+/6pZ8WHUeKgqy1IWww5DPPHQF2KmOrAYgobG5tL0HYD6fhGbWD93QsDvowt6AUH9I5y
	4PSxVMdfggXaKiYU/sWLck+d0duQapnRrtwiyosIu7+XnQ8JFX+8lffEMc6C+h4hZLk/cHyCkit9X
	8JpRU4mi2oIFwrjF1iBkMxiwr9YRRG5h4JG+D0IdQn5wI0fcR+NAqZg2dHfFQ/7yoMp7uUhTfHxwF
	PJVCPB7+gd+9D6Im7EgMw68g9c288FYct+tbaM8Cr354qrmGnwbd/sX5k+q9re6v0JAK7Py3tLyUX
	rgOyX5zYVKAoOJsK0w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDOak-003jMk-0S;
	Sat, 01 Jun 2024 13:16:14 +0000
From: linux@treblig.org
To: philipp.g.hortmann@gmail.com,
	Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] staging: r8712u: remove unused struct 'zero_bulkout_context'
Date: Sat,  1 Jun 2024 14:16:11 +0100
Message-ID: <20240601131611.52441-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Remove struct zero_bulkout_context as it is unused.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
V1 -> V2: Reword as per review
  
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


