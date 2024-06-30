Return-Path: <linux-kernel+bounces-235263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE191D289
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6398B1F2140F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0B153BE3;
	Sun, 30 Jun 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jJPCG4wF"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A5132113;
	Sun, 30 Jun 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719762715; cv=none; b=i0KDvwamqm/3uBXCgrLdX1Bb75NBQNB+LrDOfbnTSE/CNhV/FFCFG06xHIcqrviwkkth8xhvUKLiJdGwa3XO+mwIw94qx83LFpR49kI6teHmadVsY4Fdj1DvumTzMAiJGEE+RYzj1Oug0LL8KIxv4So4p/v/Kb6nrUQIyf8ExLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719762715; c=relaxed/simple;
	bh=nKVv8stQ0ehwNxNGt3f/m0itC/BhrJwOaoTRQyPh3Qk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=A3jXy/YbSdCzn7TMhKKPW+HLZw7ncsDZAwnnCHPAwYTO6lj1VIWHfos2F/Dha8hsIlyMqHbU4x7QE62GwOyWViP0oJaBM9xSmK2SPIKvGUVBXbJiDjd5SRPfj1v22HURl4jG4jtOUo/SqluqccODSLUQYfg4qkkxcU2mp9YImwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jJPCG4wF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719762710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZnQ5xnPEinCUn7M4ojlqf3tcHsfXH1JN3By76A2jvY=;
	b=jJPCG4wFjOIjHlXPs4aBSQKuTyfHLdNU2TLhaJZukHWOhCIDuxlHBSyuVeiNZsktBaysCU
	mlz7v64KJ2MDjdjbzapKlARNo0NtjuYboRHL1fqNJ5MfQeOi0s3FHF6p+fGtCX2z0IRwjZ
	nirIdlOBW96RweHWBxy5yUKl8lOSE2IPBP5Gu47F6f+w1Ujex8SyZI3/vHU2USd3m7SFLv
	+984QfSX0OKcusD2TUSIt2U52h3YdKpnvzsYrD0YXie2u+klWH/FAL2QAmw2eogHn6BwS+
	nrTswuZ8mYoJsqmpodhCHBmmI9RsR/NyOqx6oo/vJn9M0dZpR/yHjfBi+kvzQg==
Date: Sun, 30 Jun 2024 17:51:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add GPU OPP voltage ranges to
 RK356x SoC dtsi
In-Reply-To: <2573506.7YG5XaKc65@bagend>
References: <bdb60f1f793166cd65f58ab7aea025347076019c.1719679068.git.dsimic@manjaro.org>
 <2442162.AJoTavkB1d@bagend> <b8951ac4e29184fa35919c6ab85b8f87@manjaro.org>
 <2573506.7YG5XaKc65@bagend>
Message-ID: <78a743a9828741e029f14d165ad8d3a6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-06-30 17:43, Diederik de Haas wrote:
> On Sunday, 30 June 2024 14:04:50 CEST Dragan Simic wrote:
>> > I also expected that (for v1) there would be a similar construct as was
>> > recently added for rk3588. But I should interpret Heiko's comments as
>> > that strategy should not be applied to rk356x?
>> 
>> The trouble with applying the same strategy, ...
> 
> One of the reasons I like/hoped for it is that I'm a 'sucker' for
> consistency.

I also like consistency, but doing it that way simply wasn't feasible
in this case.  Maybe I'll rework the RK3399 SoC dtsi files a bit, so
we'd end up with more overall consistency. :)

>> ... the need for voltage ranges depends on one of the board features,
>> i.e. the GPU and NPU voltage regulators.  As such, it still has to
>> affect the RK356x SoC dtsi, which may warrant separate
>> rk356x-gpu-range.dtsi, for example, but the troubles would arise ...
> 
> ... but it's probably better if I (generally) abstain from taking part
> in the discussion about the correct/desired implementation as I don't
> understand the material in enough detail to meaningfully contribute.

I find your responses useful, so as far as I'm concerned, you're more
than welcome to take part in the discussions.

