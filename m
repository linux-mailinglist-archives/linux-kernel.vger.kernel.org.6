Return-Path: <linux-kernel+bounces-440673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537039EC2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC6F1884ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F31FCCF2;
	Wed, 11 Dec 2024 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OsoHKIn9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A983CDA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886197; cv=none; b=kCWagNdKNK9dhODbbwjcdBemBSLpeB89hU9Gz6yNjLt5oviiG5eWpgG7oBqk4ZFeK4B2t0NHUnHUBSc45LedhSi3nI68jd1mkmOzxZoM+/EP4k+zT8N8LJb2106d9sXBi3QRK82lkYgXeZjxch0qHfADJD3q4nfYm+TZ4EGQR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886197; c=relaxed/simple;
	bh=E/lhZPj4DeLvxLut2s0Qf5o8AxJ++i7JicIASmQPprM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ICoHQo3DU4ByT0v8euAttGEYlbEFCHNA6nCmAjm++OLi2AbrAtZK++AVOpdhMpBZz5Mqc4HOKq+8UyJkw7hOxTRptDyv4eLisNHBbxb7ifN6RSYbnoTyzHUE0q9uqddyyG0P69/ZvzTvRcnImV3VeODTXjENqwe6++xJeoi1bsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OsoHKIn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F85AC4CEDD;
	Wed, 11 Dec 2024 03:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733886196;
	bh=E/lhZPj4DeLvxLut2s0Qf5o8AxJ++i7JicIASmQPprM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OsoHKIn9VCz7vgsKsHyR8kX1EGIqgwW0ponS/2Bp5xzI7EmjLcuQzBfoVsHmwnwPx
	 v6qwHlkD/CsX70xmOPrNFN290BY0/5SHjv2eT3O98byuTS/jdaNrvHxTSZsxma1cD0
	 ouMz29p/CpPTZq9V9FZiTk2SZs7QHdLvenEb7cJU=
Date: Tue, 10 Dec 2024 19:03:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Junjie Fu <fujunjie1@qq.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 sj@kernel.org
Subject: Re: [PATCH] mempolicy.h: Remove unnecessary header file inclusions
 with no test failure
Message-Id: <20241210190315.5eeffc66cbbc23269f492275@linux-foundation.org>
In-Reply-To: <tencent_FEC6C2E299EBF3F95E516ADED98362A4F805@qq.com>
References: <tencent_FEC6C2E299EBF3F95E516ADED98362A4F805@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 10:52:30 +0800 Junjie Fu <fujunjie1@qq.com> wrote:

> Due to my previous patch not including pagemap.h in fs/aio.c, a test
> failure occurred. In this patch, it has been fixed.
> 
> Previous patch address:
> https://lore.kernel.org/all/tencent_08B979048FE091821B290B18AE97E70DC507@qq.com/
> 

The previous patch had a changelog.  This one effectively has none.

So, please resend, with a full standalone changelog.

Prepare that changelog in a manner which is suitable for inclusion into
the permanent kernel record.  References to earlier versions of the
patch are uninteresting in that context.

