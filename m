Return-Path: <linux-kernel+bounces-301190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F61495ED7C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B9C1C21C50
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F731487E3;
	Mon, 26 Aug 2024 09:37:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E3143C70
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665059; cv=none; b=rz1hegJ3H+Ivk/kECHbJEPEKk0rt7qOsIpciJcawdqHl09twrxbByXGe7XSJtNW6+8KdPVK1MVtQgldpXPneiwlk9msqLxlTjCbqgQvSDNldiaeT0KFi7T/xohea+GlQRIn1SfjGADTjTxY1e0dtRMEAH1Edr2DhV7Avgg6Srh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665059; c=relaxed/simple;
	bh=zbyx3IHFvIHZrVQn/7bcMygv/q2i8BjblbMgub8L0L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsgSQgk56GvKgGIf7TawFTVqdrTvwaxBqsey7tJbiRC9kxvcIwfn1YyDR0XixWf1OEwYM9hS3NQDyV2BxCTXIT5p4cnwfoaTR3IkI4n10SDbO7AtucMiqAfvrrvZsP8JsZoBc2HiKseY1ALgNPUeFkS31nPbcrJfKCezgYAC8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1siWAC-0000XJ-Ho; Mon, 26 Aug 2024 11:37:28 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1siWAB-0039gG-Tx; Mon, 26 Aug 2024 11:37:27 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1siWAB-0071na-2e;
	Mon, 26 Aug 2024 11:37:27 +0200
Date: Mon, 26 Aug 2024 11:37:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Message-ID: <ZsxM198_t04j6OMo@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2024 at 09:36:29AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, August 20, 2024 7:56 PM
> > To: Brian Norris <briannorris@chromium.org>; Francesco Dolcini
> > <francesco@dolcini.it>; Kalle Valo <kvalo@kernel.org>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; Sascha Hauer <s.hauer@pengutronix.de>
> > Subject: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention 
> > 
> > Align multiline if() under the opening brace.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/wmm.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c
> > b/drivers/net/wireless/marvell/mwifiex/wmm.c
> > index bcb61dab7dc86..1b1222c73728f 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/wmm.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
> > @@ -1428,13 +1428,13 @@ mwifiex_dequeue_tx_packet(struct
> > mwifiex_adapter *adapter)
> >         }
> > 
> >         if (!ptr->is_11n_enabled ||
> > -               ptr->ba_status ||
> > -               priv->wps.session_enable) {
> > +           ptr->ba_status ||
> > +           priv->wps.session_enable) {
> >                 if (ptr->is_11n_enabled &&
> > -                       ptr->ba_status &&
> > -                       ptr->amsdu_in_ampdu &&
> > -                       mwifiex_is_amsdu_allowed(priv, tid) &&
> > -                       mwifiex_is_11n_aggragation_possible(priv, ptr,
> > +                   ptr->ba_status &&
> > +                   ptr->amsdu_in_ampdu &&
> > +                   mwifiex_is_amsdu_allowed(priv, tid) &&
> > +                   mwifiex_is_11n_aggragation_possible(priv, ptr,
> > 
> > adapter->tx_buf_size))
> >                         mwifiex_11n_aggregate_pkt(priv, ptr, ptr_index);
> >                         /* ra_list_spinlock has been freed in
> > 
> > --
> > 2.39.2
> > 
> 
> I wonder we still need patch for indent issue here? If so I am sure we
> will need a bunch of similar patches which I don't think really help
> improve mwifiex quality
> 
> Actually in its successor Nxpwifi (currently under review), we have
> cleaned up all indent, and checkpatch errors/warnings/checks.

BTW you advertised nxpwifi not as a successor to mwifiex, but as the
driver to be used for new chips. This means we still have to deal with
the mwifiex driver in the future to support the old chips, so even if
nxpwifi is merged it still makes sense to clean up mwifiex.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

