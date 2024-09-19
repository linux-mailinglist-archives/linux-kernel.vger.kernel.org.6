Return-Path: <linux-kernel+bounces-333032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638697C272
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24401C21678
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0891814A82;
	Thu, 19 Sep 2024 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+32dAq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0F4430
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709623; cv=none; b=gzLeLlpt0g6XbhlBMlidbs0wTBz3yNnbT0xhBEKyvt2mmmdmwWkNYRAyK00QN4Me2eOtdUMrnvubTEi7NhCpnhnKVH8CTN4is+8MoMm/dmOJiWFUTJq2qil8g/6axuUe6GEiU7oXRtYdY6qZGXJHkF9PicLc3nhC+GxEmTDZehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709623; c=relaxed/simple;
	bh=kIzzmFri/kJgjyyeug4PoRnrFCPRQ2ZgVw2wfglOml8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G4lsU6numKnFgz+gvUSEzyE+sY2SlV1HpGygNZupXY9Fhn8ps25xo57YCPHVdThMnV+40AB0lpyGZWLn3JaBTOLU4GxCr/oTpMeqXujkjJPqjsdHxCnwWDOwC1+JYIrW3yTLDalNli2ySBNbcw9KxsDDCq6VFLNabWdzlmkou5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+32dAq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4611AC4CEC2;
	Thu, 19 Sep 2024 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726709622;
	bh=kIzzmFri/kJgjyyeug4PoRnrFCPRQ2ZgVw2wfglOml8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=f+32dAq9/k8CCkNnfzl9zXysl0mbgWIHSLV/Uwumz2GVh/V4IwlwDqLqJWAC0Rg6f
	 jx1XHyYO0cHPfjlrlpXKOe6odDm68AOqMMaJvz5wOtAMHpB8v4g45F2l3cJOcVB/f+
	 39maLEP40D7hu7MkGssx9oe2Fc5hWZiNZf3wKpbtQaIN9RMT87PTrZ9mydOUT60FeP
	 bYiOlrF2u/ESo9Yo6GcMvJMvjzeQnmnDp4WPItzCIgDzUg7c5P0yROOzVQc+QXo0eE
	 /rCmKMOPy9gJRhZI9MbrhEOhmS5FeyMO5zxq7K3SAcR+xFbyYrGu7yM8fdj292pGD0
	 +I0x4I5yR/TMQ==
Message-ID: <7ab615e8-348a-451a-b5bd-d95a6964a36a@kernel.org>
Date: Thu, 19 Sep 2024 09:33:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] mkfs.f2fs: change -c option description
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240916192014.1611002-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240916192014.1611002-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/17 3:20, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Current description confuses users like they can add addtional devices
> with one -c option using commas(,) at the same time.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

