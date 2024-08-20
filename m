Return-Path: <linux-kernel+bounces-293535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABE958104
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B6D1F252CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63F18A92F;
	Tue, 20 Aug 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug+iSR6C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11518A6BC;
	Tue, 20 Aug 2024 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142657; cv=none; b=Lr9Jhim03sUnzjDs+hRm/MXnfovTFHPU5uvsRI2YyBv1+nqDfEB9LvtbtdpXQkzSJuR160VQf8PkafRH5+I7dBJtEmUwcQ1KCpUevz19jAeS2fo0qelwbxtLE67tC5XoQeQQpKKZ7xlNQPhoVMAcTwr6YBaNH54N5INuTm6omlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142657; c=relaxed/simple;
	bh=BmInGksExZlBWkn/07xLCLQVvYFAfRl0PNPyW6MxqbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klhdvM+97wsG6RWWCa4L0SMhfj4iuxawYAqVUJrWWllH+g0V+JTkCM1dZiH8AivS0Dj7B/l/COhKU7MwMVck4tJaFcXEdx68O6/eQiz8mrSB18lcGsyA4Pe75ZXc3SagHSxKs0vkU2oKhrF4s/TGVteHqKgJeh/0Oh3iWaOAeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug+iSR6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9921C4AF0F;
	Tue, 20 Aug 2024 08:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724142656;
	bh=BmInGksExZlBWkn/07xLCLQVvYFAfRl0PNPyW6MxqbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ug+iSR6CN9Cx6AdKo3T2Z4aOuprJDe79l4wOJkPZe6TzyzBDKIJRYNVGM2vjOuzut
	 BdNbeSfqTPPHXcxYWx03I8eT817/xpq7oTbq5BsbGOfG5ywPHvmuTzhT5YHiVL25Js
	 CFK3gsCdwK05HOArVVNrmissVuO2lB9AxzzkExum+yIJKXlzPxPajAlrsWS5vnpsxc
	 qcmIxRJIgio3Fuvu2UhbUOBHCPWU1oMB2Fx314R6rTOEJbHYdvmr5k+gm9mcZ8nuXl
	 RM/G3YOSR/WmauKmGoSLhQp7AJIvfGcgCOJp3XMtbZNYwsDHeHM6VYg9LXuW2+I/lY
	 9H1E9mnKxYymw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sgKGV-000000000hj-2hYk;
	Tue, 20 Aug 2024 10:30:55 +0200
Date: Tue, 20 Aug 2024 10:30:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] USB: serial: add missing MODULE_DESCRIPTION() macros
Message-ID: <ZsRUP7ZcKvcUBL4t@hovoldconsulting.com>
References: <20240611-md-drivers-usb-serial-v1-1-c6ada535890a@quicinc.com>
 <ZofajSjhaaZsFRro@hovoldconsulting.com>
 <108d8399-9b09-4a1d-8424-a6fa69b63d77@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108d8399-9b09-4a1d-8424-a6fa69b63d77@quicinc.com>

On Tue, Jul 23, 2024 at 11:44:05AM -0700, Jeff Johnson wrote:
> On 7/5/2024 4:35 AM, Johan Hovold wrote:
> > On Tue, Jun 11, 2024 at 10:52:54AM -0700, Jeff Johnson wrote:
> >> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/ch341.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/navman.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
> >>
> >> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> >>
> >> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > 
> > I amended the commit message with the (recent) commit that added this
> > W=1 warning (and dropped C=1). I also tweaked three descriptions
> > slightly. End result is here:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=9f4dc05107a6db3743e6b9ea4014cbdc3795682d

> I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
> Will you be able to have this pulled during the merge window?
> I'm trying to eradicate all of these warnings before 6.11 rc-final.

This one is now in Linus' tree.

Johan

