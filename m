Return-Path: <linux-kernel+bounces-233321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0191B56B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B596282BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819701C694;
	Fri, 28 Jun 2024 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DQOdodv8"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9C224CC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544976; cv=none; b=DKWobBJK/CZwEmd0xPCn16iLt7XRoJyUICEOvUHb846O5HxhLcRNHnZEPIwkE0hoGI5TIjyYh3/4xdmnwz9Uxgi+y29K4uVs/8C0xBHa10EDOHNJVaTgtFcl35p+ENDlWhDsfKqz+iMIZ19D4aREaejGyMTVxLETLOQqmRe5jXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544976; c=relaxed/simple;
	bh=3DUUtBPRxTtvJOlbJoNG47TbMiWx3qFShWLO8MlOlSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/sSz/KrFdwS17QB7qBtdb8F1n6tcBaa2gizg/pm9s3gx05+yCUoA3pi+P81r5nPgAE1gr45ezDxfXVO2OaK8UbHPO2bZj7f8NMjfl7IIGXsK8vOXHmaulKMComyNZ+avDsjKpnAen3jqGFN0Yr9DzY+sfPpxW43srOjkuu5Puk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DQOdodv8; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719544973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wyVmhtzRgXjKmN/+2ILYIJ53nf9dPoYBTf1xl1b9vM=;
	b=DQOdodv8LJ635EwBC5usDhHWawNtFtwWM175C06AD9nRL1ZRL3yxS0khFiUmtDlhHYAAko
	BdPDEWx0WT3YcGcd4DtJ959lyYC08jz1xvMHRsjiovafy5q7ZUUa/pu3CZ4h0kf5yCwXVa
	Pc9epzyvXGJwJVy+8qu+Y/DnNFFHAOM=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: minchan@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <fa282bea-4639-4d04-9d99-b9e2838a6b7a@linux.dev>
Date: Fri, 28 Jun 2024 11:22:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] zsmalloc: rename class stat mutators
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20240628015154.3230389-1-senozhatsky@chromium.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240628015154.3230389-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/28 09:42, Sergey Senozhatsky wrote:
> A cosmetic change.
> 
> o Rename class_stat_inc() and class_stat_dec() to class_stat_add()
>    and class_stat_sub() correspondingly. inc/dec are usually associated
>    with +1/-1 modifications, while zsmlloc can modify stats by up
>    to ->objs_per_zspage. Use add/sub (follow atomics naming).
> 
> o Rename zs_stat_get() to class_stat_read()
>    get() is usually associated with ref-counting and is paired with put().
>    zs_stat_get() simply reads class stat so rename to reflect it.
>    (This also follows atomics naming).
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Looks good to me.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>


