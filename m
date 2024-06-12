Return-Path: <linux-kernel+bounces-212349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0288905EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1F62846C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452E12C544;
	Wed, 12 Jun 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SHRPuLFO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80257A93B;
	Wed, 12 Jun 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718233669; cv=none; b=Rmy7cK32DKaBjknWLJCzplddjk1alNSfXJLuB7WTJGmxktP0bOXYWoICLcpYEDcPZn5sNFZYCvBYywCchAS9/6pF9lJTYW2iuJk2P8MLeP9B6yy8Du4gC7Opxedbk1v/hHhhgrKANlK8aKWOJx0VNHV47EY8pBvafC80jCSdxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718233669; c=relaxed/simple;
	bh=sCSMmYNgQJ3DiLMYKjU2lPt//XpoYkcJrmzTty7AElk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mbq2U5v6r537vHbv6b0P6F1vFtobgQIRd6BCJTjF8g41h0+MttP6+W+NO2jhp/kNVQXpjt4nuwX69LZGunVzHoiFlbK1GEUmzqsoC62+LSfXApJd1U/vt1Aw2JtAwLyNRpD7OeRA7mhkrDf113RvdD4WaFFBAPyY3Obs7fT+Yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SHRPuLFO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=b60jhXNNn1qYJ52pvMZIF85Gim2GmpkxYvSlzNpDmjI=; b=SHRPuLFOV432e41uqTutol4OFL
	M0yJ4Mf9u9bMIRHFU0OVUxsnwkxKnKp0qHYC37EBz/oKWIbnjNzf89spAxdL6l9DJ7AszTvs2kPk1
	ZD/yjtAFey2FYn8uQv724cXljnkaI6lzYOxu7/dckClEC8hw/ASAJLUd6ebSmHHtn8khBIZ76BitV
	3jyHAeBPboB5VkdJvcJkFf46VuOpO69XDt0UJp9U4DmliBkQ6sJ/2IE7OmE5op5qanj2kuwe054OX
	yP5NVpxFHcKLqrioUpNxLQW0S+M0pKC4n9iyi6UPYzQVOpsvU+NjDXR9g2y4hatZ4z+80JEbzu576
	T/H4QdNw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHX4G-0000000EQH0-02uQ;
	Wed, 12 Jun 2024 23:07:48 +0000
Message-ID: <5a2389c8-f64a-47c1-8924-c603628c52fb@infradead.org>
Date: Wed, 12 Jun 2024 16:07:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
From: Randy Dunlap <rdunlap@infradead.org>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
 <87ikyvccwc.fsf@meer.lwn.net>
 <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
 <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
Content-Language: en-US
In-Reply-To: <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/12/24 3:17 PM, Randy Dunlap wrote:
> 
> 
> On 6/1/24 8:03 AM, Carlos Bilbao wrote:
>> Extend the Index of Further Kernel Documentation by adding entries for the
>> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
>> on the second edition of Billimoria's kernel programming book. Also,
>> perform some refactoring: format the text to 75 characters per line and
>> sort per-section content in chronological order of publication.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>> ---
>>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>>  1 file changed, 44 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/process/kernel-docs.rst
>> b/Documentation/process/kernel-docs.rst
> 
> The 2 lines above should be on one line, but fixing that doesn't fix everything.
> 'patch' still says that it's a malformed patch.
> 
> Carlos, please check Documentation/process/email-clients.rst section on
> Thunderbird, especially for line length and line wrap.
> 
> I'm still looking...

I don't know what is causing it, but there are a bunch of non-ASCII characters
in the patch file. Specifically 0xc2 at the beginning of many lines. E.g., when
I copy/paste only the "Index of Further" & ===== lines into a small text file:

> hd docs-chars.txt 
000000 c2 a0 49 6e 64 65 78 20 6f 66 20 46 75 72 74 68  >..Index of Furth<
000010 65 72 20 4b 65 72 6e 65 6c 20 44 6f 63 75 6d 65  >er Kernel Docume<
000020 6e 74 61 74 69 6f 6e 0a c2 a0 3d 3d 3d 3d 3d 3d  >ntation...======<
000030 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d  >================<
000040 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d 0a  >===============.<


> 
>> index 8660493b91d0..6f3e290abd22 100644
>> --- a/Documentation/process/kernel-docs.rst
>> +++ b/Documentation/process/kernel-docs.rst
>> @@ -3,27 +3,27 @@
>>  Index of Further Kernel Documentation
>>  =====================================
> 
> 

-- 
~Randy

