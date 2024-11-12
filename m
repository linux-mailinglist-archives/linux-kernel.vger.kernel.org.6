Return-Path: <linux-kernel+bounces-405393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90879C50B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865111F23008
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE920B7F0;
	Tue, 12 Nov 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="TAGLrXIB"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD3B154456
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400477; cv=none; b=RECIWNSyN1dmAhTzr7GtznZooK1l8iLY4xVgj51fCiOyvWSsyTDM4oCAyQQe+NnTKJBr8bTkD0mT3V+YztWvb5fQPNqLwIjpIsQSOZsFABv4filOswZ3yEhtMXbzSW8ENkBIueU2exZQWaS+eZFgv8d49m+pRqOsl+TGk8MnMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400477; c=relaxed/simple;
	bh=oHMfopyLGWcArsWyaVd1aOVGAT5C2IA/L6SRJPL8qbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu2SL8cKq7VC0raAF3tck3/BQI2YufrOnDyR7V55EW6CgZbTvkpeVFs13EpYXkaSR//09/3MWx3PXb/NgphrAK2KT8LTAGnvd1tlEAnMb/IIP9dyiVFKwquooYoyvVI3LGScufw1gj56APgCGdthW5+WP2yCkHLDMqqCXOe0Qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=TAGLrXIB; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 3E6AA2FC0048;
	Tue, 12 Nov 2024 09:34:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731400470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cz6EpwzNEW/FKSNKQEDaaTQwb1kSyYhG9Jguy8uvAe0=;
	b=TAGLrXIBa0ALBO4XLaBjELTuYqqW9jioidvg9QXtfco7Qk7TRm8Skpgatj9pxDQlHmxu8y
	tgkz+uzHkoxWmEb83TJ7C18cHusAyPs5p5Hpwxve1UsgVxPuc/RiKFusckPklQDowcm2cm
	ZM1IDFM8hkMNT+PYxPmwMvA1Vxztr4E=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <1fcb3716-308f-49b8-b84f-2225aa2a1fb8@tuxedocomputers.com>
Date: Tue, 12 Nov 2024 09:34:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EXPORT_SYMBOL_GPL with GPLv3
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoffer Sandberg <cs@tuxedo.de>
References: <17276996-dcca-4ab5-a64f-0e76514c5dc7@tuxedocomputers.com>
 <ZzLg2etoX94Nb0yk@infradead.org>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZzLg2etoX94Nb0yk@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 12.11.24 um 06:00 schrieb Christoph Hellwig:
> On Mon, Nov 11, 2024 at 07:40:25PM +0100, Werner Sembach wrote:
>> Hi,
>>
>> asking at the source: Can EXPORT_SYMBOL_GPL-exports be used with out of tree
>> GPLv3 licensed modules?
> No.  The kernel as whole is licencsed as GPLv2, not GPLv2+.
>
Yes, but the documentation for EXPORT_SYMBOL_GPL only talks about 
"GPL-compatible" and external linking for EXPORT_SYMBOL-exports is even legal 
with proprietary code. So to my understanding, it comes down to what 
EXPORT_SYMBOL_GPL means and not what's the license of the code behind it is.

Kind Regards,

Werner Sembach


