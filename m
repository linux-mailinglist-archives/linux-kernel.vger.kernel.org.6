Return-Path: <linux-kernel+bounces-196486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 672908D5CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F291C2471B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A71514F3;
	Fri, 31 May 2024 08:37:22 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583914F9EF;
	Fri, 31 May 2024 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144641; cv=none; b=Y+d5EtOpsV3ktOEjv70xFtWPBoQUEOWxuMuQDOsP0jHAk6BU/DuzLDSrNr6m4YneG60mYAn4nAK0kj5T6NGK9OLlB14wniSHKi0TnFJ2r8Vav2fa7tP8sWRHjkR2tXs0OEsgJnHRWfdXt7Pswb5p/6utGvujbeqMDCS8zPjINf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144641; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abdXR1P+ihPugg7FwvrYHuK469K9f89dnUt8XlAGc1ISZ70sCesgDBugrgU3/dvm7xSanWc4PeYv3CUig1Eq/+aCsfKn3tnJU3gJDpAa3GRjxyozQ9Rx+zIzbim8wco/DOyLYYvM+l7qIuHWTHBoRFBe+N65iztKubBYZZOPuZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4212b102935so678245e9.2;
        Fri, 31 May 2024 01:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144638; x=1717749438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ucvxFaOwB62sqDtaCYcaortqOjRDVBbeNJ/pe7ggSP9i600lPZ6wBID3w9C2eZ4OrJ
         BXhVzCNHIJoWfG2cD+uEAJqNXjj3LKl7m9hiXeFNsUa1ejDlKbhpV6g+tld4ozbBOhGu
         wpnA4t1GEyWfmNDhTN5bNtFqNDMkFlYhlnZBmozY6yZvADdfGriDb1Uivp2iOy6hQfwU
         0uS7ZHJl9z7BdkIUFlYRil/ArmHGarsVjyNZhSg87puny0nZxtPyzCv4j8oYB7AoiaVK
         C0WjqI6r1Jv2RgP9gBsSfU1pq/9X2Ybhtt9x6vnG5LqQjmfSPifRg+S/SbZk9F6UVrHc
         HHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7I9TJJ42OuLZqnltYWfn+3mlvoxg3+tWZgSRcedFNF5yMJZisA8WLq1j/8TErbzCD14QoRYR6bgz8C9kVLljs3MgAum6rZfyhfogmGwcEo45xgUnEEZhzAB9FMbbwJiiNe9xzZk/ITwS6DZOT
X-Gm-Message-State: AOJu0YzpiXLXAVf/gGocze2uI6X917jxNhpa3LlmjUlh4BdM1RATxRXq
	2Pdz2tGCb9GMnC1Ij7x7oqxE25ttqL7Q3Id9FxgzgUeNlA7ZI+vX
X-Google-Smtp-Source: AGHT+IEcMZB90PK3n/9rMQxD7m9IN3Nt4bzySZUbYfywqxlzdNOgXH/47NR1pw7f8r7XCWcMKZ23iw==
X-Received: by 2002:a05:600c:3b0c:b0:421:2918:3d9a with SMTP id 5b1f17b1804b1-4212e006132mr9155745e9.0.1717144638185;
        Fri, 31 May 2024 01:37:18 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8afe40sm17955285e9.40.2024.05.31.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 01:37:17 -0700 (PDT)
Message-ID: <746bdba5-8826-4069-8f3b-08891d78321d@grimberg.me>
Date: Fri, 31 May 2024 11:37:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-apple: add missing MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Hector Martin
 <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

