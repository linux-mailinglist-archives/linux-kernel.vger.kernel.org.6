Return-Path: <linux-kernel+bounces-196196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F149C8D58B4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB2B1F23C20
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9077378C68;
	Fri, 31 May 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SNAYiZtN"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA814265;
	Fri, 31 May 2024 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123535; cv=none; b=XAdOEoUR6xFF80GJEM2haPji7H8r2JMi4tph53dYZgSkqVgJqE1ldvHuL/3PrEWrxMip+yzV4kZpOokMI6SiQju+WVOBgLQ4LtryCe/46fc5QEwzWaN6NXkndJq9vI28TAxCnK/DksQeMvF8C3QCyLiyc0ZpqgJJ9UKeptDJjn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123535; c=relaxed/simple;
	bh=ogjFpFI1mY9EkB7BS5con78jBONtmxi3wYyr48grF7c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CWlQRPsqXK/vzAJXXtOdaUKTifanEKjz5vu7AhYO1pKeDF7qJIfjFi7GxtaPt4uQ6Is3EfCDgDonBP6FkvXZmO14H5pbseqTxvD95kbuqttiQsDgq4A22GxnBZGuS+Dw6iF0sgwT9LtpBXJ5vZ0z+tnGa6N9hsPURfAQEVeX6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SNAYiZtN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717123530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5Xxa+1pfjc83KgBzGxQW/9sLaAlfMtTgcdj5otYUxQ=;
	b=SNAYiZtNgZqRk9A1Opklu3S3DISvQzvdiQsIwR+hxLJwn3EvkM1U0oc4W5FDaYKz5KfM6c
	E/QhLW+EYIHy0+wN3Lk34YIaYl0fnzuTr+hGczp5TBmFjlsafAnBHmjeDmQ30NVFhL6DUa
	mTcPkotcL1rEazPuEg8KQ44s8AsVIdwQXZbiwZqJba9gbqT7RvVwROCJAVVi2fQ5Aa/1vs
	X0+mjKUw+xJyVBYMhvgDxVoihnSyX7qUMbEe57qOJ7dNHF/rNGV5pD74o8NdfuMXhGNH5m
	udPdca5v8xsOKerjRU+/jdYjE1W8zgyRmv2a9rqiXHxil18UeXtkJv4VvAGx4w==
Date: Fri, 31 May 2024 04:45:28 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 wens@kernel.org, daniel.lezcano@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
In-Reply-To: <511137f077495007f467d5927f42f85d@manjaro.org>
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <9996796.SDjBYy7pSV@bagend> <511137f077495007f467d5927f42f85d@manjaro.org>
Message-ID: <06452ce330f0a712e4d765475c6cbc8b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-29 13:33, Dragan Simic wrote:
> On 2024-05-29 13:09, Diederik de Haas wrote:
>> On Wednesday, 29 May 2024 11:57:45 CEST Alexey Charkov wrote:

[...]

>>> >  arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  414 +--
>>> >  arch/arm64/boot/dts/rockchip/rk3588j.dtsi     |    6 +-
>>> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 2671 +----------------
>>> 
>>> Rename detection didn't do a particularly great job here - wonder if
>>> we can do anything about it to minimize the patch size and ensure 
>>> that
>>> the change history is preserved for git blame...
>> 
>> +1
>> The diff does look awfully big for a rename operation, which was 
>> supposed to
>> (also only) "modify ... a bit".
> 
> I also don't like the size of the patch.  I just tried playing with
> specifying different values for the --find-renames and --find-copies
> options, but with no good results.  I'll have a look into the Git
> source later, to see what's actually going on with those options.

Yay, --break-rewrites makes the diff extremely compact. :) [1]

[1] 
https://git-scm.com/docs/git-diff#Documentation/git-diff.txt--Bltngtltmgt

