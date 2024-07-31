Return-Path: <linux-kernel+bounces-269072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD9F942D36
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E29B217C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC321AD9C7;
	Wed, 31 Jul 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QfXFGZe2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDCF18562A;
	Wed, 31 Jul 2024 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425179; cv=none; b=icYsRIp8WXy4p5Ur0C/wiD0GAMjvCHwxvf6bjmcws7M3cqcNkIi8f6dCFCHNwOES0jVBEbIaCwltqv0QT/k9LLAKeoBBo14dS1zwaTygdT5PUXqdttlkvxa66COGJv/4PXZyJelSMie5m+wuK4gecq4R44cUGnGf/iza8PHbzQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425179; c=relaxed/simple;
	bh=p0m35vPz+4N58/r73K27RHGwwZnlOffWYK5jmMgdwF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qULtvELI4vX8fs4wrTgnAJ2grry20jN0K6mlRleno1oFppcXeaq43hJRiJ2rz2/ZrihYBevODE3pTEQGJAQS6q5rPDzCn0rZQZRL/AW0Xu2hqmeq2zLE/GNMxg+5eXzpz71FBn952UN3VYxuah8wMnPEM0sASPbVMT/ggJI7G7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QfXFGZe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F25C116B1;
	Wed, 31 Jul 2024 11:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722425178;
	bh=p0m35vPz+4N58/r73K27RHGwwZnlOffWYK5jmMgdwF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfXFGZe2e7qEIz3ubpmsaqXt8ULb827eMZywP9qV1rVhLsAJNe5EAHe2JXVnkRqVB
	 aKRluqom55SQespBmVy2R9aOrx7jvhVUd8pGuZW4VA38e380pzUldVbBnB6925JaW1
	 QVh2xShenRAeyLljfEWwObDjQkfvtsINzW6pAh0I=
Date: Wed, 31 Jul 2024 13:26:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Michael Dolan <mdolan@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Documentation: embargoed-hardware-issues.rst: minor
 cleanups and fixes
Message-ID: <2024073108-omega-claim-0e46@gregkh>
References: <2024073032-outsource-sniff-e8ea@gregkh>
 <8734nq92wx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734nq92wx.fsf@trenco.lwn.net>

On Tue, Jul 30, 2024 at 11:59:26AM -0600, Jonathan Corbet wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > The embargoed-hardware-issues.rst file needed a bunch of minor grammar,
> > punctuation, and syntax cleanups based on feedback we have gotten over
> > the past few years.  The main change here is the term "silicon" being
> > used over "hardware" to differentiate between companies that make a chip
> > (i.e. a CPU) and those that take the chip and put it into their system.
> >
> > No process changes are made here at all, only clarification for the way
> > the current process works.
> >
> > All of these changes have been approved by a review from a large number
> > of different open source legal members, representing the companies
> > involved in this process.
> >
> > Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Co-developed-by: Michael Dolan <mdolan@linuxfoundation.org>
> > Signed-off-by: Michael Dolan <mdolan@linuxfoundation.org>
> > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Jon, I can take these changes through my tree if you don't object.
> 
> They seem fine to me, no problem.  Should anybody care:
> 
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks!

greg k-h

