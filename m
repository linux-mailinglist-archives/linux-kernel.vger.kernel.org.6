Return-Path: <linux-kernel+bounces-411689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860499CFE39
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F50B21BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E4195B37;
	Sat, 16 Nov 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YF4bI9xB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6B19340E;
	Sat, 16 Nov 2024 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731753585; cv=none; b=T4wchZArLDLsXj07NGHzXaBbKBqC2vYbD5PEBGHT9beuqCcFv/cIVOHFjw3amgXWtGhc7DojLZSaFCczsffpdPodnJLA68O9DB1ZrmmFlshtCCiR9f/N2xr9ni2w5o3IdcDw79jpQCEQxCBBN/eYySnNJ7AHPUsEDw+zGz3y6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731753585; c=relaxed/simple;
	bh=gfVw9TKIjUv6gOtvAMpFXR7iRNEUzDe1MMWkiU8B3cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2MuTWY3R5l4ESll4GKnYOSeS7bYHlKVTtag/IS3NuxrBpqlncMbiinHwZa03xEVjz/m6gTGpWT4JCREPoekWTn8ONhrtcPhMbod9Fxs8KGsUkwAYjqQUwidpGIaOMQykwc3V4AdakRvGZ0F2ks+o7onQ9gX0qX6KHDRFBYrUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YF4bI9xB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07E8C4CEC3;
	Sat, 16 Nov 2024 10:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731753585;
	bh=gfVw9TKIjUv6gOtvAMpFXR7iRNEUzDe1MMWkiU8B3cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YF4bI9xBtY9AR3ym6gVb3qjal1zjZHXap69UPQlto0mY8FizBrlEzVto1W8/RYSNk
	 ERKkGMWheNEv3IXfoh8nwv+MZUL9An9r7SA5e6PECjDYcSVO+530yT3G36xkKWgvJ2
	 30inmPsnJ19xtoLGghu3g0xgharOetTmpidac2Zg=
Date: Sat, 16 Nov 2024 11:39:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] docs: 5.Posting: mentioned Suggested-by: tag
Message-ID: <2024111605-flyover-chevron-bbcb@gregkh>
References: <cover.1731749544.git.linux@leemhuis.info>
 <1609d461030094b294f08d0b4e208d32993ac799.1731749544.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609d461030094b294f08d0b4e208d32993ac799.1731749544.git.linux@leemhuis.info>

On Sat, Nov 16, 2024 at 10:33:58AM +0100, Thorsten Leemhuis wrote:
> Mentioned the Suggested-by: tag in 5.Posting.rst in a way similar to
> submitting-patches.rst, which according to the header of the latter is
> the less detailed document of the two.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/process/5.Posting.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index b3eff03ea2491c..dbb763a8de901d 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -261,6 +261,10 @@ The tags in common use are:
>     can be used instead of Closes: if the patch fixes a part of the issue(s)
>     being reported.
>  
> + - A Suggested-by: tag indicates that the patch idea is suggested by the person
> +   named and ensures credit to the person for the idea. This will, hopefully,
> +   inspire them to help us again in the future.
> +
>   - Cc: the named person received a copy of the patch and had the
>     opportunity to comment on it.
>  
> -- 
> 2.45.0
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

