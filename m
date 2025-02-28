Return-Path: <linux-kernel+bounces-538474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C78A49927
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A30E7A9B40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747DF26AAAE;
	Fri, 28 Feb 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBh8kvP+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45926A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745539; cv=none; b=g//XxJpNzN2i+ue52LA1Vj+Yubm1i8Df2foXFz40CdfXjfl+qBbBK9/zVMNr0etkkQA+vzJOpS2Hexnz3h1i1Xf7gqeo0ryKZKjBSdOELYRw8bwRdV4e5vSKukQulltbDbXHcggj1Pr/RGBc6PrKy6RE4P/CFJeCT0b0CbQybS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745539; c=relaxed/simple;
	bh=XqM5WqihnbemKDDciIHF4nQMqthqgTkWOa0BRrNtGzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leli5TadutmXqdb71YoHDBiKRBbQRrNVrJBcBuZ2Lb5hkNIl84hxfk0Lr39vJjgo2zUHX9RZLGvY8u5gvXAxuu4n4yjYMwEcqTyPpX5jZHZmZ3gJz0N27eZRAxvcEhE/ZlZPfk355eQA/y+eFwzVYzSwLQld+oFb8EwVo0g6ok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBh8kvP+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740745538; x=1772281538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XqM5WqihnbemKDDciIHF4nQMqthqgTkWOa0BRrNtGzY=;
  b=CBh8kvP+hvkb1/8WDpFp6tHffhLCoBucu1HTnLuajNg+AKk9iYZsv9y2
   fYaULizb54flibejOFwncMq2TzOIhbhYPdMQkv68kpxvvcEXrWJ+zgfxX
   ywQohxofl7iBUjPkRUqC782ikt9iBqqIFVsd0HdOeNPNojuf0m6HjTAnj
   DK6t7BmvwDzSjUQXhAMkQT3bfhyo4hzCfWO6G+r8mfJj7+nJSylaoGnUQ
   syL2gFtIyCr+W31SJio0mA4EJ4EM/YjG1fgbDPmZ07sqjdVv2O5a4Vt3Q
   PivZWGDKFlpVfzOmfOBWWvIwEPRxQFqR1iyEygqqcNjbSZ7E8qCVZG+GA
   w==;
X-CSE-ConnectionGUID: vw94adHjTY+9ruL3U3N2ww==
X-CSE-MsgGUID: /mnn/YB8RZSLC3Nvnpu1RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53082756"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53082756"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:25:38 -0800
X-CSE-ConnectionGUID: +vEAD0khTHaoviOwOBaRTA==
X-CSE-MsgGUID: NHIA2YbBRnSkulEVCiO8IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122337530"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:25:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzQo-0000000FwW8-3xEu;
	Fri, 28 Feb 2025 14:25:30 +0200
Date: Fri, 28 Feb 2025 14:25:30 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: kernel test robot <lkp@intel.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <Z8GrOhRRsCvD_UtB@smile.fi.intel.com>
References: <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
 <202502280028.1Y9QMcR0-lkp@intel.com>
 <PN3PR01MB9597926E81D2787F2210B84CB8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597926E81D2787F2210B84CB8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 05:28:33PM +0000, Aditya Garg wrote:
> > On 27 Feb 2025, at 10:24 PM, kernel test robot <lkp@intel.com> wrote:
> > ﻿Hi Aditya,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.14-rc4 next-20250227]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> 
> A version 7 of this patch has already been submitted, not sure why kernel test robot tested version 4

Because you are too fast to send a new versions. Whenever patch appears in ML
it is seconds/minutes to trigger a bot build, which takes hours. I recommend
spend more time on thinking and discussing, than issuing versions like from
a machine gun.

-- 
With Best Regards,
Andy Shevchenko



