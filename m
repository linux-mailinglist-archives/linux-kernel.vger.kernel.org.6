Return-Path: <linux-kernel+bounces-321062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E39713F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FD328101F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF01B29D3;
	Mon,  9 Sep 2024 09:38:11 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF401B14F4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874691; cv=none; b=sG/ajbUju1n8LIRNe8PqJpp7Cjs56WyWNocfRELcAhSesAjg3raiofKRGJr/oZHptA4KwJQlCF9Z8SbhMiCjQm9nj27v4lD6i3EyvXcxm3ZPQBbHVStzD9Gsx4eJpGZUDkjIztiaIL2UOsLrZUm8LUEFDD0ftUw2zP8FDRQYpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874691; c=relaxed/simple;
	bh=jSBEnBJKptfzTjkmTy2SUr0l7D90UJd8TMxOxJxwszQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GCie75pvDreKwd2y/BXe2Utr3K21MQHYURmpW07egYA9xCn/Dw37U6oY+MB7h8TgzxkvylHJw5Wln+jCHoYFs0nk85T5kDjtq420V2tzKN//+XnhKsctn4XYsYufzzxQ/gz4DxHLBWVNJbJ5NepI2vUfE2uBWBJn+FyTeg0UeEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566dec1fb687-0b68a;
	Mon, 09 Sep 2024 17:38:04 +0800 (CST)
X-RM-TRANSID:2ee566dec1fb687-0b68a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466dec1ef32a-4740d;
	Mon, 09 Sep 2024 17:38:03 +0800 (CST)
X-RM-TRANSID:2ee466dec1ef32a-4740d
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: warthog9@eaglescrag.net,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] ktest: remove redundant declarations
Date: Mon,  2 Sep 2024 20:57:12 +0800
Message-Id: <20240902125712.5814-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since $loops is not used in the subsequent code, its declaration should be removed.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/ktest/ktest.pl | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index dacad94e2be4..8fcd9c5115f1 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2169,7 +2169,6 @@ sub monitor {
     my $bug = 0;
     my $bug_ignored = 0;
     my $skip_call_trace = 0;
-    my $loops;
 
     my $start_time = time;
 
-- 
2.33.0




