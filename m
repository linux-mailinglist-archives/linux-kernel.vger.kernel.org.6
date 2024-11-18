Return-Path: <linux-kernel+bounces-412351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D24589D07F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CC9B21D05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE36A8D2;
	Mon, 18 Nov 2024 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fjiZZXHF"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1E56B81
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731898119; cv=none; b=a7Ffhfhg0ozNEweIBsQEkLw6WJvyg0mkVhzCPMbUh56y6mXIDdaMwYiN5eFaB3XkGnjz+mmZaG9jxWafI1LP0Zi4w2ioH0mC5AFzaiq1TjX1brTYvj5n8bTPHLY8SBBgkL5BWJKaYqU6H6AuKx7fyvd4ZeR59mYgf2HR/yhhnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731898119; c=relaxed/simple;
	bh=G1x8WhYVx94r49CX/OCfWksnZffVfvm9n/ohpVd/RLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUKY02Fsrr3dU1Sy1O6B1ove7I8zlQa1sFU6ADECLW9JWvUTjy8IPMYabovnroyTanKprnFbvegrcCRBiKLplYVo9gNT/H7x7dcTaYhUPt695PeFtDWKkwtMGt5YlwnyZFzq8XCjIkZg5xVYxSZ7TlrOTESXAi9UtNuCs/sr124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fjiZZXHF; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k/6FV
	6ewrrGfEVPXYpIuoujp3S96x+EqE/dJiaCPmwA=; b=fjiZZXHFuACy4Hu3NhvNw
	RQnIXqafayeq9mLn7//Wqzj9H39aSiEckwOlbNWp5K2BTkk+b5BAhzfS6txLfxtt
	b2vRXBEvybFbKXDXVLw/EKO9ghYZqt2tE11WL1v5YIpgZx5JMMwEl/zFYqaAQlv4
	UiZwMKX7qn1wVWHCqX/ZM8=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnuwzApjpnvgFEAg--.56570S2;
	Mon, 18 Nov 2024 10:30:26 +0800 (CST)
From: 412574090@163.com
To: dlemoal@kernel.org
Cc: 412574090@163.com,
	James.Bottomley@HansenPartnership.com,
	andreas@gaisler.com,
	andrew+netdev@lunn.ch,
	cassel@kernel.org,
	davem@davemloft.net,
	deller@gmx.de,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	martin.petersen@oracle.co,
	mpe@ellerman.id.au,
	ojeda@kernel.org,
	perex@perex.cz,
	sudipm.mukherjee@gmail.com,
	t.sailer@alumni.ethz.ch,
	weiyufeng@kylinos.cn,
	xiongxin@kylinos.cn
Subject: Re: [PATCH v2 1/4] parport: use standard kernel printing functions
Date: Mon, 18 Nov 2024 10:30:24 +0800
Message-Id: <20241118023024.22287-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <39c7413a-aa51-4fb2-b949-3f4e3a53839f@kernel.org>
References: <39c7413a-aa51-4fb2-b949-3f4e3a53839f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDnuwzApjpnvgFEAg--.56570S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFW5tF1xCF15Ww4xWF1Utrb_yoW7uw18pa
	18uFsrZ39rta17Aw1UAan8uF45t3WqkFy8CF18Ka4jvFnFyrZrArWjkFZ293Z8GFyUXayf
	tFs8GFnxAr4fKr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0dgLUUUUU=
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBXwqXAGc1t5mIpwABsQ

