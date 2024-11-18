Return-Path: <linux-kernel+bounces-412881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEA79D108F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8F4B229F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCA199253;
	Mon, 18 Nov 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8VGh4IA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7C38B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932970; cv=none; b=bCWcTfSSSzjn/aEOwoaVqPrvKPozhx0AgNqVOw2rU716Q5IyKBSSqyJ/bm+5AFv2CYVgdR1glZQeHKh9VgdsanhTVTA/fampAzdUIKIXN+ZVmPyeQXkGCieIETDJ5VuLdP22fEM7TrcnEkVDXjiQFpOAiiEPoZMjasL7/HBSHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932970; c=relaxed/simple;
	bh=qDqpB+vgdxTrCsO26iMQ3Xxoa1DPhryXB+kX0cNj7jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUZOkHoHfTAarQyyUxEnZutY9/bSRjUG8AGjOgdJRw71D3X2uQ/GffCcwNxCmp35pP1bRd9ElZHDINPwodmbIc35SQwbs7mDP48vWOW20nmfWz5ydGzWK7jxslIgBVVhn3h1ORoPIuZJFQyhZkM+lNLpJ/Lp7rI0t+3fxQM3wro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8VGh4IA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78016C4CECC;
	Mon, 18 Nov 2024 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731932969;
	bh=qDqpB+vgdxTrCsO26iMQ3Xxoa1DPhryXB+kX0cNj7jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8VGh4IARlhSqTaEqoD3MEReje0/QV6mP2/7HwPbFP28Dy+1DF9sjl+uK3lyw9zEd
	 IHl7w4ojjuREjmcMDC3skkkvBBSX+/vF9Is+iY1+gj3JtpbiYma/Q7OaenRFV/hdC+
	 S5zymIlXVvB5ZK9f8OOFynd3aTINw+kLc6v2B+2/pisjSLStFWqX8ta+/bo7Xv45OI
	 BRXkpBvG9Gcv280yzFaKFOc/Fll3I6UiZWJeQgGeGMt82vak3mxLtls63h136Fwv95
	 pn7DKP70V/zvEVDTdGMXnjifSYD4uzwjmRmZ7e4JC0Zr6xjGRxKwIflOU5mkkSLyeL
	 p87vciPfnfhLA==
Date: Mon, 18 Nov 2024 13:29:23 +0100
From: Niklas Cassel <cassel@kernel.org>
To: 412574090@163.com
Cc: dlemoal@kernel.org, James.Bottomley@hansenpartnership.com,
	andreas@gaisler.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	deller@gmx.de, edumazet@google.com, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.co, mpe@ellerman.id.au, ojeda@kernel.org,
	perex@perex.cz, sudipm.mukherjee@gmail.com, t.sailer@alumni.ethz.ch,
	weiyufeng@kylinos.cn, xiongxin@kylinos.cn
Subject: Re: [PATCH v2 1/4] parport: use standard kernel printing functions
Message-ID: <ZzszI9obKws73vgL@ryzen>
References: <39c7413a-aa51-4fb2-b949-3f4e3a53839f@kernel.org>
 <20241118023024.22287-1-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118023024.22287-1-412574090@163.com>

Hello weiyufeng,

On Mon, Nov 18, 2024 at 10:30:24AM +0800, 412574090@163.com wrote:
> > On 11/12/24 11:11, 412574090@163.com wrote:
> > > From: weiyufeng <weiyufeng@kylinos.cn>
> > > 
> > > change printk to standard kernel printing functions.
> > > 
> > > Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> > > ---
> > >  drivers/net/hamradio/baycom_epp.c |  8 ++++----
> > >  drivers/net/hamradio/baycom_par.c |  6 +++---
> > >  drivers/parport/parport_pc.c      | 12 ++++++------
> > >  drivers/parport/procfs.c          |  2 +-
> >
> > This is mixing changes for different drivers. Please split the net and ata part
> > into different patches and send the net ones to the correct list and maintainers.
> Yes, it will be updated in v3 version. Can you help review the patch for
> path2-patch4? If possible, it would be a great honor.

Sorry, that is not how it works.

If I look at patch 2/4, it changes all these files:
 drivers/ata/pata_parport/bpck6.c        |  2 +-
 drivers/ata/pata_parport/pata_parport.c |  2 +-
 drivers/auxdisplay/ks0108.c             |  4 +--
 drivers/net/hamradio/baycom_epp.c       | 10 +++---
 drivers/net/hamradio/baycom_par.c       |  6 ++--
 drivers/net/plip/plip.c                 |  2 +-
 drivers/parport/daisy.c                 |  2 +-
 drivers/parport/parport_gsc.c           |  8 ++---
 drivers/parport/parport_ip32.c          |  8 ++---
 drivers/parport/parport_mfc3.c          |  2 +-
 drivers/parport/parport_pc.c            | 42 ++++++++++++-------------
 drivers/parport/parport_sunbpp.c        | 24 +++++++-------
 drivers/parport/procfs.c                |  2 +-
 drivers/parport/share.c                 |  6 ++--
 drivers/scsi/imm.c                      |  8 ++---
 drivers/scsi/ppa.c                      | 10 +++---
 include/linux/parport.h                 |  4 +--
 include/linux/parport_pc.h              | 18 +++++------
 sound/drivers/mts64.c                   |  6 ++--
 sound/drivers/portman2x4.c              |  6 ++--

So we cannot give your Reviewed-by tag to this commit.

So please split the commit to the appropriate subsystems,
and CC: the proper mailing lists for each commit.
(Check the MAINTAINERS file.)

Then people will be able to review your changes.


Kind regards,
Niklas

