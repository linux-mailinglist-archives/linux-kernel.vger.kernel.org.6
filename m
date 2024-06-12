Return-Path: <linux-kernel+bounces-212311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86064905E56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3851F22B40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3775128812;
	Wed, 12 Jun 2024 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R4F5khrM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D01DFF0;
	Wed, 12 Jun 2024 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230634; cv=none; b=Ie0tK3zfUGgl6ti7EztclNdwCuGCm3e5MUC0FLH9DqELoiDwjL8HRXciVN/2Kg7ZwR/BCTNyLlijfHoq8o3PcxdHWguQ7VgWmShG5HU8jgBMhB4/bp8F+KXZioRpsatrGZY/9ok/+W2I9hMl5ReJ7pyDAcT8TINYB3cD+cddIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230634; c=relaxed/simple;
	bh=XKtl3fJWBAPZ7lPosHOgxWa9htLb59tXW1SBr5vShuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaJKvcFYBojS2Lmm5jcG+8XBT5bnmGnmv2zfVUacR+Is7wCUkMofDgA/R6AaSFUKHprgjVsUUhSfUlu453d5TS6XteqzK1LNRELvGqFEDUgahLAQ5j9wAon1MXL6VfqVfwpsZyfSmy4cu5Lwt/KarMsTg60rPURk2yJkgJM0OIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R4F5khrM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=iIcxLlxujOaY2/FzOniBx4ritUwioZHVZDGOHoqYSgQ=; b=R4F5khrM3n1n98/9URs3iVUS+6
	qudWHPbPAr6Nsdo6Y4i9/FOobpumY7SpWwxUC9CsCXpQj68JZPJBtmtwvS3Hf+FWxs49e/+l6xSBW
	HE+sHbl+u+E4cJcnbDwrfknCJVKt8Qfgr7asds+JGZtUyDLX+Jul0Yy8ckTUVoZCoArCuIFk0+4hJ
	kUEcSy0dpOlIvWof4FxWoHy6R0m3l58hH4mLOjiqfCgs5C+dJFxDSWd/Is8ClHQTBL6lda7BakcLi
	JNi9i74qMgGyFi/fq44JVHT2ZAEex7t/1r96pdyF+AQ0S/LjFXOrUA4P48AEwV8+Jxjztz+GgQ5oR
	+oxv0qyQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHWHH-0000000EIr1-03fk;
	Wed, 12 Jun 2024 22:17:11 +0000
Message-ID: <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
Date: Wed, 12 Jun 2024 15:17:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
 <87ikyvccwc.fsf@meer.lwn.net>
 <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/1/24 8:03 AM, Carlos Bilbao wrote:
> Extend the Index of Further Kernel Documentation by adding entries for the
> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
> on the second edition of Billimoria's kernel programming book. Also,
> perform some refactoring: format the text to 75 characters per line and
> sort per-section content in chronological order of publication.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>  1 file changed, 44 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/process/kernel-docs.rst
> b/Documentation/process/kernel-docs.rst

The 2 lines above should be on one line, but fixing that doesn't fix everything.
'patch' still says that it's a malformed patch.

Carlos, please check Documentation/process/email-clients.rst section on
Thunderbird, especially for line length and line wrap.

I'm still looking...

> index 8660493b91d0..6f3e290abd22 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -3,27 +3,27 @@
>  Index of Further Kernel Documentation
>  =====================================


-- 
~Randy