> On 11/12/24 11:11, 412574090@163.com wrote:
> > From: weiyufeng <weiyufeng@kylinos.cn>
> > 
> > change printk to standard kernel printing functions.
> > 
> > Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> > ---
> >  drivers/net/hamradio/baycom_epp.c |  8 ++++----
> >  drivers/net/hamradio/baycom_par.c |  6 +++---
> >  drivers/parport/parport_pc.c      | 12 ++++++------
> >  drivers/parport/procfs.c          |  2 +-
>
> This is mixing changes for different drivers. Please split the net and ata part
> into different patches and send the net ones to the correct list and maintainers.
Yes, it will be updated in v3 version. Can you help review the patch for
path2-patch4? If possible, it would be a great honor.
>
> >  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> > diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
> > index 9e366f275406..1b7fd6d49a96 100644
> > --- a/drivers/net/hamradio/baycom_epp.c
> > +++ b/drivers/net/hamradio/baycom_epp.c
> > @@ -828,13 +828,13 @@ static int epp_open(struct net_device *dev)
> >          }
> >  #if 0
> >          if (pp->irq < 0) {
> > -                printk(KERN_ERR "%s: parport at 0x%lx has no irq\n", bc_drvname, pp->base);
> > +		pr_err("%s: parport at 0x%lx has no irq\n", bc_drvname, pp->base);
> >  		parport_put_port(pp);
> >                  return -ENXIO;
> >          }
> >  #endif
> >  	if ((~pp->modes) & (PARPORT_MODE_TRISTATE | PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT)) {
> > -                printk(KERN_ERR "%s: parport at 0x%lx cannot be used\n",
> > +		pr_err("%s: parport at 0x%lx cannot be used\n",
> >  		       bc_drvname, pp->base);
> >  		parport_put_port(pp);
> >                  return -EIO;
> > @@ -857,11 +857,11 @@ static int epp_open(struct net_device *dev)
> >  	bc->pdev = parport_register_dev_model(pp, dev->name, &par_cb, i);
> >  	parport_put_port(pp);
> >          if (!bc->pdev) {
> > -                printk(KERN_ERR "%s: cannot register parport at 0x%lx\n", bc_drvname, pp->base);
> > +		pr_err("%s: cannot register parport at 0x%lx\n", bc_drvname, pp->base);
> >                  return -ENXIO;
> >          }
> >          if (parport_claim(bc->pdev)) {
> > -                printk(KERN_ERR "%s: parport at 0x%lx busy\n", bc_drvname, pp->base);
> > +		pr_err("%s: parport at 0x%lx busy\n", bc_drvname, pp->base);
> >                  parport_unregister_device(bc->pdev);
> >                  return -EBUSY;
> >          }
> > diff --git a/drivers/net/hamradio/baycom_par.c b/drivers/net/hamradio/baycom_par.c
> > index 00ebc25d0b22..4b57874c2463 100644
> > --- a/drivers/net/hamradio/baycom_par.c
> > +++ b/drivers/net/hamradio/baycom_par.c
> > @@ -307,12 +307,12 @@ static int par96_open(struct net_device *dev)
> >  		return -ENXIO;
> >  	}
> >  	if (pp->irq < 0) {
> > -		printk(KERN_ERR "baycom_par: parport at 0x%lx has no irq\n", pp->base);
> > +		pr_err("baycom_par: parport at 0x%lx has no irq\n", pp->base);
> >  		parport_put_port(pp);
> >  		return -ENXIO;
> >  	}
> >  	if ((~pp->modes) & (PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT)) {
> > -		printk(KERN_ERR "baycom_par: parport at 0x%lx cannot be used\n", pp->base);
> > +		pr_err("baycom_par: parport at 0x%lx cannot be used\n", pp->base);
> >  		parport_put_port(pp);
> >  		return -ENXIO;
> >  	}
> > @@ -339,7 +339,7 @@ static int par96_open(struct net_device *dev)
> >  		return -ENXIO;
> >  	}
> >  	if (parport_claim(bc->pdev)) {
> > -		printk(KERN_ERR "baycom_par: parport at 0x%lx busy\n", pp->base);
> > +		pr_err("baycom_par: parport at 0x%lx busy\n", pp->base);
> >  		parport_unregister_device(bc->pdev);
> >  		return -EBUSY;
> >  	}
> > diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
> > index f33b5d1ddfc1..609c10d4bc31 100644
> > --- a/drivers/parport/parport_pc.c
> > +++ b/drivers/parport/parport_pc.c
> > @@ -1609,7 +1609,7 @@ static int parport_ECP_supported(struct parport *pb)
> >  
> >  	priv->fifo_depth = i;
> >  	if (verbose_probing)
> > -		printk(KERN_DEBUG "0x%lx: FIFO is %d bytes\n", pb->base, i);
> > +		pr_debug("0x%lx: FIFO is %d bytes\n", pb->base, i);
> >  
> >  	/* Find out writeIntrThreshold */
> >  	frob_econtrol(pb, 1<<2, 1<<2);
> > @@ -1623,7 +1623,7 @@ static int parport_ECP_supported(struct parport *pb)
> >  
> >  	if (i <= priv->fifo_depth) {
> >  		if (verbose_probing)
> > -			printk(KERN_DEBUG "0x%lx: writeIntrThreshold is %d\n",
> > +			pr_debug("0x%lx: writeIntrThreshold is %d\n",
> >  			       pb->base, i);
> >  	} else
> >  		/* Number of bytes we know we can write if we get an
> > @@ -1676,16 +1676,16 @@ static int parport_ECP_supported(struct parport *pb)
> >  	priv->pword = pword;
> >  
> >  	if (verbose_probing) {
> > -		printk(KERN_DEBUG "0x%lx: PWord is %d bits\n",
> > +		pr_debug("0x%lx: PWord is %d bits\n",
> >  		       pb->base, 8 * pword);
> >  
> > -		printk(KERN_DEBUG "0x%lx: Interrupts are ISA-%s\n",
> > +		pr_debug("0x%lx: Interrupts are ISA-%s\n",
> >  		       pb->base, config & 0x80 ? "Level" : "Pulses");
> >  
> >  		configb = inb(CONFIGB(pb));
> > -		printk(KERN_DEBUG "0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
> > +		pr_debug("0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
> >  		       pb->base, config, configb);
> > -		printk(KERN_DEBUG "0x%lx: ECP settings irq=", pb->base);
> > +		pr_debug("0x%lx: ECP settings irq=", pb->base);
> >  		if ((configb >> 3) & 0x07)
> >  			pr_cont("%d", intrline[(configb >> 3) & 0x07]);
> >  		else
> > diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> > index 3880460e67f2..3f809fff317b 100644
> > --- a/drivers/parport/procfs.c
> > +++ b/drivers/parport/procfs.c
> > @@ -128,7 +128,7 @@ static int do_hardware_base_addr(const struct ctl_table *table, int write,
> >  	if (write) /* permissions prevent this anyway */
> >  		return -EACCES;
> >  
> > -	len += scnprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
> > +	len += scnprintf(buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
> >  
> >  	if (len > *lenp)
> >  		len = *lenp;
--
Thanks,

weiyufeng


