Return-Path: <linux-kernel+bounces-321314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA11F97189F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3711C22550
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEDD1B6548;
	Mon,  9 Sep 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AkeXvqep";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gzpwkHDS"
Received: from a7-30.smtp-out.eu-west-1.amazonses.com (a7-30.smtp-out.eu-west-1.amazonses.com [54.240.7.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EC14A09E;
	Mon,  9 Sep 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882602; cv=none; b=nxCKWVu0B5VNwTsBdEruk99xgz5q9OdCDQ6TRGpS+eoUEksdww/MjtzRBMvfyySX4w3d43GVAofa+ZVTQeR76Gkv4WBVefzb/c/UAq8PTReH50iPKfzKAk9BWU3p6dt7i1FmV9okYkrWr0NWe9Z3oKcOc6QwwesQNFdagqOKZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882602; c=relaxed/simple;
	bh=r9QUF7QVMFgab3Q833wJ2VFjeAU7H8m4qLqgty3INyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+ZMlg83oQtUUdLqPIt+IklFUj+IxQWf0YqpambnQYzzsomHDKq3NAT0lmYK3e6PGBV+qWaLFRHrp1IDCY59Ls8+PyX/rC3GcbzJd30XMe3jPq+Rtu32GCBatcjAMCrXKhfY6batxV0bQd+5sb70+EbEFuOpkmJ3naA0BDw5esk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AkeXvqep; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=gzpwkHDS; arc=none smtp.client-ip=54.240.7.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882599;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=r9QUF7QVMFgab3Q833wJ2VFjeAU7H8m4qLqgty3INyQ=;
	b=AkeXvqepN74am8AJZosrAgPH+V8h4jex9dhY7iO3eM2lNEuG5dQnS9C8t++0Y1TY
	hLYaHK+jn+uRiE/ncAZC2Gv+7dEsIItjYvMDqk2C06RA/vskTqXp43Xx3pOb6s6fT59
	XCVXn4vmEkajzsxVfcJr7GtYnV8wAJzTvjR6NXKC/oRehF1hTO1/TIBG4I4OuRGVmRH
	NLXHq4v/T3QbBs7jP2D7g/CIIpF8SsqH9S0Y8jxhPUfpWP5M8DjfvN3TAtPW62hT6jh
	j5FcWX+Xct/p0VzlnYy1FzjtPpJ1dSO2QAMiDthGoz7dFQ1SjaF9NmmvCpGMXQFjd+A
	6PnS6ieYmg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882599;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=r9QUF7QVMFgab3Q833wJ2VFjeAU7H8m4qLqgty3INyQ=;
	b=gzpwkHDSf7Plm/VuBK/eCISzJ3ZbtBm0zawPlojZsaj8InPhJQhGLVYvmYijn2DF
	Drfw2t0+MPIy6eDP9V8ShUclDRBKyemQ8+c6RBxDD2FEocmfkST0Eeur7ZIlxJcy9Cn
	Vma6ZUKDWJsaCBiA27aSE5ZWpnoqqsEwDKus3IeA=
Message-ID: <01020191d69e8733-e5caff8d-c8ad-4cda-b8bb-ae7368a8dd9a-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:49:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ASoC: mt8365: Allow build coverage
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-7-7ad0bac20161@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-7-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.30

Il 07/09/24 02:53, Mark Brown ha scritto:
> There is no build time dependency on anything specific to ARCH_MEDIATEK so
> enable COMPILE_TEST builds.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


