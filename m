Return-Path: <linux-kernel+bounces-337726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C175C984E06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DBA1F24E28
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7F1AC8B1;
	Tue, 24 Sep 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UMVXgnwR"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D92C1AD3E0;
	Tue, 24 Sep 2024 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217853; cv=none; b=aI60vPg1jCXsyy7CU2v4SMCJi7Oo7heYi/aN08JAT/jGJQ5mZgP8nZW2kvVcQ494jrHbzNrqMpmj/luTv9LHFfQCVLxsFHEJezZUkQcEsVs//2juR7UH89SrNGwSPKfc0w5TR8vtwZFNm8+SFlyd09B5MBKSfhInbAKlaR8c5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217853; c=relaxed/simple;
	bh=1kak7Papg+REt0YX9qEAPqyd0bv8zJRl0skoenBu4Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsuot/I8OkNjlYB5WNMMQzMgbPTXYoZ17RAY7btCl22wMB0OIHJ344Zy+Xi0gw2X2MYvW5eHL4yd7ZUvuddnFytnxSAY+z+AMIxC6RXHRj4Og2Jw831IeqtbsMdBMqEnq310oHBxgjwL925FJSEzKbbogxTOanUIZCqK71aI7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UMVXgnwR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IIQp0fRS7W4DUEIrqrSf6cHBI+Xpz5AzpoihIU8mkY0=; b=UMVXgnwRJoohfetEiSKOCMwFSf
	9exaMvMbJWlLxNI2qwm1q/J7FFqtVvH7OEzUP31x47dJPc3t+VVQpNrBxoj6CUlmATQ8mgqqZRqw1
	0GsxMl8cO2R3vx23sKuatXPMQwf4yIbp2GdwGfzcakpD4e8rWIc615AubZjeUkSu3VvxeJeAgd5WF
	D9mKzyFYnZ5a+G51Xo/pbeulxQ2CHvNNzcVkY2OJBslnGBsiRX71Q9oitwXA4b/8Tp2FCL9vpVUjh
	6/RxNwLCmri8W5hesrDL1DwjafIH3L3shMteym3zHNN8gDveoyaSYlYNNBTnmbkyMMSvdW6qdP0aN
	iGBwSoXg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39768)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1stEGJ-0005vY-1Z;
	Tue, 24 Sep 2024 23:44:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1stEGF-0006ki-3D;
	Tue, 24 Sep 2024 23:44:00 +0100
Date: Tue, 24 Sep 2024 23:43:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Rob Herring <robh@kernel.org>
Cc: Kunwu Chan <chentao@kylinos.cn>, saravanak@google.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] amba: Add dev_is_amba() function and export it for
 modules
Message-ID: <ZvNAr0d5gYmuM+Zt@shell.armlinux.org.uk>
References: <20240923094249.80399-1-chentao@kylinos.cn>
 <20240923094249.80399-2-chentao@kylinos.cn>
 <20240924222857.GA404805-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924222857.GA404805-robh@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 24, 2024 at 05:28:57PM -0500, Rob Herring wrote:
> On Mon, Sep 23, 2024 at 05:42:47PM +0800, Kunwu Chan wrote:
> > Add dev_is_amba() function to determine
> > whether the device is a AMBA device.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> >  drivers/amba/bus.c       | 6 ++++++
> >  include/linux/amba/bus.h | 5 +++++
> >  2 files changed, 11 insertions(+)
> 
> Russell, Can I get an ack for this to take it with patch #2.

Would be nice to discuss "how shall we merge this cross-subsystem
patch series" first, hmm?

The reason I didn't take patch 1 originally is because it was submitted
to me without any users, and the general principle is not to accept
patches without users. Too many times, I've merged code where there's
been a "promise" that it will be used, only to have the author go
silent and users never come along. So now, my rule is... any code that
adds something must also come with its user.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

