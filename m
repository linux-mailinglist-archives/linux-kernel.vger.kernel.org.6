Return-Path: <linux-kernel+bounces-269219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F58942F66
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25BF286D45
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8FF1BE233;
	Wed, 31 Jul 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c+PxEqef";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fU/GDxHZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c+PxEqef";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fU/GDxHZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01451B373C;
	Wed, 31 Jul 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430353; cv=none; b=bFjd0uQ3vdCuwb0l0JRSOmZT3ruGmvzj5zM+n9b6iJ3zI3KTyNQw3g7GF/W6M4F4RL6Ng4LhJcaIvs9kPcyKx+O5meCJyOK/mLfOn/cFufTJRFI1IQu6xqX+IOdpGymAwdn3E3hZBLWfgA9cYV/MDxWE3yWTeV7zgud/JokEkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430353; c=relaxed/simple;
	bh=jPNRfYvc3p5Ff7xKGx5V4dnx6zKau2j4YlKH+npVZqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcH3QpJgUitLB9pjQLXlU2zl9mW/f9OAHEfjyYhUx2ycYTthzo3/1XfPpKv2gxOjcM79BAA4hqVoTmdp2v+U0pmL5psQdPHHmJiNIWJOwkLjluc8534GM75ujA9PHcgi7z3/hIcFoMnfQQgCVQgs49R/Z61gJCy4OiEWp6z9DnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c+PxEqef; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fU/GDxHZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c+PxEqef; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fU/GDxHZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 582BD21B51;
	Wed, 31 Jul 2024 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxU+AesFYUxrvsdAdk3sLZxuGllIUill+l6h2/H5VTs=;
	b=c+PxEqef6z3V0YpoW4laurvnFuzUcwQwlu7kw2aQxMRFCLdmrwQ5mB4+R5KrZEPn8Bm8qe
	ELDADfc9pE3EpfEvtbgVy7vTvGmXsGkaN1k/pJRRdZYi1Qm0Nl4DvPczgcSxOhPqREEplH
	fi34WF5BoEeyNHfwGFVKTVneCyzAynE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxU+AesFYUxrvsdAdk3sLZxuGllIUill+l6h2/H5VTs=;
	b=fU/GDxHZvrT1SaPUcHjIaI5GXk5Id+8ldCj6raBjqtfdvt1wBbZo63AR8MLwD4y5aBdXiD
	QUvt9idY/GrBv1BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c+PxEqef;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="fU/GDxHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxU+AesFYUxrvsdAdk3sLZxuGllIUill+l6h2/H5VTs=;
	b=c+PxEqef6z3V0YpoW4laurvnFuzUcwQwlu7kw2aQxMRFCLdmrwQ5mB4+R5KrZEPn8Bm8qe
	ELDADfc9pE3EpfEvtbgVy7vTvGmXsGkaN1k/pJRRdZYi1Qm0Nl4DvPczgcSxOhPqREEplH
	fi34WF5BoEeyNHfwGFVKTVneCyzAynE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxU+AesFYUxrvsdAdk3sLZxuGllIUill+l6h2/H5VTs=;
	b=fU/GDxHZvrT1SaPUcHjIaI5GXk5Id+8ldCj6raBjqtfdvt1wBbZo63AR8MLwD4y5aBdXiD
	QUvt9idY/GrBv1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27B6B13297;
	Wed, 31 Jul 2024 12:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SIF0CIszqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Corentin Chary <corentin.chary@gmail.com>
Subject: [PATCH 10/10] platform/x86: samsung-laptop: Use backlight power constants
Date: Wed, 31 Jul 2024 14:51:00 +0200
Message-ID: <20240731125220.1147348-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731125220.1147348-1-tzimmermann@suse.de>
References: <20240731125220.1147348-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,intel.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.81
X-Rspamd-Queue-Id: 582BD21B51

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality or semantics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/samsung-laptop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 3d2f8e758369..0d3e3ca20b1b 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -14,7 +14,6 @@
 #include <linux/pci.h>
 #include <linux/backlight.h>
 #include <linux/leds.h>
-#include <linux/fb.h>
 #include <linux/dmi.h>
 #include <linux/platform_device.h>
 #include <linux/rfkill.h>
@@ -554,7 +553,7 @@ static int update_status(struct backlight_device *bd)
 
 	set_brightness(samsung, bd->props.brightness);
 
-	if (bd->props.power == FB_BLANK_UNBLANK)
+	if (bd->props.power == BACKLIGHT_POWER_ON)
 		sabi_set_commandb(samsung, commands->set_backlight, 1);
 	else
 		sabi_set_commandb(samsung, commands->set_backlight, 0);
@@ -1189,7 +1188,7 @@ static int __init samsung_backlight_init(struct samsung_laptop *samsung)
 
 	samsung->backlight_device = bd;
 	samsung->backlight_device->props.brightness = read_brightness(samsung);
-	samsung->backlight_device->props.power = FB_BLANK_UNBLANK;
+	samsung->backlight_device->props.power = BACKLIGHT_POWER_ON;
 	backlight_update_status(samsung->backlight_device);
 
 	return 0;
-- 
2.45.2


