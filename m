Return-Path: <linux-kernel+bounces-199657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAF8D8A70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00AE2866F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D5413A879;
	Mon,  3 Jun 2024 19:48:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAA20ED;
	Mon,  3 Jun 2024 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444082; cv=none; b=NpjLioKzaAavyOfgAY3Ung93Si2yEFpL1rPYQQLzhG5aXRBDZTYDT9AQg2SFDX6wa8lSSEUla3nkpSkLPV9iOQ2BE7aSWeRRZBL6misvaDvzOxZvDWEJG9cW+wfcU4M3/q/WLlvAgr3/ZrZSsVUkGDlVYkPS5tpRFJe/PvZutOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444082; c=relaxed/simple;
	bh=VvvqiFcoU7bNUHX+pwuQRPUA4s1y2fJan5cr8vu4BwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7YsZxU8GDLOty42jm1Uh7l8Vp7HmypiWUOlOtr9q/2ZCGoXW9kBsmmuFpK6t+C4DUpk4o4F/+GYR7RHGwu/HybrIsGH7eqPMOUhc4xHjJzHHBBXn57mZn5ya30Y2T1nkkXYEQVvC4YeGUh8qxxsUuK17Zu8hZgIzWpUFGrTS3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: uZncMz9sQ8+yjaQYAlriew==
X-CSE-MsgGUID: 6eR8Yox8Rqqv3QOxahXjnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17744822"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="17744822"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:48:01 -0700
X-CSE-ConnectionGUID: OBAO9a07Ttqim9QBTsOMTA==
X-CSE-MsgGUID: 29kyABT5TpCUrLH2fUrtgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="74466476"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:47:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1sEDev-0000000DNG5-02ap;
	Mon, 03 Jun 2024 22:47:57 +0300
Date: Mon, 3 Jun 2024 22:47:56 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: linedisp: add missing MODULE_DESCRIPTION()
 macro
Message-ID: <Zl4d7A_uE-PFrlCo@smile.fi.intel.com>
References: <20240602-md-drivers-auxdisplay-linedisp-v1-1-9895acebf916@quicinc.com>
 <CAMuHMdV+xKD22ntAeTXUN89agxrjXiu-Nk3uHDvUJDczVpaLgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV+xKD22ntAeTXUN89agxrjXiu-Nk3uHDvUJDczVpaLgA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 03, 2024 at 09:53:40AM +0200, Geert Uytterhoeven wrote:
> On Mon, Jun 3, 2024 at 5:02 AM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> > make allmodconfig && make W=1 C=1 reports:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line-display.o
> >
> > Add the missing invocation of the MODULE_DESCRIPTION() macro.
> >
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pueshed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



