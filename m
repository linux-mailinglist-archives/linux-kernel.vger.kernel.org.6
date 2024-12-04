Return-Path: <linux-kernel+bounces-430969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B66A9E37C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0BDB29975
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8521AC459;
	Wed,  4 Dec 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sf8vlOJf"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE219049A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308487; cv=none; b=aFqlMAQoacnh5Tvmw2+fpntCg0v5d18vS87jFbmCeSu3F0YPHSZvyO/THj2CUUalIB0pKrqTkLV36fW12fxMsuu+5A7/F4UoMAxeQA9PeetFK8+LT+9+CGmH+GizzT0NrGplIfV+KdZB8Yayun1lMmm3b27+LWgIsQ1tzZykuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308487; c=relaxed/simple;
	bh=02pMRcucLSEVi+457j04rHj8aPruOwGuuwGP1j5fwW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qjd3pDjRdbIEEJMpb5D1+l9RdfQwyfsoLKYBdRLu50aivUxGFtCeom/hMYLHGRIeexEZU8rmt7a1s6LCZZPP1abyhkTQfCFnV1HQ1K7FANl3QmhDKSsLld22V/mHhFQcxb5pGTiS4R0TI9y3ou7fQK+xrXViJ7/pc/bz4EyG2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sf8vlOJf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A32DAE0006;
	Wed,  4 Dec 2024 10:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733308483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2ns5t2BEosv01Uf3vWM9bso7Hkzlj+9qMfug4CWmjs=;
	b=Sf8vlOJfK5Rtlz+h2XtNkpBxaUuqGGqjIjUUWnYYlcbLast8FsKUkXO+AEQMNW4nXt2t7F
	gqb2KgxIthjLQnjBbB234mi8p5Yg/PwBW3SAFLJV8IvlAcgXC9VK4E6XFtFfN38fGC4Wg8
	XVuESAwcxJswDVrJR8Y1DY97BPBohAISQNdAxpdX/VtRgxeh7c9AVAt1Aggdy8rVkcaygZ
	sDxNTOvyeBkCHDWhdhQkLJlspDF31k5wTDC5PcO6S7gPhpf4HugO3kKHILJSNEgC9R9QFt
	ZNo6lEvM0GGOTOn8s/HUoM7OMfnDPtZb1gb65HCIjsYn+sqeUH/C7xn+QMvzwQ==
Message-ID: <39b78b3e-466c-4ab2-81a0-1633df48ef3e@bootlin.com>
Date: Wed, 4 Dec 2024 11:34:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240425122853.29544-1-bastien.curutchet@bootlin.com>
 <3612b36e-3350-4a5c-827e-482434753e95@enneenne.com>
 <973aa216-4932-4e21-b9a1-184ce809d483@bootlin.com>
 <956e2244-a95e-4c5e-a4a3-fb694c124739@enneenne.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <956e2244-a95e-4c5e-a4a3-fb694c124739@enneenne.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Rodolfo,

I revive this topic.

On 6/26/24 4:16 PM, Rodolfo Giometti wrote:
> On 26/06/24 14:55, Bastien Curutchet wrote:
>> Hi Rodolfo
>>
>> On 4/25/24 14:42, Rodolfo Giometti wrote:
>>> On 25/04/24 14:28, Bastien Curutchet wrote:
>>>> In the IRQ handler, the GPIO's state is read to verify the direction of
>>>> the edge that triggered the interruption before generating the PPS 
>>>> event.
>>>> If a pulse is too short, the GPIO line can reach back its original 
>>>> state
>>>> before this verification and the PPS event is lost.
>>>>
>>>> This check is needed when info->capture_clear is set because it needs
>>>> interruptions on both rising and falling edges. When info- 
>>>> >capture_clear
>>>> is not set, interruption is triggered by one edge only so this check 
>>>> can
>>>> be omitted.
>>>>
>>>> Add a warning if irq_handler is left without triggering any PPS event.
>>>> Bypass the edge's direction verification when info->capture_clear is 
>>>> not
>>>> set.
>>>>
>>>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>>>
>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>>
>>
>> I don't think I've received any updates since you acked this. Is there 
>> something missing before the patch can be applied?
> 
> No updates. It can be applied.
> 

In the MAINTAINER file, you are listed as the sole maintainer for the 
PPS subsystem. Could you let me know if there's someone else in charge 
of applying patches so I can gently ping them please ?

I checked, the patch still applies to v6.13-rc1

Best regards,
Bastien

