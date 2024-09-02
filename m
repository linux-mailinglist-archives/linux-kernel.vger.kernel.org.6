Return-Path: <linux-kernel+bounces-310656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BB2967FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3482B21B42
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FEA15C13F;
	Mon,  2 Sep 2024 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1mDvVBCP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362D154BEA;
	Mon,  2 Sep 2024 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259971; cv=none; b=Zht80XC2M06Z+Sb+NbyoKGRGSGtd7lIOC9YadjMDFvZC0KoiQ1AKuOhzI61MTIJRQl/5d9tnCjccJyzV4ImHL647WFE2TGQwFYq1PtcgAlhxx4L42K0VpRtMJ0hhQCrI75GeCHfx1EX9c6JzmX7d3SQ1fEUx2SOYORT4RwV4rR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259971; c=relaxed/simple;
	bh=S7CC/iZB7Rb45+kIN5CIjyVrAmEYMfx5cVaEEE8jWqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjmBuD4esoF09E9wQ4nlwQ6G3TZUm2pVE1Ia0kxbU1GFLmEQZ8NkI4YRjI1ERYLg/W25FXEm/+BiucUqA3ejl+Njm8sWe/12zLKmHvCvewCGY1N+ZDvdC05kilbB1Wb0jtqTDFUj3BZ9N1E5tMW3FAcSpL80VdPxdge5Le5Pu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1mDvVBCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B82C4CEC2;
	Mon,  2 Sep 2024 06:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725259970;
	bh=S7CC/iZB7Rb45+kIN5CIjyVrAmEYMfx5cVaEEE8jWqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1mDvVBCPMlKjCYN/We32c/kbyKdhhCTbVr95zuf8FmDGgkw1NYTl9LOeAZpPVYFY8
	 uiZhhyNAHddSgiMIzpVPiVXydcVXmHjnqQf8H2BjIiI5een4FYCptgOhzIWrmqZ7AJ
	 jbrwkj4ofijmEddu9no9JZuDi/Psh/49ohqHmMXk=
Date: Mon, 2 Sep 2024 08:52:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: Re: [PATCH] USB: serial: option: add support for
 Foxconn T99W651
Message-ID: <2024090202-sauna-unsent-c373@gregkh>
References: <20240705081709.105496-1-slark_xiao@163.com>
 <Zoe3qBwWG33AZaU9@hovoldconsulting.com>
 <5b098485.965d.190822996fc.Coremail.slark_xiao@163.com>
 <Zoe7RT7o39C7iXmA@hovoldconsulting.com>
 <43cc2529.9d61.190823e694a.Coremail.slark_xiao@163.com>
 <2024070538-circling-ambiguity-908f@gregkh>
 <6c85e8f3.4bab.191b0e374ee.Coremail.slark_xiao@163.com>
 <2024090237-pacemaker-natural-e0ff@gregkh>
 <4669a740.6a05.191b17bc3e0.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4669a740.6a05.191b17bc3e0.Coremail.slark_xiao@163.com>

On Mon, Sep 02, 2024 at 02:46:04PM +0800, Slark Xiao wrote:
> 
> At 2024-09-02 13:59:28, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Mon, Sep 02, 2024 at 11:59:42AM +0800, Slark Xiao wrote:
> >> At 2024-07-05 17:39:56, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >> >On Fri, Jul 05, 2024 at 05:34:06PM +0800, Slark Xiao wrote:
> >> >> 
> >> >> At 2024-07-05 17:22:13, "Johan Hovold" <johan@kernel.org> wrote:
> >> >> >On Fri, Jul 05, 2024 at 05:11:22PM +0800, Slark Xiao wrote:
> >> >> >
> >> >> >> I have a concern about the test result of "usb-devices" in Ubuntu
> >> >> >> 22.04. Do you know why it wouldn't show our devices any more? 
> >> >> >
> >> >> >No, sorry, no idea. Everything seems to work here with the latest
> >> >> >usbutils-017.
> >> >> >
> >> >> >Is it just your devices that no longer show up or doesn't it work at
> >> >> >all?
> >> >> >
> >> >> A lot of devices missed in Ubuntu 22.04, especially for modem devices.
> >> >> Nothing would be printed for modem devices.
> >> >
> >> >What specific version of usbutils are you using?
> >> >
> >> >If you pull from the github repo, can you try the version there?
> >> >
> >> >And if that has problems, a diff of both working and not-working would
> >> >be great.
> >> >
> >> >thanks,
> >> >
> >> >greg k-h
> >> Hi Greg,
> >> I reproduced this issue again. And now I checked it with different usbutils
> >> version one by one.  Version 014 has this issue. Both 013 and 015 works well.
> >> Please see attached log:
> >
> >So this is fine now with the latest version?  Note that 015 was released
> >way back in 2022 and that is even quite old, 017 is the latest release
> >of usbutils.
> >
> >A problem in usb-devices was fixed in the 015 release, dealing with
> >recursion and overwriting existing variables, so odds are that is what
> >fixed the problem you were having.  Please just use that or newer and
> >all should be fine.
> >
> >thanks,
> >
> >greg k-h
> Yeah, now I am using V017. BTW, the default of usbutils of Ubuntu 22.04.4 LTS is 014.
> So may I know do you have any plan to fix it since 22.04 LTS still under maintain.

How can I go back in time to fix that version?  :)

That's up to Ubuntu to resolve, there's nothing I can do, sorry.  Please
contact them and get them to resolve it as that's what your support
contract with them should provide.

good luck!

greg k-h

