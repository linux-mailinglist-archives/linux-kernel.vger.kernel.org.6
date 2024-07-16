Return-Path: <linux-kernel+bounces-254501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CCC9333E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C171C22CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366661428E4;
	Tue, 16 Jul 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="YkacCOVL"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55F13CFBC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166843; cv=none; b=Hc2VJgeZhxBUy6QCK7bBQrAatZaJXhVSlBhdOHZwJ/7pFXqcTmgucJHXIymYMTe8cUwUMx5WgyNPPlzxvsZZIsxnz48+7wRhLusV17KNn6NgBafBIPYz2shkgXEMkwaTMGZLhI6R+XesByTDDCcH5hjtp6G4eULhaOc+RNLFMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166843; c=relaxed/simple;
	bh=/v7SBEYyAFXSZP6HH1/ng/YIKTlSO2bhoybTNyrPRNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgAhNhnBVrDPyWLrKjklMQG0M2jZFYp+ho0uClkbcIP9RMez73wrFyX2Sh0lJyrvrzHNMvSu+HHA4xCz13QOr00GT4jKQ7M3Mvf5InJdXlLqJw6N/DpfWRhrExUC2zY3L6FZZarPsEwuZCfabPatRVWFlgwX9LB4kuPyF2/a9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=YkacCOVL; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id TYKQsUyldVpzpTq7VsKPxn; Tue, 16 Jul 2024 21:54:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Tq7UsgaOBO7CrTq7UsllKH; Tue, 16 Jul 2024 21:54:01 +0000
X-Authority-Analysis: v=2.4 cv=Pco0hThd c=1 sm=1 tr=0 ts=6696ebf9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=9IUVmF_uN4HtD0BfTqgA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dV9YVxJPuIXVAPNCLnlMOQMoWavIDcj3/ND7BIJk3U8=; b=YkacCOVLokc2loc0vcE9mWz2fS
	R10osTZ0lvAJ4JU1of2wxfUzPI6AtXeZ0jAfZUYuM2d5b+uEtATlycuw96fwqsiYANg4xuSQDRwnu
	HrxrksHBQiVT0BnlP5nblFnRflb0IV/BXL1WxqpzFyUsABVC+p9ccteaszzezYZW4KgatllVVfwiJ
	R7QkqZE325glyIADCvkLhnNliEitk5Q2/U9DNrRTEYnAPVOJfsoch5c62+1yxiMVZwEl2nqpFtQmQ
	ZDTikQ2zVfuiN7dWXs8UP3r8cXpPYBQOAq367QTdXN/EZS7bRGFXVtD4T0QL/2McoRHTTNl1/87FJ
	2bsYzLTQ==;
Received: from [201.172.173.139] (port=33646 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sTq7T-000Vx6-2X;
	Tue, 16 Jul 2024 16:53:59 -0500
Message-ID: <de26df66-67e8-4b88-b337-a50311bf2ea2@embeddedor.com>
Date: Tue, 16 Jul 2024 15:53:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: icc-clk: Add missed num_nodes
 initialization
To: Kees Cook <kees@kernel.org>, Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240716214819.work.328-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240716214819.work.328-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sTq7T-000Vx6-2X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:33646
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEdKM8b38pi6wqbeW7TzZq8jL4FtQ5i+OSBJv0XxUCQT4nQn1G5IsJ8KaNFK3UuGSB25/nQyHFGBTCDhQup147tybWjyGZU+aCMx5yy27rSoxnkYh32i
 KIs7msxMtpv32Xase65Q/Fd6wMXqHAbGHcMIJAolv462vUpAliQ1AiDHpeV45IiUH6tMav2l08DEPqvhlwmh9JQxq4IhJaeLJ2rvefKeIGxSmCoH0BOxBNxY



On 16/07/24 15:48, Kees Cook wrote:
> With the new __counted_by annotation, the "num_nodes" struct member must
> be set before accessing the "nodes" array. This initialization was done
> in other places where a new struct icc_onecell_data is allocated, but this
> case in icc_clk_register() was missed. Set "num_nodes" after allocation.
> 
> Fixes: dd4904f3b924 ("interconnect: qcom: Annotate struct icc_onecell_data with __counted_by")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: Georgi Djakov <djakov@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---
>   drivers/interconnect/icc-clk.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> index f788db15cd76..b956e4050f38 100644
> --- a/drivers/interconnect/icc-clk.c
> +++ b/drivers/interconnect/icc-clk.c
> @@ -87,6 +87,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
>   	onecell = devm_kzalloc(dev, struct_size(onecell, nodes, 2 * num_clocks), GFP_KERNEL);
>   	if (!onecell)
>   		return ERR_PTR(-ENOMEM);
> +	onecell->num_nodes = 2 * num_clocks;
>   
>   	qp = devm_kzalloc(dev, struct_size(qp, clocks, num_clocks), GFP_KERNEL);
>   	if (!qp)
> @@ -133,8 +134,6 @@ struct icc_provider *icc_clk_register(struct device *dev,
>   		onecell->nodes[j++] = node;
>   	}
>   
> -	onecell->num_nodes = j;
> -
>   	ret = icc_provider_register(provider);
>   	if (ret)
>   		goto err;

