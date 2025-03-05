Return-Path: <linux-kernel+bounces-546744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12AEA4FE3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD95170FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592B24291C;
	Wed,  5 Mar 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="CaFkGyFD"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C542242915;
	Wed,  5 Mar 2025 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176444; cv=none; b=thoPU/r+L8BDu45zC1mb/n4krc1scouOzbuY3HyudkUMJki7O6E2+bvJ6LERMJ3ThR8CEh86lG6kMxPTWWK6qR2xIra47b+dZzyrMZ3We0Iq/b2iqZX2MZ7AcFmxtKE3e1k5rJnIhUgkOoYdIucvY3XAxCa8zgTCS0Rug5wPJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176444; c=relaxed/simple;
	bh=fNQFlRxVUsB/mQXiMmN1dBCOvVLzzc20XOwjCotvWb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3OjBsfFQu5XgYMjsHKNAu5IakDJUgTvas/9gahEeFdBj3/WpUA+OkbVMzDkBLeURMZo9TwmBON0fO3YioEOn06+F6m+GOYfiVJNteagb40BA1Vi4oJGG287PPtLRqauBJHYy0YYihXTljt65eRgDEDugGLXYXMigFrHTwVPhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=CaFkGyFD; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59f4f.dip0.t-ipconnect.de [217.229.159.79])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id A02FB2FC0048;
	Wed,  5 Mar 2025 13:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741176438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqjf2YehbblSrh0fNr1izRi09IVA6aE1MgHJhXJgmRg=;
	b=CaFkGyFDE9oGOv+8LohPVs2y4tECRJdnuKFCf8vuDFinliCZL9WJzdFec31sAo57WYDwq9
	M6VR9TXQih2Lt/kwiniLOkDVG8WzIXS3nK1Jf2Fg+ujDipsKszPjpSFPtb7en3X+qJ1fZU
	vEDq3y9a5fLiqRnHVkC/7ZT8Lw7But4=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <d74c348d-474a-4871-8b94-d836e8d054e8@tuxedocomputers.com>
Date: Wed, 5 Mar 2025 13:07:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 FN-keys
To: Hans de Goede <hdegoede@redhat.com>, mario.limonciello@amd.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250303190442.551961-1-wse@tuxedocomputers.com>
 <20250303190442.551961-2-wse@tuxedocomputers.com>
 <1bee0a62-058b-482a-8eec-d45b8aca1614@redhat.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <1bee0a62-058b-482a-8eec-d45b8aca1614@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 05.03.25 um 12:25 schrieb Hans de Goede:
> Hi Werner,
>
> On 3-Mar-25 8:04 PM, Werner Sembach wrote:
>> This small driver does 2 things:
>>
>> It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku to
>> F21 to conform with established userspace defaults. Note that the
>> Hangaku/Zenkaku scancode used here is usually unused, with real
>> Hangaku/Zenkaku keys using the tilde scancode.
> So this control + super + scancode 0x76 sending is also seen on
> quite a few other laptops and I think we need a generic fix for this.
>
> I recently noticed that KDE's keyboard-shortcut settings actually has
> a  control + super + Hangaku/Zenkaku -> touchpad-toggle key binding
> in its default bindings (IIRC). But that cannot work because xkb actually
> has no mapping for evdev code 85 / KEY_ZENKAKUHANKAKU if you look in:
>
> /usr/share/X11/xkb/keycodes/evdev and then look for 93 (*) you will
> find no mapping. I think this KDE default binding may be from a long
> time ago when this did work. Or maybe KDE uses the FOO part of KEY_FOO
> as symbolic when there is no xkb mapping ?

It does not work on X11, but it does work on Wayland (there xev also sees the 
Zenkaku/Hankaku keypress). Don't ask me why.

Also: Other DEs don't have this binding.

>
> *) 85 + 8 all codes there are shifted up 8 compared to the KEY_FOO
> defines because codes 0-7 are reserved for modifier.
>
> I hit the same issue years ago on "T-boa Tbook air" laptop and
> their I fixed this by mapping Hangaku/Zenkaku -> f21 in
> /lib/udev/hwdb.d/60-keyboard.hwdb :
>
> ###########################################################
> # T-bao
> ###########################################################
>
> evdev:atkbd:dmi:bvn*:bvr*:bd*:svnT-bao:pnTbookair:*
>   KEYBOARD_KEY_76=f21                                    # Touchpad toggle
>
> + teaching GNOME to also accept Ctrl + Super + XF86TouchpadToggle
> as touchpad-toggle:
>
> https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/data/org.gnome.settings-daemon.plugins.media-keys.gschema.xml.in?ref_type=heads#L577

Yeah KDE would need a similar fix and other DEs probably too. I hoped for a 
generic fix that does not need adjustments in so many projects.

My first try was to do it on the XKB level but on Wayland the RedirectKey action 
is not implemented 
https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/merge_requests/794#note_2803713 
(and probably wont be even in the future 
https://github.com/xkbcommon/libxkbcommon/issues/18#issuecomment-72728366) so I 
can't "unpress" control and super.

If it is a more general issue, why not fix it on a more general level in the 
kernel? Maybe a generic filter applyable via a command line quirk and/or a quirk 
list?

>
> Notice that system76 has the same hwdb key mapping for their
> Pangolin 12 model which I presume also has something like e.g.
> a clevo as base model.
>
> So for now to fix the touchpad on this TUXEDO NB02 you should
> simply add a hwdb entry like the above entries.
>
> Longer term I think the right fix for the touchpad toggle for
> all laptops which do this would be to make GNOME do what KDE does
> and change the touchpad-toggle-static keybinding list which
> currently is:
>
> ['XF86TouchpadToggle', '<Ctrl><Super>XF86TouchpadToggle']
>
> to:
>
> ['XF86TouchpadToggle', '<Ctrl><Super>XF86TouchpadToggle', '<Ctrl><Super>"Something"']
>
> Where "Something" would then be the new mapping. Or maybe just teach
> atkbd or xkb or hwdb to map scancode 0x76 to TouchpadToggle by
> default then at least in GNOME this will work OOTB and for KDE
> a default binding of '<Ctrl><Super>XF86TouchpadToggle'] -> touchpad-toggle
> should probably be added there.
>
>> It suppresses the reserved scancode produced by pressing the FN-key on its
>> own, which fixes a warning spamming the dmesg log otherwise.
> Can you not also suppress this by mapping the key to "unknown" in hwdb?
Maybe, I didn't try. Was convenient to just do it here since I already had the 
filter. Will look into it once it is decided what to do with the touchpad toggle 
issue.
>
> Regards,
>
> Hans
>
>

