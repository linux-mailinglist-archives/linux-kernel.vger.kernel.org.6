Return-Path: <linux-kernel+bounces-524009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C10DA3DDE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737F63BB4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80A1D5CF8;
	Thu, 20 Feb 2025 15:09:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3C1CEACB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064195; cv=none; b=Tr9Tn9NqHeCcXByjiHOGK4Rbfz1LO9xmjktEKDZpYXmsqu2K8wXAv8qGakbOCz3jLwTy8qFVcaJyv8OgJfg/YCr784gQ7lfeP7Ac4hYKbIX4VSyDVM8DJKiNuLLC+PNJij6RFSbG3s24Wndv4T+2OYONDxqdhUnUfFwrPtNCtNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064195; c=relaxed/simple;
	bh=FH0XKG9X6v3LuhvharSMWHtZJNFYUBJX11tCfAOvnIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWF17al2O9TdnbQZD3cIxezQ8a67ktwqg/A4wWqhhURqcVZUWfmiSMXsIv33NoeTIzlyAI4gdZaFrMIYBTrtNOObfyxVg06erG0ST4MIAFF/djqj5BzQrJExBZfVh9IEA7EJTPTSMxEfp9jTefg2eQaqSvoQgbmWeMUr/qE1QeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B131BC4CED1;
	Thu, 20 Feb 2025 15:09:52 +0000 (UTC)
Date: Thu, 20 Feb 2025 10:09:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hillf Danton <hdanton@sina.com>, Byungchul Park <byungchul@sk.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <Z7dFuTkdQ7PmP7sY@home.goodmis.org>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com>
 <Z7c0BTteQoZKcSmJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7c0BTteQoZKcSmJ@casper.infradead.org>

On Thu, Feb 20, 2025 at 01:54:13PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 20, 2025 at 07:49:19PM +0800, Hillf Danton wrote:
> > On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> > > Just in case that I don't understand what you meant and for better
> > > understanding, can you provide a simple and problematic example from
> > > the u-a-f?
> > > 
> > Tell us if it is illegal to commit rape without pregnancy in your home town?
> 
> Hillf, this is unacceptable language.  You need to apologise.

Agreed. WTF Hillf?  Where did that come from? Is this how you talk to your
co-workers?

I'll tell you what would happen in my home town. If someone said
that to a co-worker, they would likely be terminated.

-- Steve


