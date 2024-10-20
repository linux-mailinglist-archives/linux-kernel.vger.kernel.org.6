Return-Path: <linux-kernel+bounces-373445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11AF9A56B7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E3B1F2241A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE451198E75;
	Sun, 20 Oct 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aG6WRvsn"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23A198A19
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456842; cv=none; b=ulXYBmjYkAPlNufY75Ru2X9+ewahGLhqjHG4fPPLSVDsKrHlSbLg+Xlu+WuOolx+n2vxDmnakFbufRci1tVoDE3NsI6BEnWbWBndkde29NUPZtc81zjXxGkD/bqm8aO0dNb06dyJ9EeswVTbVAeY/PZqJ4tSuBN/n9wBOuuvRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456842; c=relaxed/simple;
	bh=UD+HiEx82siOq5FpR9/Iq/Tmpkla9NdLZ3OaTiJzVOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0F7I1FYbmD8ASIBkYFR552FjS8K3GrdmNDlyiPB7E9Okn4Vk6oqzRE7XAulXBr/eP3ATATHBEurJqil3iACUaUTAXEax5fS+4emjeJ8XszoyzFGGSCGpKY8Z25NAEjFFrDgBxC8ZIMMW2/KccJ4yf/FwZAovP70NU5QflBfSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aG6WRvsn; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 20 Oct 2024 16:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729456837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6/RjdngvvzPRnLVE0ufrS0HRnnOyBIjVbyjsAyWOPQ=;
	b=aG6WRvsnPbk8/R/+jmmEgQkGvgoEnH4rN2RGhC9T/nQTELP4Oo3TI/XQSjfAm8KhCRKwQo
	G0quZcUGuCE27R61ZDhQLwDGdYcsfSHoD4fQl6YEpxF3SfUXSCHeHyykTGxpiR/2WiaupL
	CF+m95weStQNYOd5GMikzNW9A8DgyC4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error trying to fetch the bcachefs tree
Message-ID: <pmdkqd63ywjl4ktdjg24v6pjslepes7fmmu4llpqzeueeeos2b@vldhjmmcqfil>
References: <20241021073823.1a89e1fa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021073823.1a89e1fa@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 21, 2024 at 07:38:23AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Fetching the bcachefs tree produces this error:
> 
> fatal: unable to connect to evilpiepirate.org:
> evilpiepirate.org[0: 5.161.236.196]: errno=No route to host
> 
> This also applies to the header_cleanup tree.

It should be back up in a day or so, for now I have a github mirror:
https://github.com/koverstreet/bcachefs/ for-next

