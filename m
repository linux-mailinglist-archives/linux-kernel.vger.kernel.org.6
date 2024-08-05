Return-Path: <linux-kernel+bounces-274806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E7947CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B321C20FDB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8B13BC11;
	Mon,  5 Aug 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHA+dfAI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA2139CFF;
	Mon,  5 Aug 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868814; cv=none; b=LW5LYDJ6l/WP43Z3b6RYwBnx5viSWWkZIn9CpJqfhLoeZyvkeVSFnoMVSpqwq9DNM58tevI2u0p2BKS/Cz4lN9g7sLcp0Te6N1IlcdBxsoc1LRmKmcfMaqr9zZMd9mFVxFoGVRcssw9o1piHouPGSKFZNKQ+OORSugpYfPKQNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868814; c=relaxed/simple;
	bh=I0HFxd1bsijwWSloHgrp1xwwDQmR0UsPmJGs57EAz5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLNP1twPzqnR7D4OSLr6wRkAf7WsZDi7l/CLgQwm2b7gXC3S24Y4a1cre0y66BkyEItCZIa7thCK2Q6oLV+basZPpFdm4RQpr+p3kp4RjoQXBc+6rz3Dego4wqQmLved8l+NsXHtcFHpJUYJ60aavrRVffpGeFv67ltuFS4tt50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHA+dfAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24594C32782;
	Mon,  5 Aug 2024 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722868813;
	bh=I0HFxd1bsijwWSloHgrp1xwwDQmR0UsPmJGs57EAz5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHA+dfAIYyMaVzOt786aDrV0ZRl22NoDQzGPIMJdd1d88IHLYJYIaa2slTMFTCIAw
	 KaWBQaViFB6+UMkXgfl9FhmCG5MBgLQUmRoTPm/4Yx7Q1hEg/vCuHsRIRv4oX2CuIj
	 CVc02HpzqBaX3v8MxXxFA4lhqTafX1HvwwUXk2i4b3Szp1BrVsPChGqbAcvm1OZ7d5
	 4kaW9hF6waqh1TBUNdpiMS8T0q0kTZQZ76JX3sZaOcv4tkR38eI2saT3qzwsste4l/
	 qTntcovzg0FBnNclTvQjSScvyvKFvN2586WmbyL2bh28RkMSGpQYOrbcpciM8J7eO7
	 SM3zLCieZuW+A==
Date: Mon, 5 Aug 2024 11:40:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf mem: Update documentation for new options
Message-ID: <ZrDkSqTpNCitJ-1K@x1>
References: <20240802180913.1023886-1-namhyung@kernel.org>
 <CAP-5=fU2HNnJKzRQUaM51ht7evxO30gSR0H5sQ9mSOE+xqkLjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU2HNnJKzRQUaM51ht7evxO30gSR0H5sQ9mSOE+xqkLjA@mail.gmail.com>

On Fri, Aug 02, 2024 at 12:00:27PM -0700, Ian Rogers wrote:
> On Fri, Aug 2, 2024 at 11:09 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add a common options section and move some items to the section.  Also
> > add description of new options to report options.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to tmp.perf-tools-next,

- Arnaldo

