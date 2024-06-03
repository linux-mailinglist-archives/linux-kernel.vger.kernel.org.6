Return-Path: <linux-kernel+bounces-199524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F918D881B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE3428508D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E01413790F;
	Mon,  3 Jun 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sh+oRTR1"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93A28382
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436393; cv=none; b=bFhncRxqGiPiC9IKhOJG5eoT926P/UwkHW2oMk6/7/zjOFvehE5Z0JtCxpHU7+WsGPtf3Z+y40hB9gM9+OcQeH6DgGP8BYwr/zPY/JALYOJGK5YhsHRT6oR9RN2vqn3axskl0mV04eAqKE7h9wjnfbAvQfhslCGZC2JECT0M81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436393; c=relaxed/simple;
	bh=3c3w005UvrCNKiI8kJ/KOZjDllrOuRvQ9VhKuduhfhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGjobVIF+ejHqhFh0/c05wQjKziI0iG56cxcCofLK+bgIqiAv0O1H1NT6heGE789WD4Ny9DtzxRf2EjdJcLXLW6OMxhfVqVevlDllr1d5unjG0Zp3zwprmxu4yx8MgKm/pA97/+Z0g78e+Jv9ZR104wPzSxco5Wh3bnJLPhEQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sh+oRTR1; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=w2SkQCALZUJGPkfKV2Y9xV9yqucWzBmwANClRi5Emqc=; b=sh+oRTR1y8u452VN
	w99m3VW4s1WyARCaLvp4yYiB5q17GNYc82acCLjQ+5O78SW3WtgT5HX5JcRQiY/WT0LQ8Tn5mdByN
	A0bqjNU+n7kJ48pTXrIosyszQdIBDuCH1g9sCJMRxC9txi1iOxQDe1hdlVPSLZTEmZJraec/ygFOY
	pJmBBGkSSt44W9lvqzUeXfUSqaNGk20x2aFeVh3yxF/VbyJ9xcE1JkwU707qT3AyFFSjlgdx3dKY3
	uvVGYBDu3UTWHgE7v5cOrcUEqNz4uOQc9GrrwEcF5WpbRuABD8SZiK1Usz9hG5eimP0uMjVv3fgac
	qDPxLhxDjbkR8EMhoA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sEBeu-00400i-38;
	Mon, 03 Jun 2024 17:39:48 +0000
Date: Mon, 3 Jun 2024 17:39:48 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: sudipm.mukherjee@gmail.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org
Subject: Re: [PATCH 0/3] parport: Cleanup some pre-devmodel code
Message-ID: <Zl3_5MzTNqIiXM_C@gallifrey>
References: <20240502154823.67235-1-linux@treblig.org>
 <ZkXj9Ip3DoUAe1wt@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZkXj9Ip3DoUAe1wt@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:39:38 up 26 days,  4:53,  1 user,  load average: 0.00, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (dave@treblig.org) wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > There are some remenants of the pre-devmodel code
> > still in the parport drivers; try and clean some of them out.
> 
> Ping!

Ping^2.

Dave

> Dave
> 
> > This series should have no visible change, all the drivers
> > already use the devmodel, it's just removing the flags
> > that say that, and cleaning out no longer used function pointers.
> > (To me the most useful bit is removing the no longer used
> > 'attach' pointer, so if you've got code that's trying to use
> > it you'll get educated).
> > 
> > Trivially tested in qemu, I can still write to the lp;
> > 
> > Also checked with grep -r 'struct parport_driver' . -A 9
> > to see if I've missed any.
> > 
> > (I found this while dragging the out-of-tree ppscsi code
> > into working on head, so that I could use my prehistoric
> > HP PP scanner)
> > 
> > Dave
> > 
> > Dr. David Alan Gilbert (3):
> >   parport: Remove 'drivers' list
> >   parport: Remove attach function pointer
> >   parport: Remove parport_driver.devmodel
> > 
> >  drivers/ata/pata_parport/pata_parport.c  | 1 -
> >  drivers/auxdisplay/ks0108.c              | 1 -
> >  drivers/auxdisplay/panel.c               | 1 -
> >  drivers/char/lp.c                        | 1 -
> >  drivers/char/ppdev.c                     | 1 -
> >  drivers/i2c/busses/i2c-parport.c         | 1 -
> >  drivers/input/joystick/db9.c             | 1 -
> >  drivers/input/joystick/gamecon.c         | 1 -
> >  drivers/input/joystick/turbografx.c      | 1 -
> >  drivers/input/joystick/walkera0701.c     | 1 -
> >  drivers/input/serio/parkbd.c             | 1 -
> >  drivers/net/hamradio/baycom_epp.c        | 1 -
> >  drivers/net/hamradio/baycom_par.c        | 1 -
> >  drivers/net/plip/plip.c                  | 1 -
> >  drivers/parport/daisy.c                  | 1 -
> >  drivers/parport/share.c                  | 9 ---------
> >  drivers/pps/clients/pps_parport.c        | 1 -
> >  drivers/pps/generators/pps_gen_parport.c | 1 -
> >  drivers/scsi/imm.c                       | 1 -
> >  drivers/scsi/ppa.c                       | 1 -
> >  drivers/spi/spi-butterfly.c              | 1 -
> >  drivers/spi/spi-lm70llp.c                | 1 -
> >  include/linux/parport.h                  | 6 ------
> >  sound/drivers/mts64.c                    | 1 -
> >  sound/drivers/portman2x4.c               | 1 -
> >  25 files changed, 38 deletions(-)
> > 
> > -- 
> > 2.44.0
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

