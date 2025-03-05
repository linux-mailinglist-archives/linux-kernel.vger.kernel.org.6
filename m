Return-Path: <linux-kernel+bounces-546270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDC9A4F895
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4CD3A086C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7DC1F583C;
	Wed,  5 Mar 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MunnFaJR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ts1ePHH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998114658D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162751; cv=none; b=dZ4rVZa0nUCSSh+d+c6FHEMnZ8sgLGWpN9AybkQ/hovzPG5DPRJQv9nb7fNRTyZD+suoPA3yO8G7mxXnqTahVaUR2iOp4Wz0/odR17j/lgieE/kL3xtn+zOMxH+x9MsA89uoWta6wJ+5+beFOYJIV+i/b0K4CYMr8pxAlH7mkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162751; c=relaxed/simple;
	bh=2Y1gglN8km+2bBHCcWRgN47mtV5DE9sqwyp7GsXlWbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNSoWkggR/RNOGu/vTze9avFhqUvelfA7/xp7Eqt5bBzMgr/6QdurI2r5okvzYZ2m4cVL5NpOxda1mbF4RGf1Tc5eYqGpzxi44235U2ZUSYoW7ixUWqxWAMLe3kkEItdoqC+diLdmPEj8mxa9eGIIqJwL4xU5iAfulGEwNAbrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MunnFaJR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ts1ePHH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 09:19:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741162748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y1gglN8km+2bBHCcWRgN47mtV5DE9sqwyp7GsXlWbo=;
	b=MunnFaJRvDeimrfh0NOU5DPvghmeUP0j+Ofp2dNsebjfX5+A9jrohIqr2W49Ks7oa6mnOd
	FyFzCOvWQr3x2dKJ1hrkiDCfKOh/IQzMj80uESAqcxMwoBWoUX/wE5HwBuZJ2BRYr0Ifr1
	/pjLXCfK0yMC7dhFLwTLsZojr9K6jmOAjG9QfZYlGwN+W2KOPb1Ya+Vf7EK28BCQc7D3kM
	HSWvQJzjlItmTtMa+kKd9aXewaQxJ34+6ayeXGQx2yakZ9Nwu0kx7O/6KKzBorOR0gOxs8
	ANCD421AIervIQtqLbFIqIz4g2Q3s0oWYUcwJ9zvrAY8HtUKMm1PO9QTn5i2CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741162748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Y1gglN8km+2bBHCcWRgN47mtV5DE9sqwyp7GsXlWbo=;
	b=5ts1ePHHwsKTvMmMmZZlPjsRZfxMq6sRJvhet63k2PHzd0/1SlRT/YoMFMchpQeYyjXnyL
	Yt2x+WN9JUEME1Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Oleg Nesterov <oleg@redhat.com>, Yi Lai <yi1.lai@linux.intel.com>,
	syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf: Fix hang while freeing sigtrap event
Message-ID: <20250305081907.xHiR7jy0@linutronix.de>
References: <20250304135446.18905-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250304135446.18905-1-frederic@kernel.org>

On 2025-03-04 14:54:46 [+0100], Frederic Weisbecker wrote:
> Perf can hang while freeing a sigtrap event if a related deferred
> signal hadn't managed to be sent before the file got closed:
=E2=80=A6
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Both of the test cases pass=E2=80=A6 This looks way simpler than the initial
attempts, why didn't we go with this initially?

Sebastian

