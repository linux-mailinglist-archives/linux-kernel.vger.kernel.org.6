Return-Path: <linux-kernel+bounces-242241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9BD92854A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A6A1F24B6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586181474A7;
	Fri,  5 Jul 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqpR9PFb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04A1465AE;
	Fri,  5 Jul 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172400; cv=none; b=Rr09faV9piFYPF3x1397q5sbYdOAGU6dIMi+fDg1gqFdzFNk34crXgZlecrHmUIBCi5/woZlUjICT2jNuJcRccL51q5tHA0hYTbyAEBrKFCXORMsbcZOyH4lHUKIDXuuBusn+IVHWfl7PszcNosekGq2/i8KbZ4RNUYQPwoJg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172400; c=relaxed/simple;
	bh=8OX4GVpinaiIjEjAASpL6JS3LGl4paqDHb/3D+nSI8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJc7ecy48Q3ocnvptLMW1vOHdgyf8ulsSpzyNLiJ9ikFlVM6uzgxnTmUlxyI+EhB948RBrB0tTBge3BcdB5TVn8+WfUJQ9GS7z93VoLTdlWhnGTmb1aEwbr+ckY1M77ciyMLhHkKjcNFtVlPuaXL0ydbZrDBpyh6jSq0wMjoZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqpR9PFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F99C116B1;
	Fri,  5 Jul 2024 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720172400;
	bh=8OX4GVpinaiIjEjAASpL6JS3LGl4paqDHb/3D+nSI8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqpR9PFb7yWzc2mYf9+l7oVU7VqSh6yVtmVZUgkL0DLpj/idelz1PtEsIL6e0XRQb
	 pskMQDReh8Ni1ZlScNkwFKAfn2XewKGZoxocK52U+5U1F5ayY7voon9TIIo3Ha/lbI
	 0kejKCt1ZlEWCKUlyF5ggTsJAB4bwTAtV8uGgGsE=
Date: Fri, 5 Jul 2024 11:39:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] USB: serial: option: add support for Foxconn
 T99W651
Message-ID: <2024070538-circling-ambiguity-908f@gregkh>
References: <20240705081709.105496-1-slark_xiao@163.com>
 <Zoe3qBwWG33AZaU9@hovoldconsulting.com>
 <5b098485.965d.190822996fc.Coremail.slark_xiao@163.com>
 <Zoe7RT7o39C7iXmA@hovoldconsulting.com>
 <43cc2529.9d61.190823e694a.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43cc2529.9d61.190823e694a.Coremail.slark_xiao@163.com>

On Fri, Jul 05, 2024 at 05:34:06PM +0800, Slark Xiao wrote:
> 
> At 2024-07-05 17:22:13, "Johan Hovold" <johan@kernel.org> wrote:
> >On Fri, Jul 05, 2024 at 05:11:22PM +0800, Slark Xiao wrote:
> >
> >> I have a concern about the test result of "usb-devices" in Ubuntu
> >> 22.04. Do you know why it wouldn't show our devices any more? 
> >
> >No, sorry, no idea. Everything seems to work here with the latest
> >usbutils-017.
> >
> >Is it just your devices that no longer show up or doesn't it work at
> >all?
> >
> A lot of devices missed in Ubuntu 22.04, especially for modem devices.
> Nothing would be printed for modem devices.

What specific version of usbutils are you using?

If you pull from the github repo, can you try the version there?

And if that has problems, a diff of both working and not-working would
be great.

thanks,

greg k-h

