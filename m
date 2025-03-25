Return-Path: <linux-kernel+bounces-576098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE065A70AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088DA189DEBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B20265CCF;
	Tue, 25 Mar 2025 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahM6QEZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A01F03E6;
	Tue, 25 Mar 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933146; cv=none; b=VVH+ByWlHOQZxVVUCNUr/Nv2ssQp/sDGJbgStrqDwMFErnGR1kuECWv3xZ14iEB/oclDw5xqt4/adwXguTbq8BcKrscl36FnWZ6iVK3zUzKjqFp0QMbGuIZvmMUvSoJSpL03dkUcP6OMxX3egSA0lEkRp9JTeopwHMyrO1rKXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933146; c=relaxed/simple;
	bh=X/72qEeKSYHb3elkSglf86VYveOfq9a0qmJcTUN5hDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayCxmtT2T8784ZyONi2P2alBuKQrmfDgqJkKvrdFHekBarRs+qwaTFAbhPFdGzhiY9qiUeUZu/mBfgngtQGFkja1cI6gY/dLjhUfVS2S1t4husNulYcflDIqWdPucYfoQTvtQwT5+4G3UDy/MJFGAqiU5VHiWj3keFXaKxnqx9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahM6QEZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA3EC4CEE4;
	Tue, 25 Mar 2025 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742933145;
	bh=X/72qEeKSYHb3elkSglf86VYveOfq9a0qmJcTUN5hDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahM6QEZcVCjW3BKr+TU9Xmp0YDSX/cu9MQRksROxL7aglAWOxiMyhridJgcTp/Se0
	 DzQEGs49sg9qFUNT5x+F2Dw4vxeHVxT9aQIegI3yp/n/FaTxw2ob08lZUhCYMWWaKV
	 cuNPOtVoJ4yRwLw3TN07ECkf9VSx6pOmK9q+zJlFH51al+3SJZBLKjRrKvzcSQp+av
	 HwKgZYLB/u4uCKrjcaoouEUAplD5yR1Z7C7XRT1tdHpDRBCNulkg2KWB1fdgEYUG6c
	 I9LPjoiDkBcOnhRX50d/fQRqcnyQlwRRYR37u/0Rzp/6Q8RaZ/NxRDoBMMTxjxaOW2
	 +Ca6+PmaKmydQ==
Date: Tue, 25 Mar 2025 15:05:44 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND] scripts/make_fit: Print DT name before libfdt
 errors
Message-ID: <20250325200544.GA2195874-robh@kernel.org>
References: <20250209-makefit-v1-1-bfe6151e8f0a@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209-makefit-v1-1-bfe6151e8f0a@posteo.net>

On Sun, Feb 09, 2025 at 05:55:28PM +0100, J. Neuschäfer wrote:
> This makes it easier to pinpoint where the error happened. For example:
> 
>   FIT     arch/powerpc/boot/image.fit
> Error processing arch/powerpc/boot/dts/microwatt.dtb:
> Traceback (most recent call last):
>   File "/home/jn/dev/linux/linux-git/build-mpc83xx/../scripts/make_fit.py", line 335, in <module>
>     sys.exit(run_make_fit())
>              ^^^^^^^^^^^^^^
>   File "/home/jn/dev/linux/linux-git/build-mpc83xx/../scripts/make_fit.py", line 309, in run_make_fit
>     out_data, count, size = build_fit(args)
>                             ^^^^^^^^^^^^^^^
>   File "/home/jn/dev/linux/linux-git/build-mpc83xx/../scripts/make_fit.py", line 286, in build_fit
>     raise e
>   File "/home/jn/dev/linux/linux-git/build-mpc83xx/../scripts/make_fit.py", line 283, in build_fit
>     (model, compat, files) = process_dtb(fname, args)
>                              ^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/jn/dev/linux/linux-git/build-mpc83xx/../scripts/make_fit.py", line 231, in process_dtb
>     model = fdt.getprop(0, 'model').as_str()
>             ^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/libfdt.py", line 448, in getprop
>     pdata = check_err_null(fdt_getprop(self._fdt, nodeoffset, prop_name),
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/libfdt.py", line 153, in check_err_null
>     raise FdtException(val)
> libfdt.FdtException: pylibfdt error -1: FDT_ERR_NOTFOUND
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> The example is from a different series which I will release soon, which
> enables FIT on powerpc.
> ---
>  scripts/make_fit.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, sorry for the delay.

Rob

