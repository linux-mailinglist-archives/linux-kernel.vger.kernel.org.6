Return-Path: <linux-kernel+bounces-343806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E7989FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8642F1F22663
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C118CBEF;
	Mon, 30 Sep 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qTmxBEg6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b6b+0by9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qTmxBEg6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b6b+0by9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6218BB9E;
	Mon, 30 Sep 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693354; cv=none; b=GWazwT4+vDkrmZZUkPy05m/FSzCY2NaZQfui/d1C2nLqiqqfzx0ugbfdaDd014dzPP9TRjxx5lSVMssZ4kf+m9NEz/pQf+4wEDrfmUqIZBuv/uRppSMbt+a9M2LFFlm0FjP77VRPFbu6sxDSfcUbm79PsFPBLqeQATYW8yREO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693354; c=relaxed/simple;
	bh=FhlGhBiu1endbj4ATv2BZikqkhkOKulNPUKxXrSSLFg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDGRoNW5Hc+d5vjc7WgxLHM7y6lkqva+CDml+GNHYEkP2qN+VFHuN3o0ZKAhmSaM5x+hTtHKaWrPNio+2vGYn9JW+6NVK5QJLqUCkXA8W/YpYKTg+qchN5ZWIid49TVxZUGAuOUPr+vZDWLcW/VOLnDQC/vIECpst/yljsTdLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qTmxBEg6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b6b+0by9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qTmxBEg6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b6b+0by9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC12E1F7FC;
	Mon, 30 Sep 2024 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727693350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FoYkvambTs+GOnmiclqfZWv/9RYyTntP9l8SSeJfySk=;
	b=qTmxBEg6loCdKbDUtzuWPqKsy3N4B6YauShoL5f/MU+TPNsLLoswt0ZqJrbPKaUu9qEkwo
	0B83zic+siZ/5PRvQbawUvoB/58O99QjmNN7f8naYeHIMey7Gw8HP2wUw0MZuFnGlYQ/FA
	/99E1KHkF14mABAFluLHwjKZh+0l2wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727693350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FoYkvambTs+GOnmiclqfZWv/9RYyTntP9l8SSeJfySk=;
	b=b6b+0by9z47bNAvdCk2Yl64zTlVm6SSr13Rz1/aAVjcoQRbPaqOwrdsrkFiut/4wVQPOsh
	t+9IOSX72Edvn1AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727693350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FoYkvambTs+GOnmiclqfZWv/9RYyTntP9l8SSeJfySk=;
	b=qTmxBEg6loCdKbDUtzuWPqKsy3N4B6YauShoL5f/MU+TPNsLLoswt0ZqJrbPKaUu9qEkwo
	0B83zic+siZ/5PRvQbawUvoB/58O99QjmNN7f8naYeHIMey7Gw8HP2wUw0MZuFnGlYQ/FA
	/99E1KHkF14mABAFluLHwjKZh+0l2wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727693350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FoYkvambTs+GOnmiclqfZWv/9RYyTntP9l8SSeJfySk=;
	b=b6b+0by9z47bNAvdCk2Yl64zTlVm6SSr13Rz1/aAVjcoQRbPaqOwrdsrkFiut/4wVQPOsh
	t+9IOSX72Edvn1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E68713A8B;
	Mon, 30 Sep 2024 10:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xa5WFSaC+mb8RwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 10:49:10 +0000
Date: Mon, 30 Sep 2024 12:50:03 +0200
Message-ID: <877catiffo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Peter Wu <peter@lekensteyn.nl>,
	Lukas Wunner <lukas@wunner.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel: Fix Optimus when GPU has no sound
In-Reply-To: <ZvpTRLxSkcqn03Fk@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
	<871q1ygov9.wl-tiwai@suse.de>
	<ZttEUjeYFzdznYKM@mail.gmail.com>
	<87wmjndbha.wl-tiwai@suse.de>
	<ZtxZBUjlF8TeIUKC@mail.gmail.com>
	<87jzfncvm0.wl-tiwai@suse.de>
	<ZtyMWSA0bg1SjFSU@mail.gmail.com>
	<87ed5vcp23.wl-tiwai@suse.de>
	<Zu5_faxUwoIl09fW@mail.gmail.com>
	<87msjpk5el.wl-tiwai@suse.de>
	<ZvpTRLxSkcqn03Fk@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,suse.com,linux.intel.com,intel.com,gmail.com,loongson.cn,google.com,lekensteyn.nl,wunner.de,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 30 Sep 2024 09:29:08 +0200,
