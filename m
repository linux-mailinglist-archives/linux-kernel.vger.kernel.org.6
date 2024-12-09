Return-Path: <linux-kernel+bounces-438050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5489E9C33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652902839C1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A815B14F9FB;
	Mon,  9 Dec 2024 16:56:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922B14D44D;
	Mon,  9 Dec 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763369; cv=none; b=tR2LcwslzB9fNAYJU52qePR9kXxNkhN7ZYqXMRIVZAUj/Pju4HrjsaxYkLSBj+j69UZ6eBJooCXnrxX0u6TvQty1wXcrMKteprVI7+Sch9Y8s9ZIoDZq0iJU8rgJFHGmPjcRSssIajooc4uoixIZurG6NSsJBLyP66IqoB8Of28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763369; c=relaxed/simple;
	bh=LXHtbriYVn16tnultK+kooVpWwRoVXNygrvKzvdebhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkaJ6qKbuPebheV44c7XM61FECycR3He+84AHlIDDJZu7Q/IblB+2W3D2MZ/fq/VOAQYK02Em3e/BBS3VRMf7C7RcDsGjJwo/A7Q0Qh9xr/cU+Hk5agxhdhecm/m7rItFrFvGRe1TZxcvte8WNPspW2btV22vW0mJulj+cMLGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 43MM2+o1SJyXOc7A5TlDYw==
X-CSE-MsgGUID: UKPqwnWOT0e8xUa3fuh1zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34129686"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34129686"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:56:08 -0800
X-CSE-ConnectionGUID: ffp5MoZuSTy7dbxZYrkGUQ==
X-CSE-MsgGUID: XbUfTYedTM6zg+kKOzNfLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="99942309"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:56:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tKh3D-00000005nuY-1MSB;
	Mon, 09 Dec 2024 18:56:03 +0200
Date: Mon, 9 Dec 2024 18:56:03 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Paul Burton <paulburton@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] auxdisplay: img-ascii-lcd: Remove an unused field in
 struct img_ascii_lcd_ctx
Message-ID: <Z1chIylBEFHTs65p@smile.fi.intel.com>
References: <35fab997bcac76cd4135797a4968c2c72511dcb9.1733523925.git.christophe.jaillet@wanadoo.fr>
 <CAMuHMdVL8J4=ufYf0nyoQo9f1Dd3ER4wf1wtAGtqFnN74GWJxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVL8J4=ufYf0nyoQo9f1Dd3ER4wf1wtAGtqFnN74GWJxw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 09, 2024 at 09:54:19AM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 6, 2024 at 11:26 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> > Remove 'cfg' from struct img_ascii_lcd_ctx. It is unused since commit
> > 7e76aece6f03 ("auxdisplay: Extract character line display core support")
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



