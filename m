Return-Path: <linux-kernel+bounces-401161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F69C1695
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1057D28399C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A21CFEA3;
	Fri,  8 Nov 2024 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TaxxnE1W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301951BD9D8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048550; cv=none; b=jMiqGxyZuAtdYs+GARPES0Q1g3XKdh6S2ApZ5uC9NuVk8UeUHwChYWEErjseTWS6J9GnokWqa/oaEeNRbV7nrLkOqkvVIlDd9muG1+V1djnu/zt/2yYN8V91h+7wj+sHb6wFKRCXpyj9wXCoSTdyDYavp8W6U6K/PPXv3LKbOTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048550; c=relaxed/simple;
	bh=yEnIXrr+o/BeE2tObiPbz4duD8YAfpPneFh6BOs8FmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5TQf5RctleDQjWwQrZLtd379TK/r+olvhl0Y2kr+EmdESgRsCY6VQK8IA0x1n807ZXbKZEJk9xLuVtJlSUYWsU7Rr0XHjWPQY/C9io4IBp/A9CiRNigMx6BRVuPJdeFxTNNQSvOmERczyck9+OuDmowRI8nMNOuASQVBzCGXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TaxxnE1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62BDC4CECE;
	Fri,  8 Nov 2024 06:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731048549;
	bh=yEnIXrr+o/BeE2tObiPbz4duD8YAfpPneFh6BOs8FmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaxxnE1WWpYQPVrVRzO15nKb384mTSd0TjQ3WqkvFKnXHj3kTVSs8PbO09jZTVp2q
	 L8w/tE8P9Ddkh1UkvK0TY1nokU3V0w6BL4jEI25JbrPCjGwboYfEGVZq389kjLQcQ0
	 HO2/aiTHYhL1ITub224PUkH13hbEw84AvEFjpG9M=
Date: Fri, 8 Nov 2024 07:49:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH vulns 1/2] add a .vulnerable id for CVE-2024-49888
Message-ID: <2024110843-french-lingo-b055@gregkh>
References: <20241108055118.28631-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108055118.28631-1-shung-hsi.yu@suse.com>

On Fri, Nov 08, 2024 at 01:51:13PM +0800, Shung-Hsi Yu wrote:
> Link: https://lore.kernel.org/all/klr4llu43s4osw4o7234no33k6eujo2wvpeyhft2z5zgib6zac@hvg72k5q7w3f/
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> Add vulnerable commit IDs as Greg previously suggested[1].
> 
> I posted analysis separately and referenced them with the Link tag
> instead of including the whole analysis in the commit message. Let me
> know if an alternative approach is preferred.
> 
> 1: https://lore.kernel.org/all/2024102419-deserving-veneering-6641@gregkh/
> ---
>  cve/published/2024/CVE-2024-49888.vulnerable | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 cve/published/2024/CVE-2024-49888.vulnerable
> 
> diff --git a/cve/published/2024/CVE-2024-49888.vulnerable b/cve/published/2024/CVE-2024-49888.vulnerable
> new file mode 100644
> index 00000000..b7b1891d
> --- /dev/null
> +++ b/cve/published/2024/CVE-2024-49888.vulnerable
> @@ -0,0 +1 @@
> +ec0e2da95f72
> -- 
> 2.47.0
> 
> 

Thanks for both of these patches.  I've now applied them and pushed out
the update .json files to cve.org for these entries.

greg k-h

