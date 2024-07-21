Return-Path: <linux-kernel+bounces-258151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4800393846B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11271F214D3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4BF14F9FF;
	Sun, 21 Jul 2024 11:11:17 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395DFEEA9
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721560276; cv=none; b=Z3t4j/eDabc4f7SRP/gG7lhKLRUVMpqSJ9rUr/JIw7KfE+875B6OsxTCpjlGwtiKAdX6tcB5Y6P1h7ZCW3yExrXwhLjNrVoR44wbk2auYYbmnDyI8EhnnsJkeDaly1zY9FE+CH37vef4sEQO54LlTYqODS83eMDRNXPCT09MJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721560276; c=relaxed/simple;
	bh=rxZaF0bpiO8Hzb30ByoID04f8xGZRqtVVxq4mpnXUdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLEM+wkZrKOEoxl/fzP3X6i9WDZ7P7CXXDUfiWWcaG/G21vG7g3c9SKLO5YjMDyAK4dqVM5sBJzRkChNrS2lfwN/r3V6BU3kmb50a6zY1ECNv925EBxz/9L7xKHFTghqy0yY0FL4KrfsXoQIBGW5ox6lDaQiiw6vRmzjoQ0ZX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266ea4e4bdso3574855e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560273; x=1722165073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFbOMQfCROyDm0OZKxMGsU+e4FtaLGih+eCKQ0ekhdI=;
        b=CU5sfIouPvYv3Mnvc6pY037nzBd7X1oNY/5yhe6LT2q9Ruq6+K68UBqwJOYZiCmpJ9
         /JdJX4B5Ack/+AFm+FFDZOkhD+8IIzQRn7o+MMzogRG5YsdpdCqLkuuyW8XkdiMzEpxM
         0zRQ+N//qnQYPCp5MwkOfbQ4zaVE9EkJbzsmvL0LibThcTTchCsPfuExQtIXAqYk+139
         Vwg9dNzZw5p7ZPeOd1dPBMPAT+f7P2ADq6b6/5scaxmXQvMDGGZS1Iuqk9p37pef1P1s
         vUKgqJgBAPAdXXjDehLw19V8MlAfgInW/5z73G2m9jch/GrcILRV/ancV3IG/UHLMlBP
         ZODg==
X-Forwarded-Encrypted: i=1; AJvYcCXr3NY7UUfg6YdpHzp/yrbYKQbp21rV9P1PVGvMJzJttRxwyXe0j+g3OYRtW9mgl7nKS6KgXRUVwYV3xZ5asPbjbfgmS0N5gAn1A4jC
X-Gm-Message-State: AOJu0YzUjyfAuurRPKW3HUhgoCWK4sQC/+TqAYIhyBruRNIV1l49/N5J
	mTSYzr62zUlrl6DOHFgiT5QY9cAVfVVU9Ty8hZdXy5bkoywcCE+H9OPGsA==
X-Google-Smtp-Source: AGHT+IG8QaWT06bMoJ9JYOAlu6LzbUR4LC6+JY3JJJrgdendir6MaVu9kJaphBP/+uH+afvG+uTCqA==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr19813575e9.5.1721560273245;
        Sun, 21 Jul 2024 04:11:13 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d69073d5sm87151215e9.25.2024.07.21.04.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:11:12 -0700 (PDT)
Message-ID: <9f1236a1-530f-4cd1-8574-9e377ae9f85e@grimberg.me>
Date: Sun, 21 Jul 2024 14:11:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Ping Gan <jacky_gam_2001@163.com>
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240719053116.GA21474@lst.de>
 <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 19/07/2024 9:28, Hannes Reinecke wrote:
> On 7/19/24 07:31, Christoph Hellwig wrote:
>> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>> TCP use bounded workqueue to handle IO, but when there is other high
>>> workload on the system(eg: kubernetes), the competition between the
>>> bounded kworker and other workload is very radical. To decrease the
>>> resource race of OS among them, this patchset will enable unbounded
>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>> get some performance improvement. And this patchset bases on previous
>>> discussion from below session.
>>
>> So why aren't we using unbound workqueues by default?  Who makea the
>> policy decision and how does anyone know which one to chose?
>>
> I'd be happy to switch to unbound workqueues per default.
> It actually might be a left over from the various workqueue changes;
> at one point 'unbound' meant that effectively only one CPU was used
> for the workqueue, and you had to remove the 'unbound' parameter to
> have the workqueue run on all CPUs. That has since changed, so I guess
> switching to unbound per default is the better option here.

A guess needs to be based with supporting data if we want to have this 
change.

