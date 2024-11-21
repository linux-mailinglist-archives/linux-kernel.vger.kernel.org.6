Return-Path: <linux-kernel+bounces-417006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7989D4D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C5E1F215EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF71D6DB3;
	Thu, 21 Nov 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJXK6kXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD21B0F0C;
	Thu, 21 Nov 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194805; cv=none; b=rZiln9v4z7hyZXJxKVYSHtcymRNNj2RYsCcaxKVtkYECO/birhR21ZbGLJhjNagPBct1m07hVlAUTUaY8aNBYKgsHhrZhr2lVhHbX2EuWanDAnnMISBdKhsmr1ZN0aOB2HCaK6pChq3tyM7RPE0gzllQMCy2nksq2xYHNFJVDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194805; c=relaxed/simple;
	bh=T56RJic84mjGseWEFMdODkz00/doKV0DVthpc7FjRn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzZ71saMpIFw2jWpLCYUBLrrgUPWRp8V09p0bXomGzGyLwiPxwQP1LxqpgOKRekOWugsTzVr1eWuwVPG91dEEgnAnGaneOnwsh2amQFImL5X1U2Vq44LgUA5SICcfjjVkBhrR+ox/ldNUh5NBLL1BPlOh/Q4fGmKld+7ZNM3AB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJXK6kXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89504C4CECC;
	Thu, 21 Nov 2024 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732194804;
	bh=T56RJic84mjGseWEFMdODkz00/doKV0DVthpc7FjRn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jJXK6kXNcg159HH1WH4Z/Rg49Y2MZqn8Nx4Mg2sV5thGdG9p/CwU8w0/2Ae8JyXOK
	 xniA215zDKMjjOUg608GCGxCc7C1sYRIoefHh9bxw+azkQgnNy9+rUWRTZzMsyosIe
	 4ElAcq/W+aYdJZUuRq2nwlWKMn+fAk/nD5thp44MmdrB85BVMKP41PsJ3etpBTbJiv
	 XINFkfblHwx+akqNRduAN+S7PODfE72wlzZkOC8gdKschzKMNimICR5xXe212hcdPj
	 UhyuWqBmMSS1kR9DsiXsvVQouv/Vy2ZW9O0uA47rr5pdi+22Y8cbgofmfqC5gxs7S7
	 YyXrNN4iT1Syw==
Message-ID: <97fbcaf0-ccd5-44d8-8600-f0e0c5c36d41@kernel.org>
Date: Thu, 21 Nov 2024 15:13:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-am64-main: Switch ICSSG clock
 to core clock
To: MD Danish Anwar <danishanwar@ti.com>, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, ssantosh@kernel.org, nm@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s-anna@ti.com, kristo@kernel.org, srk@ti.com
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-3-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241113110955.3876045-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/11/2024 13:09, MD Danish Anwar wrote:
> ICSSG has 7 available clocks per instance. Add all the cloks to ICSSG
> nodes. ICSSG currently uses ICSSG_ICLK (clk id 20) which operates at
> 250MHz. Switch ICSSG clock to ICSSG_CORE clock (clk id 0) which operates at
> 333MHz.
> 
> ICSSG_CORE clock will help get the most out of ICSSG as more cycles are
> needed to fully support all ICSSG features.
> 
> This commit also changes assigned-clock-parents of coreclk-mux to
> ICSSG_CORE clock from ICSSG_ICLK.
> 
> Performance update in dual mac mode
>   With ICSSG_CORE Clk @ 333MHz
>     Tx throughput - 934 Mbps
>     Rx throughput - 914 Mbps,
> 
>   With ICSSG_ICLK clk @ 250MHz,
>     Tx throughput - 920 Mbps
>     Rx throughput - 706 Mbps
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

It would be nice if you could send patches to update
corresponding nodes in am65 and j721e platforms as well
else we will start getting dtbs_check errors.

Reviewed-by: Roger Quadros <rogerq@kernel.org>


