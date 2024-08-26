Return-Path: <linux-kernel+bounces-301128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA1D95ECB2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181D41C2171A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48C143C7D;
	Mon, 26 Aug 2024 09:07:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C884047
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663233; cv=none; b=IRO3lAZfjGqqAjzS/KPLu2wlLks6fm95Nwqy/ZFy20rk/5pvmKQRZb8MZex42fFpDTrilF3WoW59Hrq7+XkIAySHricmELchCZa1hIJMxnvbXagC+UaQ+UUuXOR/ScsJpYWUQ1xjIe/Qbj5wTxcikHysha0byIPENsVfmZBZvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663233; c=relaxed/simple;
	bh=VYcpTxpZ8oA8e1PlWGOKIV6M0wWDxeEsIXyzKs/3vNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2RyYQ+9kFumWayc1Pr9Syl/kdPDyVMxupKKKpYUJBN7mxtvUNt2t6UKwyBfgYX+hNB05FyXYOqr4SNY8tWBlm2OAdewt1CN01mfIet4Zl9XI/mwozWCXLtgF5HEvt5ZkXGYw4itWEKOSCyGPUhDN8AvL3oWQg9fDB4MTCQeYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1siVgm-0005di-Hd; Mon, 26 Aug 2024 11:07:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1siVgm-0039P3-2Q; Mon, 26 Aug 2024 11:07:04 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1siVgl-0070tM-35;
	Mon, 26 Aug 2024 11:07:03 +0200
Date: Mon, 26 Aug 2024 11:07:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/31] wifi: mwifiex: drop HostCmd_CMD_802_11_MAC_ADDRESS
 response handling
Message-ID: <ZsxFt19nQs4D7Q7t@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-3-320d8de4a4b7@pengutronix.de>
 <Zsd-ZxscUBmf0xsu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsd-ZxscUBmf0xsu@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2024 at 11:07:35AM -0700, Brian Norris wrote:
> Hi Sascha,
> 
> On Tue, Aug 20, 2024 at 01:55:28PM +0200, Sascha Hauer wrote:
> > The command response handler copies the new MAC address over to
> > priv->curr_addr. The same is done in the code issuing the call
> > already, so drop the unnecessary HostCmd_CMD_802_11_MAC_ADDRESS
> > handling.
> 
> It took a bit to figure out what you meant here -- I guess you're
> referring to mwifiex_set_mac_address()? It could help to document what
> you mean.

Ok, I can clarify this a bit when sending this next time.

Right now what we have is:

1) mwifiex_set_mac_address() sets priv->curr_addr to the desired new MAC
   address
2) mwifiex_cmd_802_11_mac_address() (called from mwifiex_send_cmd())
   constructs the HostCmd_CMD_802_11_MAC_ADDRESS command, using the MAC
   address in priv->curr_addr
3) mwifiex_ret_802_11_mac_address(), called from the response handler,
   sets priv->curr_addr to the MAC address received with the command
   response, which of course is the same as we initially copied there
   in step 1), which makes 3) redundant and unnecessary

> 
> I'm also a bit torn; this command API ostensibly has a (unused so far,
> for this command) HostCmd_ACT_GEN_GET mode, in which case this *is*
> important.
> 
> If anything, I might consider dropping some of the handling in
> mwifiex_set_mac_address(), because it seems to presume (and then has to
> undo for failure) behavior of the underlying command.

What we could do instead of dropping 3) is:

1) pass the new MAC address in the data_buf argument to
   mwifiex_send_cmd()
2) instead of priv->curr_addr use data_buf in
   mwifiex_cmd_802_11_mac_address()

With this the response handler would still set priv->curr_addr in case
the command went through successfully. No need to undo priv->curr_addr
to the previous MAC address in case the command failed.

Sounds good to me. Is that where you aiming at?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

