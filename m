Return-Path: <linux-kernel+bounces-306567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8B964091
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B041F235C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6418DF77;
	Thu, 29 Aug 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sBVdCPC0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7F18C02F;
	Thu, 29 Aug 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925151; cv=none; b=eQWlTAhFIrmb8EzjeYPc/tXx5lnkg6dK5gqc6BDjDxtyL6fxrrF/pvNpHNQtFKaWb8fAAmSOvX+TMmGlRKsID/31XrzecOU/hpiTUVK1VH2wyfSWg/BtCvlMilcGn3yU64tPE8yjvsO/fKE8IYeMjcqQqL6uVdcA6PZBmKAwX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925151; c=relaxed/simple;
	bh=VikkqmM08MmteOB1Do4OvzIF+T70LjlRl6TYmYEHVOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVMXPM+Bj1ju26K/49puHGyNY7jZDiMHVVW1tzwVwSR4YS1uLyOc8egBN8VX628oqfaO74BqLrsNc/rUBjpM1357njz9ixXNY6HUdskUWwCnW/2APbQeRgLwjekCuoCr8BPLejtbR9hxNHTDqFMgKDceKqvKLvIIg6gPXTegpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sBVdCPC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD04DC4CEC1;
	Thu, 29 Aug 2024 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724925151;
	bh=VikkqmM08MmteOB1Do4OvzIF+T70LjlRl6TYmYEHVOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBVdCPC081WVzqVEXxMwXTXXVCi/kTxyQUNjIZXRWMURt1o4QWzy0izMGC3933IyM
	 su9SIw1xTvHicpxztsQ0FIR/aDHfa9OIEFNq0VysQ66OEbAu6VQcTK3//onZjgc9o5
	 FxB1FZI+kZr8u54hX2nhoTlCaecHtBj3vH3UGmyA=
Date: Thu, 29 Aug 2024 11:52:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alien Wesley <alienwesley51@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: rtl8192e: Fix Assignment operator '=' in
 rtl_wx.c:681
Message-ID: <2024082916-savings-upstage-9606@gregkh>
References: <20240825161335.21737-1-alienwesley51@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825161335.21737-1-alienwesley51@gmail.com>

On Sun, Aug 25, 2024 at 01:13:35PM -0300, Alien Wesley wrote:
> Separated assignments for pairwise_key_type and group_key_type
> in order to silence the following checkpatch warning.
> 
> CHECK: Assignment operator '=' should be on the previous line.
> 
> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>

Please do not put line numbers in the subject line.

thanks,

greg k-h

