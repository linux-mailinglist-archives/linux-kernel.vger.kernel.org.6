Return-Path: <linux-kernel+bounces-263084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B77B93D0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5795E282A75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A4176AD8;
	Fri, 26 Jul 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlM+/qtQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E630225AF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988171; cv=none; b=M2AHQa4l8cKHDSlpmpn1845zLEVTpckuQrgyKjcjtILnRVftTV9Ed2UdVreQgkcpiEXPqej+/3zvefuV+8FjdS3OZiHXSClIqJv+DKFc0MkEoH6FSfzJM3+s4iCdwcVmBL5cSgocH5192Sx8PoP3P2pdw6/lFOGT378eftwskoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988171; c=relaxed/simple;
	bh=y3T7leRy9u9hWhekWEnrvGtNeI2sgTWgG2gCnKSw2PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ui8Vf8jrDXgqNL5RxZ5PJeDmY8qMLxBO2QxAsiANP6vbieoZPmMsJGQGGIYjkxLPT0a+nRz9St7E3BQT3sf34H+zN8jQ0SKvB31mPEW+of8VuMqH4xN9NNX1AYkhlNiipS5rYCWch+Gt9r9fVFZ2KMnfEG5Mkz7nUn8jafc2Sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlM+/qtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B56C32782;
	Fri, 26 Jul 2024 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721988170;
	bh=y3T7leRy9u9hWhekWEnrvGtNeI2sgTWgG2gCnKSw2PQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YlM+/qtQGfI8YrQqvKEu3N134dL5tNaJ6MPGalYwca1ppGNZIIEv0FfqunTkVDk0G
	 z5lAB8Zyjd2QkiQ+G+FJgPfv2p52AHah8r+fzXfVmrXYZ/bHZj3xdxFP/hDjV2M/rB
	 PKtV+IoQMQu1pEU51ncTh3Paqyz6zDDFqMPLIf0iJQPeQQ8CXYaNybb0Z72MqX/S6G
	 2J12R5RlVZLEhWe2G9z6AX8vMkx/GbxtseDQD75nN8TFF4WaJ0dBJdI2NgtYoiVf+r
	 Lr4MwF9DfZ105rauj+gKANFn4Cwl+gDw0JEUFKju/T9k7UbIipEJPUU+slOzpcMdIM
	 YruHPjmyzSW9Q==
Message-ID: <0b16f00a-71d5-46f7-adc1-1f48f6e68745@kernel.org>
Date: Fri, 26 Jul 2024 18:02:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: convert comma to semicolon
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chen Ni <nichen@iscas.ac.cn>,
 xiang@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240724020721.2389738-1-nichen@iscas.ac.cn>
 <96238616-071e-43f8-9a14-5d4beab64217@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <96238616-071e-43f8-9a14-5d4beab64217@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/24 10:45, Gao Xiang wrote:
> 
> 
> On 2024/7/24 10:07, Chen Ni wrote:
>> Replace a comma between expression statements by a semicolon.
>>
>> Fixes: 84a2ceefff99 ("erofs: tidy up stream decompressors")
> 
> I think typos are bugfixes, so I will drop this label.
> 
>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

