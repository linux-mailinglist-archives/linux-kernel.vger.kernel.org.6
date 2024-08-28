Return-Path: <linux-kernel+bounces-305064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69F09628D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B6B239EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BDD187FE5;
	Wed, 28 Aug 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RS40OcAf"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2617839E;
	Wed, 28 Aug 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852281; cv=none; b=plk4c2rw1CdqZg+3kUTLsZTy0xnjrA758verYgEP4mi4JLXcLtqLEyMAhEYaPbKbnLz7TLswMZGNsGJZAzOB7rnpyi/nbHx6W747fTg5F0HFd5uvWPVgAbcBI3ETAHqE1ejdWG1/xjhq8Ps9+04AnB02x7qyxEuVWx5UMFsU9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852281; c=relaxed/simple;
	bh=2NTH+PcNYqTCW8E4NFaKCpPvnrGFF2ZwzQVr+NzLD6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzuiCF1QSJuBp6CHqOFtkOnQGP9cOls5b7PTB1BA5TSNWjl0+N2Y+nPQ3DI25EnNn1G6zIYOTJlVk8Jfg0L5o79eRJIp0OSuGec/z+CdVxGyiLn68UmdO5czuBKgVT+nGqVfIyGr2MEve7LXKXAxKngGlLT6usoZwpdKoTQg0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RS40OcAf; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724852185; x=1725456985; i=markus.elfring@web.de;
	bh=2NTH+PcNYqTCW8E4NFaKCpPvnrGFF2ZwzQVr+NzLD6k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RS40OcAfSS++bbn5S2DyYxUzHLbBwts5htcTdaW58W0W+IbIbr1OLrc6pW26YmzC
	 Qmh6DaR1Fp8HLzQ+/du/wq+OGStTSWgBiQ9aJY3vQ8ZbPSkkYzrE4f4tgZw7qdAld
	 pcvu6LPhlRB5KwHWZmNfWx4WVyC91fCK9CQFNmvyDvgrf646yl8pWdKEoYcv7BzWx
	 ++qELW3f1D5N2UzV8hhk3RrrP6hCFJpNR/dPY8yJ0cL+scfjV5DxDqWjnKES/Cl3e
	 exolQMx8WTjJA52gU+7Azm9iFzeHFffZfiVBeXcULTEfxeGlqtKYHBr+6Yi/iEuvj
	 5vUSa8KY4LRt88XzoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmho4-1sHLpP3VDS-00gKUA; Wed, 28
 Aug 2024 15:36:25 +0200
Message-ID: <7c91459e-5f65-4dac-9c96-26da88ffec4a@web.de>
Date: Wed, 28 Aug 2024 15:36:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Simplify sched_set_rq_online()
To: Yang Yingliang <yangyingliang@huawei.com>, kernel-janitors@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huaweicloud.com>,
 LKML <linux-kernel@vger.kernel.org>, Ben Segall <bsegall@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Wei Li <liwei391@huawei.com>
References: <20240828090336.905676-1-yangyingliang@huaweicloud.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240828090336.905676-1-yangyingliang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JqQJums5aOG8GgmNo2TpJ5F3kMTaI4qFL+LiI7IEt0Vq7Kexs0U
 6CxJ3LieS1+iZy6u8GvtLg9h/LumhYXG6/9bwDYzeis8GscRYNXrngK0Rr2oj8UBdb7V2Sj
 65e765IV47C+Xz4T8TcoYcKEauuAtPxDjufRGbCLs+zsne7ayaid/8p6Ly1RT5/WFo7Hf5t
 fvmGPgsJGLZJVurhACnvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oOOF6oacCXo=;p8cFoIz5uLf0KKGyXRMpPfWDNTR
 e0vumHOBuBKTcsew7GHLZ0aOIOK9DGEpiuIqcvBOG0SmhhFguqiCPUHY8dH4RQd362rtNxs5Z
 dbRuJ+u8as62cLGBCKhvgE6pXm/+MMkWJECBVmz/cwpORmxd+OrqGwUglAvWGP2RClS+zOm61
 /m+XHdzv4YqWgoDdi2elsSbxctNgk3cRAgPKdQJ6KkdZroSWRIllwWOj1GFqfWXUHyco1vs0T
 YIzOQk3qHfhxP9GqPe5Sm+HY47d4Bgn3mxsjOcJvenPViBjGdSbn5sJs7pBEv0HPFGh1dcdHV
 ZT5jAH/ewQUy2HYyfE9lxC63FMUErbau45skgKU3+2AvTR75+5hJ5oBPjU9zS3u5nWuVgLzzf
 lm4Tk+J9+g0BXI4Bmp+BuJIddxg6LNe8N34eYUvGzHZQcXUI1c0jC7JmuUuM5AFJiwGLmJf8k
 mpTR/X91wGeJwt+QEMQoLZRghg4jAHPEYKb7gr5kuRE9jjxXXiyD5ccmjQI3mxyyKIDyU2ybs
 2yAFWimyAqk2EAXFWuJfoaQ3i11a2e5AljnsQmPLUOtFoJq3ADi4RHnEmwjmaWc4hn833CbUt
 fqcyi12PBYEZRpQLpjKqsqXxAOOHTGLpiKthaxj+oZX+2crs7w1wr92wtL7IJROj2NmG0wesA
 CLpnEw7v1jq08oFrGNMlRNWuA4NUlHBn8V9OFa6dy4k22LnOo73RHVcwsnVTyK1Wt/Ru5/YFJ
 rJre3uBvlnvVNnosXCT2wISpz0acozDcdwOrVRxhsPNDvvU/hAEBssuOjQhPql4VIN2f1Yf4h
 PJ7FNiB6MDm91ZNhLTBzKnJQ==

> Use guards to simplify sched_set_rq_online()

Wording suggestion:
Replace lock function calls by guard definitions so that two function implementations
can benefit more from applications of scope-based resource management.


Were further update candidates left over according to this programming interface?

Regards,
Markus

