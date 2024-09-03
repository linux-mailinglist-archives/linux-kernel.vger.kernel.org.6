Return-Path: <linux-kernel+bounces-313012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CFD969F02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A0B1F250FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954B1C2423;
	Tue,  3 Sep 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diekuehnen.com header.i=@diekuehnen.com header.b="yp1r/26l"
Received: from mail.diekuehnen.com (mail.diekuehnen.com [78.47.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054D1A726A;
	Tue,  3 Sep 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.205.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370078; cv=none; b=P54XtiVPgMXbnqmVgdQj5L2odlnNFSszgLhwsYkrbRxQvp0jt8J9ZJ3nORvPwl/JJ72iq+jQOjLVe+586zSHViUTDRnBB3ZoPRQ1FJg2hqykxXDgUvOamk6/o46IL2OqwDjzhnRT3crHoeaINU0MmbvVqNMvZB2Jxl7ENlRKnEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370078; c=relaxed/simple;
	bh=CLQG+IdwZ22SMXaJSPeFr07Fb9OMYcb0Y4GqWfh/YmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I18QGyS7OZ3oDNq+ernLCvgo462pocg5Yc/ZycFoL5drpwdjGqZIfqCRMdAYG9WK0Hhl/WUhXizR3cZD56ZRdeRr3GkPXd5sNCmRMPLhNm628xvAMMUmF74HkI661UwAOUp0NcY9nKV2iyXKT5z/AkLQRx65D9PKMh7WT5w9vw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diekuehnen.com; spf=pass smtp.mailfrom=diekuehnen.com; dkim=pass (2048-bit key) header.d=diekuehnen.com header.i=@diekuehnen.com header.b=yp1r/26l; arc=none smtp.client-ip=78.47.205.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diekuehnen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diekuehnen.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD2EE7E70D;
	Tue,  3 Sep 2024 15:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=diekuehnen.com;
	s=dkim; t=1725370068;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=HV2hf1nSATsA3NNJxSWkfgMwLvWvQ3pMvRpwUZxKkXc=;
	b=yp1r/26lNKqk7dD7+0Bh9E7ZrMQKfgz+bGiBEeBdChNJ567eFsyqrGZq1VTcMhFk4hoGwg
	ZpUBSD0nmRlaGKi+SSeQnVLwBY/d/7R7o67TUMm/KcJlLOT57Imw6g2tXihs+Hp397/Kin
	8WFCA/oHt1CBebwGnNIw9qBQrGMtBJFcYIkOwup+hDeWJa1aSCm+UrSuyB7hTI90ttxHLH
	XCsQsPFsXflPnWPHchXA2uTfQ4ET/WKP4Epez4sMkqNpuOqN1xRXCeJTp9m7TM0AGirIPq
	ouIESRkTIQtc2p6gpjXtn+51mF/8cssoG+wsiI2hOh8DVvcmh7WjR8j8T6KAHA==
From: =?UTF-8?q?Andreas=20K=C3=BChn?= <andreas.kuehn@diekuehnen.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	peter.chen@kernel.org,
	gregkh@linuxfoundation.org
Cc: =?UTF-8?q?Andreas=20K=C3=BChn?= <andreas.kuehn@diekuehnen.com>,
	openbmc@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: chipidea: npcm: Fix coding style with clarification of data type
Date: Tue,  3 Sep 2024 15:25:15 +0200
Message-ID: <20240903132535.15554-1-andreas.kuehn@diekuehnen.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Fixed coding style issue: unsigned to unsigned int.

Signed-off-by: Andreas Kühn <andreas.kuehn@diekuehnen.com>
---
 drivers/usb/chipidea/ci_hdrc_npcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_npcm.c b/drivers/usb/chipidea/ci_hdrc_npcm.c
index c89c68f41ccc..3e5e05dbda89 100644
--- a/drivers/usb/chipidea/ci_hdrc_npcm.c
+++ b/drivers/usb/chipidea/ci_hdrc_npcm.c
@@ -18,7 +18,7 @@ struct npcm_udc_data {
 	struct ci_hdrc_platform_data pdata;
 };
 
-static int npcm_udc_notify_event(struct ci_hdrc *ci, unsigned event)
+static int npcm_udc_notify_event(struct ci_hdrc *ci, unsigned int event)
 {
 	struct device *dev = ci->dev->parent;
 
-- 
2.43.0


