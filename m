Return-Path: <linux-kernel+bounces-534742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D5A46A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE937A6CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6D237A3B;
	Wed, 26 Feb 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X3Mi75tV"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D22376F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596866; cv=none; b=bI8QUGrdoGa6cEVqYv60Pb1B7DR5MZkN4lfA2zEGKtcc2YqT4axjqAQq/2aqjYZ9hL2zZrVSnQnA39j1x3hF+6Ho4sTG4UxQv70zjkehb7CR8fnIthIvCaMRcV797dWsFbNvfSyRLZUb11aU8OnIn2ppRNN8a85Is1hXoolNY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596866; c=relaxed/simple;
	bh=vaZR9Hnj++wdm9p2gOfT46UizyWXUgiuV8N/tsFe4CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAGEilav6YBMvuwuF9X892h+IqLzGlPOOSTDBkx9XDyMPanOl/+5V+mUgt9Cr7Ocs4Kqafm10HSSY5H6e9sS9Bs40BcpeRBU0L1ElBsCVPlv5DVFTITmWQrBunJGcRZondZa17vmYPYdTXeaxZTED8aaHou6xmYqz7JO/7lgNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X3Mi75tV; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1d495444-5287-453f-8d20-6d578c4edb36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740596862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j71fEwNAw6vMemf2qgdxvV8cBNKsWsP3YOvG0aBa448=;
	b=X3Mi75tVIKy5oeu+mDylHxr1bM+aq2YD2tiPCVIof4NAN9q4CO+6jCwl07Czw4D4nC2jdA
	rVzqHV2LCNnikpVG4DU8Ha2+Obse2084q7JAyhPMPrWJLXjim0LNpmWMqBokF9NAldfs0J
	wfQrE53G3GT4zBSP13cXqqcmkcRw30c=
Date: Wed, 26 Feb 2025 11:07:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] platform/x86: Add Lenovo Gaming Series WMI Drivers
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>,
 Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>,
 Mia Shao <shaohz1@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20250225220037.16073-1-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

For the series on both Lenovo Legion Go and Legion Go S, all platform profile selection and power controls have been working consistently over several hours with numerous adjustments and many suspend/resume cycles. Tested on Arch Linux w/ kernel 6.14-rc1 compiled from platform-drivers-x86. 

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev> 

On 2/25/25 1:59 PM, Derek J. Clark wrote:
> Adds support for the Lenovo "Gaming Series" of laptop hardware that use
> WMI interfaces that control various power settings. There are multiple WMI
> interfaces that work in concert to provide getting and setting values as
> well as validation of input. Currently only the "Gamezone", "Other
> Mode", and "LENOVO_CAPABILITY_DATA_01" interfaces are implemented, but
> I attempted to structure the driver so that adding the "Custom Mode",
> "Lighting", and other data block interfaces would be trivial in a later
> patches.
> 
> This driver is distinct from, but should be considered a replacement for
> this patch:
> https://lore.kernel.org/all/20241118100503.14228-1-jonmail@163.com/
> 
> This driver attempts to standardize the exposed sysfs by mirroring the
> asus-armoury driver currently under review. As such, a lot of
> inspiration has been drawn from that driver.
> https://lore.kernel.org/all/20240930000046.51388-1-luke@ljones.dev/
> 
> The drivers have been tested by me on the Lenovo Legion Go and Legion Go
> S.
> 
> v3:
> - Added notifier chain to Gamezone and Other Mode drivers.
> - Added component framework to lenovo-wmi-other driver with
>   lenovo-wmi-capdata01 acting as a component.
> - Completed all suggestions from v2.
> - Checkpatch produces CHECK complaints about the Other Mode macros
>   reusing some variable names. This don't appear to create the condition
>   it highlights in my testing.
> 
> v2:
> https://lore.kernel.org/platform-driver-x86/20250102004854.14874-1-derekjohn.clark@gmail.com/t/#m9682cee65783ff3a9e927f2ad1f55c4cbfc37615
> v1:
> https://lore.kernel.org/platform-driver-x86/CAFqHKTna+kJpHLo5s4Fm1TmHcSSqSTr96JHDm0DJ0dxsZMkixA@mail.gmail.com/T/#t
> 
> Suggested-by: Mario Limonciello <superm1@kernel.org>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Derek J. Clark (4):
>   platform/x86: Add lenovo-wmi drivers Documentation
>   platform/x86: Add Lenovo Gamezone WMI Driver
>   platform/x86: Add Lenovo Capability Data 01 WMI Driver
>   platform/x86: Add Lenovo Other Mode WMI Driver
> 
>  .../wmi/devices/lenovo-wmi-gamezone.rst       | 355 +++++++++++
>  .../wmi/devices/lenovo-wmi-other-method.rst   | 142 +++++
>  MAINTAINERS                                   |  12 +
>  drivers/platform/x86/Kconfig                  |  35 ++
>  drivers/platform/x86/Makefile                 |   4 +
>  drivers/platform/x86/lenovo-wmi-capdata01.c   | 140 +++++
>  drivers/platform/x86/lenovo-wmi-gamezone.c    | 374 ++++++++++++
>  drivers/platform/x86/lenovo-wmi-other.c       | 549 ++++++++++++++++++
>  drivers/platform/x86/lenovo-wmi.c             |  77 +++
>  drivers/platform/x86/lenovo-wmi.h             |  94 +++
>  10 files changed, 1782 insertions(+)
>  create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>  create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.rst
>  create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-other.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi.h
> 


