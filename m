Return-Path: <linux-kernel+bounces-324384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE100974BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A09B212D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886B13D539;
	Wed, 11 Sep 2024 07:53:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C953E15
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041228; cv=none; b=TLCegNRLy5v/QLYFejqS7BCQms4gjxb651/MUhNHKCXO7VlLuJO+zUTCZmybkYt6Y0L2ayLvoirMpQymDhTQsJl2VXtYjT/nt6iraKVmIPXKsM675UuANdWCdhaXIXi8LcaHQq6UsmzIJszAiBjAPsyfUywqm9kREnzsTiRPGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041228; c=relaxed/simple;
	bh=uQI95tHOIeg8jtsOx70gTQ2n+CCT9VUFkY/haJdXKQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJh0xT7cjt4B6WFQj98PCdCXg7Xd1yh0kMXsDGmU7doOn19otuysXP8V3x6Rbp52fE8fc2WtPRsbi8OJneP6RJrIHC2LriHWun3rpOI8RdnoS35CpJqZFCU1BAEaIIKV0NJvn+IttrermBM/lFoaNyApk1WbLCpFkmtFdoBR7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1soIAQ-0004xJ-Kf; Wed, 11 Sep 2024 09:53:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1soIAN-0075Pj-R6; Wed, 11 Sep 2024 09:53:31 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1soIAN-001qDC-2N;
	Wed, 11 Sep 2024 09:53:31 +0200
Date: Wed, 11 Sep 2024 09:53:31 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Qianqiang Liu <qianqiang.liu@163.com>, chris.snook@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ag71xx: remove dead code path
Message-ID: <ZuFMe-WoIIwr8E1o@pengutronix.de>
References: <20240910152254.21238-1-qianqiang.liu@163.com>
 <196dc563-85ec-491d-8e2e-8749f3b07ff4@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <196dc563-85ec-491d-8e2e-8749f3b07ff4@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2024 at 05:58:22PM +0200, Andrew Lunn wrote:
> On Tue, Sep 10, 2024 at 11:22:54PM +0800, Qianqiang Liu wrote:
> > The 'err' is always zero, so the following branch can never be executed:
> > if (err) {
> > 	ndev->stats.rx_dropped++;
> > 	kfree_skb(skb);
> > }
> > Therefore, the 'if' statement can be removed.
> 
> This code was added by Oleksij Rempel <o.rempel@pengutronix.de>. It is
> good to Cc: him, he might have useful comments.

Yes, please.

> Your changed does look correct, but maybe ret was actually supposed to
> be set somewhere? Is there an actual bug hiding here somewhere?

Hm, let's see... this issue existed in the openwrt code and I didn't
spotted it by upstreaming.

The only place which may fail in this part is napi_build_skb(), we will
need to count it probably with rx_errors++.

I'm ok with this patch, it can be reworked to use rx_errors++ on
napi_build_skb() instead or this can be done in a separate patch.

If you like to keep this patch as is, here is my:
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

