Return-Path: <linux-kernel+bounces-429491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24B9E1CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53741B634B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98681EBA0F;
	Tue,  3 Dec 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xltb8R6t"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3331EB9F5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230182; cv=none; b=FXMr5aheXG+GYbzuy7/08KYeCgPWBWR3V7niicopPwuCsVYYydXOgWg0TQR2M/2gcRfSvHNUx5NVYpXaB9YhKcsxrgKw8WL+YCfO/H0ARdTbnB+pm9H72ZGtTj0pG6Zeo+kFsnhEFWRXZnki1wFBwvr77JIGtgyHLLKgsmibpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230182; c=relaxed/simple;
	bh=T1GpIkBfvxvbX+MalpmiQrxGXfApHwhCr7QEBi1XWRg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWmdz+IOU1TzFyWAgXrgWKoTZyN0sP0f73/mfrygSfqFalPMN7aotXkCrQ/0ubLvNPn+6WpG/xSb/YTMP7RLj2aXy/WB6kLUSYRa4NnqlgHZbpI2gqcxyutd898tEGbbqxZLXgHGMf9AenPF1PFpr2u7Q+iI0AOX500gP4JmcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xltb8R6t; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733230181; x=1764766181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T1GpIkBfvxvbX+MalpmiQrxGXfApHwhCr7QEBi1XWRg=;
  b=xltb8R6tkFiSIivNQIt2fjMUhyPSY6QStvsTEZsvnK/vT92njrcTSWWZ
   cMZK5Ptuf72YEM8J5P3LLbpWQ64/hzCabv1nPlliBsyycT67smyRVcgZN
   XUvdfzRZYYwHtW+O91703fL8DsHK+9rSayXSgsgsL7aOjoiiDjSVku0H4
   JtNH+NQ/j+ICT50PNeOrdMVR0FyibOWGTD/llFle/IGJrtHgDSV7Y3GC2
   xbWIv2x76J4lcFDePvUqsWxm85ERWDS7cuW1s5bRg4uwsznsWdN/SG4pf
   juyq5KRqK8trO7gp6Mac4FGBtlXQf5CedJ9FO2sYXD7vvNbTxC3E3A0PE
   g==;
X-CSE-ConnectionGUID: S20NuJ6cSjmnORbGeVYKQw==
X-CSE-MsgGUID: g5ipLOFAQNG9hyM/4AxIEQ==
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="266264389"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Dec 2024 05:49:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Dec 2024 05:48:59 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 3 Dec 2024 05:48:58 -0700
Date: Tue, 3 Dec 2024 12:48:57 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Calvin Owens <calvin@wbinvd.org>
CC: Muhammad Usama Anjum <Usama.Anjum@collabora.com>, LKML
	<linux-kernel@vger.kernel.org>, <Steen.Hegelund@microchip.com>,
	<kuba@kernel.org>
Subject: Re: [Bug Report] Depmod is failing on allmodconfig for arm64 and
 x86_64
Message-ID: <20241203124857.ng736mvwhvkmqie3@DEN-DL-M70577>
References: <91c041ac-5491-4c97-9afc-9eb11c8e686c@collabora.com>
 <Z03fvf3RT7mq9hUZ@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z03fvf3RT7mq9hUZ@mozart.vkv.me>

Hi Calvin, Muhammad,

Thanks for reporting this.

Took me a while to reproduce, turned out i needed a newer version of kmod in
order to get the error print.

> On Tuesday 11/26 at 18:25 +0500, Muhammad Usama Anjum wrote:
> > Hi,
> >
> > The depmod is failing on 9f16d5e6f2206 (mainline) arm64 and x86_64 because of:
> > ```
> > depmod: ERROR: Cycle detected: libphy
> >
> > depmod: ERROR: Cycle detected: lan969x_switch -> sparx5_switch -> lan969x_switch
> > depmod: ERROR: Cycle detected: ptp
> > depmod: ERROR: Cycle detected: stp
> > depmod: ERROR: Cycle detected: ipv6
> > depmod: ERROR: Cycle detected: bridge
> > depmod: ERROR: Found 2 modules in dependency cycles!
> > make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
> > make[1]: *** [/tmp/kci/linux/Makefile:1844: modules_install] Error 2
> > make: *** [Makefile:224: __sub-make] Error 2
> > ```
> >
> > This issue wasn't present until c66fbc6c3df9.
> 
> I set up a bisect script to run overnight, it landed here:
> 
>     98a01119608d21e0ed95a544071beabb353240ed is the first bad commit
>     commit 98a01119608d21e0ed95a544071beabb353240ed
>     Author:     Daniel Machon <daniel.machon@microchip.com>
>     AuthorDate: Thu Oct 24 00:01:33 2024 +0200
>     Commit:     Jakub Kicinski <kuba@kernel.org>
>     CommitDate: Wed Oct 30 18:08:06 2024 -0700
> 
>         net: sparx5: add compatible string for lan969x
> 
>         Add lan9691-switch compatible string to mchp_sparx5_match. Guard it with
>         IS_ENABLED(CONFIG_LAN969X_SWITCH) to make sure Sparx5 can be compiled on
>         its own.
> 
>         Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
>         Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
>         Link: https://patch.msgid.link/20241024-sparx5-lan969x-switch-driver-2-v2-14-a0b5fae88a0f@microchip.com
>         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
>      drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 5 +++++
>      1 file changed, 5 insertions(+)
>     bisect found first bad commit
> 
> Thanks,
> Calvin

So we have two modules: sparx5-switch.ko and lan969x-switch.ko. They both
require symbols from each other, so the error makes sense.  I think the
solution here is to just ditch the lan969x-switch.ko module alltogether and
compile the support into the sparx5-switch.ko module.

/Daniel


