Return-Path: <linux-kernel+bounces-332695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32997BD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F34F284C74
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017518A957;
	Wed, 18 Sep 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X7/Nrsok";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h/N7oq85";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rnPRlbT0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SzT0YTtM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A71189F5D;
	Wed, 18 Sep 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667351; cv=none; b=YOeUZhv11GpZywUvE58OMPQzg6cuwHs+9FmkZQzITyLCVXz/f/El2Xm++jdnfvwc8A0M1kigX4sHlsSpuU/mimUVphLGx06zx+MBWfZRVKZeJxuFdRHTUJ2JJ/A/GByXMjD5vxo7/60IQ7lKvipx1qzra+jtKQ41edyfaceVhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667351; c=relaxed/simple;
	bh=x/j6+utVxm9MtbnUt+vtiAGSki5s6+vNIxKDQ8KERG4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6HxwwfwZTYkUfT6waAwVJtV69fasFCIGFMEN7Q1PJOpsUpA2WkTn1q9+iK8Wnu9//vYItkaTsaoPtVIocB41ue8gtIXEO68ojYi8saZk4ilMOuOK/5WY5CEWr4j0+bisZG1x5I65elwADqEFqwoLqXcyepxbIzC4WHnebKPzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X7/Nrsok; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h/N7oq85; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rnPRlbT0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SzT0YTtM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C537E204D6;
	Wed, 18 Sep 2024 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726667346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjNWfIsoPbI5GNaskSTUHI9N2i+In/tLp/qU3/Au3vI=;
	b=X7/Nrsokv3hDgTCjtVEcFaQ0PA47upyfQrftkx9yOMI8MMalupFg7jsWnS8ISxiIf3sh5q
	TWmUptN9nvi0w+5OO4Aa86FrGhJ6YwS6sguXb9vtOrfW4bEj9tH9as2/gwD/zy3t2ELTb1
	KBiotMVoYt1J91kSbRqmzrBtsmjtavw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726667346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjNWfIsoPbI5GNaskSTUHI9N2i+In/tLp/qU3/Au3vI=;
	b=h/N7oq85HQNjcCKMexz2QvU9n6VONsVHq9WJh3PTsvQCQmdTf9d+bRs46zaHcZtK8l6UqR
	4Y2p3yo5Jzv8fFAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rnPRlbT0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SzT0YTtM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726667345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjNWfIsoPbI5GNaskSTUHI9N2i+In/tLp/qU3/Au3vI=;
	b=rnPRlbT0om2QMvMleN18/coLcwac++OxYszHim6xUPg+hzpu5Cc10865ckHXJWEAGHAqDB
	CqhIFsO3OJHw2BEUWzoDEUUX1bFXnUXgIYUU020b6ugpQSTjMQpn0mJY0g+xbL2HWOfBjg
	7f6380D5MYKvCBFpX5ERhiB90jpGAsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726667345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjNWfIsoPbI5GNaskSTUHI9N2i+In/tLp/qU3/Au3vI=;
	b=SzT0YTtMNqa3T7cF2vKbWo4QYfho97gBSDqxYAe9mAirME34ZkZUph9lnXPGZOCQ9R+bdg
	anDkqdPpM4djeEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 816B013508;
	Wed, 18 Sep 2024 13:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9G9KHlHa6mZSPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 18 Sep 2024 13:49:05 +0000
Date: Wed, 18 Sep 2024 15:49:55 +0200
Message-ID: <87r09hcbr0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jerry Luo <jerryluo225@gmail.com>,
	Christoffer Sandberg <cs@tuxedo.de>,
	Christian Heusel <christian@heusel.eu>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <dfb141e8-6afa-4d21-8cd4-f9a53e8a192e@tuxedocomputers.com>
