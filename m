Return-Path: <linux-kernel+bounces-534985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304F1A46D98
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA221188A9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904FA25C6F1;
	Wed, 26 Feb 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dZ1bcff/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EA25B672;
	Wed, 26 Feb 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605824; cv=none; b=SZ8B1eu5afBGZccHDjPzYO4cfsAlaFvRwYGYAuVwEUK3cyIXak0ASwOwZFpKcStePt9gk097P+ziEC8+FTAzK9uU3unmbh4bfXNXQBvq0f9uOkdfGlL9nJalvvZxkvzQOzhumgYVU+UBPRG1EHjl84eXOnTpB3RfaJXAphkiQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605824; c=relaxed/simple;
	bh=wf6obHnMMoGaG4QVY5lRk59ZLrrgwYDJxae8z9utqvM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WmifwL2xfG9c1uLHbbsJ82kUdYRfy4/6kCRh+7hUScaNWolzM4sJ97OeVV85lXu3tSNt1GX8sgWgdT4Kdc7WfLGrraWlF6/Ot3iYC6LU43+qsuctok+mepp0vzv4RITebIs+oLHSd/cJ8lD0Ab8p5JfE+mjldNuLaM9r7ys40qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dZ1bcff/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED22DC4CEE7;
	Wed, 26 Feb 2025 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740605824;
	bh=wf6obHnMMoGaG4QVY5lRk59ZLrrgwYDJxae8z9utqvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dZ1bcff/Dly+w8JhAnF7KAs+3JaKvB/tzezIFeTj41APQ1PPVufmY/Woxgb8QcSbt
	 zfeso7b96qb0NvYlMtll6uw/Ut/YopPlanNEr/8V8xzzj3ZppYjuPT/T9wRYum3JlN
	 BNATt/Cr1Ba3yIvpS3825StbXGzGt5PrdCd/lPFc=
Date: Wed, 26 Feb 2025 13:37:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: bus710 <bus710@gmail.com>, damon@lists.linux.dev, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
Message-Id: <20250226133703.3c9775c9e50e198abc9b9f6e@linux-foundation.org>
In-Reply-To: <20250226184204.29370-1-sj@kernel.org>
References: <20250226184204.29370-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wrote:

> From: bus710 <bus710@gmail.com>

Full names are preferred, please.  Actually I think it's "required".

I'll apply it anyway due to the patch's minor nature, thanks.

