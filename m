Return-Path: <linux-kernel+bounces-231617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D8919AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5275A1F22DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789F194083;
	Wed, 26 Jun 2024 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="V3TRTmAw"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0660181B80;
	Wed, 26 Jun 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442691; cv=none; b=jRMYVjHdedIfnIcqxP5jux0SyUKlfgPPLeC3m1v0g0Bv9Ljjo67I3smbakoYrpVFzz0SwxQRMn6tlnucHCoOn9/zZvUT+apvzYH8Z9rerlU3PeWb5NPFJbQP34H1PmZ9dggYbYzhcxjY7aTopLtOGVIyA6mWZuONLSeTxs5B6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442691; c=relaxed/simple;
	bh=3ggciXfkKtod5+5ActdBNmx2SFruhRoKb3wtvraDCDU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQ+a9B3t7Z/aenDL16bCyKGIdtcU/YwFG/TMigMJiV7G2RONxl8aSDHy4YL63tvgCV36o1BqzmmtMM7QsrG9JCkhrMsqW1mt1S9LZ9kj7yfTa+infakZIfAF9S5c4804HvF4ghmI3v3+6MnmUc9ifrXbnGt4ixk1/909AJkYfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=V3TRTmAw; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D249C45E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719442690; bh=rpAlUTxdQ9UTDQ7LCDE71kXw/lpo/I0zJuqonJl1HnQ=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=V3TRTmAwXPuRpBqaxG37Af+MVs91HvHdcZ2cp6F5kkyd2k5dNzSa0VRjkPMmfyO1C
	 UglG0jKSV3y5uIef84cJ4vb80UbCNdUHurkjyZl51tuuCXCWfeZ5gzsna/l4ifdWHo
	 F51YsL0LtmhMLZqRfW033IxIYUd8yG5+9SVHLgBEWRk4eZNvaq9drFxit2osLgnExS
	 6V24GqnaenH1oQ2rg/MhxeCnJdjUnN6rRb7SAuHzVXupyWhkKJ1HYYQ5vlJXlRAUZD
	 6fCq39p1XK1bx4KagGWl/JOdOQeFpQk/vNkHe7yBHht4fYFZ0NR7uhteL16h0odfYL
	 4OJhzr1VRyEjw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D249C45E2B;
	Wed, 26 Jun 2024 22:58:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nir Lichtman <nir@lichtman.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: English corrections in vmalloced kernel
 stacks
In-Reply-To: <20240619215944.GA3571421@lichtman.org>
References: <20240619215944.GA3571421@lichtman.org>
Date: Wed, 26 Jun 2024 16:58:09 -0600
Message-ID: <87msn7xqf2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I have applied this but...

Nir Lichtman <nir@lichtman.org> writes:

> From 34f137faedf7769b2ab8c834ce57d4de56eb0d88 Mon Sep 17 00:00:00 2001
> From: Nir Lichtman <nir@lichtman.org>
> Date: Thu, 20 Jun 2024 00:45:14 +0300
> Subject: [PATCH] Documentation: English corrections in vmalloced kernel stacks

This stuff ^^^ just has to be edited out when I apply the patch, which
adds useless work.  If you don't use git send-email to send your
patches, please make the effort to send something that can be directly
applied.

Also: when sending a new version of a patch, indicate that it is such
("v2") and make a note of what changed.

Thanks,

jon

