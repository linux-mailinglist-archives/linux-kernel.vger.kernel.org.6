Return-Path: <linux-kernel+bounces-192438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F78E8D1D42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0371C21802
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62C16F289;
	Tue, 28 May 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vlybEr0m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTyxuErG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183B17C7F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903633; cv=none; b=p1zJC4rc9nO9zCe5OQBxd69yxMOioWv5OjXzVLrJWr10+7sbqKtwVoSmJQ7Kcy6iX2k7W6kLyv+yZdlbU52JviQn4zsl94gK4J3evIAiQBieaFhKos2u9CBdGRS0utanmInSvEDtNTPAMe9hdbNW0uGiRZmWlUG6xbvNgLnGzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903633; c=relaxed/simple;
	bh=jCsWH/d8W7fB3e1UAVqtUFoeOTBe4TZO8l/pIk2nA4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jADJ7XXntD7uEEoFQ8bIGqsNF1F3l5PsWStA/TmZIyo8Wm10sAYhKVFtsXc/Hhjxl5JTXi2p3u1CIUJE06zfs3sJb7v1/Mf7KFq6pv3ZHPtFPF5IYxhbXkEkok4OTuaFQ0SealnztzrR13j54AVd0oufqckDcLm702cGOSzfDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vlybEr0m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTyxuErG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 15:40:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716903628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAVkJCXJ4dkn+VlJdVdki+iHlel2IgcpuHOJvEpfZzg=;
	b=vlybEr0mhOc2+ZEjIFHVBhIOrIA9J0OSOvh7I69CVsMFLfXDR43kB82+V3m5RNAwnwKqvD
	36srCUHqDfoIJGt6PHbUrB2MCLU/o3miqCWr6GUzHhtFUUk8iTF+hJ16Mngnod1X/Wz+0y
	ldkRBtgs1GmlHQPzbvg2BDt7u/H3Sa1JVAXB3f4nnobJEnRHpPXO0b9cL6VDelUidNxJoA
	tsQa7mrOOvnCojzK85mgPnqIgoL/05JsKSfgMP2r6m5j74xstw2jmaUF2E4AOIFEnWTJeK
	rDPNZM1mfboBQDzpBuZHBkUIdhOnBpfmg86gGkVYw3jnO0JiVcZMxQs6y2GGcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716903628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAVkJCXJ4dkn+VlJdVdki+iHlel2IgcpuHOJvEpfZzg=;
	b=dTyxuErG1eKdw5YDua9/Tanb4X6kCsKzP391CYzeNj2f4YmUdOKv4ExWTvhdVBzwgfpkCt
	TFrGd6BDWgp638CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Message-ID: <20240528134027.OxDASsS3@linutronix.de>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>

On 2024-05-28 14:34:55 [+0200], Vlastimil Babka (SUSE) wrote:
> > The safety of the counter update is already ensured by
> > VM_WARN_ON_IRQS_ENABLED() which is part of memcg_stats_lock() and does
> > not require yet another check.
> 
> I think here it's __mod_memcg_lruvec_state() doing the VM_WARN_ON_ as we
> don't go through memcg_stats_lock()?

It is either VM_WARN_ON_IRQS_ENABLED() directly as in
__mod_memcg_lruvec_state() (which is special) or memcg_stats_lock().

Do you want me to rephrase this part?

Sebastian

