Return-Path: <linux-kernel+bounces-436692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC19E8976
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A0D1643FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BFB450EE;
	Mon,  9 Dec 2024 03:14:10 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4771EB3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733714050; cv=none; b=Grc5/MUTMYOzPAKs37iVt/MnvqjxqJ0PNvpA4nUVTHszLm4LMn7Z+PK56mqBIf7syKVE/Td/txlrNklCXXJXjftzluTBwTpGIiT35j+dVfBNbHWoSIen2+rulPVQ95bOI345XFvaYrq5ZENIWUJLkeak9a+zn5BNoeqL7lDS2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733714050; c=relaxed/simple;
	bh=QiNj9btLSB6aFxtzkuLOXfX0M3KRoHvxch7Ck/iDEeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sd8ZPxqxAdEVnQbC8VieG+u2oRd3PxbvGEFrMikoKWKJsn0C4vNrYLbb1t5M7rInPRYfVVaoJyfImS4FfjMe/Hwz7Ffg1BJuX/0QERm7Ggexm01DT8x7f68JUP8a/c3TgqHIM7206znt5ChjgNJWm9Y4B2SsQkvxaszGnccP6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee867565fc0da7-2adfa;
	Mon, 09 Dec 2024 11:10:58 +0800 (CST)
X-RM-TRANSID:2ee867565fc0da7-2adfa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee767565fc0d41-9d738;
	Mon, 09 Dec 2024 11:10:57 +0800 (CST)
X-RM-TRANSID:2ee767565fc0d41-9d738
From: liujing <liujing@cmss.chinamobile.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] dm raid: fix spelling errors in raid_ctr()
Date: Mon,  9 Dec 2024 11:10:55 +0800
Message-Id: <20241209031055.2806-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the respective spelling errors in raid_ctr() function.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 1e0d3b9b75d6..6adc55fd90d3 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3196,7 +3196,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		if (reshape_sectors || rs_is_raid1(rs)) {
 			/*
 			 * We can only prepare for a reshape here, because the
-			 * raid set needs to run to provide the repective reshape
+			 * raid set needs to run to provide the respective reshape
 			 * check functions via its MD personality instance.
 			 *
 			 * So do the reshape check after md_run() succeeded.
-- 
2.27.0




