Return-Path: <linux-kernel+bounces-350094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B998FFAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D3F1C20AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B170146D78;
	Fri,  4 Oct 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b="TRWObgKF"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09A146A7B;
	Fri,  4 Oct 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033939; cv=none; b=V/7DjQd46itL7Qnz3Q44zKXPOLcnlvmETd6jLDYTHJxDy4amxGNTG1AiyDvUKtkC9ixAi4IYhA11lOi6v/1/EcvECwh7RVKmzR03sP5azgWPtdMQMQDkSnFu/sfBHdI86NExnH4NTuPycYPjkTfYU9WwQ+zlWEaLGlt5z31RvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033939; c=relaxed/simple;
	bh=645ko5croWnHBkUGstpACowgWBQjdeIjQ+SqtTQUsw8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RSdZ5XuDya26PmJ9QPsWSM/7wcMWDw1Vfycl5JGZMiY+DBzL9Y7AWlaq1ycOYs+ogy+JZW7HSCV9pTYXckK+y73OKDyn7gM+CliweElkNBwUjDj7bay3J15QfbeCLSbSc8lJ48wIFAHZTBSKCFy7kGHIYPU6XLJyrEVMD+E1jAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de; spf=pass smtp.mailfrom=tuxedo.de; dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b=TRWObgKF; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedo.de
