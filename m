Return-Path: <linux-kernel+bounces-327219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32297727E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B17D1C23035
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F61BFDF6;
	Thu, 12 Sep 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXov8ImP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944413D530;
	Thu, 12 Sep 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171075; cv=none; b=lSWFwL852Z+zuHp/VvpwMeFjVdIk3A9v8FO/tY1HxywL5ZwvjWk307462NqVoTvuMZvNs1onpBRZSY5TGPFSEIqW1DrBCSoOrPRVwX+XBpyG6fRn75mNtyM8IO+DESAQ1Ps8X453IR0Lkv52GJKY+c5sB6SLx1YBkkF0qtnQkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171075; c=relaxed/simple;
	bh=RkWoI/SZq21kLXJf2EVrauT+m9UWfqNmPlRimV1ezzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT4x0CNiy/yb7h8bE6I4v6IdsBjl5bHx8L9u4KLiwWFiS0Q7ye7FuWsjC+vHgVs4Oq9rIOr01Yz2vfMlFkAXv/rC9OzQUXVUsbl2YIplhEWccJmEu8sF9eWrlTwb/tbcHGu+PMHe9wKP2HBXKJnozpC739w5+7DAWmwuoJng9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXov8ImP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E1DC4CEC3;
	Thu, 12 Sep 2024 19:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726171075;
	bh=RkWoI/SZq21kLXJf2EVrauT+m9UWfqNmPlRimV1ezzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXov8ImPFzo59RqnVIIl8zmbJsYop1wnJ5/qII/nwnNKmSmgMteRBK9HPc3K7vImt
	 zI3PLpJj/1TgrpU8fLn8ZvIm3hhtZMUeL7pgVa46bpTlqLjujppT9jSm/FAb5fLXiw
	 D0ksFHuly11cyayesqk6I1vEMPVhBBEdMR9ApZ9s9VOM/A4IOijQbKmwS+XT2cQxKO
	 jVxOP0twQrSrnxH1aJdStTl3/yTutEGiNiiU8zAlQ3oSTc2Vdds4+bsvwuAzd/Ujtr
	 2cBZC8f5j7p9/1bBuSXjnbw6g86CiXhjB9sXlWVzoWy/GuneTlxA021X6xbzFwS+tf
	 SfhhUnCmyrX3Q==
Date: Thu, 12 Sep 2024 14:57:53 -0500
From: Rob Herring <robh@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] of/irq: Use helper to define resources
Message-ID: <20240912195753.GA555349-robh@kernel.org>
References: <20240911160253.37221-1-vassilisamir@gmail.com>
 <20240911160253.37221-3-vassilisamir@gmail.com>
 <ZuHCJcTyQvfPl7ai@smile.fi.intel.com>
 <20240911173438.GA5015@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911173438.GA5015@vamoiridPC>

On Wed, Sep 11, 2024 at 07:34:38PM +0200, Vasileios Amoiridis wrote:
> On Wed, Sep 11, 2024 at 07:15:33PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 11, 2024 at 06:02:53PM +0200, Vasileios Amoiridis wrote:
> > > Resources definition can become simpler and more organised by using the
> > > dedicated helpers.
> > 
> > ...
> > 
> > > -		r->start = r->end = irq;
> > > -		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > > -		r->name = name ? name : of_node_full_name(dev);
> > > +		*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev));
> > 
> > Hmm... It seems you haven't replied to me why you avoid using Elvis here,
> > while at it.
> > 
> > Also for both patches you probably want
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > > +		r->flags |= irq_get_trigger_type(irq);
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> 
> 
> Hi Andy,
> 
> Thanks for your message once again!!
> 
> I honestly didn't know this operator, I just found out about it.
> Looks like it fits here, I can definitely use it.
> 
> I am going to leave it for a while to see if Krzysztof or Rob have
> any other comments and then I can send as you proposed.

No comments from me, please send with the updates.

Rob

