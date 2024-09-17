Return-Path: <linux-kernel+bounces-331518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3EA97ADC5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C5E1F24090
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CE115958E;
	Tue, 17 Sep 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="puMJTVxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11394594A;
	Tue, 17 Sep 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564899; cv=none; b=sbBaHOq6UF6/wWFZ7f1+GP6hpT1vnMvguoOcHOYQ/6p4FJ0f3LTPn7ukhvXQZcNR1+wYpPgsy7DeQ8F2Lk8vBRwt2wQltM23hmVCbDKQ8ATz/H8Sg34EompEhoJs+lWC11kuUfP/XfEZ+Z55nfl65p6E8Q1Utidzc/WQp+vrcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564899; c=relaxed/simple;
	bh=R1iqgmx+CMAzHieMLoPMrwkljgV4c7hm0z+Zyu3WcgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk5YZFjZUUIEoLFh6NbEo3rE8DTU05GQ9N18raIKSVxMMqMCQIDZEYoLSY99XRuiW11qcsaRXuRPOWbFmntzslRSd6B+X8AORYn8oQNRIQJNUi5Gl7Ex/hapF0qUOnA0TuqXj6l4OK8lBhrF/qfA7cRlMd0kaQx3FJ4LVc2kNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=puMJTVxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A590C4CEC5;
	Tue, 17 Sep 2024 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726564899;
	bh=R1iqgmx+CMAzHieMLoPMrwkljgV4c7hm0z+Zyu3WcgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=puMJTVxZSWsz62fJ18IF/MuwcOcZ73UlG089lAPo0fNTyluMojDcUVRZ0vtLwENu0
	 s9YmUUfbSaECrVKLgJ/hJMJW6BB65bFFrnRDs3qJpv1KM7rlkqkvX3cL0uRz1Os5rc
	 7GJwtPuObIBqF9guJJcJ9mDwZDmNFboRlqu6fp0E=
Date: Tue, 17 Sep 2024 11:21:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, yoshihiro.toyama@sony.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
Message-ID: <2024091747-monorail-unbutton-7ebd@gregkh>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh>
 <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
 <26fed82b-7c60-4fda-8951-b22654728743@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26fed82b-7c60-4fda-8951-b22654728743@kernel.org>

On Tue, Sep 17, 2024 at 11:03:14AM +0200, Krzysztof Kozlowski wrote:
> On 17/09/2024 11:06, Nayeemahmed Badebade wrote:
> > Hi Greg,
> > 
> > Thank you for taking the time to check our patch and provide
> > valuable feedback. We appreciate your comments/suggestions.
> > 
> > Please find our reply to your comments.
> > 
> > On Fri, Sep 13, 2024 at 06:36:38AM +0200, Greg KH wrote:
> >> On Wed, Sep 11, 2024 at 07:53:17PM +0530, Nayeemahmed Badebade wrote:
> >>> Hi,
> >>
> >> If Rob hadn't responded, I wouldn't have noticed these as they ended up
> >> in spam for some reason.  You might want to check your email settings...
> >>
> > 
> > I have ensured standard settings which we have been using are used this
> > time, let me know if this email is received properly.
> > 
> >>> This patch series introduces a new framework in the form of a driver
> >>> probe-control, aimed at addressing the need for deferring the probes
> >>> from built-in drivers in kernels where modules are not used.
> >>
> >> Wait, why?
> >>
> > 
> > We have a scenario where a driver cannot be built as a module and ends up
> > as a built-in driver. We don't want to probe this driver during boot as its
> 
> Fix this instead.

Agreed, that should be much simpler to do instead of adding core driver
code that will affect all drivers/devices because just one driver
doesn't seem to be able to be fixed?

What driver is this that is causing the problem?

> > not required at the time of booting.
> > Example: drivers/pci/controller/dwc/pci-imx6.c

Just this one?  I don't see anything obvious that can't turn that into a
module, have you tried?  What went wrong?

thanks,

greg k-h

