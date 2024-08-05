Return-Path: <linux-kernel+bounces-274249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A799475A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F052281269
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F712143C6C;
	Mon,  5 Aug 2024 07:01:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3301109;
	Mon,  5 Aug 2024 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841281; cv=none; b=KBez5ehVOQxq0HVbPZ7hUdvAzR5xE9OBInX03Rr7G/RfobHMpXz7GGT0mVNFDAzBI5hHprjWpjBM/Ii0Qj783CjdCxek+pYEQgqOMlJk+Pzq+pkg5fwjpVoN5rwIwfOeLAMxXR3ekw3IICLDsoZ1L8YNNOeT7zh0i4YHMl+NRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841281; c=relaxed/simple;
	bh=lLpNY2gvKncPHrzY9sUabSQ0nRzvIjqpZU+/Z1TWLL8=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=vA9R5XLwTm/iGwHtdVTl3XPS3ArXn9qmUihW9wyWxP968Y9NQviSf7UNFFJQLYs4OBFyJ39J6wUDVAC7dtpmmaxQpickp5/FuUTKCIHs744MoEHQzn11IxaRt84Ntfs8jvLqi3z2cMeN2NlrBC26RJmjKlcPiG1rUUdQz55Cm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WcnPh1dVYznVZy;
	Mon,  5 Aug 2024 15:00:08 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
	by mail.maildlp.com (Postfix) with ESMTPS id 0862C180100;
	Mon,  5 Aug 2024 15:01:15 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 15:01:14 +0800
Message-ID: <d5691b1b-c7e6-ddea-bd58-10855fd36d40@huawei.com>
Date: Mon, 5 Aug 2024 15:01:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <2024073038-CVE-2024-42226-fa39@gregkh>
Subject: Re: CVE-2024-42226: usb: xhci: prevent potential failure in
 handle_tx_event() for Transfer events without TRB
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <2024073038-CVE-2024-42226-fa39@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500011.china.huawei.com (7.185.36.84)

Hi，

I noticed the fix commit is reverted in 6.1.99 and 6.6.39 due to 
performance regression. Does it
means this CVE should be rejected？

Thanks！

