Return-Path: <linux-kernel+bounces-242066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C07928331
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69671F2194C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48175144D01;
	Fri,  5 Jul 2024 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Plyp169b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E30132103
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166040; cv=none; b=kqHhd6oI6u7KJ8N/VnqIFgn03wN7xnGAPyILyHQyuTyw4L6aG7Vz01mvZS8CcHUXDQr3H7ndMtLJecdr7L/bsfxv3Oe32MM9em8+C0kifzWv4cW/1oofYh47KKN0Y+C0i/lXJYsM+MDFvpGjmsYth4m3v/pDsYfzCmUlDQKJfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166040; c=relaxed/simple;
	bh=JOaF6/rLqxwGG3Jqswy40/olv6ayRp2XORfsUqbzAKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz+2zi4essHhpZkxbzgHoPWGZF6HF0WuWfMbQSKbhW0Rm+C6l49dVFCLyAKLJw9TU+Xxh5rh4dqjR3i0Y2q5X1hrF31q7oS8nZH7o++xDxJTnCQVDLf/B1CHgSh+DHjuk/5AstDold2OplHexNkqymqaSROduBGGzV1I2xept2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Plyp169b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF767C116B1;
	Fri,  5 Jul 2024 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720166040;
	bh=JOaF6/rLqxwGG3Jqswy40/olv6ayRp2XORfsUqbzAKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Plyp169bFBML2BZAx5GIqyWTxORNKuTAhHJM90eMn9Hm6A4kPGgUulHFIqPjrHsRY
	 MXY4gOV2yhmGvcZZP6dEXpjnEu3HIDaEURQ7gspWYah6+ram7vJ1E2XJ5OGKFbIA0s
	 Y6xIoiIxqW8VkzCJB1qr//po0sXhS8irlC2MSN5k=
Date: Fri, 5 Jul 2024 09:53:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, Amit Vadhavana <av2082000@gmail.com>,
	"Ricardo B . Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH 1/1] slimbus: Fix struct and documentation alignment in
 stream.c
Message-ID: <2024070532-romp-clarify-7d2b@gregkh>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
 <20240705074045.418836-3-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705074045.418836-3-srinivas.kandagatla@linaro.org>

On Fri, Jul 05, 2024 at 08:40:40AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Amit Vadhavana <av2082000@gmail.com>
> 
> The placement of the `segdist_codes` array documentation was corrected
> to conform with kernel documentation guidelines. The `@segdist_codes`
> was placed incorrectly within the struct `segdist_code` documentation
> block, which led to a potential misinterpretation of the code structure.
> 
> The `segdist_codes` array documentation was moved outside the struct
> block, and a separate comment block was provided for it. This change
> ensures that clarity and proper alignment with kernel documentation
> standards are maintained.
> 
> A kernel-doc warning was addressed:
>     ./drivers/slimbus/stream.c:49: warning: Excess struct member 'segdist_codes' description in 'segdist_code'
> 
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/slimbus/stream.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

I don't think this was ment to be sent as part of the fastrpc patch
series :(

Can you fix this up and resend a v2?

thanks,

greg k-h

