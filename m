Return-Path: <linux-kernel+bounces-434485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB89E6768
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B852814FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D602D1D7992;
	Fri,  6 Dec 2024 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WjO/nhe2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4928684;
	Fri,  6 Dec 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467521; cv=none; b=d74KDVh1P/b1WSDGCkCJI4FAoVhFguI2eGf5/scYiz0J4DN+JOFM8RnzDPvetPsEv4sPh9rP/JJFKg+exshSQELB63zomwObf++TRLYMq7I08rLiCMCgaJWIiE1AIzVH6C7mSgatH3G/2HSiiUJQ9mdHN8h2PZQRVfjpze1Oe/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467521; c=relaxed/simple;
	bh=mKGZ3/d9Q4M/1rKf/GJtEkBttRpjSIlN5KQxL4Wv0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfC+XjTev/KX0jvUH7eFwyp/+4QPegGZk5C8wC+6wNZSQjNYDvIoWPEsBQI34OD2iavUS0LtD16vW6h/QBncKKsD4xB9eE5WpuwI4z5AUjw3WLug9MYmN2tElrZJdFr4qniiBX09ROTbW4d6g+P0b2XfHzpl3wydXTAnXSM+/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WjO/nhe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C93C4CED1;
	Fri,  6 Dec 2024 06:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733467520;
	bh=mKGZ3/d9Q4M/1rKf/GJtEkBttRpjSIlN5KQxL4Wv0d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjO/nhe29ZEvB1dHMSzFpLlL12hxOdNZIatrROPAfS9TMc0ERdnn0IO5F7cVEvCwV
	 QvtJ0Brw3kQODDS2g5ODAOpi70lb2//BaX6btEKgrx/ZPaaBb3V1F8a8leGdaMlso3
	 wU8KD3HB4bqH+uCMHW2eM0Lt2Frtm1eR8Nj97GRI=
Date: Fri, 6 Dec 2024 07:45:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 5/5] MAINTAINERS: Add Rust Misc Sample to MISC entry
Message-ID: <2024120617-directory-tiring-56e7@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-6-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205162531.1883859-6-lee@kernel.org>

On Thu, Dec 05, 2024 at 04:25:22PM +0000, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee@kernel.org>

You know I can't take changelog entries without any text :(

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 21f855fe468b..ea5f7c628235 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5328,6 +5328,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>  F:	drivers/char/
>  F:	drivers/misc/
>  F:	include/linux/miscdevice.h
> +F:	samples/rust/rust_misc_device.rs

Nice, you are signing me up to maintain it for 20+ years?

{sigh}

greg k-h

