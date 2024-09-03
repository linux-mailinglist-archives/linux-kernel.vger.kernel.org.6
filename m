Return-Path: <linux-kernel+bounces-312405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CED969623
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304931C23137
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041420011B;
	Tue,  3 Sep 2024 07:52:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B01865F0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349938; cv=none; b=Ge66fsxiy9T4q/YgL9OupUrVAukwruQz9KsGRjSbrUT0w67QCO4kghQUQdv8ukrKfkvm90P9+JSy1J6bD+Pp3U2B0CASxfU/+mE1thwti3TlLaairNXeY9qW/zp2VXo5sY4KnOVpMebcLBzAI4EdABmAOY6rG90HIMOOmMDqXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349938; c=relaxed/simple;
	bh=VqLr+yy1XoO4L1Pd40Z3oz29G7U1Fbe0JlTSv+JMgL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzpVS+vONDXA5AyXvaCD/wyGseBoVcAL4ngXd1jBi0FAt5in9d6nTy8NLIxHp/1HhVc0Dz1Kx8X9JBs3DyXb643V5L6ivR1pzfwx62FLhwZkFMtWIMqB4cB1p4zOGURlhiOLs0dU2oHGP2J2vnakr9lwamt7LhkpYD2Sl31ynzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1slOKf-0005vN-2O; Tue, 03 Sep 2024 09:52:09 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1slOKe-0058G8-BL; Tue, 03 Sep 2024 09:52:08 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1slOKe-004NAj-0k;
	Tue, 03 Sep 2024 09:52:08 +0200
Date: Tue, 3 Sep 2024 09:52:08 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Message-ID: <ZtbAKPP7tIexefd3@pengutronix.de>
References: <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVtPJSsIr9eIFWv@pengutronix.de>
 <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtW5fFocfr9_WgGD@pengutronix.de>
 <PA4PR04MB963814F85BBA6DD39F516469D1932@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtatnHp_7FBSSpko@pengutronix.de>
 <DU0PR04MB9636EF4BC137C95F70594E9DD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <Zta63ltdVl_UcX9R@pengutronix.de>
 <DU0PR04MB96367FEE321C1F269278EA4DD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB96367FEE321C1F269278EA4DD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2024 at 07:35:59AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, September 3, 2024 3:30 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> > <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle Valo
> > <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > On Tue, Sep 03, 2024 at 06:39:15AM +0000, David Lin wrote:
> > > > > > > Not only this code segment. In fact, you did not add VDLL data
> > > > > > > patch support
> > > > > > to sdio.c.
> > > > > > > If you try to add the code and do test, you will know what is
> > > > > > > missing in your
> > > > > > code.
> > > > > >
> > > > > > Could you point me to the code you mean?
> > > > > >
> > > > > > Sascha
> > > > > >
> > > > >
> > > > > I only know the porting VDLL code in nxpwifi.
> > > >
> > > > Yes, and I asked for a pointer to that code, some function name, or
> > > > file/line or whatever, because I looked at the nxpwifi driver and
> > > > don't know what you mean with "VDLL data patch support" in sdio.c.
> > > >
> > > > Sascha
> > > >
> > >
> > > It is better for you to check MXM driver. It is the same as Mwifiex which
> > support all SDIO modes.
> > 
> > Now I am confused. You said:
> > 
> > > In fact, you did not add VDLL data patch support to sdio.c
> > 
> > I was under the assumption that the nxpwifi driver that you specifically posted
> > for the iw61x chipset should contain this code. Isn't that the case?
> > 
> > BTW did you really mean "VDLL data patch" or did you mean "VDLL data
> > path"?
> > 
> 
> Sorry VDLL data path.
> You did not add the code to support this new SDIO data type in your patch.
> 
> Please check MXM driver which supports all SDIO modes.

But why? The nxpwifi driver is much closer to the mwifiex driver and
much better readable, so I would rather pick the missing pieces from
there.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

