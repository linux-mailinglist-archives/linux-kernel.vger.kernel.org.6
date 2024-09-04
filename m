Return-Path: <linux-kernel+bounces-315216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580AD96BF6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029C71F21E27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7511DA62D;
	Wed,  4 Sep 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k3i+OgpO"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251B1EBFF7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458339; cv=none; b=Gc5zl693sKFeQuXjIvLlUfR02ANiXuOpJScu/g3JwrM4O4atOhG8c87fCk+0NdjXv/6HvzyEVhMkdxKFVTbWr5nrQ+JxfYfuf9365Debb1lHpwkZUHD15eVzfpRUmujX/PwSgHJ3TEOUc6JwX0vU9ShWUxyaUiBMqfzWisrxPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458339; c=relaxed/simple;
	bh=5pF5LKciR4HEMlpLl1ORC3QIc2KTUXEsYEoaOe3rU+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvsPq51oHkcR3PwDu2pBzGPMWoJi9hHo+yseUZjvwD/AkG9vz6v+XlSqOY7WjGvWazIxHNMX9zPXx712OUUTNDwKuzigFT4Xwx5dQCnd41yCl2dqQJQcvlP4tct6hQGjDlXyaq4XwdYJyYHbPdWY6UVXgsIiORWczDrTkysS/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k3i+OgpO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CK9YOQcn0hbEz+qWT2tHxZst0v4UHRaH0O0qQOoH9lk=; b=k3i+OgpOeCIHA7fQ5/hc/t+VD+
	u3z6QRz1mEvlKbRMETQMnquUsx6Ow+/ywHFtfViMkpUh2NbA1ruhYyac+kSbwO/gBG0hXyOl0tHaZ
	N0mPs4ZsW+++BiUp6BVguDSBwGXWq2HaoPJqtDUuKLN5S2B8ehVUJlvVaISNEufxusTyxy2ip5p+G
	XR6HbE4xhQVl/EZ5cdP2FxMPTl9UwC5jxjKe7uNnyZ1bVHY8uLVnMLaFU4xuqHnsvKWt9nnSFX6OH
	PGebqivzbg/TCoDPtUuhZI/5PJzBjBE87UnSJgYo7Dnggsxsta+MUR+DE/SrLwG8w+8dM9Tu7Rj/x
	6G4csvxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46704)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1slqWu-00015e-38;
	Wed, 04 Sep 2024 14:58:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1slqWq-0003mK-1s;
	Wed, 04 Sep 2024 14:58:36 +0100
Date: Wed, 4 Sep 2024 14:58:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, krzk@kernel.org,
	andi.shyti@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
	suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] amba: make amba_bustype constant
Message-ID: <ZthnjPjPB+6cMf9w@shell.armlinux.org.uk>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
 <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
 <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
 <Zs3Wt5xkFOiuH-iP@smile.fi.intel.com>
 <6774cd23-47f9-4d15-8954-a9f749998fe2@linux.dev>
 <Zs8jZiN1TvNfHQ9N@smile.fi.intel.com>
 <65c80deb-21e1-44eb-87c9-c7cdd36d77cd@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65c80deb-21e1-44eb-87c9-c7cdd36d77cd@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 29, 2024 at 09:31:29AM +0800, Kunwu Chan wrote:
> Thanks for the reply.
> On 2024/8/28 21:17, Andy Shevchenko wrote:
> > On Wed, Aug 28, 2024 at 10:51:54AM +0800, Kunwu Chan wrote:
> > > On 2024/8/27 21:37, Andy Shevchenko wrote:
> > > > On Tue, Aug 27, 2024 at 03:45:31PM +0800, Kunwu Chan wrote:
> > > > > On 2024/8/26 18:40, Andy Shevchenko wrote:
> > > > > > On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:
> > ...
> > 
> > > > > > Make it patch series:
> > > > > > 1) patch that introduces exported function called dev_is_amba() (1 patch)
> > > Done.
> > > > > > 2) convert user-by-user (N patches)
> > > I've no idea about how to modify, such as in iommu.c:
> > Oh, crap. Yes, this need more thinking.
> > Anyway, Russell is okay with your initial patch, the rest can be done
> > separately. For now probably we can leave it exported for this only case.
> > 
> Anyway, thanks for the suggestion, i'll   introduce the dev_is_amba function
> 
> and  add the Suggested tag for you.
> 
> If you have a better idea and need me to do it, you can always contact me.

General policy is not to add stuff that doesn't have any users. From
what I can see from briefly reading this discussion, and looking at
the patches submitted to me, the dev_is_amba() patch adds a helper,
but as yet there are no users - and not even any patches on a mailing
list to make use of this helper. Therefore, I won't be applying that
patch.

Good idea, but it needs users...

Please note that I likely won't be reading further discussion (see
my signature below, and I'm having the same op on the other eye -
which is the only eye suitable for screen work at the moment -
this Friday.)

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

