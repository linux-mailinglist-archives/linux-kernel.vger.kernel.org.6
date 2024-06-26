Return-Path: <linux-kernel+bounces-230288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097F917ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2331B1C23D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BA616A925;
	Wed, 26 Jun 2024 08:24:15 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9B1684BE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390255; cv=none; b=hkOV7vgl8MdQHK3IIy+ySK+EtXk9rtXxSG8DkUsFQgzyXfPtVQQH4Z5hoFD+i/IM3RR676KOQSxhCpYwOU18pPWtqzUAVXmPOY+QN9LKekWAshM4Je0/8/dKZckjNTNKRejk8AC6pwg1Vk1NgmDoV46zbiF1Oxp250IB4f7Ij8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390255; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQEsHFabbPvQHu95Uc1dVGsR0PhoBw8PltLi1QX8fesoN7JOZU/EmKA85K7DLRByASsY9o49Edf5hRN4YYV0Vd8c3UsS/E/JsKubAJdMjoQaDwqZtJQInEcWVaJQ9kcuKSn0SfVN3+ItsEAOpjD8dHMqkmlVX5JqmK9x1bF7CjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424aa34bf44so1008575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390252; x=1719995052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=uWtjHcRCCTDL3OxGslvAlI4X0aMij0S0fjiLPH10OyUgjAJLpam+i43ArvqSNSCEvF
         CK+VUJUjuqrXIw9Lv5S6gr5aNcm+fwqT5hqNYb6eyPgJ84nHmxS97z5JoQA2n0hsLEla
         jOiGKiuP6jmMLnE0U6sz87SxwYvylBIYIfZLNLvoWaXOs2ka7qNn86lJIyTYuU5FUZ2c
         6XJpknQ8G8HLMz+Ys7qYq/rMhJ/C/K15mAgvDiN5SCk1Ax4Zz2k0BCV4eehnNrMk31Ch
         jYrOpSLYj+4btdvjaJygRIhvBv+/y+zLYAqyQKqfEBn2LU+zjt7RcLypdEKj2ZW2AN1h
         vEXg==
X-Forwarded-Encrypted: i=1; AJvYcCW3h/S4S7joA19fWcK2aHFEjJq5XOctYiwLwGiT9zpyK/KZDwCRleKFGgxa0FTPoxD7VVsmvxh2OH6rjZLC8mihofSWOcgH9RiZXJD4
X-Gm-Message-State: AOJu0Yy7R3Jmy8FkjQOP2UhrJzpV/sXJi3KbJrp4We4adGRYfxo7bFiR
	RGuo7ev1aeMtK6pHAwof/VMo/drKZf5JGFnuPgGYljRwX4L81c+TlyzMiA==
X-Google-Smtp-Source: AGHT+IGdHFyLibIBAx6EykdH7v6q7ac5kTWgmkyoqn2R2pX73WHr5WR1MZfSlMVNzrh7gkDa+Fg8aw==
X-Received: by 2002:a05:600c:1c0f:b0:424:a74b:32d4 with SMTP id 5b1f17b1804b1-424a74b3445mr21608645e9.0.1719390251715;
        Wed, 26 Jun 2024 01:24:11 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c837dc4csm16071825e9.26.2024.06.26.01.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:24:11 -0700 (PDT)
Message-ID: <751b0dd6-7699-4773-a7a7-40141ec01db7@grimberg.me>
Date: Wed, 26 Jun 2024 11:24:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] nvme-multipath: implement "queue-depth" iopolicy
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
 chaitanyak@nvidia.com, hare@kernel.org
References: <20240625122605.857462-1-jmeneghi@redhat.com>
 <20240625122605.857462-3-jmeneghi@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240625122605.857462-3-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

