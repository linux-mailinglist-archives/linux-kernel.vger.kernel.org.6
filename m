Return-Path: <linux-kernel+bounces-330866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40F97A569
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B1FB28E74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E794158DC8;
	Mon, 16 Sep 2024 15:34:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE2158A3D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500855; cv=none; b=K0iMqLGI3duWT54RZ9qZyF2f8mtJ9p7XfsQ/c0Jxb446Ew54skfdAt3TSQz+SQGqojACFQkPIpsNTERjYcfrjGX3CaBVMT6JzVRDs/Zs4evZom5rpoU6rg8oj7o2EbwPFBLoXnVmbyOGNC5svEiW+ALUBgWDmwY6EmgZLnszHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500855; c=relaxed/simple;
	bh=6zEWI4lHPBDr65Z8hl6lPtALpXskWVdw2oBfOpVhCGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mncPNG08iT1fbrCN2aD1+aQk/21LYxHlePdeoZjC/phhncgO9hi3HcA+PV94vqkjUgOSZII4D6BZvUXRX48iAvLE1A3xGenkLeER3nazYae2SMkttJJBrje6ZR33HmAU7/pvWYxZv9O4kgKYy8LzQoti9cN7F5WLpSs8HwWiswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C51FC4CEC4;
	Mon, 16 Sep 2024 15:34:13 +0000 (UTC)
Date: Mon, 16 Sep 2024 16:34:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, muchun.song@linux.dev, david@redhat.com,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH 1/2] hugetlb: arm64: add mte support
Message-ID: <ZuhP80DOWipwB0AR@arm.com>
References: <20240913183404.3517556-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913183404.3517556-1-yang@os.amperecomputing.com>

On Fri, Sep 13, 2024 at 11:34:03AM -0700, Yang Shi wrote:
> Enable MTE support for hugetlb.
> 
> The MTE page flags will be set on the folio only.  When copying
> hugetlb folio (for example, CoW), the tags for all subpages will be copied
> when copying the first subpage.
> 
> When freeing hugetlb folio, the MTE flags will be cleared.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

The patch looks fine to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

You may want to rebase and repost after the merging window.

