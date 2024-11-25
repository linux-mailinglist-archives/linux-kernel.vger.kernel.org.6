Return-Path: <linux-kernel+bounces-421662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94029D8E23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE92DB2FE16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E761C07DD;
	Mon, 25 Nov 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bc9bvMI8"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F21B6D1A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570498; cv=none; b=ikjtVzH/Eli5W3t+kmo/Y9jrOTaheD6Zbqd2HNN1poskJxYsspb9aSsAb0uCwNn0VNeysKfCd+IqmrXOA2oYQ4E0PFdo8v8IhGvB24T0VoD9kDLjPv1O3vff5QpFVy/O4Yryuqb/tL2ttv8qVGLeLX7+01ZP6wwNdi95K6x9xYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570498; c=relaxed/simple;
	bh=iYM21YyG1P8NGSWo7SKKW3RDR8g+QqVm8/En6TTtZ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcLZ0UR6JSO96X+7gxaCunq9fjq9F1n0HMsubAjWAF6c2loRTekBvFnkV+QVjo1pbfqlaTkcQ308Vhuv/qDxansxi2qkOtduouJtSe+wAQAAuB0JmRH/9ZnMvU4Dxc9+RRPiElY4pfMKheAyrDXv5byCZ92DOlBHH0cKBNMoS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bc9bvMI8; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Nov 2024 16:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732570493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4z9seMwwfN5os5InvC6e4JEVTlNcHQwVQxYELoifTdc=;
	b=bc9bvMI806tpCSObfZnqRj14oJPcO5gEfinlMbPTO4iJIanPbh02o4ucAaYJiQxuwKCTaE
	b9loKXlg1swp7h+aOi0yc3xFJZeXe18QnPeIJmThKjtHzew55YeYnucyGZeziFKmxmveTX
	VxMkaOe3xqdsvTWgZbBH9FhJNNctOAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the bcachefs tree
Message-ID: <pcwl5uu77olfcogaq77jrnfic5ftsuizu7xtt3mjxhr7ri6n2y@kryl6cprd3br>
References: <20241124183507.5241d705@canb.auug.org.au>
 <L_EkkmQsB6qOPGXuF9tsZFHbNXMQcco_bdzKzow3ZXhjccVKzQJ-Ekd8SU4Ofqt9RNJccI_ZlUrjsNDGvKZuuujdUjxHcaS6qT8WkmHITL0=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <L_EkkmQsB6qOPGXuF9tsZFHbNXMQcco_bdzKzow3ZXhjccVKzQJ-Ekd8SU4Ofqt9RNJccI_ZlUrjsNDGvKZuuujdUjxHcaS6qT8WkmHITL0=@proton.me>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 25, 2024 at 05:26:03PM +0000, Piotr Zalewski wrote:
> On Sunday, November 24th, 2024 at 8:35 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > Commit
> > 
> > a4f3d037408e ("bcachefs: Fix evacuate_bucket tracepoint")
> > 
> > is missing a Signed-off-by from its author.
> 
> Looking at the commit - Kent has changed my patch significantly. So either
> there was a mistake in assigning myself as an author or he forgot to add
> my signed-off-by line.

Uhh, some of column a, some of column b - I thought I was doing a new
commit and must have brainfarted somewhere.

Co-developed-by?

