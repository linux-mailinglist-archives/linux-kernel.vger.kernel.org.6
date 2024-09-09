Return-Path: <linux-kernel+bounces-322080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAFA9723B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5440283B40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5918A935;
	Mon,  9 Sep 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MVE4BxzG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8E17623C;
	Mon,  9 Sep 2024 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913865; cv=none; b=pbsuXapRADytH79756xIpYiPKot8aX38Y//PYDJ3Tl2lEet27/P98gcGW7+6pbGcJxAK0o6363voY/HQdwYKPCrLvOuf5oNfPSZFvCsqwZzVw4TRna4Wte/BLpL//vE6KgPd0hzEvZEYV3GFaL1JR9+TPFAL9IrVeB3L68MpdOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913865; c=relaxed/simple;
	bh=PXwFjHOhvl1OGXlLUXPGJTt7tq0EMk8uWYaP/NemlFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVfdgx0TIgjQ9FZIsqINx4L4+ALxCeaIEeGk8L9NTzHnDLVCdu5QcvBoKO0zYdk++1lscMZJe+NPCQBcGaQbobz4A+hjeCjqD/l6A9qzVtlUD5XcJ4MhCD632KzAo3qPhSBOwAWdYamLXmnqiTvOHMz1qKBulzxxZHR7x3SrtRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MVE4BxzG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hPiKzQ2MFgE8BNowohQU42Vyju/yIvsh/2C5Lasvj9c=; b=MVE4BxzGQdJ74a4mS+kwBR1h3u
	HCwBLsIKiiscT2NcrvIFqyds1q4V3G+RJbjsvKDvNrmW2xqXVUSHhklRBXulTsOFjps+z9uRpGSay
	JGoYLLIxyslVu3Wi2YjR+M69o02LLaZVq4rXo8ydf1b26IqcZPApYwKVGXuqN3r7i9YoQril15N6C
	DdE2kdnUDnnTza1cWfrsESSbZf22BOpWkvxVFHcEoqwzOgntXdu1CpnnEVEPiCGcynSzjhrb/sAvZ
	1AvOzXnHvwX4J7S00b3HYonCP79vm8Fp/oJLRgfBFkf1oj8vuUuMul+YIdmiEs+7tiNxMh9cpFrfu
	0uOgX1Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snl2E-0000000H9JD-2Yxy;
	Mon, 09 Sep 2024 20:30:54 +0000
Date: Mon, 9 Sep 2024 21:30:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: cvam <cvam0000@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Typo in the file 'feature-and-quirk-policy.rst'.
Message-ID: <Zt9a_lSCXWwXKdDk@casper.infradead.org>
References: <20240909200253.19818-1-cvam0000@gmail.com>
 <8734m8h9ce.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734m8h9ce.fsf@trenco.lwn.net>

On Mon, Sep 09, 2024 at 02:15:45PM -0600, Jonathan Corbet wrote:
> >  =======================================
> > -Linux NVMe feature and and quirk policy
> > +Linux NVMe feature and quirk policy
> >  =======================================
> 
> A nice touch would be to adjust the width of the "====" lines to match.

Actually, I wouldn't.  The tooling only complains about lines which are
too short (and honestly, I wish it wouldn't).  Lines which are a bit too
long are fine with the tool, and I don't object to how they look in a
text editor either.

