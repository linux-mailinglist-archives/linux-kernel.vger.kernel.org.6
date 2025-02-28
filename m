Return-Path: <linux-kernel+bounces-537717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFBCA48FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857361893406
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91A01BBBDD;
	Fri, 28 Feb 2025 03:34:42 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970D1A8409;
	Fri, 28 Feb 2025 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713682; cv=none; b=YkBJYdymByyT6T3QnZy2GQ5EiNF+QRWaEGauEiaqohwUUk+8X0ikVz7HNi5sSRtzuNjDln5dAp/b3jVr2oxKuLWaShXtWMf8QhvZueND2IBL9gOc9uvnDkBHVHNqBSKzFgAHFW9pKhBSM53nAR5Bn7a/QyyEkEn+uPK3aPBUa8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713682; c=relaxed/simple;
	bh=sZuew6/qnh9yp1NKKxOuD9FyuFysq44fEgAQWmRiQjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ks2gZnpRxyXvHkx80jtPa5mfedDY6N8AM0KlxFryMWfkzbgTibAAlZxmptCtMoy2UgcDmESCS/MidMybVD4Np78PBcfmjSSnrksN+hNwIc2dZr0vYLXibAxkAq7ptvXa6FbR5mMd57VavzzZeDqtgdnc6oQm4f9gFL10nfDqqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201622.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202502281134312562;
        Fri, 28 Feb 2025 11:34:31 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Feb 2025 11:34:30 +0800
Received: from locahost.localdomain (10.94.9.231) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Feb 2025 11:34:30 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <perex@perex.cz>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH v2] ALSA: seq: seq_oss_event: fix inconsistent indenting warning in note_on_event()
Date: Fri, 28 Feb 2025 11:34:27 +0800
Message-ID: <20250228033427.7056-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227092441.19044-1-hanchunchao@inspur.com>
References: <20250227092441.19044-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 20252281134315347d902aec45dbc892b8b30f4291622
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
sound/core/seq/oss/seq_oss_event.c:297 note_on_event() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 sound/core/seq/oss/seq_oss_event.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_event.c b/sound/core/seq/oss/seq_oss_event.c
index 7b7c925dd3aa..76fb81077eef 100644
--- a/sound/core/seq/oss/seq_oss_event.c
+++ b/sound/core/seq/oss/seq_oss_event.c
@@ -290,16 +290,14 @@ note_on_event(struct seq_oss_devinfo *dp, int dev, int ch, int note, int vel, st
 		if (note == 255 && info->ch[ch].note >= 0) {
 			/* volume control */
 			int type;
-			//if (! vel)
-				/* set volume to zero -- note off */
-			//	type = SNDRV_SEQ_EVENT_NOTEOFF;
-			//else
-				if (info->ch[ch].vel)
+
+			if (info->ch[ch].vel)
 				/* sample already started -- volume change */
 				type = SNDRV_SEQ_EVENT_KEYPRESS;
 			else
 				/* sample not started -- start now */
 				type = SNDRV_SEQ_EVENT_NOTEON;
+
 			info->ch[ch].vel = vel;
 			return set_note_event(dp, dev, type, ch, info->ch[ch].note, vel, ev);
 		} else if (note >= 128)
-- 
2.43.0


