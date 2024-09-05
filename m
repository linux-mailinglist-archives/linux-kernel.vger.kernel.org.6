Return-Path: <linux-kernel+bounces-316448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0F96CFBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B8D1C22771
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C6A192583;
	Thu,  5 Sep 2024 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UOlctXAy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003A42C0B;
	Thu,  5 Sep 2024 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518997; cv=none; b=UcKvxZ8EWWD/nthdHgGSUp3xaBng7qDTy9k3bup0/s1xiHkiS1shVlgMNmb9W+XlXgvUe6TIvTFOEFqCeFqaGJUU3vxLI6k/k3dgetbtsY7OHDDAJIjr22KPLf1yX+eLn7j4IHTVAkDFMYLi623Pq7+BzRV5S73z2XApjcaZTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518997; c=relaxed/simple;
	bh=8SJlBOk9n+f7fVtMJCiDy+hk2CT0quz2Ay4YrW8J1Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNgsfDjbdhSrNY7ngwGM5rlGtQa6U6Z/+08QDktDxUbGAnYvhiY4ksxMTWyVJqSWICJg2uONa5LcBqtH8c3wjnZ+QFdqZvv6SvfIOrIR0NBQP63yK3evNdRkHuy6SLomf9ZCBJO/KIhhboSPwMT3ljE5VmTp/+XftXklFkdYiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UOlctXAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2422EC4CEC4;
	Thu,  5 Sep 2024 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725518996;
	bh=8SJlBOk9n+f7fVtMJCiDy+hk2CT0quz2Ay4YrW8J1Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOlctXAy+nQ35ggRWlzEeeo2mDukjm8eWSgD/ZrFJuVaiZZEXlSkrw4pLoOufgfik
	 w/fU9S4SixqW8JuBsp4k4x0C+pShZ+nYGTDdE6OaKq/DrAlWb1ySoNErJtprYGeL6B
	 cd+AkUwUDHOGEHlRa0Sr6sK5bxsECMgD+kH6L+14=
Date: Thu, 5 Sep 2024 08:49:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jorge.lopez2@hp.com,
	acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: linux/usb.h: Move USB port definition to usb.h
Message-ID: <2024090522-suggest-overpay-9fba@gregkh>
References: <20240905042447.418662-1-kai.heng.feng@canonical.com>
 <2024090516-battering-prompter-3f53@gregkh>
 <CAAd53p5tGvTh_zP8BdBu1o0t5=s_uBQuctKQcwCNwyHo6Fx7oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p5tGvTh_zP8BdBu1o0t5=s_uBQuctKQcwCNwyHo6Fx7oQ@mail.gmail.com>

On Thu, Sep 05, 2024 at 02:24:31PM +0800, Kai-Heng Feng wrote:
> On Thu, Sep 5, 2024 at 1:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 05, 2024 at 12:24:46PM +0800, Kai-Heng Feng wrote:
> > > Move struct usb_port to linux/usb.h so other subsystems can use it too.
> >
> > These really are "internal to the usb core" functions and variables, I
> > am loath to export them as it requires that you "know" what the device
> > type is of something without any recorse if you get it wrong.  I
> > commented on patch 2/2 about that.
> >
> > Could we provide a usb core function for you instead to help out?  What
> > exactly are you trying to get access to on the USB bus that you need to
> > use here, the port or the device?
> 
> The device so the quirk can check its vendor and product id.
> 
> That means a function or helper that can return USB port/device from
> an ACPI path.

So you don't want the port, only the device.  Why not just search the
bus for a device, you don't care where in the acpi path it lives, right?
Or better yet, do this in the driver for the device itself, that's when
you know you have the right device.

thanks,

greg k-h

