Return-Path: <linux-kernel+bounces-386015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827869B3E17
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F413B219A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA991F4297;
	Mon, 28 Oct 2024 22:57:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D91EBFFA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156235; cv=none; b=W3VspT3I7TjBNObKW+kdwZFFQ/Hj+9hsYiGY/WWZuIbMnlLb+9MsEe3WrFm7RVkgmSjc9/BlkMa41g4jEXcgN07xfK9971MKFn+p38MfRCZ4N8qe6OMnrw0xfTuviKiGdxsS4JNEjy/ZBETTE7zXEA/wRLAlO4FGCVsUCA/xReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156235; c=relaxed/simple;
	bh=zBxzWB+7NYfQRp0L19AL6OTNfIqJpNwmV/Utz6grqUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZJ3aC0dukIHkfPhphIbQ7rPXtMiDNfDzWO0bIiZLzOcBtHUUv+wqshd+r5TQ8Vgys0IFeXwghRWOkpyfMVI7bBPljOrSbCl4M9TXjpB3wbFP1Up94u/n7kxU72vgsP7++APrzVf9wagj/j7G/c3sLr5wwg0TCKX0GhIRB1l7KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5YfW-000798-Vm; Mon, 28 Oct 2024 23:57:02 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5YfW-000vc8-2A;
	Mon, 28 Oct 2024 23:57:02 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5YfW-000tfx-1s;
	Mon, 28 Oct 2024 23:57:02 +0100
Date: Mon, 28 Oct 2024 23:57:02 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20241028225702.tdtfqzhm335vvuv5@pengutronix.de>
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

Hi Greg,

On 24-10-01, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2024 at 09:24:53AM +0200, Marco Felsch wrote:
> > Hi,
> > 
> > gentle ping as this is series is two months old now.
> 
> And it was rejected as serdev does not support hotplug which of course,
> usb-serial does.

I hoped to get some feedback on my answer [1]. Regarding hotplug
support: serdev _requires_ some sort of firmware like OF (not sure if it
does work with ACPI too). That said, if serdev finds no firmware a
fallback is provided to the standard serial handling.

The firmware could either be added directly by the platform OF file or
via OF-overlays. By making use of overlays we could gain some kind of
hotplug: Once a usb devices was detected and the driver has an
overlay, the overlay gets applied and the probe continues, like we do it
for PCIe devices now [2]. For devices which don't have a registered
overlay the standard usb-serial setup is done by exposing the serial
interface to the userspace.

> So until serdev is fixed up to handle that correctly, this is not going
> anywhere, nor should you want it to as then you would be in charge of
> code that does not work properly :)

Regards,
  Marco

[1] https://lore.kernel.org/all/20240917044948.i2eog4ondf7vna7q@pengutronix.de/
[2] https://lore.kernel.org/all/7512cbb7911b8395d926e9e9e390fbb55ce3aea9.camel@pengutronix.de/

> 
> thanks,
> 
> greg k-h
> 

