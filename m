Return-Path: <linux-kernel+bounces-258606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53344938A63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D192E1F2171A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2811607A1;
	Mon, 22 Jul 2024 07:49:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87F1607A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634551; cv=none; b=KqNEyXj+utGWPUKUVdpOU98W3Ji830YNfiDVa7QG+rEQjPF7XT/0Ae1+3uvW/2XSFj4HfOLLWZsv5tSlT03/KwTjmcO5CeF6p5+aZlEpSrfZVZYXtkp6R0fJjEi7A+1PHGPRwke2ifbPEle7boy6MH13SAPokkAtjFzzsvIs1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634551; c=relaxed/simple;
	bh=PNdKJp9Ck9M4KS5ovwPqlWdFJz6BJY9k0p13qloArcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcCyDGAdHYdKIUYgzpfkBWpBoiZy6kipuOb6cbr6AoPfIkGCelT5kt59fAdNIRKkz3D0yvnNScOIN1UodHVluDq9jPl8TEpC7Z7LO2DFRDvgr/64zgliLJFWWXhodAyPHOghi8ifQVuvZCl5Wei/HYh+XXLQDgbmwMSOXta4cmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sVnn3-000582-Fm; Mon, 22 Jul 2024 09:49:01 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sVnn2-001KgX-3j; Mon, 22 Jul 2024 09:49:00 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sVnn2-00BUPx-00;
	Mon, 22 Jul 2024 09:49:00 +0200
Date: Mon, 22 Jul 2024 09:48:59 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH v2 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <Zp4O68Y6oss_pwMm@pengutronix.de>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com>
 <ZpoCC042qMcOQ83N@pengutronix.de>
 <Zpq43ZxnICn5vEIu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpq43ZxnICn5vEIu@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2024 at 12:05:01PM -0700, Brian Norris wrote:
> [ +CC David, in case he has thoughts ]
> 
> On Fri, Jul 19, 2024 at 08:04:59AM +0200, Sascha Hauer wrote:
> > On Thu, Jul 18, 2024 at 03:55:18PM -0700, Brian Norris wrote:
> > > On Wed, Jul 17, 2024 at 10:30:08AM +0200, Sascha Hauer wrote:
> > > > This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> > > > method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> > > > using key_mgmt=WPA-PSK-SHA256.
> > > > 
> > > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
> > > >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
> > > >  2 files changed, 4 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> > > > index 3adc447b715f6..1c76754b616ff 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> > > > @@ -415,6 +415,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
> > > >  #define KEY_MGMT_NONE               0x04
> > > >  #define KEY_MGMT_PSK                0x02
> > > >  #define KEY_MGMT_EAP                0x01
> > > > +#define KEY_MGMT_PSK_SHA256         0x100
> > > >  #define CIPHER_TKIP                 0x04
> > > >  #define CIPHER_AES_CCMP             0x08
> > > >  #define VALID_CIPHER_BITMAP         0x0c
> > > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > index 7f822660fd955..c055fdc7114ba 100644
> > > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > > @@ -60,6 +60,9 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
> > > >  		case WLAN_AKM_SUITE_PSK:
> > > >  			bss_config->key_mgmt = KEY_MGMT_PSK;
> > > >  			break;
> > > > +		case WLAN_AKM_SUITE_PSK_SHA256:
> > > > +			bss_config->key_mgmt = KEY_MGMT_PSK_SHA256;
> > > > +			break;
> > > 
> > > I feel like this relates to previous questions you've had [1], and while
> > > I think the answer at the time made sense to me (basically, EAP and PSK
> > > are mutually exclusive), it makes less sense to me here that PSK-SHA256
> > > is mutually exclusive with PSK. And in particular, IIUC, this means that
> > > the ordering in a wpa_supplicant.conf line like
> > > 
> > >   key_mgmt=WPA-PSK WPA-PSK-SHA256
> > > 
> > > matters -- only the latter will actually be in use.
> > > 
> > > Is that intended? Is this really a single-value field, and not a
> > > multiple-option bitfield?
> > 
> > It seems that when only the KEY_MGMT_PSK_SHA256 is set, then
> > KEY_MGMT_PSK also works. Likewise, when only KEY_MGMT_SAE is set, then
> > also KEY_MGMT_PSK_SHA256 and KEY_MGMT_PSK work.
> > I gave it a test and also was surprised to see that we only have to set
> > the "most advanced" bit which then includes the "less advanced" features
> > automatically.
> 
> Huh, that's interesting. So these KEY_MGMT* flags don't really mean what
> they say. It might be nice to have some additional commentary in the
> driver in that case.
> 
> > I could change setting the key_mgmt bits to |= as it feels more natural
> > and raises less eyebrows, but in my testing it didn't make a difference.

Thinking about this again we really do need to use '|=' and not '='
to make the result independent of the ordering of the AKM suites array
entries.

> 
> That would make sense to me, but I think that's in conflict with what
> David Lin said here:
> 
> https://lore.kernel.org/all/PA4PR04MB9638B7F0F4E49F79057C15FBD1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com/
> 
> "Firmware can only support one of WLAN_AKM_SUITE_8021X,
> WLAN_AKM_SUITE_PSK, or WLAN_AKM_SUITE_SAE."

I don't really know how this sentence was meant. It clearly works when
both WLAN_AKM_SUITE_PSK and WLAN_AKM_SUITE_SAE are advertised. Of course
in the only one of both is selected by the station.

> 
> If that's true, then it seems like we need some kind of priority
> conditions here (e.g., if PSK is provided, but then we see PSK_SHA256,
> let PSK_SHA256 override -- but not vice versa). That might be pretty
> ugly though.
> 
> > BTW wpa_supplicant parses the key_mgmt options into a bitfield which is
> > then evaluated elsewhere, so the order the AKM suites are passed to the
> > kernel is always the same, regardless of the order they appear in the
> > config.
> 
> I hear you, but that's not really how we define kernel APIs -- by the
> particular implementation of a single commonly-used user space.

I know. I wrote this just as a note that we can't use wpa_supplicant out
of the box to actually test how a different order of AKM suites in the
array behaves.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

