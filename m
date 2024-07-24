Return-Path: <linux-kernel+bounces-261041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3ED93B21B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7F21C21468
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69251158DD0;
	Wed, 24 Jul 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p6rMMhxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7C1581F8;
	Wed, 24 Jul 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829327; cv=none; b=nM1XK+OUYHukQ/TL2sJYeupJwU4EtTJN7QgQQOcqw5VQba31trSwZuIRGCpPbGyvt8Wl1lzJfPC+wFirGROma+Yl/+sJeWN2xjdd4xJrBSNFRFqmplH2F0SqQMJGPTXHnPUAIZR7AAa8YyGpdWYLbV1NtgS6+OGnqBaLYLR9t2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829327; c=relaxed/simple;
	bh=bc7va+Bv8EJLQaG0jjbUekIN+PKCy7lo0JaWmHs7U9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyv17iE8lNCO6iwgwQLL7sdBh0fX33BlJrk02JOOvm6mqrClAg3hXEy19a4Y2MSPhRgvUDqH05zpy+1gfWOM6NeNLjuCKUWfXWdcag1D40OBUKYyyC5tD5/neaZwoW9lXMYm5QCbv3Opy8KKuGerMFka9n4MwJF/pVTYw5Bf5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p6rMMhxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EF7C32781;
	Wed, 24 Jul 2024 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721829327;
	bh=bc7va+Bv8EJLQaG0jjbUekIN+PKCy7lo0JaWmHs7U9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6rMMhxV66cyVaeQLl0mQuFFXt0CvFks9Xm2efTGYmmtt04q96gsI9W9ASrP3rYXB
	 MSOTlrCDpTCy0yn8XQ8RphW8kvmdqNZTxSbFFbh/xswRS52Hl8FX91G3dZIPM+biPX
	 ZohPwweMHHeyAzDIfy2teE16j02AYTktgw3/elss=
Date: Wed, 24 Jul 2024 15:55:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: remove unnecessary braces in if
 statements and space before close parenthesis in function call
Message-ID: <2024072441-evasion-armored-42f1@gregkh>
References: <20240723060311.32043-1-riyandhiman14@gmail.com>
 <2024072339-elderly-charbroil-5d5d@gregkh>
 <CAAjz0QbtK=c98QP5t76_=_Xrg4+3bHksXR=_QJfz0W0f_zZ=vA@mail.gmail.com>
 <2024072320-trimness-scribe-8055@gregkh>
 <CAAjz0QZpJWBHxn131xaeGHoUyLA3rf4JGRW9Vaw6ko9+zEz8hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjz0QZpJWBHxn131xaeGHoUyLA3rf4JGRW9Vaw6ko9+zEz8hA@mail.gmail.com>

On Wed, Jul 24, 2024 at 06:22:55PM +0530, Riyan Dhiman wrote:
> Hi,
> 
> Thank you for your feedback on my patch submission.
> I understand that the fix provided by my patch is not needed. As this is my
> first contribution to the Linux kernel, I am eager to learn and make
> valuable contributions.
> To ensure my future submissions are more aligned with the needs, I would
> like to know if it would be helpful for me to focus on the following types
> of fixes:
> 
>    - CHECK: usleep_range is preferred over udelay; see
>    Documentation/timers/timers-howto.rst

That's very hard to fix without access to the device and the knowledge
of what needs to happen.  See the archives for where people have tried
to do this and the responses they got.

>    - WARNING: Unnecessary ftrace-like logging - prefer using ftrace

That's good to clean up, try that and see!

thanks,
g
reg k-h

