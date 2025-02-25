Return-Path: <linux-kernel+bounces-532295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D958AA44B23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18FFD7A9C30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BADE1A2567;
	Tue, 25 Feb 2025 19:15:12 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672A1917F1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510911; cv=none; b=dWucaMFWafJOXh1GA2up9JYkkckvzv7zl9x6yTJ4jyaNsV+d5Gl2CLsdEao+AnqCOI/ECSAlB2Yzh5LPfGhTqwJUGsEZ87fDu2FxaK1lZQhEHbthsE5aI8nBwoN0Eiiy0haIgFOo8C9c0WFUX3slA2Ge9NdbLn+vTcx4bxB5sCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510911; c=relaxed/simple;
	bh=GE+T00s9Gkl4VgJz8rKYqK53bfXaAZFrgk4B4xLv2Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apRzyO1XDEjis34zvI9PmzD0aHyM7BSe6un7cQ92tuIhkGlrejcBseK4Gs+gOuNnqE7U1DHfj6B0+W++q3xOsyLE6jpPS8h2d9XNrCrGG1guzvzDuoSSO0XyHeo7h3SvpFrD89obGwIopcWJFqwtQk/LDE0hvOSQa9E/2pY00eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1tn0OW-005gaG-FX; Tue, 25 Feb 2025 20:15:04 +0100
Received: from laforge by nataraja.fritz.box with local (Exim 4.98)
	(envelope-from <laforge@gnumonks.org>)
	id 1tn0Ho-00000000kIs-003o;
	Tue, 25 Feb 2025 20:08:08 +0100
Date: Tue, 25 Feb 2025 20:08:07 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, david@rowetel.com
Subject: Re: users of drivers/misc/echo ?
Message-ID: <Z74VF1Uw5sRVbXhy@nataraja>
References: <Z7tZhYET41DAoHVf@gallifrey>
 <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
 <Z724l3DFJbGevtPF@nataraja>
 <Z72_EnXyHoDACRk5@gallifrey>
 <Z73MevharqkC5dt8@nataraja>
 <Z74OSsZqeboJml9c@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z74OSsZqeboJml9c@gallifrey>

Hi Dave,

On Tue, Feb 25, 2025 at 06:39:06PM +0000, Dr. David Alan Gilbert wrote:
> > Actually, looking at DAHDI, I really don't think anyone is still using
> > the dahdi_echocan_oslec code.  It is disabled by default and only built
> > if explicitly enabled by the user, and indeed if anyone did that it
> > would fail to build for any kernels that have moved it out of staging.
> 
> It looks like Debian is including and enabling it in it's DKMS build:

thanks, I didn't realize that.  You could reach out to the Debian maintainer of the package
if you'd want clarification.

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

