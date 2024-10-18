Return-Path: <linux-kernel+bounces-372174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C549A454A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487231F244A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F0204021;
	Fri, 18 Oct 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="QaLpDhSW"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE514900E;
	Fri, 18 Oct 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273796; cv=none; b=D+shyqKMAb8kG/iB8WQ3VFvp/zIGj392Qljilozws8AmtzgpZuNyGKmTDyeGMQui7CT9ul85RGssFTsK3egpJ9vyNiw4y4Tuk4ctI7+edzeT21jDPyq4kPoRGelCf06KBNZDp3YrDbJ9AGz4GTMR+LsrpSlFPyAV/TImd+nSV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273796; c=relaxed/simple;
	bh=3HzUW6klwTGDpnzFyQ1cHW5PQs6VJSFf50duEN49w90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSIr31pmAUwVAFnPl+NAkvCwEa/xCRqp5B4eeGtyny3w0upj5mZrJRzaLP/1CA3Zkki0bknR0EhIg+CemZ8P5dIN/tB2GlUZJH80kuptmAGERlIHHL56/wgK93wVH2p6ohN02EV/z44EqHP49WnLdzAtZ8GTybh2Tfi5wfTcQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=QaLpDhSW; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 9F918177103; Fri, 18 Oct 2024 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729273793; bh=3HzUW6klwTGDpnzFyQ1cHW5PQs6VJSFf50duEN49w90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaLpDhSWE6MUy3HYy6Joh/2F8v6YQnzjUXdOF8xj5FfUm3LnJcjp2LVoHV7jAL6Fs
	 FltKdT9kIk/o+kQp5zClSnkHqATf8IIsAf7ulLoiKm3w3sYDJIobyonNcbSGwKjhSo
	 Ubj1dNxb9Q/COk7l/xsZ1LiyfpLHSXZHV47ogzCs2JgnkD5wp5NdTFMJhdh8dHQkdG
	 rllq+EhNF0Vfi0d0FdyckilDIj5xG4idBNADkSbgXCjZenvYerhw4JDwLC7BoYSDvQ
	 p6FdrZErBc+4qbG3M51RlGfJ4GtILcyZVxsRec1PeTyKI7UY0/EdnPpSt3oVTLB9bb
	 6YqX/f+y1Q1dw==
Date: Fri, 18 Oct 2024 17:49:53 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: English fixes in kgdb/kdb article
Message-ID: <20241018174953.GA796860@lichtman.org>
References: <20241018163136.GA795979@lichtman.org>
 <ZxKaZR_M-mOjSmBp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxKaZR_M-mOjSmBp@casper.infradead.org>

On Fri, Oct 18, 2024 at 06:27:01PM +0100, Matthew Wilcox wrote:
> On Fri, Oct 18, 2024 at 04:31:36PM +0000, Nir Lichtman wrote:
> > -Next you should choose one of more I/O drivers to interconnect debugging
> > +Next you should choose one of the I/O drivers to interconnect the debugging
> 
> Wrong fix ;-)  "one or more".

Will fix in v2 :)

> 
> > @@ -201,7 +201,7 @@ Using loadable module or built-in
> >  Configure kgdboc at runtime with sysfs
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  
> > -At run time you can enable or disable kgdboc by echoing a parameters
> > +At run time you can enable or disable kgdboc by echoing the parameters
> >  into the sysfs. Here are two examples:
> 
> Maybe "by writing parameters into sysfs"?

Yah, sounds better will fix as well in v2.

> 
> > @@ -631,8 +631,6 @@ automatically changes into kgdb mode.
> >  
> >  	kgdb
> >  
> > -   Now disconnect your terminal program and connect gdb in its place
> > -
> 
> Is there a reason you deleted this?  It seems important.
> 

Yes, this sentence is duplicated twice (with slightly different wording), here and a line below.

