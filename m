Return-Path: <linux-kernel+bounces-390606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B59B7C26
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA67B1F22045
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C0719F111;
	Thu, 31 Oct 2024 13:50:42 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F118858A;
	Thu, 31 Oct 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382641; cv=none; b=eYRp3yNNrgfCQvZwRPtQC32YIgZOrKzqPlCmu7FXja8KPRllbR8gw4DiJSr811s1e1npS+7GX7DA32WDqnL2oKW7S2rRbQe3UQJ6jusYvM6SHlLPioR4F1hfIFkkKOnKwn5y0gpujQBvb4uX1ztztntl7vQpI3+mfS3Tu1gWShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382641; c=relaxed/simple;
	bh=hJhqOrb9icJdn9+eoAEG23GR1NmmQfebcODBfmoq4AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=md6EUXqriE+7lB5BmkE0jHgUxCnCjQf9zPjyN9jHtGrE2PjLc9wOyVF4yrlrzJu7K5i+lcAOVYgZ3mdyuCSLod3qP8vEHWp6VlZxHygJQnZxYGzO4czROmvNiZoahyL+9/yvCPitf6lOf2v2V9rOvHfDt+DXfc3dw4GIAl+mOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XfQMt0zcPz20qwQ;
	Thu, 31 Oct 2024 21:49:30 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 981581A016C;
	Thu, 31 Oct 2024 21:50:30 +0800 (CST)
Received: from [10.67.109.114] (10.67.109.114) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 31 Oct 2024 21:50:29 +0800
Message-ID: <d38c2b1a-3527-421b-a122-fcec0e48b4c4@huawei.com>
Date: Thu, 31 Oct 2024 21:50:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: clk-axi-clkgen: fix division by zero in
 axi_clkgen_calc_params()
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <lars@metafoo.de>,
	<mturquette@linaro.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>
References: <20241026072344.976154-1-quzicheng@huawei.com>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <20241026072344.976154-1-quzicheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500009.china.huawei.com (7.185.36.209) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Gentle ping.


