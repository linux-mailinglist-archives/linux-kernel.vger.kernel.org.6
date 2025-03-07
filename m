Return-Path: <linux-kernel+bounces-551703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA3BA56FAC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F517850F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE9241698;
	Fri,  7 Mar 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Dz4WIbwl"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240923E227;
	Fri,  7 Mar 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369987; cv=none; b=J/7V9zXtGWb52onr3YmvGx0WXKi3ohpeRZwBTaY8ltsQp3Sk7gpctWrfiVkQuzXeeovveNcL9EuMAe7NLKmOzuNY2rfk/jVX+lR4KrDjosKF6aWUUBAIpYdGZYT11pBoE6yaiJxgYTqU76UCVMYq9hVBF7jHbHR5eJujO17Hd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369987; c=relaxed/simple;
	bh=dqJJda4JvW0gEseJ0YzOFrzFR1CvMUBmSU/PFWYCSkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgIe9tqzo4NUMo4rTnL7X+1enZLwxv5h9P1EyPo8i08o/xIY7Qpz/YaDhttA4Q9waHlkIlkPjkiWrDAEISwxoY7Y4uNQy7SMqBjG8wSI1YhImlNL76Fo2Vw7WV89QkGM9od4oqBF+paekD2Wp0LABJKssqrx5Sf8l7zxYLSVt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Dz4WIbwl; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59f4f.dip0.t-ipconnect.de [217.229.159.79])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 8AD8D2FC0048;
	Fri,  7 Mar 2025 18:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741369974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh3OB9skzi/WGY4x4LThkGtwcku529pZ78r4jtQTrTQ=;
	b=Dz4WIbwlhwOHtN1yJORmGYCnz1KLkiAiIUBgQtWwlX8SwWtoObco00HDCrLiLwuRmbah1O
	vKtnlGMmQaqBFsMGni8+s+s+xUXdgFNw512LBXw8TMhBRvuHuR34ZEpqUBrObE45wbe214
	KeLNlX3yVHsE+xgpo+Seia1s5ze4DBM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <2936f99d-0211-41de-976e-1a5631f62414@tuxedocomputers.com>
Date: Fri, 7 Mar 2025 18:52:54 +0100
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
Coming back to this: this doesn't work because hwdb handles keycodes, but the 
message in dmesg is produces because the scancode is not mapped to any keycode 
by default (it is mapped to 0 in atkbd.c).
>
> Regards,
>
> Hans
>
>

