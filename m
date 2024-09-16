Return-Path: <linux-kernel+bounces-330291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6714979C26
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA01B223D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E413B2B6;
	Mon, 16 Sep 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DYB1wE3t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F36132103;
	Mon, 16 Sep 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472452; cv=none; b=HDJHwOV9tSh5775GEtv/eU4Py9UlbEATWmYTabZIwSBKJsT6P2aMUXhJFi6ExJYvTLb9tWxb5nyx2tzU5c4NgU3I0/fEjJcG3sww3/6MaIzQIIWk6IrIEk2+hABtx2U+7G/7gs1TuPMuh1ejHq+m5rQ0foF6Zl5upGl50YKDCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472452; c=relaxed/simple;
	bh=N1S4qn058a7rzx9R4IDM2YiSFwwswkfDmvXpwFuQN1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0lYhL3lEnSko7fe3NDb31fAx8iMeQS9vPs9moZ3SK6xMc/7VnMMgGgCV540RyyToI2nPXsw6folEoHlxJAgww/xzu7Zknyh+xBrnqTJEQ5OtIqKOJQBmFRXtsiSzi/65FfgZjmWnLY3BTE2VTc5bBG30LgXatWC/zi++5Jpm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DYB1wE3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59285C4CEC4;
	Mon, 16 Sep 2024 07:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726472451;
	bh=N1S4qn058a7rzx9R4IDM2YiSFwwswkfDmvXpwFuQN1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYB1wE3t6Zk871L+eS5mmsbDWVfK2zHFS4evqO6iIC4QSwkM9lRrW1Zi4RPQrPR/d
	 Li8SDiqzotqMVjbckBGYIQAwaf+5gMW00EgJWbSuzXWmQUKee4lVJX7m4W1CYyHQZc
	 Mu+rgEFx/QjUEImP2EcaK0OC/jsRW5auhxC8Bu8Q=
Date: Mon, 16 Sep 2024 09:40:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix spelling errors in file
 drivers/usb/gadget/udc/m66592-udc.c
Message-ID: <2024091606-armoire-lyrics-5bf8@gregkh>
References: <2024091626-trailside-grandkid-5f86@gregkh>
 <20240916052357.6487-1-everestkc@everestkc.com.np>
 <2024091639-tasty-relay-5082@gregkh>
 <CAEO-vhEYdfJ=zLQPPWv7eD6K=G28b_cjog+qBn+QHuQ2dp0u7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEO-vhEYdfJ=zLQPPWv7eD6K=G28b_cjog+qBn+QHuQ2dp0u7Q@mail.gmail.com>

On Mon, Sep 16, 2024 at 01:35:19AM -0600, Everest K.C. wrote:
> On Mon, Sep 16, 2024 at 12:52 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Sep 15, 2024 at 11:23:56PM -0600, Everest K.C. wrote:
> > > Fixed spelling errors in error message and comments that
> > > were reported by codespell as follows:
> > >       unexpect  --> unexpected
> > >       workaound --> workaround
> > >
> > > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > > ---
> > >  v1 --> v2: Removed the coding style fix. This patch now only
> > >           fixes spelling errors. The coding style will be fixed
> > >           in a separate patch.
> > >
> > >  drivers/usb/gadget/udc/m66592-udc.c | 18 +++++++++---------
> >
> > If you do:
> >         git log --oneline drivers/usb/gadget/udc/m66592-udc.c
> > you will see the format for how to properly write the Subject: line
> > here.
> >
> > As this is your first kernel contributions, I recommend working in an
> > area that is designed for new developers to help work through these
> > types of issues, drivers/staging/  Get some experience there before
> > moving out into other areas of the kernel.  Also note that many
> > subsystems do not care about things like spelling fixes, so be careful.
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> Thank you for pointing out my mistake with the subject line. I have noted
> and will keep that in mind when I submit my next patch.
> Also, do you mean the fixes like this need to be done in gregkh/staging.git
> repo? Do you recommend that I resubmit this patch with corrections or
> discard it ?

I mean start working in drivers/staging/ on issues there, not in
drivers/usb/, until you get the process working well for you, then worry
about moving to other portions of the kernel.

good luck!

greg k-h

