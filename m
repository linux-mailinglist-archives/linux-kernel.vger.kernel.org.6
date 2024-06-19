Return-Path: <linux-kernel+bounces-220662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A938F90E527
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEFDB223AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535AC78C62;
	Wed, 19 Jun 2024 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Q/rXPPLA"
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC173441
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784186; cv=none; b=skLKCUqoHmPqdAaZC+xE2OtkcNMkwuFUMxwi6tLjLQA0+6OF9sIUTnUL3nwos2l+gnCcPwopKzPOjhpcxK0+0rIg1YvPL0MBWv9FgqXmewwAGGCN7QjBRcCOBvjrgM3S0OWbY/Ydp33Yx1tYUdBtTYF4rH4hyIlI0Tl0PVm87p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784186; c=relaxed/simple;
	bh=X3X95GITpZLm7cdJUEI4B9MOnj7tVUmwEWSeI3Pm+Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NPA2zaZgBUdLAHVN04gYu5MQ3Apuyq1GKsVDq9+zkD6Zt2XIFOe3kUl5GJu54X0CtLRkpCpg7gT/JqKleEkctrdXcARw1K/RQtvvRgRBEZ5nRfxICXjTMgh8zKWgXTQGzkgYBJjqN5uibJtGJNghjr89YU520iqs2oZ9EaJiCPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Q/rXPPLA; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A665C1D0F;
	Wed, 19 Jun 2024 07:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1718783703;
	bh=xvQw66MlB8IJ+in91YVeOZwco8FULunZGBsn4p2+W2g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Q/rXPPLAq49Rll+kaL+JBCtyLUrtGkRFgiuD6wTKnFtAeNk51GH6mnFDcmcZ3swlm
	 uoKD9PSQPC40NCDxRFKqyONkcMFXCvoWXqeTYVcVOFPWAVd9sSeh42ckdWE2KcgeD/
	 GDeIVBsBmYWXCU4zQzvRfBa7HAihbWVChxTrSkeo=
Received: from [192.168.211.147] (192.168.211.147) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 19 Jun 2024 11:03:02 +0300
Message-ID: <f6e70e2d-0881-4ced-affe-0d08cf7f9253@paragon-software.com>
Date: Wed, 19 Jun 2024 11:03:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fs/ntfs3: Fix bugs and typos
To: Huacai Chen <chenhuacai@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>
CC: <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240529064053.2741996-1-chenhuacai@loongson.cn>
 <CAAhV-H4N6NGKJBy19zs6ciGFYHWTUTKA6X=bA_ENXTP2fr7XHA@mail.gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <CAAhV-H4N6NGKJBy19zs6ciGFYHWTUTKA6X=bA_ENXTP2fr7XHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 12.06.2024 07:48, Huacai Chen wrote:
> Hi, Konstantin,
>
> Could you please take some time to review this series? Thank you.
>
> Huacai
>
> On Wed, May 29, 2024 at 2:41 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>> When we enable NTFS3 on Loongson platforms we found some bugs and
>> typos. So fix them.
>>
>> Huacai Chen(2):
>>   fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed.
>>   fs/ntfs3: Rename the label end_reply to end_replay.
>>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>> 2.27.0
>>
Hi,Huacai

We have accepted your patches and will add them to the repository shortly.

Regards, Konstantin

