Return-Path: <linux-kernel+bounces-547162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D93A503A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A757A4A24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160E52505A2;
	Wed,  5 Mar 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="J0zzfvDz"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169B24EF93;
	Wed,  5 Mar 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189287; cv=none; b=Gxqy5Lmv9Loyrf4VVxytwflP7doGPCGnieKXYr2zLoj1QPqYbqBdbDhKx0Z3Gaz7n9+sTDhc2/g5W/Om67khX9vP2BTmMr7JP/Q03IYlpHb4m6a6ciuxV0zNL37Xp0jkbJe95Kigbm85CGACukXcJt+vHrqw4/ihQIUOTLEeTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189287; c=relaxed/simple;
	bh=QVXzwZI8QWLrdadVm4OsCG7KScMpWF/+/XAQqckZiuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSxhOqdd4g7aofCZWyxxY3FqMG1dwjBJmObsMU4+hsa9MCrIzURlLGUwl/iIQzyP/JjHRI01IrDQFF/SJPTMnts+N+SyUkxMcg9TjGjy8wuHOC5P5J7B6P0ytqdxfjjvTS8WFUfr2UE6hpJDbJIKwK4Rx/9cumrx/EOb7ENIr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=J0zzfvDz; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59f4f.dip0.t-ipconnect.de [217.229.159.79])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 1CE292FC0048;
	Wed,  5 Mar 2025 16:41:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741189280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6jhBJij2I0NQYatN7vveyLTqhAJA3pvmCwSTqgjABM=;
	b=J0zzfvDztdNy1xOMu03BiXaC1w6+qiiCbs5TtGhM3Dz6kHkti9xU5L9H79iDPCHCFySqK+
	yqpzdveeDGd87ytaU1wYNWsSjDX8w1uaa47TSi2CbsMD3CeRsOLziaaOr9UH2SaflckXmn
	8+VUP8stD8nPpJJnIboGOi6CLdH4ZVM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <e6f5234c-98ab-4a06-aa1a-59726f395ea4@tuxedocomputers.com>
Date: Wed, 5 Mar 2025 16:41:19 +0100
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
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250303190442.551961-1-wse@tuxedocomputers.com>
 <20250303190442.551961-2-wse@tuxedocomputers.com>
 <1bee0a62-058b-482a-8eec-d45b8aca1614@redhat.com>
 <d74c348d-474a-4871-8b94-d836e8d054e8@tuxedocomputers.com>
 <1fbdfe7f-0f25-4de0-805c-b712663f7681@redhat.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <1fbdfe7f-0f25-4de0-805c-b712663f7681@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hans,

Am 05.03.25 um 15:18 schrieb Hans de Goede:
> Hi Werner,
>
> On 5-Mar-25 1:07 PM, Werner Sembach wrote:
>> Am 05.03.25 um 12:25 schrieb Hans de Goede:
>>> Hi Werner,
>>>
>>> On 3-Mar-25 8:04 PM, Werner Sembach wrote:
>>>> This small driver does 2 things:
>>>>
>>>> It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku to
>>>> F21 to conform with established userspace defaults. Note that the
>>>> Hangaku/Zenkaku scancode used here is usually unused, with real
>>>> Hangaku/Zenkaku keys using the tilde scancode.
>>> So this control + super + scancode 0x76 sending is also seen on
>>> quite a few other laptops and I think we need a generic fix for this.
>>>
>>> I recently noticed that KDE's keyboard-shortcut settings actually has
>>> a  control + super + Hangaku/Zenkaku -> touchpad-toggle key binding
>>> in its default bindings (IIRC). But that cannot work because xkb actually
>>> has no mapping for evdev code 85 / KEY_ZENKAKUHANKAKU if you look in:
>>>
>>> /usr/share/X11/xkb/keycodes/evdev and then look for 93 (*) you will
>>> find no mapping. I think this KDE default binding may be from a long
>>> time ago when this did work. Or maybe KDE uses the FOO part of KEY_FOO
>>> as symbolic when there is no xkb mapping ?
>> It does not work on X11, but it does work on Wayland (there xev also sees the Zenkaku/Hankaku keypress). Don't ask me why.
> Interesting, so in xev under Wayland you see something like this
> on release:
>
>      state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
>
> With there actually being a keysym of "Zenkaku_Hankaku" there ?

