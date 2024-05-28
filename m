Return-Path: <linux-kernel+bounces-192714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9F8D2116
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AB31F2626C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50BF172BC4;
	Tue, 28 May 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="grDHSthT"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD17172799;
	Tue, 28 May 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912177; cv=none; b=fcL6mNQlWgmd2NNBOCbDJb/5hP8r5D6P8sPjf2rSuTNAJDye61VwbL9RBfpWJ95hf2QekUQFjigfk56OJ7i+KuHUqbmMBbiaN0pf6UbepuTpCk0lymv5oAdpQfzLAFNlO+Ca6qHF4ScaA9JuUjS2+7XTJG25kUudneUGPfnWd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912177; c=relaxed/simple;
	bh=W/RsddcsNH4pGznPMfIGArlnC1+trGL18DoQAdB6nv0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=s9fSQexIwdjvmmhri5KGE411phOJg4oLkoa+v6tzZwgUfTe7yWoMoWEQLK+nrOEsPgAONyypfZrDoUcCFctkDQ+pqcGaFlyIkMXbt1UbiFGblXtfcre9UIORyX/iTNeM4hHV4PwXDkwcWGF0eJj+2iJ3Gq21MswL1LL6cBJj1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=grDHSthT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716912173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJazQCNLMe9zLT+pOoBooIhBm8Gr8yYEIFiGMNKV21E=;
	b=grDHSthTJTkLATXkf4IJBngUGMARyTKuopBirMZW4640rCczThfi3UOX1p9ah4LXiMlMIs
	dyhvHm506M1hRIs1MlAVuBAFpx3HBVFsmNIRnTJzmqSCzrl/HZTPREvzKrfzkiImXG/t3E
	gQjAGpF67JVOM3sp3mgsUaUst56nld7stVyRkRCsvMvoDo2a0Z+EiYIDJZ7TWOYov6ib3q
	+DaV2eFOgroGC4n5X+px2qyjfGL3yBAfha3esb8PvpE3axqpDzrD7OzBZHBXAANX4dzWhn
	4x9yTJitYwSVuqZ6LcSAdUSULU92US1jV4dfhFig2/AwDOgf6nvTvQPK8IM4ug==
Date: Tue, 28 May 2024 18:02:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: wens@csie.org
Cc: jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
In-Reply-To: <CAGb2v64ETOtHxQf1D9n+c9bGivsRTC=O8swDru+2cX2UT=o0qw@mail.gmail.com>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
 <171691117471.681554.6744393893618279840.b4-ty@csie.org>
 <CAGb2v64ETOtHxQf1D9n+c9bGivsRTC=O8swDru+2cX2UT=o0qw@mail.gmail.com>
Message-ID: <803a939c62b3ac4ced7ac49f18efd723@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-05-28 17:56, Chen-Yu Tsai wrote:
> On Tue, May 28, 2024 at 11:46 PM Chen-Yu Tsai <wens@csie.org> wrote:
>> 
>> On Sun, 28 Apr 2024 13:40:36 +0200, Dragan Simic wrote:
>> > Add missing cache information to the Allwinner H6 SoC dtsi, to allow
>> > the userspace, which includes lscpu(1) that uses the virtual files provided
>> > by the kernel under the /sys/devices/system/cpu directory, to display the
>> > proper H6 cache information.
>> >
>> > Adding the cache information to the H6 SoC dtsi also makes the following
>> > warning message in the kernel log go away:
>> >
>> > [...]
>> 
>> Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!
>> 
>> [1/1] arm64: dts: allwinner: Add cache information to the SoC dtsi for 
>> H6
>>       https://git.kernel.org/sunxi/linux/c/c8240e4b0fd2
> 
> OK, that's weird. Somehow b4 thought this patch was v2 of the A64 patch 
> [1].
> Looks like they are threaded together because this patch has 
> "In-Reply-To".
> 
> Please avoid it in the future.

I'm sorry for that.  I noticed that back when I sent the patches to the
mailing list, but didn't want to make some noise about that.  The root
cause was some missing configuration for "git send-email", which 
resulted
in adding troublesome threading-related headers to the messages for the
individual .patch files that in fact were correctly created by running
"git format-patch".

Do I need to resend the patches?

