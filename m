Return-Path: <linux-kernel+bounces-259675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D95939B56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72E8B21DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83114A60E;
	Tue, 23 Jul 2024 07:04:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39013B5A6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718280; cv=none; b=XQD7u24UyEU7COmqz5pureZMBYFCCXnG9aMJLr+DWGioJ95UvnpRPeOrua3cdiiT5vYla2ykIK12ey9ANt9hg8XZhJUXXsCGoMX0YKxtf5gQU1uGoBBB8svA4sUbLS2L6CDHrpyeEEXqIqJIxtdseeNvjeO4BkYf0ncmrHOmz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718280; c=relaxed/simple;
	bh=AjivKJmATafcZh8nRhi8DlkVIGNrKl/8z1haDaVMQzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME7tPYkGv5n2/wC0JwUTQGcI8UZsK2ZYND7IoJR6l9q4CHstnrzG5z9vAaOi0DesUt2vcOMIo/o/RZPQXlHojSdAL2/yTxKFJZZV7QkQKb4AAA0ylUM7EoIklhMK5GmdAiLQ5d3kFccT88DYRpTPlqk34jLPZig8iW9pOzL/+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sW9ZL-00077w-M2; Tue, 23 Jul 2024 09:04:19 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sW9ZK-001YxF-8L; Tue, 23 Jul 2024 09:04:18 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sW9ZK-00DOcd-0T;
	Tue, 23 Jul 2024 09:04:18 +0200
Date: Tue, 23 Jul 2024 09:04:18 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: add support for
 WPA-PSK-SHA256
Message-ID: <Zp9V8iaHudiBLlk9@pengutronix.de>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com>
 <ZpoCC042qMcOQ83N@pengutronix.de>
 <Zpq43ZxnICn5vEIu@google.com>
 <Zp4O68Y6oss_pwMm@pengutronix.de>
 <PA4PR04MB963817EE5EA2F6BAEDF22CC2D1A82@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXPGwT7ST3k0SHzpHJ0i2XbtMD-9f06M2PhQjMu-TmMqZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ASDXPGwT7ST3k0SHzpHJ0i2XbtMD-9f06M2PhQjMu-TmMqZw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2024 at 12:30:53PM -0700, Brian Norris wrote:
> Hi David and Sascha,
> 
> On Mon, Jul 22, 2024 at 1:46 AM David Lin <yu-hao.lin@nxp.com> wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> > > Thinking about this again we really do need to use '|=' and not '='
> > > to make the result independent of the ordering of the AKM suites array entries.
> > >
> >
> > Yes, for our private driver. It uses '|=" and can work for firmware of IW416 and IW61x.
> > For nxpwifi, it will follow mwifiex first and will be updated to use "|=" later.
> 
> Thanks for the reply, David. Treating this as a bitfield sounds good
> to me, then.
> 
> > > > That would make sense to me, but I think that's in conflict with what
> > > > David Lin said here:
> ...
> > > > "Firmware can only support one of WLAN_AKM_SUITE_8021X,
> > > > WLAN_AKM_SUITE_PSK, or WLAN_AKM_SUITE_SAE."
> > >
> > > I don't really know how this sentence was meant. It clearly works when both
> > > WLAN_AKM_SUITE_PSK and WLAN_AKM_SUITE_SAE are advertised. Of course
> > > in the only one of both is selected by the station.
> 
> Yeah, I was a little confused too. I don't have many AP systems to
> test though -- all my use cases are STA.
> 
> > Mwifiex supports a lot of legacy devices, I don't know if modifications of the coding
> > for the data of TLV_TYPE_UAP_AKMP will affect existed devices or not. Maybe you
> > can follow the patch for host mlme to add a flag like ''host_mlme_enabled'' to enable
> > this kind of change for specific device.
> 
> I don't love adding new flags for small changes just out of extreme
> caution. If we find a good reason to, that's an option, but in this
> case, it feels like the behavior is poorly defined and possibly
> inconsistent or broken with the current code. Specifically, if anyone
> was specifying PSK+EAP from user space, we didn't really guarantee
> behavior. If users were really using that previously and are broken by
> such a change ... well, we can figure out a way forward by introducing
> such a flag.

+1, thanks Brian.

I'll send an updated series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

