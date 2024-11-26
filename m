Return-Path: <linux-kernel+bounces-422098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B4C9D94AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DFEB27FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131CF1BC07E;
	Tue, 26 Nov 2024 09:33:03 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952C1B87DE;
	Tue, 26 Nov 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613582; cv=none; b=LfjLJ2U0IfjE2oQaBDABF/tNVAHajVYDRvaQVBg5UdBEMvsif6XVbrWs++bcSjVik+sJRj2KB3UkpNu76wexKMylvADHEXZJ7KSnIfdJ9d8LyP7oGIml3CjtHaiM79MOF5TW/uNOaYsvch1UfFg7BcDCMIsSR+XpWIpva8yUxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613582; c=relaxed/simple;
	bh=vmb0LVU7VYZ5D72G8ZNIEvuV+aZ8kSkVuOA6QAl5Q4I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tighDA+ZMOFa/kqD3ZcH87kAGmdUJJ66hEn+zT5kDeladjdOvlJIrt2amfGf6di4Ox6u1hIkYkLPHp+HnsiqROqAACJqaff5spe+q5QGGreOUkgqAWLgq1B7kkwFlg8aiB8xPa12Pd7H9iz5xQtamTBxmNvjk3RfSejcddKGXsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1674595bec2c-56543;
	Tue, 26 Nov 2024 17:32:49 +0800 (CST)
X-RM-TRANSID:2ee1674595bec2c-56543
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5674595c0746-2b847;
	Tue, 26 Nov 2024 17:32:49 +0800 (CST)
X-RM-TRANSID:2ee5674595c0746-2b847
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] ALSA: asihpi: Remove unused variable
Date: Tue, 26 Nov 2024 01:32:45 -0800
Message-Id: <20241126093245.3228-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

the variable is never referenced in the code, just remove it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/pci/asihpi/asihpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index fdd4fe162..5a84591b1 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -464,7 +464,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 			return -ENOMEM;
 		}
 
-		err = hpi_stream_get_info_ex(dpcm->h_stream, NULL,
+		hpi_stream_get_info_ex(dpcm->h_stream, NULL,
 				&dpcm->hpi_buffer_attached, NULL, NULL, NULL);
 	}
 	bytes_per_sec = params_rate(params) * params_channels(params);
-- 
2.17.1




