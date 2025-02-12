Return-Path: <linux-kernel+bounces-511304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE79A3291F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FCF7A2ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF19210F71;
	Wed, 12 Feb 2025 14:51:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE020E315;
	Wed, 12 Feb 2025 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371866; cv=none; b=iEO7ZkXxIQ29sm7VnqYvDddaoUJXfQK9sf8naxhenwDXoaOGS+W3QD4ZRz9mlp8FpsCCNDtvcA0cQZ4cGKWdmQaNZNkohGhljdndCTJm5PjNris9ToWB3aX6yg7r/+8QlRDhJ/rzskrotXffiVp7gTbvIUlqBzpRNjY/bARYWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371866; c=relaxed/simple;
	bh=OjJ1FlXU0I9LAmFUCM7zVyKA18/G1eXx7FGDi7SeJJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUzo8f8FD5IQeAAnMb/Qo/lYf83tBUK4nyYOxxi24W+CCyS91MrtMygm7b4FVauZMd1S4I1OI8LTTDUxtnxGHwQVzTnkzKMHP4iirWax6OvJcLEQ9rcW4YsU+9h7J8O1+jk8rFhIuFKSnn/akwylXZR3XSst/XWZYdQJGgE4wQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA8C4CEE2;
	Wed, 12 Feb 2025 14:51:04 +0000 (UTC)
Date: Wed, 12 Feb 2025 09:51:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, mhiramat@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: trace: Refactor index documentation
Message-ID: <20250212095111.7e07b92e@gandalf.local.home>
In-Reply-To: <Z6yBtB7mjoiquKRj@archie.me>
References: <20250206141453.139613-1-purvayeshi550@gmail.com>
	<20250210174556.70fc53b7@gandalf.local.home>
	<Z6yBtB7mjoiquKRj@archie.me>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 18:10:44 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> > > +Introduction to Tracing
> > > +-----------------------
> > > +
> > > +This section provides an overview of Linux tracing mechanisms
> > > +and debugging approaches.
> > >  
> > >  .. toctree::
> > > -   :maxdepth: 2
> > > +   :maxdepth: 1  
> > 
> > I don't really know what the maxdepth gives here, but there was no mention
> > in the change log why it had to be converted from 2 to 1.  
> 
> :maxdepth: specifies heading levels depth of the toctree. In this case,
> the author wants only doc titles (hence 1), whereas 2 also includes
> second-level (section) headings.

As I'm the original author, I would like to know why there was a change.

-- Steve

