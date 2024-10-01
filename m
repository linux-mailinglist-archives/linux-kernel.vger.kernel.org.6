Return-Path: <linux-kernel+bounces-346584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B9298C636
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F464286054
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EDC1CDA03;
	Tue,  1 Oct 2024 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr/uXv7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35241CC141
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811996; cv=none; b=e/HWrYTQu/tIDAMqOejgS9DgfleOtsCI0SHddP+l/VeEoB8oZyb8qfPXedwWwDGVW2OyAGXKMhGvdrK9P7LliAyUUdIxveQ2XfnpHYOYTxN046ERiiIPkHnvYIsvqkC6woOIZZzJYiCGh+Xs3WoR4me927Zc9g2SpAjl7OgdXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811996; c=relaxed/simple;
	bh=4TAqwwU9ygi4B/CYgE9ehjp3IymoTX4BUtJEz4/Bxxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvluvkxblPzVL7nTDg/V4N2r2D2Vy15rc3C26rpqtNlSOvajMa+KXHRDlV9y5xxWFl8G4NeDpAmd5qYeKDhV4ANpyDpqwjEE6kMG+xPk1xJji7k580+yIiqj27gJ65j7yI+Yg2rikpAycKhc2O3NXhz9NrknISKWDKKKmTIM33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr/uXv7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578D1C4CEC6;
	Tue,  1 Oct 2024 19:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727811995;
	bh=4TAqwwU9ygi4B/CYgE9ehjp3IymoTX4BUtJEz4/Bxxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rr/uXv7KzE7smajMPn6CBJrUBs8LRup40VvVLzAnvtJKvv19zmrVrWe7D6jKxIMHI
	 Hsux0w/rB1N4snGwlIAc2FOSRmZ/cBR7ETyUpYz9UaAb6eIhBRQPPsU+OfrnZ46I0t
	 FJyBucpttwPz8R3p6GoLxev8pnqXKFznhmMNFqmX2h0i2NmThhhrurkFVJSK65YwgL
	 uSkObifeXu4/8tdzoF3I++dyzRqAEIZ+C0MpV0oRTf+PBU9VpP9mnY15Qmc/X3g8/E
	 dF11xsWsPG9hLOmfEi+OyWjEc0BXlMWt+iZT2+kGxnBhum39xDqPTmfwQY7fCIg03b
	 d+JypEDq+2Ysw==
Date: Tue, 1 Oct 2024 09:46:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthias =?iso-8859-1?Q?M=E4nnich?= <maennich@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	peterz@infradead.org, void@manifault.com
Subject: Re: [PATCH] sched: fix include for task_cpu_possible
Message-ID: <ZvxRmiro3oE4hDgO@slm.duckdns.org>
References: <20240930164455.2060692-2-maennich@google.com>
 <ZvrZsQ-uXHFQsxII@slm.duckdns.org>
 <Zvs42l4A9wvqnLFK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zvs42l4A9wvqnLFK@google.com>

On Mon, Sep 30, 2024 at 11:48:42PM +0000, Matthias Männich wrote:
> > Should the patch also remove mmu_context.h from kernel/sched/core.c?
> 
> kernel/sched/core.c has a call to switch_mm_irqs_off, which is defined
> in linux/mmu_context.h as well. So, no, the original include needs to
> remain.

Hmm... I'm a bit confused. kernel/sched/core.c always includes
kernel/sched/sched.h which collects all the shared includes. Why does it
need to be repeated in core.c?

Thanks.

-- 
tejun

