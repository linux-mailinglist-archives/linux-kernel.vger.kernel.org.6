Return-Path: <linux-kernel+bounces-204093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA33C8FE409
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51882284517
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B07194AEC;
	Thu,  6 Jun 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cWZ7zbat";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKpMm5MV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF38158848
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669018; cv=none; b=Jopdo+87CbTsZDqbAM8HHMM5Syo6ZeHmaH3E1fVxxC9YhZujrzqBKvvmf2THyR2mj6JhWyvrNLIxAhK0PIcUcPYnylkt7JDe9rbXECuYIVpiFJ3sqTyQhuVFas6CK+t9l8DoLWnqLH+yn+yOmOaFUslzxCS06b/YKIngVdZWRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669018; c=relaxed/simple;
	bh=5A8sf7+yLRYKY9ELUuBQgOLbkKskjjU7WN2pZkuN8Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3jSAHhQFkyjIBwJd1RHeuqmtnmDiFPTYHT0a1TGvbD0hpCHQIVH9v+cl+KOWYHLAhzZ+7oj4Mdkci0vsCmqBxvNdHfu1/aJ4qHLt0/0NT/aeGsrrr4BN85ehuZaBSSGTZbnRyq8EsMwVwaQwokNfCq2X9vNzE618d3go+WHqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cWZ7zbat; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKpMm5MV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Jun 2024 12:16:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717669009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nB08h6l0DX4mfAbuJ0lVlp4ndJx2Sw6kgwEfV7ZfKZA=;
	b=cWZ7zbatMUtio6jOGpnHxn4S/VFCQOA/OeAiUilP6VzrTsvfPTOQ440kXTRTutDQrdMu0L
	803XCgOAAkqFEJ2fKPiyKgsKCYf62khRoYmXoEhCj6ZWkmPW90e7yaoOzfO0er91JF9HBT
	tPSHwSOWmZ3VP+XO6KxxJlRxpnk+c35TxzpggbKccRwimQwssoILv/LCJGE+gMZWWIr2Oa
	TmomMYrpoC+uzerkBO1EE5jLxldWfWd3/v55+E3wvpC89K0YgoDH8MBbC94kfvXFbISOPj
	vBMM7MC4GX/bY0+pxoRHnTXtg4uOzoXWL+S6aHUU+SpZzQvOqHj9I9QHqkJsIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717669009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nB08h6l0DX4mfAbuJ0lVlp4ndJx2Sw6kgwEfV7ZfKZA=;
	b=vKpMm5MV5/unNJK57XZLa3psO1Km1djXUoc2z5/BgJiHh7yyDYxz+b3gLM/NEh275qunBG
	eSGmQo7qILdVerDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4 v3] perf: Fix leaked sigtrap events
Message-ID: <20240606101648.D07Btzy4@linutronix.de>
References: <20240516140936.13694-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240516140936.13694-1-frederic@kernel.org>

On 2024-05-16 16:09:32 [+0200], Frederic Weisbecker wrote:
> Changes since v2:
> 
> * Simplify the branch condition on [3/4] (peterz)
> * Rebase [4/4] accordingly

This wasn't applied in the meantime?
I will try to rebase my patches on top of this series.

Sebastian

