Return-Path: <linux-kernel+bounces-300713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F4995E779
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848C42815B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B64383BF;
	Mon, 26 Aug 2024 03:58:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5697320C;
	Mon, 26 Aug 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724644680; cv=none; b=HAmhJGIwjUy+hkirPqaEbMuCCuBRHLQomvn70MeE+LM1lmlYSdWA3Q1KsIzKdFry204ANNtVKP6281hCHxoFN9edCqtBLCYYqJQm00vgVtECtG8bFLFn4lOyjQPno10kBqjYJgHaydZx3snpoqWhyncezTpkk0N1GSptMkZyx5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724644680; c=relaxed/simple;
	bh=zsSo2stRyFTbAbP1smklFqSp9tifqlGAFlKWoiyHp5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qfSwgNOXb89bqpedcCgRUTP3Q2vhMrdybw6NRnmvFEAv7yYl9zEZ8Dh+T+evTDuVCfvgi2jI4pZ/5HokWIY5N5+kn64luSnpvSIOtI7QPiK/BEALo/1sDECsfXT+WR4YRQzoWVi3N7UerQrOMp/Srnxe+Fr3yz33J3SloReRGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WscKN0my3zhYF4;
	Mon, 26 Aug 2024 11:55:52 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E1B801402E1;
	Mon, 26 Aug 2024 11:57:54 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 11:57:54 +0800
Message-ID: <8d63758f-15cf-8d26-d5cd-74974a2083ea@huawei.com>
Date: Mon, 26 Aug 2024 11:57:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] of/platform: Simplify with scoped for each OF child
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <robh@kernel.org>, <saravanak@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240822073417.3582286-1-ruanjinjie@huawei.com>
 <q6oqvxc4hdmnfcjlrmrbhd4d6cvt3vvi7rxmwslazadrpadlbk@4mdmxsqoijwk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <q6oqvxc4hdmnfcjlrmrbhd4d6cvt3vvi7rxmwslazadrpadlbk@4mdmxsqoijwk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/24 15:56, Krzysztof Kozlowski wrote:
> On Thu, Aug 22, 2024 at 03:34:17PM +0800, Jinjie Ruan wrote:
>> Use scoped for_each_child_of_node_scoped() when iterating over device
>> nodes to make code a bit simpler.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/of/platform.c | 14 ++++----------
> 
> There are like 3 or 4 patches for OF from you. Send them as ONE
> PATCHSET, not one after another.

Thank you very much!

> 
> Best regards,
> Krzysztof
> 

