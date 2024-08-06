Return-Path: <linux-kernel+bounces-275934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79047948C25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938211C214D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62F1BDA94;
	Tue,  6 Aug 2024 09:25:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED31607BD;
	Tue,  6 Aug 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936315; cv=none; b=CZ26iUqAKYIJ+N2D2zWgFNNgLooE5SoUMA4V57R4lGtUlxOTbIDGL2A1PHgYXbW0muTTP1P3G8oSK8uDbQ8FpYmv9cljvWJcxlHQgaRp6G6UlAiefIIroe3PLzY//TFf7szxu8ZqAucK/PAX2rsnJiSIcrJ5HkXdB2eZywxGwg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936315; c=relaxed/simple;
	bh=w0qrlZvlU0q3fDZjWqTxED7lAK3MrOnkizZxKFtqjiw=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=ElVdyZxnSD9VPVFBbtXXF2JmoMCt2sgblX4LYR5Kq/dEMzm5Si/rDAx4cNjVUN0b48akkwd3c42OvT032zGTL3mljdO1RIJxdDd1SdaEnA3bzf/PcTmhmAb1cFub8ZflzquIylDp0GQb8i3F4nWTzXh4+NHqVTWI1PosPDg1cO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WdSXQ3bvxzfZpH;
	Tue,  6 Aug 2024 17:23:18 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
	by mail.maildlp.com (Postfix) with ESMTPS id D4D2C140135;
	Tue,  6 Aug 2024 17:25:11 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 17:25:11 +0800
Message-ID: <9409f3d3-02d1-1e31-a6da-056b44a9523f@huawei.com>
Date: Tue, 6 Aug 2024 17:25:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To: <niklas.neronin@linux.intel.com>
CC: <cve@kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-cve-announce@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tujinjiang@huawei.com>
References: <d5691b1b-c7e6-ddea-bd58-10855fd36d40@huawei.com>
Subject: Re: CVE-2024-42226: usb: xhci: prevent potential failure in
 handle_tx_event() for Transfer events without TRB
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <d5691b1b-c7e6-ddea-bd58-10855fd36d40@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500011.china.huawei.com (7.185.36.84)

Hi, Niklas

The commit 66cb618bf0bb ("usb: xhci: prevent potential failure in 
handle_tx_event() for Transfer events without TRB")
has been assigned with CVE-2024-42226, but the commit has been reverted 
in 6.1.99 and 6.6.39 due to
performance regression. Do you have a plan to address this issue, or if 
this CVE should be rejected?

Thanks!


