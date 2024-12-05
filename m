Return-Path: <linux-kernel+bounces-432735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3889E4F92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D672810BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB791D049D;
	Thu,  5 Dec 2024 08:19:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22436194A43
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386776; cv=none; b=CUh1Ln89EoPp//iC9ZFHq4yzwAhAzj9aJ6u8hZdgHX4/RV61Fn7lL5K4x+c9uH94/U6ltuHZAh4QQUsPzuLZjAhJLESU4QfA0AOGu6w4jhILM5ESccckUOwEHY+1UC+0nPZvLbrF0lO2I14Oqqy5nTc184C3+WRImwCn7FL6nsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386776; c=relaxed/simple;
	bh=Rp0uSYMv7tS7UlEf36XAhzbPtrr+tZ2JpfXt1fGEMjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+QGwGFIzK1mJNkRgsA4fmUkjDARYJnfD2zb3FjAGv1EJ46d9iEZXry1ZRjcUYGU7SrIdV+XDVBVBbS5jd9t6jHUQP29UEqQAwYpruKgyauki48ojpECk9cHZ7v0OtDmNaMzvveCMGVR4l/DkUtiFINNHP1wMf4FQOFVf3lBe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: fBrzkG2+T2etuHodIUz50A==
X-CSE-MsgGUID: pj1Cu+McSgW+YYYHlYU3HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="21271315"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="21271315"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:19:35 -0800
X-CSE-ConnectionGUID: BfXL9c6NR5yT3QEPz80omw==
X-CSE-MsgGUID: aAabbjbPTn2aDyA1ROdO3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="94374241"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:19:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tJ759-000000041aa-0epQ;
	Thu, 05 Dec 2024 10:19:31 +0200
Date: Thu, 5 Dec 2024 10:19:30 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel_soc_pmic_chtdc_ti: Remove invalid
 max_register from regmap-config
Message-ID: <Z1FiEuqjwpyW4s3Q@smile.fi.intel.com>
References: <20241204210209.136976-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204210209.136976-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 10:02:09PM +0100, Hans de Goede wrote:
> The max_register = 128 setting in the regmap config is not valid.
> 
> The Intel Dollar Cove TI PMIC has an eeprom unlock register at address 0x88
> and a number of EEPROM registers at 0xF?. Drop the invalid max_register
> setting so that these registers can be accessed.

Wouldn't this break debugfs facility?
If that is the case, perhaps adding 0xff to it would make more sense?

-- 
With Best Regards,
Andy Shevchenko



