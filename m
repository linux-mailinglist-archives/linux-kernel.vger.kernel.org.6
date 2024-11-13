Return-Path: <linux-kernel+bounces-407129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA69C6930
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF012812B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B5717B425;
	Wed, 13 Nov 2024 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vl3BS6kn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAC17085A;
	Wed, 13 Nov 2024 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478695; cv=none; b=lTIfZgcI5MXH4XqGuUpQWNulUP36TOsDKsW7otPn6L4Q4F60N19JvbysCRqMjDzJoom6S0SYvSpGY1L7ZFdIOutnkJDXZW5giH7X7bjCiuRqGebUnXDwHhtzqUZh1zY0/MySOol8tvcSbH84mrCBQfJUF0tHaM71UCowInA5SGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478695; c=relaxed/simple;
	bh=zDxCVgumsYdvuBJYwURAZWWIMOmORpTsX8/yd6J0rko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzNULO8ijHCGicnhyaKmmfTNotFa9N3jaOcmoT0DLF0gNS45iPqx0lgfkwm9OsTfz8bqUGIpXplGwHLPXD7vP3+OkY6etXJ6Z5qQfUNzR5LAe2936HJBONO81vaIkvLW2/cf1UThrrd1+ijCuwx93eBV4H/nEZ7oUw9+SI3wli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vl3BS6kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BF1C4CECD;
	Wed, 13 Nov 2024 06:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731478695;
	bh=zDxCVgumsYdvuBJYwURAZWWIMOmORpTsX8/yd6J0rko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vl3BS6knAEmeN4lA5Yr1YLMsmHn8Q+3Zwk+zvchIarPaxy6WlU91TGYUpzQX8QAlp
	 0FwBd1OV8dDy2JtJMjwIX0rwvlOrEdS4ySUOOXUa+Qsjh/0vCDGqFAzvxQMpSOp0CF
	 xxTLbs3R21Y6VH2Ahse3h/wKtsOaqyqwfB608Szc=
Date: Wed, 13 Nov 2024 07:18:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason fab <siliconfab@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: VTIO support on USB
Message-ID: <2024111339-monogram-refried-f189@gregkh>
References: <CAHXL5pfQjhpANBxNY1YjURhWwU17WD9gX4rDqi4ezYOKeFs=gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHXL5pfQjhpANBxNY1YjURhWwU17WD9gX4rDqi4ezYOKeFs=gQ@mail.gmail.com>

On Wed, Nov 13, 2024 at 11:27:47AM +0530, Jason fab wrote:
> Hello,
> 
> I would like to know if the linux kernel usb subsystem supports
> Virtualization based Trusted IO Management (USB VTIO)?

What exactly is that, I can't seem to search for it and have not heard
of it before.  Do you have a link to it somewhere?  Is there a USB.org
specification published for it?

thanks,

greg k-h

