Return-Path: <linux-kernel+bounces-357531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E5699723E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FC71C240CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9381547CF;
	Wed,  9 Oct 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZZlNYzr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C522098
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492482; cv=none; b=skrusaAGJRCiMffHqHnQZ4Ce4mYRDBqv5MKDogaRkM2A+PogOb7TE9JZRGdl7uZtcaMM3A2amiIt+wZJpLnQ1dMq4V5jPVWARbIIcQN5WIBYqAgQ77xC7h6SCEDsnJSmcpC4AG10k77JskpJ1QgLA6OyNVnG4rDSvdcEywIcjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492482; c=relaxed/simple;
	bh=hLIAN9ux1aPc6NJT1p9v4iCX20vpsU0RwWid80EujYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3N3BpM1vRJCCvm/EDki/oyXjHi5RmzIgxZE5F58hZ+N4ud7/vnxOw8PPmuVbmJFOjOguwCL0dpMQJG/huJrHiAkks1HiPgrdSzZ1qwAtfjWEhOipOAnRmzEay5R0CqKV/HIuLe3h2WBsYPbv/y3+qBcByhihYjPVFuphiLFMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZZlNYzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E049DC4CEC3;
	Wed,  9 Oct 2024 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728492482;
	bh=hLIAN9ux1aPc6NJT1p9v4iCX20vpsU0RwWid80EujYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZZlNYzrMbc3/E+odxlDMxFltHFOxpLNtpVcEKkQjvc8XqoOy4bhbIj8fYouaUq6f
	 QsTB8m1R/RSvl11m26EXmCde9rPxKBn6E3aZQpfxl1qdQ3LW5WYjODsiZBKfEj4JEj
	 7Oa79n/BFeg030f3dlf6/vg/H+WL0yPZ4rnmRJx07DvHYTYHlQfxOJydjo38rAhkA0
	 E55L6wqUwy+SxBrc6uUeewAPSv7LX5oxpHvp+zekBqZWXC5OG38h0OwPF/OUv4xSxz
	 xvigoX6E8igHylgH4ryKJKnosE7dhPbRYlyvgheo+s8SNqMzrQxow98fWWNnWEM+v0
	 vwOfroUeTamBA==
Date: Wed, 9 Oct 2024 06:48:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: use correct function name in pick_task_scx()
 warning message
Message-ID: <ZwazwQBZdLtnsi7-@slm.duckdns.org>
References: <20241009030602.91216-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009030602.91216-1-jameshongleiwang@126.com>

On Wed, Oct 09, 2024 at 11:06:02AM +0800, Honglei Wang wrote:
> pick_next_task_scx() was turned into pick_task_scx() since
> commit 753e2836d139 ("sched_ext: Unify regular and core-sched pick
> task paths"). Update the outdated message.
> 
> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

