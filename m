Return-Path: <linux-kernel+bounces-434486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E125F9E6769
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90510188454F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6A1D7992;
	Fri,  6 Dec 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URJtpYzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6428684;
	Fri,  6 Dec 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467580; cv=none; b=f4tp87yc81lIa5tGWAKmBraKGbiD92BSE+eAGIcJY8xZtK2zvVl0H9H65xDKKmy6TRGHzRaTDD9wKGiFlFup29fF6U+CYH/5cSUOaPLy84jJ6dp0g0TJPAXS2COERtpqV51AlHWG+/IbyeC6GuGwIbY2AYUhCfcGpvXhFgzbdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467580; c=relaxed/simple;
	bh=ZSVE7kul+VjeaqUjY7H0f11C6ro/U5lBAiZmh1tfCnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJW7Nc1sP25mI1/Luo0y0eceW8lgoWEvTkh7cTmB8Svs8CKDR3Dw7e/0ErUZPzcM2jg164iLF+bgho/unong7nwKLoos1xutuMBhbo81eIqOr6SaSOGb2nG89IFOSaAtlBrbiM3ZnmuQwChTSKINFzvqfTBLF3/ONZAXCN1BRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URJtpYzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1A5C4CED1;
	Fri,  6 Dec 2024 06:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733467580;
	bh=ZSVE7kul+VjeaqUjY7H0f11C6ro/U5lBAiZmh1tfCnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URJtpYzN6vKNptxxTQR4fipqAvmBLEDigDmZFgHpFojnFyYUqMMM5GAlKOyMuFfty
	 Fq0i3EqCn0zaP/lGUWjDx9P7VAleQoFtDAu6Y2I6ZkilQLu1b8UW6d+NWV+Gw1wCnc
	 zl0kaidsOH+G11P5FiMQIjhthJASTSy13Bb9Ng80=
Date: Fri, 6 Dec 2024 07:46:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 2/5] Documentation: ioctl-number: Carve out some
 identifiers for use by sample drivers
Message-ID: <2024120656-tuition-freehand-68f9@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-3-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205162531.1883859-3-lee@kernel.org>

On Thu, Dec 05, 2024 at 04:25:19PM +0000, Lee Jones wrote:
> 32 IDs should be plenty (at yet, not too greedy) since a lot of sample
> drivers will use their own subsystem allocations.
> 
> Sample drivers predominately reside in <KERNEL_ROOT>/samples, but there
> should be no issue with in-place example drivers using them.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 243f1f1b554a..dc4bc0cab69f 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -311,6 +311,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <mailto:oe@port.de>
>  'z'   10-4F  drivers/s390/crypto/zcrypt_api.h                        conflict!
>  '|'   00-7F  linux/media.h
> +'|'   80-9F  samples/                                                Any sample and example drivers

This is fine, but why does the sample driver use "R" as the key instead?

thanks,

greg k-h

