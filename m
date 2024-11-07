Return-Path: <linux-kernel+bounces-399168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD779BFBC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBDF1C2192F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0B17BD6;
	Thu,  7 Nov 2024 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K9C7ho5a"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EFD1854;
	Thu,  7 Nov 2024 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943582; cv=none; b=ShCfsHQsOW9Bs+vD9F2ip1CQmAQeflYlyBZu6hd5VyJiKjSFKX62RyVLe/lg38/TbPdic7FdTG/ae/0extDIfOJ5PVC3WT2JoQ3HkrmKFSxoRg9ASBX5rWp1Kf4qzj1KNg/8DToIivak0yevP92lwC/BDKH5NAPFeBvjG67kZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943582; c=relaxed/simple;
	bh=v+wSnkxB7K8ZEE4ZN48hk/OOcNbesDZwgQE7ZDFhLoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuVrFhRA24zf7XSSV0/kPZ9itRQnym4nduhq1C79RvrylLIt8rl0eNZOkDprTl92Ky0H5xY8W4Ggu7VmBF+cjR6VZxbeKKZtItxP1CVEccuViJRMqx8M2oUdqb98LQKubrSMnr5FDf9PIprigGtMTsSV0Dzke1mAxebVce//rPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K9C7ho5a; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730943576; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H7nMDuaCmHzuDu+vzqYAf2Ao4YDpMJQ1LC3DQ9Aqn/w=;
	b=K9C7ho5ay4idmQnra9UP+1CAbHC4BZhFkImts3t/RQ3AfCwKstTgzy55/fByz334PotzNPUUzrEYi46U0w3WjIP3GPzkBZ6V8zsPgKOdzU1P0BeXCqKR2SF1X6n7e4o+J8x4zcUXERiuNnO3ezG7Yxf8ogogggYyc2+++pKCKd4=
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIthrqX_1730943574 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 09:39:36 +0800
Message-ID: <ef09f0d0-c8c1-408f-85d9-31fa8de13a92@linux.alibaba.com>
Date: Thu, 7 Nov 2024 09:39:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: sprd: sc9863a: fix in-ports property
To: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1730918663.git.stano.jakubek@gmail.com>
 <5318a47282b8c15a3135fd12dacedb8aa70592e2.1730918663.git.stano.jakubek@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5318a47282b8c15a3135fd12dacedb8aa70592e2.1730918663.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/7 03:05, Stanislav Jakubek wrote:
> This property is called "in-ports", not "in-port", fix it.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Changes in V2:
> - new patch
> 
>   arch/arm64/boot/dts/sprd/sc9863a.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> index e5a2857721e2..31172ac44adc 100644
> --- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> @@ -288,7 +288,7 @@ etf_little_out: endpoint {
>   				};
>   			};
>   
> -			in-port {
> +			in-ports {
>   				port {
>   					etf_little_in: endpoint {
>   						remote-endpoint =

