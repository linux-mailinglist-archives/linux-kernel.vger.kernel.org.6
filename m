Return-Path: <linux-kernel+bounces-386141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACD9B3F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B39A1F22F60
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EC19415D;
	Tue, 29 Oct 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8u6Lis8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E219342B;
	Tue, 29 Oct 2024 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164017; cv=none; b=jzYm0pMg1LFOSmzz4c15xlcyWdbU3F9CLFdd4nU/xRbEmHNzo3kRELqeigTrTlD8xYIeEj6ZR5Vnc4SwxZV2ZO3J9FuRXGVsa1PQa/hNUknxGY9DETNE4caaRNK5vU/QY/TXTvw6LMDqVLc4cA3bPpfeFb8Is40tNoUXvLX4GAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164017; c=relaxed/simple;
	bh=yyGt2lFd7eUrhzUDgQyOyxt36TVANJJ8Zc2Ulyj2GhI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S4to37AQTcTDaTw/I8K7vzCgr2JkyAEnl0cT434hJGZcAG1OlB0b/RtazvdaYhX8SAV9CyyekGPkOppzynQ0gTNlyLpf7bOqpC2R3SkWljp/7nW0EGapn+RgqOmxVpk7N8kl59cFPZz3pBg3/bGw9cwGIVeh/zy2zDpe1baIyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8u6Lis8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62711C4CEC3;
	Tue, 29 Oct 2024 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730164016;
	bh=yyGt2lFd7eUrhzUDgQyOyxt36TVANJJ8Zc2Ulyj2GhI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=C8u6Lis8Hm5wbQ/FId2JzudFCPrxOueupnHOxGnhIj2pOcPy3eGM4nKs1wp6JCQrV
	 3pjxk+I79ZHilqheA5F1n8qwh4NrmvdLOD+coylUMikKgRXUuXBdhiL9UiM8BGhMpV
	 /pmnU1eR7Uhk+8rj/U79lUCjva+K5PIlE0L9anuMtYHfO1lRak1Xleb3e3accSJaF9
	 ajBotaEXZauUUK//UEpA7lSISkLUNFK0im2ZDGg0K6RVFeCEM7IaSc/b0+TOW5cr/+
	 b55I/XlqDMU9qC0e44OCj74VyVHVRo/SAfzLVq2vYiHrDnQH/RBEDuJDOb4TAjThCL
	 hYcU8rMpaAOmA==
Message-ID: <26177c11-43eb-4fb1-8127-857b36113209@kernel.org>
Date: Tue, 29 Oct 2024 09:06:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix typos
To: Andrew Kreimer <algonell@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241027140623.24802-1-algonell@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241027140623.24802-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 22:06, Andrew Kreimer wrote:
> Fix typos: datas -> data.
> 
> Via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

