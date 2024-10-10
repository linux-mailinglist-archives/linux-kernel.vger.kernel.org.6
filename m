Return-Path: <linux-kernel+bounces-359581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B6998D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E462B1C22FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07A2195980;
	Thu, 10 Oct 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cFQcmmXI"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2336192B9E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578150; cv=none; b=tD+YxoUnfhi+dgDr8lTxwN2cU1+J/a3ZaR3HO91NQCaJiIDqRCIc/RUn/xNyoWd9wToYExROvV0y/ewemZ6oL5q/dR3jcW9Zg3zI8uy4DyqqV4bWVJfcfSrsVCP/V4qO9J5spPPLhkSwaquXcHgnddJTFPPtgWqnOKv6KJYFxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578150; c=relaxed/simple;
	bh=K/rrtjjNtaOqa0vDLGxMlVQQYiQd64BJVvfcAydB9/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3vlEKOGQbfQF6AShiCnfy8+5mbUhrQNAUx+Kym32cFH//zegzSCkOt4SvWrss4V1JMqAoflSpk8QbFJT+v5I9eohpbPtmcHQpEGLI+WQXisY8YRlUAbZilB/VrwWq+RWKYTBjoWix4SfkP1bBbqlpyerJsY34rGejcjUfWzOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cFQcmmXI; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72fc3cca-9d31-4733-a683-62b332a296bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728578146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIkjqZKN61dewomW51a/Tay4bybD57pDagj6pATYUGA=;
	b=cFQcmmXIAVlZ8b+J49e2VIi9ct/nVJ9POlqSw4Z3i7bDKnakdTUmR8MqTAgn2Ll4RzvmSg
	JCQ7Vq/DlSTYEFlgTNQpOLwmF1iK+VW97Z47qEoHf1E3v695BdjMKOyaPWXINI/wCz+Qz5
	152lOkkxg76UpwGSwlmjcJN/53b/Mms=
Date: Fri, 11 Oct 2024 00:35:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] Docs/mm: Fix a mistake for pfn in page_tables.rst
To: Pengyu Zhang <zpenya1314@gmail.com>
Cc: corbet@lwn.net, rppt@kernel.org, linus.walleij@linaro.org,
 fmdefrancesco@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaxin_wang_uestc@163.com
References: <20241009144135.12453-1-zpenya1314@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20241009144135.12453-1-zpenya1314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/10/9 22:41, Pengyu Zhang wrote:
> The documentation incorrectly calculate the pfn value as 0x3fffff,
> which should be 0x3ffff instead. It is obtained by right-shifting
> 0xffffc000 by 14 bits.
> 
> This patch corrects the value to prevent any potential confusion
> for developers referencing this document.
> 
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>

Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>

