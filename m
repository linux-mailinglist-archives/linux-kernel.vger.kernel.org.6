Return-Path: <linux-kernel+bounces-186381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898B8CC37C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218FD1C21EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE3D1CAA1;
	Wed, 22 May 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JvevakpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CD6AD7;
	Wed, 22 May 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389234; cv=none; b=BxB6eD2PxSYoNW9HJl7s0OYcj9SfO/PyupFP+j/e67Gl8cwbtZewYGzSg01VMLMZJ8SPS83AI+7TRR0sATz3HOmmxyt1sYH6r3XUC5Vwfzm0R59U3hG0W4fKbY7A7wI7St5V33oLKHMxVev+CWMs/sKOVq7UH+YDCaJDoT8WZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389234; c=relaxed/simple;
	bh=5j3a97GZYn8GtQc/vvZ0rSn8m3uqrmZSlXHqEKA7KqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLyNnJNl5lFhV02Lfjov+p31TUzOcDJL3haClLNUk2PSVUXl97fdYua9WVhoqghhS36nL2w+32C47fcJOv56N+C9z1t1qUzizendfDyzaKoQctVuVj0pWApFFhA3US7mKMEzj6EsOq4Lv5OQGSUMPhxgg7z8dKZc289cZcPUkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JvevakpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02CAC2BBFC;
	Wed, 22 May 2024 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716389234;
	bh=5j3a97GZYn8GtQc/vvZ0rSn8m3uqrmZSlXHqEKA7KqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvevakpVj33ueJIw6Hvj1R41NaRx/ciHI77LaJBPStAP1/m6aPoNPZLQN3i2Z5jRl
	 Wl0W+TrkUMUXZHEHH57koACtpwhICr7etVIP8ErC0VzjtOxDWcf03dGT8xumMzbXVC
	 KY5s6UfUgQW2s15iKAPUBydKcqtP9vaWOGRMVHcc=
Date: Wed, 22 May 2024 16:47:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roland Xu <mu001999@outlook.com>
Cc: ojeda@kernel.org, boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: kernel: make impl_has_work compatible with more
 complex generics
Message-ID: <2024052213-uninjured-stricken-cc20@gregkh>
References: <ME0P282MB489023110AAF1163F0A4B2E1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME0P282MB489023110AAF1163F0A4B2E1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>

On Wed, May 22, 2024 at 09:16:33PM +0800, Roland Xu wrote:
> Make the impl_has_work macro compatible with more complex generics such as lifetimes and const generic arguments.

Can you wrap your lines at 72 columns like checkpatch asks for?

> See more in https://github.com/Rust-for-Linux/linux/issues/1077

Please don't point to external sites for "more information", include it
here in the changelog text as this is where it is going to live for
"forever", random external sites hosted by others usually have short
lifespans.

thanks,

greg k-h

