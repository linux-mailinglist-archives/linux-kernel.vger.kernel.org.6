Return-Path: <linux-kernel+bounces-380289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1E79AEBBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24072819F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D644C1F80A1;
	Thu, 24 Oct 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nQC58c44"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE01633EA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786765; cv=none; b=EVy0jNPNjc2Gluq3eqigD2sLNUh9MtOTmyfmPaGHTAC3+V7eQ8ltVzDCpspMx9keCV811JgPSHX/thZH2kl7/r8PjWd9mQ3RNp0j+Tucx2RNaSNmG5jJ6ckZU2a5IuD88zkV075XGlO3LXWBjbEP3fkZuGekgjpVER+TxSq1kQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786765; c=relaxed/simple;
	bh=475YnfWnYBje4bzVTPJzQFtKcIzA1DKqzv6pac7oe5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTG9hRsj7V2SdjAsrSj9XIex5v6rGzC1Ejlv2a09PDimJk/6o/LG3m468w1Eu/8FwTqc86BmlYnYWhEdHhMV3+3uhUUUmTTIb41ZfRuecSLHbsoZB38nWRq/ttu1VVrGpT1jpq7zEhzQI8e+IdrLJHHWLKsumrQoC5pj2aia6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nQC58c44; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b467be5f-6c18-4a4a-a669-0708fd9de2a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729786761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=475YnfWnYBje4bzVTPJzQFtKcIzA1DKqzv6pac7oe5I=;
	b=nQC58c44p1tiPt4bDeP7p/hczaqENfHVDbGJ2voLB/cGYAIHfjdSqoG11i8MYeVFEyH8Sp
	vSBClFb2gJUclwPyracbtZuRJgEITXZpLqQ+sjF304u1dfhBE/vdnyVra3JSdBDYzucsJ2
	KPGWpJHrpS2IQUdd1ogbZK31z7xoG18=
Date: Thu, 24 Oct 2024 09:19:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Rename CFI stubs to
 names that are recognized by BPF
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team@meta.com,
 sched-ext@meta.com, David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org
References: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/23/24 5:54 PM, Tejun Heo wrote:
> CFI stubs can be used to tag arguments with __nullable (and possibly other
> tags in the future) but for that to work the CFI stubs must have names that
> are recognized by BPF. Rename them.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


