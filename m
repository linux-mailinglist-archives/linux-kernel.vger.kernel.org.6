Return-Path: <linux-kernel+bounces-248842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898E92E297
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B29B21F96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6964152178;
	Thu, 11 Jul 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAjUYCn5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E412D1E9;
	Thu, 11 Jul 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687311; cv=none; b=UGeDnGiwF3KwM/DNlSDak2QBjt/A4/FUqLdzMj2LYMFNjA7jvMXrB5S3wHa2AmNMbyQ8nWYQYhG3XlB+Bqp7aK1WqhzQdYuPlPvTq665zE+7o8Bv1BWI3dbsO/uy6h5ggEZXH9Dg+o1husYERBMK0kZrYmBwZ7jQZogIvdxII7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687311; c=relaxed/simple;
	bh=8TeAmHSOHfrhxxuafFc3tzdvy3GGVjcQIxB7dVt1X6o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VldHrc2Bs9c2XXlh+494HIpm4yf2CS2+gneeZ1rQRygDNNrEv9McCnCgjSNCeGHE2H+Kzkil/JEJ751p9FNRdW2XbSuFP1Y4kgkioBUOviTVLrprcdFEcCWlkU4cM38zGcWtc0pJKxOpaAc4aytzU+wYVFAnFZ5flKCTkv9qdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAjUYCn5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720687309; x=1752223309;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8TeAmHSOHfrhxxuafFc3tzdvy3GGVjcQIxB7dVt1X6o=;
  b=QAjUYCn5msBBLLTmbt8h1WBTOGTYvKuUXoM3LOJs5wIlik8kGhDWjHqm
   b2bqCOEvPYRJMmRMLYO8CJnCV9cGJwrBD8v93GujLnGda2COGjTQGR6Sf
   MvQC5D3RhY9KlAfO/Qt39rNRPr905LjFe4UqQ+cZbvhikYN+ffzrTy3/L
   IzAzSCpFTFfzIttZv1PIhpx31YhXiGUzx9mbqKfiaW9/c6B7Zltg70ewu
   2oah1S9CBHjLrgt08VNdajQqF7opHBODHOW8Qx0UbQFdzRfC5vJirIqrj
   GkOTOwKTdyaLojGO/qDMBuGLqlkSoZ37zEVDuuySpjDN7nEwzXBszyIoI
   w==;
X-CSE-ConnectionGUID: G+v4WgI3QF2Wlh8oZlRB+Q==
X-CSE-MsgGUID: AmyOX0/CQHiKFI5Gpz4McA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17665860"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="17665860"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:41:49 -0700
X-CSE-ConnectionGUID: eA1KWiGyR6+0lhr+lnLWRA==
X-CSE-MsgGUID: Cnt29IZURIWvdp6HBN0h6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48560936"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:41:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 11:41:43 +0300 (EEST)
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] HP: wmi: added support for 4 zone keyboard rgb
In-Reply-To: <20240707175613.27529-2-carlosmiguelferreira.2003@gmail.com>
Message-ID: <71874c5e-b6d0-d05c-3b07-d1add491dbb6@linux.intel.com>
References: <20240707175613.27529-1-carlosmiguelferreira.2003@gmail.com> <20240707175613.27529-2-carlosmiguelferreira.2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 7 Jul 2024, Carlos Ferreira wrote:

> This driver adds supports for 4 zone keyboard rgb on omen laptops
> and maps the wmi backlight toggle event to KEY_KBDILLUMTOGGLE.
> For the backlight, it uses the multicolor led api.
> 
> Tested on the HP Omen 15-en1001np.
> 
> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
> ---
> Changes in v3:
>  - Moved to the multicolor led api
>  - Mapped the wmi backlight toggle event to KEY_KBDILLUMTOGGLE
>  - Some other minor changes
> Changes in v2:
>  - Rearranged code to remove forward declarations
>  - Changed from sprintf() to sysfs_emit()
>  - Fixed some identation and coding style problems
>  - Switched from manual bit manipulation to GENMASK(x, y) + FIELD_PREP(XX, )
>  - #define'ed magic constants
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 248 +++++++++++++++++++++++++++++--
>  1 file changed, 239 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 5fa553023842..5eae47961f76 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -14,6 +14,8 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -24,6 +26,7 @@
>  #include <linux/platform_profile.h>
>  #include <linux/hwmon.h>
>  #include <linux/acpi.h>
> +#include <linux/bits.h>

You need to add #include <linux/bitfield.h> as LKP found out. The 
MODULE_DESCRIPTION() ones you can ignore as LKP unfortunately spams some 
kernel-wide problems to all patches even if they're entirely unrelated
to the patch in question.

> +	for (size_t i = 0; i < 4; i++)
> +		fourzone_leds.leds[i].led_cdev.brightness = br;

> +	for (int i = 0; i < 4; i++) {
> +		colors[i] = FIELD_PREP(FOURZONE_COLOR_R, buff[25 + i * 3])
> +			  | FIELD_PREP(FOURZONE_COLOR_G, buff[25 + i * 3 + 1])
> +			  | FIELD_PREP(FOURZONE_COLOR_B, buff[25 + i * 3 + 2]);

The loop variables are not particularly consistent... I'd prefer them to 
be declared in the normal function variable declaration block.

> +
> +	for (size_t i = 0; i < 4; i++)
> +		if (strcmp(led_cdev->name, fourzone_zone_names[i]) == 0)

!strcmp()

> +	ret = fourzone_get_colors(colors);
> +	if (ret < 0)
> +		return ret;
> +
> +	memcpy(fourzone_leds.color_cache, colors, sizeof(colors));
> +
> +	brightness = get_fourzone_brightness(NULL);
> +
> +	for (size_t i = 0; i < 4; i++) {
> +		fourzone_leds.subleds[i] = (struct mc_subled) {
> +			.color_index = LED_COLOR_ID_RGB,
> +			.brightness = 1,
> +			.intensity = colors[i]

Please add comma to the last line because if this is ever extended, this 
line doesn't need to be touched.

> +		};
> +
> +		fourzone_leds.leds[i] = (struct led_classdev_mc) {
> +			.led_cdev = {
> +				.name = fourzone_zone_names[i],
> +				.brightness = brightness,
> +				.max_brightness = 1,
> +				.brightness_set = set_fourzone_brightness,
> +				.brightness_get = get_fourzone_brightness,
> +				.color = LED_COLOR_ID_RGB,
> +				.flags = LED_BRIGHT_HW_CHANGED

Ditto.

> +			},
> +			.num_colors = 1,
> +			.subled_info = &fourzone_leds.subleds[i]

Ditto.

> +	return 0;
> +}
> +
> +static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void)
> +{
> +	u8 buff[128];
> +	int ret;
> +
> +	ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM,
> +		&buff, sizeof(buff), sizeof(buff));

Align the continuation of parameters to the opening (.

> +	if (ret != 0)
> +		return HPWMI_KEYBOARD_INVALID;
> +
> +	/* the first byte in the response represents the keyboard type */
> +	return (enum hp_wmi_keyboardtype)(buff[0] + 1);
> +}
> +
> +static bool fourzone_supports_lighting(void)
> +{
> +	u8 buff[128];
> +	int ret;
> +
> +	ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE,
> +		&buff, sizeof(buff), sizeof(buff));

Ditto.

I probably missed a few similar cases as mentioned above so please go 
through your patch and correct them all.

I'm left unsure if a mutex would be necessary to protect the brightness
updates. Probably.


Hans might have more to say about the approach.


-- 
 i.


