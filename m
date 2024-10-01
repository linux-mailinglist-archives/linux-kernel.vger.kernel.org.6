Return-Path: <linux-kernel+bounces-345415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B298B60E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E541C21CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9421BDA96;
	Tue,  1 Oct 2024 07:47:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE963D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768833; cv=none; b=gRB9E12psJh5T4R4Gugaw9MnUeGDyMjScKF3Syj3iNa6HsRLlF4M9T/bmYvMs+mH2ptsGkPJq9+1rQJxMEPUNUHnci32G+mqWRXGKs9SbxmceRT/enH3RYmzDw+IdwfWOWBLQQlaRVhQe/jpuawyX/IdsZtUhNrSnFmCryilNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768833; c=relaxed/simple;
	bh=kqqvKQHwGcK5dvxhg4sDEbtgeaTSZPxRLhJEhl+Zghk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffn7K59Qi/U3y50jxdNv6bkVFf/1x+ny98vRuQk7palHmGuxF2DIB1T+bwscBHlviZzvPQWeR4p/XC0nPfKbcOiYhsB9nDfu5T36BuwvBokFNagbZKK5/+Jv8m4h76oQRzzKDqVX20m2g7skONKiU0FG6U7iF6UWifbMG5NfCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXb6-00022d-R1; Tue, 01 Oct 2024 09:47:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXb6-002pFI-Cu; Tue, 01 Oct 2024 09:47:04 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1svXb6-004u4N-0z;
	Tue, 01 Oct 2024 09:47:04 +0200
Date: Tue, 1 Oct 2024 09:47:04 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20241001074704.kb4dus7rdrfc4v5c@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <20241001072453.3xv5sqxaj4zjprnz@pengutronix.de>
 <2024100109-maker-ravine-7c65@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100109-maker-ravine-7c65@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-10-01, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2024 at 09:24:53AM +0200, Marco Felsch wrote:
> > Hi,
> > 
> > gentle ping as this is series is two months old now.
> 
> And it was rejected as serdev does not support hotplug which of course,
> usb-serial does.

I just read concerns which I tried to explain/argue but didn't saw it as
rejected.

> So until serdev is fixed up to handle that correctly, this is not going
> anywhere, nor should you want it to as then you would be in charge of
> code that does not work properly :)

Sure as always :)

Regards,
  Marco

