Return-Path: <linux-kernel+bounces-284117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA694FD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7DBB22A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D942262B;
	Tue, 13 Aug 2024 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OTD84jCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433121345
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723525985; cv=none; b=bHkURI0gpOgNA+jEnM/BzswNwhOmJwTqGLRGiSVXTBWEwdEtqkgR79Ipdjcwgnc7UiaRlsC9KztChGZiqvQrtgiIw1zK/s0Sxuhr213Z/CBZEo60GI8kyYV2WsA0pLcj1Ow4pQ+iaWgO5L/iqe/80Jz53IVaVZ3TBbATzixai1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723525985; c=relaxed/simple;
	bh=fq8pIBrcKsf2cWfAXmWVMPY2GtmcWbx9jO20zAVHRFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tURsasArKPoej389bM8q4trIQh+R3aQwRSmPKqU9EA0hbS9dDfREUN2OM8yL9xjgxJ/AlGAzcpUgjVO8X3OSQS0sgLsnOlrwfk+wjfAS/b/it6Httjyo/HkuSG9iVIGnu7R1Hbc9lZlrvWyz0PtRiHuSaglklkAtwIeMwiidHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OTD84jCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735BCC4AF09;
	Tue, 13 Aug 2024 05:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723525985;
	bh=fq8pIBrcKsf2cWfAXmWVMPY2GtmcWbx9jO20zAVHRFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTD84jCvvDHfJPQnt8gP2DKiFHpaenceqwi4ygkXOEar9DJpXhtDYgO6KvqKaV98y
	 LtqsBZSZMDrXXi+oTwWYelEPoMI+ZtVVhJ1S1zbjHVstBj51oGFZ1HVemlkc5bA5Lo
	 J6yGCM+SCXeNQVT5aYXCmAkJ8pGLSsrl5uR7Uzbk=
Date: Tue, 13 Aug 2024 07:13:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, arnd@arndb.de,
	masahiroy@kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, hridya@google.com,
	smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v1] add binder genl for txn report
Message-ID: <2024081341-egging-custodian-428d@gregkh>
References: <20240812211844.4107494-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812211844.4107494-1-dualli@chromium.org>

On Mon, Aug 12, 2024 at 02:18:44PM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>

Sorry, but I can not parse your Subject: line at all.  Please use
vowels, we don't have a lack of them :)

Also look at how other patches are formatted for these files to get an
idea of how to create a good subject line.

> Frozen tasks can't process binder transactions, so sync binder
> transactions will fail with BR_FROZEN_REPLY and async binder
> transactions will be queued in the kernel async binder buffer.
> As these queued async transactions accumulates over time, the async
> buffer will eventually be running out, denying all new transactions
> after that with BR_FAILED_REPLY.
> 
> In addition to the above cases, different kinds of binder error codes
> might be returned to the sender. However, the core Linux, or Android,
> system administration process never knows what's actually happening.
> 
> This patch introduces the Linux generic netlink messages into the binder
> driver so that the Linux/Android system administration process can
> listen to important events and take corresponding actions, like stopping
> a broken app from attacking the OS by sending huge amount of spamming
> binder transactions.
> 
> To prevent making the already bloated binder.c even bigger, a new source
> file binder_genl.c is created to host those generic netlink code.

"genl" is a rough abbreviation that is not going to be easy to remember,
what's wrong with "binder_netlink.c"?


> 
> Usage example (user space pseudo code):
> 
> 	// enable binder report from the interested binder context(s)
> 	struct binder_report_info info = {0, BINDER_REPORT_ALL};
> 	ioctl(binder1, BINDER_ENABLE_REPORT, &info);
> 	ioctl(binder2, BINDER_ENABLE_REPORT, &info);
> 
> 	// set optional per-process report, overriding the global one
> 	struct binder_report_info info2;
> 	info2.pid = getpid();
> 	info2.flags = BINDER_REPORT_FAILED | BINDER_REPORT_OVERRIDE;
> 	ioctl(binder2, BINDER_ENABLE_REPORT, &info2);
> 
> 	// open netlink socket
> 	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> 
> 	// bind netlink socket
> 	bind(fd, struct socketaddr);
> 
> 	// get the family id of binder generic netlink
> 	send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME);
> 	int id = recv(CTRL_ATTR_FAMILY_ID);
> 
> 	// register the current process to receive binder reports
> 	send(fd, id, BINDER_GENL_CMD_REGISTER);
> 
> 	// verify registration by reading back the registered pid
> 	recv(fd, BINDER_GENL_ATTR_PID, &pid);
> 
> 	// wait and read all binder reports
> 	while (running) {
> 		struct binder_report report;
> 		recv(fd, BINDER_GENL_ATTR_REPORT, &report);
> 
> 		// process struct binder_report
> 		do_something(&report);
> 	}
> 
> 	// clean up
> 	close(fd);

What userspace code is now going to use this and require it?  How was it
tested?  Where is the test code?  Where is the new user/kernel api that
you created here documented?

You added a new ioctl here as well, why not mention that?  Why is it
needed?  Why not always emit netlink messages?  How do you turn them
off?

And how does this deal with binder namespaces?  Are these messages all
now "global" somehow?  Or are they separated properly per namespace?

thanks,

greg k-h

