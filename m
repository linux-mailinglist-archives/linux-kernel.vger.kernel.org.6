Return-Path: <linux-kernel+bounces-331276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE4E97AAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D091F22E65
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8914594A;
	Tue, 17 Sep 2024 04:50:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C363BBF6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726548604; cv=none; b=ZTyfUKTVBVtyqmGR3HRJmTnsfU9UndJwiZtK5RU8UcHsEyXoRoWQ1hhhSZzPRWxRGe+1ynOqMLPHOloj0U/110AbveOzhELPnDgjseNYE+7BweGI23eJoVuQoG9LC+sGfE3quxsElgRw8s36LJNpd7YjLFiqiOsHOSK1StWED3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726548604; c=relaxed/simple;
	bh=Sn1LKgeiv7Ac9Vx4YAFMr8WB687zRSgn39BsPkqstYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8jp7tWQa6TsSX/5ussYywb2G33s4IgQ/SkTQ/J/DTRp0vDO88unmTUJoEUE1yZyzSudsUWuEIvsGJSoA7khK5uMg0ZD83pGFQUTMG4lC4bx/CHWstvvyBQd0T4IuiU8fZjOLiD7bElvCCpmygqJ27PcyXm116aCj/lymeJ+5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sqQ9s-00005O-Rv; Tue, 17 Sep 2024 06:49:48 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sqQ9s-008ToX-BP; Tue, 17 Sep 2024 06:49:48 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sqQ9s-00D9So-0m;
	Tue, 17 Sep 2024 06:49:48 +0200
Date: Tue, 17 Sep 2024 06:49:48 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <Zt7kCxawoszunWq3@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7kCxawoszunWq3@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Johan,

On 24-09-09, Johan Hovold wrote:
> On Wed, Aug 07, 2024 at 04:08:47PM +0200, Marco Felsch wrote:
> > this patchset is based on Johan's patches [1] but dropped the need of
> > the special 'serial' of-node [2].
> 
> That's great that you found and referenced my proof-of-concept patches,
> but it doesn't seem like you tried to understand why this hasn't been
> merged yet.

I'm glad for your input.

> First, as the commit message you refer to below explain, we need some
> way to describe multiport controllers. Just dropping the 'serial' node
> does not make that issue go away.

Sorry for asking but isn't the current OF abstraction [1] enough? As far
as I understood we can describe the whole USB tree within OF. I used [1]
and the this patchset to describe the following hierarchy:

 usb-root -> usb-hub port-1 -> usb-serial interface-0 -> serial
                                                         bt-module

[1] Documentation/devicetree/bindings/usb/usb-device.yaml

> Second, and more importantly, you do not address the main obstacle for
> enabling serdev for USB serial which is that the serdev cannot handle
> hotplugging.

Hotplugging is a good point but out-of-scope IMHO (at least for now)
since the current serdev implementation rely on additional firmware
information e.g OF node to be present. E.g. if the above mentioned setup
would connect the "serial bt-module" directly to the UART port you still
need an OF node to bind the serdev driver. If the node isn't present
user-space would need to do the hci handling.

So from my POV the serdev abstraction is for manufacturers which make
use of "onboard" usb-devices which are always present at the same USB
tree location. Serdev is not made for general purpose USB ports (yet)
where a user can plug-in all types of USB devices.

Regards,
  Marco

> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-serial-of&id=b19239022c92567a6a9ed40e8522e84972b0997f
> 
> Johan
> 

