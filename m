Return-Path: <linux-kernel+bounces-347641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D298D890
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84739B2168E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE31D174C;
	Wed,  2 Oct 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DtJHMYXQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hTtLYbPv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DtJHMYXQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hTtLYbPv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475111D0E06;
	Wed,  2 Oct 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877561; cv=none; b=PCkbDtexTXApxU2DyD14+mmB2EVeUWRL1COtub1s9Ad5bn+CeGoG6pR5qZRirwmZs5CZFatOqy7o2i2SgoHE7r4XC+JUUOlOUbEX3O9Qt7C3jGI39T++GoZfNmUf0ynzaKVFTVKZP5ksZhXvbgOxrRI1RAIufKNAn9FGW3nrr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877561; c=relaxed/simple;
	bh=H3x7HChewXCBq++vL0N/zqhVYLD2Xe15enk4XJYLpf4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYcyemYyaFzHzI1eOhbJmk9XaCJuxWaoyi//zXisaXuM8o9zbUQILojWLnT7rHwc2x4d9DtAglYM2GO8LaR7YfcqyUC91E0RzajAFKFg6n4eACXGpueOfePn4s/XBd8OzhroXaL/9hOblXUOCO21dj/vdR1HnrJRuXeHQvtfr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DtJHMYXQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hTtLYbPv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DtJHMYXQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hTtLYbPv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5191F84B;
	Wed,  2 Oct 2024 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727877557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0wIVxDJS0t9oUJn2fZsmk70kxLohlX7viakzu3sEqk=;
	b=DtJHMYXQBb/1sTH4jvQO9npZieA1e+5QEECvZMFkxIOZOtucNEzJrn3FxKhkYtLPM3A++m
	QxY0K0g0/Hk8rFEs1CClUoeKIe5T6HW3fTe7GICONR87eEcbhkfFYBGn87+Hl8bV/D6hln
	Y+eu42uQg2BJD4eVYLC/fdq3rydh6yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727877557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0wIVxDJS0t9oUJn2fZsmk70kxLohlX7viakzu3sEqk=;
	b=hTtLYbPvAipZEgfjT2M/P3B45+xJKvkxu+0/Ctgy06LhjA5x1K9z9toH/vbCEOuGDEy7UX
	a5oGkOKpYzPnShDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727877557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0wIVxDJS0t9oUJn2fZsmk70kxLohlX7viakzu3sEqk=;
	b=DtJHMYXQBb/1sTH4jvQO9npZieA1e+5QEECvZMFkxIOZOtucNEzJrn3FxKhkYtLPM3A++m
	QxY0K0g0/Hk8rFEs1CClUoeKIe5T6HW3fTe7GICONR87eEcbhkfFYBGn87+Hl8bV/D6hln
	Y+eu42uQg2BJD4eVYLC/fdq3rydh6yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727877557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0wIVxDJS0t9oUJn2fZsmk70kxLohlX7viakzu3sEqk=;
	b=hTtLYbPvAipZEgfjT2M/P3B45+xJKvkxu+0/Ctgy06LhjA5x1K9z9toH/vbCEOuGDEy7UX
	a5oGkOKpYzPnShDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38BDA13974;
	Wed,  2 Oct 2024 13:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n2ueDLVR/Wa5JwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 02 Oct 2024 13:59:17 +0000
Date: Wed, 02 Oct 2024 16:00:10 +0200
Message-ID: <87seteli51.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christoffer Sandberg <cs@tuxedo.de>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jerry Luo <jerryluo225@gmail.com>,
	christian@heusel.eu,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	regressions@lists.linux.dev,
	wse@tuxedocomputers.com
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <b38b5947482a5ca4b55e0ddb908c2f34@tuxedo.de>
References: <87jzfbh5tu.wl-tiwai@suse.de>
	<ea6e5168-238f-41f5-9600-36b75ed990a1@gmail.com>
	<87jzetk2l0.wl-tiwai@suse.de>
	<b38b5947482a5ca4b55e0ddb908c2f34@tuxedo.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: multipart/mixed;
 boundary="Multipart_Wed_Oct__2_16:00:10_2024-1"
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,heusel.eu,vger.kernel.org,perex.cz,lists.linux.dev,tuxedocomputers.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Score: -3.30
X-Spam-Flag: NO

--Multipart_Wed_Oct__2_16:00:10_2024-1
Content-Type: text/plain; charset=US-ASCII

