Return-Path: <linux-kernel+bounces-199660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B068D8A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5399628AA60
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38213B596;
	Mon,  3 Jun 2024 19:49:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE613B287;
	Mon,  3 Jun 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444154; cv=none; b=n8qzPmHHOzF7dsQ1r2Q1tSz0VfP6j60kUNibvdBUNq+FWWrt1F4ATqa6zBjlI3kBEazgg5Qr31HZKjpzXCPfHqzUbjrhwe6mlFppdYrSoozIh1R8K/R9SAM4TBqaGXRLAkS4n8rD6a7cwovPix32dz+a/G8FQtStrBlS17Gy3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444154; c=relaxed/simple;
	bh=ZecRCW16gc1bohlnVxh9o8nTv9ssEss5ipSxh+2ZfKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nay2vcWcj+q4YcqcGJ8lOc1F5oflEb+JqkE2IgePjqiMj6TIDSq1DAw9Vm2gugrC5f+mGErl4n+bAE2wHItelqaC++53zZNcTKeSjQFykY8cUsXdplCIRqxIrLsRSZxtpbJ3NTVX/bhMTPMqpQ8xuPJ1lMpwhhKTHsdA9AMtwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: WGbTdQFJRPesqMwe21xLiw==
X-CSE-MsgGUID: IVLB5l1mS0mevZeTGkVs7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17793856"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="17793856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:49:13 -0700
X-CSE-ConnectionGUID: aFUKDmSGT5Syf4POBYiWQA==
X-CSE-MsgGUID: AHfx65rxTRaQbh2H+xmnjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="67814692"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:49:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1sEDg5-0000000DNH2-01Bp;
	Mon, 03 Jun 2024 22:49:09 +0300
Date: Mon, 3 Jun 2024 22:49:08 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: hd44780: add missing MODULE_DESCRIPTION()
 macro
Message-ID: <Zl4eNFEdrsFmHFq1@smile.fi.intel.com>
References: <20240602-md-drivers-auxdisplay-hd44780-v1-1-0f15bd19f949@quicinc.com>
 <CAMuHMdWCTKBJ5FXeDTD+opJshNk3micT06kea+YRD7WTtqsnbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWCTKBJ5FXeDTD+opJshNk3micT06kea+YRD7WTtqsnbg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 03, 2024 at 09:55:00AM +0200, Geert Uytterhoeven wrote:
> On Mon, Jun 3, 2024 at 4:50 AM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> > make allmodconfig && make W=1 C=1 reports:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
> >
> > Add the missing invocation of the MODULE_DESCRIPTION() macro.
> >
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



