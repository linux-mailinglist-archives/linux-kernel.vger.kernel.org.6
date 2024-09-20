Return-Path: <linux-kernel+bounces-334270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5197D4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9CC1F26CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F70143738;
	Fri, 20 Sep 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2/q3lxSI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4B914290;
	Fri, 20 Sep 2024 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831565; cv=none; b=izHMr63L9QVhbU0o1qX88LctFSmiAK58dUVwVInEmmlvPWGgFaVkkbf0SXH8PPPm7csAKA+ZrvrGbq9dlo/fjvvkuVpTvKH2uXfcvkjSEk5gjNOwcTiWJklDiQm8ljXg+iqcnpMuxiJe/Ccj12R+fF/pRLiSp3oPIaMpj1CVvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831565; c=relaxed/simple;
	bh=0FTbkSuwF/nWhLWpO8SYLY2ED+F0e/TeFwLsP00CZgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Hxi72P814UCSeFydLIxPkTmoNlihly7Er210gljvvu2Hx5nks4uPsXaZM4XIyNkXEVwdAaSQ6RL4aKQ10+9O6nVqElbS/asmNL9nIkqeUYXOaGNLTiJh5t7W2IJKAHqOI72H7KPgpDASGI8S1b791Vwr+52XcIdl2EDk0NuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2/q3lxSI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0FTbkSuwF/nWhLWpO8SYLY2ED+F0e/TeFwLsP00CZgM=; b=2/q3lxSIMR+4wZXiLxymHtJlZH
	DBK4ZIJsJOA40RmIXCREbMe34xYvvYIrYANb9GxYotRneXQgn/qfEm/YeH28N+18Y14Lr38gMavGV
	VLcDZUtNEiLJ2LgdRPflJFjtXsO7xUVHh0lIKlhrp390zyncdbC0JjMST5n6vVxKQJk8A4qxUSu1e
	SP9azR7Z/7sDYlHjlnGLBh5ZxyvfUJSoIfuWBOlug4ttcar9yGhhWunpwvqW2iX8oK2PVMjfhJGOy
	2RStJcBXT0NZ8caDPkq2fFEBOvP9szFpXcKxgdsvSKWY9S27ZGnDSQUdU7MCI2DgOA4qvumL7vdjw
	8dYL3X/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1srblx-0000000C5qv-44iz;
	Fri, 20 Sep 2024 11:26:01 +0000
Date: Fri, 20 Sep 2024 04:26:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <Zu1byUGU832iWBUp@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 20, 2024 at 05:41:51AM +0800, Xi Ruoyao wrote:
> This breaks using my laptop camera with gstreamer (with "gst-launch-1.0
> v4l2src ! videoconvert ! autovideosink" or GNOME snapshot).

What camere and driver are you using?

> (I had to use "git bisect skip" several times because I encountered
> kernel panic on boot at some revisions.)

Do you have any traces of that?


