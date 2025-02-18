Return-Path: <linux-kernel+bounces-519731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CADA3A126
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6932E3A4A94
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12C26B96B;
	Tue, 18 Feb 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="run9tbSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF326B968
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892414; cv=none; b=hJ61zP0QVkBfLhlGHWAA35gjEndOf5SsAN5mSAur4pGK1YNWU7QfRuQw47F0AI4nianHWlbAHJwJJ6rWU2qpf6vFCFf7a2ZK/RQY1HZAB487StaoFGOMUmOixonrpyIq8JX4kLNNg8nEna0DFk795Qyr+HZPsmBrqWPwdQ4Osl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892414; c=relaxed/simple;
	bh=Vm/zSEBHeIBBemF6FrSgLE0r4d3+v11KQH1ex+zA+bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEkwUwKItSAKYSRTjHeVfl4NmY2g59cmroZL3j8sbq96mPR2YHUYrnwFcceeXUnrEPXFNU6gQFWBWRq2djuTUWSJKWHGx7SAyKUK0B3vLZcizBgkVZPiKm/MAyaRkjkIf3YXEjZn0oT/QoRgkbqX7h9bQ3yr6g+7u7XzmkKZurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=run9tbSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09F7C4CEE2;
	Tue, 18 Feb 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739892414;
	bh=Vm/zSEBHeIBBemF6FrSgLE0r4d3+v11KQH1ex+zA+bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=run9tbSIOxhn63Ko4/DCEOznzqsrL+0iY/oi8NG4phDoS9+mpkQ/EvM9EW9Rf2AXX
	 2dQrfESe7vzowjsr9YwyHnUJx7D8ruMv7YACiRfhKVFm2WSzbF6XTK74nGO6mexVIu
	 MWvTo7+IJDW1yRg1vMICqPKU8fkLGCeA12/Netkw=
Date: Tue, 18 Feb 2025 16:26:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] CVE-2024-56642: Fix wrong fixes tag.
Message-ID: <2025021836-sprinkler-unsocial-5697@gregkh>
References: <2025021831-sixfold-geography-c6e8@gregkh>
 <20250218143732.11095-1-siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218143732.11095-1-siddh.raman.pant@oracle.com>

On Tue, Feb 18, 2025 at 08:07:31PM +0530, Siddh Raman Pant wrote:
> The fixes tag in the commit message is incorrect. It should be the
> commit which adds the counter, which is:
> 
> 04c26faa51d1 ("tipc: wait and exit until all work queues are done")
> 
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
>  cve/published/2024/CVE-2024-56642.vulnerable | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 cve/published/2024/CVE-2024-56642.vulnerable
> 
> diff --git a/cve/published/2024/CVE-2024-56642.vulnerable b/cve/published/2024/CVE-2024-56642.vulnerable
> new file mode 100644
> index 000000000000..75eac70bd13b
> --- /dev/null
> +++ b/cve/published/2024/CVE-2024-56642.vulnerable
> @@ -0,0 +1 @@
> +04c26faa51d1e2fe71cf13c45791f5174c37f986
> -- 
> 2.47.2
> 

Many thanks, both now applied and the cve record has been regenerated.

greg k-h