No. Sorry I got it a little bit wrong above, I didn't know it exactly anymore 
and had to retest:


With the keyboard shortcut deactivated, xev on wayland shows this:

KeyPress event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 246681, (83,3), root:(1273,701),
     state 0x0, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
     XLookupString gives 0 bytes:
     XmbLookupString gives 0 bytes:
     XFilterEvent returns: False

KeyPress event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 246682, (83,3), root:(1273,701),
     state 0x40, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
     XLookupString gives 0 bytes:
     XmbLookupString gives 0 bytes:
     XFilterEvent returns: False

KeyPress event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 246686, (83,3), root:(1273,701),
     state 0x44, keycode 93 (keysym 0x0, NoSymbol), same_screen YES,
     XLookupString gives 0 bytes:
     XmbLookupString gives 0 bytes:
     XFilterEvent returns: False

KeyRelease event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 246690, (83,3), root:(1273,701),
     state 0x44, keycode 93 (keysym 0x0, NoSymbol), same_screen YES,
     XLookupString gives 0 bytes:
     XFilterEvent returns: False

KeyRelease event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 246696, (83,3), root:(1273,701),
     state 0x44, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
     XLookupString gives 0 bytes:
     XFilterEvent returns: False

KeyRelease event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 246703, (83,3), root:(1273,701),
     state 0x40, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
     XLookupString gives 0 bytes:
     XFilterEvent returns: False


With the shortcut active, xev on wayland shows this (and the shortcut works):

KeyPress event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 365034, (83,3), root:(1273,701),
     state 0x0, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
     XLookupString gives 0 bytes:
     XmbLookupString gives 0 bytes:
     XFilterEvent returns: False

KeyPress event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 365036, (83,3), root:(1273,701),
     state 0x40, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
     XLookupString gives 0 bytes:
     XmbLookupString gives 0 bytes:
     XFilterEvent returns: False

KeyRelease event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 365060, (83,3), root:(1273,701),
     state 0x44, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
     XLookupString gives 0 bytes:
     XFilterEvent returns: False

KeyRelease event, serial 39, synthetic NO, window 0x1200001,
     root 0x4f7, subw 0x0, time 365060, (83,3), root:(1273,701),
     state 0x40, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
     XLookupString gives 0 bytes:
     XFilterEvent returns: False

