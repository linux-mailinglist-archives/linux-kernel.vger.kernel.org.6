Return-Path: <linux-kernel+bounces-253525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F106B93227B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8651C21215
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17D195807;
	Tue, 16 Jul 2024 09:10:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2F4C74
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121035; cv=none; b=BwWhwq5gkURUAUoIeb25t+4wOTAnXj/OUnA3LWnnwspXXXPqgszHidOU1U4JRNt8n69ryS+P+ut7W1YlO0hKgrgX4Zve1z8Lgr1qLQC9FWkE+QxUqijjbtULSfrM6aosZWzSfYXCFfEnC28Q81N/rEe3tMBHDCNN2T6Fpu/0Oqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121035; c=relaxed/simple;
	bh=Q/J5HPjD3nULGe63cSK+WgRKArnBrtmlU+sZid0smjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7SnlfqoclvKl70c7XwmxkOM5OdgVGB0z/IPRuZc9DOVJidzazjnqBI8ricWSsDOrIQ9cziKeO7uq7xm9mrpM6KrH38kWn4LZqN2Mo0NYigHyEUus8T/NQTdpBs5uLgwTt6+5PIPSm7HuaN1Wljuh6WdFxSjTQJOcpXOE2zX3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sTeCP-00068u-US; Tue, 16 Jul 2024 11:10:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sTeCO-0005nC-PZ; Tue, 16 Jul 2024 11:10:16 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sTeCO-002HWK-2C;
	Tue, 16 Jul 2024 11:10:16 +0200
Date: Tue, 16 Jul 2024 11:10:16 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Message-ID: <ZpY4-PpxgMOH0wQB@pengutronix.de>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530130156.1651174-1-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, May 30, 2024 at 03:01:56PM +0200, Sascha Hauer wrote:
> The maximum number of AKM suites will be set to two if not specified by
> the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
> specify up to ten AKM suites in the akm_suites array.
> 
> Without only the first two AKM suites will be used, further ones are
> ignored.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Current wpa_supplicant/hostapd only put a maximum of two into the
> akm_suites array as well, a patch changing this can be found here:
> http://lists.infradead.org/pipermail/hostap/2024-May/042720.html

This was recently merged: http://lists.infradead.org/pipermail/hostap/2024-July/042802.html

Kalle, given that userspace now would be able to make use of a bigger
AKM suites array, can we merge this patch for the kernel as well?

Sascha

> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index b909a7665e9cc..908dfe01c30d7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -4358,6 +4358,8 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
>  				 BIT(NL80211_IFTYPE_P2P_GO) |
>  				 BIT(NL80211_IFTYPE_AP);
>  
> +	wiphy->max_num_akm_suites = CFG80211_MAX_NUM_AKM_SUITES;
> +
>  	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
>  		wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
>  
> -- 
> 2.39.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

