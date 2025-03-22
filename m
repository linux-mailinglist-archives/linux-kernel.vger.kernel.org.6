Return-Path: <linux-kernel+bounces-572122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8915A6C6C2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD85A3BC350
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF37EAD0;
	Sat, 22 Mar 2025 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="prqnxbkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034299443
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742604821; cv=none; b=EIzXm4U/zdcXIvylRVJSR9MwZY1gjV3922gzz0XfH3sTV/tZncdo3CuKb8PZcMhH58YxUqbTVLWzNjkC6g9zqbv8JEsNyXMh0dafcUXxVi9lj1Z+t2wjDhtiVubSr8Al9dBCEkZ9fZgAhez7hOrwmUMW1hyOufqxYN2qZEmbZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742604821; c=relaxed/simple;
	bh=+CF3vr8DE+bHK2WCcftcSUttYfoGPAboQBuJMb7Z1xc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GLPKSJyi2CucryQTnAGPT54JwWh5fYyJFNFCNR0+kOggHzidYo+Pfxw4yjlidw6Ob6K7RWLildmm9r5rYgQbH/br5irKzcYvKm99D4ndYXnYO+kG1x1HJMclyU5zQjTbzOSL1UsWmNO4UBipZzYy6eZJCLHrskTn7IBgkLLJNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=prqnxbkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4CFC4CEE3;
	Sat, 22 Mar 2025 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742604820;
	bh=+CF3vr8DE+bHK2WCcftcSUttYfoGPAboQBuJMb7Z1xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=prqnxbkAYyMdSTosYM4qFLTFY/AZSIZhbW/bBl65aP/ljOX4mqxJvnRPeMj5LuGtB
	 RbrBjhh9bWfRLtyGQcBAWBZLCx4NUbElFi3Zlnsko9GboNEmUGojM5eskGhG5Iz3gp
	 2vWVWgJTflfLX90aQXqfw5WzoBuHs15J3YNj8rE8=
Date: Fri, 21 Mar 2025 17:53:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Axel Rasmussen
 <axelrasmussen@google.com>, Mike Rapoport <rppt@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>, David
 Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as userfaultfd reviewer
Message-Id: <20250321175339.e8de6020fec6ea62f3b179d3@linux-foundation.org>
In-Reply-To: <20250322002124.131736-1-peterx@redhat.com>
References: <20250322002124.131736-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 20:21:24 -0400 Peter Xu <peterx@redhat.com> wrote:

> Add an entry for userfaultfd and make myself a reviewer of it, just in case
> it helps people manage the cc list.
> 
> I named it MEMORY USERFAULTFD, could be a bad name, but then it can be
> together with the MEMORY* entries when everything is in alphabetic order,
> which is definitely a benefit.
> 
> The line may not change much on how I'd work with userfaultfd; I think I'll
> do the same as before..  But maybe it still, more or less, adds some
> responsibility on top, indeed.

Thanks.  If anyone else would like a cc on userfaultfd emails, please
lmk or send a patch.