References: <c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu>
	<87jzfbh5tu.wl-tiwai@suse.de>
	<66dfd536-ae17-4d75-b514-7931a3734e54@gmail.com>
	<20f70c0a92a27db29f188e05c33ba82c@tuxedo.de>
	<1fbba03e-56b8-4e74-adf6-998e3a2d9dac@gmail.com>
	<87setxe68m.wl-tiwai@suse.de>
	<87r09he63e.wl-tiwai@suse.de>
	<dfb141e8-6afa-4d21-8cd4-f9a53e8a192e@tuxedocomputers.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C537E204D6
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,tuxedo.de,heusel.eu,lists.linux.dev,vger.kernel.org,perex.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 18 Sep 2024 15:39:28 +0200,
Werner Sembach wrote:
> 
> Hi
> 
> Am 18.09.24 um 10:09 schrieb Takashi Iwai:
> > On Wed, 18 Sep 2024 10:06:01 +0200,
> > Takashi Iwai wrote:
> >> [...]
> >> I don't see any relevant about the incorrect volumes by the suggested
> >> commit, but at least we should avoid applying the quirk for a
> >> non-existing speaker pin.
> >> 
> >> Jerry, yours is with CX11970 (codec id 0x14f120d0), right?
> 
> Yes, at least for the preproduction sample of the Sirius Gen1 I have
> at hand atm.
> 
> pciid is 2782:12c3
> 
> @Christoffer: I guess 2782:12c5 is for the Gen2?

Hm, and one of those PCI SSID conflicts with System76 Pangolin
(pang14)?  All seem to have the very same codec CX11970.

If they really conflict in both PCI and HD-audio codec IDs, the only
way would be to check DMI string, I'm afraid.


Takashi

