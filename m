Return-Path: <linux-kernel+bounces-440963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F299E9EC722
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E2A188C2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791361D9591;
	Wed, 11 Dec 2024 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pRzeh9JN"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C01D61AF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905628; cv=none; b=kZYVCl8RktwfZbYgwpb4fP0FuKJv/Ab2HXXLpZyWU1InDFs6Wg7zgzhD3lajYJ2mYhALpYpqze9dnH/16GNHZUusVvb1nG59WCxuI8X27dm39Chnr4ixKDpJHQgWsUv4VJkN2oa5Px5h/jpJf3X2ZUJ454Zz+CUFDhV7FJtRQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905628; c=relaxed/simple;
	bh=o+pLegHIssaXl/O+UV3tjufgzcMHs+H1Zwi+3ngSXfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThMzPstN4ubvo/zq76zHDbUiPwHSDaTKxgBmF/iWKNsymEk/Q2fVTKRStSl5FOEApPVUTuPk8TcYenf/YZuSwGuP43/yAj/0ml/5Z9RUg4aALAlMbcE6DT0bSPqyyvT28LCWvfVJpY7ofX9ZdhWSgyepRvKnBnWNATbe/wpvDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pRzeh9JN; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733905622; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qu6ZJQXtM8l423+WKxjZ38oMaUAOb4QcnD0R42mJevo=;
	b=pRzeh9JNCkbU6PEnL3l9Ymj6+pEUgnWZJ0erxTD4JOXljuZmwVxvJqQG9MzP5Aehw9GdYsC3/HqO8L1ku7RcTRrG+aUE13+425GU0BmGcRkYjF+4ejJhfAqEklBAFLRU6yEddo2xqkBaMCXi/vC93uZsK3B5nf7WUgQu+xm36+M=
Received: from 30.221.130.195(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLHfMid_1733905621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 16:27:02 +0800
Message-ID: <5ac4956d-10c2-4243-8396-cea01c4d72be@linux.alibaba.com>
Date: Wed, 11 Dec 2024 16:27:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: erofs: update Yue Hu's email address
To: Yue Hu <zbestahu@163.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>
References: <20241211080918.8512-1-zbestahu@163.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241211080918.8512-1-zbestahu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/11 16:09, Yue Hu wrote:
> From: Yue Hu <zbestahu@gmail.com>
> 
> The current email address is no longer valid, use my gmail instead.
> 
> Signed-off-by: Yue Hu <zbestahu@gmail.com>

Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

