Return-Path: <linux-kernel+bounces-266046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE41293F9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E0F1C22069
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442C548E0;
	Mon, 29 Jul 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyxWbvsX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E84A0A;
	Mon, 29 Jul 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267917; cv=none; b=usmmjr8FSHpv4oGnY5bY4t9Fu0Lp2H0nSkRbPjkb1pcXFHoROTvcvViULKBxGjgzc0/41Z8o8G3ejPsiLDb/a+SdLqBGgsrU2zM0AyFPNY2y8lyC740/FVjTkoy/3QxrkckiJcwPbU1Ypv7EdfnFCmyNMq4kHJBl9HneV3+Btp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267917; c=relaxed/simple;
	bh=mTwQvXUjB6+WMpCUj/sfA9/wJwChqp256MJxGC6rRM0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lCc6+zfXpCKilmx20yETT1D1HKx1N3bvPATJBpnkNfzqddT5DyG5thJvLHVy0dlHzgpU/2IS9TgK07Re3qgDJJ6NTL3ROuWz0oT1dQ8xNT/YHseR2AWHVQgApkk8jZOf0TvVgsiN7oHYCHKHMv76hSmaRTI/W414Tq2klwRjkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyxWbvsX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722267916; x=1753803916;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mTwQvXUjB6+WMpCUj/sfA9/wJwChqp256MJxGC6rRM0=;
  b=dyxWbvsXz1inlVYlfkSTmQ+WcC5cfQNRMQaPXD6VU/Unc8dfTJKY9Yg5
   DNLWVljSXwxhyhb20O0Lcw8d8iXLsq60bqIzEbWos+G6bvcmB6BRSed2R
   juh5WAShUyU9UGPgMK2yVMk6NhhSCNxX0MtoBM3C6+sERv7PxJrnJRo02
   73C8UNfYZVwYe6Ro8zI1vj+Uk3G3U16EGI0Eic7FwMT0JDIXOebVNkt/e
   UoaKCf+RxHU/VEiYGYTHA+9f+Y0KrsMxYEaFiYhmpnl/JrpNPsRV8QEo8
   KKItf35nTNEYU7gmnwSsueZUJnu3z67evApaeR0sVzD90kBPl/E0UTqKT
   g==;
X-CSE-ConnectionGUID: 4Qixp7CkQSO66aA5b0nTZQ==
X-CSE-MsgGUID: zO1pviUQSqiuBO465Lp/BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20161214"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="20161214"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:45:15 -0700
X-CSE-ConnectionGUID: l6hjn5DmRZ6A/janof6Srg==
X-CSE-MsgGUID: S2snkASpR4ahIuE5btW5TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53989940"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:45:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jul 2024 18:45:09 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: don't fail if platform_profile
 already registered
In-Reply-To: <20240713075940.80073-3-luke@ljones.dev>
Message-ID: <8533dbf2-05cf-9747-c61c-e57fd7bbdc4b@linux.intel.com>
References: <20240713075940.80073-1-luke@ljones.dev> <20240713075940.80073-3-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 13 Jul 2024, Luke D. Jones wrote:

> On some newer laptops it appears that an AMD driver can register a
> platform_profile handler. If this happens then the asus_wmi driver would
> error with -EEXIST when trying to register its own handler leaving the
> user with a possibly unusable system - this is especially true for
> laptops with an MCU that emit a stream of HID packets, some of which can
> be misinterpreted as shutdown signals.
> 
> We can safely continue loading the driver instead of bombing out.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 4c129881ce28..7d87ff68f418 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3836,8 +3836,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
>  		asus->platform_profile_handler.choices);
>  
>  	err = platform_profile_register(&asus->platform_profile_handler);
> -	if (err)
> +	if (err == -EEXIST) {
> +		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> +		return 0;
> +	} else if (err) {
> +		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);

Please don't print __func__ to user in warnings or errors, and try to 
write in English what is the reason (instead of resorting to use function 
names).

-- 
 i.

>  		return err;
> +	}
>  
>  	asus->platform_profile_support = true;
>  	return 0;
> @@ -4713,7 +4718,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  		throttle_thermal_policy_set_default(asus);
>  
>  	err = platform_profile_setup(asus);
> -	if (err)
> +	if (err && err != -EEXIST)
>  		goto fail_platform_profile_setup;
>  
>  	err = asus_wmi_sysfs_init(asus->platform_device);
> 


