Return-Path: <linux-kernel+bounces-318686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D896F1A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6461F233C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947361C9ECE;
	Fri,  6 Sep 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="G6x/byVg"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5831C9EC1;
	Fri,  6 Sep 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619092; cv=pass; b=qMMsQKH7JKCzjFIjCtHchxPMCU+dPI5GXskn0/soujSrA67fkCOeFBw9smMelmhanWQhBEPcbJII1NSkHcS4AOHihIK1DINkbnNAVS8TOFccgRSJv+9NAW+8moO9GNueYLjV2CLvlaBLkQKVj6vE/qQW9EU0RXSrR/5WJvkDSVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619092; c=relaxed/simple;
	bh=S5GeQ2PX64HKmYqJxWN562B3NUdKkEmZivnovPV5oS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tu2dpWOmPFQKEr6m1y7iDuQORIC55OT503Q8KNE64TAcZY8zfCQEi8vK/QyOMosLxDUcjkdIQol5Jr0+XEDIuTYqIOmq0swFpIcPDzlzyB/9gAHoAqDjyq3FJ7lwd1kMDzXaqLxwxd/DLQmBHgSBDTM++Hz8SRqxfpnpbq9hM2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=G6x/byVg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725619072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j7kL7hTxwYWgV809uPCeUug65QSA2izxVhypOB4bA6zSAGEtkywqaiK+998+BrvsUXNqdRQj/h2B0eeeUKRdgvMgceqeDb0Oz82B8q5/kDB1J17I3y86pj929q+l/s8ShFRWH6I8jamzdtBVLwO8m5C4mWhmwCEpTskrgGHVPao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725619072; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dji0WrDUX2YOKzFvOkOb3cVSwywumU9GEEbmJmUTJuI=; 
	b=j+QBZFkkyPabDB5axQ3mReO1+rifmwph+2KauiTuLn7eP56wLQFJDYU/Lq+s1V70PXtb9RNtAD60a5HsAI9hTcjPkYY/S6tBem/ZBfFWjokshAuzPgy85T1AZS6BmX1c5k6db5inUHVZe5BeDs4uUBTlUbwvMGOoJLKxOuBla20=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725619072;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=dji0WrDUX2YOKzFvOkOb3cVSwywumU9GEEbmJmUTJuI=;
	b=G6x/byVgXowohDSlIYd2cZspWzhVZ2rhiammIELvyVwZyEhwn20PRqw3oI3JGX73
	GLeniHl6wtlQn18j6zm6OLxDTbsQY9rLqElG92Q5lU2Xxnkt1tXZe5cgyYYWYmVMWGB
	vo1TFcaDN/0c7/6YzYsQxhmoYJZVn8Fu9dFp9vjI=
Received: by mx.zohomail.com with SMTPS id 1725619071634303.6658924086322;
	Fri, 6 Sep 2024 03:37:51 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: acp: Return in-case of error
Date: Fri,  6 Sep 2024 15:37:24 +0500
Message-Id: <20240906103727.222749-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Return when error occurs instead of proceeding to for loop which will
use val uninitialized.

Fixes: f6f7d25b1103 ("ASoC: amd: acp: Add pte configuration for ACP7.0 platform")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
The fix may be wrong. Please consider this patch as report and fix it.
---
 sound/soc/amd/acp/acp-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index ae63b2e693ab5..3a7a467b70633 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -231,7 +231,7 @@ void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int s
 			break;
 		default:
 			dev_err(adata->dev, "Invalid dai id %x\n", stream->dai_id);
-			break;
+			return;
 		}
 		break;
 	default:
-- 
2.39.2


