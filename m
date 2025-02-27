Return-Path: <linux-kernel+bounces-535918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDBA47906
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821AA171539
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C78227E8D;
	Thu, 27 Feb 2025 09:26:03 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C37226D06;
	Thu, 27 Feb 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648363; cv=none; b=DkfuykqGhFbKopHuWomPzcqTGhR+6wb6AHeXYh6EHbVGZYQMMOfTyK4M0MSUvbLU9TtWpR9WkuHsX+/NmhIa0Ph0gtWFUzxkiv5ywGDgRbJ4JvUKAUOiO4TDPWuyhfH94JwUUKNrqvv1O5oTErrQf0IO+DV/NcvMVW6WkYlw6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648363; c=relaxed/simple;
	bh=51QJII6fUdiPIfCW79kJ4QsvgBBy1ihvI+vJ0EJXRJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EYGgAf3AZOYVStRiwlyQa8dSE0dE2HCN10fP06KHGegfwK0xV5lhbwCJsiZHgpyxfbIYVT4hmiFZekuk0SYsjFr6d2TxaTaUmwhRgCt6JILVW90FhZznBU6fcNXyyYHsp+QQBuhwhH+CzJtezhi7sDRX70f3c8CTTI8sBCG77Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502271724453794;
        Thu, 27 Feb 2025 17:24:45 +0800
Received: from locahost.localdomain (10.94.4.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 27 Feb 2025 17:24:44 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <perex@perex.cz>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] ALSA: seq: seq_oss_event: fix inconsistent indenting warning in note_on_event()
Date: Thu, 27 Feb 2025 17:24:41 +0800
Message-ID: <20250227092441.19044-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025227172445306a30912b55c7cedf2b913425d7437d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
sound/core/seq/oss/seq_oss_event.c:297 note_on_event() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 sound/core/seq/oss/seq_oss_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/oss/seq_oss_event.c b/sound/core/seq/oss/seq_oss_event.c
index 7b7c925dd3aa..9a42713c7bdd 100644
--- a/sound/core/seq/oss/seq_oss_event.c
+++ b/sound/core/seq/oss/seq_oss_event.c
@@ -294,7 +294,7 @@ note_on_event(struct seq_oss_devinfo *dp, int dev, int ch, int note, int vel, st
 				/* set volume to zero -- note off */
 			//	type = SNDRV_SEQ_EVENT_NOTEOFF;
 			//else
-				if (info->ch[ch].vel)
+			if (info->ch[ch].vel)
 				/* sample already started -- volume change */
 				type = SNDRV_SEQ_EVENT_KEYPRESS;
 			else
-- 
2.43.0


