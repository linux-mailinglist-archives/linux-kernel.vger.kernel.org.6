Return-Path: <linux-kernel+bounces-207773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF7B901BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DAF1F2165E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959EA25569;
	Mon, 10 Jun 2024 07:28:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF620DC4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004486; cv=none; b=bFHRNSsxou6N9x1YSRS5d/eJpb7LeZM1Yuz22JswDxlZmfmdkdoxvlR+IbJFejdpqBkT/TFf3ONBVcs0Px9Ve/HIzgqm4miQ5NC588VaOcV9jBqvyiVDWY8TEIKg9kpRfcF74dCIA8xj9bmSwXVaEY2rteQkOSO2RhLrYDkswyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004486; c=relaxed/simple;
	bh=l+cnz2kffqXjhx1RkbyaFT7mcoQvwDH1FC4xqQmmmW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiKjilzRsHCDq+ojg1lgB7mBucY2zDBVmlavTFjU+4o5wvVyBL2NfBoA1klMqgO01Jmm0iX3vJT2hO/tCzg+36W1tUdJSnS38s4vIecLZ6lkihP5QuSlUQAHYgtEUzpx2U1jS6QG3lwyMqIg3MY3Nm7pPMkQClyLUeCI5TMO4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sGZRc-0002DG-M7; Mon, 10 Jun 2024 09:27:56 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sGZRb-001FSn-Lk; Mon, 10 Jun 2024 09:27:55 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sGZRb-002hvq-1r;
	Mon, 10 Jun 2024 09:27:55 +0200
Date: Mon, 10 Jun 2024 09:27:55 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Message-ID: <Zmaq-4whltVgrzCz@pengutronix.de>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
 <171767674666.2401308.2539321240473169281.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171767674666.2401308.2539321240473169281.kvalo@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2024 at 12:25:48PM +0000, Kalle Valo wrote:
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > The maximum number of AKM suites will be set to two if not specified by
> > the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
> > specify up to ten AKM suites in the akm_suites array.
> > 
> > Without only the first two AKM suites will be used, further ones are
> > ignored.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> I assume you that you have also tested this on a real device, right?

Sure. It was tested with a MAYA-W161-00B module from u-blox with a IW416
chipset.

BTW I haven't mentioned this, but It fixes the same problem as mentioned here:

https://lore.kernel.org/linux-kernel/20240523081428.2852276-1-s.hauer@pengutronix.de/T/

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

