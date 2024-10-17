Return-Path: <linux-kernel+bounces-370363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7489A2B83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1B31F25CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA31E04A6;
	Thu, 17 Oct 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb8OutvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78561E0484;
	Thu, 17 Oct 2024 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187728; cv=none; b=ReCdjcxt1N2iL7TG78pv4R2i8/rdTEgkvpOGl+Sh8XGJpkte4c9HI5LUHtC+Qy5hNyFy8yNa5dGdXFmiT26sAW6MR6QbwACF4eCY6aPrv72GWwVpQ3BfUjM1CAnBsehf9BFJZs/NvyLC7n7RGg6XTs4DUy3VIIjGd3T+xzYLJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187728; c=relaxed/simple;
	bh=UoZIjoquc7ianrvVX05sSUHV7hg2qpqSbdJFzAVzsU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1UGdIIJ7ErmCUyfPxL9z2jZT5gIRtlU3v+vYfwJIQooBGUxdHvbFd8GTYulZL0ONHaPDsH1Zz33lZ8LxFRH97MFaj7EioGMuna947eY+369ManbBMp0vVzkDTifgEIkKC3n/F3vVMgJ0mJtBSdIsDIYotryqBM7RshiGe6+x+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb8OutvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C41C4CEC3;
	Thu, 17 Oct 2024 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729187726;
	bh=UoZIjoquc7ianrvVX05sSUHV7hg2qpqSbdJFzAVzsU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mb8OutvS+HulwhEvASibptQnz7JsKTs3lDxbpwDr/KgyH1R23Wmm7DUkekOo3hWx0
	 fvRDb16lthRGCzAHDP7gXUDhSs2+8I3MzDSAWIDRhlAzaBzvoWiZPOyzP8faPMWf3+
	 dJsXv561uK/Kh0ic5L6vBNruWehnd89IfyHuWREVCytJWlKRaKMJd1HRRMOngtJYl4
	 C9FAkPQpn4uK8QuuU1TH4lhq44JcVEbHErLztouGkAdc4p6vxnyKA+3JL6E1HkHlLC
	 kMuU6f6gK80g8sVJXnl0QpY6/sy+qJ8tkwk1fpeM+G/rUx6KyPhl2M5jDlOo6TKRZP
	 hM6+DQ4kfp59Q==
Date: Thu, 17 Oct 2024 18:55:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Yang Li <yang.lee@linux.alibaba.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] iio: imu: bmi270: Remove duplicated include in
 bmi270_i2c.c
Message-ID: <20241017185507.547c5505@jic23-huawei>
In-Reply-To: <v3xzvojyycil7jszgxfnrwjiqxonz6aqrmfs6hgmru7pfuzgyv@3qrbzqo6p5mk>
References: <20241016003919.113306-1-yang.lee@linux.alibaba.com>
	<v3xzvojyycil7jszgxfnrwjiqxonz6aqrmfs6hgmru7pfuzgyv@3qrbzqo6p5mk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 22:31:57 -0400
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> On Wed, Oct 16, 2024 at 08:39:19AM +0800, Yang Li wrote:
> > The header files linux/module.h is included twice in bmi270_i2c.c,
> > so one inclusion of each can be removed.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11363
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> > ---
> >  drivers/iio/imu/bmi270/bmi270_i2c.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> > index e9025d22d5cc..71cc271cdf30 100644
> > --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> > +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> > @@ -3,7 +3,6 @@
> >  #include <linux/module.h>
> >  #include <linux/i2c.h>
> >  #include <linux/iio/iio.h>
> > -#include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/regmap.h>  
> 
> Good catch!
> 
> Minor nit: Should remove the top module.h include instead to keep
> alphabetical ordering.
> 

Given I messed up the pull request anyway, I've snuck this one is
as an obviously fine last minute tidy up. With the other entry removed as
suggested.

