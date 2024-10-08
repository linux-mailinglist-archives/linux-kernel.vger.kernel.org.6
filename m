Return-Path: <linux-kernel+bounces-356318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722EE995F86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300C028531A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994D16BE20;
	Wed,  9 Oct 2024 06:13:54 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E284736D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454434; cv=none; b=fERY7PLaldMiP50BWWQY5ijMkeTTfYodrIYqxEsYmKcDRLw+IyAAFnKBUdkHDBcG5GZTAeDAcrX/PUyh563ahD8vYyLRRNyarXR5enkyXTZSIJ60fP3iLY9G4vR9JelxK1986STFkQ156xG1WIydljMrkRbRxaqf/U1fxF6GU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454434; c=relaxed/simple;
	bh=8uX7coThDMx+v6d/K4EqGqvh2dB7LoVg1MFCQaOjfII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAj3fBh104cIklAUR1k6DbOLFlnKoTMwxZerMnJGn94oDAp7vXIrsR29Uf5KIfM6t2CdpXU1cTSGz+L3/TfLElGUzvGfDgg7xlB/SyvCo/jImVn/Fx4Z4Af2yG9/m2qvtFlWlCrlDpHF1J//64iTjtcNOpQG5Vg3xUcRVh5rXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee967061f1431e-f032b;
	Wed, 09 Oct 2024 14:13:41 +0800 (CST)
X-RM-TRANSID:2ee967061f1431e-f032b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee767061f04bae-d9472;
	Wed, 09 Oct 2024 14:13:41 +0800 (CST)
X-RM-TRANSID:2ee767061f04bae-d9472
From: Ba Jing <bajing@cmss.chinamobile.com>
To: linux@dominikbrodowski.net
Cc: bajing@cmss.chinamobile.com,
	quic_jjohnson@quicinc.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: i82365: remove unused macro
Date: Tue,  8 Oct 2024 17:40:27 +0800
Message-Id: <20241008094027.39377-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found the macro IS_UNKNOWN is
never referenced in the code. Just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/pcmcia/i82365.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index 86a357837a7b..3b045cd87107 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -183,7 +183,6 @@ enum pcic_id {
 #define IS_VADEM	0x0001
 #define IS_CIRRUS	0x0002
 #define IS_VIA		0x0010
-#define IS_UNKNOWN	0x0400
 #define IS_VG_PWR	0x0800
 #define IS_DF_PWR	0x1000
 #define IS_REGISTERED	0x2000
-- 
2.33.0




