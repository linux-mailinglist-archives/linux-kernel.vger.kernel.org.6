Return-Path: <linux-kernel+bounces-517602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5CA382EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77858171F92
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E622217F5C;
	Mon, 17 Feb 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b="EY5mGSWv"
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E862218842;
	Mon, 17 Feb 2025 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795158; cv=none; b=A4+vpsN6AJIZPlvtCQQ8UdlSX3T8KYMSP2Y7ytl8GbV/ryHLuzyzjx3regxhbkpBkXyWNpnE1VlKG0TpzAGUk7KdcUlL1GexXMScHeUZ8ai2T+ErDZKdM3w5BVwyr2uwQNorPPyQJZkDWGL7+p2fX2vZVWnI5ja7/B+cTDoRWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795158; c=relaxed/simple;
	bh=lFJsXlgEY82n+SX5Ibkp2jyxFTxnjgwhZlkrhHi3tzc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=l84grobQbuVKX7IZP7Y3xHVMxboVi70iTIxknLE9keCmlpcElEcJ/T9AEPHVW63RXixhueo7v04V+MSioLY4MqhtcqKMNCotexZY/eWvzIwxnmF8MSJqcvSVKr0KbdHGKc2JI+YWWqsvsE6zqSDagibC7/7Pp9JGIwtJ3myPouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk; spf=pass smtp.mailfrom=pelago.org.uk; dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b=EY5mGSWv; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pelago.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pelago.org.uk; s=mythic-beasts-k1; h=To:Subject:From:Date;
	bh=CviyWBmyPdnlT0TjppgyZxk7v9bpeFzOVnWOqtTK928=; b=EY5mGSWv+YCfGvTHU/IXarZcEY
	Au0oDEgJ5aPk3Zop3VG4pnVNJWNIEAeT9QZkMK3rw4S7s8oEopKqz9Vj2bRAB4/H7hT1bQwtItQD7
	JVLj0yxsU8zZI+90M4dKYyT1mFU5/Jg8TUlWqv923esjM+9pOWYur1EJQYH+alwO3D/dnSkA3iXYo
	W/LQQYtCYhBm2OaceFdmG9WHHyOjvJW7ExC2P7Z1mRocy0a5oA00ursKWzQQ8v7PGkolg6x41uBuf
	6SzofvjELAk4BhGamfVrCKtIKB47WAyWVq/imvHzsGf0Usjmx+AaDSLXkW+GSRLUvg4eoeWoc+TaA
	8ejpt/rg==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <john-linux@pelago.org.uk>)
	id 1tk0CA-0057lr-AK; Mon, 17 Feb 2025 12:25:54 +0000
Message-ID: <690b6c31-67b3-42c5-86a0-0efe3640724e@pelago.org.uk>
Date: Mon, 17 Feb 2025 12:25:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Veness <john-linux@pelago.org.uk>
Subject: [PATCH v3] ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute
 LED
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0

Allows the LED on the dedicated mute button on the HP ProBook 450 G4
laptop to change colour correctly.

Cc: stable@vger.kernel.org
Signed-off-by: John Veness <john-linux@pelago.org.uk>

---
Re-submitted with correct stable CC'ing method hopefully! Sorry, I'm
still new to this.

 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 4985e72b9..34874039a 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1090,6 +1090,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
-- 
2.48.1

