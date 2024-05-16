Return-Path: <linux-kernel+bounces-180921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007B8C74D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF820287369
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C97145342;
	Thu, 16 May 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="SWrmU0Rd"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8F143866
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856384; cv=none; b=Hd2cNXeBRdGAMW36+6zdxrkGHTnCha3fw51HGGdar1lnTYDNGxO2qN/XxelRARUgbDIP/3vG6Uj8ovpSximjNNbYgiS0lErzxhWm4U9rGPSDRoDg35A6fe1jXR3MibbyvIamMIbY+XayPeKYtCdFgceFOFU+bj+My7kOfWJ69cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856384; c=relaxed/simple;
	bh=QY0AeitsqqCxT+3ZJAW/jZAg5x1lur9Lmw+RgFWMNH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYHgk4JDiWtp8IG49FJIBViBVtCWH17aR5mjOyWyWOSlWJtbgStRqaPbFv3gdgTz7IAo0AViUSxOg7+PfwI/wzxNKJP5Zo1geSk3RmFXn6S51coOQ2Ug7OlPyBwXQgDU8GxT2E1cHQeQFqmZz2heLrTgaEWCEmn2+z574BL7aoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=SWrmU0Rd; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=sfAZnDr/F1j2PBMDkg6bGHqWdxY46sHH2KFN7kd5Q+M=; b=SWrmU0Rd04ldJWtx
	rGBYzPzLRskEM4WaMyouHDDf83TFn7AHQoI4Il20LDhBI79LYDS/CoppJciRiqc9a8Zy/9iBKaVCw
	I8D3C2MzatXyJZSmBp0e1tpaZJYn71TQDnSRSdqLgd2+MDyHFhnfbvj6eSF06YHjpwgZbWk7hXPUC
	Bn1Igf15a3inK41UFkAc5n0siUc+GrRi5+SajQiFbgwBWzMyi9H19n4KkeQlg5TDUSFcZpSn1vHJS
	JzgX3AqLHBmg9Xn/s5AFxk0hvlMWi+dhUDlnqFeFDgDG0h6Pl5ANphie8B/EuSGpZhnkxAamkeGj0
	+OBTzX1cIgLPfCT45w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s7Ycm-001Cjz-1l;
	Thu, 16 May 2024 10:46:12 +0000
Date: Thu, 16 May 2024 10:46:12 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: sudipm.mukherjee@gmail.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org
Subject: Re: [PATCH 0/3] parport: Cleanup some pre-devmodel code
Message-ID: <ZkXj9Ip3DoUAe1wt@gallifrey>
References: <20240502154823.67235-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240502154823.67235-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:45:58 up 7 days, 22:00,  1 user,  load average: 0.05, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> There are some remenants of the pre-devmodel code
> still in the parport drivers; try and clean some of them out.

Ping!

Dave

> This series should have no visible change, all the drivers
> already use the devmodel, it's just removing the flags
> that say that, and cleaning out no longer used function pointers.
> (To me the most useful bit is removing the no longer used
> 'attach' pointer, so if you've got code that's trying to use
> it you'll get educated).
> 
> Trivially tested in qemu, I can still write to the lp;
> 
> Also checked with grep -r 'struct parport_driver' . -A 9
> to see if I've missed any.
> 
> (I found this while dragging the out-of-tree ppscsi code
> into working on head, so that I could use my prehistoric
> HP PP scanner)
> 
> Dave
> 
> Dr. David Alan Gilbert (3):
>   parport: Remove 'drivers' list
>   parport: Remove attach function pointer
>   parport: Remove parport_driver.devmodel
> 
>  drivers/ata/pata_parport/pata_parport.c  | 1 -
>  drivers/auxdisplay/ks0108.c              | 1 -
>  drivers/auxdisplay/panel.c               | 1 -
>  drivers/char/lp.c                        | 1 -
>  drivers/char/ppdev.c                     | 1 -
>  drivers/i2c/busses/i2c-parport.c         | 1 -
>  drivers/input/joystick/db9.c             | 1 -
>  drivers/input/joystick/gamecon.c         | 1 -
>  drivers/input/joystick/turbografx.c      | 1 -
>  drivers/input/joystick/walkera0701.c     | 1 -
>  drivers/input/serio/parkbd.c             | 1 -
>  drivers/net/hamradio/baycom_epp.c        | 1 -
>  drivers/net/hamradio/baycom_par.c        | 1 -
>  drivers/net/plip/plip.c                  | 1 -
>  drivers/parport/daisy.c                  | 1 -
>  drivers/parport/share.c                  | 9 ---------
>  drivers/pps/clients/pps_parport.c        | 1 -
>  drivers/pps/generators/pps_gen_parport.c | 1 -
>  drivers/scsi/imm.c                       | 1 -
>  drivers/scsi/ppa.c                       | 1 -
>  drivers/spi/spi-butterfly.c              | 1 -
>  drivers/spi/spi-lm70llp.c                | 1 -
>  include/linux/parport.h                  | 6 ------
>  sound/drivers/mts64.c                    | 1 -
>  sound/drivers/portman2x4.c               | 1 -
>  25 files changed, 38 deletions(-)
> 
> -- 
> 2.44.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

