Return-Path: <linux-kernel+bounces-438049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC699E9C31
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60D41886FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C714F9EE;
	Mon,  9 Dec 2024 16:55:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C662C9A;
	Mon,  9 Dec 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763354; cv=none; b=NqA9ZLBN1yBAFQFjtYxABNEKinfp6Qgb4w6kZ1Qz22g6r/R3EDkUEYcBfbTgEmS3p0URDHmrME7gFdACSIBOPC5mj0Dv2hz7S8gb23O2/vuXSupv4ju9dEZZyY2NIHcbil5kRbQVX7FaHoOJLbhsYBQYf6RQMQmbcixAox2Rg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763354; c=relaxed/simple;
	bh=/+IoL6yT04naLm0YS2E/bg1d0nnL1xvkoT0ltvf6aVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFgTlOJs4KOHKlj3Aga41WKPB79B31291vO0E/O1uG+R0UeAB1aKURemUrRItWDRoM/wtNN4gugKus9lerElUjoRMRZiNG5baFHUqVc1izba5Cvl4LP19zintWXtlu2JAuwsdSiny2FEVSNnw4PkQaHxFglm4HbfpQDwlMtmXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 1yfg6N+vTwau+KBHdYAtPQ==
X-CSE-MsgGUID: yjbs+PmASDWI9BQd6aGGYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34129624"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34129624"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:55:50 -0800
X-CSE-ConnectionGUID: 0S1ZjDmSStmv6z/kiFHLDg==
X-CSE-MsgGUID: z1pUL3BOSoS+4WlHmp1zXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="99942161"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:55:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tKh2p-00000005ntl-1h9X;
	Mon, 09 Dec 2024 18:55:39 +0200
Date: Mon, 9 Dec 2024 18:55:39 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Paul Burton <paulburton@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] auxdisplay: img-ascii-lcd: Constify struct
 img_ascii_lcd_config
Message-ID: <Z1chC8GHeog24M33@smile.fi.intel.com>
References: <35fab997bcac76cd4135797a4968c2c72511dcb9.1733523925.git.christophe.jaillet@wanadoo.fr>
 <f205c8ab886a4e12b2ceda6f89c873a9d921625d.1733523925.git.christophe.jaillet@wanadoo.fr>
 <CAMuHMdVaJyW3bvTxRfcDavA9HaukUDGBaTWRoUtrwjy_rb2DpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVaJyW3bvTxRfcDavA9HaukUDGBaTWRoUtrwjy_rb2DpA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 09, 2024 at 09:55:48AM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 6, 2024 at 11:26 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> > 'struct img_ascii_lcd_config' is not modified in this driver.
> >
> > Constifying this structure moves some data to a read-only section, so
> > increase overall security, especially when the structure holds some
> > function pointers.
> >
> > On a x86_64, with allmodconfig:
> > Before:
> > ======
> >    text    data     bss     dec     hex filename
> >    6110     728       0    6838    1ab6 drivers/auxdisplay/img-ascii-lcd.o
> >
> > After:
> > =====
> >    text    data     bss     dec     hex filename
> >    6198     632       0    6830    1aae drivers/auxdisplay/img-ascii-lcd.o
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