> 
> >> 
> >> Werner, how about your Sirius models?  Are they also with the same
> >> codec chip?
> >> If they are different, we can have the additional checks
> >> for judging whether to apply the pincfg fix or not.
> > Or it's a question to Christoffer.  Doesn't matter, if anyone can give
> > a info :)
> > 
> > 
> > thanks,
> > 
> > Takashi
> Codec: Conexant CX11970
> Address: 0
> AFG Function Id: 0x1 (unsol 1)
> Vendor Id: 0x14f120d0
> Subsystem Id: 0x278212c3
> Revision Id: 0x100001
> No Modem Function Group found
> Default PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> State of AFG node 0x01:
>   Power states:  D0 D1 D2 D3 D3cold S3D3cold CLKSTOP EPSS
>   Power: setting=D0, actual=D0
> GPIO: io=8, o=0, i=0, unsolicited=1, wake=1
>   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
> Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
>   Control: name="Speaker Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Speaker Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Device: name="CX11970 Analog", type="Audio", device=0
>   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
>   Amp-Out vals:  [0x4a 0x4a]
>   Converter: stream=0, channel=0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
>   Control: name="Headphone Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Headphone Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
>   Amp-Out vals:  [0xac 0xac]
>   Converter: stream=0, channel=0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x12 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
>   Control: name="Beep Playback Volume", index=0, device=0
>     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
>   Control: name="Beep Playback Switch", index=0, device=0
>     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
>   Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0f, mute=0
>   Amp-Out vals:  [0x03]
> Node 0x13 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
>   Control: name="Capture Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Control: name="Capture Switch", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Device: name="CX11970 Analog", type="Audio", device=0
>   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
>   Amp-In vals:  [0xb0 0xb0] [0xb0 0xb0] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x18 0x19* 0x1a 0x15 0x1f
> Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
>   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
>   Amp-In vals:  [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 3
>      0x1a* 0x1f 0x15
> Node 0x15 [Vendor Defined Widget] wcaps 0xf0050b: Stereo Amp-In
>   Amp-In caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
>   Amp-In vals:  [0x4a 0x4a] [0x4a 0x4a]
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 2
>      0x10* 0x11
> Node 0x16 [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x0001001c: OUT HP EAPD Detect
>   EAPD 0x2: EAPD
>   Pin Default 0x03211040: [Jack] HP Out at Ext Left
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x4, Sequence = 0x0
>   Pin-ctls: 0xc0: OUT HP
>   Unsolicited: tag=01, enabled=1
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 2
>      0x10 0x11*
> Node 0x17 [Pin Complex] wcaps 0x400501: Stereo
>   Pincap 0x00010010: OUT EAPD
>   EAPD 0x2: EAPD
>   Pin Default 0x91170110: [Fixed] Speaker at Int Rear
>     Conn = Analog, Color = Unknown
>     DefAssociation = 0x1, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 2
>      0x10* 0x11
> Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
>   Control: name="Mic Boost Volume", index=1, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00001324: IN Detect
>     Vref caps: HIZ 50 80
>   Pin Default 0x05a1303e: [Jack] Mic at Ext Top
>     Conn = 1/8, Color = Blue
>     DefAssociation = 0x3, Sequence = 0xe
>   Pin-ctls: 0x24: IN VREF_80
>   Unsolicited: tag=03, enabled=1
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
>   Control: name="Mic Boost Volume", index=0, device=0
>     ControlAmp: chs=3, dir=In, idx=0, ofs=0
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00001324: IN Detect
>     Vref caps: HIZ 50 80
>   Pin Default 0x03a11030: [Jack] Mic at Ext Left
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x3, Sequence = 0x0
>   Pin-ctls: 0x24: IN VREF_80
>   Unsolicited: tag=02, enabled=1
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x1a [Pin Complex] wcaps 0x40048b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000024: IN Detect
>   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x1d [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x0001001c: OUT HP EAPD Detect
>   EAPD 0x2: EAPD
>   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x22
> Node 0x1e [Pin Complex] wcaps 0x40048b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000024: IN Detect
>   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x1f [Pin Complex] wcaps 0x40040b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000020: IN
>   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x20 [Audio Output] wcaps 0x611: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   IEC Coding Type: 0x0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x5]: PCM AC3
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x21 [Pin Complex] wcaps 0x400701: Stereo Digital
>   Pincap 0x00000010: OUT
>   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x20
> Node 0x22 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
>   Control: name="Bass Speaker Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Bass Speaker Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
>   Amp-Out vals:  [0x4a 0x4a]
>   Converter: stream=0, channel=0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x23 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
>   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
>   Amp-Out vals:  [0x4a 0x4a]
>   Converter: stream=0, channel=0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x24 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
>   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
>   Amp-In vals:  [0x4a 0x4a]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x1e
> Node 0x25 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
>   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
>   Amp-In vals:  [0x4a 0x4a]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x540]: 48000 96000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x27
> Node 0x26 [Pin Complex] wcaps 0x400501: Stereo
>   Pincap 0x00010010: OUT EAPD
>   EAPD 0x2: EAPD
>   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x23
> Node 0x27 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000020: IN
>   Pin Default 0x40f001f0: [N/A] Other at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
> Node 0x28 [Vendor Defined Widget] wcaps 0xf00000: Mono
> 68:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 63)
> 	Subsystem: Emdoor Digital Technology Co., Ltd Raven/Raven2/FireFlight/Renoir Audio Processor [2782:12c3]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 111
> 	IOMMU group: 27
> 	Region 0: Memory at dc580000 (32-bit, non-prefetchable) [size=256K]
> 	Region 2: Memory at 7f10000000 (64-bit, prefetchable) [size=8M]
> 	Capabilities: [48] Vendor Specific Information: Len=08 <?>
> 	Capabilities: [50] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [64] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 256 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
> 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 16GT/s (ok), Width x16 (ok)
> 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
> 			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
> 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> 			 FRS- TPHComp- ExtTPHComp-
> 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
> 			 AtomicOpsCtl: ReqEn-
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
> 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> 	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
> 	Capabilities: [2a0 v1] Access Control Services
> 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
> 	Kernel driver in use: snd_pci_ps
> 	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x, snd_pci_acp6x, snd_acp_pci, snd_rpl_pci_acp6x, snd_pci_ps, snd_sof_amd_renoir, snd_sof_amd_rembrandt, snd_sof_amd_vangogh, snd_sof_amd_acp63
> 

