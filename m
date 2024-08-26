Return-Path: <linux-kernel+bounces-300929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4B95EAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD4B2097C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224B13A3F3;
	Mon, 26 Aug 2024 07:43:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DAD137903
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658187; cv=none; b=dkhmhXKA7wbPisD8kRl3I1+rjf8634FMsiIywlS0qHNeR0kY+BpDPJOrbY+nY4VHgAyEVHaBkSGOe3Ncqo56GkVulckcbeiOH0p4kXgv3u3SJycJ7FEjhkkBLxARevBSY9m5Rp7k/RKWzZ2w08V+de0RUB3/xdeuzQoFUyqrwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658187; c=relaxed/simple;
	bh=UuFnM833sZHAtd5I23V8mgAJ7A1r9IgMzyY+EAQUmlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nARhrLrlhWnoHj69P08KT32GIhr4gNY4RPJRwn87CyeU/KDSgH+eed1V0pfupfI4HZeL01KKbz9Ww8TkHBcQ7NcIAHbAFYeA9j0HPBkp3W1L++xGm1uW6ClzzguC3XRqQqTvVv8IjFNTOAR67KOdTEb2z2md8zsQsDF5RtYFtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1siUNS-0006LC-ET; Mon, 26 Aug 2024 09:43:02 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1siUNR-0038OV-JG; Mon, 26 Aug 2024 09:43:01 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1siUNR-006xYj-1Z;
	Mon, 26 Aug 2024 09:43:01 +0200
Date: Mon, 26 Aug 2024 09:43:01 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvalo@kernel.org,
	johannes@sipsolutions.net, briannorris@chromium.org,
	tsung-hsien.hsieh@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <ZswyBSyDC8it95Zt@pengutronix.de>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de>
 <20240824134839.GA21315@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824134839.GA21315@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2024 at 03:48:39PM +0200, Francesco Dolcini wrote:
> On Thu, Aug 22, 2024 at 02:56:25PM +0200, Sascha Hauer wrote:
> > On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > > This series adds support for IW61x which is a new family of 2.4/5 GHz
> > > dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
> > > tri-radio single chip by NXP. These devices support 20/40/80MHz
> > > single spatial stream in both STA and AP mode. Communication to the
> > > IW61x is done via SDIO interface
> > > 
> > > This driver is a derivative of existing Mwifiex [1] and based on similar
> > > full-MAC architecture [2]. It has been tested with i.MX8M Mini evaluation
> > > kits in both AP and STA mode.
> > > 
> > > All code passes sparse and checkpatch
> > > 
> > > Data sheet (require registration):
> > > https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
> > > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
> > > 4-plus-802-15-4-tri-radio-solution:IW612
> > > 
> > > Known gaps to be addressed in the following patches,
> > >   - Enable 11ax capabilities. This initial patch support up to 11ac.
> > >   - Support DFS channel. This initial patch doesn't support DFS channel in
> > >     both AP/STA mode.
> > > 
> > > This patch is presented as a request for comment with the intention of being
> > > made into a patch after initial feedbacks are addressed
> > > 
> > > [1] We had considered adding IW61x to mwifiex driver, however due to
> > >     FW architecture, host command interface and supported features are
> > >     significantly different, we have to create the new nxpwifi driver.
> > >     Subsequent NXP chipsets will be added and sustained in this new driver.
> > 
> > I added IW61x support to the mwifiex driver and besides the VDLL
> > handling which must be added I didn't notice any differences. There
> > might be other differences, but I doubt that these can't be integrated
> > into the mwifiex driver.
> 
> Maybe you can share an RFC patch with what you currently have available
> to support IW61x within the current mwifiex driver?

I just did, see:

https://lore.kernel.org/linux-wireless/20240826072648.167004-1-s.hauer@pengutronix.de/

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

