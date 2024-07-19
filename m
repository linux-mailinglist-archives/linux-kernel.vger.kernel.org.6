Return-Path: <linux-kernel+bounces-257370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63017937920
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F46B2254E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3ED13AD22;
	Fri, 19 Jul 2024 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rxmqcdVH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B031E871;
	Fri, 19 Jul 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399069; cv=none; b=FnhQqoVZuV/aKz+nzGs0wT1otglXQzUX6fRlwMrm28dxv8Xe9iK6fIZNkGuuWtvFMSW3U70Tk9rSuGD7W3N/le9rFt5hjt9HBG0zrCqnuJ9wwsreaNWDZM90p98jNx99TFfd1MuJFNCnkT3z1mSn06JpH4XQysNLvOJz1MBguRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399069; c=relaxed/simple;
	bh=nqNiyXDyPdSoo5vVKalW8O+1Xy1hqhSh7kpPxwmZDCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFaT/vrNrjHw5mmnf+lrktP5ujX3Kl0EDse/2tujWOMJVm72IrFW7K6S4X2g1dhO9vkEflGQYAwZ19IhEdAzcXvalv42TNz4MoTiR5JzP2cVOqwRcMLm8r9PSvdheQInRJGtkr3ayZ0rqpd3rZWr8Rcji4gbsU0YW9VLZUNwD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rxmqcdVH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=loR+NtcqS5n8AOftDgXNtGcQ9Ox7BWghyEic45EGsso=; b=rxmqcdVHMT0kNgTPPR203ha6f/
	kJ4diTZd+wEUujjzjxjUejYs6ek7K6Bamwc3YnhmXup/Rmra03D4Vi7wrOGwnmn09WSHNY5TBjF3U
	mBL0aqaZ8Km/YoaPDBojj0FvydVYuiI1/509XhaaxlPGTuhKCvqZzclrZpjgUPo4wddBJ3o+2Ntqn
	WdW+ac6rWwspQENcu/QhKszNtvcGaX0K3AHQp4YpuHCnfNfWciDfG7y4aa67NBlNquanJTX/ewZ1S
	4qlhfKt2OgzKt3sbBRIJnPTz6ppSn2S3DokilauzNaVfZZPSClptcKRALZ4tnjpKjYUJbFjrYK6II
	vZnwhR7A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUoWs-0000000380P-0Etw;
	Fri, 19 Jul 2024 14:24:14 +0000
Date: Fri, 19 Jul 2024 15:24:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: n.shubin@yadro.com
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, nikita.shubin@maquefel.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@yadro.com
Subject: Re: [PATCH] workqueue: doc: Fix function name
Message-ID: <Zpp3DQNQ5GCM_kd5@casper.infradead.org>
References: <20240719-fix_doc-v1-1-9d176e38ba98@yadro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-fix_doc-v1-1-9d176e38ba98@yadro.com>

On Fri, Jul 19, 2024 at 05:17:38PM +0300, Nikita Shubin via B4 Relay wrote:
> -case. Use ``alloc_ordered_queue()`` instead.
> +case. Use ``alloc_ordered_workqueue()`` instead.

If we remove the `` markers, this turns into a nice link to
the kernel-doc for alloc_ordered_workqueue.  ie:

+case. Use alloc_ordered_workqueue() instead.

