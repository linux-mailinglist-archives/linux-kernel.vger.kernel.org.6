Return-Path: <linux-kernel+bounces-209375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B9B903387
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9064E28D295
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE958172BBE;
	Tue, 11 Jun 2024 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGERCKct"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824115AAC6;
	Tue, 11 Jun 2024 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090818; cv=none; b=k4JNq9CK8gt//tiojvcd9CTaoy+zJtSFYe5LZjRG7HOAJgSM6aR/P8RRxrHU7v+rlfT7/ZQZVkPkGvSEZmeiHZuez+YogzOu1wr/x7Cu/pVZtkcF9PDjrPMIlHKG0sR56a8xzTa2D/w2N8Q96tgyEAxXhhHnPIi4oozTeMwK/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090818; c=relaxed/simple;
	bh=iuOB2LsQWK4Lkwwodvl1jWuCTovzR1GweHkEYEJmjOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7lne4tM/N2KGpO+nD29gflZsbVQrTLL36LIkhtmiahzNLoaNhIE5y9Ypl0mZRhDIrxWS4f83TjRnEDyae5nhSUOdXBo/duRS1cTo7HS0UHkH+nNRDIISzFPJ3pIWupiexZsndqfJW0oztThz8R7C4ev8LGT5Pi4OtqW5Pmy0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGERCKct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83DCC2BD10;
	Tue, 11 Jun 2024 07:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718090817;
	bh=iuOB2LsQWK4Lkwwodvl1jWuCTovzR1GweHkEYEJmjOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGERCKctz2/Kc9ktdEVlLUjHyF80NLdjv4CUSslRddBp8ZzvrBXXK+LNkO6c4Z47x
	 Cc3y1cFKmTfrsXevRWnhx8bfBdslyftddPFaPy7vvcF+mp6qhaC/0d1LqGx5jR7Zm/
	 62/g4ya2eCkX6qQ5eBTLFZT7+C+YG1/ktMRDgIfo=
Date: Tue, 11 Jun 2024 09:26:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danny Lin <danny@kdrag0n.dev>
Cc: masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	=?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] .editorconfig: move to Documentation/ directory
Message-ID: <2024061144-slander-occupancy-8c8b@gregkh>
References: <2024061112-kilogram-poker-bacf@gregkh>
 <dc9a785c-f8f1-474d-ba49-31de63dc5e8d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9a785c-f8f1-474d-ba49-31de63dc5e8d@app.fastmail.com>

On Mon, Jun 10, 2024 at 11:53:46PM -0700, Danny Lin wrote:
> On Mon, Jun 10, 2024 at 11:49 PM, Greg Kroah-Hartman wrote:
> > Some editors (like the vim variants), when seeing "trim_whitespace"
> > decide to do just that for all of the whitespace in the file you are
> > saving, even if it is not on a line that you have modified.  This plays
> > havoc with diffs and is NOT something that should be intended.
> 
> If trim_trailing_whitespace is the only rule that has actually been a problem,
> how about removing it and leaving the rest of .editorconfig intact?
> The other rules are still useful to have as defaults.

Good idea, let me do v2 with that...

