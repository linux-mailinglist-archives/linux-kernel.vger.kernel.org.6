Return-Path: <linux-kernel+bounces-184793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824248CAC16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EC51F227C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1877F08;
	Tue, 21 May 2024 10:16:40 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8D97710E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286600; cv=none; b=aP5YrtrVi0uKW4NtP7MjyS2OkkhYxdQmtrsdWyY1o+V+C/vwMy0Ey7+Q1qWirN6aBZBjPTfNoE1jVrMQ92bRgpN7RijhYFfK1vU8xwR8UtGtJeY+5HQ+0stCt3UhxtcdiCvepZQe9+UY89nNwQbAP2FuNgznIEnoBQmt8tltgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286600; c=relaxed/simple;
	bh=MPwGTcO7SdKLGmSlXO+JkZTIVE5nYQNq+c4qRkuXs+k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ag5guCxHAYsHrYEfEmS2v2Ggsznp06dTlsspeav2n0eCosCQo5iSDDAPitlv8hHuLg0xH12RuaZuu26kg4KYpia6ibBJ3J4oXewoOm/AeFdMgRlI5pFWkX39L2dO7jOIIr1C9vwMpqcdFSoasZvj1CYkjMPjgGpZAAC7cb6frTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354c84d4604so491008f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286597; x=1716891397;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaiAWU3NXtCfmiYvgYy3wEGjD3mnbg8XC2Sk28TmeCE=;
        b=WZGyxuJsXhhhCmuu63iWA7xpa3DI6eqWvIdRJGfsG2cfLFsxH68IAwJfXXNTk+f0f+
         I3ZWA7YVEBpcVKY8JSDuA0DDXG1JF8XXUaFvLKekVHDs6Y4/A9IC4NGzqj1LccIVrFY7
         Xlve4a6GdgLmtelMM6RScTYDE/C28bvq/Ml/gQN/spgJ+v5Z1KeWzP5SC2RiMECgxIV7
         KKaR4LYuirVU1KO/SiWTAq+7eTxWEnHEvIrs1ws239IFvPvkLAZ0fO0FEy6stW9cQiS8
         TwGdmtVvYhMZRK29BBD8NsfxwNtQ2ibOhbWoErHUre7hk+Pq+fSimzb+I9Bevcgug4Hs
         ooBA==
X-Forwarded-Encrypted: i=1; AJvYcCUv5RgphO3HnIjcTCv8YyLM0W33e7fmhM2QO3Ak5hqPDvpmKNo+wVpKlVpMNPcAymMh1J3RZ165rz6YBpYj6rPfWR8RO3YJFAuG7avj
X-Gm-Message-State: AOJu0YzFOqn3DhV2juIyuXTpY9RpRDPz1fQYbE06+ZO5FwLzC0ieKjyF
	rudqio2n512Shm95IIhQuB3j5W3U47GZuRXXoXOohq+46QW3LRwW
X-Google-Smtp-Source: AGHT+IHzm5XmKjKZ6tsHMVzBPcQUMKdYpRr8I/AR7wUCjqE+6Br3cDXCQYKdwXv8uiY0N0OcPJJHrg==
X-Received: by 2002:a05:6000:227:b0:34b:5cef:4af3 with SMTP id ffacd0b85a97d-3504aa689d9mr22396035f8f.6.1716286597126;
        Tue, 21 May 2024 03:16:37 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d2df8449sm15112285f8f.12.2024.05.21.03.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:16:36 -0700 (PDT)
Message-ID: <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
Date: Tue, 21 May 2024 13:16:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
From: Sagi Grimberg <sagi@grimberg.me>
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
 <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
Content-Language: he-IL, en-US
In-Reply-To: <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2024 13:15, Sagi Grimberg wrote:
>
>
> On 21/05/2024 13:11, Sagi Grimberg wrote:
>>
>>>> Don't think this matters because cancellation only happens when we
>>>> teardown the controller anyways...
>>>>
>>> I think in case if we reset the nvme controller then we don't teardown
>>> controller, isn't it? In this case we cancel all pending requests, and
>>> later restart the controller.
>>
>> Exactly, nvme_mpath_init_ctrl resets the counter.
>
> Except you're right, the counter reset needs to move to 
> nvme_mpath_init_identify()
> or some place that is called on every controller reset.

This however raises the question of how much failover/reset tests this 
patch has seen...

