Return-Path: <linux-kernel+bounces-378417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5819ACFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ED41C21325
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE0A1CACDD;
	Wed, 23 Oct 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hjUcDR1t"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409D13B792;
	Wed, 23 Oct 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700113; cv=none; b=TNGURKnPQzKP9hE9SLMYqeaDFkAXFrhFeY2R15AMM5qqwtUrP5MQy5OtJVxnB79LwobxJJ6JKNDp5/kbRvdrRaqqS0PSFtNzD/97qnQt9mc/XLZVEJFuXOn/7BzxWD2kWfHd8OpLkrhxn6KNuhpg/uRJlp4+pxbwy/pQPoY44bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700113; c=relaxed/simple;
	bh=D/52lvRHKwbJIQpPwXo77l4J/agxz5DoMEYGv6PXfX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0r/XGsGXq3tPXinmElaJOIiYEMGg+6x8Q+WE8Xo4KWaD/7tPaXpe3uJtlnEc1BLYgm5XSIW9RAwk8ph6s0a4WbkofUTXyA8qXT8cukeOKJEURURLHXOMTTygpRT/19hL/ZTlgqIzmZdL/Uahb+IOUg2q+/QD9dp/JIIVqoBgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hjUcDR1t; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BF0E042C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729700109; bh=fIJfloZ8yBvdz0nXTszCb4O8l1k0DN3bSKxXpNY18ug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hjUcDR1tPwERcxct6O4PSc4QCrv5jSMA2tTCyClhyX0t+zIKaWv+JCeu8r6kv5sI9
	 pnGfefa3InEeCA6VbUk0ouJTOy3x5tOe+k4cesEOWSW8jLFFJ7lmMZhXo9VbXOzBYL
	 kV2Rsp3ji8YMbmjLs91zyFQ1kOULEsq8N4aDekVoabwxcI0k92X9w1wN9wcnAzstdW
	 9n5R7HbH7NnXNg1U5rIc64MHL/W1DTKKGPhL0EhLBz8Jc1WVgnOytOgmHzG9/l6RQQ
	 V0xgJx55ujb8DAZoH01PmEHVe+zikGznq7emsq9gFqF/Gb9QVQapXSeRC2rgYfAZ5m
	 s/QUzqiDAfc9A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BF0E042C17;
	Wed, 23 Oct 2024 16:15:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, anish kumar
 <yesanishhere@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Docs/sound: Update codec-to-codec documentation
In-Reply-To: <ZxkgCL2/JtDDJ9N1@opensource.cirrus.com>
References: <20241020163706.87123-1-yesanishhere@gmail.com>
 <ZxkgCL2/JtDDJ9N1@opensource.cirrus.com>
Date: Wed, 23 Oct 2024 10:15:08 -0600
Message-ID: <87sesmn6cz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charles Keepax <ckeepax@opensource.cirrus.com> writes:

> On Sun, Oct 20, 2024 at 09:37:06AM -0700, anish kumar wrote:
>> Updated documentation to provide more details
>> for codec-to-codec connection.
>> 
>> Signed-off-by: anish kumar <yesanishhere@gmail.com>
>> ---
>
> The patch doesn't seem to apply cleanly for me, my system doesn't
> seem to like:
>
> Content-Type: text/plain; charset="y"
>
> Not sure if that is a problem on my end or yours, but I am not
> familiar with that encoding.

That's something that "git send-email" does occasionally.  At some point
I remember that somebody figured out why that was, but it escapes me
now...

jon

