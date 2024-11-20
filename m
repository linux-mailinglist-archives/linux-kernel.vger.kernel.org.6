Return-Path: <linux-kernel+bounces-415737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839999D3AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FC4282E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F001A302E;
	Wed, 20 Nov 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YmEH7q1v"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE619F104;
	Wed, 20 Nov 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732105636; cv=none; b=GfCkX8XLMUJjLeBihLisyE4Lp1HYRnlPrv3ZiuOtEtAJvTQnwFMVsO3P/FOP/ojvmzW53AaFRG5cbxZ/ZFx0JnR7kyFp0lKIeX+ep84BG27MzETcgar9a/yHdQJmHT4pK3bCh+2ScuzmGM6DDFNiX7+H60oI4ZwcZpvUuffLjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732105636; c=relaxed/simple;
	bh=Qb4eqMebJcQI3QOs9amzuOmJHtyisaX1Fxo3qWZ1X3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smesjOyHEMucrEviSMr1uZge/Zc/p2duuEc0zu/sXr1gDXJSmv2YwdJ8afc09F9g9eVUbWWDVVIrzJEIkmhdeIztHLKtJ2SJ34XPsNsYi/1JlW0V948++JKZ7FNTpbYqXBN7Kfd3fG2bFbEe+y1ftWWhOGPH+lcEShosia8cabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YmEH7q1v; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732105626; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hWFSbqCPWtJxCwPgT6LDllmiwlrYCejAuYkhuuUWIQk=;
	b=YmEH7q1vo9DC97Zu7ntSr2sbkjxQ+2EW9zTKH6EegQH3rigMpM2R4arra3FQM3Mt2HWoEblg231NCFJFmKn9lKG+DzSVj1tpkQ8l5HH3bedX9vRW38GI9yl7/MfjEO4UtI4obut2hf9eb7v8u2GEzoWljEWBOP63c98MxY2tR4Q=
Received: from 30.13.184.88(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJsR6ue_1732105624 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 20:27:05 +0800
Message-ID: <a31e5b41-d495-4b5e-996d-1cb0a1f6929f@linux.alibaba.com>
Date: Wed, 20 Nov 2024 20:27:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: sprd: Remove unused and undocumented
 "constant_charge_voltage_max_microvolt" property
To: Stanislav Jakubek <stano.jakubek@gmail.com>, robh@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, orsonzhai@gmail.com, zhang.lyra@gmail.com
References: <Zz3SnIiW_iu10rrs@standask-GA-A55M-S2HP>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zz3SnIiW_iu10rrs@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/20 20:14, Stanislav Jakubek wrote:
> Hi Rob,
> 
> constant-charge-voltage-max-microvolt is a valid property, which I assume
> was the original intention here. I've already submitted a patch changing this
> to the documented property:
> 
> https://lore.kernel.org/lkml/aa557091d9494fdaa3eda75803f9ea97014c8832.1730918663.git.stano.jakubek@gmail.com/
> 
> Baolin also reviewed that patch... make of that what you will.

Ah, yes. Sorry I forgot your patch. Thanks for reminding.

