Return-Path: <linux-kernel+bounces-562248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CC2A61FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D981756FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B7202F88;
	Fri, 14 Mar 2025 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Y1iOQCTY"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D02262BE;
	Fri, 14 Mar 2025 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990372; cv=none; b=OdhanqHu8GP+wlyEnMFhfGASrzYbl+G1YAJAUmX0UC1bC62OyvCj2J6mGYi5EpZWVN5fBbYOE13hB4KXk0dhIp0l5c84lBEh0nWGVrYTnwi3jUUnhh0QXY4po7/au7PEN4fFshT5qAIdwqF9QjUpaBzYKKB97m4U+0Rkn3jM5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990372; c=relaxed/simple;
	bh=hL+66E115ntnpF6K+ywl/R3ddgeL0xYnTtSbq7O1JFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI8ow2yJlnTQtQKGERZ0Jqky/mcqcaBEaq6aTXgwJqkgvBMhJ7xZ/kMt8ZGPBq1lxGo8x7qW1QgZ3QARuCEPrhWlFugtC3IDmGe73cHb3E3vnNb3xtlSfSXJcjIp9LXVF94T7Gs4RShBxfcy00bLNP434tBi71iBOcorn4mJv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Y1iOQCTY; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LaG+dv5kr3uIyhXDXcsmjcW8Aj8ijHXLR/ClgPL6Z/4=; b=Y1iOQCTYhVUuHmbcT9kpLjiSvN
	c5LGknYbiDfdPqm1gnQ4iPGAQL09CIwr8F0V05za+ErclxgjCDgBGPIckNQGDMSHYXW8ql8UveXkk
	m+fiP5USRBcxJ8zmZRmIWL+TZnYqlOqMt3rMxqvvNQlt9AcyV9ZpCsXyUXVmJe0ADeN7kptzWOFt/
	sSQy6zh1/Bwg38sUEV35Wa0c5SLjgJdyD2nmvxd3GRFxOU3pXkzXwm1u5MLVTE3oZSv5NWfhYolmq
	qi0kHWQIFT9vbJMJkQIfen2muGWNQZZHURHYAT5gVAHOgF/Q8f8FktUE3/TwXW567vxhI4kj0wnDv
	kGZuvDWA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1ttDGr-00EMvu-20;
	Fri, 14 Mar 2025 17:12:50 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: corbet@lwn.net, Su Hui <suhui@nfschina.com>
Cc: Su Hui <suhui@nfschina.com>, wine-devel@winehq.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 4/4] docs: ntsync: update NTSYNC_IOC_*
Date: Fri, 14 Mar 2025 17:12:49 -0500
Message-ID: <3301384.aV6nBDHxoP@camazotz>
In-Reply-To: <20250314071454.201697-5-suhui@nfschina.com>
References: <20250314071454.201697-5-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 March 2025 02:14:54 CDT Su Hui wrote:
> Some macros in the document do not match the code and the header files,
> correct these macros according to the definitions in the code.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  Documentation/userspace-api/ntsync.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/userspace-api/ntsync.rst b/Documentation/userspace-api/ntsync.rst
> index 25e7c4aef968..969774bf4c60 100644
> --- a/Documentation/userspace-api/ntsync.rst
> +++ b/Documentation/userspace-api/ntsync.rst
> @@ -152,9 +152,9 @@ The ioctls on the device file are as follows:
>  
>  The ioctls on the individual objects are as follows:
>  
> -.. c:macro:: NTSYNC_IOC_SEM_POST
> +.. c:macro:: NTSYNC_IOC_SEM_RELEASE
>  
> -  Post to a semaphore object. Takes a pointer to a 32-bit integer,
> +  Release a semaphore object. Takes a pointer to a 32-bit integer,
>    which on input holds the count to be added to the semaphore, and on
>    output contains its previous count.
>  
> @@ -186,7 +186,7 @@ The ioctls on the individual objects are as follows:
>    unowned and signaled, and eligible threads waiting on it will be
>    woken as appropriate.
>  
> -.. c:macro:: NTSYNC_IOC_SET_EVENT
> +.. c:macro:: NTSYNC_IOC_EVENT_SET
>  
>    Signal an event object. Takes a pointer to a 32-bit integer, which on
>    output contains the previous state of the event.
> @@ -194,12 +194,12 @@ The ioctls on the individual objects are as follows:
>    Eligible threads will be woken, and auto-reset events will be
>    designaled appropriately.
>  
> -.. c:macro:: NTSYNC_IOC_RESET_EVENT
> +.. c:macro:: NTSYNC_IOC_EVENT_RESET
>  
>    Designal an event object. Takes a pointer to a 32-bit integer, which
>    on output contains the previous state of the event.
>  
> -.. c:macro:: NTSYNC_IOC_PULSE_EVENT
> +.. c:macro:: NTSYNC_IOC_EVENT_PULSE
>  
>    Wake threads waiting on an event object while leaving it in an
>    unsignaled state. Takes a pointer to a 32-bit integer, which on
> @@ -213,7 +213,7 @@ The ioctls on the individual objects are as follows:
>    afterwards, and a simultaneous read operation will always report the
>    event as unsignaled.
>  
> -.. c:macro:: NTSYNC_IOC_READ_SEM
> +.. c:macro:: NTSYNC_IOC_SEM_READ
>  
>    Read the current state of a semaphore object. Takes a pointer to
>    struct :c:type:`ntsync_sem_args`, which is used as follows:
> @@ -225,7 +225,7 @@ The ioctls on the individual objects are as follows:
>       * - ``max``
>         - On output, contains the maximum count of the semaphore.
>  
> -.. c:macro:: NTSYNC_IOC_READ_MUTEX
> +.. c:macro:: NTSYNC_IOC_MUTEX_READ
>  
>    Read the current state of a mutex object. Takes a pointer to struct
>    :c:type:`ntsync_mutex_args`, which is used as follows:
> @@ -242,7 +242,7 @@ The ioctls on the individual objects are as follows:
>    ``EOWNERDEAD``. In this case, ``count`` and ``owner`` are set to
>    zero.
>  
> -.. c:macro:: NTSYNC_IOC_READ_EVENT
> +.. c:macro:: NTSYNC_IOC_EVENT_READ
>  
>    Read the current state of an event object. Takes a pointer to struct
>    :c:type:`ntsync_event_args`, which is used as follows:
> @@ -255,7 +255,7 @@ The ioctls on the individual objects are as follows:
>         - On output, contains 1 if the event is a manual-reset event,
>           and 0 otherwise.
>  
> -.. c:macro:: NTSYNC_IOC_KILL_OWNER
> +.. c:macro:: NTSYNC_IOC_MUTEX_KILL
>  
>    Mark a mutex as unowned and abandoned if it is owned by the given
>    owner. Takes an input-only pointer to a 32-bit integer denoting the
> 

Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>



