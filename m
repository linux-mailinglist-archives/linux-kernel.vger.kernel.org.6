Return-Path: <linux-kernel+bounces-415879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA539D3D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641CA281AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6391AA7A4;
	Wed, 20 Nov 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rl8xdE18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC91A4F1B;
	Wed, 20 Nov 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112728; cv=none; b=BXW5yyXqmQO9ahsRlsnqp+8m5VAKCzoltYTMnwRqOnfn3kkK2irnXef2W2HJkV/5hZVsihsMOTPxZM0/yTq7dTjBkuvxzS7eXp/LQr+SQVFQct1YU/U3jdNajGIY4dJsWfAMaduJFFt1Z1zALL80KoJ69vcnSFcoMxyH/ItI/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112728; c=relaxed/simple;
	bh=y6qu8dBLA0LCgbdRq7LXfUlUzWcMqEAMFsWovlz6Unc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk+ypJpmCExe7Xv7i23/I0tnfB100lO+VnoTs+4VHCmK3fw9SCSd6MqhQafSMFWWca/oVeeRQDO6B0pmVEoAy4ajqPwvBsgdOp+xbgatEf6hu5cYkleu3utGXxnxiB5phAyQuA9a6/jpuVrC+JoKXW0Ge/AbkLLaKBkyWOiL4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rl8xdE18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47140C4CECD;
	Wed, 20 Nov 2024 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732112725;
	bh=y6qu8dBLA0LCgbdRq7LXfUlUzWcMqEAMFsWovlz6Unc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rl8xdE186zc9YHa9wdheQGVrp4/5QVCl/CW4AkkvQbPspSciM9q9phIJJ7KChVJOW
	 oDh/GZ5uDMq1CCRL9pehXvCz2viEY8+Vk3PqLnaAArnVvuQkZAIBh2I1C4JHn+McoI
	 64SDYeJ4482YWDHNlyvI4AfZDxTcn+NDG34ctLv8=
Date: Wed, 20 Nov 2024 15:25:00 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, "rbm@suse.com" <rbm@suse.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: remove unused sg struct member
Message-ID: <2024112037-grader-outsource-e821@gregkh>
References: <20241119212452.269255-1-luis.hernandez093@gmail.com>
 <20241119221907.tyt4luboduaymukl@synopsys.com>
 <Zz3vdkEzSobJ54bI@x13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz3vdkEzSobJ54bI@x13>

On Wed, Nov 20, 2024 at 09:17:26AM -0500, Luis Felipe Hernandez wrote:
> Thanks, Thinh and Greg, for the feedback!
> 
> On Tue, Nov 19, 2024 at 10:19:09PM +0000, Thinh Nguyen wrote:
> > > Previously, this patch addressed a documentation warning caused by the
> > 
> > Remove this paragraph. This context only makes sense in this thread
> > where the previous patch version is visible.
> > 
> 
> I’ll update the commit message and remove the unnecessary paragraph as suggested.
> 
> > > Reported-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > 
> > I'm not the one who should be attributed to by the Reported-by tag.
> > 
> > I think Greg was alluding to this report by Stephen Rothwell:
> > https://lore.kernel.org/all/20241118194006.77c7b126@canb.auug.org.au/
> > 
> > It wasn't Cc to the linux-usb list, so I'm not sure if you've seen it.
> > If your change was base on the report above, then you can update the
> > Reported-by tag accordingly.
> > 
> 
> Regarding the report by Stephen Rothwell, I wasn’t aware of it before. I found the warning independently while trying to compile the Documentation subsystem, looking for bugs to address.
> 
> That said, now that I’m aware of Stephen’s thread, I wouldn’t mind updating the commit message to include a reference to it if you think it would help link the two discussions. Let me know your thoughts on this.

Sure, it can not hurt, as it was reported by them, and fixed by you,
everyone gets credit!

thanks,

greg k-h