>
> Because that is not working on Wayland on my laptop with the same
> issue (after disabling the hwdb mapping) and I don't understand
> how that could work at all given that /usr/share/X11/xkb/keycodes/evdev
> has no mapping for EV keycode 85 (93 in that file) ?
>
>> Also: Other DEs don't have this binding.
> Yes that is an issue, but see below.
>
>>> *) 85 + 8 all codes there are shifted up 8 compared to the KEY_FOO
>>> defines because codes 0-7 are reserved for modifier.
>>>
>>> I hit the same issue years ago on "T-boa Tbook air" laptop and
>>> their I fixed this by mapping Hangaku/Zenkaku -> f21 in
>>> /lib/udev/hwdb.d/60-keyboard.hwdb :
>>>
>>> ###########################################################
>>> # T-bao
>>> ###########################################################
>>>
>>> evdev:atkbd:dmi:bvn*:bvr*:bd*:svnT-bao:pnTbookair:*
>>>    KEYBOARD_KEY_76=f21                                    # Touchpad toggle
>>>
>>> + teaching GNOME to also accept Ctrl + Super + XF86TouchpadToggle
>>> as touchpad-toggle:
>>>
>>> https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/data/org.gnome.settings-daemon.plugins.media-keys.gschema.xml.in?ref_type=heads#L577
>> Yeah KDE would need a similar fix and other DEs probably too. I hoped for a generic fix that does not need adjustments in so many projects.
>>
>> My first try was to do it on the XKB level but on Wayland the RedirectKey action is not implemented https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/merge_requests/794#note_2803713 (and probably wont be even in the future https://github.com/xkbcommon/libxkbcommon/issues/18#issuecomment-72728366) so I can't "unpress" control and super.
>>
>> If it is a more general issue, why not fix it on a more general level in the kernel? Maybe a generic filter applyable via a command line quirk and/or a quirk list?
> The problem is that filtering keys with modifiers like you are doing
> here just does not work.
>
> Your filter is seriously messing with the timing of the keypresses
> which can be a real issue when not actually using the toggle touchpad
> hotkey.
>
> Lets say the user is playing a game and has mapped super to
> one of the fire buttons and is using an in game weapon with
> some sort of auto-repeat firing.
>
> And your seqpos variable likely is 0 when super gets pressed,
> now the keyboard sends 0xe0, 0x5b which your filter filters
> out, and the user keeps super pressed because they expect
> the weapon to start firing on auto-repeat. But the super
> press is never send until super is released or another key
> is pressed so things don't work.
>
> Likewise if the DE, an app or accessibility settings want to
> differentiate between a short and a long super press all
> presses now become super (pun not intended) short because
> you insert the press directly in front of the release, losing
> any timing information about how long the key was pressed.
>
> This is why using an i8042 filter for filtering key-combinations
> (and the EC emulates a key-combination here) can never work reliably.
Ok, thought I had a clean solution, but doesn't seems so xD.
>
> OTOH desktop environments already allow having Ctrl+Super+something
> keybindings for DE actions. So we can re-use the tried and trusted
> modifier handling in the DE to deal with combi part leaving just
> the issue of mapping PS/2 scancode 0x76 aka evdev code
> 85 / KEY_ZENKAKUHANKAKU to something usable by the DE.
>
> ATM both GNOME and KDE already have support for
> Ctrl+Super+something for touchpad-toggle except that KDE expects
> a "Zenkaku_Hankaku" keysym where as GNOME expects "XF86TouchpadToggle"
> arguably the GNOME solution is slightly better because Japanese
> keyboard layouts already use/send the "Zenkaku_Hankaku" keysym
> unrelated to touchpad-toggle use. And I don't know what happens
> when pressing ctrl+super+Zenkaku_Hankaku while using a Japanese
> layout.
When I interpret the xkb-config correctly, JIS keyboards use the tilde 
scancode/keycode for the physical zenkaku/hankaku keys, at least in the default 
config HZTG (henkaku/zankaku toggle) is aliased to TLDE
>
> I think maybe we just need to patch atkbd.c at the kernel to
> map scancode 0x76 -> KEY_TOUCHPAD_TOGGLE since normal PS/2
> keyboards never generate 0x76, this would lose the mapping to
> KEY_ZENKAKUHANKAKU but since /usr/share/X11/xkb/keycodes/evdev
> does not even map KEY_ZENKAKUHANKAKU I don't think loosing that
> mapping will do a big deal.

At least from kernel side this would be a very small patch, are there any 
objections to it?

If not I make a patch for it and create a KDE issue.

>
> So I think that going with the evdev mapping + teaching KDE
> that Ctrl+Super+XF86TouchpadToggle is just XF86TouchpadToggle
> is the best way forward to solve this once and for all.
>
>>>> It suppresses the reserved scancode produced by pressing the FN-key on its
>>>> own, which fixes a warning spamming the dmesg log otherwise.
>>> Can you not also suppress this by mapping the key to "unknown" in hwdb?
>> Maybe, I didn't try. Was convenient to just do it here since I already had the filter. Will look into it once it is decided what to do with the touchpad toggle issue.
> Please give using hwdb for this a try.

kk will do later

Best regards,

Werner

>
> Regards,
>
> Hans
>
>

