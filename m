Return-Path: <linux-kernel+bounces-204083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF98FE3D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F0E1C2132B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B50E18FC6D;
	Thu,  6 Jun 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G0WNRQQh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxxuNZFW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1717D36B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668536; cv=none; b=sVU/aWKiSX9pw+w79YTAn2KlbEEJh5ivzcIdwr8RBiJrAJx2w1lCT/ezaN07Kxpsgmq6yxMmiQ1/kEiRdDlPDB3BUrEu6x8uCIX6tKEPDre5opDv88x72QxEp/2glnUOEe0HMlyeOCMaqpior39Pa39GqEFFMO61R5ai2dpETlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668536; c=relaxed/simple;
	bh=3M0gJX6vCn6MWF/imG0ZGKkB0QrRPP6O47dIjqNIQcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEFX/7PmgE3dxy/ZdxB+NhaEF055DqeQ2uiCKbUtREQMnQSMT+gL9KVuZg4Cx1wFIkQJyPhgvj1eQqsje14K0ONOmjZilIff/BRufWbcgtPGrJn08G8kjcUp/2q0sXuVuE/DIv45Vn6wUenoMyOCp15PW/5jicMTFbm3mmhf3vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G0WNRQQh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxxuNZFW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Jun 2024 12:08:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717668532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WqEabuleFVGI4Bpli2Csrw15euWmSuZ3oOxISs2N7T0=;
	b=G0WNRQQhayj9rycvzywxCjl/Me91xNP1sFH3CwBZcxG5+InH8u5wpTp3I0RHiEsghYkw07
	oSmSDHbbkms3976PrdAipSpJAbJoJ2Rmm1aqXpwfpuC2kp0NVKQlsPhQ15jWmzuJJ2s+C7
	NCf7eFFbze6k5wFiomefj2BsCy5iTRxUjK76c73Q5az+zEzi99pBuUvR4EW7pcDhI8vPaD
	wgN7Gi4HVSokrOuGB47a634ORm+eaAOpLAVbcssltLpGXRrsirkDe+fw2HzcuOB+AtIdwN
	BFOylvfN+0z1Ixs52pseXpqCivCmDPVHx2XAjaWPga8KoKedqGDm1C3KXnlWWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717668532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WqEabuleFVGI4Bpli2Csrw15euWmSuZ3oOxISs2N7T0=;
	b=bxxuNZFWHbVeBoCwQ5D/Aq46K+fjoWNIwm06NSugsw3x788mDZ8B29+0c9uFc6dwBaMm8n
	AduY/yzp8wAfIAAA==
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
Subject: Re: [PATCH 3/4] perf: Fix event leak upon exit
Message-ID: <20240606100851.QI7uQRSB@linutronix.de>
References: <20240516140936.13694-1-frederic@kernel.org>
 <20240516140936.13694-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240516140936.13694-4-frederic@kernel.org>

On 2024-05-16 16:09:35 [+0200], Frederic Weisbecker wrote:
> When a task is scheduled out, pending sigtrap deliveries are deferred
> to the target task upon resume to userspace via task_work.
> 
> However failures while adding en event's callback to the task_work
                                an
> engine are ignored. And since the last call for events exit happen
> after task work is eventually closed, there is a small window during
> which pending sigtrap can be queued though ignored, leaking the event
> refcount addition such as in the following scenario:

Sebastian

