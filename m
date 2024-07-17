Return-Path: <linux-kernel+bounces-255603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DF9342D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69621F232E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98318508E;
	Wed, 17 Jul 2024 19:47:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20651183065;
	Wed, 17 Jul 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245678; cv=none; b=uyq4vyEHDoeNstqVnaGJJVRVHGnfR5N4/pPX4/X7HbNmbJ4hOjR3AwuiQlegxi7S++3nSGlCJq3ZimP5Ps7l3tD/ZsUSBtYN8FECpp8Zya2/hCMVhDpnS8hbEEXhwAj/z85kV4izN3b37MNHWwtjKWKCIlPW14gCPkdi+diVN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245678; c=relaxed/simple;
	bh=WtQscphKD9WrFFgvF1XmBmMBWuN2XyendL4Q8loY+b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2kHgGEUB9DiNMAEPkcf7mI7gdpc6oy7ju/e9pTLJOYyPx04v2EG0vWgVndq5O+h65CG+CnOMsqPTN+aLHj5xViC4/vAgg+BzziXYh2fKn0EVUn0iXqxN510NdYr7oZGt+n0iFvUUOuvK+78DVSyIzow4FRc/ihauQN49y9eMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A039E1063;
	Wed, 17 Jul 2024 12:48:20 -0700 (PDT)
Received: from [10.57.9.252] (unknown [10.57.9.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67E03F73F;
	Wed, 17 Jul 2024 12:47:53 -0700 (PDT)
Message-ID: <b12aa046-b50f-4c05-b996-9f8eba0d43ea@arm.com>
Date: Wed, 17 Jul 2024 20:47:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] perf build: libtraceevent, libtracefs feature
 check with pkg-config
To: Guilherme Amadio <amadio@gentoo.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ian Rogers <irogers@google.com>,
 Thorsten Leemhuis <linux@leemhuis.info>, linux-perf-users@vger.kernel.org,
 linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240717123147.17169873@rorschach.local.home>
 <20240717174739.186988-1-amadio@gentoo.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240717174739.186988-1-amadio@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/2024 6:47 PM, Guilherme Amadio wrote:
> 
> This patch series is a continuation of recent work to use pkg-config for feature
> checks for libtraceevent and libtracefs.

Tested this series for building x86_64 target and cross building aarch64 target:

Tested-by: Leo Yan <leo.yan@arm.com>

