Return-Path: <linux-kernel+bounces-296143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375C95A63B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45A31F22A13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68B170A2E;
	Wed, 21 Aug 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rphYCJuf"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E016EB76
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273849; cv=none; b=CjqqolbEUOsYUNxnOUy0NnT29aLkceTuZXvsULR5gIUlnYAOlY7dbE641nNF1HoEdXUVaP2cvPr68nX7pmNtrr7WzLASnvmxEVw8/lR03rSCvpIzpFg1h2wF30gjP1UNZMSUDphJlC2TmxaXzGMur7L9W/QKpZbzHuQxkeAbiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273849; c=relaxed/simple;
	bh=koV1Z0ezM9KjFQsYj8gKIqQU27srf1FA8/z4SHqXXsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jt1owcLvGHwUVsSIcci6FtEQv5AMb4c/jqVckD93GekY87szTvWSC72jaFZicQhy9fHWkPjZp0Wf5rLB7B55q1fZcQiuUbU+0iOLxiweYMZzRUPHelmCUySWT9X79FTwj3T/1V87mGdgZzSaCFg2q8PAno8vVsyQ5+r73Bz0QFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rphYCJuf; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0da394e2-e124-4171-aeb2-92f27e1cc742@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724273845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=koV1Z0ezM9KjFQsYj8gKIqQU27srf1FA8/z4SHqXXsQ=;
	b=rphYCJufmG1Jp//ebgGgX3GfV2CVfjlYwDK6ToM7VgsKa4gOdwC3/pbfaj/9cuWff4hLp7
	lmSjIhMZMUAC9j62WT7pAoCPg2z44hwb3JTOlbLGAN6tPlXcH3x28kQyo9AHdUpxN1mkJD
	NbYv8yTM96g4pKUXfj3XJUH7IQdolwA=
Date: Wed, 21 Aug 2024 13:57:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools/bpf: remove unused variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, song@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240820055122.3769-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240820055122.3769-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/19/24 10:51 PM, Zhu Jun wrote:
> The variable is never referenced in the code, just remove them.
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


