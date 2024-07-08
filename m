Return-Path: <linux-kernel+bounces-244018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2A929DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6E41F20CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532E39AFD;
	Mon,  8 Jul 2024 08:09:40 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C13A29
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426180; cv=none; b=qW5OhcJ+/A4WX+2WP1qeEMoOy0jMLNISiXB342mzfVs1tQ6md5d7SccQ8dDqo13hhZF3p4ll1RO1iCyEPCofwB2PTTns1MQoMpfWvPR0uBCpzz7Zqm8VOlYlFFFIPeIAS+gHx3V6VVugsqMcrWNjHtPmhLUa9nlVJA8TKQNvf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426180; c=relaxed/simple;
	bh=bH6ZaKSTs+D6YdWUNgouudH2b2WD0aTRgHaF7g7XdG8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l2kjkYD8dCSmJbObLrRUTNsxSAbPgLczijCNEgYKgCNgsoFLEHw5ackNmp0XhjEGfA2FIM2+Mfof7e4hI6RQc2L9HohM7e5gNZ1X1eyP7d+k1bE2YHS1nChYFJTyipJIGfWxGB3F9bNkU71aFHvyEsRIRfab3o0nAblpiiUhhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id AB70A1A112F;
	Mon,  8 Jul 2024 08:09:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 9C2816000D;
	Mon,  8 Jul 2024 08:09:23 +0000 (UTC)
Date: Mon, 08 Jul 2024 10:09:22 +0200
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
CC: juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: sched: Update MAINTAINERS
User-Agent: K-9 Mail for Android
In-Reply-To: <20240708075752.GF11386@noisy.programming.kicks-ass.net>
References: <20240708075752.GF11386@noisy.programming.kicks-ass.net>
Message-ID: <83E249B1-6F84-4A98-BBA2-0D944A240422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9C2816000D
X-Rspamd-Server: rspamout07
X-Stat-Signature: q4dy7mcfm5muzzj7k1f14kz83iop6wqz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19MDnu7EcJWOIIKZtiv8QVCCae/Gw/c23c=
X-HE-Tag: 1720426163-419174
X-HE-Meta: U2FsdGVkX1/HeVUzadppj+YXF0Y+TUi1Fgx5+21on6BbJEY9Uv0LL6p0u2+AUgTjIYivgFbWKS66SxyyrN6mMzLM+U9IWqF1vOSUsNQ6XTLCYSL1Kft1unUq8oF38IlBX2eZ4vvVcN97/rgEFApRJKHJOm+8O9uYaKsyjM86Hl9vUs+moiXEQ1DT+c7eVJQLRSdn/OXxj977Kj4soxsMF+qyFmZx8URUjqlo5escx/nTUrfumbionxkqI2aBzr8qa+xMkZyirJIsgGNo6Jq9pkENUtjVWQwTPcez3gxLulRnNSSiJsrR3X+ot1NlJu/33lOPWY1SHqoaFnsgV8XWU8FS8wNwK5ed08TfLFlmksGWY+MNAtVaQB9moMNbJk5J5xf0zCpTIH2VfnbcvkXQzhK/MJg8XhKAH7+CE/SBWsxXiQvfbAAZY1s2PwSztkzJDdOFuFZcmy3xIABboiUUWSHXAmRdGq9DYTc84p5mTbTQXGbY/hxn3FJfzdczAHgeJEaQ2bZVB63j1EHphJb8LiZMiqWCjEL3HAudX4JczR4=



On July 8, 2024 9:57:52 AM GMT+02:00, Peter Zijlstra <peterz@infradead=2Eo=
rg> wrote:
>
>  Thank you for having been our friend!
>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>

Reviewed-by: Steven Rostedt <rostedt@goodmis=2Eorg>

>---
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -19929,7 +19929,6 @@ R:	Dietmar Eggemann <dietmar=2Eeggemann@ar
> R:	Steven Rostedt <rostedt@goodmis=2Eorg> (SCHED_FIFO/SCHED_RR)
> R:	Ben Segall <bsegall@google=2Ecom> (CONFIG_CFS_BANDWIDTH)
> R:	Mel Gorman <mgorman@suse=2Ede> (CONFIG_NUMA_BALANCING)
>-R:	Daniel Bristot de Oliveira <bristot@redhat=2Ecom> (SCHED_DEADLINE)
> R:	Valentin Schneider <vschneid@redhat=2Ecom> (TOPOLOGY)
> L:	linux-kernel@vger=2Ekernel=2Eorg
> S:	Maintained

