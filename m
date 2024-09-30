Return-Path: <linux-kernel+bounces-344679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4389798ACA9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0295B24344
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFBD183CC5;
	Mon, 30 Sep 2024 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Fzs1rj5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB615E97
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723836; cv=none; b=GtsVzSaIHKhAezsXiwFfv+fD9s6i8x0bZVIGChy9nBFZVG1wq/EcpW4rgppjXzc3Bgrd1U9c+zgOB7LYfmWI6b+p2XFIOYiLuA/e80U36IvXrCCNmk6Qxl/ocwAcrCeBgIWZiaa2dbwPwbr3rMEw5brAMxuQ2XU2/0cqtSXV2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723836; c=relaxed/simple;
	bh=EKXQ/NkOUG68FLhVF4/nLkkGEyfRy7q4ka5FDA/CAuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZA2JB+bJRh7RD7JAC/ldBPrwg7Kj307lnlnyP331ZiuiMbMwsc+0z2fjXdmBeTXdDrUjClEM+HL3mCNhjYrrpLipQtyUunRreAqxFyiw1tziCeznd/75w9XSWoa3MkRg3L8tYUxD2Ua3GrNshYyQXrAzVmqrMG3gM6AuIkhVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Fzs1rj5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF939C4CEC7;
	Mon, 30 Sep 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Fzs1rj5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727723832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXhqapFBo+75hVKPH5GgFx2LdKbyngn/VfVLQxKR/Ms=;
	b=Fzs1rj5+BBskyJzw19syl1VxJS3+wVCvV8ZCfMPQcVkA1fhg9se2wsCqV4OsEEGfjzN8HG
	rny8d8iOkVGvpHVUS1rhplsgmHHg5zSsC65+Ws88P0g4BqTQtXOEHtF+4zhVxJAfjyPtcV
	+FlQ1E9O4OwhjHFJuGDVi05sy9NBPaA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3ab1cbd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 19:17:11 +0000 (UTC)
Date: Mon, 30 Sep 2024 21:17:09 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.12-rc1
Message-ID: <Zvr5NRtqxsIwmfeK@zx2c4.com>
References: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
 <ZvqkfSM_8sxTSzz_@zx2c4.com>
 <CAHk-=wjm1jLqnMnLar9XRDAwDTHcG7e9+cFhq2bgz4Q+5yysKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjm1jLqnMnLar9XRDAwDTHcG7e9+cFhq2bgz4Q+5yysKg@mail.gmail.com>

On Mon, Sep 30, 2024 at 10:22:28AM -0700, Linus Torvalds wrote:
> On Mon, 30 Sept 2024 at 06:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Pushed 5.12-rc1 too? Odd.
> 
> It's an old tag that was renamed to v5.12-rc1-dontuse when it was
> found to have some particularly nasty problems:
> 
>   https://lore.kernel.org/all/CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com/
> 
> For random reasons (read: I had an old repo) it re-materialized under
> its old name, and because it was *so* co-incidental in naming (getting
> pushed out at the same time as 6.12-rc1), I felt it was too good to
> fix up again.
> 
> And if somebody goes and randomly starts using v5.12-rc1 (from
> February 2021) and hits the swap problem, I can only go "why did you
> do that?"

Ah, I remember that ordeal. I suppose you've been testing out rc1 on
some different hardware and so old repos are found hither and thither.

Jason

