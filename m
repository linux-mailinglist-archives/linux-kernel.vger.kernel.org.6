Return-Path: <linux-kernel+bounces-385223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 376349B3433
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6241F22589
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730991DE2C6;
	Mon, 28 Oct 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XecdA1Wd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0S5ME1kT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XecdA1Wd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0S5ME1kT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E41D61A4;
	Mon, 28 Oct 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127681; cv=none; b=NHx7bZ2sPp1bhamFbzlTkenbEIHMXejLH1Kuav5TdB8QVv4qAhx60HAvT5BdpQTE3AlARhLWWfsV5VNLMlXU8u8zBHdTZr7zRrIWSZ6z0xLl6ofNMSXIjVuIlQouGRPgZUCOQ2nFdXHINKGChNKRdOdEof+CnMcXPpXmSfv9C2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127681; c=relaxed/simple;
	bh=Zsay79nU2eMCSqWrRa8oot6GKFy/BE43j1a9E9/Qt9Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5bTFyDTNpjUWwXQnGOAQDI8S+jA/UeDZz46pC07LBV/REItavHV9WOZjdnAtlHHk0U1SAom0pxBezNHC0ZFYWHHD7ESlnMA9jRoI/G4puNdPkzfnYRa/Dyew7Dmy4v8SOFvRU3KtqVFme3B/7HNr85LFHWNOkwulMKF4HDHhLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XecdA1Wd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0S5ME1kT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XecdA1Wd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0S5ME1kT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98C441FDA1;
	Mon, 28 Oct 2024 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730127677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mbpjmrdgp+jOJf/Yxvcfl5QS2vt8WbjcQQlTRirH1yc=;
	b=XecdA1WdyK4eKNYL0NncyvaKr/D4rCWRRXJVRWA3VPI1oS09X9s4fHdlx//3izmF7Ui9Gd
	AffhSoO1IuONR3YcNSPR+WV69NLtWz2pCOgtvqfvASwRqW0mO//2mMylmWLE6lLW7bEk8D
	2W33G+Lcz7hasKqL9/KNV7AKY7PIO3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730127677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mbpjmrdgp+jOJf/Yxvcfl5QS2vt8WbjcQQlTRirH1yc=;
	b=0S5ME1kTvVpXYX6PFTle3qvmuBhUvet48PPcLKI+5TIGPgNfWR5N1IZnuhS/qVS/Wuzfcm
	kOon8PGEZVfNPCDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XecdA1Wd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0S5ME1kT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730127677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mbpjmrdgp+jOJf/Yxvcfl5QS2vt8WbjcQQlTRirH1yc=;
	b=XecdA1WdyK4eKNYL0NncyvaKr/D4rCWRRXJVRWA3VPI1oS09X9s4fHdlx//3izmF7Ui9Gd
	AffhSoO1IuONR3YcNSPR+WV69NLtWz2pCOgtvqfvASwRqW0mO//2mMylmWLE6lLW7bEk8D
	2W33G+Lcz7hasKqL9/KNV7AKY7PIO3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730127677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mbpjmrdgp+jOJf/Yxvcfl5QS2vt8WbjcQQlTRirH1yc=;
	b=0S5ME1kTvVpXYX6PFTle3qvmuBhUvet48PPcLKI+5TIGPgNfWR5N1IZnuhS/qVS/Wuzfcm
	kOon8PGEZVfNPCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 707D5136DC;
	Mon, 28 Oct 2024 15:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H9AhGj2nH2eHCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Oct 2024 15:01:17 +0000
Date: Mon, 28 Oct 2024 16:02:20 +0100
Message-ID: <87a5eoqnib.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13
In-Reply-To: <20241027221655.74885-1-piyuschouhan1598@gmail.com>
References: <20241027221655.74885-1-piyuschouhan1598@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 98C441FDA1
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 27 Oct 2024 23:16:55 +0100,
Piyush Raj Chouhan wrote:
> 
> From: pc1598 <piyushchouhan1598@gmail.com>

Please drop this line, otherwise it's taken as the author.
We prefer having the same address as specified in Signed-off-by tag.


thanks,

Takashi


> Infinix ZERO BOOK 13 has a 2+2 speaker system which isn't probed correctly.
> This patch adds a quirk with the proper pin connections.
> Also The mic in this laptop suffers too high gain resulting in mostly fan noise being recorded,
> This patch Also limit mic boost.
> 
> HW Probe for device; https://linux-hardware.org/?probe=a2e892c47b
> 
> Test: All 4 speaker works, Mic has low noise.
> Signed-off-by: Piyush Raj Chouhan <piyushchouhan1598@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 3567b14b52b7..075935707f8a 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -7551,6 +7551,7 @@ enum {
>  	ALC290_FIXUP_SUBWOOFER_HSJACK,
>  	ALC269_FIXUP_THINKPAD_ACPI,
>  	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
> +	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
>  	ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO,
>  	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
>  	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
> @@ -7996,6 +7997,16 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
>  	},
> +	[ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = (const struct hda_pintbl[]) {
> +			{ 0x14, 0x90170151 }, /* use as internal speaker (LFE) */
> +			{ 0x1b, 0x90170152 }, /* use as internal speaker (back) */
> +			{ }
> +		},
> +		.chained = true,
> +		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
> +	},
>  	[ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO] = {
>  		.type = HDA_FIXUP_PINS,
>  		.v.pins = (const struct hda_pintbl[]) {
> @@ -10989,6 +11000,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> +	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
>  	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
>  	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
>  	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
> -- 
> 2.46.2
> 

