Return-Path: <linux-kernel+bounces-184757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A08CAB89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87EEB20910
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE906BFA3;
	Tue, 21 May 2024 10:11:24 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F556B7B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286283; cv=none; b=rJXbbQTHHDCg/6+ziYkoxKSqNBrgndvv82rrfT2VA9jFmt1d3y2AYewCRbfULPJDxFTi62tl0BoepsLQhjLW3dpn4+fwwzaZEtnBcu/HWe0ZRWWSDMjFxqo5MaqclNBvYshnOCUOBfkxySJu/OdpTBDPo75n9Xi8/d5gzm5VCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286283; c=relaxed/simple;
	bh=qW/pTB21gkgRrK+hJF+k9TNP6E/0yI22RXhiZtqv3aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsh4Y8yNeAA2alaA2QUtI1K11eErIC1u+Y24pK7aNrVMnzvA55ZsfNGBVBonTdRA0zNaOsAmFuytN1Jbh/fqUz/BbIMyyD3WQKryzo7oaWbCbE+k8sPH2G7aSIoWBoXZ4JJygqGE+C+VJd8Fch/qfDbflFgH7qfLkLKi4ueunI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354c3b445bbso270295f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286281; x=1716891081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qW/pTB21gkgRrK+hJF+k9TNP6E/0yI22RXhiZtqv3aM=;
        b=Hb+pbIx340FceJs0w01qZ7qYUIbO8fWTqciNZx//3tY9kGs0XjYlRI2CVGivhTp5wY
         NDhwNHr4G+c6BWpHn3E5f/hV3tCgT25oSTJkAzo1z1ZgIG4JsTlpZqAjMh6z8g3gRslB
         sI7vaQa1MlOdQjRr9jQFJKwnhLi1YDrvPh1i4q+guLAuQucyhuOM3i70mbNJbwHGzBS7
         v2HFSRGBXWERVUxCrYL1RV9BtNFn4RNnr7KWvtJAik87pY7NQ7MQ9b2V0LTgxB5bSLdk
         Ajtf/96BnQnPJDkjhCqwJyJmAYjRnwkhoYxJnPFC6ReGkP5tA6hlzWI9SohdGgUhShfh
         uULw==
X-Forwarded-Encrypted: i=1; AJvYcCUj4TLXNLASmIjnAwVYX1Iag4P0sBAYT1KGVb7CQsRLh69OMb4C1SZ13fOPSQYQ72kbrSBlVdGHsuaztcde+6nA4psUwr/VaLMfBQ7k
X-Gm-Message-State: AOJu0YyCJRszrEugMPC1F/KTXAx8RfpnVCsYvENzgixXpIk/Ci7wvGmN
	QUOZhEwCJdpqN0y87k5cQUHGWFh3G7q3oybr4sGMqPKd/+agFMwY
X-Google-Smtp-Source: AGHT+IE3wknQTChsi66LlBnMZL0t4LfufqdO8o1Kvxz+hZ2bhhl3LudndZWEz+t/RK1UoNyFsGGqkg==
X-Received: by 2002:a5d:69c5:0:b0:34d:a29d:a8d5 with SMTP id ffacd0b85a97d-3504a96c0d0mr21877968f8f.4.1716286280394;
        Tue, 21 May 2024 03:11:20 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf20sm31412435f8f.93.2024.05.21.03.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:11:20 -0700 (PDT)
Message-ID: <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
Date: Tue, 21 May 2024 13:11:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> Don't think this matters because cancellation only happens when we
>> teardown the controller anyways...
>>
> I think in case if we reset the nvme controller then we don't teardown
> controller, isn't it? In this case we cancel all pending requests, and
> later restart the controller.

Exactly, nvme_mpath_init_ctrl resets the counter.