Received: from mail.tuxedocomputers.com (localhost [IPv6:::1])
	(Authenticated sender: cs@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id B3B282FC0064;
	Fri,  4 Oct 2024 11:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedo.de; s=default;
	t=1728033932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHHUyfkGOAubihwR899hP5kwPoySVKzIJzeKuYqsakw=;
	b=TRWObgKF6O1D+Av1P8K05+348lRJOF3M5TS4AanMWZV17D2h8ZTV4qdi3v6vx8sw8yy3NT
	uFHXHB1JWV1ReyPfYSG0Z5awvfCnpg3qIVT6ocmKKluCiHjztlXx8nOkdFrWGiH65bEYai
	Oam4zax1jV4pQNP7i7YeIjYiou9d0/gFY7lN7SNuJcB0DL5KqTrawwnI1Y2pESI8J8ieTM
	QY4cDo8ttdphgQrdIzskFbxiuKOTFxDoD5n4Gy67k5U1i3lxRaiYZeuWOmCpYwdC49DBBB
	onSsVkFQcJsKiN4aBevu2EK1cRZmxxQTS+NVrw+YGLZoMu5266h3q9FqPLMjqw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Oct 2024 11:25:32 +0200
From: Christoffer Sandberg <cs@tuxedo.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jerry Luo <jerryluo225@gmail.com>, christian@heusel.eu,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz,
 regressions@lists.linux.dev, wse@tuxedocomputers.com
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <87iku8mfzh.wl-tiwai@suse.de>
References: <87jzfbh5tu.wl-tiwai@suse.de>
 <ea6e5168-238f-41f5-9600-36b75ed990a1@gmail.com>
 <87jzetk2l0.wl-tiwai@suse.de> <b38b5947482a5ca4b55e0ddb908c2f34@tuxedo.de>
 <87seteli51.wl-tiwai@suse.de>
 <d348ca06-38ca-474f-8673-dff2248331e5@gmail.com>
 <dbc783cc2608ac63ffd420b1dc3eeaa9@tuxedo.de> <87iku8mfzh.wl-tiwai@suse.de>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <8292a0dccbdcfcaebfb04bd84aa240e6@tuxedo.de>
X-Sender: cs@tuxedo.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit



On 4.10.2024 10:25, Takashi Iwai wrote:
> On Fri, 04 Oct 2024 10:18:10 +0200,
> Christoffer Sandberg wrote:
>> 
>> 
>> 
>> On 2.10.2024 23:28, Jerry Luo wrote:
>> > On 10/2/24 10:00 AM, Takashi Iwai wrote:
>> >> On Wed, 02 Oct 2024 10:21:22 +0200,
>> >> Christoffer Sandberg wrote:
>> >>>
>> >>>
>> >>> On 30.9.2024 09:44, Takashi Iwai wrote:
>> >>>> On Mon, 23 Sep 2024 21:37:42 +0200,
>> >>>> Jerry Luo wrote:
>> >>>>>
>> >>>>> Hi Takashi,
>> >>>>>
>> >>>>> On Mon, 16 Sep 2024 19:22:05 +0200,
>> >>>>>
>> >>>>> Takashi Iwai wrote:
>> >>>>>
>> >>>>>      Could you give alsa-info.sh output from both working and
>> >>>>> non-working
>> >>>>>      cases?  Run the script with --no-upload option and attach the
>> >>>>> outputs.
>> >>>>>
>> >>>>>      thanks,
>> >>>>>
>> >>>>>      Takashi
>> >>>>>
>> >>>>> Issue now reappear, output from alsa-info.sh are attached. If they
>> >>>>> are still
>> >>>>> needed.
>> >>>> Thanks.  The obvious difference seems to be the assignment of two
>> >>>> DACs
>> >>>> 0x10 and 0x11 for headphone and speaker outputs.
>> >>>>
>> >>>> Christoffer, how are those on your machines?
>> >>> I attached alsa-info from the Sirius Gen2 device.
>> >>>
>> >>> Comparing the working/nonworking of Jerry, yeah, the assignment of
>> >>> 0x10 and 0x11 looks switched around. I don't see what difference this
>> >>> would make. Also, node 0x22 has "bass speaker" controls in the
>> >>> non-working version.
>> >>>
>> >>> Comparing the Sirius Gen2 alsa-info with Jerrys, to me it looks like
>> >>> the non-working version corresponds to our working version.
>> >>>
>> >>> I would expect the non-working version to happen all the time though
>> >>> with regards to the "bass speaker" controls. Why would this only
>> >>> happen sometimes?
>> >> Thanks!  The assignment of DACs depend on the pins and topology, so it
>> >> can be a bit sensitive.
>> >>
>> >> Now looking more closely at both outputs, I wonder how the commit
>> >> breaks pang14.  Maybe it has a PCI SSID 2782:12c5 (or 12c3) while the
>> >> codec SSID is 2782:12b3?  If so, the patch below should fix.
>> 
>> Interesting, you're right, PCI SSID c3/c5 and codec SSID c3/c5 for the
>> Siriuses.
>> 
>> I had a look around. In patch_realtek there are some cases where codec
>> SSID match is needed as well. Would it be better/safer to directly do
>> this immediately or keep it as an exception where it breaks or for
>> known sensitive models/brands?
> 
> It needs a better handling, yes.  OTOH, the driver became gigantic and
> it's very tough to change the basic matching stuff.  That is, we can't
> flip from PCI SSID to codec SSID out of sudden, as it'll break
> certainly many other systems.
> 
> What I have in mind is to add an extra flag to the matching table to
> indicate the codec SSID matching, something like:
> 
> --- a/sound/pci/hda/hda_local.h
> +++ b/sound/pci/hda/hda_local.h
> @@ -282,6 +282,7 @@ struct hda_fixup {
>  	int type;
>  	bool chained:1;		/* call the chained fixup(s) after this */
>  	bool chained_before:1;	/* call the chained fixup(s) before this */
> +	bool match_codec_ssid:1; /* match with codec SSID instead of PCI SSID 
> */
>  	int chain_id;
>  	union {
>  		const struct hda_pintbl *pins;
> 

Sounds reasonable to me. It would mean either-or then though.

> Although this will help in this case, many of existing code do check
> codec ID in addition to PCI SSID, and this flag won't help for them as
> is.

For the fixups where codec SSID is already known for all cases it would 
be possible to represent current logic with matching both SSIDs.

Otherwise I can not judge whether matching both PCI SSID and codec SSID 
at the same time would be needed.

In any case, your approach would reduce code size if this is a recurring 
thing.

