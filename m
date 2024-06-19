Return-Path: <linux-kernel+bounces-220564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0790E3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36515B21126
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474996F304;
	Wed, 19 Jun 2024 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ec78oXTj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12128EC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779668; cv=none; b=ujELcxgWvjO8zRBb7huw4/T16NQpB2vs1fVVZvAcB7DWkQpm2Q3hQCTJkN+54/MHKGs9hesyyQnp2p/WDiWAab0i42yKJ0HEK1snX6bxi9Dlf+PDJUVkoivW7CiSPZYNbeTKKA/9ZikfRxm5eTNlYwSA4J1cLkvha1+TTUU1uHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779668; c=relaxed/simple;
	bh=ahSjp8AyrTRHx9tnLn8lLZXOGdzYqOoNCEq42uD1V0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBpLT1ayloJXOMqqQwWn4y3+LLKiw4JM06DTxsNGquIscfYbW9X/c4Ft03cYRrhAqtl6ZaoNJXFOpvsYqlPlmkIfXaz6cfIYGYgxHNaun0XTnxpoMoIqpNMT2bMcHUDu4hNfd33j6aARZ1QthlJjqPzblE8SzKeedTc3/kja114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ec78oXTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A978DC2BBFC;
	Wed, 19 Jun 2024 06:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718779668;
	bh=ahSjp8AyrTRHx9tnLn8lLZXOGdzYqOoNCEq42uD1V0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ec78oXTjoqyiH7sYS/7QbHaKwlo+T8xUDHuTKmbVDPgUOWFQMmH+RxbcvF0Qpi//5
	 rHWW69i0gof+JbRZ2jUXGhbOATB19fhSst30ZocXwnEh27FrNjRLoojJTUFCyk+IDI
	 m36+0WwzyBVsH4592J7gpfZamDAaQsLDPDaunKVw=
Date: Wed, 19 Jun 2024 08:47:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add Danilo as maintainer for FIRMWARE
 LOADER
Message-ID: <2024061944-abrasive-creamed-d2d9@gregkh>
References: <20240619001209.109227-1-dakr@redhat.com>
 <20240619001209.109227-2-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619001209.109227-2-dakr@redhat.com>

On Wed, Jun 19, 2024 at 02:11:59AM +0200, Danilo Krummrich wrote:
> Add myself as maintainer for the firmware loader, as suggested by Luis
> in [1].
> 
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Russ Weight <russ.weight@linux.dev>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/rust-for-linux/ZnHkQpyiX4UKdLEt@bombadil.infradead.org/ [1]
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38e7e0edd9b8..19e4a21e574e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8569,6 +8569,7 @@ F:	include/linux/arm_ffa.h
>  FIRMWARE LOADER (request_firmware)
>  M:	Luis Chamberlain <mcgrof@kernel.org>
>  M:	Russ Weight <russ.weight@linux.dev>
> +M:	Danilo Krummrich <dakr@redhat.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/firmware_class/
> -- 
> 2.45.1
> 

These never hit a public mailing list as you provided an incorrect email
address for it (hint, lkml does not have a = sign in it, I fixed it up
for this response.)

Please fix up and resend so that I can take them.  For obvious reasons,
I can't take a private email thread.

thanks,

greg k-h

