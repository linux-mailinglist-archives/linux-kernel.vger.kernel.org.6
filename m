Return-Path: <linux-kernel+bounces-344089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0A98A466
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EBE281C77
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B318F2DD;
	Mon, 30 Sep 2024 13:12:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D218E755
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701941; cv=none; b=r4kJ86lO00QJ7SD51z8yi6lasUEKk+GC2wsAtTQE3gUbVz2VmXUyNGzl044hoCo08dTUT2NdLabWNcZP18XotrSQRv3HpTh13Z4L1bAKWRTlBGuqaIJEDYUxqDlmO+9WhsHc/DlzT7vNVg85O9TfBh6IrOsCaBjF85ovOvqXZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701941; c=relaxed/simple;
	bh=J0R9sbZ1JIZNBQLvxAiot7RMxltzdfewnfyMxSH5TUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFQv+7iPhM4JGvCfciHuC5xFc1/HWkm1V/Jso30KdDcp10UtfKcILw8mOrS9M+7c/n+IIs5n9ZuUOQNaeeTbohsSX66TKUZH/3casbCTf4k4f1qtsg3ntlfEL2t5mLhQKZJafe6mNJogdfA8fTr2rwQGjL1BjOfHNgr5vLaZuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 3ZSqTIr9TZWOqGTYqWKWPQ==
X-CSE-MsgGUID: 3BeSYcbxTWCPQ/GgUeN4Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26887347"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26887347"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:12:16 -0700
X-CSE-ConnectionGUID: I1QIfj42RT2HHmpnABO/gg==
X-CSE-MsgGUID: Sw+YPtN0Tay9kjWMKNKtCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104104671"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:12:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1svGCD-0000000EfX1-0hO7;
	Mon, 30 Sep 2024 16:12:13 +0300
Date: Mon, 30 Sep 2024 16:12:12 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <ZvqjrKzm672KTZHS@smile.fi.intel.com>
References: <20240918123150.1540161-8-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918123150.1540161-8-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 18, 2024 at 02:31:50PM +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