On Wed, 02 Oct 2024 10:21:22 +0200,
Christoffer Sandberg wrote:
> 
> 
> 
> On 30.9.2024 09:44, Takashi Iwai wrote:
> > On Mon, 23 Sep 2024 21:37:42 +0200,
> > Jerry Luo wrote:
> >> 
> >> 
> >> Hi Takashi,
> >> 
> >> On Mon, 16 Sep 2024 19:22:05 +0200,
> >> 
> >> Takashi Iwai wrote:
> >> 
> >>     Could you give alsa-info.sh output from both working and
> >> non-working
> >>     cases?  Run the script with --no-upload option and attach the
> >> outputs.
> >> 
> >>     thanks,
> >> 
> >>     Takashi
> >> 
> >> Issue now reappear, output from alsa-info.sh are attached. If they
> >> are still
> >> needed.
> > 
> > Thanks.  The obvious difference seems to be the assignment of two DACs
> > 0x10 and 0x11 for headphone and speaker outputs.
> > 
> > Christoffer, how are those on your machines?
> 
> I attached alsa-info from the Sirius Gen2 device.
> 
> Comparing the working/nonworking of Jerry, yeah, the assignment of
> 0x10 and 0x11 looks switched around. I don't see what difference this
> would make. Also, node 0x22 has "bass speaker" controls in the
> non-working version.
> 
> Comparing the Sirius Gen2 alsa-info with Jerrys, to me it looks like
> the non-working version corresponds to our working version.
> 
> I would expect the non-working version to happen all the time though
> with regards to the "bass speaker" controls. Why would this only
> happen sometimes?

Thanks!  The assignment of DACs depend on the pins and topology, so it
can be a bit sensitive.

Now looking more closely at both outputs, I wonder how the commit
breaks pang14.  Maybe it has a PCI SSID 2782:12c5 (or 12c3) while the
codec SSID is 2782:12b3?  If so, the patch below should fix.

Could you guys try it and verify whether it fixes for Pangolin and
doesn't break Sirius?


Takashi



--Multipart_Wed_Oct__2_16:00:10_2024-1
Content-Type: application/octet-stream; type=patch; name="0001-ALSA-hda-conexant-Fix-conflicting-quirk-for-System76.patch"
Content-Disposition: attachment; filename="0001-ALSA-hda-conexant-Fix-conflicting-quirk-for-System76.patch"
Content-Transfer-Encoding: 7bit

From d2323f9fce4a65639a7484accce8f500ca7186f0 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 2 Oct 2024 15:51:56 +0200
Subject: [PATCH] ALSA: hda/conexant: Fix conflicting quirk for System76
 Pangolin

We received a regression report for System76 Pangolin (pang14) due to
the recent fix for Tuxedo Sirius devices to support the top speaker.
The reason was the conflicting PCI SSID, as often seen.

As a workaround, now the codec SSID is checked and the quirk is
applied conditionally only to Sirius devices.

Fixes: 4178d78cd7a8 ("ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices")
Reported-by: Christian Heusel <christian@heusel.eu>
Reported-by: Jerry <jerryluo225@gmail.com>
Closes: https://lore.kernel.org/c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index ade42a8209c2..b61ce5e6f5ec 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -816,6 +816,23 @@ static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
 	{}
 };
 
+/* pincfg quirk for Tuxedo Sirius;
+ * unfortunately the (PCI) SSID conflicts with System76 Pangolin pang14,
+ * which has incompatible pin setup, so we check the codec SSID (luckily
+ * different one!) and conditionally apply the quirk here
+ */
+static void cxt_fixup_sirius_top_speaker(struct hda_codec *codec,
+					 const struct hda_fixup *fix,
+					 int action)
+{
+	/* ignore for incorrectly picked-up pang14 */
+	if (codec->core.subsystem_id == 0x278212b3)
+		return;
+	/* set up the top speaker pin */
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		snd_hda_codec_set_pincfg(codec, 0x1d, 0x82170111);
+}
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -976,11 +993,8 @@ static const struct hda_fixup cxt_fixups[] = {
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
 	[CXT_PINCFG_TOP_SPEAKER] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x1d, 0x82170111 },
-			{ }
-		},
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_sirius_top_speaker,
 	},
 };
 
-- 
2.43.0


--Multipart_Wed_Oct__2_16:00:10_2024-1--

