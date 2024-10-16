Return-Path: <linux-kernel+bounces-367313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A309A00C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9161F22399
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C61A18BC0B;
	Wed, 16 Oct 2024 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwy6j0CK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B64CB5B;
	Wed, 16 Oct 2024 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056810; cv=none; b=i97mFSzcxrfcB6p+CwJaFhiBUsRqit9o1myphPzDlTeBlzRG7K48027QFmET0YvFJjuJdIUrKuv8h6Vux2/zVuE6s272yXeeNb5bDork5DqWOSrSFMlKyIg2m2GSKoi2dDKaPohY6feeg2NKVPl1f31WwAzfPvbweThFWfgUE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056810; c=relaxed/simple;
	bh=+e7T4hQZhKNwlhm9rLtAT+cyHx82aCspHPskjYq2sJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFsiH1MfkpIHKhDMmbWiyjnuvnnPqZfKdZIeSMuN/WjrkbSferX4D3KDR0O9yedJVtG8mc4KnvJXpVDLSCbhp77lOU25c/7Jh/ZMV1JbVmq9/+wI5c/LRWLjmM2CSNXSmyygXW3b441eUBDWM43PpTswDeMOIEUoFTitrfOCKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gwy6j0CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B4EC4CED2;
	Wed, 16 Oct 2024 05:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729056810;
	bh=+e7T4hQZhKNwlhm9rLtAT+cyHx82aCspHPskjYq2sJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwy6j0CKh6DZ+NbkaOTbvU9/fZ+ZmXpK0UP0hDj5S9jNfgvy6TjmEJyhXSXakHPSi
	 ODd1XIH83PIjp1EEVxMIM+r8ogP3quUNZNig2byeKzK/wZE6hc2cnHNThNNqarZPdb
	 Z1j6Xp1fOGt7/RylphZgrL67LNtS2oZxbwqL/cZ4=
Date: Wed, 16 Oct 2024 07:33:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: dpenkler@gmail.com, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: gpib: Add TODO file
Message-ID: <2024101609-getaway-appendage-1f88@gregkh>
References: <20241015192838.16740-1-dominik.karol.piatkowski@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015192838.16740-1-dominik.karol.piatkowski@protonmail.com>

On Tue, Oct 15, 2024 at 07:28:57PM +0000, Dominik Karol Piątkowski wrote:
> Add a TODO file stub for the gpib driver.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
> v2: Remove maintainers from TODO, as they can be found in MAINTAINERS file
>  drivers/staging/gpib/TODO | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 drivers/staging/gpib/TODO
> 
> diff --git a/drivers/staging/gpib/TODO b/drivers/staging/gpib/TODO
> new file mode 100644
> index 000000000000..850dc1102e54
> --- /dev/null
> +++ b/drivers/staging/gpib/TODO
> @@ -0,0 +1,2 @@
> +TODO:
> +- checkpatch.pl fixes
> -- 
> 2.34.1
> 
> 
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

