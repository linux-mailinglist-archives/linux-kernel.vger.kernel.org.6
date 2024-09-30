Return-Path: <linux-kernel+bounces-344286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49398A7D1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AC4B25901
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D391922D5;
	Mon, 30 Sep 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NdcXtmHm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48418BBB0;
	Mon, 30 Sep 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707928; cv=none; b=HhNnCwKtBlwrN+BCyfZMH6dsgujpa76kP+CeDcLtuV4/BGmasj6WCCVhEj7/IsYNhyGQ/rfUp//Fi1XeVLJ03IqWtSPlsj2Zh0KpSOUwf+x6In+9uwAWb9q6zF8muZ14nHT48xd7gyl84JqoNmI2I79vKgxdSoie887Jpioxom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707928; c=relaxed/simple;
	bh=zj6qkf2jJptAzjCgXAlSXsfQHb3M5Vn8XRoZeBYhWXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxpWyFZKXmvesO7R+Efcgi4X/11PpIe9cqqbVc/wMq4F2CZKsDe3TSob6C/YTLW1/IUZvLOMI5ZITqFpT9ZytLW1bHVPybh4WYKL1Hu46+tQAHGyaMS7rvRMphRUMC9j/Ppd8QyMdKVRu266JEaBfJ9KO8zSDqdC2QseTZ7M220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NdcXtmHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECBBC4CEC7;
	Mon, 30 Sep 2024 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727707927;
	bh=zj6qkf2jJptAzjCgXAlSXsfQHb3M5Vn8XRoZeBYhWXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdcXtmHmZ16PtmjA0nrL9pSO57/+6/Ugirj+awgd2nlJYuGZ3JMk8f7dDkuhKt/hJ
	 U3P8x5Ev3h29XqsQX5T6Xn4qeIvKx4reS89XhBQMPE6yjnhhfjmKDZgLUzJQd43EfX
	 ouSxg9OQHknth9WAvPH/scida2cONEYIOQNudESU=
Date: Mon, 30 Sep 2024 16:52:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
Message-ID: <2024093044-violator-voice-8d97@gregkh>
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
 <20240930144328.51098-2-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930144328.51098-2-trintaeoitogc@gmail.com>

On Mon, Sep 30, 2024 at 11:43:27AM -0300, Guilherme Giacomo Simoes wrote:
> This function increments the refcount by a call to
> "bindings::get_device(ptr)". This can be confused because, the function
> Arch::from_raw() from standard library, don't increments the refcount.
> Hence, rename "Device::from_raw()" to avoid confusion with other
> "from_raw" semantics.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  rust/kernel/device.rs   | 2 +-
>  rust/kernel/firmware.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

