Return-Path: <linux-kernel+bounces-284390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11035950071
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29EC286A66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AD613C8E2;
	Tue, 13 Aug 2024 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hj3jxyDj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA56A8CF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539248; cv=none; b=E5SmlqUgpB3q3F2A8q8UOhusaJ78XUE5VeR+muChByFTAKdzedbTL2iQwkfhM7c4GhzlExenIc+s+beI6YnZCmWzpYD11Xv3yE8nBSqWu+zbmAnzrYxQY7E7r9C05ww91P4d7okl90QqQPk1p2tMdqEg37o1EO6flFd0fWtAcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539248; c=relaxed/simple;
	bh=PYQvb3QgokLc6WRHufvan9FQ+oyfNGZflZUttXxrAUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuBVHvrDUGn8i6mDmOfIPLzJMNg7LqAt4+030jgte55viLshnY679K5ExzFvOaZtbnxwZ2a6gi8yAvlNKf4kIm5cZpHTVk5gjHotBo1OQGSTfqnI6ZXm8PMaawRnySaJPHY7698ZzIG/dPqw07ufrQYkra5NY9QA2MuMqQeWjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hj3jxyDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06330C4AF0B;
	Tue, 13 Aug 2024 08:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723539247;
	bh=PYQvb3QgokLc6WRHufvan9FQ+oyfNGZflZUttXxrAUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hj3jxyDjs2MM6/7OdgT5MNAPBiPLOCXP8p7tty2b7qHp4zWTb0cms9AcHUW8k82RU
	 YoVkKWiZv5PYiY3u4Ih2aTIlyVCmzOGGas2zSxM1R3/ctsetFhopqJgfB0CR9s0PzG
	 SEYijVLS1GmT+nuU3Tn5EiEiNbUFgfG7ie/JPBDc=
Date: Tue, 13 Aug 2024 10:54:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhang Ning <zhangn1985@outlook.com>
Cc: Andy Shevchenko <andy@kernel.org>, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID: <2024081349-erupt-reaction-efaa@gregkh>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
 <TY2PR01MB3322AAB13DBBB16C334A5D39CDBB2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR01MB3322AAB13DBBB16C334A5D39CDBB2@TY2PR01MB3322.jpnprd01.prod.outlook.com>

On Sat, Aug 10, 2024 at 01:27:18PM +0800, Zhang Ning wrote:
> On Fri, Aug 09, 2024 at 05:09:49PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> > > On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > > > > Hi, Greg & Rafael
> > > > > 
> > > > > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > > > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > > > 
> > > > > after check source code, I find irq for these two devices are 0, when
> > > > > use platform_get_irq, it will alway fail.
> > > > > 
> > > > > 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > > 		return -EINVAL;
> > > > > 	return ret;
> > > > > 
> Hi, Greg
> 	One more question, I don't understand why 0 is not a valid IRQ
> 	number for platform device?

Please search the archives for many many many discussions about this.

thanks,

greg k-h

