Return-Path: <linux-kernel+bounces-240325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F34926C2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D4281202
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079EE1946AD;
	Wed,  3 Jul 2024 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScQ7Tf55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9513AD27;
	Wed,  3 Jul 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047644; cv=none; b=VIO6r8nL9IK79gxO0zdiS4sliyKI0GwUssRAn6zRPiAulGT6F6t5GKi3MyFuqcq9nCpJKt3P5aHRS1Fob9UBT+BuWpgWe+V2MOpIjXHFWNbJ8MlS77EaDgM1BHhvw0KJLx3178Ofgfp/IkpvNPO5oPozwIi7SswT6hmhVrbZGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047644; c=relaxed/simple;
	bh=QrxVFpPiW9yuY94rmvTNh1kcmX2+boRlejh1aKWSj8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M24I8YtlKJp0oWV2Z6i8X0i02QCcRmV/tXrosB2Ysdy4o2gNkvtdJILqKxp9vQQ0KIzVf4HJ4pFt09VM3hiC8zGhUjLjEatGmaaP3n0NYEgvcnbrU1iY+Ra/luRqS8dJ/djZju8ACEHvEhhPYq4gdfxWHDvF7/IKfIB7yI/rtH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScQ7Tf55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24735C2BD10;
	Wed,  3 Jul 2024 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720047643;
	bh=QrxVFpPiW9yuY94rmvTNh1kcmX2+boRlejh1aKWSj8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScQ7Tf55K50IDT4ZgmFafSUZY8XgMRYAVZpfDY7yKuSg35SnQiCPTqDSqr7P0t0k3
	 ZRjbtpcyJ045EgP+GXOIaXK0q1xFCv74P1/82FudPLb5VTmlqWQbA1oXAX8lV+cYcz
	 k4Xx/QSELc9ov8Mc9xA8GCmggL20l4co+yuPz+qNAQbkQo4sr6jC1DOTP2Jpo/lFJi
	 EatsSRmvky9R7SAXObycjNZzB1PBfAB9X1apAxXvnuKStWiL+l6m0VgI0Ry81tIc2h
	 a+No+mzGbrvFe3mspcv2SsbninAGs3pWBAgUjlwsi6qIo0hOTxn2oe0s1bkoVk5Tor
	 kxr2TTAhhzVuA==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 4/4] Docs/mm/index: move allocation profiling document to unsorted documents chapter
Date: Wed,  3 Jul 2024 16:00:40 -0700
Message-Id: <20240703230040.90283-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <87msmyt8zh.fsf@trenco.lwn.net>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 03 Jul 2024 16:18:42 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> SeongJae Park <sj@kernel.org> writes:
> 
> > The memory allocation profiling document was added to the bottom of the
> > new outline.  Apparently it was not decided by well-defined guidelines
> > or a thorough discussions.  Rather than that, it was added there just
> > because there was no place for such unsorted documents.  Now there is
> > the chapter.  Move the document to the new place.
> 
> I'll take this for now, but it's truly sad to see new documentation
> being added to the slushpile at the end.  It seems better to create a
> "development tools" section in the new outline and put the allocation
> profiling document there?

I have no strong opinions about that.  Cc-ing Suren and Kent, as they are the
author of the allocation profiling document and hence might have some opinion.


Thanks,
SJ

[...]