Maxim Mikityanskiy wrote:
> 
> On Mon, 30 Sep 2024 at 08:43:46 +0200, Takashi Iwai wrote:
> > On Sat, 21 Sep 2024 10:10:37 +0200,
> > Maxim Mikityanskiy wrote:
> > > 
> > > On Sat, 07 Sep 2024 at 20:10:44 +0200, Takashi Iwai wrote:
> > > > On Sat, 07 Sep 2024 19:24:41 +0200,
> > > > Maxim Mikityanskiy wrote:
> > > > > 
> > > > > On Sat, 07 Sep 2024 at 17:49:11 +0200, Takashi Iwai wrote:
> > > > > > On Sat, 07 Sep 2024 15:45:41 +0200,
> > > > > > Maxim Mikityanskiy wrote:
> > > > > > > 
> > > > > > > On Sat, 07 Sep 2024 at 12:06:25 +0200, Takashi Iwai wrote:
> > > > > > > > On Fri, 06 Sep 2024 20:05:06 +0200,
> > > > > > > > Maxim Mikityanskiy wrote:
> > > > > > > > > 
> > > > > > > > > On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> > > > > > > > > > On Wed, 04 Sep 2024 22:39:55 +0200,
> > > > > > > > > > Maxim Mikityanskiy wrote:
> > > > > > > > > > > 
> > > > > > > > > > > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> > > > > > > > > 
> > > > > > > > > Spotted a typo: s/520M/540M/
> > > > > > > > > 
> > > > > > > > > > > the discrete GPU. snd_hda_intel probes the device and schedules
> > > > > > > > > > > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > > > > > > > > > > up probed, but calls azx_free() and stops the chip. However, from the
> > > > > > > > > > > runtime PM point of view, the device remains active, because the PCI
> > > > > > > > > > > subsystem makes it active on probe, and it's still bound. It prevents
> > > > > > > > > > > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > > > > > > > > > > power management for the video and audio devices).
> > > > > > > > > > > 
> > > > > > > > > > > Fix it by forcing the device to the suspended state in azx_free().
> > > > > > > > > > > 
> > > > > > > > > > > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > > > > > > > > > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > > > > > > > > > 
> > > > > > > > > > What if this device probe is skipped (e.g. adding your device entry to
> > > > > > > > > > driver_denylist[] in hda_intel.c)?  Is the device also in the
> > > > > > > > > > runtime-suspended state?
> > > > > > > > > 
> > > > > > > > > I added the following:
> > > > > > > > > 
> > > > > > > > > { PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },
> > > > > > > > > 
> > > > > > > > > The probe was apparently skipped (the device is not attached to a
> > > > > > > > > driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
> > > > > > > > > DynOff.
> > > > > > > > 
> > > > > > > > OK, that's good.
> > > > > > > > 
> > > > > > > > > However, I'm not sure whether it's a good idea to blacklist 540M
> > > > > > > > > entirely, as there might be other laptops with this GPU that have sound,
> > > > > > > > > and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.
> > > > > > > > 
> > > > > > > > You should specify the PCI SSID of your device instead of 0:0 in the
> > > > > > > > above, so that it's picked up only for yours.
> > > > > > > 
> > > > > > > Where can I get it?
> > > > > > > 
> > > > > > > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_vendor
> > > > > > > 0x0000
> > > > > > > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_device
> > > > > > > 0x0000
> > > > > > 
> > > > > > Ouch, Lenovo didn't set it right.
> > > > > > Alternatively we may introduce a deny list based on DMI.  Hmm...
> > > > > 
> > > > > A DMI-based quirk sounds better than blocking any NVIDIA 540M, it would
> > > > > also allow handling alternative GPUs on this laptop model.
> > > > > 
> > > > > But could you explain what's wrong with a generic approach that I
> > > > > suggest (probe_continue failed => mark as suspended)? It doesn't require
> > > > > any lists. Any drawbacks?
> > > > 
> > > > As you noticed, it will leave the device bound with driver, i.e. this
> > > > looks as if it were operative.  It means that the sound driver is
> > > > still responsible for suspend/resume or whatever action even though
> > > > it's totally useless.  In that sense, it makes more sense to give it
> > > > away at the early stage before actually binding it, and the deny list
> > > > is exactly for that.
> > > 
> > > Thanks for your feedback!
> > 
> > Sorry for the late reply, as I've been off in the last weeks.
> > 
> > > Do you happen to know whether there is a way for a driver to unbind
> > > itself after probe() returned success? I've never seen anything like
> > > this, but it would be a perfect solution: no lists and no driver bound
> > > after the delayed initialization fails.
> > 
> > I don't think it's possible for now (at least in a clean way).
> > It should be a call of device_driver_detach(), but it's no exported
> > API.
> > 
> > > > Apart from that, the suggested change itself can be applied
> > > > independently from the deny list update, too.  It'd be good for other
> > > > similar devices, too.
> > > 
> > > I was trying to avoid lists, because it's a maintainance nightmare (the
> > > lists are never complete, there might be false positives, etc.), and
> > > we'd need to add another type of a list for DMI quirks. Moreover, adding
> > > both my change and a list entry has a drawback that similarly broken
> > > devices will use different workaround code (i.e. less robust), and the
> > > ones that use the generic fallback will never get on the list, because
> > > no one will report it.
> > > 
> > > As a maintainer, what's your preferred approach?
> > > 
> > > 1. Unbind ourselves on failure in azx_probe_continue() (but I don't know
> > > whether it's possible).
> > 
> > So it's no easy way.
> > 
> > > 2. Add a DMI deny list to hda_intel.
> > > 
> > > 3. Add a DMI check to quirk_nvidia_hda (i.e. don't enable a non-existent
> > > HDA if it's not enabled by BIOS on this laptop model).
> > 
> > I'm afraid that it may break other systems; IIRC, the power up was
> > needed explicitly even if it's disabled on BIOS.
> 
> I'm not suggesting full removal of quirk_nvidia_hda. If we add a DMI
> check to disable quirk_nvidia_hda on this particular laptop model, it
> can't break other systems, can it?

Possibly, but if BIOS enables it, this quirk will just skip, no?
My gut feeling is rather to leave it.  Who knows any side effect if we
tweak there.  But, you can experiment it for judging whether it fits
better, of course.

> Anyways, adding a DMI check to hda_intel or quirk_nvidia_hda seems the
> same level of efforts, so I can proceed with the former. It's the same
> power consumption either way, right?

I assume so, but you need to check in your side.

> I'm also thinking of adding a module parameter to block probing of the
> DGPU audio. Back in the days, there were plenty of similar Lenovo
> laptops, which might also suffer from the same issue.

That's an overkill.  We can apply a runtime-PM suspended change as
your patch in addition to the deny list.  And this can give some info
print to users to update the deny list, too.


thanks,

Takashi

