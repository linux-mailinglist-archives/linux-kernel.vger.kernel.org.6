Return-Path: <linux-kernel+bounces-397456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F309BDC4B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D0D1C2025F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0919309E;
	Wed,  6 Nov 2024 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RagMxLTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6D192D7B;
	Wed,  6 Nov 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859092; cv=none; b=RVEZSAC08JwWIOJzkAMfq3UFOzu6LnI8jAb0WbsvBFgVileUpAAugu4gcuCcZkekdYcTqJbPf8q+QAOYtb+4hdxTBQrrS7HTNcNehnJJXrPSmWK7hYmOqQtrv9jEn+OaFF7EguuEI6bAACadAtIpMOXocBdVTBj1QuijjzNq9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859092; c=relaxed/simple;
	bh=yoiX/BNCVPPIZ+ku6FhTAvGoBpO+i1o9f6hvkZYQ+Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJRwkhSX+JwsVOS1Os+jB5G0Wcd/LLMtgny2hU5YI2jaqxpu4Mt38qJ4wW3QBYWomIFobnh/cQPPRmrYxjtV+iOsy2XfBV0+Psr897E0J6PEV0UWtSZ0VntIhaDVXTb16Qb+Llwls8ZQaN80dpb0QmJHJw0t1/r7LfIDaZMeHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RagMxLTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06E9C4CECF;
	Wed,  6 Nov 2024 02:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859092;
	bh=yoiX/BNCVPPIZ+ku6FhTAvGoBpO+i1o9f6hvkZYQ+Gs=;
	h=From:To:Cc:Subject:Date:From;
	b=RagMxLTbLrikBggldu3jElOdC4sDVdjik3UroKfvCb3OODCnmfZpPKBDEjmeLNPjV
	 Lb9RslH1GitY8DD26XWOm1xtlk3C2obr791keOsOdCMeuGhZqmUWAB6p4xRj+XbBT/
	 NvAAoVvgw4gaEahWf1PyFTdOjZQRk0rLCVLAz9jm80BsKfGRhLyXKswRHF6nOw7na/
	 3Qpo2PVX2fJJD5VjJuvmEDoHfTd6kB0yO1ocd0jeuVhRKD+njdiljvoBbZ/eHps1iC
	 NcXjzVUqF0JfXbfBGjHxOF2WVikzZ4f+WUQVGAR6GUBdEbdSh+hJ6er9xPHP2Xd2r0
	 tnNGPSsm4FX/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cs@tuxedo.de
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:11:27 -0500
Message-ID: <20241106021127.182244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e49370d769e71456db3fbd982e95bab8c69f73e8 Mon Sep 17 00:00:00 2001
From: Christoffer Sandberg <cs@tuxedo.de>
Date: Tue, 29 Oct 2024 16:16:53 +0100
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16
 Gen6 mb1

Quirk is needed to enable headset microphone on missing pin 0x19.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20241029151653.80726-2-wse@tuxedocomputers.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e06a6fdc0bab7..571fa8a6c9e12 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11008,6 +11008,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x115c, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
-- 
2.43.0





