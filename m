Return-Path: <linux-kernel+bounces-576666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97BEA712B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE651889AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2219F121;
	Wed, 26 Mar 2025 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOerlC4s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4627456;
	Wed, 26 Mar 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978079; cv=none; b=Aczy8Sd66zxRGzF1j9tC0w2HrWBok81AXUkgYxpyCH9NWlMU/mzJ7V+T96djIAVHXmUK8ZA1CUSuqnDdu2OJ2GCHc3cqUMaC75q98CsRv6yoSJMzw2YOCo46uW4COZ0tTjA2ZOtLhVAQLY1nk7+SDsicqUYc24ErjbvU+gNLHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978079; c=relaxed/simple;
	bh=bkhkkKj1iQT0oznuEUVs6r33PjMcPaUhIBCY6liySwg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hx4f6PcVRP+uUPOxdhYRM8yTAK5Opg16wlT9A6B0kdZXEM4NGXjlEqDItSRCInHzLry8PUAuIPGQw5Y4POCb8KF96eYz0VqKnPDPngRKo5/iiJWiyJOmHbb+/S9sKqPqP6VnC3Gkex0OdtiLHqNVh2dnuM4IEIpwPUhww+nzyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOerlC4s; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742978078; x=1774514078;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bkhkkKj1iQT0oznuEUVs6r33PjMcPaUhIBCY6liySwg=;
  b=TOerlC4soBMiWf4cfrdJAS6Hy6Edn6BTvurZlvKdm6CSMpyjJFAoVBfm
   hrO5eYQ/iusKMxW9EQb8IuMUdggdmcYKUOnVbdiLuKWulQ7Z3GVVnrjS7
   xplYPz5QCy6cSKFO4iglAGAqOqFl09Pt45IEVfwJ6teYF1gkCy+CXAz79
   PeNPl5UKFUFcSKpWMsJVLtMw7sRx+z3su2yisqL0TS8QcrIRnw905S3nF
   WPKmPWJMxOS9WE1cu4Ub7/dh1zgsiKsDI6igkjSuUwx1pk0juX4tFGD9O
   g5zdEz/LATpwewhAaaNIpLY0/TAdCQWKA0pCpqnYQpKc6omCqJJ3PkewE
   Q==;
X-CSE-ConnectionGUID: S9ipb0foQ7ih7bk39BcuMA==
X-CSE-MsgGUID: LBQdsrfoTk6OuaMq4nKLUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55247840"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="55247840"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:34:37 -0700
X-CSE-ConnectionGUID: wFj1v1HuSd+vQVTm9p85DQ==
X-CSE-MsgGUID: jVnvW0VBQvqHfjRwA1kMVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="125153299"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.5])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:34:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Mar 2025 10:34:30 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
    LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
    Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
    Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 00/12] platform/x86: alienware-wmi-wmax: HWMON support
 + DebugFS + Improvements
In-Reply-To: <D8PMFDWIJJUB.196935MS2OZ7J@gmail.com>
Message-ID: <32a05292-aaa0-15f0-8bdf-dae645b452f3@linux.intel.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com> <D8PMFDWIJJUB.196935MS2OZ7J@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Mar 2025, Kurt Borja wrote:
> On Thu Mar 13, 2025 at 11:29 AM -03, Kurt Borja wrote:
> > Hi all,
> >
> > This set mainly adds hwmon and manual fan control support (patches 7-8)
> > to the alienware-wmi driver, after some improvements.
> >
> > Thank you for your feedback :)
> >
> > ---
> > Changes in v6:
> >
> > [08/12]
> >   - Define dev_pm_ops statically (kernel test robot)
> >
> > Link to v5: https://lore.kernel.org/r/20250312-hwm-v5-0-deb15ff8f3c6@gmail.com
> >
> > ---
> > Kurt Borja (12):
> >       platform/x86: alienware-wmi-wmax: Rename thermal related symbols
> >       platform/x86: alienware-wmi-wmax: Refactor is_awcc_thermal_mode()
> >       platform/x86: alienware-wmi-wmax: Improve internal AWCC API
> >       platform/x86: alienware-wmi-wmax: Modify supported_thermal_profiles[]
> >       platform/x86: alienware-wmi-wmax: Improve platform profile probe
> >       platform/x86: alienware-wmi-wmax: Add support for the "custom" thermal profile
> >       platform/x86: alienware-wmi-wmax: Add HWMON support
> >       platform/x86: alienware-wmi-wmax: Add support for manual fan control
> >       platform/x86: alienware-wmi-wmax: Add a DebugFS interface
> >       Documentation: wmi: Improve and update alienware-wmi documentation
> >       Documentation: admin-guide: laptops: Add documentation for alienware-wmi
> >       Documentation: ABI: Add sysfs platform and debugfs ABI documentation for alienware-wmi
> >
> >  Documentation/ABI/testing/debugfs-alienware-wmi    |   44 +
> >  .../ABI/testing/sysfs-platform-alienware-wmi       |   14 +
> >  .../admin-guide/laptops/alienware-wmi.rst          |  128 +++
> >  Documentation/admin-guide/laptops/index.rst        |    1 +
> >  Documentation/wmi/devices/alienware-wmi.rst        |  383 +++-----
> >  MAINTAINERS                                        |    3 +
> >  drivers/platform/x86/dell/Kconfig                  |    1 +
> >  drivers/platform/x86/dell/alienware-wmi-wmax.c     | 1023 +++++++++++++++++---
> >  8 files changed, 1187 insertions(+), 410 deletions(-)
> > ---
> > base-commit: f895f2493098b862f1ada0568aba278e49bf05b4
> > change-id: 20250305-hwm-f7bd91902b57
> >
> > Best regards,
> 
> Hi Ilpo,
> 
> Is there still a chance for this to go into v6.15? or are you planning
> to review it on the next cycle?

Hi,

I'm almost there to make the main PR for 6.15 from what's in for-next 
currently, so no, this won't be part of it.

In general, I don't usually take large series after -rc6 timeframe to give 
time for things to settle and problems to be brought to surface.
Especially if the series is interfacing with other subsystems which is 
prone to lack of select/depends on clauses, etc. so more likely to break 
the build than changes that seem immune to the .config variations.

-- 
 i.


