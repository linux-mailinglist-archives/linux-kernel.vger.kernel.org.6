Return-Path: <linux-kernel+bounces-379159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328C29ADAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB96B21FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9943166302;
	Thu, 24 Oct 2024 04:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mRzO8jJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE31E51D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729743555; cv=none; b=sE6PRqI5jGcm2HapsRXzK7e71wb+B7K1Ot+gc04U172jJm/7zex3ZytRaWImUF3+PRcx+KYPuepc3wqhFv/IdnuD2NWLivhoVUR7NxpwaN3SlHtZiZWqh8ZNrcfpcNdkaMb8oHTR7rm5NnmilVVgh5pVhBY0yjlVPQPmHzeE1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729743555; c=relaxed/simple;
	bh=SlLgymg04WNk2mMQ/VjfjWhzIq5TbzTO6+60yVGdbm8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XPxtdVkHilT/0UeOx9CI3b4FkMAPH24IQ/UcIu6UlSwkCChoD5ev8xTaD2wLJzgRQ0z8eurvzACdHsl3n1YRy9X5Mu2uF6QPxKRkN3abX9GiRUTbaCnqFkwsKIejpAqp94HqUzrPZowyzmLLnLIPpDrljhNiFKFV42Yetn4LaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mRzO8jJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620A0C4CEC7;
	Thu, 24 Oct 2024 04:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729743553;
	bh=SlLgymg04WNk2mMQ/VjfjWhzIq5TbzTO6+60yVGdbm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mRzO8jJgpNUrYCQCwFrkSRnDGikopLTLPuHZG1wf6IIzqz6CQ3pDNrtRzDGf/ckQy
	 /IbFnQUIv01jNzriUgROfoyZ+JJjvaWfQHwXOkRErTkFp+/FcQBf7WJY4X8HQ8ew9m
	 fyfQwvGnwhTdKIytannI6EGWr67UHs5pFEJSFseQ=
Date: Wed, 23 Oct 2024 21:19:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Liad Peretz <liad.per@gmail.com>
Cc: linux-kernel@vger.kernel.org, bhe@redhat.com, hbathini@linux.ibm.com,
 yang.lee@linux.alibaba.com, david@redhat.com
Subject: Re: [PATCH] Makefile: Remove unused filechk_cat
Message-Id: <20241023211912.0c3d3e3b20af1f842ad42eba@linux-foundation.org>
In-Reply-To: <20241023070611.67449-1-liad.per@gmail.com>
References: <20241023070611.67449-1-liad.per@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 10:06:11 +0300 Liad Peretz <liad.per@gmail.com> wrote:

> ...
>
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -146,8 +146,6 @@ targets += config_data config_data.gz
>  $(obj)/config_data.gz: $(obj)/config_data FORCE
>  	$(call if_changed,gzip)
>  
> -filechk_cat = cat $<
> -
>  $(obj)/config_data: $(KCONFIG_CONFIG) FORCE
>  	$(call filechk,cat)

x86_64 allmodconfig:

no-print-directory -C objtool 
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
/bin/sh: 1: Syntax error: ";" unexpected

